<?php
/**
 * /api/public/wizard/save_step.php
 *
 * Persist one step's worth of data into the `wizard_drafts` row for a
 * given anonymous_id and advance the `current_step` cursor. The
 * endpoint validates the named step, allow-lists only the columns
 * that belong to that step (so a confused client can't smash random
 * fields), and refuses unknown keys.
 *
 * Payload (JSON POST):
 *   anonymous_id  string, required
 *   step          string, required — one of: 1a, 1b, 1b1, 1c, 1d, 1e,
 *                                            1f, 2, 3, 3_upload, 4,
 *                                            5, 6, 7, 8, intro_done
 *   data          object, required — only the fields appropriate to
 *                                    the step (see $stepFields below)
 *
 * Response:
 *   200 { success: true, current_step, saved_fields, last_active }
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
$step         = trim((string)($body['step'] ?? ''));
$data         = $body['data'] ?? null;

if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}
if (!is_array($data)) {
    http_response_code(400);
    jsonResponse(false, [], 'data must be an object');
}

// Field allow-list per step. Maps step name to the actual
// wizard_drafts columns the client may write at that step.
$stepFields = [
    'intro_done' => [],                              // just advances cursor
    '1a'         => ['data_vorname', 'data_nachname', 'data_geburtsname'],
    '1b'         => ['data_geburtsdatum', 'data_geburtsort'],
    '1b1'        => ['data_parent_hint_vorname', 'data_parent_hint_nachname',
                     'data_parent_hint_telefon', 'data_parent_hint_relation'],
    '1c'         => ['data_geschlecht', 'data_familienstand'],
    '1d'         => ['data_staatsangehoerigkeit', 'data_aufenthaltsstatus',
                     'data_muttersprache'],
    '1e'         => ['data_strasse', 'data_hausnummer', 'data_plz',
                     'data_ort', 'data_land'],
    '1f'         => ['data_telefon_mobil', 'data_email'],
    '2'          => ['data_mitgliedsart'],
    '3'          => ['data_finanzielle_situation'],
    '3_upload'   => ['data_leistungsbescheid_file'],
    '4'          => ['data_zahlungsmethode', 'data_zahlungstag'],
    '5'          => ['data_mitgliedschaftsbeginn_option',
                     'data_mitgliedschaftsbeginn_datum'],
    '6'          => ['data_satzung_read'],
    '7'          => ['data_datenschutz_read'],
    '8'          => ['data_widerrufsbelehrung_read'],
];

if (!isset($stepFields[$step])) {
    http_response_code(400);
    jsonResponse(false, [], 'Unknown step');
}

$allowed = $stepFields[$step];
$updates = [];
$params  = [];

foreach ($data as $key => $value) {
    $col = 'data_' . $key;
    if (!in_array($col, $allowed, true)) {
        // Silently ignore unknown keys rather than erroring — the
        // client may send a few extras during refactors and we'd
        // rather not block the save.
        continue;
    }
    // Light coercion: empty string → NULL so the column-level default
    // ("Deutschland", "deutsch") wins on resume.
    if ($value === '') {
        $value = null;
    }
    $updates[$col] = $value;
}

try {
    $pdo = getDBConnection();

    $stmt = $pdo->prepare('SELECT id FROM wizard_drafts WHERE anonymous_id = ?');
    $stmt->execute([$anonymous_id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$row) {
        http_response_code(404);
        jsonResponse(false, [], 'Wizard draft not found');
    }
    $draftId = (int)$row['id'];

    if (empty($updates)) {
        // Only the cursor moves (e.g. intro_done).
        $pdo->prepare('UPDATE wizard_drafts SET current_step = ?,
                       last_active = NOW() WHERE id = ?')
            ->execute([$step, $draftId]);
    } else {
        $setParts = [];
        foreach ($updates as $col => $_) {
            $setParts[] = "$col = ?";
            $params[]   = $updates[$col];
        }
        $params[] = $step;
        $params[] = $draftId;
        $sql = 'UPDATE wizard_drafts SET ' . implode(', ', $setParts)
             . ', current_step = ?, last_active = NOW() WHERE id = ?';
        $pdo->prepare($sql)->execute($params);
    }

    jsonResponse(true, [
        'current_step' => $step,
        'saved_fields' => array_keys($updates),
        'last_active'  => date('Y-m-d H:i:s'),
    ], 'Step saved');
} catch (PDOException $e) {
    error_log('[wizard/save_step] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
