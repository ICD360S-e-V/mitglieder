<?php
/**
 * /api/public/wizard/upload_leistungsbescheid.php
 *
 * Anonymous wizard equivalent of /api/member/upload_leistungsbescheid.php:
 * the visitor in Stufe 3 has selected bürgergeld/sozialamt and now has
 * to upload the proof document. Saved to
 * `/uploads/wizard_leistungsbescheid/<anonymous_id>.<ext>` and the
 * relative path written back into wizard_drafts.data_leistungsbescheid_file
 * so finalize.php picks it up later.
 *
 * Multipart POST:
 *   anonymous_id  (form field)
 *   file          (single file: PDF / JPG / JPEG / PNG, ≤ 10 MB)
 *
 * Response: 200 { success, file_path, original_name, size_bytes }
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

$anonymous_id = trim((string)($_POST['anonymous_id'] ?? ''));
if (strlen($anonymous_id) < 16 || strlen($anonymous_id) > 64
    || !preg_match('/^[A-Za-z0-9_-]+$/', $anonymous_id)) {
    http_response_code(400);
    jsonResponse(false, [], 'Invalid anonymous_id');
}
if (!isset($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
    http_response_code(400);
    jsonResponse(false, [], 'No file uploaded');
}

$file = $_FILES['file'];
$size = (int)$file['size'];
$tmp  = $file['tmp_name'];
$orig = $file['name'];

if ($size <= 0 || $size > 10 * 1024 * 1024) {
    http_response_code(413);
    jsonResponse(false, [], 'File too large (max 10 MB)');
}

$mime = mime_content_type($tmp);
$allowed = ['application/pdf', 'image/jpeg', 'image/png'];
if (!in_array($mime, $allowed, true)) {
    http_response_code(415);
    jsonResponse(false, ['detected_mime' => $mime],
        'Unsupported file type (only PDF/JPG/PNG)');
}

$ext = match ($mime) {
    'application/pdf' => 'pdf',
    'image/jpeg'      => 'jpg',
    'image/png'       => 'png',
};

$uploadDir = __DIR__ . '/../../../uploads/wizard_leistungsbescheid';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

// Filename keyed on anonymous_id so re-upload overwrites cleanly.
$fname = $anonymous_id . '.' . $ext;
$target = $uploadDir . '/' . $fname;
if (!move_uploaded_file($tmp, $target)) {
    http_response_code(500);
    jsonResponse(false, [], 'Failed to store upload');
}

// Path stored in DB is relative to /uploads/ for portability.
$relPath = 'wizard_leistungsbescheid/' . $fname;

try {
    $pdo = getDBConnection();
    $stmt = $pdo->prepare('UPDATE wizard_drafts
                           SET data_leistungsbescheid_file = ?,
                               last_active = NOW()
                           WHERE anonymous_id = ?');
    $stmt->execute([$relPath, $anonymous_id]);
    if ($stmt->rowCount() === 0) {
        // Draft missing: clean up the file we just stored to avoid
        // an orphan.
        @unlink($target);
        http_response_code(404);
        jsonResponse(false, [], 'Wizard draft not found');
    }
} catch (PDOException $e) {
    @unlink($target);
    error_log('[wizard/upload_leistungsbescheid] ' . $e->getMessage());
    http_response_code(500);
    jsonResponse(false, [], 'Database error');
}

jsonResponse(true, [
    'file_path'     => $relPath,
    'original_name' => $orig,
    'size_bytes'    => $size,
], 'Leistungsbescheid uploaded');
