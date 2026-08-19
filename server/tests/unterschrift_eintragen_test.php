<?php
/**
 * Prueft `SignaturHelper::unterschriftEintragen()` am ECHTEN Schema.
 *
 * Warum es diesen Test gibt: der Ablauf lag bis zum 19.08.2026 mitten im
 * member-Endpunkt und wurde von dort hierher geholt, damit die Unterschrift
 * per SMS-Link denselben Code benutzt statt einer zweiten Kopie. Der
 * bestehende Test `zwei_unterschriften_test.php` schreibt seine Zeilen von
 * Hand in die Tabelle — er haette eine kaputte Extraktion NICHT bemerkt.
 *
 * ⚠️ Legt eigene Zeilen an und raeumt sie am Ende weg. Die Aufraeumung ist
 * auf die selbst erzeugten Ids beschraenkt und wird nachgeprueft: ein
 * `DELETE` ueber ein Muster hat hier schon einmal echte Daten mitgenommen.
 *
 * 🔴 NICHT laufen lassen, waehrend jemand wirklich unterschreibt.
 *
 * Unterschreiben vergibt eine Position in der GLOBALEN Hash-Kette. Dieser
 * Test vergibt also echte Positionen und loescht sie danach wieder. Solange
 * er allein laeuft, faellt die Kette hinterher auf ihren alten Stand zurueck
 * und nichts bleibt zurueck — genau das prueft er am Ende auch nach.
 *
 * Kaeme aber dazwischen eine ECHTE Unterschrift, haenge sie an einer
 * Probezeile, und deren Loeschung risse ein Loch, das sich nicht mehr
 * schliessen laesst: `verkettungPruefen()` meldete fuer diese Unterschrift
 * fuer immer eine gebrochene Kette. Deshalb der Vergleich unten, und deshalb
 * dieser Hinweis hier oben.
 */

declare(strict_types=1);
define('API_ACCESS', true);

const WEBROOT = '/var/www/icd360sev.icd360s.de';

// ⚠️ ENC_MASTER_KEY steht nur als env[] im PHP-FPM-Pool, nicht in der CLI.
// Ohne diesen Griff wirft schon `SignaturHelper::tanHash()` — dieselbe Falle
// wie bei den Cron-Jobs fuer YouTube und Speedtest.
foreach (file('/etc/opt/remi/php85/php-fpm.d/www.conf') as $z) {
    if (preg_match('/^\s*env\[ENC_MASTER_KEY\]\s*=\s*(.+)$/', $z, $m)) {
        putenv('ENC_MASTER_KEY=' . trim($m[1])); break;
    }
}
require_once WEBROOT . '/api/config.php';
require_once WEBROOT . '/api/lib/SignaturHelper.php';

$pdo = getDBConnection();
$fehler = 0;
$pruef = function (bool $ok, string $was, string $detail = '') use (&$fehler) {
    echo ($ok ? '  ok   ' : '  FAIL ') . $was . ($detail !== '' ? " — $detail" : '') . "\n";
    if (!$ok) { $fehler++; }
};

// Ein Mitglied mit Rufnummer — die TAN-Zeile braucht eine.
$mitglied = (int)$pdo->query(
    "SELECT id FROM users WHERE role='mitglied' AND telefon_mobil<>'' ORDER BY id LIMIT 1"
)->fetchColumn();
if ($mitglied <= 0) { exit("Kein Mitglied mit Rufnummer gefunden\n"); }

$meineSignaturen = [];
$meineTans = [];

// Der Stand der Kette VOR dem Lauf. Am Ende muss er wieder derselbe sein.
//
// ⚠️ NICHT ueber `vorherigesGlied()`. Die Methode klingt nach einem Blick,
// RESERVIERT aber die naechste Position und zaehlt den Anker hoch — zum
// Nachsehen benutzt, verbraucht sie eine Nummer, die nie eine Zeile bekommt.
// Genau daran ist die erste Fassung dieses Tests gescheitert: der Anker stand
// hinterher zwei ueber dem Bestand, und das ist das Signal fuer „am Ende der
// Kette wurde geloescht".
$kettenKopf = function () use ($pdo): array {
    $nr = (int)$pdo->query('SELECT letzte_nr FROM signatur_kette_stand WHERE id = 1')
                   ->fetchColumn();
    $h  = $pdo->prepare('SELECT full_hash FROM dokument_signaturen WHERE ketten_nr = ?');
    $h->execute([$nr]);
    $gefunden = $h->fetchColumn();
    return ['nr' => $nr, 'hash' => $gefunden === false ? null : (string)$gefunden];
};
$kopfVorher = $kettenKopf();

