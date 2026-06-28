<?php
define('API_ACCESS', true);
require_once '../config.php';
require_once '../helpers.php';

header('Content-Type: application/json');
validateApiKey();
blockBrowserAccess();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405); jsonResponse(false, [], 'Method not allowed');
}

$user_id = requireAuth();
$pdo = getDBConnection();

$data = json_decode(file_get_contents('php://input'), true);

// Check Stufe statuses
$check1 = $pdo->prepare("SELECT status FROM user_verifizierung WHERE user_id = ? AND stufe = 1");
$check1->execute([$user_id]);
$stufe1 = $check1->fetch(PDO::FETCH_ASSOC);

$check2 = $pdo->prepare("SELECT status FROM user_verifizierung WHERE user_id = ? AND stufe = 2");
$check2->execute([$user_id]);
$stufe2 = $check2->fetch(PDO::FETCH_ASSOC);

// Determine what is being updated
$hasMitgliedsart = isset($data['mitgliedsart']) && !empty($data['mitgliedsart']);
$hasPersonalData = false;
$personalFields = ['vorname', 'vorname2', 'nachname', 'geburtsname',
                    'strasse', 'hausnummer', 'plz', 'ort',
                    'bundesland', 'land', 'telefon_mobil', 'telefon_fix',
                    'geburtsdatum', 'geburtsort',
                    'geschlecht', 'familienstand',
                    'staatsangehoerigkeit', 'aufenthaltsstatus', 'muttersprache'];
foreach ($personalFields as $pf) {
    if (isset($data[$pf])) { $hasPersonalData = true; break; }
}

// Block personal data changes if Stufe 1 is already verified
if ($hasPersonalData && $stufe1 && $stufe1['status'] === 'geprueft') {
    // Allow only mitgliedsart update even if stufe 1 is verified
    if (!$hasMitgliedsart) {
        jsonResponse(false, [], 'Persönliche Daten bereits verifiziert. Änderungen nur über Live-Chat möglich.');
        exit;
    }
    // Only process mitgliedsart, ignore personal data fields
    $hasPersonalData = false;
}

// Block mitgliedsart change if Stufe 2 is already verified
if ($hasMitgliedsart && $stufe2 && $stufe2['status'] === 'geprueft') {
    jsonResponse(false, [], 'Mitgliedsart bereits verifiziert. Änderungen nur über Live-Chat möglich.');
    exit;
}

$fields = [];
$params = [];

// Process personal data fields
if ($hasPersonalData) {
    $allowed = ['vorname', 'vorname2', 'nachname', 'geburtsname',
                'strasse', 'hausnummer', 'plz', 'ort',
                'bundesland', 'land', 'telefon_mobil', 'telefon_fix',
                'geburtsort', 'staatsangehoerigkeit', 'muttersprache'];
    foreach ($allowed as $field) {
        if (isset($data[$field])) {
            $fields[] = "$field = ?";
            $params[] = $data[$field];
        }
    }
    // Validated enum-style fields — reject anything not in the
    // canonical set so we don't accidentally store free-text values
    // that the Vorstand panel can't render.
    $validGeschlecht = ['maennlich', 'weiblich', 'divers'];
    if (isset($data['geschlecht']) && in_array($data['geschlecht'], $validGeschlecht, true)) {
        $fields[] = 'geschlecht = ?';
        $params[] = $data['geschlecht'];
    }
    $validFamilienstand = ['ledig', 'verheiratet', 'geschieden', 'verwitwet'];
    if (isset($data['familienstand']) && in_array($data['familienstand'], $validFamilienstand, true)) {
        $fields[] = 'familienstand = ?';
        $params[] = $data['familienstand'];
    }
    $validAufenthalt = ['deutsch', 'eu_eea_freizuegigkeit',
        'aufenthaltserlaubnis', 'niederlassungserlaubnis', 'daueraufenthalt_eu',
        'blaue_karte_eu', 'asylberechtigt', 'fluechtling_gfk',
        'subsidiaerer_schutz', 'aufenthaltsgestattung', 'duldung',
        'humanitaer', 'sonstige'];
    if (isset($data['aufenthaltsstatus']) && in_array($data['aufenthaltsstatus'], $validAufenthalt, true)) {
        $fields[] = 'aufenthaltsstatus = ?';
        $params[] = $data['aufenthaltsstatus'];
    }
    // Geburtsdatum special handling (DATE format)
    if (isset($data['geburtsdatum']) && !empty($data['geburtsdatum'])) {
        $date = DateTime::createFromFormat('Y-m-d', $data['geburtsdatum']);
        if ($date) {
            $fields[] = "geburtsdatum = ?";
            $params[] = $date->format('Y-m-d');
        }
    }
}

// Process mitgliedsart
if ($hasMitgliedsart) {
    $validTypes = ['ordentlich', 'foerdermitglied', 'ehrenmitglied'];
    if (in_array($data['mitgliedsart'], $validTypes)) {
        $fields[] = "mitgliedsart = ?";
        $params[] = $data['mitgliedsart'];
    }
}

if (empty($fields)) {
    jsonResponse(false, [], 'Keine Daten zum Aktualisieren');
    exit;
}

$params[] = $user_id;
$sql = "UPDATE users SET " . implode(', ', $fields) . " WHERE id = ?";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);

// Update combined name field
if ($hasPersonalData && (isset($data['vorname']) || isset($data['nachname']))) {
    $nameStmt = $pdo->prepare("SELECT vorname, nachname FROM users WHERE id = ?");
    $nameStmt->execute([$user_id]);
    $nameRow = $nameStmt->fetch(PDO::FETCH_ASSOC);
    $fullName = trim(($nameRow['vorname'] ?? '') . ' ' . ($nameRow['nachname'] ?? ''));
    if (!empty($fullName)) {
        $pdo->prepare("UPDATE users SET name = ? WHERE id = ?")->execute([$fullName, $user_id]);
    }
}

// Set Stufe 1 to ausgefuellt if personal data was updated
if ($hasPersonalData && $stufe1 && in_array($stufe1['status'], ['offen', 'abgelehnt'])) {
    $pdo->prepare("UPDATE user_verifizierung SET status = 'ausgefuellt', notiz = NULL WHERE user_id = ? AND stufe = 1")
        ->execute([$user_id]);
}

// Set Stufe 2 to ausgefuellt if mitgliedsart was updated
if ($hasMitgliedsart && $stufe2 && in_array($stufe2['status'], ['offen', 'abgelehnt'])) {
    $pdo->prepare("UPDATE user_verifizierung SET status = 'ausgefuellt', notiz = NULL WHERE user_id = ? AND stufe = 2")
        ->execute([$user_id]);
}

jsonResponse(true, [], 'Daten aktualisiert');
