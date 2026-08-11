<?php
/**
 * /api/member/signatur_manage.php
 *
 * Die Mitgliederseite der digitalen Unterschrift. Ein Endpunkt, vier Aktionen:
 *
 *   list           offene und erledigte Unterschriftsanforderungen
 *   tan_anfordern  TAN erzeugen und als SMS einreihen (weckt das Tablet)
 *   signieren      SVG + TAN einreichen, Beweiszeile schließen
 *   ablehnen       mit Begründung ablehnen
 *
 * Auth wie die übrigen member-Endpunkte: validateApiKey() + requireAuth().
 * Ein Mitglied sieht und unterschreibt ausschließlich seine eigenen Vorgänge —
 * jede Abfrage trägt `user_id = ?` mit, nicht nur die Liste.
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

$userId = requireAuth();
$pdo    = getDBConnection();

$body = json_decode(file_get_contents('php://input'), true);
if (!is_array($body)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid JSON');
}

$action = (string)($body['action'] ?? '');

switch ($action) {
    case 'list':         aktionListe($pdo, $userId);                break;
    case 'tan_anfordern': aktionTanAnfordern($pdo, $userId, $body);  break;
    case 'signieren':    aktionSignieren($pdo, $userId, $body);      break;
    case 'ablehnen':     aktionAblehnen($pdo, $userId, $body);       break;
    default:
        http_response_code(400);
        jsonResponse(false, [], 'Unknown action');
}

// ---------------------------------------------------------------------------

/**
 * Alles, was dieses Mitglied unterschreiben soll oder schon hat.
 *
 * `signature_svg` bleibt draußen: die Liste läuft bei jedem Öffnen des
 * Bildschirms, und die gemalten Pfade würden sie um ein Vielfaches aufblähen,
 * ohne dass sie dort jemand sieht.
 */
function aktionListe(PDO $pdo, int $userId): void
{
    // `wartet_auf` zaehlt die Mitunterzeichner, die noch nicht unterschrieben
    // haben. Beim einzelnen Unterzeichner ist der Wert immer 0, die
    // Unterabfrage laeuft dort ins Leere und kostet nichts.
    $stmt = $pdo->prepare(
        "SELECT s.id, s.dokument_typ, s.dokument_titel, s.status,
                s.pdf_seiten, s.frist_bis, s.angefordert_at,
                s.signed_at_utc, s.tan_verified_at, s.verify_code,
                s.abgelehnt_grund, s.gruppe_id, s.rolle,
                u.vorname AS angefordert_von_vorname,
                u.nachname AS angefordert_von_nachname,
                (SELECT COUNT(*) FROM dokument_signaturen g
                  WHERE g.gruppe_id = s.gruppe_id
                    AND g.id <> s.id
                    AND g.status = 'offen') AS wartet_auf
           FROM dokument_signaturen s
           LEFT JOIN users u ON u.id = s.angefordert_von
          WHERE s.user_id = ?
          ORDER BY FIELD(s.status, 'offen') DESC, s.angefordert_at DESC"
    );
    $stmt->execute([$userId]);
    $zeilen = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($zeilen as &$z) {
        $z['id']         = (int)$z['id'];
        $z['pdf_seiten'] = $z['pdf_seiten'] === null ? null : (int)$z['pdf_seiten'];
        $z['wartet_auf'] = (int)$z['wartet_auf'];

        // Unterschrieben, aber noch nicht fertig: bei der Vollmacht fehlt dann
        // die zweite Unterschrift. Das ist ein eigener Zustand und nicht
        // dasselbe wie „fertig" — es gibt in diesem Moment kein gesiegeltes
        // Dokument, und der Bildschirm darf keines versprechen.
        $z['wartet_auf_mitunterzeichner'] =
            $z['status'] === 'signiert' && $z['wartet_auf'] > 0;

        // Das signierte PDF gibt es nur über den authentifizierten Download,
        // nie als Pfad — sonst wäre die Datei über die URL erreichbar. Und es
        // gibt es erst, wenn alle unterschrieben haben.
        $z['download_verfuegbar'] =
            $z['status'] === 'signiert' && $z['wartet_auf'] === 0;
    }
    unset($z);

    jsonResponse(true, ['signaturen' => $zeilen]);
}

