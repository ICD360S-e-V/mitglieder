<?php
declare(strict_types=1); define('API_ACCESS', true);
const WEBROOT='/var/www/icd360sev.icd360s.de';
foreach (file('/etc/opt/remi/php85/php-fpm.d/www.conf') as $z) {
  if (preg_match('/^\s*env\[ENC_MASTER_KEY\]\s*=\s*(.+)$/',$z,$m)) { putenv('ENC_MASTER_KEY='.trim($m[1])); break; }
}
require_once WEBROOT.'/api/config.php';
require_once WEBROOT.'/api/lib/SignaturHelper.php';
require_once WEBROOT.'/api/helpers/vollmacht_link_lib.php';
$pdo=getDBConnection(); $f=0;
$p=function(bool $ok,string $w,string $d='') use(&$f){ echo ($ok?'  ok   ':'  FAIL ').$w.($d!==''?" — $d":'')."\n"; if(!$ok)$f++; };

/** Ein „Geraet": eigene Krümeldose. */
function geraet(string $keksdatei, string $pfad, array $post=null, bool $alsBrowser=true): array {
    $ch=curl_init('https://icd360sev.icd360s.de'.$pfad);
    $kopf = $alsBrowser ? ['Accept: text/html,application/xhtml+xml'] : ['Accept: image/png'];
    if ($post!==null) $kopf[]='Content-Type: application/json';
    curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_HEADER=>true,
      CURLOPT_SSL_VERIFYPEER=>false,CURLOPT_SSL_VERIFYHOST=>false,
      CURLOPT_RESOLVE=>['icd360sev.icd360s.de:443:127.0.0.1'],CURLOPT_TIMEOUT=>30,
      CURLOPT_COOKIEJAR=>$keksdatei, CURLOPT_COOKIEFILE=>$keksdatei,
      CURLOPT_HTTPHEADER=>$kopf,
      CURLOPT_USERAGENT=>'Mozilla/5.0 (Linux; Android 13) Probe']);
    if ($post!==null) { curl_setopt($ch,CURLOPT_POST,true); curl_setopt($ch,CURLOPT_POSTFIELDS,json_encode($post)); }
    $r=(string)curl_exec($ch); $c=curl_getinfo($ch,CURLINFO_HTTP_CODE);
    $hl=curl_getinfo($ch,CURLINFO_HEADER_SIZE); curl_close($ch);
    return ['code'=>$c,'kopf'=>substr($r,0,$hl),'rumpf'=>substr($r,$hl)];
}

$vmId=(int)$pdo->query("SELECT id FROM vertrag_ra_vollmacht WHERE pdf_uebersetzung_filename<>'' AND status<>'widerrufen' ORDER BY id DESC LIMIT 1")->fetchColumn();
$vors=(int)$pdo->query("SELECT id FROM users WHERE role='vorsitzer' ORDER BY id LIMIT 1")->fetchColumn();
$e=vlErzeugen($pdo,['quelle_tabelle'=>'vertrag_ra_vollmacht','quelle_id'=>$vmId,'zweck'=>'lesen','gesendet_von'=>$vors]);
$lid=(int)$e['link_id'];
$st=$pdo->prepare("SELECT id,body FROM signatur_sms_queue WHERE link_id=? ORDER BY id DESC LIMIT 1");
$st->execute([$lid]); $s=$st->fetch(PDO::FETCH_ASSOC);
$pdo->prepare('DELETE FROM signatur_sms_queue WHERE id=?')->execute([(int)$s['id']]);
preg_match('~/u/([A-Za-z0-9]{22})~',(string)$s['body'],$m); $tok=$m[1];
echo "Token: $tok\n";

$A='/tmp/vl_keks_a.txt'; $B='/tmp/vl_keks_b.txt';
@unlink($A); @unlink($B);

