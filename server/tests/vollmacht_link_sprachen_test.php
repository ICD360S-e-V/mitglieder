<?php
/** Prueft, ob alle Sprachtabellen der Link-Seite dieselben Schluessel tragen. */
declare(strict_types=1);
$quelle = file_get_contents('/var/www/icd360sev.icd360s.de/api/public/vollmacht_link.php');
// vlText() herausschneiden und auswerten
preg_match('/function vlText\(string \$sprache\): array\s*\{(.*?)\n\}/s', $quelle, $m);
eval('function vlTextProbe(string $sprache): array {' . $m[1] . "\n}");

$sprachen = ['de','ro','en','ru','uk','tr','ar'];
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

// Und: faellt eine unbekannte Sprache still auf Deutsch?
$fremd = vlTextProbe('pl');
echo "\nUnbekannte Sprache 'pl' (im ENUM erlaubt, aber ohne Tabelle):\n";
echo "  liefert: \"" . $fremd['titel_lesen'] . "\"" .
     ($fremd === $tab['de'] ? "  → identisch mit Deutsch\n" : "\n");

echo "\n" . ($fehler === 0 ? "ALLE SIEBEN VOLLSTAENDIG\n" : "$fehler unvollstaendig\n");