/**
 * TAN erzeugen, Rufnummer prüfen, SMS einreihen, Tablet wecken.
 *
 * Die Rufnummer kommt aus Verifizierung Stufe 1 und wird NICHT vom Client
 * übernommen — sonst könnte sich jemand die TAN an ein eigenes Telefon
 * schicken lassen und der zweite Faktor wäre keiner.
 */
function aktionTanAnfordern(PDO $pdo, int $userId, array $body): void
{
    $signaturId = (int)($body['signatur_id'] ?? 0);
    if ($signaturId <= 0) {
        http_response_code(400);
        jsonResponse(false, [], 'Missing signatur_id');
    }

    // Name, Geschlecht und Sprache kommen aus Verifizierung Stufe 1 und gehen
    // in den SMS-Text. preferred_language ist bei allen 52 Mitgliedern gefüllt
    // (ENUM, Vorgabe 'de'); muttersprache wäre die naheliegendere Spalte, ist
    // aber nur bei vier Leuten ausgefüllt und damit unbrauchbar.
    $stmt = $pdo->prepare(
        "SELECT s.id, s.status, u.telefon_mobil,
                u.nachname, u.geschlecht, u.preferred_language
           FROM dokument_signaturen s
           JOIN users u ON u.id = s.user_id
          WHERE s.id = ? AND s.user_id = ?"
    );
    $stmt->execute([$signaturId, $userId]);
    $zeile = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$zeile) {
        http_response_code(404);
        jsonResponse(false, [], 'Signatur nicht gefunden');
    }
    if ($zeile['status'] !== 'offen') {
        http_response_code(409);
        jsonResponse(false, [], 'Dieser Vorgang ist nicht mehr offen');
    }

    $telefon = trim((string)($zeile['telefon_mobil'] ?? ''));
    if ($telefon === '') {
        // Ausdrücklich als eigener Fehlercode, damit die App erklären kann,
        // WARUM nicht unterschrieben werden kann. 19 von 42 Mitgliedern haben
        // keine Nummer hinterlegt — „geht nicht" ohne Grund wäre hier das
        // Schlimmste, was die App sagen könnte.
        http_response_code(409);
        jsonResponse(false, ['grund' => 'keine_rufnummer'],
            'Für Ihr Konto ist keine Mobilnummer hinterlegt. '
          . 'Bitte wenden Sie sich an den Vorsitzenden.');
    }

    try {
        $pdo->beginTransaction();

        // Frühere offene TANs desselben Vorgangs verfallen. Sonst blieben nach
        // dreimaligem „Code erneut senden" drei gültige Codes im Umlauf.
        $pdo->prepare(
            "UPDATE signatur_tan SET verbraucht_at = UTC_TIMESTAMP()
              WHERE signatur_id = ? AND verbraucht_at IS NULL"
        )->execute([$signaturId]);

        $tan = SignaturHelper::tanErzeugen();
        $ins = $pdo->prepare(
            "INSERT INTO signatur_tan (signatur_id, tan_hash, telefon, gueltig_bis)
             VALUES (?, ?, ?, DATE_ADD(UTC_TIMESTAMP(), INTERVAL ? MINUTE))"
        );
        $ins->execute([
            $signaturId,
            SignaturHelper::tanHash($tan, $signaturId),
            $telefon,
            SignaturHelper::TAN_GUELTIG_MINUTEN,
        ]);
        $tanId = (int)$pdo->lastInsertId();

        $pdo->prepare(
            "INSERT INTO signatur_sms_queue (tan_id, signatur_id, telefon, body)
             VALUES (?, ?, ?, ?)"
        )->execute([$tanId, $signaturId, $telefon, SignaturHelper::smsText($tan, $zeile)]);

        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log('signatur tan_anfordern: ' . $e->getMessage());
        http_response_code(500);
        jsonResponse(false, [], 'TAN konnte nicht erzeugt werden');
    }

    // Das Tablet pollt sonst alle 30 Minuten — für eine TAN ist das wertlos.
    tabletWecken($pdo);

    jsonResponse(true, [
        'gesendet_an'      => SignaturHelper::telefonMaskieren($telefon),
        'gueltig_minuten'  => SignaturHelper::TAN_GUELTIG_MINUTEN,
        'max_versuche'     => SignaturHelper::TAN_MAX_VERSUCHE,
    ]);
}

