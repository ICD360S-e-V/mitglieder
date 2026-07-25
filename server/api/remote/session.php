<?php
/**
 * /api/remote/session.php
 *
 * Audit + authorization endpoint for Fernwartung (RustDesk-style remote support).
 * SEPARATE from the RDP/Guacamole office remote desktop and from voice calls.
 *
 * The Vorsitzer app calls this to (1) prove it is allowed to initiate a remote
 * session (role gate) and (2) write the immutable audit trail into
 * `remote_sessions` (see migrations/2026_07_24_remote_sessions.sql). The actual
 * screen/keyboard stream never touches PHP — it is WebRTC (DTLS/SRTP over the
 * coturn TURN relay), signaled via the WebSocket daemon (remote_* frames).
 *
 * There is NO unattended access: a row only becomes 'active' after the member
 * has consented in their own app (the Vorsitzer marks 'active' when it receives
 * remote_answer, which the member only sends after pressing "Erlauben").
 *
 * Auth: same pattern as the vorstand endpoints — validateApiKey() +
 * blockBrowserAccess() + caller's mitgliedernummer must resolve to role=vorsitzer.
 *
 * Payload (JSON POST):
 *   mitgliedernummer       string, required — caller (must be vorsitzer)
 *   action                 string, required — start | active | declined | end
 *   target_mitgliedernummer string, required for action=start — the member
 *   session_id             int, required for active|declined|end
 *   conversation_id        int, optional — WS room used for signaling
 *   control_allowed        bool, optional (start) — 1 desktop control, 0 view-only
 *   member_platform        string, optional — windows|macos|linux|android|ios
 *   reason                 string, optional (end) — member_stop|controller_end|disconnect|timeout|error
 *
 * Response: { success, session_id, status, message }
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
$action = trim((string)($body['action'] ?? ''));

if ($caller === '' || !in_array($action, ['start', 'active', 'declined', 'end'], true)) {
    http_response_code(400);
    jsonResponse(false, [], 'Missing or invalid fields');
}

$callerIp = $_SERVER['REMOTE_ADDR'] ?? null;

try {
    $pdo = getDBConnection();

    // Role gate: only a vorsitzer may drive a remote session.
    $stmt = $pdo->prepare('SELECT id, role FROM users WHERE mitgliedernummer = ?');
    $stmt->execute([$caller]);
    $admin = $stmt->fetch();
    if (!$admin || $admin['role'] !== 'vorsitzer') {
        http_response_code(403);
        jsonResponse(false, [], 'Access denied');
    }
    $controllerId = (int)$admin['id'];

    if ($action === 'start') {
        $targetMnr = trim((string)($body['target_mitgliedernummer'] ?? ''));
        if ($targetMnr === '') {
            http_response_code(400);
            jsonResponse(false, [], 'Missing target_mitgliedernummer');
        }
        $t = $pdo->prepare('SELECT id FROM users WHERE mitgliedernummer = ?');
        $t->execute([$targetMnr]);
        $member = $t->fetch();
        if (!$member) {
            http_response_code(404);
            jsonResponse(false, [], 'Member not found');
        }
        $memberId = (int)$member['id'];

        $conversationId = isset($body['conversation_id']) ? (int)$body['conversation_id'] : null;
        $controlAllowed = !empty($body['control_allowed']) ? 1 : 0;
        $memberPlatform = isset($body['member_platform'])
            ? substr((string)$body['member_platform'], 0, 32) : null;

        $ins = $pdo->prepare(
            'INSERT INTO remote_sessions
                (conversation_id, controller_id, member_id, status, control_allowed,
                 requested_at, controller_ip, member_platform)
             VALUES (?, ?, ?, "requested", ?, NOW(), ?, ?)'
        );
        $ins->execute([$conversationId, $controllerId, $memberId, $controlAllowed, $callerIp, $memberPlatform]);
        $sessionId = (int)$pdo->lastInsertId();

        jsonResponse(true, ['session_id' => $sessionId, 'status' => 'requested'], 'OK');
    }

    // active | declined | end all update an existing row owned by this controller.
    $sessionId = (int)($body['session_id'] ?? 0);
    if ($sessionId <= 0) {
        http_response_code(400);
        jsonResponse(false, [], 'Missing session_id');
    }

    if ($action === 'active') {
        // consent_at is stamped here as a proxy: an answer (→ active) only ever
        // follows the member pressing "Erlauben".
        $up = $pdo->prepare(
            'UPDATE remote_sessions
                SET status = "active",
                    consent_at = COALESCE(consent_at, NOW()),
                    started_at = NOW()
              WHERE id = ? AND controller_id = ?'
        );
        $up->execute([$sessionId, $controllerId]);
        jsonResponse(true, ['session_id' => $sessionId, 'status' => 'active'], 'OK');
    }

    if ($action === 'declined') {
        $up = $pdo->prepare(
            'UPDATE remote_sessions
                SET status = "declined", ended_at = NOW(), end_reason = "declined"
              WHERE id = ? AND controller_id = ?'
        );
        $up->execute([$sessionId, $controllerId]);
        jsonResponse(true, ['session_id' => $sessionId, 'status' => 'declined'], 'OK');
    }

    // action === 'end'
    $reason = isset($body['reason']) ? substr((string)$body['reason'], 0, 64) : 'controller_end';
    $up = $pdo->prepare(
        'UPDATE remote_sessions
            SET status = "ended", ended_at = NOW(), end_reason = ?
          WHERE id = ? AND controller_id = ?'
    );
    $up->execute([$reason, $sessionId, $controllerId]);
    jsonResponse(true, ['session_id' => $sessionId, 'status' => 'ended'], 'OK');
} catch (PDOException $e) {
    error_log('[remote/session] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
