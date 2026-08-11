-- Migration: ein Dokument darf mehrere Unterzeichner haben
--
-- Gebraucht wird das AUSSCHLIESSLICH für die Vollmacht: das Mitglied erteilt
-- sie, der Verein nimmt sie an. Alle übrigen Dokumenttypen bleiben bei genau
-- einem Unterzeichner, dem Mitglied — heute sind das jobcenter_wba und
-- jobcenter_anlage_vm, und dabei bleibt es.
--
-- WARUM KEINE NEUE TABELLE
-- Jede Unterschrift ist schon heute eine eigene Zeile mit eigenem Beweis:
-- eigener TAN, eigene IP, eigenes Gerät, eigener Platz in der Hash-Kette.
-- Genau das war die Vorgabe („Ketten kalkulierbar und einzeln, nicht
-- dieselben"). Es fehlt nur die Angabe, welche Zeilen dasselbe PDF betreffen.
-- Eine Spalte leistet das; ein Umbau der Tabelle würde den häufigen Fall
-- anfassen, um den seltenen zu ermöglichen.
--
-- WAS SICH FÜR BESTEHENDE DATEN ÄNDERT: NICHTS.
-- Die sechs vorhandenen Unterschriften sind Jobcenter-Anträge, keine
-- Vollmachten. Sie bekommen kein gruppe_id und laufen weiter wie bisher.
-- Ihre full_hash-Werte werden nicht angefasst — sie stehen in gesiegelten
-- PDFs, deren Zeitstempel sonst nicht mehr passen würde.
--
-- Safe to re-run.

ALTER TABLE dokument_signaturen
  -- NULL = ein einzelner Unterzeichner, der Normalfall.
  -- Gesetzt = alle Zeilen mit demselben Wert gehören zu EINEM Dokument.
  -- Der Wert ist die id der zuerst angelegten Zeile der Gruppe; das erspart
  -- eine eigene Sequenz und macht die Herkunft im Zweifel nachvollziehbar.
  ADD COLUMN IF NOT EXISTS gruppe_id INT NULL
    COMMENT 'Zeilen mit gleichem Wert betreffen dasselbe PDF (nur Vollmacht). NULL = einzelner Unterzeichner',

  -- Wofür diese Person unterschreibt. Steht im Unterschriftenblatt, damit auf
  -- dem Papier erkennbar ist, wer in welcher Eigenschaft gezeichnet hat —
  -- „unterschrieben von zwei Leuten" allein sagt darüber nichts.
  ADD COLUMN IF NOT EXISTS rolle VARCHAR(40) NULL
    COMMENT 'z. B. vollmachtgeber, vollmachtnehmer. NULL beim einzelnen Unterzeichner';

-- Die Gruppe wird häufig als Ganzes gelesen (ist schon jeder fertig? hat
-- jemand abgelehnt?), deshalb ein Index darauf.
CREATE INDEX IF NOT EXISTS idx_gruppe ON dokument_signaturen (gruppe_id, status);

-- Kontrolle: es darf keine bestehende Zeile eine Gruppe bekommen haben.
-- Bleibt die Zahl bei 0, ist der Bestand unberührt.
SELECT COUNT(*) AS zeilen_mit_gruppe FROM dokument_signaturen WHERE gruppe_id IS NOT NULL;
