-- Migration: verifizierung_approvals — per-Stufe dual approval audit
--
-- Implements §28 BGB Vorstandsbeschluss + Satzung §6 Abs. 2 ("Entscheidung
-- durch Vorstand") in its strictest form: each Stufe of every Mitgliedsantrag
-- requires APPROVAL FROM TWO DISTINCT VORSTAND MEMBERS before it counts as
-- finally `geprueft`. A single `abgelehnt` vote (from any Vorstand member)
-- immediately blocks that Stufe — the applicant must correct + the cycle
-- restarts.
--
-- Rationale: Vorstand has 3 members per Satzung §8 — 2 of 3 is both the
-- BGB-default simple majority AND the strict 2/3 supermajority. Implementing
-- "2 distinct approvers required" is the bright-line way to enforce it
-- without ambiguity.
--
-- Safe to re-run: uses IF NOT EXISTS.

CREATE TABLE IF NOT EXISTS verifizierung_approvals (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,                       -- applicant
  stufe TINYINT NOT NULL,                     -- 1..8
  approved_by INT NOT NULL,                   -- Vorstand member's user.id
  decision ENUM('geprueft', 'abgelehnt') NOT NULL,
  approved_at DATETIME NOT NULL,
  approved_at_local VARCHAR(50) NULL,         -- TZ-aware client wall clock
  ip_address VARCHAR(45) NULL,                -- REMOTE_ADDR of the reviewer
  user_agent VARCHAR(500) NULL,
  notiz TEXT NULL,                            -- per-vote optional comment
  full_hash CHAR(64) NOT NULL,                -- tamper-evidence over all cols
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

  -- A single Vorstand member can only cast ONE vote per (user, stufe).
  -- Forces the second Geprüft-vote to come from a different person —
  -- which is the whole point of the dual-approval rule.
  UNIQUE KEY uniq_user_stufe_approver (user_id, stufe, approved_by),

  INDEX idx_user_stufe (user_id, stufe),
  INDEX idx_approved_by (approved_by),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (approved_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
