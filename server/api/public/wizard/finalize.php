<?php
/**
 * /api/public/wizard/finalize.php
 *
 * Convert a completed (or minor-pending) wizard_drafts row into a real
 * `users` row + the matching user_verifizierung rows, then either:
 *
 *   • adults  (age ≥ 18)   → users.status = 'neu'
 *   • minors  (16 ≤ <18)   → users.status = 'waiting_for_parent_consent'
 *                            + parent_hint_* columns copied across, so
 *                            the Vorstand queue shows them immediately
 *
 * On success the draft row is left in place (for audit / debugging)
 * but `user_id` is back-linked so we know it has been materialised.
 *
 * Payload (JSON POST):
 *   anonymous_id  string, required
 *
 * Response:
 *   201 {
 *     success, mitgliedernummer, user_id,
 *     status, is_minor, message
 *   }
 *
 * Hard validation: required columns must be non-null in the draft.
 * Anything missing → 400 with the missing field list so the client
 * can route the visitor back to the right sub-step.
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../../config.php';

validateApiKey();
blockBrowserAccess();

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    jsonResponse(false, [], 'Method not allowed');
}

$body = json_decode(file_get_contents('php://input'), true);
if (!is_array($body)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid JSON');
}

$anonymous_id = trim((string)($body['anonymous_id'] ?? ''));
if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}

try {
    $pdo = getDBConnection();
    $pdo->beginTransaction();

    $stmt = $pdo->prepare('SELECT * FROM wizard_drafts
                           WHERE anonymous_id = ? FOR UPDATE');
    $stmt->execute([$anonymous_id]);
    $draft = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$draft) {
        $pdo->rollBack();
        http_response_code(404);
        jsonResponse(false, [], 'Wizard draft not found');
    }
    if ($draft['user_id']) {
        $pdo->rollBack();
        http_response_code(409);
        jsonResponse(false, ['user_id' => $draft['user_id']],
            'Draft already finalized');
    }

    // Required columns for any user (adult or minor).
    $required = [
        'data_vorname', 'data_nachname',
        'data_geburtsdatum', 'data_geburtsort',
        'data_geschlecht', 'data_familienstand',
        'data_staatsangehoerigkeit', 'data_muttersprache',
        'data_strasse', 'data_hausnummer', 'data_plz', 'data_ort',
        'data_telefon_mobil', 'data_email',
        'data_mitgliedsart', 'data_finanzielle_situation',
        'data_mitgliedschaftsbeginn_option',
    ];
    // data_zahlungs* are only required if finanzielle_situation = 'nein'.
    if (($draft['data_finanzielle_situation'] ?? '') === 'nein') {
        $required[] = 'data_zahlungsmethode';
        $required[] = 'data_zahlungstag';
    }
    // All three legal docs must be marked read.
    foreach (['data_satzung_read', 'data_datenschutz_read',
              'data_widerrufsbelehrung_read'] as $col) {
        if (empty($draft[$col])) {
            $pdo->rollBack();
            http_response_code(400);
            jsonResponse(false, ['missing' => $col],
                'Legal document not accepted');
        }
    }

    $missing = [];
    foreach ($required as $col) {
        if ($draft[$col] === null || $draft[$col] === '') {
            $missing[] = substr($col, 5);
        }
    }
    if (!empty($missing)) {
        $pdo->rollBack();
        http_response_code(400);
        jsonResponse(false, ['missing' => $missing],
            'Required fields missing');
    }

    // Re-check age (server is the source of truth — Satzung §6).
    $birth = new DateTime($draft['data_geburtsdatum']);
    $age = (int)(new DateTime())->diff($birth)->y;
    if ($age < 16) {
        $pdo->rollBack();
        http_response_code(403);
        jsonResponse(false, ['age' => $age], 'Below minimum age (16)');
    }
    $isMinor = $age < 18;

    // Email uniqueness.
    $stmt = $pdo->prepare('SELECT id FROM users WHERE email = ?');
    $stmt->execute([$draft['data_email']]);
    if ($stmt->fetch()) {
        $pdo->rollBack();
        http_response_code(409);
        jsonResponse(false, [], 'Email already registered');
    }

    // For minors, parent_hint_* must also be present in the draft.
    if ($isMinor) {
        foreach (['data_parent_hint_vorname', 'data_parent_hint_nachname',
                  'data_parent_hint_telefon', 'data_parent_hint_relation'] as $col) {
            if (empty($draft[$col])) {
                $pdo->rollBack();
                http_response_code(400);
                jsonResponse(false, ['missing' => substr($col, 5)],
                    'Parent hint required for minor');
            }
        }
    }

    // Mitgliedernummer (M + 5 digits, unique).
    do {
        $mnr = 'M' . random_int(10000, 99999);
        $stmt = $pdo->prepare('SELECT id FROM users WHERE mitgliedernummer = ?');
        $stmt->execute([$mnr]);
    } while ($stmt->fetch());

    $status = $isMinor ? 'waiting_for_parent_consent' : 'neu';
    $now = date('Y-m-d H:i:s');
    $combinedName = trim($draft['data_vorname'] . ' ' . $draft['data_nachname']);

    $cols = [
        'mitgliedernummer', 'email', 'name', 'vorname', 'nachname',
        'geburtsname', 'geburtsdatum', 'geburtsort',
        'geschlecht', 'familienstand',
        'staatsangehoerigkeit', 'aufenthaltsstatus', 'muttersprache',
        'strasse', 'hausnummer', 'plz', 'ort', 'land',
        'telefon_mobil',
        'mitgliedsart', 'finanzielle_situation',
        'zahlungsmethode', 'zahlungstag',
        'mitgliedschaftsbeginn_option', 'mitgliedschaftsbeginn_datum',
        'status', 'preferred_language',
        'datenschutz_accepted_at', 'satzung_accepted_at',
        'widerrufsbelehrung_accepted_at',
        'created_at',
    ];
    $vals = [
        $mnr, $draft['data_email'], $combinedName,
        $draft['data_vorname'], $draft['data_nachname'],
        $draft['data_geburtsname'] ?: null,
        $draft['data_geburtsdatum'], $draft['data_geburtsort'],
        $draft['data_geschlecht'], $draft['data_familienstand'],
        $draft['data_staatsangehoerigkeit'],
        $draft['data_aufenthaltsstatus'] ?: null,
        $draft['data_muttersprache'],
        $draft['data_strasse'], $draft['data_hausnummer'],
        $draft['data_plz'], $draft['data_ort'],
        $draft['data_land'] ?: 'Deutschland',
        $draft['data_telefon_mobil'],
        $draft['data_mitgliedsart'], $draft['data_finanzielle_situation'],
        $draft['data_zahlungsmethode'] ?: null,
        $draft['data_zahlungstag'] ?: null,
        $draft['data_mitgliedschaftsbeginn_option'],
        $draft['data_mitgliedschaftsbeginn_datum'] ?: null,
        $status, $draft['data_muttersprache'] ?: 'de',
        $now, $now, $now,
        $now,
    ];

    if ($isMinor) {
        $cols = array_merge($cols, [
            'parent_hint_vorname', 'parent_hint_nachname',
            'parent_hint_telefon', 'parent_hint_relation',
            'parent_hint_created_at',
        ]);
        $vals = array_merge($vals, [
            $draft['data_parent_hint_vorname'],
            $draft['data_parent_hint_nachname'],
            $draft['data_parent_hint_telefon'],
            $draft['data_parent_hint_relation'],
            $now,
        ]);
    }

    $placeholders = implode(', ', array_fill(0, count($cols), '?'));
    $sql = 'INSERT INTO users (' . implode(', ', $cols) . ') VALUES (' . $placeholders . ')';
    $pdo->prepare($sql)->execute($vals);
    $userId = (int)$pdo->lastInsertId();

    // Auto-create 8 user_verifizierung rows. All Stufen 1-5 are
    // marked 'ausgefuellt' since the wizard captured the data; 6/7/8
    // are 'ausgefuellt' because the wizard required reading them.
    // The Vorstand still has to flip each to 'geprueft' / 'abgelehnt'.
    $vstmt = $pdo->prepare('INSERT INTO user_verifizierung (user_id, stufe, status)
                             VALUES (?, ?, ?)');
    for ($s = 1; $s <= 8; $s++) {
        // Skip Stufe 4 for buergergeld/sozialamt — those visitors get
        // a beitragsfreie membership and Stufe 4 stays "offen" /
        // effectively skipped (matches verifizierung_tab.dart logic).
        $skipStufe4 = $s === 4 &&
            in_array($draft['data_finanzielle_situation'],
                     ['buergergeld', 'sozialamt'], true);
        $vstmt->execute([$userId, $s, $skipStufe4 ? 'offen' : 'ausgefuellt']);
    }

    // Back-link draft → user so we know it shipped.
    $pdo->prepare('UPDATE wizard_drafts SET user_id = ?, current_step = ?
                   WHERE id = ?')
        ->execute([$userId, 'done', $draft['id']]);

    $pdo->commit();

    http_response_code(201);
    jsonResponse(true, [
        'mitgliedernummer' => $mnr,
        'user_id'          => $userId,
        'status'           => $status,
        'is_minor'         => $isMinor,
    ], $isMinor
        ? 'Registration submitted — waiting for parent consent'
        : 'Registration complete. Your Mitgliedernummer is ' . $mnr);
} catch (PDOException $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    error_log('[wizard/finalize] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
