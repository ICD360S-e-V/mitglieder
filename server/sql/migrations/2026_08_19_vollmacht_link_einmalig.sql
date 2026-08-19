-- Ein Link gilt EINMAL. Entscheidung des Vorsitzenden, 19.08.2026.
--
-- Bisher galt er 30 Minuten und beliebig oft. Wer die SMS weiterleitet, gibt
-- damit auch die Vollmacht weiter — und beim Signier-Link die Moeglichkeit,
-- im Namen des Mitglieds zu unterschreiben.
--
-- „Einmal" heisst: an das ERSTE Geraet gebunden, das ihn oeffnet. Nicht „nach
-- dem ersten Aufruf tot": eine Seite besteht aus vielen Anfragen — das HTML,
-- ein Bild je Seite, der Download, die Handgriffe. Wer nach dem ersten
-- Aufruf schliesst, hat nichts als eine halbe Seite.
--
-- ⚠️ Wer zuerst klickt, gewinnt. Leitet jemand die SMS weiter und der andere
-- ist schneller, hat der andere den Link. Das laesst sich nicht aufloesen —
-- die SMS ist der Zugang. Aber der Zweite kommt nicht mehr hinein, und der
-- Vorstand erfaehrt davon.

ALTER TABLE vollmacht_link
  ADD COLUMN IF NOT EXISTS sitzung_hash CHAR(64) NULL AFTER token_hash,
  -- Wann und von wo aus gebunden wurde. Steht im Protokoll und beantwortet
  -- die Frage, die im Streitfall kommt: wer hat das Blatt geoeffnet.
  ADD COLUMN IF NOT EXISTS gebunden_am DATETIME NULL AFTER sitzung_hash,
  ADD COLUMN IF NOT EXISTS gebunden_ip VARCHAR(45) NULL AFTER gebunden_am,
  ADD COLUMN IF NOT EXISTS gebunden_ua VARCHAR(500) NULL AFTER gebunden_ip,
  -- Wie oft jemand OHNE die richtige Sitzung angeklopft hat. Eine Zahl ueber
  -- null heisst: der Link war unterwegs, wo er nicht hingehoerte.
  ADD COLUMN IF NOT EXISTS fremdzugriffe SMALLINT NOT NULL DEFAULT 0 AFTER gebunden_ua;
