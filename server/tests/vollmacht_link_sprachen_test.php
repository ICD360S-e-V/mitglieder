<?php
/** Prueft, ob alle Sprachtabellen der Link-Seite dieselben Schluessel tragen. */
declare(strict_types=1);
define('API_ACCESS', true);
require_once '/var/www/icd360sev.icd360s.de/api/config.php';
$quelle = file_get_contents('/var/www/icd360sev.icd360s.de/api/public/vollmacht_link.php');
// vlText() herausschneiden und auswerten
preg_match('/function vlText\(string \$sprache\): array\s*\{(.*?)\n\}/s', $quelle, $m);
eval('function vlTextProbe(string $sprache): array {' . $m[1] . "\n}");

// Alle 28 Werte des ENUM users.preferred_language.
$sprachen = ['de','en','ro','ru','uk','tr','ar','fr','es','it','pl','nl','pt','cs','sk','hu',
             'bg','hr','sr','sl','el','da','sv','nb','fi','et','lt','lv'];
$tab = [];
foreach ($sprachen as $s) { $tab[$s] = vlTextProbe($s); }

$leit = array_keys($tab['de']);
echo "Deutsch traegt " . count($leit) . " Schluessel.\n\n";
$fehler = 0;
foreach ($sprachen as $s) {
    $fehlt  = array_diff($leit, array_keys($tab[$s]));
    $zuviel = array_diff(array_keys($tab[$s]), $leit);
    // Ein Wert, der wortgleich mit dem deutschen ist, ist verdaechtig —
    // ausser bei Deutsch selbst und bei Zeichen wie „/".
    $gleich = [];
    if ($s !== 'de') {
        foreach ($leit as $k) {
            if (isset($tab[$s][$k]) && $tab[$s][$k] === $tab['de'][$k] && mb_strlen($tab['de'][$k]) > 3) {
                $gleich[] = $k;
            }
        }
    }
    $ok = !$fehlt && !$zuviel && !$gleich;
    printf("  %-3s %s  %d Schluessel%s%s%s\n", $s, $ok ? 'ok  ' : 'FAIL', count($tab[$s]),
        $fehlt ? '  FEHLT: ' . implode(',', $fehlt) : '',
        $zuviel ? '  ZUVIEL: ' . implode(',', $zuviel) : '',
        $gleich ? '  DEUTSCH GEBLIEBEN: ' . implode(',', $gleich) : '');
    if (!$ok) { $fehler++; }
}

// Gegenprobe gegen das ENUM: keine Sprache darf fehlen, keine zuviel sein.
$pdo = getDBConnection();
$typ = (string)$pdo->query("SHOW COLUMNS FROM users LIKE 'preferred_language'")
                   ->fetch(PDO::FETCH_ASSOC)['Type'];
preg_match_all("/'([a-z]{2})'/", $typ, $mm);
$enum = $mm[1];
$fehltEnum = array_diff($enum, $sprachen);
$zuvielEnum = array_diff($sprachen, $enum);
echo "\nENUM traegt " . count($enum) . " Sprachen, geprueft wurden " . count($sprachen) . ".\n";
if ($fehltEnum) { echo "  FAIL im ENUM, aber ohne Tabelle: " . implode(',', $fehltEnum) . "\n"; $fehler++; }
elseif ($zuvielEnum) { echo "  FAIL Tabelle ohne ENUM-Eintrag: " . implode(',', $zuvielEnum) . "\n"; $fehler++; }
else { echo "  ok   jede ENUM-Sprache hat eine Tabelle\n"; }


// ── SMS-Vorlagen: alle 28, und GSM-7-tauglich ──────────────────────
require_once '/var/www/icd360sev.icd360s.de/api/helpers/vollmacht_link_lib.php';
echo "\nSMS-Vorlagen:\n";
foreach (['lesen','signieren'] as $zweck) {
    $schlecht = [];
    foreach ($sprachen as $s) {
        $txt = vlSmsText($s, $zweck, 'https://icd360sev.icd360s.de/u/0123456789abcdefghijkl', 'Muster');
        // ⚠️ Alles ausserhalb von ASCII zwingt die SMS auf UCS-2 (67 statt 160
        // Zeichen je Segment). `SmsService.sanitize` auf dem Tablet
        // normalisiert nur Typografie — es transliteriert NICHT.
        if (preg_match('/[^\x20-\x7E\n]/', $txt)) {
            $schlecht[] = $s . ' (' . preg_replace('/[\x20-\x7E\n]/', '', $txt) . ')';
        }
        // Faellt eine Sprache still auf Deutsch zurueck?
        if ($s !== 'de' && $txt === vlSmsText('de', $zweck, 'https://icd360sev.icd360s.de/u/0123456789abcdefghijkl', 'Muster')) {
            $schlecht[] = $s . ' (deutsch geblieben)';
        }
    }
    printf("  %-10s %s%s\n", $zweck, $schlecht ? 'FAIL  ' : 'ok    alle 28 rein ASCII',
           $schlecht ? implode(', ', $schlecht) : '');
    if ($schlecht) { $fehler++; }
}

echo "\n" . ($fehler === 0 ? "ALLE 28 VOLLSTAENDIG\n" : "$fehler Befund(e)\n");
