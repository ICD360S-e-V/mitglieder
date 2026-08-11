<?php
/**
 * Siegelt frisch geleistete Unterschriften: jede Minute per Cron.
 *
 * Warum nicht direkt im Signier-Request: das Siegeln holt einen Zeitstempel
 * von einer fremden TSA über das Internet. Hängt die, würde das Mitglied vor
 * einem drehenden Rad sitzen und am Ende einen Fehler sehen — obwohl seine
 * Unterschrift längst gültig in der Datenbank steht. Die Unterschrift ist mit
 * dem Datenbank-Commit fertig; das Siegel kommt hinterher und darf ruhig eine
 * Minute später kommen oder einen Versuch brauchen.
 *
 * Läuft als root, nicht als nginx. Der private Schlüssel unter
 * /etc/pki/signca/ ist damit für PHP-FPM unlesbar — ein Webshell im Webroot
 * kann keine Dokumente siegeln.
 *
 * Was hier entsteht:
 *   - das Originaldokument, Seite für Seite übernommen
 *   - ein angehängtes Unterschriftenblatt mit der gemalten Unterschrift und
 *     dem vollständigen Beweisbündel
 *   - eine PAdES-Signatur mit dem Vereinssiegel
 *   - ein RFC-3161-Zeitstempel von freetsa.org
 *
 * WICHTIG: das gesiegelte PDF ist nicht byteweise das hochgeladene. FPDI baut
 * die Seiten neu auf. Deshalb bleiben BEIDE Hashes stehen: `pdf_hash` beweist,
 * was dem Mitglied gezeigt wurde, `signiert_pdf_hash` sichert die gesiegelte
 * Fassung. Wer prüft, vergleicht das, was er in der Hand hält, mit dem
 * passenden der beiden.
 */

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit("CLI only\n");
}

define('API_ACCESS', true);

const WEBROOT   = '/var/www/icd360sev.icd360s.de';
const PKI       = '/etc/pki/signca';
const TSA_HOST  = 'https://freetsa.org/tsr';
/** Mehr als das schafft eine Minute nicht zuverlässig; der Rest kommt im
 *  nächsten Durchlauf dran. */
const MAX_PRO_LAUF = 10;

/** Nach so vielen vergeblichen Anläufen wird nicht mehr versucht.
 *
 *  Ohne diese Grenze hat der Cron dasselbe Dokument im Minutentakt endlos
 *  wiederholt — beim ersten echten Fall (Jobcenter-WBA) über eine Viertelstunde
 *  lang, mit identischem Fehler. Für das Mitglied stand dabei durchgehend „das
 *  Siegel wird noch erstellt", also eine Zusage, die nie eingelöst werden
 *  konnte. Fünf Versuche fangen Aussetzer ab (TSA nicht erreichbar, Platte
 *  kurz voll); was danach noch scheitert, scheitert aus einem Grund, den ein
 *  weiterer Versuch nicht behebt. */
const MAX_VERSUCHE = 5;

/** Entfernt Objekt-Streams, damit der freie FPDI-Parser das PDF öffnen kann.
 *  Siehe [lesbarMachen].
 *
 *  Mehrere Pfade, weil `pdftk` hier die Java-Portierung ist und unter
 *  /usr/local/bin liegt, nicht unter /usr/bin wie das alte C++-Original. Ein
 *  fest verdrahteter Pfad hat genau deshalb schon einmal ins Leere gezeigt. */
const PDFTK_PFADE = ['/usr/local/bin/pdftk', '/usr/bin/pdftk', '/bin/pdftk'];

require_once WEBROOT . '/api/config.php';
require_once WEBROOT . '/pdflib/vendor/autoload.php';

$pdo = getDBConnection();

fristenPruefen($pdo);

