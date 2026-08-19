-- Migration: Vollmacht per SMS-Link — lesen und unterschreiben
--
-- Fuer Mitglieder OHNE App. Gemessen am 18.08.2026: von 44 aktiven
-- Mitgliedern haben 20 die App, 24 eine Mobilnummer — und 12 haben eine
-- Nummer, aber keine App. Genau die koennen heute gar nichts unterschreiben.
--
-- ZWEI Links, nacheinander, nicht einer mit zwei Adressen:
--
--   1. zweck='lesen'      → Leseexemplar in der Sprache des Mitglieds.
--                           Wird NICHT unterschrieben. Es darf heruntergeladen
--                           werden, und genau das wird protokolliert.
--   2. zweck='signieren'  → die deutsche Fassung, die rechtlich bindet.
--                           Unterschrift mit dem Finger + Code per SMS.
--
-- Der zweite Link geht ERST, wenn der Vorstand ihn schickt — nachdem das
-- Mitglied bestaetigt hat. Automatisch waere er in derselben Sekunde da, in
-- der jemand auf „herunterladen" tippt, also bevor er etwas lesen konnte.
--
-- ⚠️ Die Gueltigkeit betraegt 30 MINUTEN (Entscheidung des Vorsitzenden,
-- 18.08.2026). Das ist kurz — bei der Kontakt-Erinnerung ist uns genau diese
-- Frist einmal um die Ohren geflogen, weil eine Mail abends gelesen wird und
-- der Code dann tot war. Hier ist es etwas anderes: der Vorstand schickt den
-- Link im Gespraech. Damit trotzdem niemand strandet, bietet die abgelaufene
-- Seite an, einen neuen Link an DIESELBE Nummer zu schicken.
--
-- ⚠️ KEINE zweite Beweisklasse: unterschrieben wird weiterhin ueber
-- dokument_signaturen, mit derselben Hash-Kette und demselben Siegel. Diese
-- Tabelle traegt nur den WEG dorthin.
--
-- ⚠️ Der Code geht per SMS an dieselbe Nummer, auf der auch der Link ankam
-- (Entscheidung des Vorsitzenden, 18.08.2026). Damit ist er kein zweiter
-- Kanal mehr — anders als in der App, wo auf dem Geraet unterschrieben und
-- auf dem Telefon bestaetigt wird. Deshalb steht der Weg in `zugang_weg` der
-- Signaturzeile: ein Nachweis darf nicht mehr behaupten, als er hat.
--
-- Safe to re-run: uses IF NOT EXISTS.

