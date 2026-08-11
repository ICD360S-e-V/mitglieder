<?php
/**
 * Prüft, dass istWiederholbar() genau die vorübergehenden Fehler erkennt.
 *
 * Nicht mit erfundenen Ausnahmen, sondern mit echten: die Sperr-Zeitgrenze wird
 * an einer echten Verbindung provoziert. Ein Test, der eine PDOException selbst
 * konstruiert, prüft nur die eigene Annahme darüber, wie sie aussieht.
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

function verbindung(): PDO
{
    return new PDO(
        'mysql:unix_socket=/var/lib/mysql/mysql.sock;dbname=icd360sev_test_db;charset=utf8mb4',
        DB_USER, DB_PASS,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
    );
}

$fehler = 0;
$pruef = function (bool $ok, string $was, string $detail = '') use (&$fehler) {
    echo ($ok ? '  ok   ' : '  FAIL ') . $was . ($detail !== '' ? " — $detail" : '') . "\n";
    if (!$ok) { $fehler++; }
};

$a = verbindung();
$b = verbindung();
$a->exec("DELETE FROM dokument_signaturen");

$a->prepare(
    "INSERT INTO dokument_signaturen
        (user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
         pdf_pfad, pdf_hash, pdf_seiten, status, signature_svg, signed_at_utc,
         ip_address, device_id, tan_verified_at, full_hash, ketten_nr)
     VALUES (11,2,UTC_TIMESTAMP(),'jobcenter_wba','Sperrprobe','x.pdf',SHA2('x',256),1,
             'signiert','<svg/>',UTC_TIMESTAMP(),'203.0.113.1','g',UTC_TIMESTAMP(),?,1)"
)->execute([str_repeat('b', 64)]);

$kopf = "SELECT ketten_nr, full_hash FROM dokument_signaturen
          WHERE status='signiert' AND full_hash IS NOT NULL AND ketten_nr IS NOT NULL
          ORDER BY ketten_nr DESC LIMIT 1 FOR UPDATE";

// ── 1. Echte Sperr-Zeitgrenze ──
$b->exec("SET SESSION innodb_lock_wait_timeout = 1");
$a->beginTransaction();
$a->query($kopf)->fetch();          // A hält den Kettenkopf

$gefangen = null;
$b->beginTransaction();
try {
    $b->query($kopf)->fetch();
} catch (PDOException $e) {
    $gefangen = $e;
}
try { $b->rollBack(); } catch (PDOException $e) {}
$a->rollBack();

$pruef($gefangen !== null, 'die Sperr-Zeitgrenze tritt wirklich ein');
if ($gefangen !== null) {
    $pruef(SignaturHelper::istWiederholbar($gefangen),
           'istWiederholbar() erkennt sie',
           'Treibercode ' . ($gefangen->errorInfo[1] ?? '?')
           . ', SQLSTATE ' . $gefangen->getCode());
}

// ── 2. Ein echter, NICHT wiederholbarer Fehler ──
// Doppelte Kettenposition: das ist ein Datenfehler, kein Gedränge. Ein neuer
// Anlauf würde ihn nur wiederholen.
$dauerhaft = null;
try {
    $a->prepare(
        "INSERT INTO dokument_signaturen
            (user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
             pdf_pfad, pdf_hash, pdf_seiten, status, ketten_nr)
         VALUES (12,2,UTC_TIMESTAMP(),'jobcenter_wba','Doppelt','x.pdf',SHA2('y',256),1,'offen',1)"
    )->execute();
} catch (PDOException $e) {
    $dauerhaft = $e;
}
$pruef($dauerhaft !== null, 'die doppelte Kettenposition wird abgewiesen');
if ($dauerhaft !== null) {
    $pruef(!SignaturHelper::istWiederholbar($dauerhaft),
           'istWiederholbar() stuft sie NICHT als vorübergehend ein',
           'Treibercode ' . ($dauerhaft->errorInfo[1] ?? '?'));
}

// ── 3. Etwas, das gar keine Datenbankausnahme ist ──
$pruef(!SignaturHelper::istWiederholbar(new RuntimeException('kaputt')),
       'ein gewöhnlicher Fehler gilt nicht als wiederholbar');

// ── 4. Nach dem Rückrollen ist die TAN wieder brauchbar ──
// Das ist die Voraussetzung dafür, dass ein neuer Anlauf überhaupt erlaubt ist.
$a->exec("DELETE FROM dokument_signaturen");
$a->prepare(
    "INSERT INTO dokument_signaturen
        (id, user_id, angefordert_von, angefordert_at, dokument_typ, dokument_titel,
         pdf_pfad, pdf_hash, pdf_seiten, status)
     VALUES (900,11,2,UTC_TIMESTAMP(),'jobcenter_wba','TAN-Probe','x.pdf',SHA2('z',256),1,'offen')"
)->execute();

$hatTan = (bool)$a->query("SHOW TABLES LIKE 'signatur_tan'")->fetchColumn();
if (!$hatTan) {
    $a->exec(
        "CREATE TABLE signatur_tan (
           id INT AUTO_INCREMENT PRIMARY KEY, signatur_id INT NOT NULL,
           tan_hash CHAR(64), versuche INT DEFAULT 0, telefon VARCHAR(40),
           gueltig_bis DATETIME, verbraucht_at DATETIME NULL)"
    );
}
$a->exec("DELETE FROM signatur_tan");
$a->exec("INSERT INTO signatur_tan (signatur_id, tan_hash, telefon, gueltig_bis)
          VALUES (900, 'x', '+49', DATE_ADD(UTC_TIMESTAMP(), INTERVAL 5 MINUTE))");

$a->beginTransaction();
$a->exec("UPDATE signatur_tan SET verbraucht_at = UTC_TIMESTAMP() WHERE signatur_id = 900");
$a->exec("UPDATE dokument_signaturen SET status='signiert' WHERE id = 900");
$a->rollBack();

$verbraucht = $a->query("SELECT verbraucht_at FROM signatur_tan WHERE signatur_id=900")->fetchColumn();
$status = $a->query("SELECT status FROM dokument_signaturen WHERE id=900")->fetchColumn();
$pruef($verbraucht === null, 'nach dem Rückrollen ist die TAN wieder gültig');
$pruef($status === 'offen', 'und die Anforderung wieder offen');

$a->exec("DELETE FROM dokument_signaturen");
$a->exec("DELETE FROM signatur_tan");
echo "\n" . ($fehler === 0 ? "WIEDERHOLBARKEIT STIMMT\n" : "$fehler FEHLER\n");
exit($fehler === 0 ? 0 : 1);
