<?php
/**
 * Cleanup TLS Failure Reports
 *
 * Deletes tls_failures rows older than 90 days. Retention is documented in
 * the Datenschutz; this enforces it automatically.
 *
 * Auto-routes to test DB when invoked as *_test.php (mirrors the endpoint
 * convention so staging and prod share the same source).
 *
 * Schedule: daily at 03:30.
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
        'DELETE FROM tls_failures WHERE failed_at < DATE_SUB(NOW(), INTERVAL 90 DAY)'
    );
    $stmt->execute();
    $deleted = $stmt->rowCount();

    echo "[$startedAt] tls_failures cleanup: deleted=$deleted env=" .
        ($isTest ? 'staging' : 'prod') . "\n";
} catch (PDOException $e) {
    fwrite(STDERR, "[$startedAt] tls_failures cleanup FAILED: " . $e->getMessage() . "\n");
    exit(1);
}
