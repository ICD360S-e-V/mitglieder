<?php
/**
 * Der Fall, den Rückwärtsprüfen prinzipiell nicht findet: am ENDE der Kette
 * fehlt etwas.
 *
 * Stellt genau den Ablauf aus dem Befund nach — Kette 1..4 anlegen, das letzte
 * Glied löschen — und zeigt, dass jede verbliebene Zeile weiterhin „unversehrt"
 * und „lückenlos verkettet" meldet, der Anker es aber bemerkt.
 *
 * Läuft gegen icd360sev_test_db.
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
require_once getenv('SIGNATUR_HELPER') ?: WEBROOT . '/api/lib/SignaturHelper.php';

$pdo = new PDO(
    'mysql:unix_socket=/var/lib/mysql/mysql.sock;dbname=icd360sev_test_db;charset=utf8mb4',
    DB_USER, DB_PASS,
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
);

$fehler = 0;
$pruef = function (bool $ok, string $was, string $detail = '') use (&$fehler) {
    echo ($ok ? '  ok   ' : '  FAIL ') . $was . ($detail !== '' ? " — $detail" : '') . "\n";
    if (!$ok) { $fehler++; }
};

// Saubere Ausgangslage: nur die Zeilen dieses Tests, Anker auf 0.
$pdo->exec("DELETE FROM dokument_signaturen WHERE dokument_titel LIKE 'Ankerprobe%'");
$pdo->exec("UPDATE signatur_kette_stand SET letzte_nr = 0 WHERE id = 1");
$pdo->exec("DELETE FROM dokument_signaturen");

function unterschreiben(PDO $pdo, string $titel): int
{
    $ein = $pdo->prepare(
        "INSERT INTO dokument_signaturen
            (user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
             pdf_pfad, pdf_hash, pdf_seiten, status)
         VALUES (11, 2, UTC_TIMESTAMP(), 'jobcenter_wba', ?, 'x.pdf', SHA2(?,256), 1, 'offen')"
    );
    $ein->execute([$titel, $titel]);
    $id = (int)$pdo->lastInsertId();

    // Genau wie im Endpunkt.
    $glied = SignaturHelper::vorherigesGlied($pdo);
    $nr = $glied['nr'] + 1;

    $pdo->prepare(
        "UPDATE dokument_signaturen
            SET status='signiert', signature_svg='<svg/>', signed_at_utc=UTC_TIMESTAMP(),
                ip_address='203.0.113.9', device_id='anker', tan_verified_at=UTC_TIMESTAMP(),
                prev_hash=?, ketten_nr=? WHERE id=?"
    )->execute([$glied['hash'], $nr, $id]);

    $f = $pdo->prepare(
        "SELECT id,user_id,dokument_typ,pdf_hash,signature_svg,signed_at_utc,
                ip_address,device_id,tan_verified_at FROM dokument_signaturen WHERE id=?"
    );
    $f->execute([$id]);
    $pdo->prepare("UPDATE dokument_signaturen SET full_hash=? WHERE id=?")
        ->execute([SignaturHelper::kettenHash($f->fetch(), $glied['hash']), $id]);

    return $id;
}

function zeile(PDO $pdo, int $id): array
{
    $q = $pdo->prepare("SELECT * FROM dokument_signaturen WHERE id=?");
    $q->execute([$id]);
    return $q->fetch();
}

// ── Vier Unterschriften ──
echo "=== Kette 1..4 ===\n";
$ids = [];
foreach ([1, 2, 3, 4] as $n) {
    $ids[$n] = unterschreiben($pdo, "Ankerprobe $n");
}

$stand = SignaturHelper::kettenStand($pdo);
$pruef($stand['vergeben'] === 4 && $stand['vorhanden'] === 4 && $stand['vollstaendig'],
       'vier Glieder, Anker und Bestand stimmen überein',
       "vergeben {$stand['vergeben']}, vorhanden {$stand['vorhanden']}");

// ── Das letzte Glied verschwindet ──
echo "\n=== letztes Glied (nr 4) gelöscht ===\n";
$pdo->prepare("DELETE FROM dokument_signaturen WHERE ketten_nr = 4")->execute();

// Der Kern des Befunds: jede verbliebene Zeile meldet weiterhin alles in Ordnung.
$alleHeil = true;
foreach ([1, 2, 3] as $n) {
    $z = zeile($pdo, $ids[$n]);
    $eigen = hash_equals((string)$z['full_hash'],
                         SignaturHelper::kettenHash($z, $z['prev_hash']));
    $kette = SignaturHelper::verkettungPruefen($pdo, $z);
    if (!$eigen || $kette !== true) { $alleHeil = false; }
}
$pruef($alleHeil,
       'die verbliebenen Zeilen melden ALLE weiterhin unversehrt und lückenlos');
$pruef(true, '  → genau deshalb reicht Rückwärtsprüfen nicht aus');

$stand = SignaturHelper::kettenStand($pdo);
$pruef(!$stand['vollstaendig'],
       'der ANKER bemerkt es',
       "vergeben {$stand['vergeben']}, vorhanden {$stand['vorhanden']}, "
       . "höchste {$stand['hoechste']}");

// ── Die nächste Unterschrift darf die Nummer NICHT wiederverwenden ──
echo "\n=== nächste Unterschrift ===\n";
$neu = unterschreiben($pdo, 'Ankerprobe 5');
$nr = (int)zeile($pdo, $neu)['ketten_nr'];
$pruef($nr === 5, 'sie bekommt 5, nicht noch einmal 4', "erhalten: $nr");

$stand = SignaturHelper::kettenStand($pdo);
$pruef(!$stand['vollstaendig'],
       'die Lücke bleibt sichtbar, statt aufgefüllt zu werden',
       "vergeben {$stand['vergeben']}, vorhanden {$stand['vorhanden']}");

// ── Und die neue Zeile zeigt den Bruch ehrlich an ──
$pruef(SignaturHelper::verkettungPruefen($pdo, zeile($pdo, $neu)) === false,
       'die neue Zeile meldet den fehlenden Vorgänger als Bruch');

// ── Aufräumen ──
$pdo->exec("DELETE FROM dokument_signaturen");
$pdo->exec("UPDATE signatur_kette_stand SET letzte_nr = 0 WHERE id = 1");

echo "\n" . ($fehler === 0 ? "DER ANKER SIEHT, WAS DIE KETTE NICHT SIEHT\n" : "$fehler FEHLER\n");
exit($fehler === 0 ? 0 : 1);