CREATE TABLE IF NOT EXISTS vollmacht_link (
  id INT AUTO_INCREMENT PRIMARY KEY,

  -- Polymorph wie dokument_signaturen.quelle_tabelle: derselbe Weg dient
  -- beiden Vollmacht-Arten, ohne die Tabelle zweimal zu bauen.
  --   'member_vollmachten'    → Gericht und Insolvenzverwaltung
  --   'vertrag_ra_vollmacht'  → Kanzlei im Inkasso-Zweig
  quelle_tabelle VARCHAR(60) NOT NULL,
  quelle_id INT NOT NULL,
  -- Wem das Blatt gehoert. Nicht aus dem Link ableitbar und deshalb hier:
  -- die Rufnummer fuer den Code wird SPAETER ueber diese Spalte aus
  -- Verifizierung Stufe 1 geholt, nie aus der Seite.
  user_id INT NOT NULL,

  zweck ENUM('lesen','signieren') NOT NULL,
  fassung ENUM('original','uebersetzung') NOT NULL,
  sprache VARCHAR(8) NULL,

  -- ⚠️ Nur der Hash. Wer die Datenbank liest, darf den Link nicht oeffnen
  -- koennen — dieselbe Regel wie bei signatur_tan.tan_hash.
  token_hash CHAR(64) NOT NULL,
  gueltig_bis DATETIME NOT NULL,

  -- ── Hinausgegangen ──────────────────────────────────────────────
  gesendet_an VARCHAR(32) NOT NULL,
  -- Der Mensch aus dem Vorstand, der ihn geschickt hat. Hier steht ein
  -- echter Absender, anders als bei einem Abruf — deshalb bekommt der Abruf
  -- auch keine Zeile in vollmacht_versand, wo diese Spalte NOT NULL ist und
  -- „durch <Name>" hiesse: er hat es verschickt.
  gesendet_von INT NOT NULL,
  gesendet_am DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  -- ── Was das Mitglied getan hat ──────────────────────────────────
  --
  -- ⚠️ `geoeffnet_am` heisst NICHT „gelesen". Jemand hat auf den Link
  -- getippt, mehr sagt es nicht. Im Protokoll steht deshalb „geoeffnet",
  -- nicht „zur Kenntnis genommen".
  geoeffnet_am DATETIME NULL,
  -- Nur der ERSTE Download. Der fuenfte Tastendruck ist keine neue
  -- Information und wuerde die Zeile ersaeufen.
  geladen_am DATETIME NULL,
  -- Nur bei zweck='lesen': „ich habe es gelesen". Keine Schranke — wer
  -- stattdessen anruft, ist genauso bestaetigt; der Vorstand schickt den
  -- zweiten Link ohnehin von Hand.
  bestaetigt_am DATETIME NULL,
  -- Nur bei zweck='signieren': hier ist die Unterschrift gefallen.
  erledigt_am DATETIME NULL,
  signatur_id INT NULL,

  -- Wie oft ueber DIESEN Link ein Code angefordert wurde. Jeder, der den
  -- Link hat, kann eine SMS ausloesen; drei ist die Obergrenze.
  codes_gesendet TINYINT NOT NULL DEFAULT 0,

  -- Abdruck beim ersten Oeffnen. Nicht mehr als das, was auch die
  -- Signaturzeile traegt.
  ip_address VARCHAR(45) NULL,
  user_agent VARCHAR(500) NULL,

  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY uniq_token (token_hash),
  INDEX idx_quelle (quelle_tabelle, quelle_id),
  INDEX idx_gueltig (gueltig_bis, zweck)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Die Link-SMS geht ueber DIESELBE Warteschlange wie die TAN.
--
-- ⚠️ Und zwar deshalb, weil das Tablet aus jeder Zeile nur `id`, `telefon`
-- und `body` liest (geprueft in termin_sms_gateway_service.dart) — eine
-- eigene vierte Warteschlange haette einen Release der Vorsitzer-App
-- gebraucht, und bis dahin haette kein Mitglied je einen Link bekommen.
--
-- ⚠️ tan_id wird nullable, ABER die Regel bleibt hart: genau eines von
-- beiden ist gesetzt. Ohne die Pruefung waere eine Zeile ohne beides
-- moeglich — eine SMS, die zu nichts gehoert und die niemand mehr zuordnen
-- kann.
ALTER TABLE signatur_sms_queue
  MODIFY COLUMN tan_id INT NULL;

ALTER TABLE signatur_sms_queue
  ADD COLUMN IF NOT EXISTS link_id INT NULL AFTER tan_id;

ALTER TABLE signatur_sms_queue
  ADD CONSTRAINT chk_queue_genau_eine_quelle
  CHECK ((tan_id IS NULL) <> (link_id IS NULL));

ALTER TABLE signatur_sms_queue
  ADD CONSTRAINT fk_queue_link
  FOREIGN KEY (link_id) REFERENCES vollmacht_link(id) ON DELETE CASCADE;


-- Woher die Unterschrift kam.
--
-- ⚠️ Der entscheidende Unterschied: in der App unterschreibt das Mitglied auf
-- dem einen Geraet und bestaetigt mit einem Code auf dem Telefon — zwei
-- Kanaele. Ueber den SMS-Link kommen Link UND Code auf demselben Telefon an.
-- Das ist die Entscheidung des Vorsitzenden vom 18.08.2026 und voellig in
-- Ordnung; es darf nur spaeter niemand aus der Beweiszeile herauslesen, es
-- seien zwei Kanaele gewesen. Deshalb steht es hier und nicht im Kommentar.
ALTER TABLE dokument_signaturen
  ADD COLUMN IF NOT EXISTS zugang_weg ENUM('app','sms_link') NOT NULL DEFAULT 'app'
  AFTER device_hostname;
