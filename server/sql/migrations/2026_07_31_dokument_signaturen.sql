-- Migration: digitale Unterschrift (Mitglied unterschreibt mit dem Finger)
--
-- Der Vorsitzer fordert aus der Mitgliederverwaltung heraus eine Unterschrift
-- an, das Mitglied unterschreibt in der App auf dem Bildschirm und bestätigt
-- mit einer TAN, die per SMS über die SIM des Vereins-Tablets rausgeht.
--
-- Beweismodell wie bei `parent_consent_signatures` und `document_acceptances`:
-- der Nachweis liegt in der Kette aus Dokument-Hash, Identität und Zeitpunkt,
-- nicht in der Zeichnung. Die gemalte Linie allein beweist nichts.
--
-- Art. 26 eIDAS (fortgeschrittene elektronische Signatur) verlangt vier Dinge.
-- Wo sie hier herkommen:
--   1. eindeutig dem Unterzeichner zugeordnet  → device_id (device_key)
--   2. Identifizierung des Unterzeichners      → Verifizierung Stufe 1, der
--      Vorsitzer hat den Ausweis in der Hand gehabt
--   3. alleinige Kontrolle                     → TAN auf das in Stufe 1
--      hinterlegte Mobiltelefon, zweiter Kanal
--   4. nachträgliche Änderung erkennbar        → pdf_hash + Hash-Kette
--      (prev_hash/full_hash) + PAdES-Siegel + RFC-3161-Zeitstempel
--
-- KEINE Druck- und Geschwindigkeitsdaten des Striches. Die wären biometrisch
-- (Art. 9 DSGVO) und würden die ganze Tabelle in eine andere Rechtsklasse
-- heben. Gespeichert wird nur der fertige SVG-Pfad.
--
-- Safe to re-run: uses IF NOT EXISTS.

