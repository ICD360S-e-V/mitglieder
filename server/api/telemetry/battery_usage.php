<?php
/**
 * Battery Usage Reporting Endpoint
 *
 * Nimmt Messfenster von Clients entgegen: wie schnell sich das Gerät entladen
 * hat, während die App lief, und was die App in demselben Fenster getan hat.
 *
 * Was hier NICHT ankommt, ist der Akkuverbrauch der App allein — keine
 * Plattform gibt einer normalen App diese Zuordnung heraus. Gemessen wird die
 * Entladerate des Geräts plus unsere eigenen Verursacherzähler; belastbar wird
 * daraus erst der Vergleich zweier Zeiträume am selben Gerät. Details in
 * migrations/2026_08_30_battery_usage.sql.
 *
 * Auth: device key (X-Device-Key header).
 *
 * Bewusst OHNE Mitgliedernummer — anders als tls_failure.php, das sie führt.
 * Dort trägt sie einen Sicherheitsvorfall einer Person zu, hier trüge sie
 * nichts bei: eine Entladerate ist nur im Vergleich EINES Geräts mit sich
 * selbst aussagekräftig, wofür die device_id genügt. Der Zustimmungsdialog
 * sagt Mitgliedern ausserdem wörtlich einen „anonymen Gerätecode (NICHT die
 * Mitgliedsnummer)" zu. Ein Client, der das Feld trotzdem schickt, wird hier
 * ignoriert, nicht gespeichert.
 *
 * Auto-routes to test DB when this file is invoked as *_test.php — mirrors
 * the convention of server/api/security/tls_failure.php so staging and prod
 * share the exact code path.
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
    error_log('[battery_usage] DB connect failed: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'db_unavailable']);
    exit;
}

// --- Payload ---------------------------------------------------------------
$raw  = file_get_contents('php://input');
$data = json_decode($raw, true);
if (!is_array($data) || !isset($data['device_id']) || !isset($data['segments']) || !is_array($data['segments'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'invalid_payload']);
    exit;
}

$deviceId     = substr((string)$data['device_id'], 0, 64);
$platform     = isset($data['platform'])         ? substr((string)$data['platform'], 0, 20)         : null;
$osVersion    = isset($data['os_version'])       ? substr((string)$data['os_version'], 0, 120)      : null;
$appVersion   = isset($data['app_version'])      ? substr((string)$data['app_version'], 0, 20)      : null;

$segments = $data['segments'];
if (count($segments) === 0) {
    echo json_encode(['success' => true, 'inserted' => 0, 'duplicates' => 0, 'rejected' => 0]);
    exit;
}
if (count($segments) > 200) {
    http_response_code(413);
    echo json_encode(['success' => false, 'error' => 'too_many_segments']);
    exit;
}

/**
 * Akkustand in Prozent. Ausserhalb 0..100 ist ein Treiberfehler, kein Messwert.
 */
function bu_battery_level_or_null($v): ?int
{
    if (!is_numeric($v)) return null;
    $i = (int)$v;
    return ($i < 0 || $i > 100) ? null : $i;
}

/**
 * Ladungszähler in µAh. Nur Android liefert ihn; 0 oder negativ heisst „nicht
 * implementiert" und wird zu NULL, damit avg_ma nicht mit Unsinn rechnet.
 */
function bu_charge_counter_or_null($v): ?int
{
    if (!is_numeric($v)) return null;
    $i = (int)$v;
    return $i > 0 ? $i : null;
}

/**
 * Nichtnegative Dauer bzw. Zähler mit Deckel. Ein Client, der eine absurde
 * Zahl meldet, ist defekt oder feindlich; beides darf keinen Mittelwert
 * kaputtmachen, den später jemand für bare Münze nimmt.
 */
function bu_bounded_int($v, int $max): int
{
    if (!is_numeric($v)) return 0;
    $i = (int)$v;
    if ($i < 0) return 0;
    return $i > $max ? $max : $i;
}

/**
 * Aufschlüsselung der Netzanfragen nach Verursacher.
 *
 * Der Client schickt {"heartbeat":60,"ticketPoll":4,...}. Gefiltert wird gegen
 * eine feste Namensliste: der Wert wandert als JSON in die Datenbank, und ein
 * Client, der beliebige Schlüssel setzen dürfte, könnte sie beliebig aufblähen.
 * Unbekannte Namen werden still verworfen — sie stammen entweder aus einer
 * neueren App-Version, die dieser Server noch nicht kennt, oder sie gehören
 * nicht hierher; in beiden Fällen ist Weglassen richtig.
 *
 * Rückgabe null, wenn nichts Verwertbares übrig bleibt: dann bleibt die Spalte
 * NULL statt ein leeres Objekt zu speichern, das sich in Auswertungen nicht
 * von "keine Anfragen" unterscheiden liesse.
 */
function bu_requests_by_source_or_null($v): ?string
{
    static $erlaubt = [
        'heartbeat', 'ticketPoll', 'logUpload', 'diagnostic',
        'deviceData', 'ntfy', 'api',
    ];
    if (!is_array($v)) return null;
    $out = [];
    foreach ($erlaubt as $name) {
        if (!isset($v[$name]) || !is_numeric($v[$name])) continue;
        $n = (int)$v[$name];
        if ($n <= 0 || $n > BU_MAX_COUNTER) continue;
        $out[$name] = $n;
    }
    if ($out === []) return null;
    return json_encode($out, JSON_UNESCAPED_SLASHES);
}

