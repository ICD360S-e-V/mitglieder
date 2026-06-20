<?php
/**
 * /api/public/wizard/start.php
 *
 * Begin a new onboarding wizard session. The client generates the
 * anonymous_id locally (32 hex on first launch, kept in
 * SharedPreferences) and sends it here; if the row already exists in
 * `wizard_drafts`, we return the stored state so the visitor resumes
 * where they left off. Otherwise we create a fresh draft scoped to
 * 30 days.
 *
 * Public endpoint — no Bearer token. blockBrowserAccess() still gates
 * against random browser UAs.
 *
 * Payload (JSON POST):
 *   anonymous_id  string, required, 16..64 chars [A-Za-z0-9_-]
 *
 * Response:
 *   200 {
 *     success: true,
 *     anonymous_id, current_step, resumed: <bool>,
 *     created_at, expires_at
 *   }
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

    $stmt = $pdo->prepare('SELECT id, current_step, created_at, expires_at
                           FROM wizard_drafts WHERE anonymous_id = ?');
    $stmt->execute([$anonymous_id]);
    $existing = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($existing) {
        // Refresh expires_at + last_active by touching it.
        $pdo->prepare('UPDATE wizard_drafts SET last_active = NOW(),
                       expires_at = DATE_ADD(NOW(), INTERVAL 30 DAY)
                       WHERE id = ?')->execute([$existing['id']]);
        jsonResponse(true, [
            'anonymous_id' => $anonymous_id,
            'current_step' => $existing['current_step'],
            'resumed'      => true,
            'created_at'   => $existing['created_at'],
            'expires_at'   => date('Y-m-d H:i:s', strtotime('+30 days')),
        ], 'Wizard draft resumed');
    }

    $expires = date('Y-m-d H:i:s', strtotime('+30 days'));
    $pdo->prepare('INSERT INTO wizard_drafts (anonymous_id, current_step, expires_at)
                   VALUES (?, ?, ?)')
        ->execute([$anonymous_id, 'intro', $expires]);

    jsonResponse(true, [
        'anonymous_id' => $anonymous_id,
        'current_step' => 'intro',
        'resumed'      => false,
        'created_at'   => date('Y-m-d H:i:s'),
        'expires_at'   => $expires,
    ], 'Wizard draft created');
} catch (PDOException $e) {
    error_log('[wizard/start] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