echo "\n== Vorschau-Abruf bindet NICHT ==\n";
// Ein Abruf ohne Wunsch nach einer Seite — wie ihn eine Nachrichten-App macht.
$r = geraet('/tmp/vl_keks_bot.txt', "/u/$tok", null, false);
$geb = $pdo->query("SELECT sitzung_hash FROM vollmacht_link WHERE id=$lid")->fetchColumn();
$p(empty($geb), 'nach dem Vorschau-Abruf ist noch nichts gebunden');
@unlink('/tmp/vl_keks_bot.txt');

echo "\n== Geraet A oeffnet zuerst ==\n";
$r = geraet($A, "/u/$tok");
$p($r['code']===200 && strpos($r['rumpf'],'s-lesen')!==false, 'A bekommt die Seite');
$p(stripos($r['kopf'],'set-cookie: vlsig')!==false, 'A bekommt eine Sitzung');
$geb = (string)$pdo->query("SELECT sitzung_hash FROM vollmacht_link WHERE id=$lid")->fetchColumn();
$p(strlen($geb)===64, 'der Link ist jetzt gebunden');
$ip = (string)$pdo->query("SELECT gebunden_ip FROM vollmacht_link WHERE id=$lid")->fetchColumn();
$p($ip!=='', 'mit Abdruck, wer gebunden hat', $ip);

echo "\n== A darf weitermachen ==\n";
$r = geraet($A, "/u/$tok?a=seite&n=1", null, false);
$p($r['code']===200 && substr($r['rumpf'],0,4)==="\x89PNG", 'A sieht die Seiten');
$r = geraet($A, "/u/$tok?a=download", null, false);
$p($r['code']===200 && substr($r['rumpf'],0,4)==='%PDF', 'A kann herunterladen');
$r = geraet($A, "/u/$tok", ['action'=>'gelesen']);
$p(($json=json_decode($r['rumpf'],true)) && ($json['success']??false)===true, 'A kann bestaetigen');

echo "\n== Geraet B — der weitergeleitete Link ==\n";
$r = geraet($B, "/u/$tok");
$p($r['code']===200 && strpos($r['rumpf'],'z-fremd')!==false, 'B bekommt die Sperrseite');
$p(strpos($r['rumpf'],'s-lesen')===false, 'B sieht das Dokument NICHT');
$r = geraet($B, "/u/$tok?a=seite&n=1", null, false);
$p($r['code']===403, 'B bekommt auch die Bilder nicht', 'HTTP '.$r['code']);
$r = geraet($B, "/u/$tok?a=download", null, false);
$p($r['code']===403, 'und den Download nicht', 'HTTP '.$r['code']);
$r = geraet($B, "/u/$tok", ['action'=>'gelesen']);
$p($r['code']===403, 'und keine Handgriffe', 'HTTP '.$r['code']);
$fz = (int)$pdo->query("SELECT fremdzugriffe FROM vollmacht_link WHERE id=$lid")->fetchColumn();
$p($fz>0, 'der Fremdzugriff ist gezaehlt', "fremdzugriffe=$fz");

echo "\n== Selbstbedienung ist weg — auch beim Lesen ==\n";
$r = geraet($A, "/u/$tok", ['action'=>'neuer_link']);
$p($r['code']===403, 'auch A bekommt keinen neuen Link', 'HTTP '.$r['code']);
$j=json_decode($r['rumpf'],true);
$p(($j['grund']??'')==='nur_vorstand', 'mit benennbarem Grund');
$anzahl=(int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn();
$p($anzahl===1, 'es ist kein zweiter Link entstanden', "links=$anzahl");

echo "\n== Aufraeumen ==\n";
@unlink($A); @unlink($B);
$pdo->exec("DELETE FROM signatur_sms_queue WHERE link_id IS NOT NULL");
$pdo->exec("DELETE FROM vollmacht_link");
$p((int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn()===0,'keine Link-Zeile uebrig');
echo "\n".($f===0?"ALLES GRUEN\n":"$f FEHLER\n");