$offen = $pdo->prepare(
    "SELECT s.*, u.vorname, u.nachname, u.mitgliedernummer
       FROM dokument_signaturen s
       JOIN users u ON u.id = s.user_id
      WHERE s.status = 'signiert'
        AND s.signiert_pdf_pfad IS NULL
        AND s.siegel_versuche < " . MAX_VERSUCHE . "
        -- Reverse-DNS, Land, Netzbetreiber und App-Fassung werden erst NACH
        -- dem Commit nachgetragen (der DNS-Lookup darf keine Unterschrift
        -- aufhalten). Dieser Cron laeuft jede Minute und griff bisher mitten
        -- in dieses Fenster: dann stand auf dem gesiegelten Blatt
        -- 'Hostname: —', waehrend die Datenbank kurz darauf einen Wert bekam.
        -- Urkunde und Buendel widersprechen sich — und die Urkunde ist die
        -- zeitgestempelte von beiden.
        --
        -- Die Ausnahme nach 15 Minuten ist Absicht: bleibt die Marke wegen
        -- eines Fehlers aus, wird trotzdem gesiegelt. Ein Buendel ohne
        -- Hostname ist unvollstaendig; eine Unterschrift, die nie ein Siegel
        -- bekommt, waere verloren.
        AND (s.beweis_vollstaendig = 1
             OR s.signed_at_utc <= UTC_TIMESTAMP() - INTERVAL 15 MINUTE)
        -- Bei mehreren Unterzeichnern (nur Vollmacht) wird erst gesiegelt,
        -- wenn ALLE unterschrieben haben. Vorher gibt es kein fertiges
        -- Dokument, und ein Siegel ueber einen halb unterschriebenen Stand
        -- wuerde etwas beglaubigen, das so nie gegolten hat.
        AND (s.gruppe_id IS NULL OR NOT EXISTS (
              SELECT 1 FROM dokument_signaturen g
               WHERE g.gruppe_id = s.gruppe_id
                 AND g.status <> 'signiert'))
        -- Je Gruppe nur EINE Zeile aufgreifen, sonst siegeln zwei Durchlaeufe
        -- dasselbe Dokument gleichzeitig. Die kleinste id fuehrt.
        AND s.id = (SELECT MIN(g2.id) FROM dokument_signaturen g2
                     WHERE COALESCE(g2.gruppe_id, g2.id) = COALESCE(s.gruppe_id, s.id))
      ORDER BY s.signed_at_utc ASC
      LIMIT " . MAX_PRO_LAUF
);
$offen->execute();
$zeilen = $offen->fetchAll(PDO::FETCH_ASSOC);

// VOR dem Ausstieg, nicht danach: der Normalfall ist, dass es nichts zu
// siegeln gibt. Stuende das Nachholen hinter der Schleife, liefe es nur an den
// Minuten, in denen ohnehin gerade gesiegelt wird — also fast nie, und
// ausgerechnet nicht in den ruhigen Stunden, in denen eine ausgefallene
// Zeitstempelstelle wieder erreichbar waere.
zeitstempelNachholen($pdo);

if ($zeilen === []) {
    exit(0);
}

echo date('c') . " — " . count($zeilen) . " zu siegeln\n";

foreach ($zeilen as $zeile) {
    try {
        siegeln($pdo, $zeile);
        echo "  #{$zeile['id']} gesiegelt\n";
    } catch (Throwable $e) {
        // Nicht abbrechen: ein kaputtes Dokument darf die übrigen nicht
        // aufhalten. Aber mitzählen — sonst wiederholt sich derselbe Fehler
        // im Minutentakt bis in alle Ewigkeit.
        $pdo->prepare(
            "UPDATE dokument_signaturen
                SET siegel_versuche = siegel_versuche + 1, siegel_fehler = ?
              WHERE id = ?"
        )->execute([substr($e->getMessage(), 0, 255), $zeile['id']]);

        $versuche = (int)$zeile['siegel_versuche'] + 1;
        $endgueltig = $versuche >= MAX_VERSUCHE ? ' — AUFGEGEBEN' : '';
        echo "  #{$zeile['id']} FEHLER ($versuche/" . MAX_VERSUCHE . ")$endgueltig: {$e->getMessage()}\n";
        error_log("seal_signaturen #{$zeile['id']} ($versuche/" . MAX_VERSUCHE . "): " . $e->getMessage());
    }
}

// ---------------------------------------------------------------------------

/**
 * Setzt abgelaufene Anforderungen auf `abgelaufen`.
 *
 * Ohne diesen Schritt wäre die Frist reine Zierde: der Status bliebe für immer
 * `offen`, das Mitglied könnte Monate später noch unterschreiben, und in der
 * Liste des Vorsitzenden stünde nicht, was tatsächlich noch aussteht und was
 * längst durchgefallen ist.
 *
 * Läuft im selben Minutentakt wie das Siegeln — eine eigene Cron-Zeile für
 * zwei Zeilen SQL wäre eine Stelle mehr, an der jemand vergisst, sie
 * einzurichten.
 */