/**
 * Die eigentliche Unterschrift: SVG + TAN kommen zusammen an.
 *
 * Erst wenn die TAN stimmt, wird überhaupt etwas geschrieben — eine
 * halbfertige Beweiszeile ohne zweiten Faktor darf es nicht geben.
 */
function aktionSignieren(PDO $pdo, int $userId, array $body): void
{
    $signaturId = (int)($body['signatur_id'] ?? 0);
    $tan        = trim((string)($body['tan'] ?? ''));
    $svg        = (string)($body['signature_svg'] ?? '');

    if ($signaturId <= 0 || $tan === '' || $svg === '') {
        http_response_code(400);
        jsonResponse(false, [], 'Missing required fields');
    }

    // Ein leerer oder absurd großer Pfad ist keine Unterschrift. Die Grenze
    // nach oben schützt die Spalte vor einem Client, der versehentlich ein
    // eingebettetes Bild statt eines Pfades schickt.
    if (stripos($svg, '<svg') === false || strlen($svg) > 400000) {
        http_response_code(400);
        jsonResponse(false, [], 'Ungültige Unterschrift');
    }

    try {
        $pdo->beginTransaction();

        $stmt = $pdo->prepare(
            "SELECT id, user_id, dokument_typ, pdf_hash, status
               FROM dokument_signaturen
              WHERE id = ? AND user_id = ? FOR UPDATE"
        );
        $stmt->execute([$signaturId, $userId]);
        $zeile = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$zeile) {
            $pdo->rollBack();
            http_response_code(404);
            jsonResponse(false, [], 'Signatur nicht gefunden');
        }
        if ($zeile['status'] !== 'offen') {
            $pdo->rollBack();
            http_response_code(409);
            jsonResponse(false, [], 'Dieser Vorgang ist nicht mehr offen');
        }

        // --- TAN prüfen ---
        $tanStmt = $pdo->prepare(
            "SELECT id, tan_hash, versuche, telefon
               FROM signatur_tan
              WHERE signatur_id = ? AND verbraucht_at IS NULL
                AND gueltig_bis > UTC_TIMESTAMP()
              ORDER BY id DESC LIMIT 1 FOR UPDATE"
        );
        $tanStmt->execute([$signaturId]);
        $tanZeile = $tanStmt->fetch(PDO::FETCH_ASSOC);

        if (!$tanZeile) {
            $pdo->rollBack();
            http_response_code(409);
            jsonResponse(false, ['grund' => 'tan_abgelaufen'],
                'Der Code ist abgelaufen. Bitte fordern Sie einen neuen an.');
        }

        if ((int)$tanZeile['versuche'] >= SignaturHelper::TAN_MAX_VERSUCHE) {
            $pdo->prepare("UPDATE signatur_tan SET verbraucht_at = UTC_TIMESTAMP() WHERE id = ?")
                ->execute([$tanZeile['id']]);
            $pdo->commit();
            http_response_code(429);
            jsonResponse(false, ['grund' => 'zu_viele_versuche'],
                'Zu viele Fehlversuche. Bitte fordern Sie einen neuen Code an.');
        }

        // hash_equals statt ===: der Vergleich darf nicht verraten, an welcher
        // Stelle der Code abweicht.
        $erwartet = SignaturHelper::tanHash($tan, $signaturId);
        if (!hash_equals($erwartet, (string)$tanZeile['tan_hash'])) {
            $pdo->prepare("UPDATE signatur_tan SET versuche = versuche + 1 WHERE id = ?")
                ->execute([$tanZeile['id']]);
            $pdo->commit();
            $offen = SignaturHelper::TAN_MAX_VERSUCHE - ((int)$tanZeile['versuche'] + 1);
            http_response_code(401);
            jsonResponse(false, ['grund' => 'tan_falsch', 'versuche_offen' => max(0, $offen)],
                'Der Code stimmt nicht.');
        }

        // --- Beweiszeile schließen ---
        $ip = SignaturHelper::clientIp();

        // Vorgänger und eigene Position in einem Zug: die Position wird
        // vergeben, nicht aus der id abgeleitet. Warum das nötig ist, steht in
        // vorherigesGlied() — kurz: die id sagt, wann jemand GEFRAGT wurde,
        // nicht, wann er unterschrieben hat.
        $glied    = SignaturHelper::vorherigesGlied($pdo);
        $prevHash = $glied['hash'];
        $kettenNr = $glied['nr'] + 1;

        $upd = $pdo->prepare(
            "UPDATE dokument_signaturen
                SET status = 'signiert',
                    signature_svg = ?,
                    signed_at_utc = UTC_TIMESTAMP(),
                    signed_at_local = ?,
                    ip_address = ?,
                    user_agent = ?,
                    device_id = ?,
                    device_hostname = ?,
                    tan_an = ?,
                    tan_verified_at = UTC_TIMESTAMP(),
                    prev_hash = ?,
                    ketten_nr = ?,
                    verify_code = ?
              WHERE id = ?"
        );
        $upd->execute([
            $svg,
            substr((string)($body['signed_at_local'] ?? ''), 0, 50),
            $ip,
            substr((string)($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 500),
            substr((string)($_SERVER['HTTP_X_DEVICE_KEY'] ?? ''), 0, 64),
            substr((string)($body['device_hostname'] ?? ''), 0, 120),
            SignaturHelper::telefonMaskieren((string)$tanZeile['telefon']),
            $prevHash,
            $kettenNr,
            SignaturHelper::verifyCode(),
            $signaturId,
        ]);

        $pdo->prepare("UPDATE signatur_tan SET verbraucht_at = UTC_TIMESTAMP() WHERE id = ?")
            ->execute([$tanZeile['id']]);

        // Den Kettenhash erst jetzt rechnen — er muss über die Werte laufen,
        // die tatsächlich in der Zeile stehen (UTC_TIMESTAMP() kennt nur die
        // Datenbank), nicht über das, was wir vorher zu schreiben glaubten.
        $frisch = $pdo->prepare(
            "SELECT id, user_id, dokument_typ, pdf_hash, signature_svg,
                    signed_at_utc, ip_address, device_id, tan_verified_at,
                    verify_code
               FROM dokument_signaturen WHERE id = ?"
        );
        $frisch->execute([$signaturId]);
        $neu = $frisch->fetch(PDO::FETCH_ASSOC);

        $fullHash = SignaturHelper::kettenHash($neu, $prevHash);
        $pdo->prepare("UPDATE dokument_signaturen SET full_hash = ? WHERE id = ?")
            ->execute([$fullHash, $signaturId]);

        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log('signatur signieren: ' . $e->getMessage());
        http_response_code(500);
        jsonResponse(false, [], 'Unterschrift konnte nicht gespeichert werden');
    }

    // Reverse-DNS bewusst NACH dem Commit: der Lookup kann in eine
    // DNS-Zeitüberschreitung laufen, und daran darf eine gültige Unterschrift
    // nicht scheitern. Fehlt der PTR, bleibt das Feld leer — das ist ein
    // Nebenbefund im Audit, kein Mangel am Beweis.
    // Aus demselben Grund steht auch die Herkunft der IP hier unten: Land und
    // Netzbetreiber sind eine Einordnung des Beweises, nicht der Beweis selbst.
    try {
        $ip = $neu['ip_address'] ?? null;

        $rdns = SignaturHelper::reverseDns($ip);
        $herkunft = SignaturHelper::ipHerkunft($pdo, $ip);

        $pdo->prepare(
            "UPDATE dokument_signaturen
                SET reverse_dns = COALESCE(?, reverse_dns),
                    country_iso = COALESCE(?, country_iso),
                    isp         = COALESCE(?, isp)
              WHERE id = ?"
        )->execute([$rdns, $herkunft['land'], $herkunft['netz'], $signaturId]);

        // Die App-Fassung EINMAL festhalten.
        //
        // device_keys.app_version wird bei jedem Login und bei jedem Start neu
        // geschrieben — sie beschreibt die Fassung von heute, nicht die vom
        // Unterschriftszeitpunkt. Wuerde das Buendel sie direkt lesen, behauptete
        // es nach dem naechsten App-Update, eine alte Unterschrift sei mit der
        // neuen Fassung geleistet worden. Eine falsche Angabe in einem
        // Beweisdokument ist schlimmer als keine.
        //
        // JETZT ist der Wert richtig: das Mitglied hat gerade mit dieser App
        // unterschrieben. Danach wird die Spalte nie wieder angefasst.
        $pdo->prepare(
            "UPDATE dokument_signaturen s
                JOIN device_keys d
                  ON d.device_key COLLATE utf8mb4_unicode_ci = s.device_id
                 SET s.app_version = d.app_version
               WHERE s.id = ? AND s.app_version IS NULL"
        )->execute([$signaturId]);
    } catch (Throwable $e) {
        error_log('signatur Herkunft: ' . $e->getMessage());
    }

    jsonResponse(true, [
        'signatur_id' => $signaturId,
        'verify_code' => $neu['verify_code'] ?? null,
        'full_hash'   => $fullHash,
    ]);
}

