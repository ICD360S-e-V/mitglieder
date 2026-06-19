<?php
/**
 * /api/public/anonymous_chat/messages.php
 *
 * Polling fallback for the visitor side when the WebSocket isn't
 * available (sandbox, restrictive network, just slower) — returns the
 * messages of the visitor's conversation, optionally only those newer
 * than `last_message_id`.
 *
 * Payload (JSON POST):
 *   anonymous_id     string, required (must match anonymous_chat_users)
 *   conversation_id  int,    required (must belong to that user)
 *   last_message_id  int,    optional — only return chat_messages.id > this
 *
 * Response:
 *   200 {
 *     success: true,
 *     items: [
 *       { id, sender_id, sender_name, sender_role, is_admin, message,
 *         created_at, is_urgent },
 *       ...
 *     ]
 *   }
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../../config.php';

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

$anonymous_id    = trim((string)($body['anonymous_id']    ?? ''));
$conversationId  = (int)($body['conversation_id']  ?? 0);
$lastMessageId   = (int)($body['last_message_id']  ?? 0);

if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}
if ($conversationId <= 0) {
    http_response_code(400);
    jsonResponse(false, [], 'Missing conversation_id');
}

$pdo = getDBConnection();

try {
    // Resolve visitor → user record.
    $stmt = $pdo->prepare(
        'SELECT u.id
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
    $stmt = $pdo->prepare('SELECT member_id FROM chat_conversations WHERE id = ?');
    $stmt->execute([$conversationId]);
    $conv = $stmt->fetch();
    if (!$conv || (int)$conv['member_id'] !== (int)$user['id']) {
        http_response_code(403);
        jsonResponse(false, [], 'Not your conversation');
    }

    // Touch last_active so the Vorstand knows the visitor is still around.
    $pdo->prepare('UPDATE anonymous_chat_users SET last_active = NOW() WHERE user_id = ?')
        ->execute([(int)$user['id']]);

    // Pull messages with sender metadata. Cap at 200 rows just in case
    // last_message_id is left at 0 on a long-running thread.
    $stmt = $pdo->prepare(
        'SELECT m.id, m.sender_id, m.message, m.is_urgent, m.created_at,
                u.name AS sender_name, u.role AS sender_role
         FROM chat_messages m
         JOIN users u ON u.id = m.sender_id
         WHERE m.conversation_id = ? AND m.id > ?
         ORDER BY m.id ASC
         LIMIT 200'
    );
    $stmt->execute([$conversationId, $lastMessageId]);

    $items = [];
    while ($row = $stmt->fetch()) {
        $items[] = [
            'id'           => (int)$row['id'],
            'sender_id'    => (int)$row['sender_id'],
            'sender_name'  => (string)$row['sender_name'],
            'sender_role'  => (string)$row['sender_role'],
            'is_admin'     => ($row['sender_role'] === 'vorsitzer'),
            'message'      => (string)$row['message'],
            'is_urgent'    => ((int)$row['is_urgent']) === 1,
            'created_at'   => (string)$row['created_at'],
        ];
    }

    jsonResponse(true, ['items' => $items], 'OK');

} catch (PDOException $e) {
    error_log('[anonymous_chat/messages] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Server error');
}
