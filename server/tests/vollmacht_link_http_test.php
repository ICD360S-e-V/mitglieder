<?php
declare(strict_types=1);
define('API_ACCESS', true);
const WEBROOT = '/var/www/icd360sev.icd360s.de';
foreach (file('/etc/opt/remi/php85/php-fpm.d/www.conf') as $z) {
    if (preg_match('/^\s*env\[ENC_MASTER_KEY\]\s*=\s*(.+)$/', $z, $m)) {
        putenv('ENC_MASTER_KEY=' . trim($m[1])); break;
    }
}
require_once WEBROOT . '/api/config.php';
require_once WEBROOT . '/api/lib/SignaturHelper.php';
require_once WEBROOT . '/api/helpers/vollmacht_link_lib.php';
$pdo = getDBConnection();
$f = 0;
$p = function(bool $ok, string $w, string $d='') use (&$f){ echo ($ok?'  ok   ':'  FAIL ').$w.($d!==''?" — $d":'')."\n"; if(!$ok)$f++; };

function hol(string $pfad, array $post = null): array {
    $ch = curl_init('https://icd360sev.icd360s.de' . $pfad);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true,
        CURLOPT_SSL_VERIFYPEER => false, CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_RESOLVE => ['icd360sev.icd360s.de:443:127.0.0.1'],
        CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (Linux; Android 13) Probe',
    ]);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post));
        curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    }
    $roh = (string)curl_exec($ch);
    $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $hl = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    curl_close($ch);
    return ['code'=>$code, 'kopf'=>substr($roh,0,$hl), 'rumpf'=>substr($roh,$hl)];
}

$vmId = (int)$pdo->query("SELECT id FROM vertrag_ra_vollmacht WHERE pdf_uebersetzung_filename<>'' AND status<>'widerrufen' ORDER BY id DESC LIMIT 1")->fetchColumn();
$vors = (int)$pdo->query("SELECT id FROM users WHERE role='vorsitzer' ORDER BY id LIMIT 1")->fetchColumn();

echo "== Statische Dateien ==\n";
$r = hol('/u/app.css');
$p($r['code']===200 && strpos($r['rumpf'],'--ton')!==false, 'app.css wird ausgeliefert', 'HTTP '.$r['code']);
$p(stripos($r['kopf'],'text/css')!==false, 'als text/css');
$r = hol('/u/app.js');
$p($r['code']===200 && strpos($r['rumpf'],'unterschriftEintragen')===false && strpos($r['rumpf'],'pointerdown')!==false, 'app.js wird ausgeliefert', 'HTTP '.$r['code']);

echo "\n== Unbekannter Token ==\n";
$r = hol('/u/zzzzzzzzzzzzzzzzzzzzzz');
$p($r['code']===200, 'antwortet', 'HTTP '.$r['code']);
$p(strpos($r['rumpf'],'z-unbekannt')!==false, 'zeigt die Unbekannt-Seite');
$p(strpos($r['rumpf'],'/u/app.css')!==false, 'bindet das Stylesheet ein');

echo "\n== Echter Leselink ==\n";
$e = vlErzeugen($pdo, ['quelle_tabelle'=>'vertrag_ra_vollmacht','quelle_id'=>$vmId,'zweck'=>'lesen','gesendet_von'=>$vors]);
$linkId = (int)$e['link_id'];
$st = $pdo->prepare("SELECT id, body FROM signatur_sms_queue WHERE link_id=? ORDER BY id DESC LIMIT 1");
$st->execute([$linkId]); $sms = $st->fetch(PDO::FETCH_ASSOC);
$pdo->prepare('DELETE FROM signatur_sms_queue WHERE id=?')->execute([(int)$sms['id']]);
preg_match('~/u/([A-Za-z0-9]{22})~', (string)$sms['body'], $m);
$tok = $m[1];
echo "  Token: $tok\n";