CREATE TABLE IF NOT EXISTS dokument_signaturen (
  id INT AUTO_INCREMENT PRIMARY KEY,

  -- Wer unterschreiben soll und wer es angefordert hat.
  user_id INT NOT NULL,
  angefordert_von INT NOT NULL,
  angefordert_at DATETIME NOT NULL,

  -- Was unterschrieben wird. `dokument_typ` bleibt bewusst VARCHAR statt ENUM:
  -- welche Dokumente zuerst über den Weg gehen, ist noch nicht entschieden,
  -- und ein ENUM zu erweitern heißt ALTER TABLE auf einer Tabelle, die dann
  -- schon Beweise trägt.
  dokument_typ VARCHAR(60) NOT NULL,
  dokument_titel VARCHAR(255) NOT NULL,
  -- Optionaler Rückverweis auf den Datensatz, aus dem das PDF stammt
  -- (z. B. mitwirkungserklaerung.id), damit die Unterschrift dort auftaucht.
  quelle_tabelle VARCHAR(60) NULL,
  quelle_id INT NULL,

  -- Das unsignierte PDF, genau so wie es dem Mitglied gezeigt wurde.
  pdf_pfad VARCHAR(255) NOT NULL,
  -- SHA256 exakt dieser Bytes. Ändert jemand das PDF später, passt der Hash
  -- nicht mehr — das ist die Verbindung zwischen Unterschrift und Inhalt.
  pdf_hash CHAR(64) NOT NULL,
  -- Seitenzahl, damit die App weiß, ob wirklich bis zum Ende gescrollt wurde.
  pdf_seiten SMALLINT NULL,

  status ENUM('offen','signiert','abgelehnt','abgelaufen','widerrufen')
    NOT NULL DEFAULT 'offen',
  frist_bis DATETIME NULL,

  -- ===== ab hier erst beim Unterschreiben gefüllt =====

  -- Der gemalte Pfad. SVG statt PNG: skaliert verlustfrei in jedes PDF und
  -- ist ein Bruchteil so groß.
  signature_svg LONGTEXT NULL,

  -- Zeitpunkt. UTC ist die verbindliche Zeitachse, local nur das, was die
  -- Uhr des Geräts behauptet hat (informativ, kann falsch gestellt sein).
  signed_at_utc DATETIME NULL,
  signed_at_local VARCHAR(50) NULL,

  -- Netz- und Geräteabdruck im Moment der Unterschrift.
  ip_address VARCHAR(45) NULL,
  -- Reverse-DNS zur IP (z. B. p5b0a1234.dip0.t-ipconnect.de). Best effort:
  -- viele Anschlüsse haben keinen PTR, dann bleibt die Spalte leer.
  reverse_dns VARCHAR(255) NULL,
  isp VARCHAR(100) NULL,
  country_iso CHAR(2) NULL,
  user_agent VARCHAR(500) NULL,
  -- Der device_key des Geräts — die Zuordnung aus Art. 26 Nr. 1.
  device_id VARCHAR(64) NULL,
  -- Menschenlesbarer Gerätename ("Galaxy Tab A11"), damit im Audit nicht nur
  -- ein Hash steht.
  device_hostname VARCHAR(120) NULL,

  -- ===== TAN (zweiter Kanal) =====
  -- Nur SMS. Bewusst kein E-Mail-Rückfallweg: eine TAN, die auf demselben
  -- Gerät ankommt, auf dem unterschrieben wird, ist kein zweiter Faktor.
  tan_an VARCHAR(32) NULL,           -- maskiert, z. B. +4917•••••4567
  tan_verified_at DATETIME NULL,

  -- ===== Siegel =====
  signiert_pdf_pfad VARCHAR(255) NULL,
  signiert_pdf_hash CHAR(64) NULL,
  -- RFC-3161-Token der TSA. Beweist, dass das Dokument zu diesem Zeitpunkt
  -- schon so existierte — unabhängig von unserer eigenen Uhr.
  tsa_token_pfad VARCHAR(255) NULL,

  -- ===== Hash-Kette =====
  -- full_hash = sha256(alle Beweisfelder || prev_hash). Wer eine Zeile
  -- nachträglich ändert, müsste alle folgenden neu rechnen — eine stille
  -- Manipulation in der Datenbank fällt damit auf.
  prev_hash CHAR(64) NULL,
  full_hash CHAR(64) NULL,

  -- Öffentlicher Prüf-Code für /verify/<code>. Zufällig, damit er nichts
  -- über das Mitglied verrät und nicht durchprobiert werden kann.
  verify_code CHAR(32) NULL,

  abgelehnt_at DATETIME NULL,
  abgelehnt_grund TEXT NULL,
  widerrufen_at DATETIME NULL,
  widerrufen_grund TEXT NULL,

  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_status (user_id, status),
  INDEX idx_status_frist (status, frist_bis),
  UNIQUE KEY uniq_verify_code (verify_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- TANs. Getrennte Tabelle, weil eine Anforderung mehrere Versuche haben darf
-- (SMS kommt nicht an, Tippfehler) und jeder Versuch nachvollziehbar bleiben
-- soll, ohne die Beweiszeile zu überschreiben.
CREATE TABLE IF NOT EXISTS signatur_tan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  signatur_id INT NOT NULL,
  -- Nur der Hash. Wer die Datenbank liest, darf nicht mitunterschreiben
  -- können. Gesalzen mit der signatur_id, damit gleiche TANs verschiedener
  -- Vorgänge verschiedene Hashes haben.
  tan_hash CHAR(64) NOT NULL,
  telefon VARCHAR(32) NOT NULL,
  gueltig_bis DATETIME NOT NULL,
  versuche TINYINT NOT NULL DEFAULT 0,
  verbraucht_at DATETIME NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (signatur_id) REFERENCES dokument_signaturen(id) ON DELETE CASCADE,
  INDEX idx_signatur (signatur_id, verbraucht_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Warteschlange für die TAN-SMS.
--
-- Der Server hat kein Modem — jede SMS verlässt das Haus über die SIM des
-- Vereins-Tablets. Gleiche Bauart wie chat_sms_outbox (claim/report), damit
-- das bestehende Gateway sie mit abarbeiten kann.
--
-- Der Unterschied zu den anderen Warteschlangen: hier zählt jede Sekunde.
-- Das Tablet pollt alle 30 Minuten; eine TAN gilt fünf und wäre bis dahin
-- längst tot. Deshalb weckt der Server nach dem Einreihen per ntfy.
CREATE TABLE IF NOT EXISTS signatur_sms_queue (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tan_id INT NOT NULL,
  signatur_id INT NOT NULL,
  telefon VARCHAR(32) NOT NULL,
  -- Der fertige Text inkl. TAN. Steht hier im Klartext, weil die SMS ihn
  -- ohnehin im Klartext trägt; die Zeile wird nach dem Versand gelöscht.
  body VARCHAR(320) NOT NULL,
  status ENUM('offen','claimed','gesendet','fehler') NOT NULL DEFAULT 'offen',
  claimed_by VARCHAR(64) NULL,
  claimed_at DATETIME NULL,
  gesendet_at DATETIME NULL,
  segments TINYINT NULL,
  fehler VARCHAR(255) NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (tan_id) REFERENCES signatur_tan(id) ON DELETE CASCADE,
  INDEX idx_offen (status, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
