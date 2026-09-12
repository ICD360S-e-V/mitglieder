-- Migration: Anzeigegröße und Schriftgröße je Gerät mitschreiben
--
-- Anlass: Die Meldung „bei mir sieht die App aus wie ein Trümmerhaufen" von
-- einem Mitglied mit vergrößerter Schrift. Was wir über sein Gerät wussten,
-- war der Modellname — daraus folgt die Auflösung, aber nicht, wie er das
-- Gerät eingestellt hat. Und genau die Einstellung ist der Unterschied
-- zwischen „passt" und „unbedienbar":
--
--   * Die System-Schriftgröße geht in den Android-Bedienungshilfen bis 200 %,
--     auf iOS mit den großen Graden noch darüber. Jede fest gesetzte
--     Schriftgröße der App wächst mit.
--   * Die Anzeigegröße ist eine ZWEITE, unabhängige Stellschraube. Sie ändert
--     nicht die Schrift, sondern die Dichte: die App bekommt weniger dp
--     gemeldet. Auf der höchsten Stufe bleiben rund 77 % übrig — aus einem
--     360 dp breiten Telefon werden 277 dp.
--
-- Wer schlecht sieht, dreht in aller Regel beide hoch. Diese Kombination ist
-- der harte Fall, und bisher konnten wir nur raten, ob ein Mitglied in ihm
-- sitzt. Mit diesen vier Spalten steht es in der Geräteliste.
--
-- Die Werte kommen aus DeviceKeyService._collectExtendedDeviceData() und damit
-- über BEIDE Wege: device/register.php (einmalig) und device/validate.php
-- (regelmäßig). Ändert jemand die Einstellung später, zieht der Wert nach.
--
-- Alle vier Spalten sind NULL-fähig: ältere App-Stände schicken sie nicht, und
-- eine Zeile ohne diese Angaben ist kein Fehler, sondern nur ein Gerät, das
-- sich seit dem Update nicht gemeldet hat.
--
-- Hinweis zum Datenschutz: die Schriftgröße ist eine Bedienungshilfe und lässt
-- damit einen Rückschluss auf eine Sehbeeinträchtigung zu. Sie steht hier aus
-- einem einzigen Grund — damit Darstellungsfehler reproduzierbar werden — und
-- gehört in dieselbe Zeile der Datenschutzerklärung wie die übrigen
-- Gerätedaten (Akku, Speicher, Root-Status).

ALTER TABLE device_keys
  ADD COLUMN screen_width_dp     SMALLINT UNSIGNED NULL
    COMMENT 'Logische Breite in dp, enthält die Anzeigegröße'  AFTER os_version,
  ADD COLUMN screen_height_dp    SMALLINT UNSIGNED NULL
    COMMENT 'Logische Höhe in dp'                              AFTER screen_width_dp,
  ADD COLUMN device_pixel_ratio  DECIMAL(4,2)      NULL
    COMMENT 'Physische Pixel je dp'                            AFTER screen_height_dp,
  ADD COLUMN text_scale          DECIMAL(4,2)      NULL
    COMMENT 'System-Schriftgröße: 1.00 = Standard, 2.00 = größte Stufe'
                                                               AFTER device_pixel_ratio;

-- Wer sitzt im harten Fall? Diese Abfrage beantwortet genau die Frage, die
-- den Anlass gegeben hat.
--
--   SELECT mitgliedernummer, device_name, os_version,
--          screen_width_dp, screen_height_dp, text_scale
--     FROM device_keys
--    WHERE is_active = 1
--      AND (text_scale >= 1.3 OR screen_width_dp < 330)
--    ORDER BY text_scale DESC;
