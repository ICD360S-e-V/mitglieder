-- Migration: document_acceptances audit trail
-- One row per (user, document_kind) captured at Stufe 6/7/8 acceptance.
-- Mirrors the existing parent_consent_signatures evidence model
-- (Art. 7(1) DSGVO Beweislast + Art. 5(2) Rechenschaftspflicht).
--
-- Safe to re-run: uses IF NOT EXISTS.

CREATE TABLE IF NOT EXISTS document_acceptances (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  -- Which legal document the row stands for.
  document_kind ENUM('satzung', 'datenschutz', 'widerrufsbelehrung') NOT NULL,
  -- Administrative version stamp, bumped whenever the Vorstand
  -- publishes a new revision of that document. Format YYYY-MM-DD or
  -- semver — kept VARCHAR for flexibility.
  document_version VARCHAR(50) NOT NULL,
  -- URL the visitor was directed to read. The WizardDocumentAcceptScreen
  -- loaded this in an in-app WebView and required scroll-to-end before
  -- the accept checkbox was enabled.
  document_url VARCHAR(255) NOT NULL,
  -- SHA256 of the document content at the moment of acceptance.
  -- Lets us prove (or disprove) that a specific revision was shown
  -- even if the URL's content later changes.
  document_content_hash CHAR(64) NOT NULL,
  -- Acceptance timestamps. UTC for the canonical timeline; local for
  -- the visitor's reported wall-clock (informational).
  accepted_at_utc DATETIME NOT NULL,
  accepted_at_local VARCHAR(50) NULL,
  -- Network + device fingerprint at the acceptance moment. IPv4/v6
  -- both fit in 45 chars. Country lookup is best-effort (GeoIP).
  ip_address VARCHAR(45) NOT NULL,
  country_iso CHAR(2) NULL,
  user_agent VARCHAR(500) NULL,
  -- The visitor's anonymous_id at registration time + (once they
  -- become a member) the device_key. Lets us cross-reference the
  -- acceptance against the same device the wizard ran on.
  device_id VARCHAR(64) NULL,
  -- Did the visitor scroll all the way through the WebView before
  -- ticking the checkbox? Client-side flag captured by
  -- WizardDocumentAcceptScreen. Boolean for direct query.
  scrolled_to_end TINYINT(1) DEFAULT 0,
  -- Tamper-proofing: SHA256 over every column above (canonical
  -- representation) so any later mutation is detectable.
  full_hash CHAR(64) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  -- One acceptance per (user, document_kind). Re-acceptance of the
  -- same document overwrites the earlier row via ON DUPLICATE KEY
  -- UPDATE in save_step.php (e.g. visitor edits Stufe 6 after Vorstand
  -- rejection → row reflects the new acceptance).
  UNIQUE KEY uniq_user_doc (user_id, document_kind),
  INDEX idx_user (user_id),
  INDEX idx_doc_version (document_kind, document_version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
