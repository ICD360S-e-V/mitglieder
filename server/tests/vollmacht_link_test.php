<?php
/**
 * Probe fuer den SMS-Link-Weg, Ende zu Ende, OHNE eine SMS zu verschicken.
 *
 * ⚠️ Die Zeile in signatur_sms_queue wird angelegt (der Weg soll ja echt
 * geprueft werden), aber SOFORT wieder entfernt, bevor das Tablet sie holen
 * kann. Sie ginge sonst an ein echtes Mitglied.
 *
 * ⚠️ Raeumt alles Eigene weg und weist das nach.
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
require_once WEBROOT . '/api/lib/SignaturHelper.php';
require_once WEBROOT . '/api/helpers/vollmacht_link_lib.php';

$pdo = getDBConnection();
$fehler = 0;
$p = function (bool $ok, string $was, string $d = '') use (&$fehler) {
    echo ($ok ? '  ok   ' : '  FAIL ') . $was . ($d !== '' ? " — $d" : '') . "\n";
    if (!$ok) $fehler++;
};

// Eine echte Vollmacht mit Uebersetzung suchen.
$vm = $pdo->query(
    "SELECT id, user_id, uebersetzung_sprache FROM vertrag_ra_vollmacht
      WHERE pdf_uebersetzung_filename <> '' AND status <> 'widerrufen'
   ORDER BY id DESC LIMIT 1")->fetch(PDO::FETCH_ASSOC);
if (!$vm) { exit("Keine RA-Vollmacht mit Uebersetzung gefunden\n"); }
$vmId = (int)$vm['id'];
echo "Vollmacht #$vmId, Leseexemplar auf '" . $vm['uebersetzung_sprache'] . "'\n";

$vorsitzer = (int)$pdo->query("SELECT id FROM users WHERE role='vorsitzer' ORDER BY id LIMIT 1")
                      ->fetchColumn();
$meineLinks = [];

/** Holt den Klartext-Token aus der gerade erzeugten SMS-Zeile und raeumt sie weg. */
$tokenAusSms = function (int $linkId) use ($pdo): string {
    $st = $pdo->prepare("SELECT id, body FROM signatur_sms_queue WHERE link_id = ?
                          ORDER BY id DESC LIMIT 1");
    $st->execute([$linkId]);
    $z = $st->fetch(PDO::FETCH_ASSOC);
    if (!$z) return '';
    // ⚠️ SOFORT weg — sonst holt das Tablet sie und ein Mitglied bekommt eine
    // Probe-SMS.
    $pdo->prepare('DELETE FROM signatur_sms_queue WHERE id = ?')->execute([(int)$z['id']]);
    return preg_match('~/u/([A-Za-z0-9]{10,})~', (string)$z['body'], $m) ? $m[1] : '';
};

echo "\n== 1. Leselink erzeugen ==\n";
$r = vlErzeugen($pdo, ['quelle_tabelle' => 'vertrag_ra_vollmacht', 'quelle_id' => $vmId,
                       'zweck' => 'lesen', 'gesendet_von' => $vorsitzer]);
$p($r['ok'] === true, 'wird angelegt', $r['meldung'] ?? '');
if (!$r['ok']) { exit("\nAbbruch\n"); }
$linkId = (int)$r['link_id'];
$meineLinks[] = $linkId;
$p(strpos((string)$r['gesendet_an'], '•') !== false, 'Nummer maskiert gemeldet', (string)$r['gesendet_an']);
$token = $tokenAusSms($linkId);
$p($token !== '' && strlen($token) === 22, 'Token steht in der SMS', 'len=' . strlen($token));

echo "\n== 2. Token aufloesen ==\n";
$a = vlAufloesen($pdo, $token);
$p($a['status'] === 'ok', 'gueltiger Token wird erkannt', $a['status']);
$p((int)$a['link']['id'] === $linkId, 'es ist derselbe Link');
$p(vlAufloesen($pdo, 'xxxxxxxxxxxxxxxxxxxxxx')['status'] === 'unbekannt', 'fremder Token: unbekannt');
$p(vlAufloesen($pdo, '')['status'] === 'unbekannt', 'leerer Token: unbekannt');

echo "\n== 3. Das Dokument haengt dran ==\n";
$dok = vlDokument($pdo, $a['link']);
$p($dok !== null, 'PDF wird geliefert');
$p($dok !== null && substr($dok['inhalt'], 0, 4) === '%PDF', 'es ist wirklich ein PDF',
   $dok === null ? '' : substr($dok['inhalt'], 0, 4));
$p($a['link']['fassung'] === 'uebersetzung', 'es ist das Leseexemplar', (string)$a['link']['fassung']);

echo "\n== 4. Oeffnen, Herunterladen, Bestaetigen ==\n";
vlGeoeffnet($pdo, $linkId);
vlGeladen($pdo, $linkId);
vlBestaetigt($pdo, $linkId);
$z = $pdo->query("SELECT geoeffnet_am, geladen_am, bestaetigt_am FROM vollmacht_link WHERE id=$linkId")
         ->fetch(PDO::FETCH_ASSOC);
$p(!empty($z['geoeffnet_am']), 'geoeffnet ist vermerkt');
$p(!empty($z['geladen_am']),   'HERUNTERGELADEN ist vermerkt');
$p(!empty($z['bestaetigt_am']),'bestaetigt ist vermerkt');
// Nur beim ersten Mal.
$vorher = $z['geladen_am'];
sleep(1);
vlGeladen($pdo, $linkId);
$nach = $pdo->query("SELECT geladen_am FROM vollmacht_link WHERE id=$linkId")->fetchColumn();
$p($vorher === $nach, 'ein zweiter Download ueberschreibt den ersten Zeitpunkt nicht');

echo "\n== 5. Das Protokoll zeigt es ==\n";
$prot = vlProtokoll($pdo, 'vertrag_ra_vollmacht', $vmId);
$p(count($prot) >= 1, 'der Link steht im Protokoll', count($prot) . ' Zeile(n)');
$erste = $prot[0];
$p($erste['zweck'] === 'lesen', 'Zweck steht drin', (string)$erste['zweck']);
$p(!empty($erste['geladen_am']), 'der Download steht drin');
$p(strpos((string)$erste['gesendet_an'], '•') !== false, 'Nummer im Protokoll maskiert',
   (string)$erste['gesendet_an']);
$p(!isset($erste['token_hash']), 'der Token kommt NICHT mit');

echo "\n== 6. Signier-Link ohne gestellte Unterschrift ==\n";
$r2 = vlErzeugen($pdo, ['quelle_tabelle' => 'vertrag_ra_vollmacht', 'quelle_id' => $vmId,
                        'zweck' => 'signieren', 'gesendet_von' => $vorsitzer]);
// Entweder es gibt eine offene Zeile (dann ok) oder nicht (dann sauber abgelehnt).
if ($r2['ok']) {
    $meineLinks[] = (int)$r2['link_id'];
    $tokenAusSms((int)$r2['link_id']);
    $sid = (int)$pdo->query("SELECT signatur_id FROM vollmacht_link WHERE id=" . (int)$r2['link_id'])
                    ->fetchColumn();
    $p($sid > 0, 'der Link haengt an einer offenen Unterschrift', "signatur_id=$sid");
} else {
    $p(($r2['grund'] ?? '') === 'nicht_gestellt',
       'ohne gestellte Unterschrift wird abgelehnt', (string)($r2['meldung'] ?? ''));
}

echo "\n== 7. Ablauf ==\n";
$pdo->prepare('UPDATE vollmacht_link SET gueltig_bis = UTC_TIMESTAMP() WHERE id = ?')
    ->execute([$linkId]);
$ab = vlAufloesen($pdo, $token);
$p($ab['status'] === 'abgelaufen', 'nach 30 Minuten: abgelaufen', $ab['status']);
$p(vlDokument($pdo, $ab['link']) !== null, 'das Dokument selbst bleibt unveraendert da');

echo "\n== Aufraeumen ==\n";
$ids = implode(',', array_map('intval', $meineLinks));
$pdo->exec("DELETE FROM signatur_sms_queue WHERE link_id IN ($ids)");
$pdo->exec("DELETE FROM vollmacht_link WHERE id IN ($ids)");
$p((int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link WHERE id IN ($ids)")->fetchColumn() === 0,
   'eigene Links weg');
$p((int)$pdo->query("SELECT COUNT(*) FROM vollmacht_link")->fetchColumn() === 0,
   'keine Link-Zeile uebrig');
$p((int)$pdo->query("SELECT COUNT(*) FROM signatur_sms_queue WHERE link_id IS NOT NULL")->fetchColumn() === 0,
   'keine Link-SMS in der Warteschlange');

echo "\n" . ($fehler === 0 ? "ALLES GRUEN\n" : "$fehler FEHLER\n");
exit($fehler === 0 ? 0 : 1);
