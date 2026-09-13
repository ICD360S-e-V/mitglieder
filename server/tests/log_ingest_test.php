<?php
/**
 * Selbststaendiger Test fuer server/api/logs/log_ingest_lib.php.
 *
 * ⚠️ Anders als die uebrigen Dateien in diesem Verzeichnis braucht dieser Test
 * WEDER Datenbank NOCH den php-fpm-Pool: er prueft nur die Entscheidungen, die
 * der Endpunkt ohne fremde Hilfe trifft — Entschaerfen von Fremdtext, Drossel,
 * Sperre um metadata.json, Platzgrenze. Dadurch laeuft er auch dort, wo der
 * Server nicht steht:
 *
 *   php server/tests/log_ingest_test.php
 *   docker run --rm -v "$PWD:/w:ro" -w /w php:8.3-cli php server/tests/log_ingest_test.php
 *
 * Was er NICHT prueft, und was deshalb der Rauchtest nach dem Ausrollen
 * abdecken muss (README.md im Endpunktverzeichnis): blockBrowserAccess(),
 * validateDeviceKey() und das Zusammenspiel mit nginx — die leben in
 * config.php auf dem Server und stehen nicht in diesem Repositorium.
 */

define('API_ACCESS', true);

// ── Ersatz fuer die beiden Funktionen aus config.php ───────────────────────
function blockBrowserAccess(): void {}
function validateDeviceKey(string $k): bool { return $k === 'gueltiger-schluessel'; }

require_once __DIR__ . '/../api/logs/log_ingest_lib.php';

$fehler = 0;
function pruefe(string $was, bool $ok): void {
    global $fehler;
    if ($ok) { echo "  ok    $was\n"; }
    else     { echo "  FEHLT $was\n"; $fehler++; }
}

echo "── log_ingest_sauber ──\n";
pruefe('Zeilenumbruch wird ersetzt, keine zweite Zeile',
    !str_contains(log_ingest_sauber("erste\nzweite", 100), "\n"));
pruefe('Wagenruecklauf ebenso',
    !str_contains(log_ingest_sauber("a\r\nb", 100), "\r"));
pruefe('gefaelschter Eintrag bleibt eine Zeile',
    substr_count(log_ingest_sauber("echt\n[2026-01-01] [ERROR] [APP] erfunden", 200), "\n") === 0);
pruefe('Steuerzeichen raus (ESC)',
    !str_contains(log_ingest_sauber("a\x1b[31mrot", 100), "\x1b"));
pruefe('Null-Byte raus',
    !str_contains(log_ingest_sauber("a\x00b", 100), "\x00"));
pruefe('harmloser Text bleibt unveraendert',
    log_ingest_sauber('Anmeldung fehlgeschlagen (HTTP 401)', 100) === 'Anmeldung fehlgeschlagen (HTTP 401)');
pruefe('Umlaute ueberleben',
    log_ingest_sauber('Grüße aus München', 100) === 'Grüße aus München');
pruefe('zu lang wird gekuerzt',
    mb_strlen(log_ingest_sauber(str_repeat('x', 500), 100), 'UTF-8') === 101); // 100 + Auslassungszeichen
pruefe('Kuerzung trennt kein Mehrbytezeichen',
    mb_check_encoding(log_ingest_sauber(str_repeat('ü', 500), 100), 'UTF-8'));
pruefe('Nicht-Skalar wird leer',
    log_ingest_sauber(['a'], 100) === '');
pruefe('Zahl wird Text',
    log_ingest_sauber(42, 100) === '42');

echo "── log_ingest_platz_frei ──\n";
$tmp = sys_get_temp_dir() . '/log_ingest_test_' . getmypid();
@mkdir($tmp, 0700, true);
$leer = "$tmp/leer.log";
pruefe('nicht vorhandene Datei hat Platz', log_ingest_platz_frei($leer));
file_put_contents($leer, 'x');
pruefe('kleine Datei hat Platz', log_ingest_platz_frei($leer));
$voll = "$tmp/voll.log";
file_put_contents($voll, str_repeat('x', LOG_INGEST_MAX_FILE_BYTES + 1));
pruefe('volle Datei hat keinen Platz mehr', !log_ingest_platz_frei($voll));
@unlink($voll);

