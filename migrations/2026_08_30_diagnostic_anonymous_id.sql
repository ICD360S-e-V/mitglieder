-- Migration: Spalte `mitgliedernummer` in den Diagnosetabellen verbreitern
--
-- Grund: Der Client sendet seit der Anonymisierung des Diagnosedienstes keine
-- Mitgliedsnummer mehr, sondern eine `anonymous_id` — 32 Hex-Zeichen, einmal je
-- Installation gewürfelt. `diagnostic/log.php` kannte das Feld nicht und legte
-- deshalb JEDE Meldung unter "unknown" ab. Ergebnis: über 60.000 Zeilen
-- battery_logs, in denen sich kein Gerät mehr von einem anderen unterscheiden
-- liess — und damit keine Entladerate mehr berechenbar, weil dafür Messpunkte
-- EINES Geräts in Reihenfolge nötig sind.
--
-- Die Spalte ist VARCHAR(20). Eine 32-stellige Kennung passt dort nicht hinein
-- und würde abgeschnitten (oder im strikten Modus abgelehnt) — der Fix in
-- log.php allein reicht also nicht.
--
-- Der Spaltenname bleibt `mitgliedernummer`, obwohl er den Inhalt nicht mehr
-- trifft. Umbenennen hiesse jeden Leser mit anzufassen (api/admin/
-- user_details.php und was sonst noch danach greift); der Gewinn wiegt das
-- Risiko nicht auf. Was drinsteht, ist ab jetzt eines von dreien:
--
--   * 32 Hex-Zeichen  → anonyme Gerätekennung (aktuelle Clients)
--   * [A-Z]\d{5}      → echte Mitgliedsnummer (Altbestand vor der Umstellung)
--   * "unknown"       → Meldung ohne verwertbare Kennung
--
-- Hinweis für api/admin/user_details.php: dessen Abfrage der letzten
-- Akkuwerte über `WHERE mitgliedernummer = <Mitgliedsnummer>` trifft für
-- aktuelle Clients bewusst nichts mehr. Das ist die beabsichtigte Folge der
-- Anonymisierung, kein Fehler dieser Migration.
--
-- Rückwärtskompatibel: VARCHAR verbreitern ist eine In-place-Operation ohne
-- Datenverlust, bestehende Zeilen bleiben unverändert.

ALTER TABLE diagnostic_logs
  MODIFY COLUMN mitgliedernummer VARCHAR(64) NOT NULL;

ALTER TABLE battery_logs
  MODIFY COLUMN mitgliedernummer VARCHAR(64) NOT NULL;
