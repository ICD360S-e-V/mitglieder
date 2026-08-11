-- Migration: erst siegeln, wenn das Beweisbündel vollständig ist
--
-- WARUM
-- Beim Unterschreiben wird die Zeile in einer Transaktion geschlossen. Danach,
-- BEWUSST ausserhalb, werden noch drei Dinge nachgetragen: Reverse-DNS, Land
-- und Netzbetreiber sowie die App-Fassung. Ausserhalb deshalb, weil der
-- DNS-Lookup in eine Zeitüberschreitung laufen kann — und daran darf eine
-- gültige Unterschrift nicht scheitern. Die Begründung ist richtig.
--
-- Der Siegel-Cron läuft aber JEDE MINUTE und nimmt jede Zeile mit
-- status='signiert', ohne Wartezeit. Er kann also genau in dieses Fenster
-- greifen. Dann steht auf dem gesiegelten Blatt „Hostname (Reverse-DNS): —",
-- während die Datenbank kurz darauf einen Wert bekommt.
--
-- Das ist schlimmer als eine fehlende Angabe: das PDF ist mit RFC-3161
-- zeitgestempelt und damit die Verankerung. Wenn Bündel und Urkunde
-- auseinanderlaufen, ist genau das der Ansatzpunkt, an dem jemand die ganze
-- Sammlung in Zweifel zieht — und er hätte recht.
--
-- WAS SICH ÄNDERT
-- Eine Marke, die der Unterschriftsvorgang setzt, wenn er mit dem Nachtragen
-- fertig ist. Gesiegelt wird erst danach. Kein pauschales Warten: sobald die
-- Zeile vollständig ist, geht es weiter — meist Millisekunden später.
--
-- Der Bestand wird auf 1 gesetzt: diese sechs sind längst gesiegelt, ihr
-- Bündel ist so vollständig, wie es je sein wird.
--
-- Safe to re-run.

ALTER TABLE dokument_signaturen
  ADD COLUMN IF NOT EXISTS beweis_vollstaendig TINYINT(1) NOT NULL DEFAULT 0
    COMMENT 'Nachgetragene Felder (Reverse-DNS, Land, Netz, App-Fassung) stehen; erst dann darf gesiegelt werden';

-- Der Cron sucht über status + diese Marke.
CREATE INDEX IF NOT EXISTS idx_siegelbereit
  ON dokument_signaturen (status, beweis_vollstaendig);

UPDATE dokument_signaturen
   SET beweis_vollstaendig = 1
 WHERE status = 'signiert' AND beweis_vollstaendig = 0;

SELECT COUNT(*) AS signiert,
       SUM(beweis_vollstaendig) AS vollstaendig
  FROM dokument_signaturen WHERE status = 'signiert';
