<?php
/**
 * /api/public/wizard/get_state.php
 *
 * Return the full draft state for an anonymous_id so the client can
 * rehydrate the wizard on a fresh launch. Strips the `data_` prefix
 * from columns to keep the client payload compact.
 *
 * Payload (JSON POST):
 *   anonymous_id  string, required
 *
 * Response:
 *   200 { success: true, current_step, data: {vorname, nachname, …},
 *         last_active, expires_at }
 *   404 if the draft has been pruned (expired or never created).
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
    $stmt = $pdo->prepare('SELECT * FROM wizard_drafts WHERE anonymous_id = ?');
    $stmt->execute([$anonymous_id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) {
        http_response_code(404);
        jsonResponse(false, [], 'Wizard draft not found');
    }

    // Drop the data_ prefix and a few bookkeeping columns from the
    // outgoing payload so the client just sees the values.
    $data = [];
    foreach ($row as $key => $value) {
        if (strpos($key, 'data_') === 0) {
            $data[substr($key, 5)] = $value;
        }
    }

    jsonResponse(true, [
        'anonymous_id' => $row['anonymous_id'],
        'current_step' => $row['current_step'],
        'data'         => $data,
        'created_at'   => $row['created_at'],
        'last_active'  => $row['last_active'],
        'expires_at'   => $row['expires_at'],
    ], 'OK');
} catch (PDOException $e) {
    error_log('[wizard/get_state] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
