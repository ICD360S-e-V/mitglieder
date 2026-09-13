<?php
/**
 * Gemeinsamer Rumpf der beiden Log-Endpunkte.
 *
 * mitglieder_android.php und mitglieder_windows.php waren Zeichen fuer Zeichen
 * dieselbe Datei, nur mit anderem Plattformnamen. Zwei Abschriften heisst: die
 * naechste Absicherung wird in einer davon vergessen, OHNE dass etwas
 * fehlschlaegt. Genau so entstand die Pfad-Traversierung, die in README.md
 * beschrieben ist — sie steckte in beiden.
 *
 * Beide Nutzlastformen bleiben unveraendert:
 *   {v:1, iv, data}          → AES-256-GCM-Startprotokoll aus StartupDiagnostics
 *   {mitgliedernummer, logs} → Klartextstrom aus LoggerService
 *
 * ⚠️ Die beiden Formen schreiben an VERSCHIEDENE Orte, und das bleibt so:
 * die verschluesselte Form nach `api/data/logs/<plattform>/`, die Klartextform
 * nach `<webroot>/logs/<plattform>/`. Das ist gewachsen, nicht gewollt — aber
 * ein Umzug verschiebt, wo die vorhandenen Protokolle liegen, und das ist eine
 * eigene Entscheidung, keine Nebenwirkung einer Absicherung.
 */

if (!defined('API_ACCESS')) {
    http_response_code(403);
    exit;
}

// ── Grenzen ────────────────────────────────────────────────────────────────
// Hergeleitet aus dem, was der Client tatsaechlich schickt, nicht geraten:
// LoggerService deckelt seine Warteschlange bei 500 Eintraegen
// (`_maxWarteschlange`, lib/services/logger_service.dart) und laedt hoechstens
// alle fuenf Minuten hoch (`_uploadInterval`, zugleich `_fehlerDrossel`).
// Wer mehr schickt, ist kein Client dieser App.
const LOG_INGEST_MAX_BYTES        = 524288;   // 512 KiB Rumpf
const LOG_INGEST_MAX_ENTRIES      = 500;      // = _maxWarteschlange
const LOG_INGEST_MAX_MESSAGE_LEN  = 8192;     // je Eintrag, danach gekuerzt
const LOG_INGEST_MAX_FILE_BYTES   = 52428800; // 50 MiB je Tagesdatei
const LOG_INGEST_WINDOW_SECONDS   = 600;      // Fenster der Drossel
const LOG_INGEST_MAX_PER_WINDOW   = 30;       // erwartet werden 2, siehe oben

// ⚠️ Der Schalter fuer die zweite Stufe. Solange er FALSE ist, werden Uploads
// ohne gueltigen X-Device-Key angenommen UND in php-fpm/error.log vermerkt:
//   grep 'log_ingest.*schluessellos' /var/log/php-fpm/error.log
// Erst wenn diese Zeile ueber mehrere Tage nicht mehr auftaucht, ist der ganze
// Bestand auf einer Fassung, die den Schluessel mitschickt — dann hier auf TRUE.
// Sofort TRUE zu setzen macht genau die Geraete stumm, deren Protokoll man
// braucht: ein Client, der nicht mehr aktualisiert, ist meistens der kaputte.
const LOG_INGEST_REQUIRE_DEVICE_KEY = false;

/**
 * Nimmt einen Upload entgegen und schreibt ihn weg. Endet immer mit exit.
 *
 * @param string $platform 'android' oder 'windows' — Teil des Zielverzeichnisses.
 */
