<?php
define('API_ACCESS', true);
require_once '../config.php';
blockBrowserAccess();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    jsonResponse(false, [], 'Method not allowed');
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input || !isset($input['device_key'])) {
    http_response_code(400);
    jsonResponse(false, [], 'Missing device_key');
}

try {
    $pdo = getDBConnection();
    $stmt = $pdo->prepare('SELECT id, device_id, device_name, platform, is_active, revoked_at FROM device_keys WHERE device_key = ?');
    $stmt->execute([trim($input['device_key'])]);
    $device = $stmt->fetch();

    if (!$device) { http_response_code(401); jsonResponse(false, [], 'Invalid device key'); }
    if (!$device['is_active'] || $device['revoked_at'] !== null) { http_response_code(403); jsonResponse(false, [], 'Device has been revoked'); }

    $boolFields = ['is_rooted','disk_encrypted','firewall_active','is_vpn','os_up_to_date'];
    // screen_*/text_scale: display size and system font size. Sent on every
    // validate, so the value follows when a member changes the setting later
    // instead of freezing at whatever it was at install time.
    $allFields = ['app_version','device_type','is_rooted','os_version','disk_encrypted','firewall_active',
                   'battery_level','battery_state','connection_type','is_vpn','disk_total_gb','disk_free_gb',
                   'smart_status','os_up_to_date','os_updates_count',
                   'screen_width_dp','screen_height_dp','device_pixel_ratio','text_scale'];
    $sets = ['last_used_at = NOW()'];
    $params = [];

    foreach ($allFields as $f) {
        if (isset($input[$f])) {
            $sets[] = "$f = ?";
            $params[] = in_array($f, $boolFields) ? ($input[$f] ? 1 : 0) : $input[$f];
        }
    }
    $params[] = $device['id'];

    $stmt = $pdo->prepare('UPDATE device_keys SET ' . implode(', ', $sets) . ' WHERE id = ?');
    $stmt->execute($params);

    jsonResponse(true, ['valid' => true, 'device_id' => $device['device_id'], 'device_name' => $device['device_name'], 'platform' => $device['platform']]);
} catch (PDOException $e) {
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}
