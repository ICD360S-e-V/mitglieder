<?php
/**
 * API Endpoint: Refresh Token
 * URL: https://icd360sev.icd360s.de/api/auth/refresh.php
 * Method: POST
 *
 * Body JSON:
 * {
 *   "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
 * }
 *
 * Folosit pentru a obține un nou access_token fără a cere parola
 * refresh_token este valid 30 zile
 * access_token nou este valid 1 oră
 */

define('API_ACCESS', true);
require_once '../config.php';

// Verifică API Key
validateApiKey();

// Blochează accesul din browser
blockBrowserAccess();

// Acceptă doar POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    jsonResponse(false, [], 'Method not allowed');
}

// Citește datele JSON din request
$input = json_decode(file_get_contents('php://input'), true);

// Validare input
if (!isset($input['refresh_token'])) {
    http_response_code(400);
    jsonResponse(false, [], 'Missing refresh_token');
}

$refreshToken = $input['refresh_token'];

// Validează refresh_token-ul
$payload = validateJWT($refreshToken);

if ($payload === false) {
    http_response_code(401);
    jsonResponse(false, [], 'Invalid or expired refresh token. Please login again.');
}

// Verifică că este un refresh token, nu un access token
if (!isset($payload['type']) || $payload['type'] !== 'refresh') {
    http_response_code(401);
    jsonResponse(false, [], 'Invalid token type. Expected refresh token.');
}

try {
    $pdo = getDBConnection();

    // Găsește user-ul după userId din token
    $stmt = $pdo->prepare('SELECT id, mitgliedernummer, email, name FROM users WHERE id = ?');
    $stmt->execute([$payload['userId']]);
    $user = $stmt->fetch();

    if (!$user) {
        http_response_code(401);
        jsonResponse(false, [], 'User not found');
    }

    // Geraeteschluessel an dieses Konto binden, falls er noch keinem gehoert.
    //
    // Ein Geraeteschluessel weist ein GERAET aus, keine Person. Erst die
    // Verbindung zu einem Konto macht daraus einen Identitaetsnachweis, auf den
    // sich ein Endpunkt stuetzen kann.
    //
    // Gebunden wurde bisher NUR beim ausdruecklichen Anmelden. Wer angemeldet
    // bleibt und nur noch Zugangstoken erneuert, kam dort nie wieder vorbei:
    // 27 der 61 aktiven Schluessel tragen deshalb gar keine user_id, sechs
    // davon in den letzten 30 Tagen benutzt. Das heilt nicht von selbst --
    // genau deswegen steht die Zeile hier.
    //
    // Dieselbe Regel wie in login_vorsitzer.php: NUR fuellen, was leer ist.
    // Ein Schluessel, der schon einem anderen Konto gehoert, wird nicht
    // uebernommen -- sonst koennte ein zweiter Nutzer auf demselben Geraet die
    // Zuordnung an sich ziehen.
    $kopfzeilen = array_change_key_case(getallheaders(), CASE_LOWER);
    $geraeteschluessel = trim((string)($kopfzeilen['x-device-key'] ?? ''));

    if ($geraeteschluessel !== '') {
        try {
            $pdo->prepare(
                'UPDATE device_keys SET user_id = ?
                  WHERE device_key = ? AND user_id IS NULL'
            )->execute([(int)$user['id'], $geraeteschluessel]);
        } catch (Throwable $e) {
            // Eine misslungene Zuordnung darf die Token-Erneuerung nicht
            // aufhalten -- sonst waere das Nebenziel wichtiger als der Zweck
            // des Endpunkts.
            error_log('refresh: Geraetebindung fehlgeschlagen: ' . $e->getMessage());
        }
    }

    // Generează nou access_token (1 oră)
    $newAccessToken = generateAccessToken($user['id'], $user['email'], $user['name']);

    // Răspuns success cu noul access_token
    http_response_code(200);
    jsonResponse(true, [
        'token' => $newAccessToken,
        'expires_in' => ACCESS_TOKEN_EXPIRY,
        'user' => [
            'id' => $user['id'],
            'mitgliedernummer' => $user['mitgliedernummer'],
            'email' => $user['email'],
            'name' => $user['name']
        ]
    ], 'Token refreshed successfully');

} catch (PDOException $e) {
    http_response_code(500);
    jsonResponse(false, [], 'Token refresh failed');
}
