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
    // $draft['user_id'] is now set BY CHECK_AGE.PHP for the
    // 'nicht_verifiziert' stub the Vorstand sees while the wizard is
    // being filled. So instead of rejecting any non-null user_id, we
    // only reject when that stub has already been converted to a
    // real status (anything other than 'nicht_verifiziert').
    $existingStubId = $draft['user_id'] ? (int)$draft['user_id'] : 0;
    if ($existingStubId > 0) {
        $sStmt = $pdo->prepare('SELECT status FROM users WHERE id = ?');
        $sStmt->execute([$existingStubId]);
        $existingStubStatus = $sStmt->fetchColumn();
        if ($existingStubStatus !== false
            && $existingStubStatus !== 'nicht_verifiziert') {
            $pdo->rollBack();
            http_response_code(409);
            jsonResponse(false, ['user_id' => $existingStubId],
                'Draft already finalized');
        }
    }

    // Required columns for any user (adult or minor).
    $required = [
        'data_vorname', 'data_nachname',
        'data_geburtsdatum', 'data_geburtsort',
        'data_geschlecht', 'data_familienstand',
        'data_staatsangehoerigkeit', 'data_muttersprache',
        'data_strasse', 'data_hausnummer', 'data_plz', 'data_ort',
        'data_telefon_mobil',
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

    // Anti-abuse throttle. The applicant's (lowercased vorname, lowercased
    // nachname, geburtsdatum) is hashed with SHA256; if 3+ rows with
    // the same hash were withdrawn in the last 90 days we reject the
    // automated path. The Vorstand can still onboard manually via
    // admin_register.php. Mirrors the irreversible hash logic in
    // withdraw.php so the same person can't bounce through registration
    // → withdraw → registration → withdraw in a loop.
    $applicantHash = hash('sha256',
        trim(mb_strtolower((string)$draft['data_vorname'], 'UTF-8'))
        . '|'
        . trim(mb_strtolower((string)$draft['data_nachname'], 'UTF-8'))
        . '|'
        . trim((string)$draft['data_geburtsdatum'])
    );
    $abuseStmt = $pdo->prepare(
        'SELECT COUNT(*) FROM users
          WHERE abuse_hash = ?
            AND status = \'gekuendigt_selbst\'
            AND deactivated_at > DATE_SUB(NOW(), INTERVAL 90 DAY)'
    );
    $abuseStmt->execute([$applicantHash]);
    $recentWithdrawals = (int)$abuseStmt->fetchColumn();
    if ($recentWithdrawals >= 3) {
        $pdo->rollBack();
        http_response_code(429);
        jsonResponse(false, [
            'code'                => 'too_many_withdrawals',
            'recent_withdrawals'  => $recentWithdrawals,
        ], 'Too many recent withdrawals — please contact the Vorstand');
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

    // Stufe 3 uploads now live in wizard_draft_files. For fee-exempt
    // visitors (Bürgergeld / Sozialamt / ALG I / Krankengeld) require
    // at least one Bescheid row; collect every file_path so we can
    // mirror the first one into users.leistungsbescheid_file for
    // back-compat with verifizierung_tab.dart.
    $bescheidPaths = [];
    $stmt = $pdo->prepare('SELECT file_path FROM wizard_draft_files
                           WHERE wizard_draft_id = ? ORDER BY id ASC');
    $stmt->execute([(int)$draft['id']]);
    foreach ($stmt->fetchAll(PDO::FETCH_COLUMN) as $p) {
        $bescheidPaths[] = (string)$p;
    }
    $exemptSituations = ['buergergeld', 'sozialamt', 'alg1', 'krankengeld'];
    if (in_array($draft['data_finanzielle_situation'], $exemptSituations, true)
        && empty($bescheidPaths)) {
        $pdo->rollBack();
        http_response_code(400);
        jsonResponse(false, ['missing' => 'leistungsbescheid_files'],
            'At least one Leistungsbescheid required for fee-exempt members');
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

    // Mitgliedernummer is reserved by check_age.php (M for adults,
    // J for minors). Fall back to legacy random generation if the
    // draft predates that change.
    $mnr = $draft['mitgliedernummer'] ?? null;
    if (!is_string($mnr) || $mnr === '') {
        $prefix = $isMinor ? 'J' : 'M';
        do {
            $mnr = $prefix . random_int(10000, 99999);
            $stmt = $pdo->prepare(
                'SELECT id FROM users WHERE mitgliedernummer = ?
                 UNION ALL
                 SELECT id FROM wizard_drafts WHERE mitgliedernummer = ?'
            );
            $stmt->execute([$mnr, $mnr]);
        } while ($stmt->fetch());
    }

    // The wizard no longer collects an email address — every formal
    // communication goes through the in-app channel and urgent stuff
    // through phone — but users.email is still NOT NULL UNIQUE, so we
    // derive a per-member placeholder from the mitgliedernummer. The
    // domain is icd360s.de so any future catch-all routing just
    // works.
    $autoEmail = strtolower($mnr) . '@icd360s.de';

    // Email collision check — only when we're INSERTing a fresh row.
    // If a stub already exists for this draft, it owns the email and
    // we're just UPDATEing it, so a "match" against itself isn't a
    // collision.
    if ($existingStubId === 0) {
        $stmt = $pdo->prepare('SELECT id FROM users WHERE email = ?');
        $stmt->execute([$autoEmail]);
        if ($stmt->fetch()) {
            $pdo->rollBack();
            http_response_code(409);
            jsonResponse(false, [], 'Email already registered');
        }
    }

    $status = $isMinor ? 'waiting_for_parent_consent' : 'neu';
    $now = date('Y-m-d H:i:s');
    $combinedName = trim($draft['data_vorname'] . ' ' . $draft['data_nachname']);

    $cols = [
        'mitgliedernummer', 'email', 'password_hash', 'name', 'vorname', 'nachname',
        'geburtsname', 'geburtsdatum', 'geburtsort',
        'geschlecht', 'familienstand',
        'staatsangehoerigkeit', 'aufenthaltsstatus', 'muttersprache',
        'strasse', 'hausnummer', 'plz', 'ort', 'land',
        'telefon_mobil',
        'leistungsbescheid_file',
        'mitgliedsart', 'finanzielle_situation',
        'zahlungsmethode', 'zahlungstag',
        'mitgliedschaftsbeginn_option', 'mitgliedschaftsbeginn_datum',
        'status', 'role', 'preferred_language',
        'datenschutz_accepted_at', 'satzung_accepted_at',
        'widerrufsbelehrung_accepted_at',
        'created_at',
    ];
    $vals = [
        $mnr, $autoEmail,
        // Passwordless flow: auth = device_key + approve_login.
        // The column is NOT NULL though, so we plant an unguessable
        // bcrypt of 64 random chars — no human will ever match it.
        password_hash(bin2hex(random_bytes(32)), PASSWORD_BCRYPT),
        $combinedName,
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
        empty($bescheidPaths) ? null : $bescheidPaths[0],
        $draft['data_mitgliedsart'], $draft['data_finanzielle_situation'],
        $draft['data_zahlungsmethode'] ?: null,
        $draft['data_zahlungstag'] ?: null,
        $draft['data_mitgliedschaftsbeginn_option'],
        $draft['data_mitgliedschaftsbeginn_datum'] ?: null,
        $status, $isMinor ? 'jugendmitglied' : 'mitglied', $draft['data_muttersprache'] ?: 'de',
        ($draft['data_datenschutz_read_at'] ?: $now), ($draft['data_satzung_read_at'] ?: $now), ($draft['data_widerrufsbelehrung_read_at'] ?: $now),
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

    // Either UPDATE the stub created by check_age.php (the modern
    // path) or INSERT a new row (legacy drafts that pre-date stub
    // creation in check_age). Either way we end up with a populated
    // users row owned by $userId.
    if ($existingStubId > 0) {
        // mitgliedernummer + email + password_hash + created_at were
        // set when the stub was created and are immutable here.
        $immutable = ['mitgliedernummer', 'email', 'password_hash', 'created_at'];
        $setParts = [];
        $setVals  = [];
        foreach ($cols as $idx => $c) {
            if (in_array($c, $immutable, true)) {
                continue;
            }
            $setParts[] = "$c = ?";
            $setVals[]  = $vals[$idx];
        }
        $setVals[] = $existingStubId;
        $pdo->prepare('UPDATE users SET ' . implode(', ', $setParts) . ' WHERE id = ?')
            ->execute($setVals);
        $userId = $existingStubId;
    } else {
        $placeholders = implode(', ', array_fill(0, count($cols), '?'));
        $sql = 'INSERT INTO users (' . implode(', ', $cols) . ') VALUES (' . $placeholders . ')';
        $pdo->prepare($sql)->execute($vals);
        $userId = (int)$pdo->lastInsertId();
    }

    // Materialise the 8 user_verifizierung rows. All Stufen 1-5 are
    // marked 'ausgefuellt' since the wizard captured the data; 6/7/8
    // are 'ausgefuellt' because the wizard required reading them.
    // The Vorstand still has to flip each to 'geprueft' / 'abgelehnt'.
    //
    // ausgefuellt_am is sourced from wizard_drafts: stufeN_completed_at
    // for 1-5 and data_{satzung,datenschutz,widerrufsbelehrung}_read_at
    // for 6/7/8. Fallback to $now if a draft pre-dates the per-Stufe
    // columns or the column is somehow NULL.
    //
    // When the stub path was taken, check_age already INSERTed 8
    // "offen" rows; INSERT IGNORE here is a no-op and the UPDATE
    // below flips them to "ausgefuellt".
    $stufeAusgefuelltAm = [
        1 => $draft['stufe1_completed_at']                ?: $now,
        2 => $draft['stufe2_completed_at']                ?: $now,
        3 => $draft['stufe3_completed_at']                ?: $now,
        4 => $draft['stufe4_completed_at']                ?: null,
        5 => $draft['stufe5_completed_at']                ?: $now,
        6 => $draft['data_satzung_read_at']               ?: $now,
        7 => $draft['data_datenschutz_read_at']           ?: $now,
        8 => $draft['data_widerrufsbelehrung_read_at']    ?: $now,
    ];

    $insertStmt = $pdo->prepare(
        'INSERT IGNORE INTO user_verifizierung
         (user_id, stufe, status, ausgefuellt_am)
         VALUES (?, ?, ?, ?)'
    );
    $updateStmt = $pdo->prepare(
        'UPDATE user_verifizierung
            SET status = ?, ausgefuellt_am = ?
          WHERE user_id = ? AND stufe = ?'
    );
    for ($s = 1; $s <= 8; $s++) {
        // Skip Stufe 4 for buergergeld/sozialamt/alg1/krankengeld —
        // those visitors get a beitragsfreie membership and Stufe 4
        // stays "offen" with NULL ausgefuellt_am.
        $skipStufe4 = $s === 4 &&
            in_array($draft['data_finanzielle_situation'],
                     ['buergergeld', 'sozialamt', 'alg1', 'krankengeld'], true);
        $row = [
            $skipStufe4 ? 'offen' : 'ausgefuellt',
            $skipStufe4 ? null : $stufeAusgefuelltAm[$s],
        ];
        $insertStmt->execute([
            $userId, $s, $row[0], $row[1],
        ]);
        $updateStmt->execute([
            $row[0], $row[1], $userId, $s,
        ]);
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
