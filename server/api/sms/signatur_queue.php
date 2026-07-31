<?php
/**
 * /api/sms/signatur_queue.php
 *
 * Die TAN-Warteschlange, so wie sie das Vereins-Tablet abarbeitet. Gleiche
 * Bauart wie api/chat/sms_outbox.php:
 *
 *   1. Der member-Endpunkt reiht beim Anfordern eine Zeile ein (nicht hier).
 *   2. Gateway ruft {"action":"list"}   → offene Zeilen inkl. Nummer.
 *   3. Gateway ruft {"action":"claim"}  → belegt sie, damit ein zweites
 *                                          Vorsitzer-Gerät sie nicht auch schickt.
 *   4. Gateway ruft {"action":"report"} → echter Sendestatus des Netzes.
 *
 * Der Server hat kein Modem; jede SMS verlässt das Haus über die SIM des
 * Tablets. Deshalb ist dieser Endpunkt kein Beiwerk, sondern der einzige Weg,
 * auf dem eine TAN je beim Mitglied ankommt.
 *
 * Zugang nur für Vorsitzer/Stellvertreter — die Zeilen tragen Rufnummern.
 */

declare(strict_types=1);

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../helpers.php';

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

$rolle = $pdo->prepare("SELECT role FROM users WHERE id = ?");
$rolle->execute([$userId]);
$role = (string)$rolle->fetchColumn();

if (!in_array($role, ['vorsitzer', 'stellvertreter'], true)) {
    http_response_code(403);
    jsonResponse(false, [], 'Forbidden');
}

$input  = json_decode(file_get_contents('php://input'), true);
$action = is_array($input) ? (string)($input['action'] ?? '') : '';

try {
    switch ($action) {

        // Offene TANs. Abgelaufene werden vorher weggeräumt: eine TAN, die
        // nicht mehr gilt, darf nicht mehr rausgehen — die SMS käme an,
        // während der Code auf dem Server bereits tot ist, und das Mitglied
        // würde einen Code eintippen, der garantiert nicht funktioniert.
        case 'list': {
            $pdo->exec(
                "UPDATE signatur_sms_queue q
                   JOIN signatur_tan t ON t.id = q.tan_id
                    SET q.status = 'fehler', q.fehler = 'TAN abgelaufen'
                  WHERE q.status = 'offen' AND t.gueltig_bis <= UTC_TIMESTAMP()"
            );

            // claimed-Zeilen, die seit über zehn Minuten hängen, gelten als
            // verloren (Tablet abgestürzt, App beendet) und werden wieder frei.
            $pdo->exec(
                "UPDATE signatur_sms_queue
                    SET status = 'offen', claimed_by = NULL, claimed_at = NULL
                  WHERE status = 'claimed'
                    AND claimed_at < DATE_SUB(UTC_TIMESTAMP(), INTERVAL 10 MINUTE)"
            );

            $stmt = $pdo->query(
                "SELECT q.id, q.signatur_id, q.telefon, q.body, q.created_at
                   FROM signatur_sms_queue q
                  WHERE q.status = 'offen'
                  ORDER BY q.created_at ASC
                  LIMIT 50"
            );
            jsonResponse(true, ['queue' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
            break;
        }

        case 'claim': {
            $deviceId = trim((string)($input['device_id'] ?? ''));
            $ids      = $input['ids'] ?? [];

            if ($deviceId === '' || !is_array($ids) || $ids === []) {
                http_response_code(400);
                jsonResponse(false, [], 'Missing device_id or ids');
            }

            $sauber = array_values(array_filter(array_map('intval', $ids), fn($i) => $i > 0));
            if ($sauber === []) {
                http_response_code(400);
                jsonResponse(false, [], 'No valid ids');
            }

            $platzhalter = implode(',', array_fill(0, count($sauber), '?'));

            // Nur was noch 'offen' ist, lässt sich belegen. Damit gewinnt bei
            // zwei gleichzeitig pollenden Geräten genau eines, und die SMS
            // geht einmal raus statt zweimal.
            $upd = $pdo->prepare(
                "UPDATE signatur_sms_queue
                    SET status = 'claimed', claimed_by = ?, claimed_at = UTC_TIMESTAMP()
                  WHERE status = 'offen' AND id IN ($platzhalter)"
            );
            $upd->execute(array_merge([$deviceId], $sauber));

            $mein = $pdo->prepare(
                "SELECT id FROM signatur_sms_queue
                  WHERE claimed_by = ? AND status = 'claimed' AND id IN ($platzhalter)"
            );
            $mein->execute(array_merge([$deviceId], $sauber));

            jsonResponse(true, [
                'claimed' => array_map('intval', $mein->fetchAll(PDO::FETCH_COLUMN)),
            ]);
            break;
        }

        case 'report': {
            $id     = (int)($input['id'] ?? 0);
            $status = (string)($input['status'] ?? '');

            if ($id <= 0) {
                http_response_code(400);
                jsonResponse(false, [], 'Missing id');
            }
            if (!in_array($status, ['gesendet', 'fehler'], true)) {
                http_response_code(400);
                jsonResponse(false, [], 'Invalid status');
            }

            $pdo->prepare(
                "UPDATE signatur_sms_queue
                    SET status = ?,
                        gesendet_at = CASE WHEN ? = 'gesendet' THEN UTC_TIMESTAMP() ELSE gesendet_at END,
                        segments = ?,
                        fehler = ?
                  WHERE id = ?"
            )->execute([
                $status,
                $status,
                isset($input['segments']) ? (int)$input['segments'] : null,
                isset($input['error']) && $input['error'] !== '' ? substr((string)$input['error'], 0, 255) : null,
                $id,
            ]);

            // Erfolgreich verschickte Zeilen tragen die TAN im Klartext. Sie
            // hat ihren Zweck erfüllt und muss nicht in der Datenbank liegen
            // bleiben — der Beweis hängt am Hash in signatur_tan, nicht hier.
            if ($status === 'gesendet') {
                $pdo->prepare(
                    "UPDATE signatur_sms_queue SET body = '' WHERE id = ?"
                )->execute([$id]);
            }

            jsonResponse(true, ['reported' => $status]);
            break;
        }

        default:
            http_response_code(400);
            jsonResponse(false, [], 'Unknown action');
    }
} catch (Throwable $e) {
    error_log('signatur_queue: ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Server error');
}
