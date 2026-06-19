<?php
/**
 * /api/public/anonymous_chat/init.php
 *
 * Stand up (or hand back) a ghost user record for an anonymous visitor
 * who wants to chat with a Vorstand member without joining. The client
 * generates a 32-hex anonymous_id on first launch and keeps it in
 * SharedPreferences; we use it as the join key so that returning to the
 * screen later yields the same conversation thread.
 *
 * Public endpoint, no Bearer token. blockBrowserAccess() still gates
 * against random browser UAs (Flutter sends ICD360S-Mitglied/1.0).
 *
 * Payload (JSON POST):
 *   anonymous_id   string, required, 16..64 chars, [a-zA-Z0-9_-]
 *   language       string, optional, BCP-47-ish code ("ro", "de", "uk")
 *   platform       string, optional ("Linux", "Android", "iOS", "Windows", "macOS")
 *   app_version    string, optional ("1.20.0")
 *   first_open_at  string, optional ISO 8601 UTC ("2026-06-19T18:30:00Z")
 *
 * Response (via jsonResponse):
 *   200 {
 *     success: true,
 *     mitgliedernummer: "ANON_A3F7B9C2",
 *     name:             "Anonim #A3F7",
 *     token:            "<JWT>",
 *     conversation_id:  <int>,
 *     message: "Anonymous session ready"
 *   }
 *
 * Side effects on first call for a given anonymous_id:
 *   • INSERT users (mitgliedernummer="ANON_xxxxxxxx", email="anon-...@local",
 *                   role="anonymous", is_anonymous=1, status="active", ...)
 *   • INSERT anonymous_chat_users (user_id, anonymous_id, metadata)
 *   • INSERT chat_conversations (member_id=user_id, admin_id=NULL,
 *                                subject="Anonymous chat", status="open")
 *
 * Subsequent calls for the same anonymous_id update last_active +
 * language and return the existing mitgliedernummer / conversation_id.
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

$raw  = file_get_contents('php://input');
$body = json_decode($raw, true);
if (!is_array($body)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid JSON');
}

$anonymous_id  = trim((string)($body['anonymous_id']  ?? ''));
$language      = trim((string)($body['language']      ?? ''));
$platform      = trim((string)($body['platform']      ?? ''));
$app_version   = trim((string)($body['app_version']   ?? ''));
$first_open_at = trim((string)($body['first_open_at'] ?? ''));

if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}

// Soft-cap optional fields so a malicious client can't bloat columns.
$language    = mb_substr($language,    0, 8);
$platform    = mb_substr($platform,    0, 50);
$app_version = mb_substr($app_version, 0, 20);

// Normalise the ISO timestamp; reject unparseable input rather than
// silently storing garbage.
$firstOpenSql = null;
if ($first_open_at !== '') {
    try {
        $dt = new DateTime($first_open_at);
        $dt->setTimezone(new DateTimeZone('UTC'));
        $firstOpenSql = $dt->format('Y-m-d H:i:s');
    } catch (Exception $e) {
        $firstOpenSql = null; // ignore, not fatal
    }
}

$pdo = getDBConnection();

try {
    // ── 1. Existing visitor? Reuse the ghost row. ─────────────────────
    $stmt = $pdo->prepare(
        'SELECT u.id, u.mitgliedernummer, u.name
         FROM users u
         JOIN anonymous_chat_users a ON a.user_id = u.id
         WHERE a.anonymous_id = ?'
    );
    $stmt->execute([$anonymous_id]);
    $existing = $stmt->fetch();

    if ($existing) {
        // Touch last_active + accept newest language hint.
        $stmt = $pdo->prepare(
            'UPDATE anonymous_chat_users
             SET last_active = NOW(),
                 language    = COALESCE(NULLIF(?, ""), language),
                 platform    = COALESCE(NULLIF(?, ""), platform),
                 app_version = COALESCE(NULLIF(?, ""), app_version)
             WHERE user_id = ?'
        );
        $stmt->execute([$language, $platform, $app_version, (int)$existing['id']]);

        $userId           = (int)$existing['id'];
        $mitgliedernummer = $existing['mitgliedernummer'];
        $displayName      = $existing['name'];
        $email            = "anon-{$anonymous_id}@icd360s.local";

        // Make sure there's an active conversation — visitor might have
        // come back after we closed the previous one.
        $convId = ensure_open_conversation($pdo, $userId);

    } else {
        // ── 2. First visit. Create the ghost row + metadata + conv. ───
        $shortHex = anonymous_short_token($anonymous_id);
        $mitgliedernummer = 'ANON_' . $shortHex;
        $displayName      = 'Anonim #' . substr($shortHex, 0, 4);
        $email            = "anon-{$anonymous_id}@icd360s.local";
        $passwordHash     = password_hash(bin2hex(random_bytes(32)), PASSWORD_BCRYPT);
        $effectiveLang    = $language !== '' ? $language : 'en';

        $pdo->beginTransaction();
        try {
            // Insert the user — only NOT NULL columns are filled; everything
            // else (vorname, address, geburtsdatum, …) stays NULL because
            // an anonymous visitor has no profile.
            $stmt = $pdo->prepare(
                'INSERT INTO users
                   (mitgliedernummer, email, password_hash, name, role,
                    is_anonymous, status, preferred_language)
                 VALUES
                   (?, ?, ?, ?, "anonymous", 1, "active", ?)'
            );
            $stmt->execute([
                $mitgliedernummer,
                $email,
                $passwordHash,
                $displayName,
                $effectiveLang,
            ]);
            $userId = (int)$pdo->lastInsertId();

            $stmt = $pdo->prepare(
                'INSERT INTO anonymous_chat_users
                   (user_id, anonymous_id, language, platform, app_version, first_open_at)
                 VALUES (?, ?, ?, ?, ?, ?)'
            );
            $stmt->execute([
                $userId,
                $anonymous_id,
                $language    !== '' ? $language    : null,
                $platform    !== '' ? $platform    : null,
                $app_version !== '' ? $app_version : null,
                $firstOpenSql,
            ]);

            $convId = ensure_open_conversation($pdo, $userId);

            $pdo->commit();
        } catch (PDOException $e) {
            $pdo->rollBack();
            throw $e;
        }
    }

    // ── 3. JWT so the WebSocket auth path accepts the connection. ────
    $token = generateAccessToken($userId, $email, $displayName);

    jsonResponse(true, [
        'mitgliedernummer' => $mitgliedernummer,
        'name'             => $displayName,
        'token'            => $token,
        'conversation_id'  => $convId,
    ], 'Anonymous session ready');

} catch (PDOException $e) {
    error_log('[anonymous_chat/init] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Server error');
}

// --------------------------------------------------------------------------
// helpers
// --------------------------------------------------------------------------

/**
 * Derive an 8-char hex token from the anonymous_id. The id itself is
 * already random + alphanumeric, so a hash of it gives us a stable
 * deterministic suffix that fits the existing mitgliedernummer shape.
 */
function anonymous_short_token(string $anonymous_id): string {
    $hash = hash('sha256', $anonymous_id);
    return strtoupper(substr($hash, 0, 8));
}

/**
 * Return the id of the visitor's current open conversation, creating one
 * if it doesn't exist. Closed conversations stay around for audit but a
 * returning visitor always gets a fresh open thread to chat on.
 */
function ensure_open_conversation(PDO $pdo, int $userId): int {
    $stmt = $pdo->prepare(
        'SELECT id FROM chat_conversations
         WHERE member_id = ? AND status = "open"
         ORDER BY id DESC LIMIT 1'
    );
    $stmt->execute([$userId]);
    $row = $stmt->fetch();
    if ($row) return (int)$row['id'];

    $stmt = $pdo->prepare(
        'INSERT INTO chat_conversations
           (member_id, admin_id, subject, status, admin_initiated)
         VALUES (?, NULL, "Anonymous chat", "open", 0)'
    );
    $stmt->execute([$userId]);
    return (int)$pdo->lastInsertId();
}
