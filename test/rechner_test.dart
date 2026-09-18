import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/rechner_ausdruck.dart';
import 'package:icd360sev_mitglied/utils/rechner_eingabe.dart';

/// Rechnet und formatiert wie der Bildschirm.
String anzeige(String ausdruck) {
  final e = rechnerAuswerten(ausdruck);
  return e.istFehler ? 'FEHLER: ${e.fehler!.name}' : rechnerZahlFormat(e.wert!);
}

/// Tippt eine Tastenfolge (durch `|` getrennt) und gibt die Rechenzeile
/// zurück. `=` wertet aus und übernimmt, genau wie `_gleich()` im Dialog.
String tippe(String tasten) {
  var st = const RechnerStand();
  for (final t in tasten.split('|')) {
    if (t == '=') {
      final e = rechnerAuswerten(st.ausdruck);
      if (!e.istFehler) st = st.mitErgebnis(e.wert!);
    } else {
      st = rechnerTaste(st, t);
    }
  }
  return st.ausdruck;
}

/// Ein Text aus der deutschen Sprachdatei — der Vorlage fuer alle 28.
String _de(String schluessel) {
  final roh = File('lib/l10n/app_de.arb').readAsStringSync();
  final daten = jsonDecode(roh) as Map<String, dynamic>;
  final wert = daten[schluessel];
  expect(wert, isA<String>(),
      reason: '$schluessel fehlt in app_de.arb — dann steht der Hinweis '
          'nirgends, und der Rechner rechnet anders, als er sagt.');
  return wert as String;
}

