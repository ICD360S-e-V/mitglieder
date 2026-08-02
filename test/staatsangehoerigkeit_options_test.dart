import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/staatsangehoerigkeit_options.dart';

/// Die Liste kommt vom Server, hier wird nur gruppiert und sortiert. Getestet
/// wird deshalb das, was daran schiefgehen kann: eine doppelte Bezeichnung
/// lässt DropdownButton beim Auswählen werfen, und eine Zeile ohne Kontinent
/// darf nicht einfach verschwinden.
void main() {
  Map<String, dynamic> z(String bezeichnung, String kontinent) =>
      {'bezeichnung': bezeichnung, 'kontinent': kontinent, 'land': '', 'iso_code': ''};

  group('Gruppierung', () {
    test('Erdteile kommen in fester Reihenfolge', () {
      final g = gruppiereStaatsangehoerigkeiten([
        z('kenianisch', 'Afrika'),
        z('samoanisch', 'Australien/Ozeanien'),
        z('deutsch', 'Europa'),
        z('japanisch', 'Asien'),
        z('kubanisch', 'Amerika'),
        z('staatenlos', 'Sonstige'),
      ]);
      expect(g.map((e) => e.kontinent).toList(),
          ['Europa', 'Asien', 'Afrika', 'Amerika', 'Australien/Ozeanien', 'Sonstige']);
    });

    test('die im Verein vorkommenden stehen in ihrer Gruppe oben', () {
      final g = gruppiereStaatsangehoerigkeiten([
        z('albanisch', 'Europa'),
        z('rumänisch', 'Europa'),
        z('belgisch', 'Europa'),
        z('deutsch', 'Europa'),
      ]);
      expect(g.single.bezeichnungen.take(2), containsAll(['deutsch', 'rumänisch']));
      expect(g.single.bezeichnungen.sublist(2), ['albanisch', 'belgisch']);
    });

    test('Umlaute sortieren wie der Grundbuchstabe', () {
      // „ägyptisch" gehört zwischen „afghanisch" und „albanisch", nicht ans Ende.
      final g = gruppiereStaatsangehoerigkeiten([
        z('albanisch', 'Afrika'),
        z('ägyptisch', 'Afrika'),
        z('afghanisch', 'Afrika'),
      ]);
      expect(g.single.bezeichnungen, ['afghanisch', 'ägyptisch', 'albanisch']);
    });

    test('Zeilen ohne Kontinent landen unter Sonstige statt zu verschwinden', () {
      // Schutz gegen eine ältere Serverfassung ohne die Spalte.
      final g = gruppiereStaatsangehoerigkeiten([
        {'bezeichnung': 'deutsch'},
        z('französisch', 'Europa'),
      ]);
      expect(g.map((e) => e.kontinent), ['Europa', 'Sonstige']);
      expect(g.last.bezeichnungen, ['deutsch']);
    });

    test('ein unbekannter Erdteil wird hinten angehängt, nicht verworfen', () {
      final g = gruppiereStaatsangehoerigkeiten([
        z('deutsch', 'Europa'),
        z('irgendwas', 'Mars'),
      ]);
      expect(g.map((e) => e.kontinent), ['Europa', 'Mars']);
    });

    test('doppelte Bezeichnungen werden entfernt', () {
      // Zwei Items mit demselben Wert lassen DropdownButton werfen, sobald
      // genau dieser Wert ausgewählt ist.
      final g = gruppiereStaatsangehoerigkeiten([
        z('deutsch', 'Europa'),
        z('deutsch', 'Europa'),
        z('deutsch', 'Asien'),
      ]);
      final alle = g.expand((e) => e.bezeichnungen).toList();
      expect(alle, ['deutsch']);
    });

    test('leere Bezeichnungen fliegen raus', () {
      final g = gruppiereStaatsangehoerigkeiten([
        z('', 'Europa'),
        z('   ', 'Europa'),
        z('deutsch', 'Europa'),
      ]);
      expect(g.single.bezeichnungen, ['deutsch']);
    });

    test('leere Eingabe ergibt keine Gruppen', () {
      expect(gruppiereStaatsangehoerigkeiten([]), isEmpty);
    });
  });

  group('Normalisierung alter Freitexte', () {
    final liste = [z('rumänisch', 'Europa'), z('deutsch', 'Europa'), z('türkisch', 'Asien')];

    test('fehlender Umlaut und Großschreibung werden erkannt', () {
      // Genau so standen 13 Mitglieder in der Datenbank, bevor das Feld eine
      // Auswahl wurde.
      expect(staatsangehoerigkeitNormalisieren('Rumanisch', liste), 'rumänisch');
      expect(staatsangehoerigkeitNormalisieren('RUMÄNISCH', liste), 'rumänisch');
      expect(staatsangehoerigkeitNormalisieren('  turkisch ', liste), 'türkisch');
    });

    test('leer bleibt leer', () {
      expect(staatsangehoerigkeitNormalisieren(null, liste), '');
      expect(staatsangehoerigkeitNormalisieren('  ', liste), '');
    });

    test('Unbekanntes bleibt unverändert stehen', () {
      expect(staatsangehoerigkeitNormalisieren('marsianisch', liste), 'marsianisch');
    });

    test('ohne geladene Liste wird nichts verbogen', () {
      expect(staatsangehoerigkeitNormalisieren('Rumanisch', const []), 'Rumanisch');
    });
  });
}
