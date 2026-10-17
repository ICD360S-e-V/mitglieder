import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:icd360sev_mitglied/services/kontakt_link.dart';

/// Der Link in der Mail mit dem Bestätigungscode — was die App daraus liest.
///
/// Meldung des Vorsitzenden, 17.10.2026: „ar fi super daca ar fi un link care
/// sa duca in aplicatie si codul sa se completeze automat“. Die Mail trägt
/// https://icd360sev.icd360s.de/code/#email=482913; die Seite dahinter ruft
/// icd360s-mitglied://code#email=482913 auf.
void main() {
  KontaktCodeAusLink? lesen(String link) => KontaktLink.lesen(Uri.parse(link));
  const ausMail = KontaktCodeAusLink('email', '482913');

  group('lesen', () {
    test('der Link aus der Mail', () {
      expect(lesen('https://icd360sev.icd360s.de/code/#email=482913'), ausMail);
    });

    test('ohne Schrägstrich am Ende, mit führender Null', () {
      expect(lesen('https://icd360sev.icd360s.de/code#email=012345'),
          const KontaktCodeAusLink('email', '012345'));
    });

    test('das eigene Schema — Windows, macOS, iOS, Linux und der Knopf der Seite', () {
      expect(lesen('icd360s-mitglied://code#email=482913'), ausMail);
      expect(lesen('icd360s-mitglied://code/#email=482913'), ausMail);
    });

    test('der Code nach dem ? statt hinter dem # — ein umgebauter Link', () {
      expect(lesen('https://icd360sev.icd360s.de/code/?email=482913'), ausMail);
    });

    test('Großschreibung in Schema und Host', () {
      expect(lesen('HTTPS://ICD360SEV.icd360s.de/code/#email=482913'), ausMail);
    });

    test('die Nummer', () {
      expect(lesen('https://icd360sev.icd360s.de/code/#telefon=482913'),
          const KontaktCodeAusLink('telefon', '482913'));
    });

    test('fremde Links zählen nicht', () {
      for (final link in [
        'https://example.com/code/#email=482913',
        'http://icd360sev.icd360s.de/code/#email=482913',
        'https://icd360sev.icd360s.de/u/#email=482913',
        'https://icd360sev.icd360s.de/code/x#email=482913',
        'https://icd360sev.icd360s.de.example.com/code/#email=482913',
        'https://icd360s.de/code/#email=482913',
        'icd360s-mitglied://anders#email=482913',
        'andere-app://code#email=482913',
      ]) {
        expect(lesen(link), isNull, reason: link);
      }
    });

    test('nur genau sechs Ziffern', () {
      for (final code in ['48291', '4829133', '48291a', '', '４８２９１３', '48 2913']) {
        expect(lesen('https://icd360sev.icd360s.de/code/#email=${Uri.encodeQueryComponent(code)}'), isNull,
            reason: code);
      }
    });

    test('ein unbekannter Kanal zählt nicht', () {
      expect(lesen('https://icd360sev.icd360s.de/code/#sms=482913'), isNull);
      expect(lesen('https://icd360sev.icd360s.de/code/'), isNull);
    });

    test('kaputte Kodierung wirft nicht', () {
      expect(lesen('https://icd360sev.icd360s.de/code/#email=%FF%FE%FD'), isNull);
    });
  });

  group('KontaktLink', () {
    setUp(() => KontaktLink.instance.abholen());

    test('ein Link wartet, bis das Dashboard ihn abholt — genau einmal', () {
      KontaktLink.instance.aufnehmen(Uri.parse('https://icd360sev.icd360s.de/code/#email=482913'));
      expect(KontaktLink.instance.offen.value, ausMail);
      expect(KontaktLink.instance.abholen(), ausMail);
      expect(KontaktLink.instance.abholen(), isNull);
    });

    test('ein fremder Link überschreibt den wartenden Code nicht', () {
      KontaktLink.instance.aufnehmen(Uri.parse('https://icd360sev.icd360s.de/code/#email=482913'));
      KontaktLink.instance.aufnehmen(Uri.parse('https://example.com/'));
      expect(KontaktLink.instance.abholen(), ausMail);
    });

    test('starten hört auf die Links von app_links — auch auf den vom Start', () async {
      final links = StreamController<Uri>();
      KontaktLink.instance.starten(links: links.stream);
      links.add(Uri.parse('https://icd360sev.icd360s.de/code/#email=482913'));
      await Future<void>.delayed(Duration.zero);
      expect(KontaktLink.instance.abholen(), ausMail);
      await links.close();
    });

    test('toString verrät den Code nicht', () {
      expect(ausMail.toString(), isNot(contains('482913')));
    });
  });
}
