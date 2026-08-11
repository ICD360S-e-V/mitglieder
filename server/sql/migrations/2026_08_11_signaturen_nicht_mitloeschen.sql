-- Migration: Unterschriften verschwinden nicht mehr, weil ein Konto gelöscht wird
--
-- WARUM
-- dokument_signaturen.user_id zeigt mit ON DELETE CASCADE auf users. Ein
-- `DELETE FROM users WHERE id = ?` — api/admin/user_delete.php tut genau das,
-- mit JWT und Vorsitzenden-Rolle, also ein ganz gewöhnlicher Handgriff — nimmt
-- damit sämtliche Unterschriften dieses Menschen mit.
--
-- Für Stammdaten ist Kaskadieren richtig. Für eine Beweissammlung ist es das
-- Gegenteil dessen, wofür sie da ist: die Unterschrift soll den Vorgang
-- überdauern, nicht mit ihm verschwinden. Und sie verschwindet lautlos —
-- niemand wird gefragt, nichts wird protokolliert.
--
-- Dazu kommt die Kette. Fällt ein Glied aus der Mitte heraus, zeigt das nächste
-- prev_hash auf einen full_hash, den es nicht mehr gibt. Seit
-- verkettungPruefen() wird das wenigstens SICHTBAR — vorher hätte jede Zeile
-- weiterhin „in Ordnung" gemeldet. Sichtbar ist aber nicht heil: die Lücke
-- bleibt, und ein Beweis mit Lücke ist angreifbar.
--
-- WAS SICH ÄNDERT
-- RESTRICT statt CASCADE: das Löschen eines Kontos mit Unterschriften scheitert
-- jetzt, statt die Unterschriften mitzunehmen. Der Vorsitzende muss sich dann
-- bewusst entscheiden — und api/admin/user_delete.php sagt ihm im Klartext,
-- woran es liegt, statt einen Datenbankfehler durchzureichen.
--
-- Der Weg für Löschbegehren nach DSGVO bleibt unberührt: dafür ist
-- api/cron/anonymize_expired_users.php zuständig, und das macht UPDATE, kein
-- DELETE (nachgesehen, Zeile 148). Diese Migration nimmt also nichts weg, was
-- gebraucht wird.
--
-- Bestandsdaten werden NICHT angefasst; nur die Regel für künftige Löschungen
-- ändert sich.
--
-- Safe to re-run.

-- Der Name des Fremdschlüssels ist der von MariaDB vergebene. Prüfen mit:
--   SELECT CONSTRAINT_NAME FROM information_schema.KEY_COLUMN_USAGE
--    WHERE TABLE_NAME='dokument_signaturen' AND REFERENCED_TABLE_NAME='users';
ALTER TABLE dokument_signaturen
  DROP FOREIGN KEY IF EXISTS dokument_signaturen_ibfk_1;

ALTER TABLE dokument_signaturen
  ADD CONSTRAINT dokument_signaturen_ibfk_1
      FOREIGN KEY (user_id) REFERENCES users (id)
      ON DELETE RESTRICT ON UPDATE CASCADE;

-- Kontrolle: muss RESTRICT sein.
SELECT r.DELETE_RULE
  FROM information_schema.REFERENTIAL_CONSTRAINTS r
 WHERE r.CONSTRAINT_SCHEMA = DATABASE()
   AND r.TABLE_NAME = 'dokument_signaturen'
   AND r.CONSTRAINT_NAME = 'dokument_signaturen_ibfk_1';
