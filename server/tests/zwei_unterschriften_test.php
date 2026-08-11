<?php
/**
 * Prueft den Zwei-Unterzeichner-Fall am echten Schema und am echten Cron.
 *
 * Zwei Durchgaenge: einmal unterschreiben beide, einmal lehnt der zweite ab.
 * Raeumt am Ende alles weg.
 */

declare(strict_types=1);
define('API_ACCESS', true);

const WEBROOT = '/var/www/icd360sev.icd360s.de';

foreach (file('/etc/opt/remi/php85/php-fpm.d/www.conf') as $z) {
    if (preg_match('/^\s*env\[ENC_MASTER_KEY\]\s*=\s*(.+)$/', $z, $m)) {
        putenv('ENC_MASTER_KEY=' . trim($m[1])); break;
    }
}
require_once WEBROOT . '/api/config.php';
require_once WEBROOT . '/pdflib/vendor/autoload.php';
require_once WEBROOT . '/api/lib/SignaturHelper.php';

$pdo = getDBConnection();
$fehler = 0;
$pruef = function (bool $ok, string $was, string $detail = '') use (&$fehler) {
    echo ($ok ? '  ok   ' : '  FAIL ') . $was . ($detail !== '' ? " — $detail" : '') . "\n";
    if (!$ok) { $fehler++; }
};

$mitglied  = (int)$pdo->query("SELECT id FROM users WHERE mitgliedernummer='M40837'")->fetchColumn()
          ?: (int)$pdo->query("SELECT id FROM users WHERE role='mitglied' LIMIT 1")->fetchColumn();
$vorsitzer = (int)$pdo->query("SELECT id FROM users WHERE mitgliedernummer='V27655'")->fetchColumn();

/** Legt eine Vollmacht mit zwei Unterzeichnern an, gibt beide ids zurueck. */
function vollmachtAnlegen(PDO $pdo, int $mitglied, int $vorsitzer, string $titel): array
{
    $dir = WEBROOT . '/uploads/signaturen/' . $mitglied;
    if (!is_dir($dir)) { mkdir($dir, 0750, true); }
    $name = 'zweitest_' . bin2hex(random_bytes(6)) . '.pdf';
    $pfad = $dir . '/' . $name;

    $doc = new TCPDF();
    $doc->setPrintHeader(false); $doc->setPrintFooter(false);
    $doc->AddPage(); $doc->SetFont('helvetica','',12);
    $doc->Write(0, "Vollmacht (Test)\n\nWird nach dem Test geloescht.");
    $doc->Output($pfad, 'F');
    chown($pfad,'nginx'); chgrp($pfad,'nginx'); chmod($pfad,0640);
    $hash = hash_file('sha256', $pfad);
    $rel  = 'signaturen/' . $mitglied . '/' . $name;

    $ein = $pdo->prepare(
        "INSERT INTO dokument_signaturen
            (user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
             pdf_pfad, pdf_hash, pdf_seiten, status, gruppe_id, rolle)
         VALUES (?, ?, UTC_TIMESTAMP(), 'vollmacht', ?, ?, ?, 1, 'offen', NULL, ?)"
    );
    $ein->execute([$mitglied, $vorsitzer, $titel, $rel, $hash, 'vollmachtgeber']);
    $a = (int)$pdo->lastInsertId();

    $ein->execute([$vorsitzer, $vorsitzer, $titel, $rel, $hash, 'vollmachtnehmer']);
    $b = (int)$pdo->lastInsertId();

    // Die Gruppe traegt die id der ersten Zeile.
    $pdo->exec("UPDATE dokument_signaturen SET gruppe_id = $a WHERE id IN ($a, $b)");
    return ['a' => $a, 'b' => $b, 'pfad' => $pfad];
}

function unterschreiben(PDO $pdo, int $id): void
{
    $svg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 60">'
         . '<polyline fill="none" stroke="#000" stroke-width="3" points="10,45 60,15 120,45 180,20"/></svg>';
    $prev = SignaturHelper::letzterKettenHash($pdo);
    $pdo->prepare(
        "UPDATE dokument_signaturen
            SET status='signiert', signature_svg=?, signed_at_utc=UTC_TIMESTAMP(),
                ip_address='203.0.113.7', device_id='devkey-zweitest',
                device_hostname='Testgeraet', tan_an='+4917••••1234',
                tan_verified_at=UTC_TIMESTAMP(), prev_hash=?, verify_code=?
          WHERE id=?"
    )->execute([$svg, $prev, SignaturHelper::verifyCode(), $id]);

    $f = $pdo->prepare("SELECT id,user_id,dokument_typ,pdf_hash,signature_svg,signed_at_utc,ip_address,device_id,tan_verified_at FROM dokument_signaturen WHERE id=?");
    $f->execute([$id]);
    $neu = $f->fetch(PDO::FETCH_ASSOC);
    $pdo->prepare("UPDATE dokument_signaturen SET full_hash=? WHERE id=?")
        ->execute([SignaturHelper::kettenHash($neu, $prev), $id]);
}

function cron(): string
{
    exec('/usr/local/bin/php ' . WEBROOT . '/api/cron/seal_signaturen.php 2>&1', $aus);
    return implode("\n", $aus);
}

function spalte(PDO $pdo, int $id, string $s)
{
    $q = $pdo->prepare("SELECT $s FROM dokument_signaturen WHERE id=?");
    $q->execute([$id]);
    return $q->fetchColumn();
}

// ═══ Durchgang 1: beide unterschreiben ═══
echo "=== Durchgang 1: beide unterschreiben ===\n";
$v1 = vollmachtAnlegen($pdo, $mitglied, $vorsitzer, 'Zweitest A — bitte ignorieren');

