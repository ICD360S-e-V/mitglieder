<?php
/**
 * Cleanup Battery Usage Segments
 *
 * Löscht battery_usage_segments-Zeilen, die älter als 90 Tage sind. Die
 * Aufbewahrungsfrist steht in der Datenschutzerklärung; das hier setzt sie
 * automatisch durch.
 *
 * Auto-routes to test DB when invoked as *_test.php (mirrors the endpoint
 * convention so staging and prod share the same source).
 *
 * Schedule: daily at 03:35 — direkt nach cleanup_tls_failures.php.
 */

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';

$isTest = strpos(basename(__FILE__), '_test') !== false;
$targetDb = $isTest ? 'icd360sev_test_db' : DB_NAME;

$startedAt = date('Y-m-d H:i:s');

try {
    $dsn = 'mysql:unix_socket=/var/lib/mysql/mysql.sock;dbname=' . $targetDb . ';charset=utf8mb4';
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ]);

    $stmt = $pdo->prepare(
        'DELETE FROM battery_usage_segments WHERE started_at < DATE_SUB(NOW(), INTERVAL 90 DAY)'
    );
    $stmt->execute();
    $deleted = $stmt->rowCount();

    echo "[$startedAt] battery_usage cleanup: deleted=$deleted env=" .
        ($isTest ? 'staging' : 'prod') . "\n";
} catch (PDOException $e) {
    fwrite(STDERR, "[$startedAt] battery_usage cleanup FAILED: " . $e->getMessage() . "\n");
    exit(1);
}
