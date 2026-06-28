<?php
/**
 * /api/public/wizard/check_age.php
 *
 * Compute the visitor's age from the birthdate they just typed in
 * Stufe 1b and tell the client which gate to take next:
 *
 *   age < 16   → too_young  : client shows Age Gate + locks device
 *   16 ≤ age   → minor      : client triggers Stufe 1b1 (parent hint)
 *      < 18
 *   age ≥ 18   → ok         : client continues to Stufe 1c
 *
 * Doing this server-side gives us a single source of truth for the
 * Satzung §6 / BGB §106 rules — the client mirrors the logic for snap
 * UX but the server's verdict is what wizard_finalize checks again at
 * the end.
 *
 * Payload (JSON POST):
 *   anonymous_id  string, required
 *   geburtsdatum  string, required (YYYY-MM-DD)
 *
 * Response:
 *   200 { success: true, age, status: "ok"|"minor"|"too_young",
 *         min_age: 16, adult_age: 18 }
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../../config.php';

validateApiKey();
blockBrowserAccess();

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    jsonResponse(false, [], 'Method not allowed');
}

$body = json_decode(file_get_contents('php://input'), true);
if (!is_array($body)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid JSON');
}

$anonymous_id = trim((string)($body['anonymous_id'] ?? ''));
$geburtsdatum = trim((string)($body['geburtsdatum'] ?? ''));

if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $geburtsdatum)) {
    http_response_code(400);
    jsonResponse(false, [], 'geburtsdatum must be YYYY-MM-DD');
}

try {
    $birth = new DateTime($geburtsdatum);
} catch (Exception $e) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid date');
}

$now = new DateTime();
if ($birth > $now) {
    http_response_code(400);
    jsonResponse(false, [], 'Birthdate cannot be in the future');
}

$age = (int)$now->diff($birth)->y;

if ($age < 16) {
    $status = 'too_young';
} elseif ($age < 18) {
    $status = 'minor';
} else {
    $status = 'ok';
}

// Reserve a mitgliedernummer on the draft so it's visible to the
// visitor from Stufe 1c onwards and so finalize.php uses the same id
// the user has been seeing throughout the wizard. Prefix follows the
// verdict: M for adults, J for minors. Too_young drafts never get
// one — the device is locked out anyway.
$mitgliedernummer = null;
if ($status !== 'too_young') {
    $prefix = ($status === 'minor') ? 'J' : 'M';
    try {
        $pdo = getDBConnection();
        $stmt = $pdo->prepare('SELECT mitgliedernummer FROM wizard_drafts
                               WHERE anonymous_id = ?');
        $stmt->execute([$anonymous_id]);
        $existing = $stmt->fetchColumn();
        if (is_string($existing) && strlen($existing) > 0
            && substr($existing, 0, 1) === $prefix) {
            // Visitor returns or edits birthdate within the same age
            // bucket — keep the number they've already seen.
            $mitgliedernummer = $existing;
        } else {
            for ($i = 0; $i < 100; $i++) {
                $candidate = $prefix . random_int(10000, 99999);
                $check = $pdo->prepare(
                    'SELECT 1 FROM users WHERE mitgliedernummer = ?
                     UNION ALL
                     SELECT 1 FROM wizard_drafts WHERE mitgliedernummer = ?'
                );
                $check->execute([$candidate, $candidate]);
                if (!$check->fetchColumn()) {
                    $mitgliedernummer = $candidate;
                    break;
                }
            }
            if ($mitgliedernummer !== null) {
                $pdo->prepare('UPDATE wizard_drafts SET mitgliedernummer = ?,
                               last_active = NOW() WHERE anonymous_id = ?')
                    ->execute([$mitgliedernummer, $anonymous_id]);
            }
        }
    } catch (Exception $e) {
        error_log('[wizard/check_age mnr] ' . $e->getMessage());
        // Non-fatal: don't block the age verdict. Client can retry.
        $mitgliedernummer = null;
    }
}

// Duplicate-registration probe. Runs only when wizard_drafts already
// has vorname + nachname (Stufe 1a has been submitted) and the
// applicant isn't blocked at the age gate. Looks up users by
// lowercased name + DOB and reports which polite-message the client
// should show. The visitor's OWN in-progress stub (status =
// 'nicht_verifiziert', created below) is excluded so a returning
// visitor isn't reported as a duplicate of themselves.
$duplicate = [
    'found'  => false,
    'action' => null,
];
$existingUserId = 0;
$draftVorname   = '';
$draftNachname  = '';
$draftGeburtsname = null;
if ($status !== 'too_young') {
    try {
        $dStmt = $pdo->prepare(
            'SELECT data_vorname, data_nachname, data_geburtsname, user_id
               FROM wizard_drafts
              WHERE anonymous_id = ?'
        );
        $dStmt->execute([$anonymous_id]);
        $names = $dStmt->fetch(PDO::FETCH_ASSOC) ?: [];
        $draftVorname     = isset($names['data_vorname'])  ? trim((string)$names['data_vorname'])  : '';
        $draftNachname    = isset($names['data_nachname']) ? trim((string)$names['data_nachname']) : '';
        $draftGeburtsname = isset($names['data_geburtsname']) && $names['data_geburtsname'] !== ''
                            ? (string)$names['data_geburtsname'] : null;
        $existingUserId   = (int)($names['user_id'] ?? 0);
        if ($draftVorname !== '' && $draftNachname !== '') {
            $uStmt = $pdo->prepare(
                'SELECT id, status, deactivated_at
                   FROM users
                  WHERE LOWER(vorname)  = LOWER(?)
                    AND LOWER(nachname) = LOWER(?)
                    AND geburtsdatum   = ?
                    AND id            != ?
                  ORDER BY id DESC
                  LIMIT 1'
            );
            $uStmt->execute([$draftVorname, $draftNachname, $geburtsdatum, $existingUserId]);
            $existing = $uStmt->fetch(PDO::FETCH_ASSOC);
            if ($existing) {
                $duplicate['found'] = true;
                $existingStatus = $existing['status'];
                if ($existingStatus === 'active') {
                    $duplicate['action'] = 'login';
                } elseif (in_array($existingStatus, ['neu',
                                                     'waiting_for_parent_consent'], true)) {
                    $duplicate['action'] = 'pending';
                } elseif ($existingStatus === 'nicht_verifiziert') {
                    // Different visitor with the same name+DOB whose
                    // own wizard run is still in progress — politely
                    // tell them an application is already underway.
                    $duplicate['action'] = 'pending';
                } elseif ($existingStatus === 'gekuendigt_selbst') {
                    // 90-day window matches the abuse throttle in
                    // finalize.php — re-register politely outside it,
                    // hard-block inside it.
                    $deactivatedAt = strtotime((string)$existing['deactivated_at']);
                    $duplicate['action'] = ($deactivatedAt !== false
                            && $deactivatedAt > strtotime('-90 days'))
                        ? 'recently_withdrawn'
                        : 'previously_withdrawn';
                } else {
                    // gekuendigt / gesperrt / suspended / deleted / verstorben /
                    // ausgeschlossen — too sensitive to enumerate; tell the
                    // visitor to call us.
                    $duplicate['action'] = 'call_us';
                }
            }
        }
    } catch (Exception $e) {
        error_log('[wizard/check_age duplicate] ' . $e->getMessage());
        // Non-fatal: a failed duplicate probe must not block the age check.
    }
}

// Create or refresh the users stub so the Vorstand can already see
// the registration in Mitgliederverwaltung's "Nicht verifiziert" tab
// before the wizard is finalized. Skipped when:
//   • visitor is being redirected to a duplicate-message screen
//     (don't pollute users with a stub the visitor will abandon)
//   • mnr couldn't be reserved (defensive — non-fatal)
//   • Stufe 1a hasn't been saved yet (no vorname/nachname to display)
if ($mitgliedernummer !== null
    && !$duplicate['found']
    && $draftVorname !== '' && $draftNachname !== '') {
    try {
        $autoEmail = strtolower($mitgliedernummer) . '@icd360s.de';
        $combinedName = trim($draftVorname . ' ' . $draftNachname);
        if ($existingUserId === 0) {
            // Fresh insert. INSERT IGNORE protects against a parallel
            // attempt racing on the same mnr (UNIQUE).
            $pdo->prepare(
                'INSERT IGNORE INTO users
                  (mitgliedernummer, email, password_hash, name,
                   vorname, nachname, geburtsname, geburtsdatum,
                   status, role, created_at)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?,
                  "nicht_verifiziert", ?, NOW())'
            )->execute([
                $mitgliedernummer,
                $autoEmail,
                password_hash(bin2hex(random_bytes(32)), PASSWORD_BCRYPT),
                $combinedName,
                $draftVorname, $draftNachname,
                $draftGeburtsname, $geburtsdatum,
                ($status === 'minor') ? 'jugendmitglied' : 'mitglied',
            ]);
            $uStmt = $pdo->prepare('SELECT id FROM users WHERE mitgliedernummer = ?');
            $uStmt->execute([$mitgliedernummer]);
            $existingUserId = (int)$uStmt->fetchColumn();
            if ($existingUserId > 0) {
                $pdo->prepare('UPDATE wizard_drafts SET user_id = ?
                               WHERE anonymous_id = ?')
                    ->execute([$existingUserId, $anonymous_id]);
                // 8 verifizierung rows, all initially "offen". The
                // save_step.php mirror flips them to "ausgefuellt" as
                // each Stufe lands.
                for ($s = 1; $s <= 8; $s++) {
                    $pdo->prepare('INSERT IGNORE INTO user_verifizierung
                                   (user_id, stufe, status)
                                   VALUES (?, ?, "offen")')
                        ->execute([$existingUserId, $s]);
                }
            }
        } else {
            // Stub already exists — refresh the mnr (in case the
            // age bucket flipped M↔J), email, and the name fields we
            // know so far. Do NOT clobber other columns: save_step
            // mirrors them as the visitor proceeds.
            $pdo->prepare(
                'UPDATE users
                    SET mitgliedernummer = ?, email = ?, name = ?,
                        vorname = ?, nachname = ?, geburtsname = ?,
                        geburtsdatum = ?, role = ?
                  WHERE id = ?'
            )->execute([
                $mitgliedernummer, $autoEmail, $combinedName,
                $draftVorname, $draftNachname,
                $draftGeburtsname, $geburtsdatum,
                ($status === 'minor') ? 'jugendmitglied' : 'mitglied',
                $existingUserId,
            ]);
        }
    } catch (Exception $e) {
        error_log('[wizard/check_age stub] ' . $e->getMessage());
        // Non-fatal: stub creation failure must not block the age check.
    }
}

jsonResponse(true, [
    'age'              => $age,
    'status'           => $status,
    'mitgliedernummer' => $mitgliedernummer,
    'duplicate'        => $duplicate,
    'min_age'          => 16,
    'adult_age'        => 18,
], 'Age check complete');