function log_ingest_handle(string $platform): void
{
    header('Content-Type: application/json');

    // ⚠️ KEIN `Access-Control-Allow-Origin: *` mehr. Der Stern stand hier,
    // obwohl kein Browser diesen Endpunkt je aufruft — die App ist nativ.
    // Er lud jede fremde Webseite ein, den Endpunkt aus dem Browser ihrer
    // Besucher zu bedienen. Ohne CORS-Kopf scheitert schon der Vorabflug des
    // Browsers (Content-Type: application/json ist keine einfache Anfrage),
    // die Anfrage geht also gar nicht erst raus. Native Clients merken davon
    // nichts: CORS ist eine Browserregel.
    blockBrowserAccess();

    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
        http_response_code(405);
        echo json_encode(['success' => false, 'error' => 'Method not allowed']);
        exit;
    }

    // ── Rumpfgroesse VOR dem Parsen ────────────────────────────────────────
    // Ein Byte mehr als erlaubt wird gelesen, damit "genau am Limit" von
    // "darueber" unterscheidbar ist. json_decode auf einen unbegrenzten Rumpf
    // loszulassen hiesse, den Speicher vom Absender bestimmen zu lassen.
    $input = (string) file_get_contents('php://input', false, null, 0, LOG_INGEST_MAX_BYTES + 1);
    if (strlen($input) > LOG_INGEST_MAX_BYTES) {
        http_response_code(413);
        echo json_encode(['success' => false, 'error' => 'payload too large']);
        exit;
    }

    // ── Geraeteschluessel ──────────────────────────────────────────────────
    // Derselbe Schluessel, den telemetry/battery_usage.php und
    // security/tls_failure.php verlangen. Er ist kein starker Nachweis —
    // device/register.php gibt ihn ohne Anmeldung heraus — aber er macht aus
    // "jeder mit curl" ein "jeder, der sich vorher registriert", gibt jedem
    // Absender eine widerrufbare Kennung und ist der Griff, an dem die Drossel
    // unten zaehlt.
    $deviceKey = $_SERVER['HTTP_X_DEVICE_KEY'] ?? '';
    $keyOk     = is_string($deviceKey) && $deviceKey !== '' && validateDeviceKey($deviceKey);

    if (!$keyOk) {
        if (LOG_INGEST_REQUIRE_DEVICE_KEY) {
            http_response_code(401);
            echo json_encode(['success' => false, 'error' => 'invalid_device_key']);
            exit;
        }
        error_log(sprintf(
            '[log_ingest] schluessellos angenommen (Stufe 1) platform=%s ip=%s',
            $platform,
            $_SERVER['REMOTE_ADDR'] ?? '?'
        ));
    }

    // ── Drossel ────────────────────────────────────────────────────────────
    // Gezaehlt wird je Geraeteschluessel, und nur ersatzweise je IP: hinter
    // einem Mobilfunk-NAT teilen sich viele Mitglieder eine Adresse, eine
    // reine IP-Drossel wuerde sie gegenseitig aussperren.
    $identitaet = $keyOk ? 'k:' . $deviceKey : 'i:' . ($_SERVER['REMOTE_ADDR'] ?? '?');
    if (!log_ingest_drossel_erlaubt($identitaet)) {
        http_response_code(429);
        header('Retry-After: ' . LOG_INGEST_WINDOW_SECONDS);
        echo json_encode(['success' => false, 'error' => 'rate limited']);
        exit;
    }

    $data = json_decode($input, true);

    // ── Verschluesselte Startprotokolle ────────────────────────────────────
    if ($data && ($data['v'] ?? 0) === 1 && !empty($data['iv']) && !empty($data['data'])) {
        log_ingest_verschluesselt($platform, $data);
        exit;
    }

    log_ingest_klartext($platform, $data);
    exit;
}

/**
 * Fenster-Drossel auf Dateibasis.
 *
 * ⚠️ Der Zaehler liegt in sys_get_temp_dir(), NICHT unter dem Webwurzel-
 * verzeichnis: er darf nicht abrufbar sein, und er darf nicht auf derselben
 * Platte wachsen, die die Protokolle fuellen. Geht er beim Neustart verloren,
 * ist das kein Schaden — ein Fenster wird einmal neu gezaehlt.
 */
function log_ingest_drossel_erlaubt(string $identitaet): bool
{
    $dir = sys_get_temp_dir() . '/icd360sev_log_drossel';
    if (!is_dir($dir) && !@mkdir($dir, 0700, true) && !is_dir($dir)) {
        // Kein Zaehler moeglich — durchlassen statt aussperren. Die Drossel ist
        // Missbrauchsschutz, kein Tor: sie darf bei eigenem Versagen nicht die
        // Diagnose abschalten, die sie schuetzen soll.
        return true;
    }

    $datei = $dir . '/' . hash('sha256', $identitaet);
    $jetzt = time();

    $fh = @fopen($datei, 'c+');
    if ($fh === false) {
        return true;
    }
    if (!flock($fh, LOCK_EX)) {
        fclose($fh);
        return true;
    }

    $inhalt  = (string) stream_get_contents($fh);
    $teile   = explode(':', $inhalt, 2);
    $beginn  = isset($teile[0]) ? (int) $teile[0] : 0;
    $anzahl  = isset($teile[1]) ? (int) $teile[1] : 0;

    if ($beginn <= 0 || ($jetzt - $beginn) >= LOG_INGEST_WINDOW_SECONDS) {
        $beginn = $jetzt;
        $anzahl = 0;
    }
    $anzahl++;

    ftruncate($fh, 0);
    rewind($fh);
    fwrite($fh, $beginn . ':' . $anzahl);
    fflush($fh);
    flock($fh, LOCK_UN);
    fclose($fh);

    return $anzahl <= LOG_INGEST_MAX_PER_WINDOW;
}