function fristenPruefen(PDO $pdo): void
{
    try {
        $stmt = $pdo->prepare(
            "UPDATE dokument_signaturen
                SET status = 'abgelaufen'
              WHERE status = 'offen'
                AND frist_bis IS NOT NULL
                AND frist_bis < UTC_TIMESTAMP()"
        );
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            echo date('c') . ' — ' . $stmt->rowCount() . " Anforderung(en) abgelaufen\n";
        }
    } catch (Throwable $e) {
        // Darf das Siegeln nicht aufhalten: eine nicht als abgelaufen markierte
        // Anforderung ist ein Schönheitsfehler, ein ungesiegeltes Dokument nicht.
        error_log('seal_signaturen fristenPruefen: ' . $e->getMessage());
    }
}

function siegeln(PDO $pdo, array $z): void
{
    $quelle = WEBROOT . '/uploads/' . $z['pdf_pfad'];
    if (!is_file($quelle)) {
        throw new RuntimeException("Originaldokument fehlt: {$z['pdf_pfad']}");
    }

    // Erst prüfen, ob das Original noch das ist, was unterschrieben wurde.
    // Stimmt der Hash nicht, ist die Datei nach der Unterschrift verändert
    // worden — dann darf nichts gesiegelt werden, denn das Siegel würde
    // genau diese Fälschung beglaubigen.
    if (!hash_equals((string)$z['pdf_hash'], hash_file('sha256', $quelle))) {
        throw new RuntimeException('pdf_hash weicht ab — Original wurde verändert');
    }

    $pdf = new \setasign\Fpdi\Tcpdf\Fpdi();
    $pdf->SetCreator('ICD360S e.V.');
    $pdf->SetAuthor('ICD360S e.V.');
    $pdf->SetTitle((string)$z['dokument_titel']);
    $pdf->setPrintHeader(false);
    $pdf->setPrintFooter(false);

    // --- Originalseiten übernehmen ---
    //
    // Nicht direkt aus $quelle: moderne PDFs (ab 1.5) packen ihre Objekte in
    // Objekt-Streams, und die kann der freie FPDI-Parser nicht öffnen. Das ist
    // kein Randfall — das erste echte Dokument (Jobcenter-WBA) war so gebaut.
    $lesbar = lesbarMachen($quelle);
    try {
        $seiten = $pdf->setSourceFile($lesbar);
        for ($i = 1; $i <= $seiten; $i++) {
            $vorlage = $pdf->importPage($i);
            $masse   = $pdf->getTemplateSize($vorlage);
            $pdf->AddPage($masse['width'] > $masse['height'] ? 'L' : 'P',
                          [$masse['width'], $masse['height']]);
            $pdf->useTemplate($vorlage);
        }
    } finally {
        // Die entpackte Kopie ist ein Zwischenschritt und hat auf der Platte
        // nichts verloren — sie traegt denselben Inhalt wie das Original,
        // dessen Zugriff sonst geschuetzt ist.
        if ($lesbar !== $quelle) {
            @unlink($lesbar);
        }
    }

    // --- Unterschriftenblatt anhängen ---
    //
    // Angehängt statt über den Text gelegt: wo auf einem fremden PDF Platz
    // ist, weiß niemand, und eine Unterschrift quer über einer Textzeile
    // sieht nach Fälschung aus, selbst wenn sie echt ist.
    // Je Unterzeichner ein EIGENES Blatt, nicht ein gemeinsames.
    //
    // Beide Unterschriften haben ihren eigenen Beweis: eigene TAN, eigene IP,
    // eigenes Gerät, eigene Uhrzeit, eigene Stelle in der Hash-Kette. Auf ein
    // Blatt gequetscht wäre im Zweifel nicht mehr auseinanderzuhalten, welche
    // Angabe zu wem gehört — und genau das müsste ein Gericht auseinanderhalten
    // können.
    foreach (unterzeichnerDerGruppe($pdo, $z) as $unterzeichner) {
        $pdf->AddPage('P', 'A4');
        unterschriftenblatt($pdf, $unterzeichner);
    }

    // --- Siegel ---
    $pdf->setSignature(
        'file://' . PKI . '/signer.crt',
        'file://' . PKI . '/signer.key',
        '',
        '',
        2,
        [
            'Name'        => 'ICD360S e.V.',
            'Location'    => 'Deutschland',
            'Reason'      => 'Digitale Unterschrift des Mitglieds '
                           . $z['mitgliedernummer'] . ' vom ' . $z['signed_at_utc'] . ' UTC',
            'ContactInfo' => 'https://icd360sev.icd360s.de',
        ]
    );
    $pdf->setSignatureAppearance(15, 240, 80, 20, -1, 'Vereinssiegel');

    // KEIN $pdf->setTimeStamp() hier. TCPDFs applyTSA() ist eine leere Hülle
    // ("//@TODO: implement this feature") — der Aufruf sieht aus, als würde
    // gestempelt, und tut nichts. Ein Zeitstempel, den man zu haben glaubt und
    // nicht hat, ist schlimmer als keiner: man verlässt sich im Streitfall
    // darauf. Stattdessen wird unten ein eigenständiger RFC-3161-Token über
    // das fertige Dokument geholt.

    $ziel = ablegen($z, $pdf);
    $pdfHash = hash_file('sha256', $ziel['absolut']);

    // Das gesiegelte Dokument gehoert der ganzen Gruppe. Truege nur die
    // fuehrende Zeile den Pfad, koennte der zweite Unterzeichner sein eigenes
    // unterschriebenes Dokument nicht herunterladen — und beim
    // Ein-Unterzeichner-Fall trifft die Bedingung genau die eine Zeile.
    // siegel_fehler wird beim Erfolg GELOESCHT. Ohne das bleibt die Meldung
    // eines frueheren Fehlversuchs fuer immer in der Zeile stehen, und die
    // Beweisansicht zeigt dazu dauerhaft „Das Siegel wird noch erstellt.
    // Letzter Fehlversuch: …" — fuer ein Dokument, das laengst fertig
    // gesiegelt ist. Ein ueberholter Fehler, der wie ein laufender aussieht,
    // ist schlimmer als gar keine Anzeige.
    $pdo->prepare(
        "UPDATE dokument_signaturen
            SET signiert_pdf_pfad = ?, signiert_pdf_hash = ?, siegel_fehler = NULL
          WHERE COALESCE(gruppe_id, id) = ?"
    )->execute([$ziel['relativ'], $pdfHash, (int)($z['gruppe_id'] ?? $z['id'])]);

    // Zeitstempel einer fremden Uhr. Ohne ihn stünde für den Zeitpunkt nur
    // unsere eigene Aussage — und die ist im Streitfall genau die Seite, der
    // man nicht glaubt.
    //
    // Erst NACH dem Eintragen des Dokuments: schlägt die TSA fehl, ist das
    // gesiegelte PDF trotzdem da und gültig, und der nächste Lauf holt den
    // Token nach. Andersherum stünde ein fertiges Dokument ungenutzt herum,
    // weil eine fremde Webseite gerade nicht erreichbar war.
    $token = zeitstempelHolen($ziel['absolut']);
    if ($token !== null) {
        // Auf die GANZE Gruppe, genau wie der Pfad eine Anweisung weiter oben.
        // Mit `WHERE id = ?` bekam nur die fuehrende Zeile den Token, und das
        // Beweisbuendel des Mitunterzeichners behauptete dann, es gebe keinen —
        // fuer dasselbe Dokument, an dem er haengt.
        $pdo->prepare(
            "UPDATE dokument_signaturen SET tsa_token_pfad = ?
              WHERE COALESCE(gruppe_id, id) = ?"
        )->execute([$token, (int)($z['gruppe_id'] ?? $z['id'])]);
    }
}