echo "── log_ingest_metadaten_schreiben ──\n";
$meta = "$tmp/metadata.json";
log_ingest_metadaten_schreiben($meta, 'M1', ['a' => 1]);
$gelesen = json_decode(file_get_contents($meta), true);
pruefe('erster Eintrag angelegt', ($gelesen['M1']['a'] ?? null) === 1);
log_ingest_metadaten_schreiben($meta, 'M2', ['a' => 2]);
$gelesen = json_decode(file_get_contents($meta), true);
pruefe('zweiter Eintrag daneben', ($gelesen['M1']['a'] ?? null) === 1 && ($gelesen['M2']['a'] ?? null) === 2);
log_ingest_metadaten_schreiben($meta, 'M1', ['a' => 9]);
$gelesen = json_decode(file_get_contents($meta), true);
pruefe('vorhandener Eintrag ersetzt', ($gelesen['M1']['a'] ?? null) === 9);
pruefe('Datei bleibt gueltiges JSON', json_last_error() === JSON_ERROR_NONE);
// ⚠️ Der Fall, fuer den die Sperre da ist: ein kuerzerer Stand darf keinen
// Rest des laengeren stehen lassen. Ohne ftruncate bliebe hier Muell hinten.
log_ingest_metadaten_schreiben($meta, 'M1', ['a' => 9]);
pruefe('kein Rest nach dem Kuerzen', json_decode(file_get_contents($meta), true) !== null);

echo "── log_ingest_drossel_erlaubt ──\n";
$ident = 'test:' . getmypid() . ':' . random_int(1, 1 << 30);
$durch = 0;
for ($i = 0; $i < LOG_INGEST_MAX_PER_WINDOW + 5; $i++) {
    if (log_ingest_drossel_erlaubt($ident)) { $durch++; }
}
pruefe('genau MAX_PER_WINDOW kommen durch', $durch === LOG_INGEST_MAX_PER_WINDOW);
pruefe('danach wird abgewiesen', !log_ingest_drossel_erlaubt($ident));
$anderer = 'test:' . getmypid() . ':' . random_int(1, 1 << 30);
pruefe('andere Identitaet ist nicht mitbetroffen', log_ingest_drossel_erlaubt($anderer));
// Fenster kuenstlich altern lassen: Beginn zurueckdatieren.
$zaehler = sys_get_temp_dir() . '/icd360sev_log_drossel/' . hash('sha256', $ident);
file_put_contents($zaehler, (time() - LOG_INGEST_WINDOW_SECONDS - 1) . ':' . LOG_INGEST_MAX_PER_WINDOW);
pruefe('neues Fenster laesst wieder durch', log_ingest_drossel_erlaubt($ident));
@unlink($zaehler);
@unlink(sys_get_temp_dir() . '/icd360sev_log_drossel/' . hash('sha256', $anderer));

echo "── Grenzen sind an den Client gebunden ──\n";
pruefe('Eintragsdeckel = _maxWarteschlange des Clients (500)', LOG_INGEST_MAX_ENTRIES === 500);
pruefe('Rumpfgrenze ist gesetzt', LOG_INGEST_MAX_BYTES === 524288);
pruefe('zweite Stufe ist noch nicht scharf', LOG_INGEST_REQUIRE_DEVICE_KEY === false);

array_map('unlink', glob("$tmp/*") ?: []);
@rmdir($tmp);

echo $fehler === 0 ? "\nAlle Pruefungen bestanden.\n" : "\n$fehler Pruefung(en) fehlgeschlagen.\n";
exit($fehler === 0 ? 0 : 1);
