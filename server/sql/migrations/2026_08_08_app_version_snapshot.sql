-- Migration: die App-Fassung im Moment der Unterschrift festhalten
--
-- Bisher las das Beweisbuendel die Fassung aus device_keys.app_version. Die
-- Spalte wird aber bei JEDEM Login und bei jedem Start ueber device/validate.php
-- neu geschrieben — sie beschreibt also die Fassung von HEUTE, nicht die vom
-- Unterschriftszeitpunkt.
--
-- Aktualisiert das Mitglied seine App, behauptet das Buendel einer alten
-- Unterschrift plötzlich, sie sei mit der neuen Fassung geleistet worden. Eine
-- falsche Angabe in einem Beweisdokument ist schlimmer als keine: wer sie
-- widerlegt, stellt alle uebrigen Felder in Frage.
--
-- Deshalb eine eigene, unveraenderliche Spalte. Sie wird beim Unterschreiben
-- einmal aus device_keys uebernommen und danach nie mehr angefasst.
--
-- Bestehende Unterschriften bleiben ABSICHTLICH leer. Sie nachtraeglich mit dem
-- heutigen Wert zu fuellen waere geraten, und genau das soll die Spalte
-- verhindern.

ALTER TABLE dokument_signaturen
  ADD COLUMN IF NOT EXISTS app_version VARCHAR(32) NULL
    COMMENT 'App-Fassung im Moment der Unterschrift — Momentaufnahme, nie nachtraeglich geaendert';
