<?php
/**
 * Prüft, dass die Hash-Kette eine Kette bleibt.
 *
 * Läuft gegen icd360sev_test_db, NICHT gegen den Bestand. Eine Testzeile in
 * der echten Tabelle verbraucht eine Kettenposition; löscht man sie hinterher,
 * zeigt die nächste echte Unterschrift auf einen Vorgänger, den es nicht mehr
 * gibt. Beweisdaten sind kein Ort für Testdaten.
 *
 * Aufsetzen (einmalig):
 *   mysqldump --no-data icd360sev_db dokument_signaturen | mysql icd360sev_test_db
 *   mysql icd360sev_test_db < server/sql/migrations/2026_08_11_kettenposition.sql
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

// Der Helfer ist umstellbar, damit die neue Fassung geprüft werden kann, BEVOR
// sie live geht: solange member/signatur_manage.php noch die alte Funktion
// ruft, würde ein vorzeitiges Einspielen jede laufende Unterschrift mit einem
// Fatal Error beenden. Ohne Angabe läuft der Test gegen den Live-Stand.
require_once getenv('SIGNATUR_HELPER') ?: WEBROOT . '/api/lib/SignaturHelper.php';

$pdo = new PDO(
    'mysql:unix_socket=/var/lib/mysql/mysql.sock;dbname=icd360sev_test_db;charset=utf8mb4',
    DB_USER, DB_PASS,
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
);
$pdo->exec("DELETE FROM dokument_signaturen");

$fehler = 0;
$pruef = function (bool $ok, string $was, string $detail = '') use (&$fehler) {
    echo ($ok ? '  ok   ' : '  FAIL ') . $was . ($detail !== '' ? " — $detail" : '') . "\n";
    if (!$ok) { $fehler++; }
};

/** Eine offene Anfrage. Gibt die id zurück. */
function anfrage(PDO $pdo, string $titel): int
{
    $s = $pdo->prepare(
        "INSERT INTO dokument_signaturen
            (user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
             pdf_pfad, pdf_hash, pdf_seiten, status)
         VALUES (1, 2, UTC_TIMESTAMP(), 'jobcenter_wba', ?, 'test/x.pdf', SHA2(?,256), 1, 'offen')"
    );
    $s->execute([$titel, $titel]);
    return (int)$pdo->lastInsertId();
}

/**
 * Unterschreiben nach der ALTEN Regel: Vorgänger ist die höchste signierte id.
 * Nachgebaut, weil der Fehler sonst nicht vorführbar ist.
 */
function altSignieren(PDO $pdo, int $id): ?string
{
    $prev = $pdo->query(
        "SELECT full_hash FROM dokument_signaturen
          WHERE status='signiert' AND full_hash IS NOT NULL
          ORDER BY id DESC LIMIT 1"
    )->fetchColumn();
    $prev = $prev === false ? null : (string)$prev;
    return schreiben($pdo, $id, $prev, null);
}

/** Unterschreiben nach der NEUEN Regel: fortlaufende Position. */
function neuSignieren(PDO $pdo, int $id): ?string
{
    $glied = SignaturHelper::vorherigesGlied($pdo);
    return schreiben($pdo, $id, $glied['hash'], $glied['nr'] + 1);
}

function schreiben(PDO $pdo, int $id, ?string $prev, ?int $nr): ?string
{
    $pdo->prepare(
        "UPDATE dokument_signaturen
            SET status='signiert', signature_svg='<svg/>', signed_at_utc=UTC_TIMESTAMP(),
                ip_address='203.0.113.9', device_id='test', tan_verified_at=UTC_TIMESTAMP(),
                prev_hash=?, ketten_nr=? WHERE id=?"
    )->execute([$prev, $nr, $id]);

    $f = $pdo->prepare(
        "SELECT id,user_id,dokument_typ,pdf_hash,signature_svg,signed_at_utc,
                ip_address,device_id,tan_verified_at FROM dokument_signaturen WHERE id=?"
    );
    $f->execute([$id]);
    $voll = SignaturHelper::kettenHash($f->fetch(), $prev);
    $pdo->prepare("UPDATE dokument_signaturen SET full_hash=? WHERE id=?")->execute([$voll, $id]);
    return $prev;
}

function feld(PDO $pdo, int $id, string $s)
{
    $q = $pdo->prepare("SELECT $s FROM dokument_signaturen WHERE id=?");
    $q->execute([$id]);
    return $q->fetchColumn();
}

function zeile(PDO $pdo, int $id): array
{
    $q = $pdo->prepare("SELECT * FROM dokument_signaturen WHERE id=?");
    $q->execute([$id]);
    return $q->fetch();
}

