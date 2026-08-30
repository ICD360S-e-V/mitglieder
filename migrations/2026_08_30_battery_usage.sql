-- Migration: battery_usage_segments
--
-- Zweck: Belegen, wie schnell sich ein Gerät entlädt, während diese App
--        läuft, und das gegen die Aktivität der App im selben Zeitraum
--        auftragen. Erst damit lässt sich eine Optimierung beweisen statt
--        behaupten.
--
-- Was hier NICHT steht: der Akkuverbrauch dieser App allein. Keine der
-- unterstützten Plattformen gibt einer normalen App die Zuordnung pro
-- Anwendung heraus (Android hält sie in BatteryStatsManager.getUidStats,
-- @SystemApi). Gespeichert wird die Entladerate des Geräts plus die Zähler
-- unserer eigenen Verursacher. Die Aussage entsteht aus dem Vergleich zweier
-- Zeiträume am selben Gerät, nicht aus einer Einzelzahl.
--
-- Genauigkeit: start_level/end_level sind ganze Prozent. Über ein
-- 20-Minuten-Fenster ist ein einziger Prozentschritt bereits ±3 %/h
-- Messfehler. Wo start_charge_uah/end_charge_uah gefüllt sind (Android
-- BATTERY_PROPERTY_CHARGE_COUNTER), ist avg_ma der belastbare Wert und
-- drain_per_hour nur Kontext. Auswertungen filtern auf is_reliable = 1.
--
-- DSGVO: berechtigtes Interesse (Art. 6(1)(f)) — Fehlerbehebung und
-- Produktqualität. Die Daten sind pseudonym: gemeldet wird ausschliesslich
-- unter der Gerätekennung, nie unter der Mitgliedernummer. Aufbewahrung
-- 90 Tage, per Cron durchgesetzt (siehe cleanup_battery_usage.php).

CREATE TABLE IF NOT EXISTS battery_usage_segments (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,

  -- Einzige Kennung. Bewusst KEINE Mitgliedernummer: die Auswertung vergleicht
  -- ein Gerät mit sich selbst über App-Versionen hinweg, wofür sie nichts
  -- beiträgt, und der Zustimmungsdialog der App sagt einen „anonymen
  -- Gerätecode (NICHT die Mitgliedsnummer)" zu.
  device_id VARCHAR(64) NOT NULL,

  reported_at DATETIME NOT NULL,
  started_at DATETIME NOT NULL,
  ended_at DATETIME NOT NULL,
  duration_ms BIGINT NOT NULL,

  -- Ganzzahlige Prozent, auf jeder Plattform verfügbar.
  start_level TINYINT UNSIGNED NOT NULL,
  end_level TINYINT UNSIGNED NOT NULL,

  -- Verbleibende Ladung in µAh, nur Android. NULL heisst: das Gerät liefert
  -- den Zähler nicht, es bleibt bei der Prozentmessung.
  start_charge_uah INT NULL,
  end_charge_uah INT NULL,

  -- Aufteilung der Fensterdauer auf App-Zustände. Die Summe darf kleiner als
  -- duration_ms sein, wenn die App zwischendurch nicht lief.
  foreground_ms BIGINT NOT NULL DEFAULT 0,
  background_ms BIGINT NOT NULL DEFAULT 0,

  -- Verursacher auf unserer Seite. network_requests ist die entscheidende
  -- Grösse: den Verbrauch bestimmt, wie oft das Funkmodem geweckt wird, nicht
  -- wie viele Bytes fliessen.
  network_requests INT NOT NULL DEFAULT 0,
  ws_reconnects INT NOT NULL DEFAULT 0,
  push_wakeups INT NOT NULL DEFAULT 0,

  -- 0 = Fenster zu kurz oder Entladung zu klein, um eine Rate abzuleiten.
  is_reliable TINYINT(1) NOT NULL DEFAULT 0,
  -- charging | stopped | rollover | gap
  closed_reason VARCHAR(16) NOT NULL DEFAULT 'stopped',
  connection_type VARCHAR(16) NULL,

  -- Systemzustand. Nur Android füllt standby_bucket, doze_exempt und
  -- thermal_status; die übrigen Plattformen kennen nichts Vergleichbares.
  power_save_mode TINYINT(1) NULL,
  -- 10 active, 20 working_set, 30 frequent, 40 rare, 45 restricted.
  standby_bucket SMALLINT NULL,
  doze_exempt TINYINT(1) NULL,
  thermal_status TINYINT NULL,

  app_version VARCHAR(20) NULL,
  platform VARCHAR(20) NULL,
  os_version VARCHAR(120) NULL,

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  -- Abgeleitete Grössen als STORED, damit sie indizierbar und in Auswertungen
  -- direkt verfügbar sind. NULLIF fängt Fenster mit duration_ms = 0 ab, die
  -- sonst eine Division durch null auslösen würden.
  drain_percent SMALLINT AS (CAST(start_level AS SIGNED) - CAST(end_level AS SIGNED)) STORED,
  drain_per_hour DECIMAL(8,3) AS (
    (CAST(start_level AS SIGNED) - CAST(end_level AS SIGNED)) * 3600000.0
    / NULLIF(duration_ms, 0)
  ) STORED,
  -- Mittlere Stromaufnahme des Geräts in mA. µAh * 3600 / ms ergibt mA.
  avg_ma DECIMAL(10,3) AS (
    (CAST(start_charge_uah AS SIGNED) - CAST(end_charge_uah AS SIGNED)) * 3600.0
    / NULLIF(duration_ms, 0)
  ) STORED,
  requests_per_hour DECIMAL(10,3) AS (
    network_requests * 3600000.0 / NULLIF(duration_ms, 0)
  ) STORED,

  -- Idempotenz: der Client behält einen Batch in der Warteschlange, wenn die
  -- Antwort verloren geht, und sendet ihn erneut. Ein Gerät kann kein zweites
  -- Fenster mit derselben Startzeit haben, also ist das der natürliche
  -- Schlüssel — ein Doppelsenden wird zum No-op statt zu einem Duplikat, das
  -- jeden Mittelwert verzerrt.
  UNIQUE KEY uniq_device_start (device_id, started_at),

  INDEX idx_device_time (device_id, started_at),
  INDEX idx_reliable_rate (is_reliable, drain_per_hour),
  INDEX idx_version_platform (app_version, platform),
  INDEX idx_started_at (started_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
