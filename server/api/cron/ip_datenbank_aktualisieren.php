<?php
/**
 * Holt die freien IP-Datenbanken von DB-IP und legt sie in MySQL ab.
 *
 * Monatlich per Cron; die Dateien erscheinen zum Monatsersten.
 *
 * WOZU
 * Im Beweisbündel einer Unterschrift steht die IP. Für sich genommen ist das
 * eine Zahl, die vor Gericht niemand einordnen kann. Land und Netzbetreiber
 * machen daraus eine Aussage, die jemand nachvollziehen kann.
 *
 * Der Netzbetreiber ist dabei der wertvollere der beiden: er unterscheidet
 * eine gewöhnliche Anschlussleitung („1&1 Versatel GmbH", „Vodafone") von
 * einem Rechenzentrum („OVH SAS"). Zweiteres heißt VPN oder Server — also
 * genau der Fall, in dem die IP über den Aufenthaltsort NICHTS aussagt. Das
 * gehört sichtbar im Bündel, statt dass es später jemand herausfindet.
 *
 * WAS HIER BEWUSST NICHT PASSIERT
 * Keine Stadt. IP-Ortung auf Stadtebene ist bei Mobilfunk regelmäßig der
 * Standort des Betreiber-Gateways, nicht der des Menschen — oft hunderte
 * Kilometer daneben. Eine Angabe, die sich widerlegen lässt, schwächt das
 * ganze Bündel: wer einen Eintrag als falsch nachweist, stellt alle übrigen
 * in Frage.
 *
 * Quelle: DB-IP Lite, frei unter CC-BY 4.0. Die Namensnennung steht in der
 * Prüfseite und im Unterschriftenblatt.
 */

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit("CLI only\n");
}

define('API_ACCESS', true);

const WEBROOT = '/var/www/icd360sev.icd360s.de';
const QUELLE  = 'https://download.db-ip.com/free';

require_once WEBROOT . '/api/config.php';

$pdo = getDBConnection();
$monat = date('Y-m');

tabellenAnlegen($pdo);

// TÄGLICH aufgerufen, obwohl die Quelle nur MONATLICH erscheint — und das ist
// kein Widerspruch. Liefe der Job nur am Monatsersten und ginge dabei etwas
// schief (Datei noch nicht veröffentlicht, Netz weg, Platte voll), stünde der
// Bestand einen vollen Monat still, ohne dass es jemand merkt. Der tägliche
// Blick kostet eine Abfrage und heilt genau diesen Fall.
//
// Ist der Monat schon geladen, endet der Lauf hier.
if (bereitsGeladen($pdo, $monat)) {
    exit(0);
}

$landZeilen = importieren($pdo, "dbip-country-lite-$monat.csv.gz", 'ip_land',
                          fn(array $r) => [$r[0], $r[1], $r[2]]);
$netzZeilen = importieren($pdo, "dbip-asn-lite-$monat.csv.gz", 'ip_netz',
                          fn(array $r) => [$r[0], $r[1], $r[3] ?? '']);
$gesamt = $landZeilen + $netzZeilen;

// Nur vermerken, wenn BEIDE Dateien durchgelaufen sind. Sonst gilt der Monat
// als offen und der nächste Tag versucht es erneut — halb geladen wäre
// schlimmer als einen Monat alt.
if ($gesamt > 0 && $landZeilen > 0 && $netzZeilen > 0) {
    $pdo->prepare(
        "INSERT INTO ip_datenbank_stand (id, monat, geladen_am)
         VALUES (1, ?, UTC_TIMESTAMP())
         ON DUPLICATE KEY UPDATE monat = VALUES(monat), geladen_am = VALUES(geladen_am)"
    )->execute([$monat]);
}

echo date('c') . " — $gesamt Bereiche geladen (Stand $monat)\n";

// ---------------------------------------------------------------------------

/** Steht der Bestand dieses Monats schon in der Datenbank? */
function bereitsGeladen(PDO $pdo, string $monat): bool
{
    try {
        $stmt = $pdo->prepare("SELECT monat FROM ip_datenbank_stand WHERE id = 1");
        $stmt->execute();
        return $stmt->fetchColumn() === $monat;
    } catch (Throwable $e) {
        return false;
    }
}