/** Legt eine offene Signaturzeile an und gibt ihre Id zurueck. */
$anlegen = function () use ($pdo, $mitglied, &$meineSignaturen): int {
    $pdo->prepare(
        "INSERT INTO dokument_signaturen
           (user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
            pdf_pfad, pdf_hash, status)
         VALUES (?, ?, UTC_TIMESTAMP(), 'probe_extraktion', 'Probe Extraktion',
                 'probe/nichts.pdf', ?, 'offen')"
    )->execute([$mitglied, $mitglied, str_repeat('a', 64)]);
    $id = (int)$pdo->lastInsertId();
    $meineSignaturen[] = $id;
    return $id;
};

/** Legt eine gueltige TAN an und gibt den Klartext zurueck. */
$tanAnlegen = function (int $sigId, int $minuten = 5) use ($pdo, &$meineTans): string {
    $tan = SignaturHelper::tanErzeugen();
    $pdo->prepare(
        "INSERT INTO signatur_tan (signatur_id, tan_hash, telefon, gueltig_bis)
         VALUES (?, ?, '+4917600000000', DATE_ADD(UTC_TIMESTAMP(), INTERVAL ? MINUTE))"
    )->execute([$sigId, SignaturHelper::tanHash($tan, $sigId), $minuten]);
    $meineTans[] = (int)$pdo->lastInsertId();
    return $tan;
};

const SVG = '<svg xmlns="http://www.w3.org/2000/svg"><path d="M0 0 L10 10"/></svg>';

// Die Adresse kommt aus dem DNS, nicht aus dem Quelltext.
//
// ⚠️ Eine eingetippte IP prueft eine Adresse, die der Server vielleicht gar
// nicht mehr hat — nach dem Umzug im Juli 2026 waere genau das passiert. So
// folgt der Test dem Host von selbst.
//
// ⚠️ Und keine fremde Adresse: die erste Fassung nahm 203.0.113.7 aus
// TEST-NET-3 (RFC 5737), die in der Datenbank als „ZZ" steht und zu NULL
// wird — voellig richtig, aber der Test meldete dadurch einen behobenen
// Fehler weiter als Fehler.
$hostV4 = gethostbyname('icd360sev.icd360s.de');
if (!filter_var($hostV4, FILTER_VALIDATE_IP)) {
    exit("icd360sev.icd360s.de laesst sich nicht aufloesen\n");
}
$aaaa = @dns_get_record('icd360sev.icd360s.de', DNS_AAAA);
$hostV6 = $aaaa && isset($aaaa[0]['ipv6']) ? (string)$aaaa[0]['ipv6'] : '';
echo "  Host laut DNS: $hostV4" . ($hostV6 !== '' ? " / $hostV6" : '') . "\n";

echo "\n== 1. Falscher Code ==\n";
$s1 = $anlegen();
$tan1 = $tanAnlegen($s1);
$r = SignaturHelper::unterschriftEintragen($pdo, $s1, $mitglied, 'XXXXXX', SVG);
$pruef($r['ok'] === false && $r['http'] === 401, 'wird mit 401 abgelehnt', 'http=' . $r['http']);
$pruef(($r['daten']['grund'] ?? '') === 'tan_falsch', 'nennt den Grund tan_falsch');
$versuche = (int)$pdo->query("SELECT versuche FROM signatur_tan WHERE signatur_id=$s1")->fetchColumn();
$pruef($versuche === 1, 'zaehlt den Fehlversuch', "versuche=$versuche");
$st = (string)$pdo->query("SELECT status FROM dokument_signaturen WHERE id=$s1")->fetchColumn();
$pruef($st === 'offen', 'die Zeile bleibt offen', "status=$st");