/**
 * Holt Zeitstempel nach, die beim Siegeln nicht zu bekommen waren.
 *
 * Der Kommentar oben sagte „der naechste Lauf holt den Token nach" — und das
 * war schlicht nicht wahr: die Hauptschleife sucht nur Zeilen mit
 * `signiert_pdf_pfad IS NULL`, ein gesiegeltes Dokument sieht sie nie wieder an.
 * Faellt freetsa.org waehrend des Siegelns fuer 25 Sekunden aus — ein
 * Aussetzer eines kostenlosen Fremddienstes —, blieb `tsa_token_pfad` fuer
 * immer leer, waehrend das ausgelieferte Blatt weiterhin einen Zeitstempel
 * zusagte.
 *
 * Neu gesiegelt wird dabei NICHT: die Datei auf der Platte ist unveraendert,
 * der Token passt also weiterhin genau auf sie. Ein zweites Siegeln wuerde nur
 * ein zweites, anderes PDF erzeugen und den ersten Hash entwerten.
 */
function zeitstempelNachholen(PDO $pdo): void
{
    $offen = $pdo->prepare(
        "SELECT id, gruppe_id, signiert_pdf_pfad, siegel_versuche
           FROM dokument_signaturen
          WHERE signiert_pdf_pfad IS NOT NULL
            AND tsa_token_pfad IS NULL
            AND siegel_versuche < " . MAX_VERSUCHE . "
          ORDER BY signed_at_utc ASC
          LIMIT " . MAX_PRO_LAUF
    );
    $offen->execute();

    foreach ($offen->fetchAll(PDO::FETCH_ASSOC) as $n) {
        $datei = WEBROOT . '/uploads/' . $n['signiert_pdf_pfad'];
        $token = is_file($datei) ? zeitstempelHolen($datei) : null;

        if ($token !== null) {
            $pdo->prepare(
                "UPDATE dokument_signaturen
                    SET tsa_token_pfad = ?, siegel_fehler = NULL
                  WHERE COALESCE(gruppe_id, id) = ?"
            )->execute([$token, (int)($n['gruppe_id'] ?? $n['id'])]);
            echo '  #' . $n['id'] . " Zeitstempel nachgeholt\n";
            continue;
        }

        // Mitzaehlen, sonst versucht es der Cron im Minutentakt bis in alle
        // Ewigkeit und der Fehlschlag bleibt unsichtbar. Dieselbe Begruendung
        // wie bei MAX_VERSUCHE fuers Siegeln selbst.
        $pdo->prepare(
            "UPDATE dokument_signaturen
                SET siegel_versuche = siegel_versuche + 1,
                    siegel_fehler = 'Zeitstempel nicht erhalten'
              WHERE id = ?"
        )->execute([(int)$n['id']]);
    }
}

