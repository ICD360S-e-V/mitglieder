-- Migration: tls_failures table
-- Purpose: Record TLS handshake failures and other systemic network errors
--          reported by clients, to detect MITM attempts and identify hostile
--          networks (corporate proxies, mobile AV products, captive portals).
--
-- Threat model: client-side certificate pinning rejects rogue CAs; this table
-- aggregates the rejections so we can see which AVs / issuers / networks are
-- intercepting our users.
--
-- GDPR basis: legitimate interest (Art. 6(1)(f) GDPR, Recital 49 — security
-- of network and information systems). Retention: 90 days, enforced by cron.

CREATE TABLE IF NOT EXISTS tls_failures (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,

  device_id VARCHAR(64) NOT NULL,
  mitgliedernummer VARCHAR(20) NULL,

  reported_at DATETIME NOT NULL,
  failed_at DATETIME NOT NULL,
  first_seen DATETIME NOT NULL,
  last_seen DATETIME NOT NULL,
  occurrence_count INT NOT NULL DEFAULT 1,

  app_version VARCHAR(20),
  platform VARCHAR(20),
  os_version VARCHAR(50),
  user_agent VARCHAR(255),

  host VARCHAR(255) NOT NULL,
  error_category VARCHAR(32),
  error_message TEXT,

  presented_subject VARCHAR(255),
  presented_issuer VARCHAR(255),
  presented_fingerprint VARCHAR(64),

  network_type VARCHAR(16),
  network_ssid VARCHAR(64),
  network_bssid VARCHAR(32),
  network_ssid_denied TINYINT(1) NOT NULL DEFAULT 0,

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  INDEX idx_member_time (mitgliedernummer, reported_at),
  INDEX idx_device_time (device_id, reported_at),
  INDEX idx_issuer (presented_issuer),
  INDEX idx_category_time (error_category, reported_at),
  INDEX idx_failed_at (failed_at),
  INDEX idx_ssid (network_ssid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
