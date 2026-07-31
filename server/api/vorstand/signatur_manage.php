<?php
/**
 * /api/vorstand/signatur_manage.php
 *
 * Die Vorsitzer-Seite der digitalen Unterschrift, aufgerufen aus dem Reiter
 * „Unterschriften" der Mitgliederverwaltung (neben Verifizierung).
 *
 *   list        alle Vorgänge eines Mitglieds
 *   detail      ein Vorgang samt vollständigem Beweisbündel
 *   anfordern   PDF hochladen und zur Unterschrift stellen (multipart)
 *   widerrufen  einen Vorgang zurückziehen
 *
 * Auth: validateApiKey() + blockBrowserAccess() + mitgliedernummer im Body,
 * die auf einen User mit role=vorsitzer auflösen muss — gleiche Bauart wie
 * die übrigen vorstand-Endpunkte.
 *
 * Bewusst KEIN Weg, eine Unterschrift zu erzeugen oder zu ändern: der
 * Vorsitzer fordert an und liest, unterschreiben kann nur das Mitglied. Ein
 * Endpunkt, über den die anfordernde Seite die Unterschrift selbst setzen
 * könnte, würde den ganzen Beweis wertlos machen.
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../helpers.php';
require_once __DIR__ . '/../lib/SignaturHelper.php';

validateApiKey();
blockBrowserAccess();

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    jsonResponse(false, [], 'Method not allowed');
}

// „anfordern" trägt die PDF-Datei und kommt deshalb als multipart, alles
// andere als JSON.
$istUpload = str_starts_with($_SERVER['CONTENT_TYPE'] ?? '', 'multipart/form-data');
if ($istUpload) {
    $body = $_POST;
} else {
    $body = json_decode(file_get_contents('php://input'), true);
    if (!is_array($body)) {
        http_response_code(400);
        jsonResponse(false, [], 'Invalid JSON');
    }
}

$pdo      = getDBConnection();
$callerId = vorsitzerPruefen($pdo, (string)($body['mitgliedernummer'] ?? ''));
$action   = (string)($body['action'] ?? '');

switch ($action) {
    case 'list':       aktionListe($pdo, $body);                  break;
    case 'detail':     aktionDetail($pdo, $body);                 break;
    case 'anfordern':  aktionAnfordern($pdo, $callerId, $body);   break;
    case 'widerrufen': aktionWiderrufen($pdo, $body);             break;
    default:
        http_response_code(400);
        jsonResponse(false, [], 'Unknown action');
}

// ---------------------------------------------------------------------------

/**
 * Nur der Vorsitzer darf hier hinein. Gibt seine user_id zurück, damit in
 * `angefordert_von` steht, wer den Vorgang wirklich angestoßen hat.
 */
function vorsitzerPruefen(PDO $pdo, string $mitgliedernummer): int
{
    if ($mitgliedernummer === '') {
        http_response_code(400);
        jsonResponse(false, [], 'Missing mitgliedernummer');
    }

    $stmt = $pdo->prepare('SELECT id, role FROM users WHERE mitgliedernummer = ?');
    $stmt->execute([$mitgliedernummer]);
    $caller = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$caller || $caller['role'] !== 'vorsitzer') {
        http_response_code(403);
        jsonResponse(false, [], 'Forbidden');
    }
    return (int)$caller['id'];
}

/**
 * Übersicht für den Reiter. Ohne SVG und ohne Beweisfelder — die Liste soll
 * schnell sein, das Bündel gibt es im Detail.
 */
function aktionListe(PDO $pdo, array $body): void
{
    $userId = (int)($body['user_id'] ?? 0);
    if ($userId <= 0) {
        http_response_code(400);
        jsonResponse(false, [], 'Missing user_id');
    }

    $stmt = $pdo->prepare(
        "SELECT id, dokument_typ, dokument_titel, status, pdf_seiten,
                angefordert_at, frist_bis, signed_at_utc, abgelehnt_at,
                abgelehnt_grund, widerrufen_at, verify_code
           FROM dokument_signaturen
          WHERE user_id = ?
          ORDER BY angefordert_at DESC"
    );
    $stmt->execute([$userId]);
    $zeilen = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $offen = 0;
    foreach ($zeilen as &$z) {
        $z['id'] = (int)$z['id'];
        $z['pdf_seiten'] = $z['pdf_seiten'] === null ? null : (int)$z['pdf_seiten'];
        if ($z['status'] === 'offen') {
            $offen++;
        }
    }
    unset($z);

    jsonResponse(true, ['signaturen' => $zeilen, 'offen_count' => $offen]);
}

/**
 * Das vollständige Beweisbündel eines Vorgangs.
 *
 * Hier liegt der Sinn des ganzen Reiters: wenn jemand die Unterschrift
 * bestreitet, muss der Vorsitzer an einer Stelle sehen können, was zum
 * Zeitpunkt der Unterschrift wahr war — Zeit, Netz, Gerät, TAN-Ziel und die
 * Stellung in der Hash-Kette.
 */
