-- Migration: die Position in der Hash-Kette wird eine Angabe, keine Vermutung
--
-- WARUM
-- letzterKettenHash() suchte das vorherige Kettenglied mit
--   WHERE status='signiert' ORDER BY id DESC LIMIT 1
-- also über die id. Die id ist aber die Reihenfolge der ANFORDERUNG, nicht die
-- der UNTERSCHRIFT. Wer unterschreibt, entscheidet das Mitglied.
--
-- Bei zwei offenen Anfragen genügt das für eine Gabel:
--   Anfrage A (id 10) und B (id 20) sind offen.
--   B wird zuerst unterschrieben  -> B zeigt auf das letzte Glied.
--   A wird danach unterschrieben  -> höchste signierte id ist B -> A zeigt auf B.
--   C (id 30) wird angelegt und unterschrieben
--                                 -> höchste signierte id ist IMMER NOCH B
--                                 -> C zeigt ebenfalls auf B.
-- A und C hängen am selben Vorgänger. Die Kette ist keine Kette mehr, sondern
-- ein Baum, und ein Glied lässt sich entfernen, ohne dass etwas auffällt:
-- jede Zeile rechnet in kette_intakt nur ihren EIGENEN Hash nach.
--
-- Die sechs echten Unterschriften sind davon nicht betroffen. Geprüft: bei
-- ihnen stimmt die id-Reihenfolge mit der Unterschriftsreihenfolge überein,
-- weil nie mehr als eine Anfrage gleichzeitig offen war. Das war Glück, keine
-- Zusicherung — und mit zwei Unterzeichnern je Dokument (Mitglied heute,
-- Vorsitzender morgen) fällt dieses Glück weg.
--
-- Auch die Uhrzeit trägt nicht: signed_at_utc ist DATETIME, also sekundengenau.
-- Zwei Unterschriften in derselben Sekunde wären wieder nicht unterscheidbar.
-- Deshalb eine eigene, lückenlos fortlaufende Nummer.
--
-- WAS SICH FÜR BESTEHENDE DATEN ÄNDERT
-- Nur diese neue Spalte wird gefüllt. prev_hash und full_hash werden NICHT
-- angefasst — sie stehen in gesiegelten PDFs mit RFC-3161-Zeitstempel.
-- Die Nachnummerierung läuft nach id, und genau das entspricht bei diesen
-- sechs Zeilen der Reihenfolge, in der ihre prev_hash-Werte vergeben wurden.
-- Die Nummer beschreibt den Bestand also, sie verändert ihn nicht.
--
-- Safe to re-run.

ALTER TABLE dokument_signaturen
  ADD COLUMN IF NOT EXISTS ketten_nr INT NULL
    COMMENT 'Lückenlose Position in der Hash-Kette, vergeben beim Unterschreiben. NULL = noch nicht unterschrieben';

-- UNIQUE: zwei Zeilen mit derselben Position wären genau die Gabel, die diese
-- Migration beseitigt. Lieber ein harter Fehler beim Schreiben als eine stille
-- Verzweigung in einer Beweiskette.
CREATE UNIQUE INDEX IF NOT EXISTS idx_ketten_nr ON dokument_signaturen (ketten_nr);

-- Bestand nachnummerieren (1, 2, 3, … in id-Reihenfolge).
SET @n := 0;
UPDATE dokument_signaturen
   SET ketten_nr = (@n := @n + 1)
 WHERE status = 'signiert' AND full_hash IS NOT NULL AND ketten_nr IS NULL
 ORDER BY id;

-- Kontrolle: lückenlos von 1 bis zur Anzahl, keine Zeile doppelt.
SELECT COUNT(*)            AS glieder,
       MIN(ketten_nr)      AS erste,
       MAX(ketten_nr)      AS letzte,
       COUNT(DISTINCT ketten_nr) AS verschiedene
  FROM dokument_signaturen
 WHERE ketten_nr IS NOT NULL;
