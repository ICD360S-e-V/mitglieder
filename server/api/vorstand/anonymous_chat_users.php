<?php
/**
 * /api/vorstand/anonymous_chat_users.php
 *
 * Returns the metadata row from `anonymous_chat_users` for one ghost user
 * (language, platform, app version, first_open / last_active). Called
 * from the Vorsitzer chat header right after the operator opens an
 * anonymous conversation so the orange info panel can show real values
 * instead of dashes.
 *
 * Auth: same pattern as other vorstand endpoints — validateApiKey() +
 * blockBrowserAccess(), X-Device-Key header (already attached by the
 * Flutter client via DeviceKeyService), plus caller's mitgliedernummer
 * in the body resolving to a user with role=vorsitzer.
 *
 * Payload (JSON POST):
 *   mitgliedernummer  string, required — caller (vorsitzer)
 *   user_id           int, required    — ghost user's id from chat_conversations.member_id
 *
 * Response:
 *   { success: true,
 *     anonymous_id, language, platform, app_version,
 *     first_open_at, created_at, last_active }
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';

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

$caller = trim((string)($body['mitgliedernummer'] ?? ''));
$userId = (int)($body['user_id'] ?? 0);

if ($caller === '' || $userId <= 0) {
    http_response_code(400);
    jsonResponse(false, [], 'Missing required fields');
}

try {
    $pdo = getDBConnection();

    $stmt = $pdo->prepare('SELECT id, role FROM users WHERE mitgliedernummer = ?');
    $stmt->execute([$caller]);
    $admin = $stmt->fetch();
    if (!$admin || $admin['role'] !== 'vorsitzer') {
        http_response_code(403);
        jsonResponse(false, [], 'Access denied');
    }

    // Also confirm the target really is a ghost user — leaks nothing
    // about real members if a bad id is passed.
    $tgt = $pdo->prepare('SELECT is_anonymous FROM users WHERE id = ?');
    $tgt->execute([$userId]);
    $target = $tgt->fetch();
    if (!$target || (int)$target['is_anonymous'] !== 1) {
        http_response_code(404);
        jsonResponse(false, [], 'Not an anonymous user');
    }

    $stmt = $pdo->prepare(
        'SELECT anonymous_id, language, platform, app_version,
                first_open_at, created_at, last_active
         FROM anonymous_chat_users WHERE user_id = ?'
    );
    $stmt->execute([$userId]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) {
        // The chat_users row hasn't been written yet — return success
        // with empty fields so the client renders a graceful "—".
        jsonResponse(true, [
            'anonymous_id'  => null,
            'language'      => null,
            'platform'      => null,
            'app_version'   => null,
            'first_open_at' => null,
            'created_at'    => null,
            'last_active'   => null,
        ], 'No metadata yet');
    }

    jsonResponse(true, [
        'anonymous_id'  => $row['anonymous_id'],
        'language'      => $row['language'],
        'platform'      => $row['platform'],
        'app_version'   => $row['app_version'],
        'first_open_at' => $row['first_open_at'],
        'created_at'    => $row['created_at'],
        'last_active'   => $row['last_active'],
    ], 'OK');
} catch (PDOException $e) {
    error_log('[anonymous_chat_users] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