function aktionDetail(PDO $pdo, array $body): void
{
    $signaturId = (int)($body['signatur_id'] ?? 0);
    if ($signaturId <= 0) {
        http_response_code(400);
        jsonResponse(false, [], 'Missing signatur_id');
    }

    $stmt = $pdo->prepare(
        "SELECT s.*,
                u.vorname, u.nachname, u.mitgliedernummer,
                a.vorname AS anfordernder_vorname, a.nachname AS anfordernder_nachname
           FROM dokument_signaturen s
           JOIN users u ON u.id = s.user_id
           LEFT JOIN users a ON a.id = s.angefordert_von
          WHERE s.id = ?"
    );
    $stmt->execute([$signaturId]);
    $zeile = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$zeile) {
        http_response_code(404);
        jsonResponse(false, [], 'Signatur nicht gefunden');
    }

    // Die Kette an dieser Stelle nachrechnen. Stimmt sie nicht, hat jemand die
    // Zeile nach dem Unterschreiben angefasst — das gehört sichtbar in die
    // Anzeige und nicht in ein Logfile, das niemand liest.
    $zeile['kette_intakt'] = null;
    if ($zeile['status'] === 'signiert' && $zeile['full_hash'] !== null) {
        $zeile['kette_intakt'] =
            hash_equals(
                (string)$zeile['full_hash'],
                SignaturHelper::kettenHash($zeile, $zeile['prev_hash'])
            );
    }

    $zeile['id'] = (int)$zeile['id'];
    unset($zeile['pdf_pfad'], $zeile['signiert_pdf_pfad'], $zeile['tsa_token_pfad']);

    jsonResponse(true, ['signatur' => $zeile]);
}

/**
 * Ein PDF zur Unterschrift stellen.
 *
 * Der Hash wird über die Bytes gebildet, die tatsächlich auf der Platte
 * landen — nicht über das, was der Client geschickt zu haben behauptet.
 * Genau dieser Hash verbindet später die Unterschrift mit dem Inhalt.
 */
function aktionAnfordern(PDO $pdo, int $callerId, array $body): void
{
    $userId = (int)($body['user_id'] ?? 0);
    $typ    = trim((string)($body['dokument_typ'] ?? ''));
    $titel  = trim((string)($body['dokument_titel'] ?? ''));
    $frist  = trim((string)($body['frist_bis'] ?? ''));

    if ($userId <= 0 || $typ === '' || $titel === '') {
        http_response_code(400);
        jsonResponse(false, [], 'Missing required fields');
    }

    if (!isset($_FILES['pdf']) || $_FILES['pdf']['error'] !== UPLOAD_ERR_OK) {
        http_response_code(400);
        jsonResponse(false, [], 'Keine PDF-Datei empfangen');
    }

    $tmp = $_FILES['pdf']['tmp_name'];

    // Auf den Inhalt schauen, nicht auf den Dateinamen: die Endung sagt nichts
    // darüber, was drinsteht, und das Mitglied bekommt diese Datei angezeigt.
    $magic = file_get_contents($tmp, false, null, 0, 5);
    if ($magic !== '%PDF-') {
        http_response_code(400);
        jsonResponse(false, [], 'Die Datei ist kein PDF');
    }

    $groesse = (int)$_FILES['pdf']['size'];
    if ($groesse <= 0 || $groesse > 20 * 1024 * 1024) {
        http_response_code(400);
        jsonResponse(false, [], 'PDF ist leer oder größer als 20 MB');
    }

    $verzeichnis = __DIR__ . '/../../uploads/signaturen/' . $userId;
    if (!is_dir($verzeichnis) && !mkdir($verzeichnis, 0750, true) && !is_dir($verzeichnis)) {
        error_log('signatur anfordern: mkdir fehlgeschlagen ' . $verzeichnis);
        http_response_code(500);
        jsonResponse(false, [], 'Ablage nicht verfügbar');
    }

    $dateiname = bin2hex(random_bytes(16)) . '.pdf';
    $ziel      = $verzeichnis . '/' . $dateiname;

    if (!move_uploaded_file($tmp, $ziel)) {
        error_log('signatur anfordern: move_uploaded_file fehlgeschlagen');
        http_response_code(500);
        jsonResponse(false, [], 'PDF konnte nicht gespeichert werden');
    }

    $hash = hash_file('sha256', $ziel);

    try {
        $stmt = $pdo->prepare(
            "INSERT INTO dokument_signaturen
                (user_id, angefordert_von, angefordert_at, dokument_typ,
                 dokument_titel, quelle_tabelle, quelle_id,
                 pdf_pfad, pdf_hash, pdf_seiten, status, frist_bis)
             VALUES (?, ?, UTC_TIMESTAMP(), ?, ?, ?, ?, ?, ?, ?, 'offen', ?)"
        );
        $stmt->execute([
            $userId,
            $callerId,
            $typ,
            $titel,
            ($body['quelle_tabelle'] ?? '') !== '' ? $body['quelle_tabelle'] : null,
            (int)($body['quelle_id'] ?? 0) > 0 ? (int)$body['quelle_id'] : null,
            'signaturen/' . $userId . '/' . $dateiname,
            $hash,
            pdfSeiten($ziel),
            $frist !== '' ? $frist : null,
        ]);
        $signaturId = (int)$pdo->lastInsertId();
    } catch (Throwable $e) {
        // Die Datei liegt sonst als Waise auf der Platte und niemand weiß,
        // wozu sie gehörte.
        @unlink($ziel);
        error_log('signatur anfordern: ' . $e->getMessage());
        http_response_code(500);
        jsonResponse(false, [], 'Anforderung konnte nicht angelegt werden');
    }

    mitgliedBenachrichtigen($pdo, $userId, $titel, $frist);

    jsonResponse(true, ['signatur_id' => $signaturId, 'pdf_hash' => $hash]);
}

