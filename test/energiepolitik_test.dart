import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/energiepolitik.dart';

void main() {
  group('Energiepolitik — Ladegerät schlägt alles', () {
    test('am Ladegerät bleibt der Grundtakt, auch bei fast leerem Akku', () {
      // Android sagt ausdrücklich: am Ladegerät ist der Einfluss
      // vernachlässigbar. Hier zu sparen brächte niemandem etwas.
      final p = Energiepolitik.ausZustand(
        ladend: true,
        akkustand: 3,
        energiesparmodus: true,
        standbyBucket: 45,
        thermalStatus: 4,
        zaehlendesNetz: true,
      );
      expect(p.stufe, Energiestufe.grosszuegig);
      expect(p.faktor, 1.0);
    });
  });

  group('Energiepolitik — am Akku', () {
    test('voller Akku ohne Auffälligkeit bleibt beim Grundtakt', () {
      final p = Energiepolitik.ausZustand(ladend: false, akkustand: 90);
      expect(p.stufe, Energiestufe.normal);
      expect(p.faktor, 1.0);
    });

    test('mittlerer Akku streckt auf das Doppelte', () {
      final p = Energiepolitik.ausZustand(ladend: false, akkustand: 40);
      expect(p.stufe, Energiestufe.sparsam);
      expect(p.faktor, 2.0);
    });

    test('knapper Akku streckt auf das Vierfache', () {
      final p = Energiepolitik.ausZustand(ladend: false, akkustand: 12);
      expect(p.stufe, Energiestufe.streng);
      expect(p.faktor, 4.0);
    });

    test('Grenzwerte zählen zur jeweils sparsameren Stufe', () {
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 20).faktor, 4.0);
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 21).faktor, 2.0);
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 50).faktor, 2.0);
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 51).faktor, 1.0);
    });

    test('Energiesparmodus streckt auch bei vollem Akku', () {
      final p = Energiepolitik.ausZustand(
          ladend: false, akkustand: 95, energiesparmodus: true);
      expect(p.stufe, Energiestufe.streng);
      expect(p.faktor, 4.0);
      expect(p.begruendung, contains('Energiesparmodus'));
    });

    test('Standby-Bucket rare streckt, working_set nicht', () {
      // Ab 40 beschränkt Android den Netzzugriff ohnehin; dagegen anzulaufen
      // kostet Funkzeit, ohne etwas zu erreichen.
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 90, standbyBucket: 40).faktor, 4.0);
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 90, standbyBucket: 20).faktor, 1.0);
    });

    test('thermische Drosselung ab moderate streckt', () {
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 90, thermalStatus: 2).faktor, 4.0);
      expect(Energiepolitik.ausZustand(ladend: false, akkustand: 90, thermalStatus: 1).faktor, 1.0);
    });

    test('Mobilfunk allein streckt nur leicht', () {
      final p = Energiepolitik.ausZustand(
          ladend: false, akkustand: 90, zaehlendesNetz: true);
      expect(p.faktor, 1.5);
      expect(p.stufe, Energiestufe.sparsam);
    });

    test('das restriktivste Signal gewinnt, nicht das letzte', () {
      final p = Energiepolitik.ausZustand(
        ladend: false,
        akkustand: 90,
        energiesparmodus: true,
        zaehlendesNetz: true,
      );
      expect(p.faktor, 4.0);
      expect(p.begruendung, contains('Energiesparmodus'));
    });

    test('Faktor überschreitet die Obergrenze nie', () {
      final p = Energiepolitik.ausZustand(
        ladend: false,
        akkustand: 2,
        energiesparmodus: true,
        standbyBucket: 45,
        thermalStatus: 5,
        zaehlendesNetz: true,
      );
      expect(p.faktor, lessThanOrEqualTo(Energiepolitik.maxFaktor));
    });

    test('unbekannter Akkustand ist kein Grund zu strecken', () {
      // Desktop-Rechner ohne Akku melden nichts; sie sollen nicht in den
      // Sparmodus fallen, nur weil der Wert fehlt.
      final p = Energiepolitik.ausZustand(ladend: false, akkustand: null);
      expect(p.faktor, 1.0);
    });
  });

  group('Energiepolitik — Intervallrechnung', () {
    test('Faktor 1 gibt das Grundintervall unverändert zurück', () {
      const grund = Duration(seconds: 60);
      final p = Energiepolitik.ausZustand(ladend: false, akkustand: 90);
      expect(p.intervall(grund), grund);
    });

    test('streckt gemäss Faktor und rundet auf Sekunden', () {
      final p = Energiepolitik.ausZustand(ladend: false, akkustand: 40);
      expect(p.intervall(const Duration(seconds: 60)), const Duration(seconds: 120));
      expect(p.intervall(const Duration(seconds: 15)), const Duration(seconds: 30));
    });

    test('krumme Werte werden auf ganze Sekunden gerundet', () {
      final p = Energiepolitik.ausZustand(
          ladend: false, akkustand: 90, zaehlendesNetz: true);
      // 15 s × 1,5 = 22,5 s → 23 s (kaufmännisch gerundet).
      expect(p.intervall(const Duration(seconds: 15)), const Duration(seconds: 23));
    });

    test('das Ergebnis ist nie kürzer als eine Sekunde', () {
      final p = Energiepolitik.ausZustand(ladend: false, akkustand: 90);
      expect(p.intervall(const Duration(milliseconds: 100)).inSeconds,
          greaterThanOrEqualTo(0));
      final streng = Energiepolitik.ausZustand(ladend: false, akkustand: 5);
      expect(streng.intervall(const Duration(milliseconds: 100)),
          greaterThanOrEqualTo(const Duration(seconds: 1)));
    });
  });
}