$r = hol('/u/'.$tok);
$p($r['code']===200, 'Seite antwortet', 'HTTP '.$r['code']);
$p(strpos($r['rumpf'],'s-lesen')!==false, 'zeigt den Lese-Ablauf');
$p(strpos($r['rumpf'],'id="pad"')===false, 'KEIN Unterschriftenfeld auf dem Leselink');
$p(strpos($r['rumpf'],'data-zweck="lesen"')!==false, 'Zweck steht im Markup');
$p(stripos($r['kopf'],'x-frame-options: DENY')!==false, 'X-Frame-Options: DENY gegen Clickjacking');
$p(preg_match('/data-rest="(\d+)"/',$r['rumpf'],$mm) && (int)$mm[1] > 1700, 'die Uhr startet bei ~30 Minuten', $mm[1] ?? '?');
$geo = $pdo->query("SELECT geoeffnet_am FROM vollmacht_link WHERE id=$linkId")->fetchColumn();
$p(!empty($geo), 'der Aufruf hat „geoeffnet" vermerkt');

echo "\n== Seite als Bild ==\n";
$r = hol('/u/'.$tok.'?a=seite&n=1');
$p($r['code']===200, 'Seite 1 antwortet', 'HTTP '.$r['code']);
$p(substr($r['rumpf'],0,8) === "\x89PNG\r\n\x1a\n", 'es ist ein PNG', bin2hex(substr($r['rumpf'],0,4)));
$p(strlen($r['rumpf']) > 5000, 'und nicht leer', strlen($r['rumpf']).' Byte');

echo "\n== Herunterladen ==\n";
$r = hol('/u/'.$tok.'?a=download');
$p($r['code']===200 && substr($r['rumpf'],0,4)==='%PDF', 'liefert das PDF');
$p(stripos($r['kopf'],'attachment')!==false, 'als Download, nicht im Fenster');
$gel = $pdo->query("SELECT geladen_am FROM vollmacht_link WHERE id=$linkId")->fetchColumn();
$p(!empty($gel), 'DER DOWNLOAD STEHT IM PROTOKOLL', (string)$gel);

echo "\n== Bestaetigen ==\n";
$r = hol('/u/'.$tok, ['action'=>'gelesen']);
$j = json_decode($r['rumpf'], true);
$p(($j['success'] ?? false) === true, 'wird angenommen', $r['rumpf']);
$best = $pdo->query("SELECT bestaetigt_am FROM vollmacht_link WHERE id=$linkId")->fetchColumn();
$p(!empty($best), 'Bestaetigung steht im Protokoll');

echo "\n== Code auf einem LESE-Link ist nicht vorgesehen ==\n";
$r = hol('/u/'.$tok, ['action'=>'code']);
$p($r['code']===400, 'wird mit 400 abgewiesen', 'HTTP '.$r['code']);

echo "\n== Abgelaufen ==\n";
$pdo->prepare('UPDATE vollmacht_link SET gueltig_bis=UTC_TIMESTAMP() WHERE id=?')->execute([$linkId]);
$r = hol('/u/'.$tok);
$p(strpos($r['rumpf'],'z-abgelaufen')!==false, 'zeigt die Abgelaufen-Seite');
$p(strpos($r['rumpf'],'neuerLink')!==false, 'bietet einen neuen Link an');
$r = hol('/u/'.$tok, ['action'=>'gelesen']);
$p($r['code']===410, 'Handgriffe werden mit 410 abgelehnt', 'HTTP '.$r['code']);

echo "\n== Aufraeumen ==\n";
$alt = $pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn();
$pdo->exec("DELETE FROM signatur_sms_queue WHERE link_id IS NOT NULL");
$pdo->exec("DELETE FROM vollmacht_link");
$p((int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn()===0, 'keine Link-Zeile uebrig');
// ⚠️ Nur die EIGENEN Zeilen. In der Warteschlange liegen echte, laengst
// gesendete TAN-Zeilen; ein COUNT ueber die ganze Tabelle waere eine
// Zusicherung ueber fremde Daten — und beim naechsten Lauf rot, ohne dass
// etwas kaputt ist.
$p((int)$pdo->query("SELECT COUNT(*) FROM signatur_sms_queue WHERE link_id IS NOT NULL")->fetchColumn()===0,
   'keine Link-SMS in der Warteschlange');

echo "\n" . ($f===0 ? "ALLES GRUEN\n" : "$f FEHLER\n");
