-- Migration: remote_sessions — Fernwartung (RustDesk-style remote support) audit
--
-- The Vorsitzer/Vorstand may view and control a member's screen for support, but
-- ONLY after the member gives explicit per-session consent in their own app.
-- DSGVO/BGB rationale: remote access to a member's device is a serious intrusion,
-- so every session is logged with an immutable trail — who initiated, when the
-- member consented, when control started/ended, and why it ended. There is NO
-- unattended access: a row can only reach status='active' after 'consented'.
--
-- This is a SEPARATE feature from the RDP/Guacamole office remote desktop and
-- from voice calls. It has its own signaling frames (remote_*) and this table.
--
-- Safe to re-run: uses IF NOT EXISTS.

CREATE TABLE IF NOT EXISTS remote_sessions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  conversation_id INT NULL,                    -- WS room used for signaling (if any)
  controller_id INT NOT NULL,                  -- users.id of the Vorsitzer initiating
  member_id INT NOT NULL,                       -- users.id of the controlled member
  status ENUM('requested','consented','declined','active','ended') NOT NULL DEFAULT 'requested',
  control_allowed TINYINT(1) NOT NULL DEFAULT 0, -- 1 = full mouse/keyboard (desktop), 0 = view-only (mobile)
  requested_at DATETIME NOT NULL,               -- Vorsitzer pressed "Fernwartung"
  consent_at DATETIME NULL,                     -- member pressed "Erlauben"
  started_at DATETIME NULL,                     -- media/data channel connected
  ended_at DATETIME NULL,                       -- session torn down
  end_reason VARCHAR(64) NULL,                  -- member_stop|controller_end|disconnect|declined|timeout|error
  controller_ip VARCHAR(45) NULL,               -- REMOTE_ADDR of the initiator
  member_platform VARCHAR(32) NULL,             -- windows|macos|linux|android|ios
  full_hash CHAR(64) NULL,                      -- tamper-evidence over the row (optional)
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

  INDEX idx_controller (controller_id),
  INDEX idx_member (member_id),
  INDEX idx_status (status),
  INDEX idx_requested_at (requested_at),
  FOREIGN KEY (controller_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (member_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
