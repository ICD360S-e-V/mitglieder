<?php
/**
 * TLS Failure Reporting Endpoint
 *
 * Receives batched reports from clients whose TLS handshake (certificate
 * pinning) failed against icd360sev.icd360s.de. Used to detect MITM attempts,
 * hostile networks, and AV/proxy products intercepting our users.
 *
 * Auth: device key (X-Device-Key header). Member identification is optional.
 *
 * Auto-routes to test DB when this file is invoked as *_test.php — that lets
 * staging share the exact code path as production.
 */

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, X-Device-Key');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

blockBrowserAccess();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'method_not_allowed']);
    exit;
}

// --- Auth: device key ------------------------------------------------------
$deviceKey = $_SERVER['HTTP_X_DEVICE_KEY'] ?? '';
if ($deviceKey === '' || !validateDeviceKey($deviceKey)) {
    http_response_code(401);
    echo json_encode(['success' => false, 'error' => 'invalid_device_key']);
    exit;
}

// --- DB target: prod by default, staging when invoked as *_test.php --------
$isTest = strpos(basename(__FILE__), '_test') !== false;
$targetDb = $isTest ? 'icd360sev_test_db' : DB_NAME;

try {
    $dsn = 'mysql:unix_socket=/var/lib/mysql/mysql.sock;dbname=' . $targetDb . ';charset=utf8mb4';
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ]);
} catch (PDOException $e) {
    error_log('[tls_failure] DB connect failed: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'db_unavailable']);
    exit;
}

// --- Payload ---------------------------------------------------------------
$raw = file_get_contents('php://input');
$data = json_decode($raw, true);
if (!is_array($data) || !isset($data['device_id']) || !isset($data['events']) || !is_array($data['events'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'invalid_payload']);
    exit;
}

$deviceId        = substr((string)$data['device_id'], 0, 64);
$mitgliedernr    = isset($data['mitgliedernummer']) ? substr((string)$data['mitgliedernummer'], 0, 20) : null;
$platform        = isset($data['platform'])         ? substr((string)$data['platform'], 0, 20)        : null;
$osVersion       = isset($data['os_version'])       ? substr((string)$data['os_version'], 0, 50)      : null;
$appVersion      = isset($data['app_version'])      ? substr((string)$data['app_version'], 0, 20)     : null;
$userAgent       = isset($data['user_agent'])       ? substr((string)$data['user_agent'], 0, 255)     : null;

$events = $data['events'];
if (count($events) === 0) {
    echo json_encode(['success' => true, 'inserted' => 0]);
    exit;
}
if (count($events) > 200) {
    http_response_code(413);
    echo json_encode(['success' => false, 'error' => 'too_many_events']);
    exit;
}

// --- Insert batch ----------------------------------------------------------
$sql = 'INSERT INTO tls_failures
    (device_id, mitgliedernummer, reported_at, failed_at, first_seen, last_seen,
     occurrence_count, app_version, platform, os_version, user_agent,
     host, error_category, error_message,
     presented_subject, presented_issuer, presented_fingerprint,
     network_type, network_ssid, network_bssid, network_ssid_denied)
    VALUES
    (?, ?, NOW(), ?, ?, ?,
     ?, ?, ?, ?, ?,
     ?, ?, ?,
     ?, ?, ?,
     ?, ?, ?, ?)';

$stmt = $pdo->prepare($sql);
$inserted = 0;
$failed = 0;

foreach ($events as $e) {
    if (!is_array($e) || !isset($e['host']) || !isset($e['failed_at'])) {
        $failed++;
        continue;
    }

    try {
        $stmt->execute([
            $deviceId,
            $mitgliedernr,
            substr((string)$e['failed_at'], 0, 32),
            substr((string)($e['first_seen'] ?? $e['failed_at']), 0, 32),
            substr((string)($e['last_seen'] ?? $e['failed_at']), 0, 32),
            (int)($e['occurrence_count'] ?? 1),
            $appVersion,
            $platform,
            $osVersion,
            $userAgent,
            substr((string)$e['host'], 0, 255),
            isset($e['error_category'])      ? substr((string)$e['error_category'], 0, 32)      : null,
            isset($e['error_message'])       ? substr((string)$e['error_message'], 0, 2000)     : null,
            isset($e['presented_subject'])   ? substr((string)$e['presented_subject'], 0, 255)  : null,
            isset($e['presented_issuer'])    ? substr((string)$e['presented_issuer'], 0, 255)   : null,
            isset($e['presented_fingerprint'])? substr((string)$e['presented_fingerprint'], 0, 64) : null,
            isset($e['network_type'])        ? substr((string)$e['network_type'], 0, 16)        : null,
            isset($e['network_ssid'])        ? substr((string)$e['network_ssid'], 0, 64)        : null,
            isset($e['network_bssid'])       ? substr((string)$e['network_bssid'], 0, 32)       : null,
            !empty($e['network_ssid_denied']) ? 1 : 0,
        ]);
        $inserted++;
    } catch (PDOException $ex) {
        error_log('[tls_failure] insert failed: ' . $ex->getMessage());
        $failed++;
    }
}

echo json_encode([
    'success'  => true,
    'inserted' => $inserted,
    'failed'   => $failed,
    'env'      => $isTest ? 'staging' : 'prod',
]);
