-- ─────────────────────────────────────────────────────────────────────────
-- Bug-report intake table — created once on the icd360sev DB.
-- Used by mitglieder/api/public/bug_report.php (writer) and the future
-- vorsitzer admin UI (reader / status updater).
--
-- Privacy notes:
--   • anonymous_id is the per-install random hex produced by
--     diagnostic_service.dart. It survives logout/login but resets on a
--     fresh install. Lets us correlate "the same device keeps reporting
--     bug X" without revealing membership.
--   • mitgliedernummer is NULL for reports submitted from the welcome
--     screen before login. When the user is logged in we keep it so the
--     Vorstand UI can follow up directly.
-- ─────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS bug_reports (
  id                INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  anonymous_id      VARCHAR(64)  NULL,
  mitgliedernummer  VARCHAR(20)  NULL,
  description       TEXT         NOT NULL,
  status            ENUM('new','in_progress','resolved','dismissed')
                    NOT NULL DEFAULT 'new',
  created_at        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  resolved_at       DATETIME     NULL,
  resolved_by       VARCHAR(20)  NULL,
  internal_notes    TEXT         NULL,
  INDEX idx_status_created (status, created_at),
  INDEX idx_anonymous      (anonymous_id),
  INDEX idx_mitglied       (mitgliedernummer)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;
