<?php
/**
 * Log Storage Endpoint - Mitglieder Windows
 * Hybrid: encrypted startup transcripts AND legacy plain Flutter logs.
 *   - {v:1, iv, data}  → AES-256-GCM startup transcript → mitglieder_windows/YYYY-MM-DD.log
 *   - {mitgliedernummer, logs[...]} → legacy plain text → mitglieder_windows/<mn>_YYYY-MM-DD.log
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit; }
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'Method not allowed']);
    exit;
}

$input = file_get_contents('php://input');
$data  = json_decode($input, true);

// ===== ENCRYPTED STARTUP PATH =====
if ($data && ($data['v'] ?? 0) === 1 && !empty($data['iv']) && !empty($data['data'])) {
    $keyHex = getenv('MITGLIEDER_STARTUP_DIAG_KEY');
    if (!$keyHex || strlen($keyHex) !== 64) { http_response_code(500); echo json_encode(['ok'=>false,'error'=>'key not configured']); exit; }
    $key    = hex2bin($keyHex);
    $iv     = base64_decode($data['iv']);
    $packed = base64_decode($data['data']);
    if (strlen($packed) < 16) { http_response_code(400); echo json_encode(['ok'=>false,'error'=>'short packed']); exit; }
    $tag    = substr($packed, -16);
    $cipher = substr($packed, 0, -16);
    $plain  = openssl_decrypt($cipher, 'aes-256-gcm', $key, OPENSSL_RAW_DATA, $iv, $tag);
    if ($plain === false) { http_response_code(400); echo json_encode(['ok'=>false,'error'=>'decrypt failed']); exit; }
    $payload = json_decode($plain, true);
    if (!$payload) { http_response_code(400); echo json_encode(['ok'=>false,'error'=>'bad payload']); exit; }

    $dir  = __DIR__ . '/../data/logs/mitglieder_windows';
    @mkdir($dir, 0750, true);
    $file = $dir . '/' . date('Y-m-d') . '.log';
    $line = json_encode([
        'ts'               => date('c'),
        'platform'         => $payload['platform'] ?? 'unknown',
        'app_version'      => $payload['app_version'] ?? 'unknown',
        'device_id'        => $payload['device_id'] ?? 'unknown',
        'mitgliedernummer' => $payload['mitgliedernummer'] ?? '',
        'remote_ip'        => $_SERVER['REMOTE_ADDR'] ?? '',
        'level'            => $payload['logs'][0]['level'] ?? 'info',
        'transcript'       => $payload['logs'][0]['message'] ?? '',
    ]) . "\n";
    if (file_put_contents($file, $line, FILE_APPEND | LOCK_EX) === false) {
        http_response_code(500);
        echo json_encode(['ok'=>false,'error'=>'write failed']);
        exit;
    }
    echo json_encode(['ok' => true]);
    exit;
}

// ===== PLAIN LOGGER PATH (legacy LoggerService) =====
if (!$data || !isset($data['mitgliedernummer']) || !isset($data['logs'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Invalid payload']);
    exit;
}

$mitgliedernummer = $data['mitgliedernummer'];
// SECURITY: this value is interpolated into a log file path below and arrives
// from an unauthenticated public endpoint. Without this check a caller can
// supply "../.." and write outside $logsDir. Whitelist, and reject loudly:
// silently rewriting a bad value would hide both broken clients and attacks.
if (!is_string($mitgliedernummer) || !preg_match("/^[A-Za-z0-9_-]{1,64}$/", $mitgliedernummer)) {
    http_response_code(400);
    echo json_encode(["success" => false, "error" => "Invalid mitgliedernummer"]);
    exit;
}
$deviceId         = $data['device_id'] ?? 'unknown';
$platform         = $data['platform'] ?? 'unknown';
$logs             = $data['logs'];

$logsDir = __DIR__ . '/../../logs/mitglieder_windows';
if (!is_dir($logsDir)) { mkdir($logsDir, 0755, true); }

$date     = date('Y-m-d');
$filename = "$logsDir/{$mitgliedernummer}_$date.log";

$logContent = '';
foreach ($logs as $log) {
    $timestamp = $log['timestamp'] ?? date('c');
    $message   = $log['message'] ?? '';
    $level     = strtoupper($log['level'] ?? 'INFO');
    $tag       = $log['tag'] ?? 'APP';
    $logContent .= "[$timestamp] [$level] [$tag] $message\n";
}
file_put_contents($filename, $logContent, FILE_APPEND | LOCK_EX);

$metaFile = "$logsDir/metadata.json";
$metadata = [];
if (file_exists($metaFile)) { $metadata = json_decode(file_get_contents($metaFile), true) ?: []; }
$metadata[$mitgliedernummer] = [
    'last_upload'      => date('c'),
    'device_id'        => $deviceId,
    'platform'         => $platform,
    'total_logs_today' => count($logs),
];
file_put_contents($metaFile, json_encode($metadata, JSON_PRETTY_PRINT));

echo json_encode([
    'success'    => true,
    'logs_saved' => count($logs),
    'file'       => basename($filename),
]);