/**
 * Sagt dem Mitglied Bescheid, dass etwas zur Unterschrift bereitliegt.
 *
 * Ohne diesen Schritt läge die Anforderung in der App und niemand wüsste
 * davon — das Mitglied müsste von sich aus nachsehen, und die Frist liefe
 * unterdessen. Eine Unterschrift, die nur deshalb ausbleibt, weil niemand
 * gefragt hat, ist kein Versäumnis des Mitglieds.
 *
 * Der Weckruf ist Komfort, kein Teil der Zusage: schlägt er fehl, steht die
 * Anforderung trotzdem in der Liste, und die Karte auf der Übersichtsseite
 * zeigt sie beim nächsten Start.
 */
function mitgliedBenachrichtigen(PDO $pdo, int $userId, string $titel, string $frist): void
{
    try {
        $stmt = $pdo->prepare('SELECT mitgliedernummer FROM users WHERE id = ?');
        $stmt->execute([$userId]);
        $nummer = (string)$stmt->fetchColumn();
        if ($nummer === '') {
            return;
        }

        require_once __DIR__ . '/../helpers/NtfyService.php';
        (new NtfyService())->sendToUser(
            $nummer,
            'Dokument zur Unterschrift',
            $frist !== ''
                ? "$titel — bitte bis zum " . date('d.m.Y', strtotime($frist)) . ' unterschreiben'
                : $titel,
            ['priority' => 4, 'tags' => ['pencil']]
        );
    } catch (Throwable $e) {
        error_log('signatur mitgliedBenachrichtigen: ' . $e->getMessage());
    }
}

/**
 * Seitenzahl aus dem PDF, damit die App weiß, wie weit „bis zum Ende
 * gescrollt" reicht.
 *
 * Bewusst über die rohen /Type /Page-Vorkommen statt über eine PDF-Bibliothek:
 * hier wird nichts gerendert, und ein Schätzwert ist besser als eine
 * zusätzliche Abhängigkeit im Upload-Pfad. Findet sich nichts, bleibt das
 * Feld leer — die App verlangt dann kein Scroll-Ziel, statt ein falsches.
 */
function pdfSeiten(string $pfad): ?int
{
    $inhalt = file_get_contents($pfad);
    if ($inhalt === false) {
        return null;
    }
    $treffer = preg_match_all('#/Type\s*/Page[^s]#', $inhalt);
    return $treffer > 0 ? $treffer : null;
}

/**
 * Zurückziehen. Nur was noch offen ist — eine geleistete Unterschrift lässt
 * sich nicht widerrufen, indem man ihren Status überschreibt. Dafür gibt es
 * `widerrufen_at` auf der signierten Zeile, das den Vorgang als überholt
 * markiert, ohne den Beweis anzutasten.
 */
function aktionWiderrufen(PDO $pdo, array $body): void
{
    $signaturId = (int)($body['signatur_id'] ?? 0);
    $grund      = trim((string)($body['grund'] ?? ''));

    if ($signaturId <= 0) {
        http_response_code(400);
        jsonResponse(false, [], 'Missing signatur_id');
    }

    $stmt = $pdo->prepare(
        "UPDATE dokument_signaturen
            SET status = 'widerrufen',
                widerrufen_at = UTC_TIMESTAMP(),
                widerrufen_grund = ?
          WHERE id = ? AND status = 'offen'"
    );
    $stmt->execute([$grund !== '' ? $grund : null, $signaturId]);

    if ($stmt->rowCount() === 0) {
        http_response_code(409);
        jsonResponse(false, [], 'Nur offene Anforderungen lassen sich zurückziehen');
    }

    jsonResponse(true, ['signatur_id' => $signaturId]);
}
