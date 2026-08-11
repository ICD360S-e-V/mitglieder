<?php
/**
 * /api/vorstand/signatur_pdf.php?mitgliedernummer=<V…>&id=<n>&which=original|signiert|tsr
 *
 * Gibt dem Vorsitzenden das Dokument eines Unterschriftsvorgangs heraus:
 * das unsignierte Original, die gesiegelte Fassung oder den
 * RFC-3161-Zeitstempel-Token.
 *
 * Ohne diesen Endpunkt wäre die gesiegelte Fassung nur auf der Platte
 * vorhanden und für niemanden erreichbar — der Vorsitzende könnte im Streitfall
 * genau das Dokument nicht vorlegen, für das der ganze Aufwand betrieben wurde.
 *
 * Der Token wird bewusst mit herausgegeben: wer die Unterschrift prüfen lassen
 * will, braucht beides. Mit PDF und .tsr kann ein Dritter ohne unsere Mithilfe
 * nachrechnen:
 *   openssl ts -verify -data <pdf> -in <tsr> -CAfile freetsa-cacert.pem
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../helpers.php';

validateApiKey();
blockBrowserAccess();

$caller = trim((string)($_GET['mitgliedernummer'] ?? ''));
$signaturId = (int)($_GET['id'] ?? 0);
$welche = (string)($_GET['which'] ?? 'signiert');

if (!in_array($welche, ['original', 'signiert', 'tsr'], true)) {
    $welche = 'signiert';
}

$pdo = getDBConnection();

$rolle = $pdo->prepare('SELECT id, role FROM users WHERE mitgliedernummer = ?');
$rolle->execute([$caller]);
$anrufer = $rolle->fetch(PDO::FETCH_ASSOC);

if ($caller === '' || !$anrufer || $anrufer['role'] !== 'vorsitzer') {
    http_response_code(403);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Forbidden');
}

// Bis hierher ist nur geprüft, dass die GENANNTE Nummer einem Vorsitzenden
// gehört — nicht, dass der Anrufer dieser Mensch ist. Und die Nummer steht in
// der URL.
//
// validateApiKey() lässt jeden gültigen Geräteschlüssel durch, also auch den
// eines beliebigen Mitglieds; ein Geräteschlüssel weist ein GERÄT aus, keine
// Person. Damit genügte
//   GET …/vorstand/signatur_pdf.php?mitgliedernummer=V27655&id=13&which=signiert
// samt eigenem Geräteschlüssel, um das unterschriebene Dokument eines fremden
// Mitglieds herunterzuladen. Bei signatur_manage.php war dasselbe Loch; hier
// wiegt es schwerer, weil der ganze Zugriff in eine Adresszeile passt.
//
// Erst beide Angaben zusammen sind eine Identität. Kein Client muss dafür
// geändert werden: die Vorsitzer-App sendet X-Device-Key bei jedem Aufruf.
// Zwei Wege, einer genügt — ausführlich begründet in
// vorstand/signatur_manage.php::anruferIstDieserMensch().
//
// Kurz: der Geräteschlüssel allein reicht nicht, weil 27 der 61 aktiven
// Schlüssel gar keine user_id tragen und sechs davon in Benutzung sind
// (darunter das MacBook mit der Vorsitzer-App). Das Token allein reicht auch
// nicht, weil signatur_service.dart heute keines mitschickt.
$kopf    = array_change_key_case(getallheaders(), CASE_LOWER);
$belegt  = false;

$auth = (string)($kopf['authorization'] ?? '');
if (preg_match('/Bearer\s+(.+)$/i', $auth, $m)) {
    $nutzlast = validateJWT(trim($m[1]));
    if (is_array($nutzlast) && (int)($nutzlast['userId'] ?? 0) === (int)$anrufer['id']) {
        $belegt = true;
    }
}

if (!$belegt) {
    $geraet = trim((string)($kopf['x-device-key'] ?? ''));
    if ($geraet !== '') {
        $bindung = $pdo->prepare(
            'SELECT 1 FROM device_keys
              WHERE device_key = ? AND user_id = ? AND is_active = 1
                AND revoked_at IS NULL'
        );
        $bindung->execute([$geraet, (int)$anrufer['id']]);
        $belegt = (bool)$bindung->fetchColumn();
    }
}

if (!$belegt) {
    error_log('signatur_pdf: Anrufer ist nicht ' . $caller);
    http_response_code(403);
    header('Content-Type: application/json; charset=utf-8');
    // Dieselbe Antwort wie oben: wer probiert, soll nicht erfahren, ob die
    // Nummer existiert oder nur der Nachweis nicht passt.
    jsonResponse(false, [], 'Forbidden');
}

if ($signaturId <= 0) {
    http_response_code(400);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Missing id');
}

$stmt = $pdo->prepare(
    "SELECT pdf_pfad, signiert_pdf_pfad, tsa_token_pfad, dokument_titel
       FROM dokument_signaturen WHERE id = ?"
);
$stmt->execute([$signaturId]);
$zeile = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$zeile) {
    http_response_code(404);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Nicht gefunden');
}

$relativ = match ($welche) {
    'original' => $zeile['pdf_pfad'],
    'tsr'      => $zeile['tsa_token_pfad'],
    default    => $zeile['signiert_pdf_pfad'],
};

if ($relativ === null || $relativ === '') {
    http_response_code(404);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, ['which' => $welche],
        $welche === 'signiert'
            ? 'Die gesiegelte Fassung wird noch erstellt.'
            : 'Diese Fassung gibt es nicht.');
}

$basis = realpath(__DIR__ . '/../../uploads');
$pfad  = realpath($basis . '/' . $relativ);

// Der Pfad kommt aus der eigenen Datenbank, wird aber trotzdem gegen das
// Upload-Verzeichnis geprüft. Stünde dort je ein `../`, wäre das hier der
// Unterschied zwischen einem Fehler und einem Datenabfluss.
if ($pfad === false || $basis === false || !str_starts_with($pfad, $basis . '/') || !is_file($pfad)) {
    error_log("vorstand signatur_pdf: fehlt oder ausserhalb: $relativ");
    http_response_code(404);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Datei nicht verfügbar');
}

$stamm = preg_replace('/[^A-Za-z0-9._-]+/', '_', (string)$zeile['dokument_titel']);
$dateiname = match ($welche) {
    'original' => $stamm . '.pdf',
    'tsr'      => $stamm . '_zeitstempel.tsr',
    default    => $stamm . '_signiert.pdf',
};

header('Content-Type: ' . ($welche === 'tsr' ? 'application/timestamp-reply' : 'application/pdf'));
header('Content-Length: ' . filesize($pfad));
header('Content-Disposition: attachment; filename="' . $dateiname . '"');
header('Cache-Control: private, no-store');
header('X-Content-Type-Options: nosniff');

readfile($pfad);