/**
 * Holt einen RFC-3161-Zeitstempel über das fertige PDF und legt den Token
 * daneben ab.
 *
 * Bewusst ein eigenständiger Token statt eines in die PDF-Signatur
 * eingebetteten (PAdES-B-T): TCPDF kann Letzteres nicht, und ein selbst
 * zusammengebautes CMS wäre an dieser Stelle mehr Risiko als Nutzen. Der
 * Beweiswert ist derselbe — der Token bindet den Hash des Dokuments an eine
 * beglaubigte Uhrzeit und lässt sich von jedem prüfen:
 *
 *   openssl ts -verify -data <pdf> -in <tsr> -CAfile freetsa-cacert.pem
 *
 * Gibt den relativen Pfad zurück oder null, wenn nichts Verwertbares kam.
 */
function zeitstempelHolen(string $pdfPfad): ?string
{
    $tsq = $pdfPfad . '.tsq';
    $tsr = $pdfPfad . '.tsr';

    try {
        // -cert: die TSA soll ihr eigenes Zertifikat mitschicken, sonst kann
        // später niemand prüfen, wer da gestempelt hat.
        exec('openssl ts -query -data ' . escapeshellarg($pdfPfad)
             . ' -sha256 -cert -out ' . escapeshellarg($tsq) . ' 2>&1', $aus, $code);

        if ($code !== 0 || !is_file($tsq)) {
            error_log('seal_signaturen: TS-Query fehlgeschlagen: ' . implode(' ', $aus));
            return null;
        }

        $ch = curl_init(TSA_HOST);
        curl_setopt_array($ch, [
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => file_get_contents($tsq),
            CURLOPT_HTTPHEADER     => ['Content-Type: application/timestamp-query'],
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT        => 25,
            CURLOPT_CONNECTTIMEOUT => 10,
        ]);
        $antwort = curl_exec($ch);
        $status  = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $curlErr = curl_error($ch);
        curl_close($ch);

        if ($antwort === false || $status !== 200 || $antwort === '') {
            error_log("seal_signaturen: TSA antwortete $status $curlErr");
            return null;
        }

        file_put_contents($tsr, $antwort);

        // Nicht blind glauben, dass 200 auch „Granted" heißt: die TSA kann
        // mit HTTP 200 antworten und den Antrag im Token ablehnen. Ein
        // abgelehnter Token als Beweis wäre wertlos und niemand würde es
        // bemerken.
        $pruef = [];
        exec('openssl ts -reply -in ' . escapeshellarg($tsr) . ' -text 2>&1', $pruef, $pcode);
        $text = implode("\n", $pruef);

        if ($pcode !== 0 || !str_contains($text, 'Granted')) {
            error_log('seal_signaturen: TSA-Token nicht Granted: ' . substr($text, 0, 200));
            @unlink($tsr);
            return null;
        }

        chown($tsr, 'nginx');
        chgrp($tsr, 'nginx');
        chmod($tsr, 0640);

        return str_replace(WEBROOT . '/uploads/', '', $tsr);
    } catch (Throwable $e) {
        error_log('seal_signaturen zeitstempelHolen: ' . $e->getMessage());
        return null;
    } finally {
        @unlink($tsq);
    }
}

