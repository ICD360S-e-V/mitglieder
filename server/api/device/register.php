<?php
/**
 * API Endpoint: Device Registration
 * URL: https://icd360sev.icd360s.de/api/device/register.php
 * Method: POST
 *
 * Generează un device_key unic pentru fiecare instalare
 */

define("API_ACCESS", true);
require_once "../config.php";

blockBrowserAccess();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    http_response_code(405);
    jsonResponse(false, [], "Method not allowed");
}

$input = json_decode(file_get_contents("php://input"), true);

if (!$input || !isset($input["device_id"])) {
    http_response_code(400);
    jsonResponse(false, [], "Missing device_id");
}

$deviceId = trim($input["device_id"]);
$deviceName = isset($input["device_name"]) ? trim($input["device_name"]) : null;
$platform = isset($input["platform"]) ? trim($input["platform"]) : null;
$appVersion = isset($input["app_version"]) ? trim($input["app_version"]) : null;
$deviceType = isset($input["device_type"]) ? trim($input["device_type"]) : "unknown";
$isRooted = isset($input["is_rooted"]) ? ($input["is_rooted"] ? 1 : 0) : null;
$osVersion = isset($input["os_version"]) ? trim($input["os_version"]) : null;

// Extended device data
$batteryLevel = isset($input["battery_level"]) ? intval($input["battery_level"]) : null;
$batteryState = isset($input["battery_state"]) ? trim($input["battery_state"]) : null;
$connectionType = isset($input["connection_type"]) ? trim($input["connection_type"]) : null;
$isVpn = isset($input["is_vpn"]) ? ($input["is_vpn"] ? 1 : 0) : null;
$diskTotalGb = isset($input["disk_total_gb"]) ? floatval($input["disk_total_gb"]) : null;
$diskFreeGb = isset($input["disk_free_gb"]) ? floatval($input["disk_free_gb"]) : null;
$diskEncrypted = isset($input["disk_encrypted"]) ? ($input["disk_encrypted"] ? 1 : 0) : null;
$firewallActive = isset($input["firewall_active"]) ? ($input["firewall_active"] ? 1 : 0) : null;

// Display + accessibility. Without these, a report like "the app looks broken
// on my phone" is guesswork: the model name gives the resolution, not how the
// member has set the device up — and that setting is the difference.
// text_scale is the system font size (1.0 default, 2.0 the largest step in the
// Android accessibility settings); screen_*_dp is the logical size the app
// actually gets, which is where the separate display-size setting shows up.
$screenWidthDp = isset($input["screen_width_dp"]) ? intval($input["screen_width_dp"]) : null;
$screenHeightDp = isset($input["screen_height_dp"]) ? intval($input["screen_height_dp"]) : null;
$devicePixelRatio = isset($input["device_pixel_ratio"]) ? floatval($input["device_pixel_ratio"]) : null;
$textScale = isset($input["text_scale"]) ? floatval($input["text_scale"]) : null;

if (!in_array($deviceType, ["phone", "tablet", "desktop", "unknown"])) {
    $deviceType = "unknown";
}

if (strlen($deviceId) < 16) {
    http_response_code(400);
    jsonResponse(false, [], "Invalid device_id");
}

try {
    $pdo = getDBConnection();

    $stmt = $pdo->prepare("SELECT device_key, is_active, revoked_at FROM device_keys WHERE device_id = ?");
    $stmt->execute([$deviceId]);
    $existing = $stmt->fetch();

    if ($existing) {
        if (!$existing["is_active"] || $existing["revoked_at"] !== null) {
            http_response_code(403);
            jsonResponse(false, [], "Device has been revoked");
        }

        // Update ALL fields including extended data
        $sets = ["last_used_at = NOW()"];
        $params = [];

        $updateFields = [
            "app_version" => $appVersion,
            "device_type" => $deviceType,
            "is_rooted" => $isRooted,
            "os_version" => $osVersion,
            "battery_level" => $batteryLevel,
            "battery_state" => $batteryState,
            "connection_type" => $connectionType,
            "is_vpn" => $isVpn,
            "disk_total_gb" => $diskTotalGb,
            "disk_free_gb" => $diskFreeGb,
            "disk_encrypted" => $diskEncrypted,
            "firewall_active" => $firewallActive,
            "screen_width_dp" => $screenWidthDp,
            "screen_height_dp" => $screenHeightDp,
            "device_pixel_ratio" => $devicePixelRatio,
            "text_scale" => $textScale,
        ];

        foreach ($updateFields as $field => $value) {
            if ($value !== null) {
                $sets[] = "$field = ?";
                $params[] = $value;
            }
        }

        $params[] = $deviceId;
        $stmt = $pdo->prepare("UPDATE device_keys SET " . implode(", ", $sets) . " WHERE device_id = ?");
        $stmt->execute($params);

        jsonResponse(true, [
            "device_key" => $existing["device_key"],
            "message" => "Device already registered"
        ]);
    }

    // Generate new device key
    $deviceKey = bin2hex(random_bytes(32));

    $stmt = $pdo->prepare("
        INSERT INTO device_keys (device_key, device_id, device_name, platform, device_type, is_rooted, os_version, app_version,
            battery_level, battery_state, connection_type, is_vpn, disk_total_gb, disk_free_gb, disk_encrypted, firewall_active,
            screen_width_dp, screen_height_dp, device_pixel_ratio, text_scale,
            created_at, last_used_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())
    ");
    $stmt->execute([
        $deviceKey, $deviceId, $deviceName, $platform, $deviceType, $isRooted, $osVersion, $appVersion,
        $batteryLevel, $batteryState, $connectionType, $isVpn, $diskTotalGb, $diskFreeGb, $diskEncrypted, $firewallActive,
        $screenWidthDp, $screenHeightDp, $devicePixelRatio, $textScale
    ]);

    jsonResponse(true, [
        "device_key" => $deviceKey,
        "message" => "Device registered successfully"
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    jsonResponse(false, [], "Database error");
}
