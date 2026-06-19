<?php
/**
 * /api/public/bug_report.php
 *
 * Public endpoint for in-app bug reports submitted from the Mitglieder
 * Flutter client (lib/screens/problem_report.dart). Unauthenticated —
 * the form sits on the welcome screen before login, so we can't gate
 * with a Bearer token. The User-Agent check (blockBrowserAccess) still
 * keeps random browsers from poking it; the Flutter client uses
 * "ICD360S-Mitglied/1.0" which passes through.
 *
 * Payload (JSON POST):
 *   description       string, required, 20..8000 chars after trim
 *   mitgliedernummer  string, optional, "M00000" shape
 *
 * The anonymous_id used for diagnostics is NOT included on purpose:
 * device-level data already arrives via /api/diagnostic/log.php when
 * consent is granted, and the user explicitly asked us not to attach
 * it again here.
 *
 * Response (via jsonResponse helper):
 *   200 { success: true,  id: <int>, message: "Bug report received" }
 *   4xx { success: false, message: "<reason>" }
 *
 * Schema: server/sql/bug_reports_schema.sql in this same repo.
 *
 * Reader / status-updater endpoints live in the vorsitzer repo (see the
 * sibling prompt for /api/vorstand/bug_reports/list.php + update.php).
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';

blockBrowserAccess();

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

// CORS preflight (the Flutter HTTP client does not send a preflight, but
// keeps the door open if a partner web tool ever wants to poke this).
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    jsonResponse(false, [], 'Method not allowed');
}

$raw  = file_get_contents('php://input');
$body = json_decode($raw, true);
if (!is_array($body)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid JSON');
}

$description = trim((string)($body['description'] ?? ''));
$mitglied    = isset($body['mitgliedernummer'])
    ? trim((string)$body['mitgliedernummer'])
    : null;

if (mb_strlen($description) < 20) {
    http_response_code(400);
    jsonResponse(false, [], 'Description too short (need at least 20 chars)');
}

// Cap so a paste of MB-size text can't bloat the DB.
if (mb_strlen($description) > 8000) {
    $description = mb_substr($description, 0, 8000);
}

// Validate mitgliedernummer if present — must match the "M00000" shape
// enforced in the client. Anything else is treated as anonymous.
if ($mitglied !== null && !preg_match('/^[A-Z]\d{5}$/', $mitglied)) {
    $mitglied = null;
}

$pdo = getDBConnection();

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
    // bridge. Stub for now; the vorsitzer repo will fill it in once the
    // admin screen lands.
    notify_vorstand_new_bug_report($reportId);

    jsonResponse(true, ['id' => $reportId], 'Bug report received');
} catch (PDOException $e) {
    error_log('[bug_report] INSERT failed: ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Could not save report');
}

/**
 * Stub: tell connected Vorstand members a new bug report is in. Replace
 * the body with the real WebSocket / Redis publish call once the
 * vorsitzer admin screen is wired up.
 */
function notify_vorstand_new_bug_report(int $reportId): void {
    // TODO(vorsitzer): publish {"type":"bug_report_new","id":$reportId}
}