/**
 * Alle Unterzeichner dieses Dokuments, in der Reihenfolge, in der sie
 * angefordert wurden.
 *
 * Beim einzelnen Unterzeichner — dem Normalfall, und dem einzigen, den es
 * ausserhalb der Vollmacht gibt — ist das genau die uebergebene Zeile. Sie
 * wird trotzdem aus der Datenbank geholt statt durchgereicht, damit beide
 * Faelle denselben Weg nehmen; ein Sonderpfad fuer den haeufigen Fall waere
 * eine zweite Stelle, an der dasselbe anders passieren kann.
 */
function unterzeichnerDerGruppe(PDO $pdo, array $z): array
{
    $gruppe = (int)($z['gruppe_id'] ?? 0);
    if ($gruppe === 0) {
        return [$z];
    }

    $stmt = $pdo->prepare(
        "SELECT s.*, u.vorname, u.nachname, u.mitgliedernummer
           FROM dokument_signaturen s
           JOIN users u ON u.id = s.user_id
          WHERE s.gruppe_id = ?
          ORDER BY s.id ASC"
    );
    $stmt->execute([$gruppe]);
    $zeilen = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Sollte nie leer sein; wenn doch, lieber ein Blatt mit den Daten, die
    // vorliegen, als ein Dokument ganz ohne Unterschriftenblatt.
    return $zeilen ?: [$z];
}

/**
 * Liefert einen Pfad, den der freie FPDI-Parser öffnen kann.
 *
 * PDFs ab Version 1.5 dürfen ihre Objekte in Objekt-Streams packen und die
 * Querverweistabelle als Stream ablegen. Der freie Parser von FPDI kann das
 * nicht lesen und wirft „probably uses a compression technique which is not
 * supported"; dafür gibt es ein kostenpflichtiges Zusatzmodul. Das erste
 * echte Dokument im Betrieb (Jobcenter-WBA, PDF 1.7 mit 13 Objekt-Streams)
 * war genau so gebaut — es ist der Normalfall, nicht die Ausnahme.
 *
 * `pdftk … uncompress` löst die Streams auf. Das ist eine STRUKTURELLE
 * Umformung: dieselben Objekte, nur nicht mehr verpackt. Der Inhalt wird
 * nicht neu gerendert, anders als bei einem Umweg über Ghostscript — Schriften
 * und Layout bleiben also Bit für Bit dieselben Anweisungen.
 *
 * Das Original wird nicht angefasst. Es bleibt die Datei, auf die `pdf_hash`
 * passt und die dem Mitglied gezeigt wurde; gesiegelt wird eine Kopie, deren
 * eigener Hash in `signiert_pdf_hash` steht.
 *
 * Geht pdftk nicht, wird der Originalpfad zurückgegeben — dann scheitert FPDI
 * mit seiner eigenen, aussagekräftigen Meldung, statt dass hier eine zweite
 * Fehlerquelle die erste verdeckt.
 */
