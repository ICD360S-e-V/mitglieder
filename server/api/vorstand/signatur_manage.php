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

/** Der Anzeigename der Mitglieder-App, wie er auf jeder Plattform steht.
 *  Steht hier als Konstante, damit im Beweisbuendel nicht irgendwann ein
 *  siebter Name auftaucht — es gab schon sechs. */
const ANWENDUNG = 'MitgliederPortal - ICD360S e.V';

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

    // Die Liste steht unter EINEM Mitglied, zeigt also dessen Zeilen. Bei einer
    // Vollmacht gehört dazu aber eine zweite Zeile mit einer ANDEREN user_id —
    // der des Vorsitzenden. Sie hier mit aufzuführen wäre falsch (sie gehört
    // nicht diesem Mitglied), sie zu verschweigen aber auch: dann stünde eine
    // Unterschrift ewig auf „unterschrieben", ohne dass erkennbar wäre, dass
    // noch jemand fehlt. Deshalb bleibt die Zeilenauswahl wie sie war, und
    // jede Zeile bekommt die Zahlen ihrer Gruppe dazu.
    $stmt = $pdo->prepare(
        "SELECT s.id, s.dokument_typ, s.dokument_titel, s.status, s.pdf_seiten,
                s.angefordert_at, s.frist_bis, s.signed_at_utc, s.abgelehnt_at,
                s.abgelehnt_grund, s.widerrufen_at, s.verify_code,
                s.gruppe_id, s.rolle,
                (SELECT COUNT(*) FROM dokument_signaturen g
                  WHERE g.gruppe_id = s.gruppe_id)                        AS gruppe_gesamt,
                (SELECT COUNT(*) FROM dokument_signaturen g
                  WHERE g.gruppe_id = s.gruppe_id AND g.status = 'signiert') AS gruppe_signiert
           FROM dokument_signaturen s
          WHERE s.user_id = ?
          ORDER BY s.angefordert_at DESC"
    );
    $stmt->execute([$userId]);
    $zeilen = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $offen = 0;
    foreach ($zeilen as &$z) {
        $z['id'] = (int)$z['id'];
        $z['pdf_seiten'] = $z['pdf_seiten'] === null ? null : (int)$z['pdf_seiten'];
        $z['gruppe_id']  = $z['gruppe_id'] === null ? null : (int)$z['gruppe_id'];

        // Ohne Gruppe ist die Zeile für sich allein vollständig: 1 von 1.
        // So muss die Oberfläche nicht zwei Fälle unterscheiden.
        $z['gruppe_gesamt']   = $z['gruppe_id'] === null ? 1 : (int)$z['gruppe_gesamt'];
        $z['gruppe_signiert'] = $z['gruppe_id'] === null
            ? ($z['status'] === 'signiert' ? 1 : 0)
            : (int)$z['gruppe_signiert'];

        $z['wartet_auf_mitunterzeichner'] =
            $z['status'] === 'signiert'
            && $z['gruppe_signiert'] < $z['gruppe_gesamt'];

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

    // Das Gerät kommt aus ZWEI Quellen, in dieser Reihenfolge:
    //
    //  1. was die App im Moment der Unterschrift mitgeschickt hat
    //     (device_hostname) — eine Momentaufnahme, und als Beweis die bessere:
    //     sie beschreibt das Gerät, wie es damals war.
    //  2. ersatzweise das, was bei der Geräteregistrierung hinterlegt wurde.
    //
    // Nummer 2 gab es die ganze Zeit in `device_keys`, mitsamt Name, Plattform
    // und Betriebssystem. Bei den ersten vier Unterschriften blieb das Feld
    // trotzdem leer, weil die App auf dem Desktop keinen Namen ermittelte —
    // und niemand kam auf die Idee, dass die Angabe längst danebenlag. Die
    // Ersatzquelle schließt diese Lücke sofort und rückwirkend, auch für
    // Mitglieder, deren App noch älter ist.
    //
    // Das COLLATE im JOIN ist nicht schmückend: `device_keys` steht auf
    // utf8mb4_general_ci, `dokument_signaturen` auf utf8mb4_unicode_ci. Ohne
    // die Angabe bricht MySQL die ganze Abfrage mit „Illegal mix of
    // collations" ab — nicht die Zeile, die ganze Detailansicht.
    $stmt = $pdo->prepare(
        "SELECT s.*,
                u.vorname, u.nachname, u.mitgliedernummer,
                a.vorname AS anfordernder_vorname, a.nachname AS anfordernder_nachname,
                d.device_name  AS geraet_registriert,
                d.platform     AS geraet_plattform,
                d.os_version   AS geraet_system,
                d.device_type  AS geraet_art,
                d.app_version  AS geraet_app
           FROM dokument_signaturen s
           JOIN users u ON u.id = s.user_id
           LEFT JOIN users a ON a.id = s.angefordert_von
           LEFT JOIN device_keys d
                  ON d.device_key COLLATE utf8mb4_unicode_ci = s.device_id
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

    // Zwei verschiedene Aussagen, und beide werden gebraucht:
    //
    //   kette_intakt      — diese Zeile ist seit dem Unterschreiben unverändert
    //   verkettung_intakt — sie hängt nachweislich an ihrem Vorgänger
    //
    // Die erste allein ist schwächer, als sie klingt: sie bleibt „in Ordnung",
    // wenn jemand eine ANDERE Unterschrift aus der Kette entfernt. Erst die
    // zweite macht aus einzelnen geprüften Zeilen eine geprüfte Reihenfolge.
    // null heißt bei Unterschriften vor dieser Fassung schlicht: noch ohne
    // Positionsangabe geleistet, also nicht prüfbar — und das steht dann auch
    // so in der Anzeige, statt eine Bestätigung vorzutäuschen.
    $zeile['verkettung_intakt'] = SignaturHelper::verkettungPruefen($pdo, $zeile);

    // Die Mitunterzeichner desselben Dokuments — nur wer, in welcher Rolle und
    // wie weit. BEWUSST ohne deren Beweisfelder: jede Unterschrift hat ihre
    // eigene IP, ihr eigenes Gerät, ihre eigene TAN und ihren eigenen Platz in
    // der Kette. Zwei Beweisbündel in einer Ansicht zu mischen wäre der Anfang
    // davon, dass später jemand das Gerät des einen der Unterschrift des
    // anderen zuordnet. Hier steht nur die id, über die sich das zweite Bündel
    // eigenständig öffnen lässt.
    $zeile['mitunterzeichner'] = [];
    if ($zeile['gruppe_id'] !== null) {
        $mit = $pdo->prepare(
            "SELECT s.id, s.rolle, s.status, s.signed_at_utc, s.abgelehnt_at,
                    u.vorname, u.nachname, u.mitgliedernummer
               FROM dokument_signaturen s
               JOIN users u ON u.id = s.user_id
              WHERE s.gruppe_id = ? AND s.id <> ?
              ORDER BY s.id"
        );
        $mit->execute([(int)$zeile['gruppe_id'], $signaturId]);
        foreach ($mit->fetchAll(PDO::FETCH_ASSOC) as $m) {
            $m['id'] = (int)$m['id'];
            $zeile['mitunterzeichner'][] = $m;
        }
    }

    // Wie weit ist das Dokument insgesamt? Eine einzelne Zeile kann
    // „unterschrieben" sein, während das Dokument noch auf jemanden wartet.
    $gesamt   = 1 + count($zeile['mitunterzeichner']);
    $signiert = ($zeile['status'] === 'signiert' ? 1 : 0)
        + count(array_filter($zeile['mitunterzeichner'], fn($m) => $m['status'] === 'signiert'));
    $zeile['gruppe_gesamt']   = $gesamt;
    $zeile['gruppe_signiert'] = $signiert;
    $zeile['wartet_auf_mitunterzeichner'] =
        $zeile['status'] === 'signiert' && $signiert < $gesamt;

    // Aus beiden Quellen EIN lesbarer Satz. Der Client soll nicht raten
    // müssen, welches der fünf Felder gerade gefüllt ist.
    $zeile['geraet_anzeige']    = geraetText($zeile);
    $zeile['anwendung_anzeige'] = anwendungText($zeile);

    $zeile['id'] = (int)$zeile['id'];
    unset($zeile['pdf_pfad'], $zeile['signiert_pdf_pfad'], $zeile['tsa_token_pfad']);

    jsonResponse(true, ['signatur' => $zeile]);
}

/**
 * Ein Satz, der das unterschreibende Gerät beschreibt.
 *
 * Bevorzugt wird, was die App im Moment der Unterschrift gemeldet hat: das ist
 * der Zustand, auf den es ankommt. Fehlt er — alte App-Fassung, oder eine
 * Plattform, die damals nicht abgedeckt war — tritt die Registrierung ein.
 *
 * Dass die Ersatzangabe später gepflegt wurde, wird nicht verschwiegen: sie
 * steht mit dem Zusatz „laut Registrierung" da. Eine Angabe als
 * Momentaufnahme auszugeben, die keine ist, wäre genau die Art von Unschärfe,
 * die ein Beweisbündel wertlos macht.
 */
function geraetText(array $z): ?string
{
    $momentaufnahme = trim((string)($z['device_hostname'] ?? ''));
    if ($momentaufnahme !== '') {
        return $momentaufnahme;
    }

    $teile = array_values(array_filter([
        trim((string)($z['geraet_registriert'] ?? '')),
        trim((string)($z['geraet_system'] ?? '')) ?: trim((string)($z['geraet_plattform'] ?? '')),
    ], fn($t) => $t !== ''));

    if ($teile === []) {
        return null;
    }
    return implode(' · ', $teile) . ' (laut Registrierung)';
}

/**
 * Mit welcher Anwendung unterschrieben wurde.
 *
 * Den NAMEN setzt der Server, nicht der Client. Er weiß mit Sicherheit, dass
 * die Unterschrift über den Mitglieder-Endpunkt kam — kein anderer Weg führt
 * dorthin. Ihn vom Client zu erfragen hieße, sich die Antwort von der Seite
 * geben zu lassen, die man gerade nachweist.
 *
 * Die VERSION kommt aus der Geräteregistrierung. Sie gehört ins Bündel, weil
 * sie sagt, welcher Programmstand die Unterschrift erzeugt hat — wird Jahre
 * später ein Fehler in einer bestimmten Fassung bekannt, lässt sich damit
 * eingrenzen, welche Unterschriften ihn überhaupt betreffen könnten.
 */
function anwendungText(array $z): string
{
    // Die festgehaltene Fassung ist die einzige, die eine Aussage ueber den
    // Unterschriftszeitpunkt zulaesst. Sie wird beim Unterschreiben einmal
    // gesetzt und danach nie geaendert.
    $momentaufnahme = trim((string)($z['app_version'] ?? ''));
    if ($momentaufnahme !== '') {
        return ANWENDUNG . ' ' . $momentaufnahme;
    }

    // Ohne Momentaufnahme (Unterschriften von vor dieser Aenderung) bleibt nur
    // der heutige Stand des Geraets — und der sagt gerade NICHT, womit
    // unterschrieben wurde. Das muss dastehen. Ihn stillschweigend als
    // Unterschriftsfassung auszugeben waere die falsche Angabe, die diese
    // Trennung ueberhaupt notwendig gemacht hat.
    $heute = trim((string)($z['geraet_app'] ?? ''));
    if ($heute !== '') {
        return ANWENDUNG . ' — Fassung beim Unterschreiben nicht erfasst, '
             . 'Gerät meldet heute ' . $heute;
    }

    return ANWENDUNG;
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
