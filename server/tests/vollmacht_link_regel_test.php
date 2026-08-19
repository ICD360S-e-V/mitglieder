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

function hol(string $pfad, array $post=null): array {
    $ch=curl_init('https://icd360sev.icd360s.de'.$pfad);
    curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_HEADER=>true,
      CURLOPT_SSL_VERIFYPEER=>false,CURLOPT_SSL_VERIFYHOST=>false,
      CURLOPT_RESOLVE=>['icd360sev.icd360s.de:443:127.0.0.1'],CURLOPT_TIMEOUT=>30]);
    if ($post!==null) { curl_setopt($ch,CURLOPT_POST,true);
      curl_setopt($ch,CURLOPT_POSTFIELDS,json_encode($post));
      curl_setopt($ch,CURLOPT_HTTPHEADER,['Content-Type: application/json']); }
    $r=(string)curl_exec($ch); $c=curl_getinfo($ch,CURLINFO_HTTP_CODE);
    $hl=curl_getinfo($ch,CURLINFO_HEADER_SIZE); curl_close($ch);
    return ['code'=>$c,'rumpf'=>substr($r,$hl)];
}

$vmId=(int)$pdo->query("SELECT id FROM vertrag_ra_vollmacht WHERE pdf_uebersetzung_filename<>'' AND status<>'widerrufen' ORDER BY id DESC LIMIT 1")->fetchColumn();
$vors=(int)$pdo->query("SELECT id FROM users WHERE role='vorsitzer' ORDER BY id LIMIT 1")->fetchColumn();
$mit =(int)$pdo->query("SELECT user_id FROM vertrag_ra_vollmacht WHERE id=$vmId")->fetchColumn();
$meine=[];

function mach(PDO $pdo, int $vmId, int $vors, string $zweck, array &$meine): string {
    $e=vlErzeugen($pdo,['quelle_tabelle'=>'vertrag_ra_vollmacht','quelle_id'=>$vmId,
                        'zweck'=>$zweck,'gesendet_von'=>$vors]);
    if (!$e['ok']) return '';
    $lid=(int)$e['link_id']; $meine[]=$lid;
    $st=$pdo->prepare("SELECT id,body FROM signatur_sms_queue WHERE link_id=? ORDER BY id DESC LIMIT 1");
    $st->execute([$lid]); $s=$st->fetch(PDO::FETCH_ASSOC);
    $pdo->prepare('DELETE FROM signatur_sms_queue WHERE id=?')->execute([(int)$s['id']]);
    preg_match('~/u/([A-Za-z0-9]{22})~',(string)$s['body'],$m);
    return $m[1] ?? '';
}

echo "== LESE-Link: Selbstbedienung erlaubt ==\n";
$tokL = mach($pdo,$vmId,$vors,'lesen',$meine);
$lid = end($meine);
$pdo->prepare('UPDATE vollmacht_link SET gueltig_bis=UTC_TIMESTAMP() WHERE id=?')->execute([$lid]);
$r = hol("/u/$tokL");
$p(strpos($r['rumpf'],'neuerLink')!==false, 'der Knopf ist da');
$vorher=(int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn();
$r = hol("/u/$tokL", ['action'=>'neuer_link']);
$j=json_decode($r['rumpf'],true);
$p(($j['success']??false)===true, 'ein neuer Link geht raus', (string)($j['message']??''));
$nachher=(int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn();
$p($nachher===$vorher+1, 'und ist wirklich angelegt', "$vorher -> $nachher");
foreach ($pdo->query("SELECT id FROM vollmacht_link WHERE quelle_id=$vmId")->fetchAll(PDO::FETCH_COLUMN) as $x) {
    if (!in_array((int)$x,$meine,true)) $meine[]=(int)$x;
}

echo "\n== SIGNIER-Link: nur der Vorstand ==\n";
// Eine offene Unterschrift anlegen, damit der Link ueberhaupt entsteht.
$pdo->prepare("INSERT INTO dokument_signaturen
   (user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
    pdf_pfad, pdf_hash, status, quelle_tabelle, quelle_id)
   VALUES (?,?,UTC_TIMESTAMP(),'probe_regel','Probe Regel','p/x.pdf',?, 'offen','vertrag_ra_vollmacht',?)")
   ->execute([$mit,$vors,str_repeat('b',64),$vmId]);
$sigId=(int)$pdo->lastInsertId();
$tokS = mach($pdo,$vmId,$vors,'signieren',$meine);
$p($tokS!=='', 'der Vorstand kann ihn anlegen');
$lidS = end($meine);
$pdo->prepare('UPDATE vollmacht_link SET gueltig_bis=UTC_TIMESTAMP() WHERE id=?')->execute([$lidS]);
$r = hol("/u/$tokS");
$p(strpos($r['rumpf'],'neuerLink')===false, 'KEIN Selbstbedienungsknopf auf der Seite');
// ⚠️ Nicht nach deutschem Text suchen: die Seite steht in der Sprache des
// MITGLIEDS. Die erste Fassung dieses Tests suchte „Verein" und fiel bei
// einem russischsprachigen Mitglied durch, obwohl die Seite richtig war.
// Geprueft wird deshalb gegen die Zeichenkette der jeweiligen Sprache.
$spr = (string)$pdo->query("SELECT preferred_language FROM users WHERE id=$mit")->fetchColumn();
$q = file_get_contents(WEBROOT.'/api/public/vollmacht_link.php');
preg_match('/function vlText\(string \$sprache\): array\s*\{(.*?)\n\}/s', $q, $mm);
eval('function tt(string $sprache): array {' . $mm[1] . '}');
$erwartet = tt($spr)['neu_nur_vorstand'];
$p(strpos($r['rumpf'], htmlspecialchars($erwartet, ENT_QUOTES, 'UTF-8')) !== false,
   'der Grund steht da, in der Sprache des Mitglieds', "$spr: " . mb_substr($erwartet, 0, 45) . '…');
$vorher=(int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn();
$r = hol("/u/$tokS", ['action'=>'neuer_link']);
$j=json_decode($r['rumpf'],true);
$p($r['code']===403 && ($j['success']??true)===false, 'die Aktion wird mit 403 abgelehnt', 'HTTP '.$r['code']);
$p(($j['grund']??'')==='nur_vorstand', 'mit benennbarem Grund');
$nachher=(int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn();
$p($nachher===$vorher, 'und es entsteht KEIN neuer Link', "$vorher -> $nachher");

echo "\n== Aufraeumen ==\n";
$pdo->exec("DELETE FROM signatur_sms_queue WHERE link_id IS NOT NULL");
$pdo->exec("DELETE FROM vollmacht_link");
$pdo->exec("DELETE FROM signatur_tan WHERE signatur_id=$sigId");
$pdo->exec("DELETE FROM dokument_signaturen WHERE id=$sigId");
$p((int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn()===0,'keine Link-Zeile uebrig');
$p((int)$pdo->query("SELECT COUNT(*) FROM dokument_signaturen WHERE dokument_typ='probe_regel'")->fetchColumn()===0,'keine Probesignatur uebrig');
echo "\n".($f===0?"ALLES GRUEN\n":"$f FEHLER\n");