/**
 * Ablehnen ist ein gleichwertiger Ausgang, kein Fehler — es muss genauso
 * nachvollziehbar sein wie das Unterschreiben. Ohne diesen Weg bliebe ein
 * Vorgang, den jemand nicht unterschreiben will, ewig „offen" stehen und
 * niemand wüsste, ob das Mitglied ihn abgelehnt oder nur nicht gesehen hat.
 */
function aktionAblehnen(PDO $pdo, int $userId, array $body): void
{
    $signaturId = (int)($body['signatur_id'] ?? 0);
    $grund      = trim((string)($body['grund'] ?? ''));

    if ($signaturId <= 0) {
        http_response_code(400);
        jsonResponse(false, [], 'Missing signatur_id');
    }

    $pdo->beginTransaction();
    try {
        $stmt = $pdo->prepare(
            "UPDATE dokument_signaturen
                SET status = 'abgelehnt',
                    abgelehnt_at = UTC_TIMESTAMP(),
                    abgelehnt_grund = ?
              WHERE id = ? AND user_id = ? AND status = 'offen'"
        );
        $stmt->execute([$grund !== '' ? $grund : null, $signaturId, $userId]);

        if ($stmt->rowCount() === 0) {
            $pdo->rollBack();
            http_response_code(409);
            jsonResponse(false, [], 'Dieser Vorgang ist nicht mehr offen');
        }

        // Lehnt EINER ab, ist das Dokument als Ganzes gescheitert — auch wenn
        // der andere längst unterschrieben hat. Danach kann niemand mehr
        // unterschreiben.
        //
        // Die bereits geleistete Unterschrift wird dabei NICHT angetastet. Sie
        // ist eine Tatsache: jemand hat zu einem Zeitpunkt mit seinem Gerät und
        // seiner TAN unterschrieben, und sie steht mit ihrem eigenen Hash in
        // der Kette. Sie nachträglich auf „abgelehnt" zu setzen hiesse, ein
        // Geschehen umzuschreiben, weil es folgenlos blieb. Gesiegelt wird das
        // Dokument nie — und genau das ist die richtige Folge, nicht eine
        // gelöschte Unterschrift.
        $gruppe = $pdo->prepare("SELECT gruppe_id FROM dokument_signaturen WHERE id = ?");
        $gruppe->execute([$signaturId]);
        $gruppeId = $gruppe->fetchColumn();

        $mitAbgelehnt = 0;
        if ($gruppeId !== false && $gruppeId !== null) {
            $rest = $pdo->prepare(
                "UPDATE dokument_signaturen
                    SET status = 'abgelehnt',
                        abgelehnt_at = UTC_TIMESTAMP(),
                        abgelehnt_grund = ?
                  WHERE gruppe_id = ? AND status = 'offen'"
            );
            $rest->execute([
                'Von einem anderen Unterzeichner abgelehnt',
                (int)$gruppeId,
            ]);
            $mitAbgelehnt = $rest->rowCount();
        }

        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log('signatur ablehnen: ' . $e->getMessage());
        http_response_code(500);
        jsonResponse(false, [], 'Ablehnung konnte nicht gespeichert werden');
    }

    jsonResponse(true, [
        'signatur_id' => $signaturId,
        // Wie viele offene Unterschriften dadurch hinfällig wurden. Beim
        // einzelnen Unterzeichner immer 0.
        'weitere_beendet' => $mitAbgelehnt,
    ]);
}