void main() {
  group('Vorrang', () {
    // ⚠️ DIE Entscheidung dieses Rechners. Ein Taschenrechner aus Plastik
    // käme auf 20. Wer das umstellt, ändert rückwirkend jede gespeicherte
    // Zeile im Verlauf — dort steht der Ausdruck, nicht das Ergebnis.
    test('Punkt vor Strich, nicht von links nach rechts', () {
      expect(anzeige('2+3×4'), '14');
      expect(anzeige('2-3×4'), '-10');
      expect(anzeige('100-10×2'), '80');
    });

    test('Klammern schlagen den Vorrang', () {
      expect(anzeige('(2+3)×4'), '20');
      expect(anzeige('((1+2)×(3+4))'), '21');
    });

    test('gleichrangiges wird von links nach rechts gerechnet', () {
      expect(anzeige('8÷2÷2'), '2');
      expect(anzeige('10-3-2'), '5');
    });

    test('der Hinweistext nennt genau diese Regel', () {
      // Er steht unter dem Tastenfeld. Ohne ihn liest jemand 14, wo er 20
      // erwartet hat, und haelt den Rechner fuer kaputt.
      //
      // ⚠️ Geprueft wird die SPRACHDATEI und nicht mehr eine Konstante im
      // Quelltext: in dieser App steht der Satz dort, weil er in 28 Sprachen
      // gebraucht wird. Die Zusicherung ist dieselbe geblieben — der Satz muss
      // genau die Regel nennen, die der Kern oben anwendet.
      expect(_de('rechnerVorrang'), contains('2 + 3 × 4 = 14'));
      expect(_de('rechnerVorrang'), contains('Klammern'));
    });
  });

  group('Gleitkomma', () {
    // ⚠️ Ohne das Runden stünde hier 0,30000000000000004 auf dem Schirm.
    test('0,1 + 0,2 ergibt 0,3 und nicht das Binaergespenst', () {
      expect(anzeige('0,1+0,2'), '0,3');
      expect(anzeige('1,1×3'), '3,3');
      expect(anzeige('4,35×100'), '435');
    });

    test('genug Stellen bleiben stehen', () {
      expect(anzeige('1÷3'), '0,333333333333');
      expect(anzeige('1÷7'), '0,142857142857');
    });

    test('eine getippte Zahl kommt unveraendert wieder heraus', () {
      // Der erste Entwurf machte hieraus 1.234.567,8899999999 — die feste
      // Stellenzahl im Formatierer legte die Ungenauigkeit wieder frei.
      expect(anzeige('1234567,89'), '1.234.567,89');
      expect(anzeige('0,07'), '0,07');
    });
  });

  group('Prozent', () {
    test('nach + und - heisst es „vom Wert davor"', () {
      expect(anzeige('120+19%'), '142,8');
      expect(anzeige('120-19%'), '97,2');
      expect(anzeige('200+50%'), '300');
    });

    test('nach × und ÷ ist es schlicht geteilt durch hundert', () {
      expect(anzeige('500×19%'), '95');
      expect(anzeige('200÷10%'), '2.000');
    });

    test('allein steht es fuer sich', () {
      expect(anzeige('19%'), '0,19');
      expect(anzeige('50%%'), '0,005');
    });

    test('nur eine EINZELNE Prozentzahl bezieht sich auf den Wert davor', () {
      // `2 × 10 %` ist keine einzelne Prozentzahl — welcher Wert dort die
      // Bezugsgroesse waere, sagt der Ausdruck nicht.
      expect(anzeige('100+2×10%'), '100,2');
    });

    test('die Prozentregel steht so auch im Kern-Kommentar', () {
      // In der Vorsitzer-App hing daran ein Hinweistext unter dem Tastenfeld.
      // Hier ist er weggefallen: mit dem Vorrang-Satz zusammen waren es zwei
      // Absaetze unter zwanzig Tasten, und auf einem 320 dp breiten Telefon
      // schob das die untere Tastenreihe aus dem Bild. Die Regel selbst bleibt
      // geprueft — durch die vier Zusicherungen darueber, nicht durch einen
      // Satz.
      expect(anzeige('120+19%'), '142,8');
    });
  });

  group('Fehler werden benannt, nicht verschluckt', () {
    test('Division durch null', () {
      expect(anzeige('5÷0'), 'FEHLER: divisionDurchNull');
      // ⚠️ Nicht „∞": das sähe aus wie ein Ergebnis.
      expect(anzeige('5÷0'), isNot(contains('∞')));
    });

    test('Klammern', () {
      expect(anzeige('(2+3'), 'FEHLER: klammerNichtGeschlossen');
      expect(anzeige('2+3)'), 'FEHLER: klammerOhneAnfang');
    });

    test('unvollstaendig und unbekannt', () {
      expect(anzeige('2+'), 'FEHLER: unvollstaendig');
      expect(anzeige('2&3'), contains('unerwartetesZeichen'));
    });

    test('leere Zeile ist kein Fehler', () => expect(anzeige(''), '0'));
  });

  group('Tastatur', () {
    // ⚠️ Die Tastatur hat kein × und kein ÷. Ohne diese Tabelle waere der
    // Rechner am Schreibtisch nur mit der Maus bedienbar.
    test('*, x, / und : rechnen wie × und ÷', () {
      expect(anzeige('2*3'), '6');
      expect(anzeige('2x3'), '6');
      expect(anzeige('10/4'), '2,5');
      expect(anzeige('10:4'), '2,5');
    });

    test('Punkt UND Komma sind Dezimaltrennzeichen', () {
      // Der Ziffernblock liefert je nach Belegung das eine oder das andere.
      expect(anzeige('1.5+1'), '2,5');
      expect(anzeige('1,5+1'), '2,5');
    });

    test('das typografische Minus rechnet auch', () {
      expect(anzeige('5−3'), '2');
    });

    test('Klammern haben eigene Tasten, der Bildschirm nur eine', () {
      // Ohne die beiden Faelle taete `(` auf der Tastatur schlicht nichts.
      expect(tippe('(|2|+|3|)'), '(2+3)');
      expect(tippe('()|2|+|3|()'), '(2+3)');
    });
  });

  group('Anzeige laesst sich wieder einlesen', () {
    // Die Eigenschaft, auf der das Weiterrechnen nach `=` steht.
    for (final f in [
      '0,1+0,2', '1÷3', '1234567,89', '-5+3', '120+19%',
      '99999999999×99999999999', '1÷100000000000', '0-0,000000001',
    ]) {
      test('„$f" rundlaeuft', () {
        final e = rechnerAuswerten(f);
        expect(e.istFehler, isFalse);
        final zurueck = rechnerAuswerten(rechnerZahlRoh(e.wert!));
        expect(zurueck.istFehler, isFalse,
            reason: 'Rohfassung „${rechnerZahlRoh(e.wert!)}" nicht lesbar');
        expect(zurueck.wert, e.wert);
      });
    }

    test('sehr grosse Zahlen gehen in die Exponentialschreibweise', () {
      expect(anzeige('99999999999×99999999999'), '9,9999999998E+21');
      expect(anzeige('1÷100000000000'), '1E-11');
    });
  });

  group('Tasten: Rechenzeichen', () {
    test('ein zweites Rechenzeichen ERSETZT das erste', () {
      expect(tippe('5|+|×'), '5×');
      expect(tippe('5|+|-'), '5-');
    });

    test('hinter × oder ÷ ist ein Minus ein Vorzeichen, kein Ersatz', () {
      expect(tippe('5|×|-'), '5×-');
      expect(anzeige('5×-3'), '-15');
    });

    test('nur Minus darf eine Rechnung eroeffnen', () {
      expect(tippe('×|5'), '5');
      expect(tippe('+|5'), '5');
      expect(tippe('-|5'), '-5');
    });
  });

  group('Tasten: Komma', () {
    test('kein zweites Komma in dieselbe Zahl', () {
      expect(tippe('5|,|,|3'), '5,3');
      expect(tippe('1|,|5|+|2|,|,|5'), '1,5+2,5');
    });

    test('ein fuehrendes Komma bekommt seine Null', () {
      expect(tippe(',|5'), '0,5');
      expect(tippe('5|+|,|2'), '5+0,2');
    });
  });

  group('Tasten: nach dem Gleichheitszeichen', () {
    test('eine Ziffer faengt eine neue Rechnung an', () {
      // Anzuhaengen hiesse, aus 5 und 7 die Zahl 57 zu machen.
      expect(tippe('2|+|3|=|7'), '7');
    });

    test('ein Rechenzeichen rechnet mit dem Ergebnis weiter', () {
      expect(tippe('2|+|3|=|+|1'), '5+1');
      expect(tippe('1|0|÷|4|=|×|2'), '2,5×2');
    });

    test('die Ruecktaste macht das Ergebnis wieder zur Eingabe', () {
      expect(tippe('1|2|+|3|=|⌫'), '1');
    });

    test('weitergerechnet wird mit dem ANGEZEIGTEN Wert', () {
      // Was man sieht, ist was gerechnet wird — sonst passt die naechste
      // Zeile nicht zu der Zahl darueber.
      var st = const RechnerStand();
      for (final t in '0|,|1|+|0|,|2'.split('|')) {
        st = rechnerTaste(st, t);
      }
      st = st.mitErgebnis(rechnerAuswerten(st.ausdruck).wert!);
      expect(st.ausdruck, '0,3');
    });
  });

  group('Tasten: Klammern', () {
    test('keine stille Multiplikation — das × steht sichtbar da', () {
      // Der Rechenkern kennt `5(2+3)` nicht, und der Fehler faellt sonst
      // erst beim `=` auf.
      expect(tippe('5|()'), '5×(');
      expect(tippe('5|('), '5×(');
    });

    test('die Taste schliesst, wenn etwas offen ist', () {
      expect(tippe('()|2|+|3|()'), '(2+3)');
    });

    test('eine schliessende Klammer ohne offene tut nichts', () {
      expect(tippe(')'), '');
      expect(tippe('(|)'), '(');
    });

    test('auf leerer Zeile oeffnet die Taste', () {
      // ⚠️ Der Fall, an dem `contains(\'\')` in Dart TRUE liefert: die leere
      // Zeile galt als „endet auf einer Zahl" und bekam `×(`.
      expect(tippe('()'), '(');
      expect(tippe('()|()'), '((');
    });
  });

  group('Tasten: Vorzeichen', () {
    test('dreht die letzte Zahl um und wieder zurueck', () {
      expect(tippe('5|±'), '-5');
      expect(tippe('5|±|±'), '5');
      expect(tippe('5|+|3|±'), '5+-3');
      expect(tippe('5|+|3|±|±'), '5+3');
    });

    test('ein Minus, das eine RECHNUNG ist, bleibt stehen', () {
      // Sonst waere aus `5-3` die Zahl 53 geworden.
      expect(tippe('5|-|3|±'), '5--3');
      expect(anzeige('5--3'), '8');
    });
  });

  group('Tasten: Prozent, Zuruecknehmen, Loeschen', () {
    test('Prozent braucht eine Zahl davor', () {
      expect(tippe('+|%'), '');
      expect(tippe('1|2|0|+|1|9|%'), '120+19%');
    });

    test('AC raeumt alles weg', () {
      expect(tippe('1|2|3|AC'), '');
      expect(tippe('9|9|AC|7'), '7');
    });

    test('eine unbekannte Taste aendert NICHTS', () {
      // Sie einfach anzuhaengen hiesse, die Zeile fuer jeden Tastendruck zu
      // oeffnen — und der Fehler fiele erst beim `=` auf.
      expect(tippe('5|@|3'), '53');
      expect(tippe('5|abc'), '5');
    });
  });

  group('Eingabezeile lesbar machen', () {
    test('Tausenderpunkte nur vor dem Komma', () {
      expect(rechnerAusdruckFormat('1234567+12'), '1.234.567+12');
      expect(rechnerAusdruckFormat('12+3456,7891'), '12+3.456,7891');
      expect(rechnerAusdruckFormat('0,123456'), '0,123456');
    });

    test('Rechenzeichen bleiben unangetastet', () {
      expect(rechnerAusdruckFormat('(1000×2)÷5%'), '(1.000×2)÷5%');
    });

    // ⚠️ Der Kern darf die geschminkte Fassung NIE zu sehen bekommen — er
    // laese `1.234` als 1,234.
    test('der Kern rechnet mit der ungeschminkten Fassung', () {
      expect(anzeige('1234+1'), '1.235');
      expect(anzeige(rechnerAusdruckFormat('1234+1')), isNot('1.235'));
    });
  });
}