function lesbarMachen(string $quelle): string
{
    // Nicht raten, ob FPDI die Datei mag, sondern es versuchen.
    //
    // Der erste Anlauf hat es geraten: „steht am Ende kein xref, ist die
    // Tabelle ein Stream". Das trifft nie zu — in JEDEM PDF steht dort
    // `startxref`, und das enthält die Zeichenfolge. Die Erkennung war damit
    // immer negativ, und der Umweg wurde nie gegangen. Ein Versuch mit
    // anschließendem Rückfall kann sich nicht auf diese Weise irren.
    try {
        $probe = new \setasign\Fpdi\Tcpdf\Fpdi();
        $probe->setSourceFile($quelle);
        return $quelle;
    } catch (Throwable $e) {
        // Weiter unten: entpacken und erneut versuchen.
    }

    $pdftk = null;
    foreach (PDFTK_PFADE as $kandidat) {
        if (is_executable($kandidat)) {
            $pdftk = $kandidat;
            break;
        }
    }
    if ($pdftk === null) {
        error_log('seal_signaturen: pdftk nicht gefunden in ' . implode(', ', PDFTK_PFADE));
        return $quelle;
    }

    $ziel = tempnam(sys_get_temp_dir(), 'siegel_') . '.pdf';
    exec(sprintf('%s %s output %s uncompress 2>&1',
        escapeshellcmd($pdftk), escapeshellarg($quelle), escapeshellarg($ziel)
    ), $aus, $code);

    if ($code !== 0 || !is_file($ziel) || filesize($ziel) === 0) {
        @unlink($ziel);
        error_log('seal_signaturen: pdftk fehlgeschlagen: ' . implode(' ', $aus));
        return $quelle;
    }

    chmod($ziel, 0600);
    return $ziel;
}

/**
 * Schreibt das gesiegelte PDF neben das Original.
 *
 * Erst in eine temporäre Datei, dann umbenennen: `rename` innerhalb desselben
 * Dateisystems ist atomar. Bricht der Lauf mittendrin ab, liegt entweder das
 * fertige Dokument da oder gar keines — nie ein halbes, auf das die Datenbank
 * schon zeigt.
 */
function ablegen(array $z, $pdf): array
{
    $verzeichnis = WEBROOT . '/uploads/signaturen/' . $z['user_id'];
    if (!is_dir($verzeichnis) && !mkdir($verzeichnis, 0750, true) && !is_dir($verzeichnis)) {
        throw new RuntimeException('Ablage nicht anlegbar: ' . $verzeichnis);
    }

    $name    = $z['id'] . '_signiert.pdf';
    $absolut = $verzeichnis . '/' . $name;
    $temp    = $absolut . '.tmp';

    $pdf->Output($temp, 'F');
    if (!is_file($temp) || filesize($temp) === 0) {
        @unlink($temp);
        throw new RuntimeException('Siegeln hat keine Datei erzeugt');
    }
    if (!rename($temp, $absolut)) {
        @unlink($temp);
        throw new RuntimeException('Umbenennen fehlgeschlagen');
    }

    chown($absolut, 'nginx');
    chgrp($absolut, 'nginx');
    chmod($absolut, 0640);

    return [
        'absolut' => $absolut,
        'relativ' => 'signaturen/' . $z['user_id'] . '/' . $name,
    ];
}

/**
 * Das angehängte Blatt: Unterschrift oben, Beweisbündel darunter.
 *
 * Es steht in Klartext da und nicht in Kürzeln, weil es jemand lesen können
 * muss, der das Dokument Jahre später in der Hand hält und weder die App noch
 * die Datenbank kennt.
 */
