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

jsonResponse(true, [
    'age'        => $age,
    'status'     => $status,
    'min_age'    => 16,
    'adult_age'  => 18,
], 'Age check complete');