/** AES-256-GCM-Startprotokoll entschluesseln und ablegen. */
function log_ingest_verschluesselt(string $platform, array $data): void
{
    // ⚠️ Dieser Schluessel steckt als Konstante im veroeffentlichten APK
    // (--dart-define → String.fromEnvironment). Er weist den Absender NICHT
    // aus und haelt den Inhalt vor niemandem geheim, der das APK hat. Was hier
    // wirklich schuetzt, sind die Groessengrenze, die Drossel und der
    // Geraeteschluessel weiter oben. Siehe lib/services/startup_diagnostics.dart.
    $keyHex = getenv('MITGLIEDER_STARTUP_DIAG_KEY');
    if (!$keyHex || strlen($keyHex) !== 64) {
        http_response_code(500);
        echo json_encode(['ok' => false, 'error' => 'key not configured']);
        return;
    }
    $key    = hex2bin($keyHex);
    $iv     = base64_decode($data['iv'], true);
    $packed = base64_decode($data['data'], true);
    if ($iv === false || $packed === false || strlen($packed) < 16) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'short packed']);
        return;
    }
    $tag    = substr($packed, -16);
    $cipher = substr($packed, 0, -16);
    $plain  = openssl_decrypt($cipher, 'aes-256-gcm', $key, OPENSSL_RAW_DATA, $iv, $tag);
    if ($plain === false) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'decrypt failed']);
        return;
    }
    $payload = json_decode($plain, true);
    if (!$payload) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'bad payload']);
        return;
    }

    $dir = __DIR__ . '/../data/logs/mitglieder_' . $platform;
    @mkdir($dir, 0750, true);
    $file = $dir . '/' . date('Y-m-d') . '.log';

    if (!log_ingest_platz_frei($file)) {
        http_response_code(507);
        echo json_encode(['ok' => false, 'error' => 'log full']);
        return;
    }

    $line = json_encode([
        'ts'               => date('c'),
        'platform'         => log_ingest_sauber($payload['platform'] ?? 'unknown', 64),
        'app_version'      => log_ingest_sauber($payload['app_version'] ?? 'unknown', 64),
        'device_id'        => log_ingest_sauber($payload['device_id'] ?? 'unknown', 128),
        'mitgliedernummer' => log_ingest_sauber($payload['mitgliedernummer'] ?? '', 64),
        'remote_ip'        => $_SERVER['REMOTE_ADDR'] ?? '',
        'level'            => log_ingest_sauber($payload['logs'][0]['level'] ?? 'info', 16),
        'transcript'       => log_ingest_sauber($payload['logs'][0]['message'] ?? '', LOG_INGEST_MAX_MESSAGE_LEN),
    ]) . "\n";

    if (file_put_contents($file, $line, FILE_APPEND | LOCK_EX) === false) {
        http_response_code(500);
        echo json_encode(['ok' => false, 'error' => 'write failed']);
        return;
    }
    echo json_encode(['ok' => true]);
}