echo "\n== 2. Richtiger Code (Weg: app) ==\n";
$r = SignaturHelper::unterschriftEintragen($pdo, $s1, $mitglied, $tan1, SVG,
        ['device_id' => 'PROBE-GERAET', 'device_hostname' => 'Probe',
         'ip' => $hostV4, 'user_agent' => 'Probe/1.0', 'zugang_weg' => 'app']);
$pruef($r['ok'] === true, 'wird angenommen', $r['meldung']);
$z = $pdo->query("SELECT status, zugang_weg, full_hash, prev_hash, ketten_nr, verify_code,
                         signature_svg, tan_an, beweis_vollstaendig, ip_address
                    FROM dokument_signaturen WHERE id=$s1")->fetch(PDO::FETCH_ASSOC);
$pruef($z['status'] === 'signiert', 'Status steht auf signiert');
$pruef($z['zugang_weg'] === 'app', 'zugang_weg = app', (string)$z['zugang_weg']);
$pruef(strlen((string)$z['full_hash']) === 64, 'full_hash ist gesetzt');
$pruef((int)$z['ketten_nr'] > 0, 'ketten_nr ist vergeben', (string)$z['ketten_nr']);
$pruef(!empty($z['verify_code']), 'verify_code ist gesetzt');
$pruef($z['signature_svg'] === SVG, 'das SVG steht unveraendert drin');
$pruef(strpos((string)$z['tan_an'], '•') !== false, 'die Rufnummer ist maskiert', (string)$z['tan_an']);
$pruef((int)$z['beweis_vollstaendig'] === 1, 'zum Siegeln freigegeben');
$pruef($z['ip_address'] === $hostV4, 'die uebergebene IP steht drin', (string)$z['ip_address']);
// ⚠️ Die Herkunft wird NACH dem Commit nachgetragen. Sie darf keine Ausnahme
// werfen — aber sie darf auch nicht still danebengehen: genau das tat sie bis
// zum 19.08.2026 (vier `:ip` in einer nativ vorbereiteten Abfrage), und keine
// einzige der 17 unterschriebenen Zeilen trug ein Land.
// ⚠️ Geprueft wird „das Feld ist gefuellt", NICHT „das Land ist DE". Sonst
// faellt der Test durch, sobald der Verein einmal woanders hostet — und
// eigentlich geht es hier darum, dass `ipHerkunft()` ueberhaupt laeuft.
$land = $pdo->query("SELECT country_iso FROM dokument_signaturen WHERE id=$s1")->fetchColumn();
$pruef(!empty($land), 'Land ist nachgetragen — ipHerkunft laeuft ohne Fehler',
       var_export($land, true));
$netz = $pdo->query("SELECT isp FROM dokument_signaturen WHERE id=$s1")->fetchColumn();
$pruef(!empty($netz), 'Netzbetreiber ist nachgetragen', (string)$netz);
$pruef(($r['daten']['full_hash'] ?? '') === $z['full_hash'], 'Rueckgabe und Zeile stimmen ueberein');

echo "\n== 3. Die Kette haengt am Vorgaenger ==\n";
// ⚠️ Gegen den Kopf, den wir VOR dem Lauf gemerkt haben — nicht gegen
// `verkettungPruefen()`. Das prueft gegen die Zeile auf `ketten_nr - 1`, und
// die ist im zweiten Durchlauf dieses Tests seine eigene, bereits geloeschte
// Probezeile: es meldete einen Kettenbruch, den es nicht gab.
$pruef((int)$z['ketten_nr'] === $kopfVorher['nr'] + 1,
       'die Position folgt auf den alten Kopf',
       $kopfVorher['nr'] . ' -> ' . $z['ketten_nr']);
$pruef((string)$z['prev_hash'] === (string)($kopfVorher['hash'] ?? ''),
       'prev_hash ist der full_hash des alten Kopfes');

echo "\n== 4. Ein zweites Mal geht nicht ==\n";
$tanNeu = $tanAnlegen($s1);
$r = SignaturHelper::unterschriftEintragen($pdo, $s1, $mitglied, $tanNeu, SVG);
$pruef($r['ok'] === false && $r['http'] === 409, 'wird mit 409 abgelehnt', 'http=' . $r['http']);

echo "\n== 5. Fremdes Mitglied darf nicht ==\n";
$s2 = $anlegen();
$tan2 = $tanAnlegen($s2);
$r = SignaturHelper::unterschriftEintragen($pdo, $s2, $mitglied + 99999, $tan2, SVG);
$pruef($r['ok'] === false && $r['http'] === 404, 'wird mit 404 abgelehnt', 'http=' . $r['http']);
$st = (string)$pdo->query("SELECT status FROM dokument_signaturen WHERE id=$s2")->fetchColumn();
$pruef($st === 'offen', 'die Zeile bleibt unberuehrt');

echo "\n== 6. Abgelaufener Code ==\n";
$s3 = $anlegen();
$tan3 = $tanAnlegen($s3, -1);          // schon abgelaufen
$r = SignaturHelper::unterschriftEintragen($pdo, $s3, $mitglied, $tan3, SVG);
$pruef($r['ok'] === false && $r['http'] === 409, 'wird mit 409 abgelehnt', 'http=' . $r['http']);
$pruef(($r['daten']['grund'] ?? '') === 'tan_abgelaufen', 'nennt den Grund tan_abgelaufen');

echo "\n== 7. Weg: sms_link ==\n";
$s4 = $anlegen();
$tan4 = $tanAnlegen($s4);
$r = SignaturHelper::unterschriftEintragen($pdo, $s4, $mitglied, $tan4, SVG,
        ['zugang_weg' => 'sms_link', 'ip' => '198.51.100.3',
         'user_agent' => 'Mozilla/5.0 (Android)']);
$pruef($r['ok'] === true, 'wird angenommen', $r['meldung']);
$z4 = $pdo->query("SELECT zugang_weg, device_id, app_version, full_hash
                     FROM dokument_signaturen WHERE id=$s4")->fetch(PDO::FETCH_ASSOC);
$pruef($z4['zugang_weg'] === 'sms_link', 'zugang_weg = sms_link', (string)$z4['zugang_weg']);
$pruef((string)$z4['device_id'] === '', 'kein Geraeteschluessel — es gab keines');
$pruef($z4['app_version'] === null, 'keine App-Fassung — es war ein Browser');
$pruef(strlen((string)$z4['full_hash']) === 64, 'die Kette laeuft trotzdem weiter');

echo "\n== 7b. Herkunft auch ueber IPv6 ==\n";
// Der Host hat A UND AAAA. Kommt eine Unterschrift ueber v6 herein, steht
// eine v6-Adresse in der Zeile — `INET6_ATON` kann das, aber gemessen ist
// gemessen.
if ($hostV6 === '') {
    echo "  --   uebersprungen: kein AAAA im DNS\n";
} else {
    $s6 = $anlegen();
    $tan6 = $tanAnlegen($s6);
    $r = SignaturHelper::unterschriftEintragen($pdo, $s6, $mitglied, $tan6, SVG,
            ['ip' => $hostV6, 'zugang_weg' => 'sms_link']);
    $pruef($r['ok'] === true, 'wird angenommen', $r['meldung']);
    $z6 = $pdo->query("SELECT ip_address, country_iso, isp
                         FROM dokument_signaturen WHERE id=$s6")->fetch(PDO::FETCH_ASSOC);
    $pruef($z6['ip_address'] === $hostV6, 'die v6-Adresse steht drin', (string)$z6['ip_address']);
    $pruef(!empty($z6['country_iso']), 'Land auch bei v6 nachgetragen', (string)$z6['country_iso']);
    $pruef(!empty($z6['isp']), 'Netzbetreiber auch bei v6 nachgetragen', (string)$z6['isp']);
}

echo "\n== 8. Unfug wird abgewiesen ==\n";
$s5 = $anlegen();
$tan5 = $tanAnlegen($s5);
$r = SignaturHelper::unterschriftEintragen($pdo, $s5, $mitglied, $tan5, 'kein svg');
$pruef($r['ok'] === false && $r['http'] === 400, 'Text statt SVG wird abgelehnt');
$r = SignaturHelper::unterschriftEintragen($pdo, $s5, $mitglied, '', SVG);
$pruef($r['ok'] === false && $r['http'] === 400, 'leerer Code wird abgelehnt');
$st = (string)$pdo->query("SELECT status FROM dokument_signaturen WHERE id=$s5")->fetchColumn();
$pruef($st === 'offen', 'die Zeile bleibt unberuehrt');

// ── Aufraeumen, und zwar nachweislich ───────────────────────────────
echo "\n== Aufraeumen ==\n";
$ids = implode(',', array_map('intval', $meineSignaturen));
$pdo->exec("DELETE FROM signatur_tan WHERE signatur_id IN ($ids)");
$pdo->exec("DELETE FROM dokument_signaturen WHERE id IN ($ids)");
$rest = (int)$pdo->query("SELECT COUNT(*) FROM dokument_signaturen WHERE id IN ($ids)")->fetchColumn();
$pruef($rest === 0, 'alle eigenen Zeilen sind weg', "rest=$rest");
$fremd = (int)$pdo->query("SELECT COUNT(*) FROM dokument_signaturen
                            WHERE dokument_typ='probe_extraktion'")->fetchColumn();
$pruef($fremd === 0, 'keine Probezeile uebrig');

// 🔴 Den ANKER zuruecksetzen — und zwar begruendet.
//
// `signatur_kette_stand.letzte_nr` waechst nur. Das ist Absicht: loescht
// jemand das letzte Kettenglied, bleibt der Anker stehen, und
// `letzte_nr > MAX(ketten_nr)` verraet, dass am Ende etwas fehlt. Ein
// Loeschen am Ende hinterlaesst sonst keinen Zeiger auf sich.
//
// Genau diesen Zustand erzeugt dieser Test aber selbst: er vergibt echte
// Positionen und raeumt seine Zeilen wieder weg. Liesse man den Anker
// stehen, meldete die Anlage von jetzt an dauerhaft „hier wurden Glieder
// entfernt" — eine falsche Alarmmeldung, die eine spaetere echte
// uebertoenen wuerde.
//
// ⚠️ Zurueckgesetzt wird NUR, wenn die Positionen dazwischen nachweislich
// leer sind. Faende sich dort eine echte Unterschrift, waere der Anker
// richtig und der Test haette Schaden angerichtet — dann bleibt er stehen
// und der Lauf faellt durch.
$dazwischen = (int)$pdo->query(
    "SELECT COUNT(*) FROM dokument_signaturen
      WHERE ketten_nr > " . (int)$kopfVorher['nr']
)->fetchColumn();
$pruef($dazwischen === 0,
       'auf den verbrauchten Positionen liegt keine echte Unterschrift',
       "gefunden=$dazwischen");
if ($dazwischen === 0) {
    $pdo->prepare('UPDATE signatur_kette_stand SET letzte_nr = ?, aktualisiert_at = UTC_TIMESTAMP()
                    WHERE id = 1 AND letzte_nr >= ?')
        ->execute([(int)$kopfVorher['nr'], (int)$kopfVorher['nr']]);
}
$kopfNachher = $kettenKopf();
$pruef($kopfNachher['nr'] === $kopfVorher['nr'] && $kopfNachher['hash'] === $kopfVorher['hash'],
       'die Hash-Kette steht wieder auf ihrem alten Kopf',
       $kopfVorher['nr'] . ' -> ' . $kopfNachher['nr']);
$anker = (int)$pdo->query("SELECT letzte_nr FROM signatur_kette_stand WHERE id=1")->fetchColumn();
$maxNr = (int)$pdo->query("SELECT COALESCE(MAX(ketten_nr),0) FROM dokument_signaturen")->fetchColumn();
$pruef($anker === $maxNr, 'Anker und Bestand stimmen wieder ueberein',
       "anker=$anker max=$maxNr");
$luecke = (int)$pdo->query(
    "SELECT COUNT(*) FROM dokument_signaturen a
      WHERE a.ketten_nr > 1
        AND NOT EXISTS (SELECT 1 FROM dokument_signaturen b WHERE b.ketten_nr = a.ketten_nr - 1)"
)->fetchColumn();
$pruef($luecke === 0, 'keine Luecke in der Kette', "luecken=$luecke");

echo "\n" . ($fehler === 0 ? "ALLES GRUEN\n" : "$fehler FEHLER\n");
exit($fehler === 0 ? 0 : 1);
