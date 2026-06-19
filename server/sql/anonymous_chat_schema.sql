-- ─────────────────────────────────────────────────────────────────────────
-- Anonymous chat infrastructure — adds the bits the WebSocket pipeline
-- needs so a visitor who hasn't joined yet can talk to a Vorstand member
-- through the same chat surface as a regular Mitglied.
--
-- The design treats an anonymous visitor as a real row in `users` with
-- is_anonymous = 1, so every existing chat helper (auth, conversation
-- lookup, translator, read receipts, 5-minute TTL on read messages) keeps
-- working without a parallel code path. The only specialisation is in the
-- Vorsitzer UI: it has to render "Anonim #XXXX" + the metadata badge
-- instead of the real name when is_anonymous is set.
-- ─────────────────────────────────────────────────────────────────────────

-- Step 1: extend the role enum with 'anonymous' so the INSERT in
-- /api/public/anonymous_chat/init.php doesn't trip the constraint.
ALTER TABLE users
  MODIFY COLUMN role ENUM(
    'mitglied','vorsitzer','stellvertreter','schatzmeister','schriftfuehrer',
    'beisitzer','kassierer','kassenprufer','ehrenamtlich','mitgliedergrunder',
    'ehrenmitglied','foerdermitglied','jugendmitglied','anonymous'
  ) DEFAULT 'mitglied';

-- Step 2: flag column. Plain TINYINT(1) so server-side filters
-- (WHERE is_anonymous = 1) stay cheap and the column slots cleanly
-- between role and the existing fields.
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS is_anonymous TINYINT(1) NOT NULL DEFAULT 0 AFTER role,
  ADD INDEX IF NOT EXISTS idx_is_anonymous (is_anonymous);

-- Step 3: metadata table. The anonymous_id (32-hex random produced
-- client-side and persisted in SharedPreferences) is the join key —
-- if the same device comes back, we hand them the same ghost user row
-- so conversation history is preserved across sessions.
CREATE TABLE IF NOT EXISTS anonymous_chat_users (
  user_id        INT          NOT NULL PRIMARY KEY,
  anonymous_id   VARCHAR(64)  NOT NULL UNIQUE,
  language       VARCHAR(8)   NULL,
  platform       VARCHAR(50)  NULL,
  app_version    VARCHAR(20)  NULL,
  first_open_at  DATETIME     NULL,
  created_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_active    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_anonymous_id (anonymous_id),
  INDEX idx_last_active  (last_active)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;