/** Klartextstrom aus LoggerService ablegen. */
function log_ingest_klartext(string $platform, $data): void
{
    if (!$data || !isset($data['mitgliedernummer']) || !isset($data['logs'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'error' => 'Invalid payload']);
        return;
    }

    $mitgliedernummer = $data['mitgliedernummer'];
    // SICHERHEIT: dieser Wert wird unten in einen Dateipfad eingesetzt und kam
    // bis zur zweiten Stufe von einem unauthentifizierten Endpunkt. Ohne diese
    // Pruefung schreibt ein Aufrufer mit "../.." ausserhalb von $logsDir.
    // Weisse Liste, und laut ablehnen: ein stilles Umschreiben verbaergt
    // kaputte Clients genauso wie Angriffe.
    if (!is_string($mitgliedernummer) || !preg_match("/^[A-Za-z0-9_-]{1,64}$/", $mitgliedernummer)) {
        http_response_code(400);
        echo json_encode(["success" => false, "error" => "Invalid mitgliedernummer"]);
        return;
    }

    $logs = $data['logs'];
    if (!is_array($logs)) {
        http_response_code(400);
        echo json_encode(['success' => false, 'error' => 'Invalid payload']);
        return;
    }
    // ⚠️ Deckel, nicht Kuerzung: wer mehr als _maxWarteschlange schickt, ist
    // kein Client dieser App, und das soll man sehen statt es wegzuschneiden.
    if (count($logs) > LOG_INGEST_MAX_ENTRIES) {
        http_response_code(413);
        echo json_encode(['success' => false, 'error' => 'too many entries']);
        return;
    }

    $deviceId = log_ingest_sauber($data['device_id'] ?? 'unknown', 128);
    $plattform = log_ingest_sauber($data['platform'] ?? 'unknown', 64);

    $logsDir = __DIR__ . '/../../logs/mitglieder_' . $platform;
    if (!is_dir($logsDir)) { @mkdir($logsDir, 0750, true); }

    $date     = date('Y-m-d');
    $filename = "$logsDir/{$mitgliedernummer}_$date.log";

    if (!log_ingest_platz_frei($filename)) {
        http_response_code(507);
        echo json_encode(['success' => false, 'error' => 'log full']);
        return;
    }

    $logContent = '';
    foreach ($logs as $log) {
        if (!is_array($log)) { continue; }
        $timestamp = log_ingest_sauber($log['timestamp'] ?? date('c'), 64);
        $message   = log_ingest_sauber($log['message'] ?? '', LOG_INGEST_MAX_MESSAGE_LEN);
        $level     = strtoupper(log_ingest_sauber($log['level'] ?? 'INFO', 16));
        $tag       = log_ingest_sauber($log['tag'] ?? 'APP', 64);
        $logContent .= "[$timestamp] [$level] [$tag] $message\n";
    }
    file_put_contents($filename, $logContent, FILE_APPEND | LOCK_EX);

    // ⚠️ metadata.json wird als Ganzes neu geschrieben. Ohne Sperre ueber
    // Lesen UND Schreiben zerlegen zwei gleichzeitige Uploads die Datei: beide
    // lesen denselben Stand, beide schreiben ihren zurueck, einer verliert —
    // im schlechten Fall mittendrin, und dann ist es kein gueltiges JSON mehr.
    log_ingest_metadaten_schreiben("$logsDir/metadata.json", $mitgliedernummer, [
        'last_upload'      => date('c'),
        'device_id'        => $deviceId,
        'platform'         => $plattform,
        'total_logs_today' => count($logs),
    ]);

    echo json_encode([
        'success'    => true,
        'logs_saved' => count($logs),
        'file'       => basename($filename),
    ]);
}

/**
 * Einen Eintrag in metadata.json setzen, unter einer Sperre ueber den ganzen
 * Lese-Aendere-Schreibe-Weg.
 */
function log_ingest_metadaten_schreiben(string $pfad, string $schluessel, array $wert): void
{
    $fh = @fopen($pfad, 'c+');
    if ($fh === false) { return; }
    if (!flock($fh, LOCK_EX)) { fclose($fh); return; }

    $roh = (string) stream_get_contents($fh);
    $metadata = $roh === '' ? [] : (json_decode($roh, true) ?: []);
    $metadata[$schluessel] = $wert;

    ftruncate($fh, 0);
    rewind($fh);
    fwrite($fh, json_encode($metadata, JSON_PRETTY_PRINT));
    fflush($fh);
    flock($fh, LOCK_UN);
    fclose($fh);
}

/**
 * Fremdtext fuer eine Protokollzeile entschaerfen.
 *
 * ⚠️ Zeilenumbrueche sind der Punkt. Die Klartextform schreibt eine Zeile je
 * Eintrag; ein "\n" mitten in der Nachricht erzeugt eine zweite Zeile, die
 * beim Lesen wie ein eigener Eintrag aussieht — mit frei gewaehltem Zeitpunkt,
 * Rang und Herkunft. Wer Protokolle als Beleg liest, liest dann Erfundenes.
 * Steuerzeichen fliegen ebenfalls raus: sie verstellen das Terminal dessen,
 * der die Datei spaeter mit `cat` ansieht.
 */
function log_ingest_sauber($wert, int $maxLen): string
{
    if (!is_scalar($wert)) { return ''; }
    $s = (string) $wert;
    $s = preg_replace('/[\x00-\x1F\x7F]/u', ' ', $s);
    if ($s === null) { return ''; }                 // ungueltiges UTF-8
    if (mb_strlen($s, 'UTF-8') > $maxLen) {
        $s = mb_substr($s, 0, $maxLen, 'UTF-8') . '…';
    }
    return $s;
}

/** Ist in der Zieldatei noch Platz? Schuetzt die Platte vor Dauerbeschuss. */
function log_ingest_platz_frei(string $datei): bool
{
    if (!is_file($datei)) { return true; }
    $groesse = @filesize($datei);
    return $groesse === false || $groesse < LOG_INGEST_MAX_FILE_BYTES;
}
