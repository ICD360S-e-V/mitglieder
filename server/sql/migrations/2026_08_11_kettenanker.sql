-- Migration: ein Anker, der nur wächst — damit das Abschneiden am Ende auffällt
--
-- WARUM
-- ketten_nr wurde bisher aus dem Bestand abgeleitet: die nächste Nummer war
-- MAX(ketten_nr) + 1. Das erkennt eine Lücke IN der Kette (verkettungPruefen
-- vergleicht rückwärts), aber nicht das Abschneiden am ENDE.
--
-- Vorgeführt: Kette 1..4 anlegen, Zeile mit ketten_nr = 4 löschen. Die
-- verbleibenden 1, 2, 3 melden weiterhin alle kette_intakt = true UND
-- verkettung_intakt = true — jede von ihnen ist ja unversehrt und hängt
-- ordentlich an ihrem Vorgänger. Die nächste Unterschrift bekommt dann erneut
-- ketten_nr = 4 und schliesst die Lücke, als hätte es Glied 4 nie gegeben.
--
-- Rückwärtsprüfen kann das prinzipiell nicht finden: was fehlt, hinterlässt
-- keinen Zeiger auf sich. Es braucht eine Stelle, die sich merkt, wie viele
-- Glieder JE vergeben wurden — und die nur wächst.
--
-- WAS SICH ÄNDERT
-- Eine Tabelle mit genau einer Zeile. Sie hält die zuletzt vergebene Nummer.
-- Beim Unterschreiben wird sie gesperrt und erhöht; die Nummer kommt von dort,
-- nicht mehr aus MAX(). Damit wird eine Nummer nie wieder vergeben, und
-- MAX(ketten_nr) < letzte_nr heisst: am Ende fehlt etwas.
--
-- Nebenwirkung, willkommen: das Sperren trifft jetzt EINE Zeile über den
-- Primärschlüssel statt einen Bereichsscan über die Beweistabelle. Die
-- Serialisierung bleibt (sie ist gewollt), aber sie fasst nichts mehr an, was
-- sie nichts angeht.
--
-- Der Anker wird auf den heutigen Stand gesetzt. Er beweist nichts über die
-- Vergangenheit — er kann nur ab jetzt bezeugen. Das ehrlich hinzuschreiben ist
-- besser, als einen Anker zu behaupten, den es damals nicht gab.
--
-- Safe to re-run.

CREATE TABLE IF NOT EXISTS signatur_kette_stand (
  id          TINYINT      NOT NULL PRIMARY KEY,
  letzte_nr   INT          NOT NULL DEFAULT 0
              COMMENT 'Hoechste je vergebene ketten_nr. Waechst nur.',
  aktualisiert_at DATETIME NULL,
  CONSTRAINT chk_eine_zeile CHECK (id = 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
  COMMENT='Anker der Unterschriften-Hashkette: eine Zeile, nur wachsend';

-- Auf den Bestand setzen. COALESCE, damit die Migration auch auf einer leeren
-- Anlage durchläuft.
INSERT INTO signatur_kette_stand (id, letzte_nr, aktualisiert_at)
SELECT 1, COALESCE(MAX(ketten_nr), 0), UTC_TIMESTAMP()
  FROM dokument_signaturen
ON DUPLICATE KEY UPDATE
  -- Beim erneuten Lauf NICHT zurücksetzen: der Anker darf nur wachsen, sonst
  -- wäre er als Anker wertlos.
  letzte_nr = GREATEST(signatur_kette_stand.letzte_nr, VALUES(letzte_nr));

-- Kontrolle: Anker und Bestand müssen jetzt übereinstimmen.
SELECT s.letzte_nr                       AS anker,
       COALESCE(MAX(d.ketten_nr), 0)     AS hoechste_vorhandene,
       COUNT(d.ketten_nr)                AS glieder,
       IF(s.letzte_nr = COALESCE(MAX(d.ketten_nr), 0), 'lueckenlos', 'ENDE FEHLT') AS befund
  FROM signatur_kette_stand s
  LEFT JOIN dokument_signaturen d ON d.ketten_nr IS NOT NULL
 WHERE s.id = 1;