function tabellenAnlegen(PDO $pdo): void
{
    // VARBINARY(16) mit INET6_ATON: dieselbe Spalte trägt IPv4 und IPv6, und
    // der Vergleich bleibt ein simpler Bytevergleich. Zwei getrennte Tabellen,
    // weil Land- und Netzgrenzen NICHT dieselben sind — zusammengelegt müsste
    // man eine der beiden verfälschen.
    $pdo->exec(
        "CREATE TABLE IF NOT EXISTS ip_datenbank_stand (
            id TINYINT NOT NULL PRIMARY KEY,
            monat CHAR(7) NOT NULL,
            geladen_am DATETIME NOT NULL
         ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"
    );

    foreach ([
        'ip_land' => 'land CHAR(2) NOT NULL',
        'ip_netz' => 'netz VARCHAR(120) NOT NULL',
    ] as $tabelle => $spalte) {
        $pdo->exec(
            "CREATE TABLE IF NOT EXISTS $tabelle (
                start_ip VARBINARY(16) NOT NULL,
                end_ip   VARBINARY(16) NOT NULL,
                $spalte,
                PRIMARY KEY (start_ip)
             ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"
        );
    }
}

/**
 * Lädt eine Datei und ersetzt den Inhalt der Tabelle.
 *
 * Erst in eine Zwischentabelle, dann umbenennen: waehrend des Imports bleibt
 * die alte Tabelle vollstaendig benutzbar. Ein halb gefuellter Bestand waere
 * schlimmer als ein einen Monat alter — er lieferte fuer manche Adressen
 * stillschweigend nichts.
 */
function importieren(PDO $pdo, string $datei, string $tabelle, callable $abbilden): int
{
    $url = QUELLE . '/' . $datei;
    $gz  = tempnam(sys_get_temp_dir(), 'dbip_');

    $roh = @file_get_contents($url);
    if ($roh === false || strlen($roh) < 100000) {
        error_log("ip_datenbank: $datei nicht ladbar");
        @unlink($gz);
        return 0;
    }
    file_put_contents($gz, $roh);

    $strom = gzopen($gz, 'rb');
    if ($strom === false) {
        error_log("ip_datenbank: $datei nicht entpackbar");
        @unlink($gz);
        return 0;
    }

    $neu = $tabelle . '_neu';
    $pdo->exec("DROP TABLE IF EXISTS $neu");
    $pdo->exec("CREATE TABLE $neu LIKE $tabelle");

    $einfuegen = $pdo->prepare(
        "INSERT IGNORE INTO $neu VALUES (INET6_ATON(?), INET6_ATON(?), ?)"
    );

    $pdo->beginTransaction();
    $n = 0;
    while (($zeile = gzgets($strom)) !== false) {
        $r = str_getcsv(trim($zeile), ',', '"', '\\');
        if (count($r) < 3) {
            continue;
        }
        $werte = $abbilden($r);
        // Ohne verwertbaren Namen bringt die Zeile nichts.
        if (trim((string)$werte[2]) === '') {
            continue;
        }
        try {
            $einfuegen->execute([$werte[0], $werte[1], substr((string)$werte[2], 0, 120)]);
            $n++;
        } catch (Throwable $e) {
            // Einzelne kaputte Zeile darf den Import nicht kippen.
        }
        if ($n % 50000 === 0) {
            $pdo->commit();
            $pdo->beginTransaction();
        }
    }
    $pdo->commit();
    gzclose($strom);
    @unlink($gz);

    // Atomar tauschen.
    $pdo->exec("DROP TABLE IF EXISTS {$tabelle}_alt");
    $pdo->exec("RENAME TABLE $tabelle TO {$tabelle}_alt, $neu TO $tabelle");
    $pdo->exec("DROP TABLE {$tabelle}_alt");

    echo "  $tabelle: $n Bereiche\n";
    return $n;
}
