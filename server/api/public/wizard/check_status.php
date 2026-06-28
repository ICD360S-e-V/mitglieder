<?php
/**
 * /api/public/wizard/check_status.php
 *
 * Live status probe for the wizard's WizardFinalScreen. After finalize
 * the visitor sees the celebration screen with a 4-step timeline:
 *   1. Cererea primită
 *   2. Vorstand verifică
 *   3. Cont activat
 *   4. Bun venit
 *
 * The client polls this endpoint every 30 s while the screen is open
 * so it can flip step 3 to green the moment the Vorstand approves —
 * no need for the user to refresh or re-open the app.
 *
 * Payload (JSON POST):
 *   anonymous_id  string, required
 *
 * Response: 200 {
 *     success,
 *     mitgliedernummer,  // matches the wizard's reserved number
 *     user_id,           // null if finalize hasn't run yet
 *     status,            // users.status enum value (or null if no user yet)
 *     is_active,         // convenience: true when status === 'active'
 *     is_minor           // convenience: true for waiting_for_parent_consent
 * }
 *
 * Cheap public endpoint — same shape as get_state.php, no token. The
 * anonymous_id is the gate.
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
    $stmt = $pdo->prepare(
        'SELECT wd.mitgliedernummer AS draft_mnr,
                wd.user_id,
                u.mitgliedernummer  AS user_mnr,
                u.status
           FROM wizard_drafts wd
           LEFT JOIN users u ON u.id = wd.user_id
          WHERE wd.anonymous_id = ?'
    );
    $stmt->execute([$anonymous_id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) {
        http_response_code(404);
        jsonResponse(false, [], 'Wizard draft not found');
    }

    $mnr     = $row['user_mnr']  ?? $row['draft_mnr'] ?? null;
    $userId  = $row['user_id'] !== null ? (int)$row['user_id'] : null;
    $status  = $row['status'];

    // Chronological per-Stufe status — drives the "Status cerere"
    // bottom sheet on the final screen. ausgefuellt_am is the moment
    // the visitor finished filling the Stufe (set by save_step.php);
    // geprueft_am is when the Vorstand signed it off.
    $stufen = [];
    if ($userId !== null) {
        $sstmt = $pdo->prepare(
            'SELECT stufe, status, ausgefuellt_am, geprueft_am, notiz
               FROM user_verifizierung
              WHERE user_id = ?
              ORDER BY stufe ASC'
        );
        $sstmt->execute([$userId]);
        foreach ($sstmt->fetchAll(PDO::FETCH_ASSOC) as $sr) {
            $stufen[] = [
                'stufe'           => (int)$sr['stufe'],
                'status'          => $sr['status'],
                'ausgefuellt_am'  => $sr['ausgefuellt_am'],
                'geprueft_am'     => $sr['geprueft_am'],
                // Vorstand's reason for status='abgelehnt' — the
                // visitor sees it inline on the rejection row so they
                // know what to correct before re-opening the step.
                'notiz'           => $sr['notiz'],
            ];
        }
    }

    jsonResponse(true, [
        'mitgliedernummer' => $mnr,
        'user_id'          => $userId,
        'status'           => $status,
        'is_active'        => $status === 'active',
        'is_minor'         => $status === 'waiting_for_parent_consent',
        'stufen'           => $stufen,
    ], 'OK');
} catch (PDOException $e) {
    error_log('[wizard/check_status] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
