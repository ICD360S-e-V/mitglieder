import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/eu_eea_citizenship.dart';

/// Diese Einstufung entscheidet, ob ein Mitglied nach einem Aufenthaltstitel
/// gefragt wird. Fällt jemand fälschlich in „Drittstaat", verlangt die
/// Verifizierung ein Dokument, das es nicht geben kann; fällt jemand
/// fälschlich in „EU/EWR", fehlt eine nötige Angabe. Beides fällt im Betrieb
/// nicht auf, deshalb hier festgenagelt.
void main() {
  group('Einstufung', () {
    test('deutsch ist eine eigene Gruppe', () {
      expect(citizenshipBucket('deutsch'), CitizenshipBucket.german);
      expect(citizenshipBucket('German'), CitizenshipBucket.german);
    });

    test('leer ist nicht Drittstaat', () {
      // Solange nichts eingetragen ist, darf kein Aufenthaltstitel verlangt werden.
      expect(citizenshipBucket(null), CitizenshipBucket.none);
      expect(citizenshipBucket(''), CitizenshipBucket.none);
      expect(citizenshipBucket('   '), CitizenshipBucket.none);
    });

    test('alle 27 EU-Staatsangehörigkeiten ergeben EU/EWR', () {
      const eu27 = [
        'österreichisch', 'belgisch', 'bulgarisch', 'kroatisch', 'zyprisch',
        'tschechisch', 'dänisch', 'estnisch', 'finnisch', 'französisch',
        'griechisch', 'ungarisch', 'irisch', 'italienisch', 'lettisch',
        'litauisch', 'luxemburgisch', 'maltesisch', 'niederländisch',
        'polnisch', 'portugiesisch', 'rumänisch', 'slowakisch', 'slowenisch',
        'spanisch', 'schwedisch',
      ];
      for (final a in eu27) {
        expect(citizenshipBucket(a), CitizenshipBucket.euEea, reason: 'falsch eingestuft: $a');
      }
      // Deutschland ist das 27. Mitglied, hat aber eine eigene Gruppe.
      expect(eu27.length, 26);
    });

    test('EWR und Schweiz haben ebenfalls Freizügigkeit', () {
      for (final a in ['isländisch', 'liechtensteinisch', 'norwegisch', 'schweizerisch']) {
        expect(citizenshipBucket(a), CitizenshipBucket.euEea, reason: 'falsch eingestuft: $a');
      }
    });

    test('Schreibweise ohne Umlaut und Großschreibung stören nicht', () {
      // Diese Werte stehen real in der Datenbank, weil das Feld früher
      // getippt wurde — „rumanisch" bei 13 Mitgliedern.
      expect(citizenshipBucket('rumanisch'), CitizenshipBucket.euEea);
      expect(citizenshipBucket('RUMÄNISCH'), CitizenshipBucket.euEea);
      expect(citizenshipBucket('  Osterreichisch '), CitizenshipBucket.euEea);
    });

    test('alles andere ist Drittstaat', () {
      for (final a in ['ukrainisch', 'russisch', 'türkisch', 'kosovarisch', 'britisch']) {
        expect(citizenshipBucket(a), CitizenshipBucket.thirdCountry, reason: 'falsch eingestuft: $a');
      }
    });

    test('das Vereinigte Königreich ist seit dem Brexit kein EU/EWR-Fall', () {
      expect(euEeaAdjectives.contains('britisch'), isFalse);
      expect(euEeaAdjectives.contains('british'), isFalse);
    });
  });

  group('Sauberkeit der Menge', () {
    test('alle Einträge sind kleingeschrieben und ohne Rand-Leerzeichen', () {
      // citizenshipBucket vergleicht kleingeschrieben — ein Eintrag mit
      // Großbuchstaben wäre unerreichbar.
      for (final a in euEeaAdjectives) {
        expect(a, a.toLowerCase(), reason: 'nicht kleingeschrieben: $a');
        expect(a, a.trim(), reason: 'Rand-Leerzeichen: "$a"');
        expect(a, isNotEmpty);
      }
    });

    test('deutsch steht nicht in der Menge', () {
      // Sonst käme german nie zustande — die Reihenfolge in citizenshipBucket
      // fängt es zwar ab, aber der Eintrag wäre trotzdem irreführend.
      expect(euEeaAdjectives.contains('deutsch'), isFalse);
    });
  });
}