function unterschriftenblatt($pdf, array $z): void
{
    $pdf->SetFont('helvetica', 'B', 14);
    $pdf->SetXY(15, 20);
    $pdf->Cell(0, 8, 'Digitale Unterschrift', 0, 1);

    $pdf->SetFont('helvetica', '', 10);
    $pdf->SetX(15);
    $pdf->MultiCell(180, 5,
        'Dieses Dokument wurde vom unten genannten Mitglied elektronisch '
      . 'unterschrieben. Die Unterschrift wurde auf dem Bildschirm geleistet '
      . 'und mit einem Einmalcode bestätigt, der an die im Verein hinterlegte '
      . 'Mobilnummer geschickt wurde.', 0, 'L');

    // --- die gemalte Unterschrift ---
    $pdf->SetXY(15, 50);
    $pdf->SetFont('helvetica', 'B', 10);
    $pdf->Cell(0, 6, 'Unterschrift ' . trim($z['vorname'] . ' ' . $z['nachname']), 0, 1);

    $rahmenY = $pdf->GetY();
    $pdf->Rect(15, $rahmenY, 90, 30);

    $svg = (string)($z['signature_svg'] ?? '');
    if ($svg !== '') {
        try {
            $pdf->ImageSVG('@' . $svg, 17, $rahmenY + 2, 86, 26, '', '', '', 0, false);
        } catch (Throwable $e) {
            // Lieber ein leerer Rahmen mit Hinweis als eine Ausnahme, die das
            // ganze Siegel verhindert. Der Beweis steht im Bündel darunter,
            // nicht in der Zeichnung.
            $pdf->SetXY(17, $rahmenY + 12);
            $pdf->SetFont('helvetica', 'I', 8);
            $pdf->Cell(86, 6, '[Unterschrift nicht darstellbar]', 0, 0, 'C');
            error_log("seal_signaturen ImageSVG #{$z['id']}: " . $e->getMessage());
        }
    }

    // --- Beweisbündel ---
    $pdf->SetXY(15, $rahmenY + 38);
    $pdf->SetFont('helvetica', 'B', 10);
    $pdf->Cell(0, 6, 'Beweisbundel', 0, 1);

    $felder = [
        'Mitglied'                => trim($z['vorname'] . ' ' . $z['nachname'])
                                     . ' (' . $z['mitgliedernummer'] . ')',
        'Dokument'                => (string)$z['dokument_titel'],
        'SHA-256 des Dokuments'   => (string)$z['pdf_hash'],
        'Unterschrieben (UTC)'    => (string)$z['signed_at_utc'],
        'Gerätezeit vor Ort'      => (string)($z['signed_at_local'] ?? '—'),
        'IP-Adresse'              => (string)($z['ip_address'] ?? '—'),
        'Hostname (Reverse-DNS)'  => (string)($z['reverse_dns'] ?? '—'),
        'Gerät'                   => (string)($z['device_hostname'] ?? '—'),
        'Geräteschlüssel'         => (string)($z['device_id'] ?? '—'),
        'Code gesendet an'        => (string)($z['tan_an'] ?? '—'),
        'Code bestätigt (UTC)'    => (string)($z['tan_verified_at'] ?? '—'),
        // Diese drei standen bisher NUR in der Datenbank und in der Ansicht des
        // Vorsitzenden, nicht auf dem Blatt. Damit waren sie die einzigen
        // angezeigten Beweisangaben ohne jede Verankerung: der Kettenhash deckt
        // sie nicht ab, und ohne Abdruck im zeitgestempelten PDF haette sich
        // 'Land: DE' spaeter unbemerkt in etwas anderes aendern lassen.
        // Auf dem Blatt sind sie durch den Zeitstempel mitgesichert.
        'Land (aus IP)'           => (string)($z['country_iso'] ?? '—'),
        'Netzbetreiber (aus IP)'  => (string)($z['isp'] ?? '—'),
        'App-Fassung'             => (string)($z['app_version'] ?? '—'),
        'Kettenhash'              => (string)($z['full_hash'] ?? '—'),
        'Prüfcode'                => (string)($z['verify_code'] ?? '—'),
    ];

    $pdf->SetFont('courier', '', 8);
    foreach ($felder as $bezeichnung => $wert) {
        $pdf->SetX(15);
        $pdf->SetFont('helvetica', '', 8);
        $pdf->Cell(50, 5, $bezeichnung, 0, 0);
        $pdf->SetFont('courier', '', 8);
        $pdf->MultiCell(130, 5, $wert, 0, 'L');
    }

    $pdf->Ln(4);
    $pdf->SetX(15);
    $pdf->SetFont('helvetica', 'I', 7);
    // Der Satz stand hier als unbedingte Zusage („wird … aufbewahrt, der
    // beweist …"). Zum Zeitpunkt des Drucks kann er das nicht sein: der
    // Zeitstempel wird erst geholt, wenn dieses PDF fertig auf der Platte
    // liegt — er gilt ja fuer die fertige Datei. Faellt die Zeitstempelstelle
    // aus, behauptete das Blatt dauerhaft etwas, das es nicht gibt. In einem
    // Beweisdokument ist eine widerlegbare Angabe schlimmer als eine fehlende:
    // wer sie kippt, stellt jede andere Zeile mit in Frage.
    $pdf->MultiCell(180, 4,
        'Das Dokument tragt ein kryptografisches Siegel des Vereins. Eine '
      . 'nachtragliche Anderung des Dokuments oder dieses Blattes macht das '
      . 'Siegel ungultig. Zu diesem Dokument wird zusatzlich ein Zeitstempel '
      . 'einer unabhangigen Zeitstempelstelle (freetsa.org, RFC 3161) '
      . 'angefordert; liegt er vor, wird er zusammen mit dem Dokument '
      . 'aufbewahrt und ist beim Verein abrufbar. Er belegt dann, dass das '
      . 'Dokument zum bestatigten Zeitpunkt bereits in genau dieser Fassung '
      . 'vorlag.', 0, 'L');
}
