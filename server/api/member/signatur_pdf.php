<?php
/**
 * /api/member/signatur_pdf.php?id=<signatur_id>&which=original|signiert
 *
 * Liefert das PDF eines Unterschriftsvorgangs an das Mitglied, dem er gehört.
 *
 * Warum ein eigener Endpunkt und kein statischer Pfad: unter /uploads/ liegen
 * die Dateien zwar auf der Platte, aber dort gibt es keine Autorisierung. Ein
 * direkter Link wäre für jeden abrufbar, der ihn errät oder mitliest — und
 * hier hängt an der Datei eine Unterschrift. Deshalb geht jeder Zugriff durch
 * requireAuth() und trägt `user_id = ?` in der Abfrage.
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../helpers.php';

validateApiKey();
blockBrowserAccess();

$userId = requireAuth();
$pdo    = getDBConnection();

$signaturId = (int)($_GET['id'] ?? 0);
$welche     = ($_GET['which'] ?? 'original') === 'signiert' ? 'signiert' : 'original';

if ($signaturId <= 0) {
    http_response_code(400);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Missing id');
}

$stmt = $pdo->prepare(
    "SELECT pdf_pfad, signiert_pdf_pfad, dokument_titel, status
       FROM dokument_signaturen
      WHERE id = ? AND user_id = ?"
);
$stmt->execute([$signaturId, $userId]);
$zeile = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$zeile) {
    http_response_code(404);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Nicht gefunden');
}

$relativ = $welche === 'signiert' ? $zeile['signiert_pdf_pfad'] : $zeile['pdf_pfad'];
if ($relativ === null || $relativ === '') {
    http_response_code(404);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Diese Fassung gibt es noch nicht');
}

$basis = realpath(__DIR__ . '/../../uploads');
$pfad  = realpath($basis . '/' . $relativ);

// Der Pfad kommt zwar aus der eigenen Datenbank, aber er wird trotzdem gegen
// das Upload-Verzeichnis geprüft. Stünde dort je ein `../`, würde diese Zeile
// den Unterschied zwischen einem Fehler und einem Datenabfluss ausmachen.
if ($pfad === false || $basis === false || !str_starts_with($pfad, $basis . '/') || !is_file($pfad)) {
    error_log("signatur_pdf: Datei fehlt oder liegt außerhalb: $relativ");
    http_response_code(404);
    header('Content-Type: application/json; charset=utf-8');
    jsonResponse(false, [], 'Datei nicht verfügbar');
}

$dateiname = preg_replace('/[^A-Za-z0-9._-]+/', '_', $zeile['dokument_titel']) . '.pdf';

header('Content-Type: application/pdf');
header('Content-Length: ' . filesize($pfad));
header('Content-Disposition: inline; filename="' . $dateiname . '"');
header('Cache-Control: private, no-store');
header('X-Content-Type-Options: nosniff');

readfile($pfad);