unterschreiben($pdo, $v1['a']);
cron();
$pruef(spalte($pdo,$v1['a'],'signiert_pdf_pfad') === null,
       'nach der ERSTEN Unterschrift wird NICHT gesiegelt');

$q = $pdo->prepare("SELECT COUNT(*) FROM dokument_signaturen WHERE gruppe_id=? AND id<>? AND status='offen'");
$q->execute([$v1['a'], $v1['a']]);
$pruef((int)$q->fetchColumn() === 1, 'der Erste wartet auf genau einen Mitunterzeichner');

unterschreiben($pdo, $v1['b']);
$ausgabe = cron();
$pfadA = spalte($pdo,$v1['a'],'signiert_pdf_pfad');
$pfadB = spalte($pdo,$v1['b'],'signiert_pdf_pfad');
$pruef($pfadA !== null, 'nach der ZWEITEN Unterschrift wird gesiegelt', (string)$ausgabe);
$pruef($pfadA === $pfadB, 'beide Zeilen zeigen auf dasselbe gesiegelte Dokument');

$ha = spalte($pdo,$v1['a'],'full_hash');
$hb = spalte($pdo,$v1['b'],'full_hash');
$pruef($ha !== $hb && $ha && $hb, 'die beiden Ketten-Hashes sind verschieden');

if ($pfadA) {
    $gesiegelt = WEBROOT . '/uploads/' . $pfadA;
    // Absoluter Pfad: unter PHP-exec ist /usr/local/bin nicht zwingend im PATH.
    // Der erste Anlauf zaehlte deshalb 0 Seiten und meldete einen Fehler, den
    // es nicht gab. Der Siegel-Cron selbst nutzt laengst absolute Pfade.
    exec('/usr/local/bin/pdftk ' . escapeshellarg($gesiegelt) . ' dump_data 2>/dev/null', $p);
    $seiten = 0;
    foreach ($p as $zeile) {
        if (preg_match('/NumberOfPages:\s*(\d+)/', $zeile, $m)) { $seiten = (int)$m[1]; }
    }
    // 1 Originalseite + 2 Unterschriftenblaetter
    $pruef($seiten === 3, 'das Dokument hat ein Blatt JE Unterzeichner', "$seiten Seiten");
    $roh = file_get_contents($gesiegelt);
    $pruef(str_contains($roh,'ByteRange'), 'gesiegelt (Signaturobjekt vorhanden)');
}

// ═══ Durchgang 2: einer unterschreibt, der andere lehnt ab ═══
echo "\n=== Durchgang 2: einer unterschreibt, der andere lehnt ab ===\n";
$v2 = vollmachtAnlegen($pdo, $mitglied, $vorsitzer, 'Zweitest B — bitte ignorieren');

unterschreiben($pdo, $v2['a']);

// Genau das, was aktionAblehnen tut.
$pdo->prepare("UPDATE dokument_signaturen SET status='abgelehnt', abgelehnt_at=UTC_TIMESTAMP(), abgelehnt_grund='Test' WHERE id=? AND status='offen'")
    ->execute([$v2['b']]);
$pdo->prepare("UPDATE dokument_signaturen SET status='abgelehnt', abgelehnt_at=UTC_TIMESTAMP(), abgelehnt_grund='Von einem anderen Unterzeichner abgelehnt' WHERE gruppe_id=? AND status='offen'")
    ->execute([$v2['a']]);

cron();
$pruef(spalte($pdo,$v2['a'],'signiert_pdf_pfad') === null,
       'nach einer Ablehnung wird NIE gesiegelt');
$pruef(spalte($pdo,$v2['a'],'status') === 'signiert',
       'die bereits geleistete Unterschrift bleibt signiert — sie ist eine Tatsache');
$pruef(spalte($pdo,$v2['a'],'full_hash') !== null,
       'ihr Ketten-Hash bleibt stehen');
$pruef(spalte($pdo,$v2['b'],'status') === 'abgelehnt', 'die Ablehnung steht');

// ═══ Regression: der Ein-Unterzeichner-Fall ═══
echo "\n=== Regression: einzelner Unterzeichner ===\n";
$e = vollmachtAnlegen($pdo, $mitglied, $vorsitzer, 'Zweitest C — einzeln');
$pdo->exec("DELETE FROM dokument_signaturen WHERE id={$e['b']}");
$pdo->exec("UPDATE dokument_signaturen SET gruppe_id=NULL, dokument_typ='jobcenter_wba' WHERE id={$e['a']}");
unterschreiben($pdo, $e['a']);
cron();
$pruef(spalte($pdo,$e['a'],'signiert_pdf_pfad') !== null,
       'einzelner Unterzeichner wird weiterhin sofort gesiegelt');

// ═══ Aufraeumen ═══
foreach ([$v1, $v2, $e] as $v) {
    foreach ([$v['a'] ?? 0, $v['b'] ?? 0] as $id) {
        if (!$id) continue;
        $p = spalte($pdo, $id, 'signiert_pdf_pfad');
        if ($p) { @unlink(WEBROOT.'/uploads/'.$p); @unlink(WEBROOT.'/uploads/'.$p.'.tsr'); }
        $pdo->prepare("DELETE FROM dokument_signaturen WHERE id=?")->execute([$id]);
    }
    @unlink($v['pfad']);
}
echo "\nTestdaten entfernt\n";
echo $fehler === 0 ? "\nZWEI UNTERSCHRIFTEN FUNKTIONIEREN\n" : "\n$fehler FEHLER\n";
exit($fehler === 0 ? 0 : 1);