/**
 * Weckt die Vorsitzer-Geräte, damit das Gateway die TAN sofort abholt statt
 * beim nächsten 30-Minuten-Takt. Gleicher Weg wie in api/chat/sms_outbox.php:
 * das Topic ist `vorsitzer_<mitgliedernummer>`, denn genau darauf hört die
 * App — ein eigenes Topic würde ins Leere senden.
 *
 * Wer nicht Gateway ist, verwirft den Auftrag ohnehin (der Schalter steht
 * dort auf aus).
 *
 * Priorität 5 statt 3 wie bei den übrigen SMS-Aufträgen: eine TAN gilt fünf
 * Minuten, und das Mitglied sitzt in diesem Moment vor dem Unterschriftsfeld.
 *
 * Seit die TAN nur noch fünf Minuten gilt, ist dieser Weckruf kein Komfort
 * mehr, sondern der einzige realistische Zustellweg: der reguläre Takt des
 * Gateways liegt bei 30 Minuten, der Code wäre bis dahin sechsmal abgelaufen.
 * Schlägt der Weckruf fehl, geht die SMS deshalb NICHT verspätet raus —
 * signatur_queue.php sortiert abgelaufene TANs vor dem Versand aus, statt
 * einen toten Code zu verschicken, den das Mitglied vergeblich eintippt. Für
 * das Mitglied heißt das: der Code kommt nicht, und es fordert einen neuen an.
 */
function tabletWecken(PDO $pdo): void
{
    try {
        require_once __DIR__ . '/../helpers/NtfyService.php';
        $ntfy = new NtfyService();
        $stmt = $pdo->query(
            "SELECT mitgliedernummer FROM users
              WHERE role IN ('vorsitzer','stellvertreter')
                AND deactivated_at IS NULL"
        );
        foreach ($stmt->fetchAll(PDO::FETCH_COLUMN) as $nummer) {
            $ntfy->send(
                'vorsitzer_' . strtolower((string)$nummer),
                'Signatur-TAN',
                'Warteschlange prüfen',
                ['priority' => 5, 'tags' => ['sms_gateway']]
            );
        }
    } catch (Throwable $e) {
        error_log('signatur tabletWecken: ' . $e->getMessage());
    }
}
