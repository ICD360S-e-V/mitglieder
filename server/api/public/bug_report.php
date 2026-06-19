<?php
/**
 * /api/public/bug_report.php
 *
 * Public endpoint for in-app bug reports submitted from the Mitglieder
 * Flutter client (lib/screens/problem_report.dart). Unauthenticated —
 * the form sits on the welcome screen, before login, so we can't
 * require a Bearer token.
 *
 * Payload (JSON POST):
 *   description       string, required, 20..8000 chars after trim
 *   mitgliedernummer  string, optional, "M" + 5 digits (uppercase)
 *
 * The anonymous_id used for diagnostics is NOT included on purpose:
 * the device-level data already arrives via /api/diagnostic/log.php
 * when the user has consented, and the user explicitly asked us not
 * to attach it again here.
 *
 * Response:
 *   200 { success: true,  id: <int>, message: "Bug report received" }
 *   4xx { success: false, message: "<reason>" }
 *
 * Schema: server/sql/bug_reports_schema.sql in this same repo.
 *
 * Reader / status-updater endpoints live in the vorsitzer repo
 * (see /api/vorstand/bug_reports/list.php + update.php once added).
 */

declare(strict_types=1);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Cache-Control: no-store');

// CORS preflight.
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

// --- Database connection --------------------------------------------------
// Adjust this include path to match where db credentials live on the
// production server. Existing endpoints in this same /api tree use the
// shared config — point at it the same way they do.
$config = __DIR__ . '/../../config.php';
if (!is_readable($config)) {
    http_response_code(500);
    error_log('[bug_report] config.php not readable at ' . $config);
    echo json_encode(['success' => false, 'message' => 'Server misconfigured']);
    exit;
}
require_once $config;

try {
    $pdo = new PDO(
        "mysql:host={$db_host};dbname={$db_name};charset=utf8mb4",
        $db_user,
        $db_pass,
        [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ]
    );
} catch (PDOException $e) {
    http_response_code(500);
    error_log('[bug_report] DB connect failed: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Database unavailable']);
    exit;
}

// --- Input parsing & validation -------------------------------------------
$raw  = file_get_contents('php://input');
$body = json_decode($raw, true);
if (!is_array($body)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Invalid JSON']);
    exit;
}

$description = trim((string)($body['description'] ?? ''));
$mitglied    = isset($body['mitgliedernummer'])
    ? trim((string)$body['mitgliedernummer'])
    : null;

if (mb_strlen($description) < 20) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'Description too short (need at least 20 chars)',
    ]);
    exit;
}

// Cap so a paste of MB-size text can't bloat the DB.
if (mb_strlen($description) > 8000) {
    $description = mb_substr($description, 0, 8000);
}

// Validate mitgliedernummer if present — must match "M00000" shape we
// enforce in the client. Anything else is treated as anonymous to keep
// bogus identifiers out of the DB.
if ($mitglied !== null && !preg_match('/^[A-Z]\d{5}$/', $mitglied)) {
    $mitglied = null;
}

// --- Insert ---------------------------------------------------------------
try {
    $stmt = $pdo->prepare(
        'INSERT INTO bug_reports (mitgliedernummer, description, status, created_at)
         VALUES (:mnr, :desc, "new", NOW())'
    );
    $stmt->execute([
        ':mnr'  => $mitglied,
        ':desc' => $description,
    ]);
    $reportId = (int)$pdo->lastInsertId();

    // Fan out to any connected Vorstand member via the existing chat WS
    // bridge. Wired by the vorsitzer repo once the new screen lands —
    // for now this is a no-op; the function is defined below so the
    // call doesn't fatal if the bridge isn't there yet.
    notify_vorstand_new_bug_report($reportId);

    echo json_encode([
        'success' => true,
        'id'      => $reportId,
        'message' => 'Bug report received',
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    error_log('[bug_report] INSERT failed: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Could not save report']);
}

/**
 * Stub: tell connected Vorstand members a new bug report is in. Replace
 * the body with the real WebSocket / Redis publish call once the
 * vorsitzer admin screen is wired up.
 */
function notify_vorstand_new_bug_report(int $reportId): void {
    // TODO(vorsitzer): publish {"type":"bug_report_new","id":$reportId}
    // to the chat WS so it shows up in the Vorstand notifications panel
    // without waiting for a list refresh.
}