// ═══ 1. Der Fehler, so wie er war ═══
// Zwei offene Anfragen, die spätere wird zuerst unterschrieben. Danach eine
// dritte. Nichts daran ist ungewöhnlich.
echo "=== 1. alte Regel (Vorgänger = höchste signierte id) ===\n";
$a = anfrage($pdo, 'A');
$b = anfrage($pdo, 'B');          // höhere id als A
altSignieren($pdo, $b);           // B zuerst
$prevA = altSignieren($pdo, $a);  // A danach
$c = anfrage($pdo, 'C');
$prevC = altSignieren($pdo, $c);

$pruef($prevA !== null && $prevA === $prevC,
       'GABEL vorführbar: zwei Zeilen am selben Vorgänger',
       'A und C zeigen auf ' . substr((string)$prevA, 0, 12) . '…');

// Und das Entscheidende: beide melden trotzdem „unverändert".
$eigenA = hash_equals((string)feld($pdo,$a,'full_hash'),
                      SignaturHelper::kettenHash(zeile($pdo,$a), $prevA));
$eigenC = hash_equals((string)feld($pdo,$c,'full_hash'),
                      SignaturHelper::kettenHash(zeile($pdo,$c), $prevC));
$pruef($eigenA && $eigenC,
       'die Gabel bleibt unsichtbar: beide Zeilen melden ihren Hash als gültig');

// ═══ 2. Dieselbe Reihenfolge, neue Regel ═══
echo "\n=== 2. neue Regel (fortlaufende Position) ===\n";
$pdo->exec("DELETE FROM dokument_signaturen");
$a = anfrage($pdo, 'A');
$b = anfrage($pdo, 'B');
neuSignieren($pdo, $b);
$prevA = neuSignieren($pdo, $a);
$c = anfrage($pdo, 'C');
$prevC = neuSignieren($pdo, $c);

$pruef($prevA !== $prevC, 'keine Gabel mehr: A und C haben verschiedene Vorgänger');
$pruef((int)feld($pdo,$b,'ketten_nr') === 1
    && (int)feld($pdo,$a,'ketten_nr') === 2
    && (int)feld($pdo,$c,'ketten_nr') === 3,
       'die Positionen folgen der Unterschrift, nicht der id',
       'B=1, A=2, C=3');
$pruef($prevC === feld($pdo,$a,'full_hash'),
       'C hängt am zuletzt Unterschriebenen (A), nicht an der höchsten id (B)');

// ═══ 3. Die Prüfung findet die Lücke ═══
echo "\n=== 3. verkettungPruefen ===\n";
foreach ([$b,$a,$c] as $id) {
    if (SignaturHelper::verkettungPruefen($pdo, zeile($pdo,$id)) !== true) {
        $pruef(false, "Zeile $id sollte lückenlos verkettet sein");
    }
}
$pruef($fehler === 0, 'die unversehrte Kette wird als lückenlos erkannt');

// Ein Glied aus der Mitte entfernen — der Angriff, den die alte Prüfung nicht sah.
$pdo->prepare("DELETE FROM dokument_signaturen WHERE id=?")->execute([$a]);

$zeileC = zeile($pdo, $c);
$pruef(hash_equals((string)$zeileC['full_hash'],
        SignaturHelper::kettenHash($zeileC, $zeileC['prev_hash'])),
       'kette_intakt meldet weiterhin „in Ordnung" — sie kann die Lücke nicht sehen');
$pruef(SignaturHelper::verkettungPruefen($pdo, $zeileC) === false,
       'verkettung_intakt schlägt an: der Vorgänger fehlt');

// ═══ 4. Zwei gleichzeitige Unterschriften können nicht dieselbe Position bekommen ═══
echo "\n=== 4. UNIQUE auf der Position ===\n";
$pdo->exec("DELETE FROM dokument_signaturen");
$x = anfrage($pdo, 'X');
$y = anfrage($pdo, 'Y');
neuSignieren($pdo, $x);
$doppelt = false;
try {
    $pdo->prepare("UPDATE dokument_signaturen SET ketten_nr=1 WHERE id=?")->execute([$y]);
} catch (PDOException $e) {
    $doppelt = ($e->getCode() === '23000');
}
$pruef($doppelt, 'eine doppelte Position wird von der Datenbank abgewiesen');

// ═══ 5. Bestandszeilen ohne Position ═══
echo "\n=== 5. Unterschriften von vor der Umstellung ===\n";
$pdo->exec("UPDATE dokument_signaturen SET ketten_nr=NULL WHERE id=$x");
$pruef(SignaturHelper::verkettungPruefen($pdo, zeile($pdo,$x)) === null,
       'ohne Positionsangabe: nicht prüfbar (null), keine falsche Bestätigung');

$pdo->exec("DELETE FROM dokument_signaturen");
echo "\n" . ($fehler === 0 ? "DIE KETTE IST EINE KETTE\n" : "$fehler FEHLER\n");
exit($fehler === 0 ? 0 : 1);
