-- Wizard onboarding + parent consent infrastructure
-- Target: icd360sev_db on 10.10.10.5
-- Safe to re-run: uses IF NOT EXISTS on new tables.

-- 1) Hint columns on `users` so child's wizard captures parent contact
--    while waiting for parent registration + Vormund linkage.
ALTER TABLE users
  ADD COLUMN parent_hint_vorname VARCHAR(100) NULL AFTER vormund_verknuepft_von,
  ADD COLUMN parent_hint_nachname VARCHAR(100) NULL AFTER parent_hint_vorname,
  ADD COLUMN parent_hint_telefon VARCHAR(20) NULL AFTER parent_hint_nachname,
  ADD COLUMN parent_hint_relation ENUM('mutter','vater','sorgeberechtigter','andere') NULL AFTER parent_hint_telefon,
  ADD COLUMN parent_hint_created_at DATETIME NULL AFTER parent_hint_relation;

-- 2) Extend `status` enum with the new minor-pending bucket.
ALTER TABLE users
  MODIFY COLUMN status ENUM('nicht_verifiziert','neu','active','passiv','ruhend',
    'gesperrt','gekuendigt_selbst','gekuendigt_verein','ausgeschlossen',
    'verstorben','suspended','deleted','gekuendigt','waiting_for_parent_consent')
  DEFAULT 'nicht_verifiziert';

-- 3) `parent_consent_signatures` — proof bundle when parent signs the
--    BGB §107/§1629 consent for their 16-17 year old child.
--    Captures everything Art. 6 DSGVO legitimes Interesse covers; no
--    GPS / no biometric trace (those would push us into Art. 9).
CREATE TABLE IF NOT EXISTS parent_consent_signatures (
  id INT AUTO_INCREMENT PRIMARY KEY,
  child_user_id INT NOT NULL,
  parent_user_id INT NOT NULL,
  consent_text TEXT NOT NULL,
  consent_text_hash CHAR(64) NOT NULL,
  signature_svg LONGTEXT NOT NULL,
  signed_at_utc DATETIME NOT NULL,
  signed_at_local VARCHAR(50) NOT NULL,
  ip_address VARCHAR(45) NOT NULL,
  isp VARCHAR(100) NULL,
  country_iso CHAR(2) NULL,
  user_agent VARCHAR(500) NULL,
  device_id VARCHAR(64) NULL,
  full_hash CHAR(64) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (child_user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (parent_user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_child (child_user_id),
  INDEX idx_parent (parent_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4) `wizard_drafts` — server-side draft storage for the onboarding
--    wizard. Visitor starts wizard → anonymous_id created locally and
--    on server. Each step writes here. At final submit, server reads
--    full draft, creates real `users` row + populates personal data +
--    user_verifizierung rows. Drafts auto-expire after 30 days.
CREATE TABLE IF NOT EXISTS wizard_drafts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  anonymous_id VARCHAR(64) NOT NULL UNIQUE,
  user_id INT NULL,
  current_step VARCHAR(20) NOT NULL DEFAULT 'intro',
  -- Stufe 1 fields:
  data_vorname VARCHAR(255) NULL,
  data_nachname VARCHAR(100) NULL,
  data_geburtsname VARCHAR(100) NULL,
  data_geburtsdatum DATE NULL,
  data_geburtsort VARCHAR(100) NULL,
  data_geschlecht VARCHAR(20) NULL,
  data_familienstand VARCHAR(50) NULL,
  data_staatsangehoerigkeit VARCHAR(100) NULL DEFAULT 'deutsch',
  data_aufenthaltsstatus VARCHAR(100) NULL,
  data_muttersprache VARCHAR(50) NULL,
  data_strasse VARCHAR(255) NULL,
  data_hausnummer VARCHAR(20) NULL,
  data_plz VARCHAR(10) NULL,
  data_ort VARCHAR(100) NULL,
  data_land VARCHAR(100) NULL DEFAULT 'Deutschland',
  data_telefon_mobil VARCHAR(20) NULL,
  data_email VARCHAR(255) NULL,
  -- Stufe 2:
  data_mitgliedsart VARCHAR(50) NULL,
  -- Stufe 3:
  data_finanzielle_situation VARCHAR(50) NULL,
  data_leistungsbescheid_file VARCHAR(255) NULL,
  -- Stufe 4:
  data_zahlungsmethode VARCHAR(50) NULL,
  data_zahlungstag INT NULL,
  -- Stufe 5:
  data_mitgliedschaftsbeginn_option VARCHAR(50) NULL,
  data_mitgliedschaftsbeginn_datum DATE NULL,
  -- Stufe 6/7/8 (document acceptance):
  data_satzung_read TINYINT(1) DEFAULT 0,
  data_datenschutz_read TINYINT(1) DEFAULT 0,
  data_widerrufsbelehrung_read TINYINT(1) DEFAULT 0,
  -- Minor flow (16-17):
  data_parent_hint_vorname VARCHAR(100) NULL,
  data_parent_hint_nachname VARCHAR(100) NULL,
  data_parent_hint_telefon VARCHAR(20) NULL,
  data_parent_hint_relation ENUM('mutter','vater','sorgeberechtigter','andere') NULL,
  -- Lifecycle:
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_active DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  expires_at DATETIME NULL,
  INDEX idx_anonymous (anonymous_id),
  INDEX idx_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cleanup helper (Vorstand cron — already runs daily):
-- DELETE FROM wizard_drafts WHERE expires_at IS NOT NULL AND expires_at < NOW();