/** Datumsformat des Clients: `YYYY-MM-DD HH:MM:SS` in UTC. */
function bu_utc_datetime_or_null($v): ?string
{
    if (!is_string($v)) return null;
    $s = str_replace('T', ' ', trim($v));
    $s = preg_replace('/Z$/', '', $s);
    $dt = DateTime::createFromFormat('Y-m-d H:i:s', $s, new DateTimeZone('UTC'));
    if (!$dt) return null;
    // createFromFormat rollt Unmögliches still um: aus "2026-13-45 00:00:00"
    // wird klaglos 2027-01-14. Nur wenn sich der Wert unverändert zurück-
    // formatieren lässt, war die Eingabe tatsächlich ein gültiges Datum.
    if ($dt->format('Y-m-d H:i:s') !== $s) return null;
    // Zukunft ist keine Messung. Eine Stunde Toleranz für Uhren, die leicht
    // vorgehen; alles darüber ist eine verstellte Uhr und damit unbrauchbar.
    if ($dt->getTimestamp() > time() + 3600) return null;
    return $dt->format('Y-m-d H:i:s');
}

// 30 Tage in ms — grosszügig über der maxDuration des Clients (6 h), aber weit
// unter allem, was ein Rechenfehler produzieren würde.
const BU_MAX_DURATION_MS = 2592000000;
const BU_MAX_COUNTER     = 1000000;

$allowedCloseReasons = ['charging', 'stopped', 'rollover', 'gap'];

$sql = 'INSERT INTO battery_usage_segments
    (device_id, reported_at, started_at, ended_at, duration_ms,
     start_level, end_level, start_charge_uah, end_charge_uah,
     foreground_ms, background_ms,
     network_requests, requests_by_source, ws_reconnects, push_wakeups,
     is_reliable, closed_reason, connection_type,
     power_save_mode, standby_bucket, doze_exempt, thermal_status,
     app_version, platform, os_version)
    VALUES
    (?, NOW(), ?, ?, ?,
     ?, ?, ?, ?,
     ?, ?,
     ?, ?, ?, ?,
     ?, ?, ?,
     ?, ?, ?, ?,
     ?, ?, ?)
    ON DUPLICATE KEY UPDATE id = id';

$stmt       = $pdo->prepare($sql);
$inserted   = 0;
$duplicates = 0;
$rejected   = 0;

foreach ($segments as $s) {
    if (!is_array($s)) {
        $rejected++;
        continue;
    }

    $startedAt  = bu_utc_datetime_or_null($s['started_at'] ?? null);
    $endedAt    = bu_utc_datetime_or_null($s['ended_at'] ?? null);
    $startLevel = bu_battery_level_or_null($s['start_level'] ?? null);
    $endLevel   = bu_battery_level_or_null($s['end_level'] ?? null);

    if ($startedAt === null || $endedAt === null || $startLevel === null || $endLevel === null) {
        $rejected++;
        continue;
    }
    // Ein Fenster, das vor seinem Anfang endet, ist keine Messung.
    if ($endedAt < $startedAt) {
        $rejected++;
        continue;
    }

    $durationMs = bu_bounded_int($s['duration_ms'] ?? 0, BU_MAX_DURATION_MS);
    if ($durationMs === 0) {
        $rejected++;
        continue;
    }

    $closeReason = isset($s['closed_reason']) ? (string)$s['closed_reason'] : 'stopped';
    if (!in_array($closeReason, $allowedCloseReasons, true)) {
        $closeReason = 'stopped';
    }

    try {
        $stmt->execute([
            $deviceId,
            $startedAt,
            $endedAt,
            $durationMs,
            $startLevel,
            $endLevel,
            bu_charge_counter_or_null($s['start_charge_uah'] ?? null),
            bu_charge_counter_or_null($s['end_charge_uah'] ?? null),
            bu_bounded_int($s['foreground_ms'] ?? 0, BU_MAX_DURATION_MS),
            bu_bounded_int($s['background_ms'] ?? 0, BU_MAX_DURATION_MS),
            bu_bounded_int($s['network_requests'] ?? 0, BU_MAX_COUNTER),
            bu_requests_by_source_or_null($s['requests_by_source'] ?? null),
            bu_bounded_int($s['ws_reconnects'] ?? 0, BU_MAX_COUNTER),
            bu_bounded_int($s['push_wakeups'] ?? 0, BU_MAX_COUNTER),
            !empty($s['is_reliable']) ? 1 : 0,
            $closeReason,
            isset($s['connection_type']) ? substr((string)$s['connection_type'], 0, 16) : null,
            isset($s['power_save_mode']) ? (!empty($s['power_save_mode']) ? 1 : 0) : null,
            isset($s['standby_bucket']) && is_numeric($s['standby_bucket']) ? (int)$s['standby_bucket'] : null,
            isset($s['doze_exempt']) ? (!empty($s['doze_exempt']) ? 1 : 0) : null,
            isset($s['thermal_status']) && is_numeric($s['thermal_status']) ? (int)$s['thermal_status'] : null,
            $appVersion,
            $platform,
            $osVersion,
        ]);

        // rowCount() ist 1 bei einem echten INSERT und 0, wenn der
        // UNIQUE-Schlüssel gegriffen hat — also bei einem Client, der einen
        // Batch nach verlorener Antwort erneut sendet. Das ist der Normalfall
        // und kein Fehler.
        if ($stmt->rowCount() > 0) {
            $inserted++;
        } else {
            $duplicates++;
        }
    } catch (PDOException $ex) {
        error_log('[battery_usage] insert failed: ' . $ex->getMessage());
        $rejected++;
    }
}

echo json_encode([
    'success'    => true,
    'inserted'   => $inserted,
    'duplicates' => $duplicates,
    'rejected'   => $rejected,
    'env'        => $isTest ? 'staging' : 'prod',
]);
