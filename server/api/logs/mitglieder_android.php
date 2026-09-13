<?php
/**
 * Log Storage Endpoint - Mitglieder Android
 *
 * Nimmt beide Nutzlastformen entgegen:
 *   {v:1, iv, data}          → AES-256-GCM-Startprotokoll → api/data/logs/mitglieder_android/
 *   {mitgliedernummer, logs} → Klartextstrom              → <webroot>/logs/mitglieder_android/
 *
 * Der ganze Rumpf steht in log_ingest_lib.php, gemeinsam mit dem
 * Gegenstueck der anderen Plattform. Vorher waren die beiden Dateien Zeichen
 * fuer Zeichen gleich, und jede Absicherung musste zweimal gemacht werden —
 * so entstand die Pfad-Traversierung aus README.md in beiden zugleich.
 */

define('API_ACCESS', true);
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/log_ingest_lib.php';

log_ingest_handle('android');
