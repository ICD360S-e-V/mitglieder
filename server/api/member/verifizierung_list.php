<?php
define('API_ACCESS', true);
require_once '../config.php';
require_once '../helpers.php';

header('Content-Type: application/json');
validateApiKey();
blockBrowserAccess();

$user_id = requireAuth();
$pdo = getDBConnection();

// Auto-create missing stages
$check = $pdo->prepare("SELECT COUNT(*) FROM user_verifizierung WHERE user_id = ?");
$check->execute([$user_id]);
if ($check->fetchColumn() < 8) {
    for ($stufe = 1; $stufe <= 8; $stufe++) {
        $ins = $pdo->prepare("INSERT IGNORE INTO user_verifizierung (user_id, stufe) VALUES (?, ?)");
        $ins->execute([$user_id, $stufe]);
    }
}

// Get stages with reviewer info
$stmt = $pdo->prepare("
    SELECT uv.stufe, uv.status, uv.notiz, uv.geprueft_am,
           u2.name as geprueft_von_name
    FROM user_verifizierung uv
    LEFT JOIN users u2 ON uv.geprueft_von = u2.id
    WHERE uv.user_id = ?
    ORDER BY uv.stufe
");
$stmt->execute([$user_id]);
$stages = $stmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($stages as &$s) {
    $s['stufe'] = (int)$s['stufe'];
}

// Get personal data including acceptance timestamps. Mirrors every
// column the wizard writes via finalize.php so the Verifizierung tab
// can show all of Stufe 1 (Geburtsname, Geschlecht, Familienstand,
// Aufenthaltsstatus included) without follow-up requests.
$userStmt = $pdo->prepare("
    SELECT vorname, vorname2, nachname, geburtsname,
           strasse, hausnummer, plz, ort,
           bundesland, land, email, telefon_mobil, telefon_fix,
           mitgliedsart, finanzielle_situation, zahlungsmethode, zahlungstag,
           mitgliedschaftsbeginn_option, mitgliedschaftsbeginn_datum,
           geburtsdatum, geburtsort, geschlecht, familienstand,
           staatsangehoerigkeit, aufenthaltsstatus, muttersprache,
           datenschutz_accepted_at, satzung_accepted_at, widerrufsbelehrung_accepted_at
    FROM users WHERE id = ?
");
$userStmt->execute([$user_id]);
$userData = $userStmt->fetch(PDO::FETCH_ASSOC);

$completedCount = 0;
foreach ($stages as $s) {
    if ($s['status'] === 'geprueft') $completedCount++;
}

jsonResponse(true, [
    'data' => [
        'stufen' => $stages,
        'personal_data' => $userData ?: [],
        'completed_count' => $completedCount,
        'document_acceptances' => [
            'datenschutz' => $userData['datenschutz_accepted_at'] ?? null,
            'satzung' => $userData['satzung_accepted_at'] ?? null,
            'widerrufsbelehrung' => $userData['widerrufsbelehrung_accepted_at'] ?? null,
        ]
    ]
]);
