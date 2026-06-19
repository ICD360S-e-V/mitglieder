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
  -- ws_broadcast: flipped from 0 → 1 by the WebSocket server's
  -- checkPendingBugReports() polling loop (server.php, 5s interval)
  -- after it has pushed a 'bug_report_new' frame to every connected
  -- Vorstand client. Stays 0 until that broadcast actually happens, so
  -- reports made while the WS service was down still go out when it
  -- comes back up.
  ws_broadcast      TINYINT(1)   NOT NULL DEFAULT 0,
  created_at        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  resolved_at       DATETIME     NULL,
  resolved_by       VARCHAR(20)  NULL,
  internal_notes    TEXT         NULL,
  INDEX idx_status_created (status, created_at),
  INDEX idx_anonymous      (anonymous_id),
  INDEX idx_mitglied       (mitgliedernummer),
  INDEX idx_ws_broadcast   (ws_broadcast)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- Migration safety: if the table existed before ws_broadcast was added,
-- this brings it up to date. ALGORITHM=INSTANT keeps it free on modern
-- MariaDB / MySQL 8+.
ALTER TABLE bug_reports
  ADD COLUMN IF NOT EXISTS ws_broadcast TINYINT(1) NOT NULL DEFAULT 0
  AFTER status,
  ADD INDEX IF NOT EXISTS idx_ws_broadcast (ws_broadcast);
