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

require_once WEBROOT . '/api/config.php';
require_once WEBROOT . '/pdflib/vendor/autoload.php';

$pdo = getDBConnection();

$offen = $pdo->prepare(
    "SELECT s.*, u.vorname, u.nachname, u.mitgliedernummer
       FROM dokument_signaturen s
       JOIN users u ON u.id = s.user_id
      WHERE s.status = 'signiert'
        AND s.signiert_pdf_pfad IS NULL
      ORDER BY s.signed_at_utc ASC
      LIMIT " . MAX_PRO_LAUF
);
$offen->execute();
$zeilen = $offen->fetchAll(PDO::FETCH_ASSOC);

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
        // aufhalten. Der nächste Lauf versucht es erneut — bleibt es dabei,
        // steht es im Log und der Vorgang bleibt ungesiegelt sichtbar.
        echo "  #{$zeile['id']} FEHLER: {$e->getMessage()}\n";
        error_log("seal_signaturen #{$zeile['id']}: " . $e->getMessage());
    }
}

// ---------------------------------------------------------------------------

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
    $seiten = $pdf->setSourceFile($quelle);
    for ($i = 1; $i <= $seiten; $i++) {
        $vorlage = $pdf->importPage($i);
        $masse   = $pdf->getTemplateSize($vorlage);
        $pdf->AddPage($masse['width'] > $masse['height'] ? 'L' : 'P',
                      [$masse['width'], $masse['height']]);
        $pdf->useTemplate($vorlage);
    }

    // --- Unterschriftenblatt anhängen ---
    //
    // Angehängt statt über den Text gelegt: wo auf einem fremden PDF Platz
    // ist, weiß niemand, und eine Unterschrift quer über einer Textzeile
    // sieht nach Fälschung aus, selbst wenn sie echt ist.
    $pdf->AddPage('P', 'A4');
    unterschriftenblatt($pdf, $z);

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

    $pdo->prepare(
        "UPDATE dokument_signaturen
            SET signiert_pdf_pfad = ?, signiert_pdf_hash = ?
          WHERE id = ?"
    )->execute([$ziel['relativ'], $pdfHash, $z['id']]);

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
        $pdo->prepare("UPDATE dokument_signaturen SET tsa_token_pfad = ? WHERE id = ?")
            ->execute([$token, $z['id']]);
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
    $pdf->MultiCell(180, 4,
        'Das Dokument tragt ein kryptografisches Siegel des Vereins. Eine '
      . 'nachtragliche Anderung des Dokuments oder dieses Blattes macht das '
      . 'Siegel ungultig. Zusatzlich wird zu diesem Dokument ein Zeitstempel '
      . 'einer unabhangigen Zeitstempelstelle (freetsa.org, RFC 3161) '
      . 'aufbewahrt, der beweist, dass es zum genannten Zeitpunkt bereits in '
      . 'genau dieser Fassung vorlag.', 0, 'L');
}
