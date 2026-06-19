<?php
/**
 * /api/public/anonymous_chat/send.php
 *
 * Anonymous visitor sends a message. Mirrors /api/chat/send.php but
 * authenticates via the anonymous_id stored in SharedPreferences
 * instead of an API key + Bearer token. The conversation row was
 * already created by init.php on the first visit; this endpoint just
 * appends to it.
 *
 * Payload (JSON POST):
 *   anonymous_id     string, required (must match anonymous_chat_users)
 *   conversation_id  int,    required (must belong to that user)
 *   message          string, required, 1..4000 chars
 *
 * On success the message is INSERTed into chat_messages, the
 * conversation row's updated_at is bumped, and WebSocketNotifier fires
 * so any connected Vorstand gets the realtime push immediately.
 *
 * Response:
 *   200 { success: true, message_id, created_at, message: 'Message sent' }
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../../config.php';
require_once __DIR__ . '/../../helpers/WebSocketNotifier.php';

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

$anonymous_id   = trim((string)($body['anonymous_id']   ?? ''));
$conversationId = (int)($body['conversation_id'] ?? 0);
$message        = trim((string)($body['message']        ?? ''));

if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}
if ($conversationId <= 0) {
    http_response_code(400);
    jsonResponse(false, [], 'Missing conversation_id');
}
if ($message === '') {
    http_response_code(400);
    jsonResponse(false, [], 'Message cannot be empty');
}
if (mb_strlen($message) > 4000) {
    $message = mb_substr($message, 0, 4000);
}

$pdo = getDBConnection();

try {
    // Resolve visitor → user record (must be the ghost with is_anonymous=1).
    $stmt = $pdo->prepare(
        'SELECT u.id, u.name, u.role, u.mitgliedernummer, u.preferred_language
         FROM users u
         JOIN anonymous_chat_users a ON a.user_id = u.id
         WHERE a.anonymous_id = ? AND u.is_anonymous = 1'
    );
    $stmt->execute([$anonymous_id]);
    $user = $stmt->fetch();
    if (!$user) {
        http_response_code(404);
        jsonResponse(false, [], 'Anonymous session not found');
    }

    // Conversation must belong to this visitor.
    $stmt = $pdo->prepare(
        'SELECT id, member_id, status FROM chat_conversations WHERE id = ?'
    );
    $stmt->execute([$conversationId]);
    $conv = $stmt->fetch();
    if (!$conv || (int)$conv['member_id'] !== (int)$user['id']) {
        http_response_code(403);
        jsonResponse(false, [], 'Not your conversation');
    }
    if ($conv['status'] !== 'open') {
        http_response_code(409);
        jsonResponse(false, [], 'Conversation closed');
    }

    // Persist.
    $stmt = $pdo->prepare(
        'INSERT INTO chat_messages
           (conversation_id, sender_id, message, is_urgent, message_status)
         VALUES (?, ?, ?, 0, "sent")'
    );
    $stmt->execute([$conversationId, (int)$user['id'], $message]);
    $messageId = (int)$pdo->lastInsertId();

    $pdo->prepare('UPDATE chat_conversations SET updated_at = NOW() WHERE id = ?')
        ->execute([$conversationId]);

    // Bump anonymous activity so the Vorstand can sort by "still around?".
    $pdo->prepare('UPDATE anonymous_chat_users SET last_active = NOW() WHERE user_id = ?')
        ->execute([(int)$user['id']]);

    $createdAt = date('Y-m-d H:i:s');

    // Flush response before pinging the WS — same pattern as /api/chat/send.php.
    http_response_code(201);
    echo json_encode([
        'success'    => true,
        'message_id' => $messageId,
        'created_at' => $createdAt,
        'message'    => 'Message sent',
    ]);
    if (function_exists('fastcgi_finish_request')) {
        fastcgi_finish_request();
    }

    // Realtime push to whoever's in this conversation room on the WS.
    try {
        WebSocketNotifier::notifyNewMessage(
            $conversationId,
            $messageId,
            (int)$user['id'],
            (string)$user['name'],
            (string)$user['role'],
            false,                       // is_admin — anonymous visitor is never admin
            $message,
            $createdAt,
            (string)($user['preferred_language'] ?? 'en'),
            0,                           // not urgent
            (string)$user['mitgliedernummer'],
            null                         // no translation pre-computed here
        );
    } catch (Exception $e) {
        error_log('[anonymous_chat/send] WS notify failed: ' . $e->getMessage());
    }

} catch (PDOException $e) {
    error_log('[anonymous_chat/send] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Server error');
}
