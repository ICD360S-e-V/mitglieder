-- Migration: Netzanfragen je Verursacher in battery_usage_segments
--
-- Grund: `network_requests` sagte, DASS die App das Funkmodem in einem
-- Messfenster 83-mal pro Stunde geweckt hat, aber nicht wer. Damit liess sich
-- die nächste Optimierung nicht begründen — die Vermutung, der Heartbeat sei
-- der Hauptverursacher, blieb eine Vermutung.
--
-- Gespeichert wird die Aufschlüsselung als JSON statt als je eine Spalte pro
-- Quelle: die Menge der Quellen gehört der App, nicht der Datenbank, und eine
-- neue Quelle in einer künftigen App-Version soll keine Migration erzwingen.
-- Der Endpunkt verwirft Namen, die er nicht kennt, also bleibt der Inhalt auf
-- die tatsächlich definierten Quellen beschränkt.
--
-- `network_requests` bleibt als Summe erhalten: alle bestehenden Auswertungen
-- und die generierte Spalte requests_per_hour hängen daran, und ältere
-- App-Versionen senden weiterhin nur diesen Wert.
--
-- Auswertung, sobald Daten da sind — welcher Dienst weckt am häufigsten:
--
--   SELECT app_version,
--          SUM(JSON_EXTRACT(requests_by_source,'$.heartbeat'))  AS heartbeat,
--          SUM(JSON_EXTRACT(requests_by_source,'$.ticketPoll')) AS ticket,
--          SUM(JSON_EXTRACT(requests_by_source,'$.logUpload'))  AS logs,
--          SUM(JSON_EXTRACT(requests_by_source,'$.diagnostic')) AS diag,
--          SUM(JSON_EXTRACT(requests_by_source,'$.deviceData')) AS geraet,
--          SUM(JSON_EXTRACT(requests_by_source,'$.ntfy'))       AS ntfy,
--          SUM(JSON_EXTRACT(requests_by_source,'$.api'))        AS uebrige,
--          ROUND(SUM(duration_ms)/3600000,1)                    AS stunden
--   FROM battery_usage_segments
--   WHERE is_reliable = 1 AND background_ms > foreground_ms
--   GROUP BY app_version;
--
-- LONGTEXT statt JSON, weil MariaDB JSON ohnehin als LONGTEXT mit
-- CHECK-Constraint umsetzt; so bleibt die Migration auf älteren Versionen
-- anwendbar. NULL heisst: App-Version ohne Aufschlüsselung.

ALTER TABLE battery_usage_segments
  ADD COLUMN requests_by_source LONGTEXT NULL
  CHECK (requests_by_source IS NULL OR JSON_VALID(requests_by_source))
  AFTER network_requests;
