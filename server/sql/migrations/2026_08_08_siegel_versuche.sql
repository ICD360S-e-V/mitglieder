-- Migration: Siegel-Versuche begrenzen und den Grund festhalten
--
-- Anlass: das erste echte Dokument (Jobcenter-WBA, PDF 1.7 mit Objekt-Streams)
-- liess sich vom freien FPDI-Parser nicht oeffnen. Der Cron hat es daraufhin
-- JEDE MINUTE erneut versucht — dieselbe Datei, derselbe Fehler, unbegrenzt.
-- Fuer das Mitglied stand dabei durchgehend „das Siegel wird noch erstellt",
-- also eine Zusage, die nie eingeloest werden konnte.
--
-- Zwei Spalten reichen: zaehlen, wie oft es schon versucht wurde, und den
-- Grund aufheben. Nach einer Obergrenze wird nicht mehr versucht, und der
-- Vorsitzende sieht im Beweisbuendel, woran es liegt.
--
-- MariaDB 10.11 kann ADD COLUMN IF NOT EXISTS — dadurch ist die Migration
-- wiederholbar.

ALTER TABLE dokument_signaturen
  ADD COLUMN IF NOT EXISTS siegel_versuche TINYINT NOT NULL DEFAULT 0
    COMMENT 'Wie oft das Siegeln schon gescheitert ist',
  ADD COLUMN IF NOT EXISTS siegel_fehler VARCHAR(255) NULL
    COMMENT 'Warum es zuletzt gescheitert ist (fuer den Vorsitzenden sichtbar)';

-- Der laufende Fall soll nach dem Deploy sofort erneut drankommen, egal wie
-- oft er vorher gescheitert ist.
UPDATE dokument_signaturen
   SET siegel_versuche = 0, siegel_fehler = NULL
 WHERE status = 'signiert' AND signiert_pdf_pfad IS NULL;
