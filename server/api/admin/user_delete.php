<?php
/**
 * API Endpoint: Delete User (Admin Only)
 * URL: https://icd360sev.icd360s.de/api/admin/user_delete.php
 * Method: POST
 * Body: {"user_id": 1}
 * Auth: JWT Token (role: vorsitzer)
 */

define("API_ACCESS", true);
require_once "../config.php";

validateApiKey();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    http_response_code(405);
    jsonResponse(false, [], "Method not allowed");
}

$headers = array_change_key_case(getallheaders(), CASE_LOWER);
$authHeader = isset($headers["authorization"]) ? $headers["authorization"] : "";

if (empty($authHeader) || !preg_match("/Bearer\s+(.+)/i", $authHeader, $matches)) {
    http_response_code(401);
    jsonResponse(false, [], "Missing or invalid Authorization header");
}

$token = $matches[1];
$payload = validateJWT($token);

if (!$payload) {
    http_response_code(401);
    jsonResponse(false, [], "Invalid or expired token");
}

$input = json_decode(file_get_contents("php://input"), true);

if (!isset($input["user_id"])) {
    http_response_code(400);
    jsonResponse(false, [], "Missing required field: user_id");
}

$userId = (int)$input["user_id"];

try {
    $pdo = getDBConnection();
    
    // Verifică că user-ul curent este vorsitzer
    $stmt = $pdo->prepare("SELECT role FROM users WHERE id = ?");
    $stmt->execute([$payload["userId"]]);
    $currentUser = $stmt->fetch();
    
    if (!$currentUser || $currentUser["role"] !== "vorsitzer") {
        http_response_code(403);
        jsonResponse(false, [], "Access denied. Vorsitzer role required.");
    }
    
    // Nu permite ștergerea propriului cont
    if ($userId === (int)$payload["userId"]) {
        http_response_code(400);
        jsonResponse(false, [], "Cannot delete your own account");
    }
    
    // Verifică că user-ul țintă există și nu e vorsitzer
    $stmt = $pdo->prepare("SELECT id, mitgliedernummer, name, role FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $targetUser = $stmt->fetch();
    
    if (!$targetUser) {
        http_response_code(404);
        jsonResponse(false, [], "User not found");
    }
    
    if ($targetUser["role"] === "vorsitzer") {
        http_response_code(403);
        jsonResponse(false, [], "Cannot delete a Vorsitzer account");
    }
    
    // Unterschriften sind Beweise und dürfen nicht als Nebenwirkung verschwinden.
    //
    // Bis zur Migration 2026_08_11_signaturen_nicht_mitloeschen.sql stand der
    // Fremdschlüssel auf ON DELETE CASCADE: ein Klick hier nahm sämtliche
    // Unterschriften dieses Menschen mit, lautlos, und riss dabei Glieder aus
    // der Hash-Kette. Jetzt weist die Datenbank das Löschen ab (Fehler 1451).
    //
    // Die Abfrage steht trotzdem hier davor, damit der Vorsitzende erfährt,
    // WORAN es liegt. Ein "Database error" hätte ihn ratlos zurückgelassen —
    // und die naheliegende Reaktion darauf wäre gewesen, es noch einmal zu
    // versuchen.
    $stmt = $pdo->prepare(
        "SELECT COUNT(*) FROM dokument_signaturen WHERE user_id = ?"
    );
    $stmt->execute([$userId]);
    $unterschriften = (int)$stmt->fetchColumn();

    if ($unterschriften > 0) {
        http_response_code(409);
        jsonResponse(false, [
            "grund" => "unterschriften_vorhanden",
            "anzahl" => $unterschriften,
        ], "Dieses Mitglied hat {$unterschriften} digitale Unterschrift(en). "
         . "Sie sind Beweisdokumente und werden nicht mitgelöscht. "
         . "Für ein Löschbegehren nach DSGVO ist die Anonymisierung vorgesehen, "
         . "die den Namen entfernt und die Unterschriften bestehen lässt.");
    }

    // Șterge user-ul
    $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    
    http_response_code(200);
    jsonResponse(true, [
        "deleted_user_id" => $userId,
        "deleted_mitgliedernummer" => $targetUser["mitgliedernummer"]
    ], "User deleted successfully");
    
} catch (PDOException $e) {
    // 1451: eine Fremdschlüsselbeziehung verhindert das Löschen. Die Abfrage
    // oben fängt den bekannten Fall ab; hier bleibt der Rest — irgendeine
    // andere Tabelle hängt noch an diesem Konto. Auch das ist kein
    // "Database error", sondern eine Auskunft.
    if (($e->errorInfo[1] ?? null) === 1451) {
        error_log('user_delete: 1451 fuer user ' . $userId . ' — ' . $e->getMessage());
        http_response_code(409);
        jsonResponse(false, ["grund" => "abhaengige_daten"],
            "Zu diesem Mitglied gehören noch Daten, die nicht mitgelöscht werden dürfen. "
          . "Das Konto bleibt bestehen.");
    }

    error_log('user_delete: ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], "Database error");
}
