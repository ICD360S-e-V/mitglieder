import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/services/wizard_service.dart';
import 'package:icd360sev_mitglied/utils/mitglied_felder.dart';

/// Dieselben Werte im Online-Formular, in dieser App und in der
/// Verifizierung des Vorstandspanels (05.10.2026).
///
/// Vorher speicherte jeder der drei seine eigene Fassung: Geschlecht als
/// 'maennlich' hier und 'M' dort, vier Familienstände hier und acht dort,
/// den Aufenthaltsstatus als Schlüssel hier und als Etikett dort; die App
/// nahm Mobilnummern ohne Ländervorwahl an, die der Server später abwies;
/// und wer im Mitglieds-Tab nur die Mitgliedsart speicherte, bekam „Die
/// Mobilnummer kann hier nicht geaendert werden".
String quelle(String pfad) => ohneKommentare(File(pfad).readAsStringSync());

/// Kommentare weg — sonst bestätigt der Test die Erklärung über dem Code
/// statt den Code (die Kommentare nennen die alten Werte mit Absicht).
String ohneKommentare(String q) => q
    .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '')
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i);
    })
    .join('\n');

/// Der Rumpf einer Methode — ab dem Kopf bis zur ausgeglichenen Klammer.
String rumpf(String quelltext, String kopf) {
  final start = quelltext.indexOf(kopf);
  expect(start, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  var i = quelltext.indexOf('{', start + kopf.length);
  var tiefe = 0;
  final ab = i;
  while (i < quelltext.length) {
    if (quelltext[i] == '{') tiefe++;
    if (quelltext[i] == '}') {
      tiefe--;
      if (tiefe == 0) return quelltext.substring(ab, i + 1);
    }
    i++;
  }
  fail('Rumpf nicht geschlossen: $kopf');
}

void main() {
  group('Telefon: dieselbe Regel wie telefonPruefen() auf dem Server', () {
    test('mit Ländervorwahl → kanonisch', () {
      expect(telefonPruefen('+49 151 2345678').nummer, '+491512345678');
      expect(telefonPruefen('0049 151 2345678').nummer, '+491512345678');
      expect(telefonPruefen('+40 (755) 123-456').nummer, '+40755123456');
    });

    test('„+49 (0)160 …": die eingeklammerte Null fällt weg', () {
      expect(telefonPruefen('+49 (0)160 944820').nummer, '+49160944820');
    });

    test('unsichtbare Richtungsmarken aus dem Adressbuch stören nicht', () {
      expect(telefonPruefen('\u202A+49 151 2345678\u202C').nummer, '+491512345678');
    });

    test('führende Null: NICHT als deutsch geraten — Vorschlag statt Übernahme', () {
      final p = telefonPruefen('0151 2345678');
      expect(p.gueltig, isFalse);
      expect(p.fehler, TelefonFehler.ohneVorwahlNull);
      expect(p.vorschlag, '+491512345678');
      expect(p.ziffern, '01512345678');
      // Eine rumänische Nummer bleibt ein Fehler, nicht still +49755…
      expect(telefonPruefen('0755 123 456').gueltig, isFalse);
    });

    test('ohne Vorwahl, zu kurz, zu lang, keine Nummer, leer', () {
      expect(telefonPruefen('151 2345678').fehler, TelefonFehler.ohneVorwahl);
      expect(telefonPruefen('+49 12').fehler, TelefonFehler.laenge);
      expect(telefonPruefen('+1234567890123456').fehler, TelefonFehler.laenge);
      expect(telefonPruefen('abc').fehler, TelefonFehler.keineNummer);
      expect(telefonPruefen('').fehler, TelefonFehler.leer);
      expect(telefonPruefen(null).fehler, TelefonFehler.leer);
    });
  });

  group('Abbildungen alt → neu', () {
    test('Geschlecht: Altwerte werden zum Code', () {
      expect(geschlechtWerte, ['M', 'W', 'D', 'X']);
      expect(geschlechtCode('maennlich'), 'M');
      expect(geschlechtCode('weiblich'), 'W');
      expect(geschlechtCode('divers'), 'D');
      expect(geschlechtCode('keine_angabe'), 'X');
      expect(geschlechtCode('M'), 'M');
      expect(geschlechtCode('w'), 'W');
      expect(geschlechtCode(''), isNull);
      expect(geschlechtCode(null), isNull);
      expect(geschlechtCode('irgendwas'), isNull);
    });

    test('Familienstand: die sieben der Verifizierung, „unbekannt" nicht wählbar', () {
      expect(familienstandWerte, [
        'ledig',
        'verheiratet',
        'eingetragene_lebenspartnerschaft',
        'getrennt_lebend',
        'geschieden',
        'verwitwet',
        'eheaehnliche_gemeinschaft',
      ]);
      expect(familienstandWerte, isNot(contains('unbekannt')));
    });

    test('Aufenthaltsstatus: Schlüssel → Etikett genau wie auf dem Server', () {
      expect(aufenthaltEtiketten, {
        'deutsch': 'deutsche Staatsangehörigkeit',
        'doppelt_de': 'Doppelte Staatsbürgerschaft (DE + andere)',
        'eu_eea_freizuegigkeit': 'EU-/EWR-Bürger — Freizügigkeitsrecht (§ 2 FreizügG/EU)',
        'aufenthaltserlaubnis': 'Aufenthaltserlaubnis (§ 7 AufenthG)',
        'niederlassungserlaubnis': 'Niederlassungserlaubnis (§ 9 AufenthG)',
        'daueraufenthalt_eu': 'Erlaubnis zum Daueraufenthalt-EU (§ 9a AufenthG)',
        'blaue_karte_eu': 'Blaue Karte EU (§ 18b AufenthG)',
        'asylberechtigt': 'Asylberechtigt (Art. 16a GG)',
        'fluechtling_gfk': 'Anerkannte/r Flüchtling (GFK, § 25 Abs. 2 Alt. 1 AufenthG)',
        'subsidiaerer_schutz': 'Subsidiärer Schutz (§ 25 Abs. 2 Alt. 2 AufenthG)',
        'aufenthaltsgestattung': 'Aufenthaltsgestattung (§ 55 AsylG)',
        'duldung': 'Duldung (§ 60a AufenthG)',
        'humanitaer': 'Aufenthaltserlaubnis aus humanitären Gründen (§ 25 AufenthG)',
        'ukraine_24': 'Aufenthaltserlaubnis § 24 AufenthG (Ukraine-Vertriebene)',
        'sonstige': 'Sonstiges',
      });
    });

    test('Aufenthaltsstatus: gespeichertes Etikett → Schlüssel; fremdes bleibt fremd', () {
      expect(aufenthaltSchluessel('deutsch'), 'deutsch');
      expect(aufenthaltSchluessel('deutsche Staatsangehörigkeit'), 'deutsch');
      expect(aufenthaltSchluessel('Aufenthaltserlaubnis § 24 AufenthG (Ukraine-Vertriebene)'), 'ukraine_24');
      expect(aufenthaltSchluessel('EU-/EWR-Bürger — Freizügigkeitsrecht (§ 2 FreizügG/EU)'), 'eu_eea_freizuegigkeit');
      // Etikett der früheren Fassung des Online-Formulars
      expect(aufenthaltSchluessel('Aufenthaltserlaubnis (befristet, § 7 AufenthG)'), 'aufenthaltserlaubnis');
      // Ein Etikett, das nur der Vorstand vergibt: kein Schlüssel — es bleibt
      expect(aufenthaltSchluessel('Fiktionsbescheinigung (§ 81 Abs. 5 AufenthG)'), isNull);
      expect(aufenthaltSchluessel(''), isNull);
    });

    test('§ 24 steht bei ukrainischer Staatsangehörigkeit vorn', () {
      expect(aufenthaltDrittstaatFuer('ukrainisch').first, 'ukraine_24');
      expect(aufenthaltDrittstaatFuer('türkisch').first, isNot('ukraine_24'));
      expect(aufenthaltDrittstaatFuer('türkisch'), contains('ukraine_24'));
      expect(aufenthaltDeutsch, ['deutsch', 'doppelt_de']);
    });

    test('Mitgliedsart ohne Ehrenmitglied, Zahlung ohne SEPA, Zahltag 1–28', () {
      expect(mitgliedsartWaehlbar, ['ordentlich', 'foerdermitglied']);
      expect(zahlungsmethodeWaehlbar, ['ueberweisung', 'dauerauftrag']);
      expect(zahlungstagMax, 28);
      expect(beitragsfreiWerte, {'buergergeld', 'sozialamt', 'alg1', 'krankengeld'});
      expect(finanzielleSituationWerte, containsAll(beitragsfreiWerte));
      expect(finanzielleSituationWerte, contains('nein'));
    });
  });

  group('Rümpfe an member/update_personal_data.php', () {
    test('updatePersonalData schickt optionale Felder nur, wenn übergeben', () {
      final body = ApiService.personalDataBody(
        vorname: 'Anna',
        nachname: 'Probe',
        strasse: 'Hauptstraße',
        hausnummer: '1',
        plz: '89073',
        ort: 'Ulm',
      );
      expect(body.keys.toSet(), {'vorname', 'nachname', 'strasse', 'hausnummer', 'plz', 'ort'});
      expect(body.containsKey('telefon_mobil'), isFalse);
      expect(body.containsKey('telefon_fix'), isFalse);
      expect(body.containsKey('vorname2'), isFalse);
    });

    test('ein übergebener Leerstring heißt weiterhin „leeren"', () {
      final body = ApiService.personalDataBody(
        vorname: 'Anna',
        nachname: 'Probe',
        strasse: 'Hauptstraße',
        hausnummer: '1',
        plz: '89073',
        ort: 'Ulm',
        telefonFix: '',
        vorname2: 'Lena',
      );
      expect(body['telefon_fix'], '');
      expect(body['vorname2'], 'Lena');
    });

    test('updateMitgliedsart schickt genau einen Schlüssel', () {
      expect(ApiService.mitgliedsartBody('foerdermitglied'), {'mitgliedsart': 'foerdermitglied'});
    });

    test('Mitglieds-Tab speichert Stufe 2 über updateMitgliedsart', () {
      final tab = quelle('lib/widgets/verifizierung_tab.dart');
      final stufe2 = rumpf(tab, 'Future<void> _saveStufe2() async');
      expect(stufe2, contains('updateMitgliedsart('));
      expect(stufe2, isNot(contains('updatePersonalData(')));
    });
  });

  group('Kein Hochladen mehr', () {
    test('der Ablauf kennt keinen Hochlade-Schritt; ein alter Entwurf landet bei Stufe 3', () {
      expect(WizardStep.values.map((s) => s.name), isNot(contains('stufe3Upload')));
      expect(wizardStepFromName('3_upload'), WizardStep.stufe3);
    });

    test('nirgends wird noch ein Bescheid hochgeladen', () {
      final stufe3 = quelle('lib/screens/wizard_stufe_3_screen.dart');
      expect(stufe3, isNot(contains('uploadLeistungsbescheid')));
      expect(stufe3, isNot(contains('FilePicker')));
      expect(stufe3, isNot(contains('ImagePicker')));
      expect(stufe3, isNot(contains('wizardStufe3UploadRequired')));
      expect(quelle('lib/services/wizard_service.dart'), isNot(contains('upload_leistungsbescheid')));
      expect(quelle('lib/services/api_service.dart'), isNot(contains('upload_leistungsbescheid')));
      final tab = quelle('lib/widgets/verifizierung_tab.dart');
      expect(tab, isNot(contains('_pickLeistungsbescheid')));
      expect(tab, isNot(contains('uploadLeistungsbescheid')));
    });
  });

  group('Die Schritte benutzen die gemeinsamen Listen', () {
    test('Stufe 2 bietet nur mitgliedsartWaehlbar an', () {
      final s = quelle('lib/screens/wizard_stufe_2_screen.dart');
      expect(s, contains('for (final key in mitgliedsartWaehlbar)'));
      expect(s, isNot(contains("'ehrenmitglied'")));
    });

    test('Stufe 1c speichert Codes und die sieben Familienstände', () {
      final s = quelle('lib/screens/wizard_stufe_1c_screen.dart');
      expect(s, contains('for (final key in geschlechtWerte)'));
      expect(s, contains('for (final key in familienstandWerte)'));
      expect(s, isNot(contains("'maennlich'")));
    });

    test('Stufe 1f prüft mit telefonPruefen und schickt das Festnetz mit', () {
      final s = quelle('lib/screens/wizard_stufe_1f_screen.dart');
      expect(s, contains('telefonPruefen('));
      expect(s, contains("'telefon_fix':"));
    });

    test('Stufe 1a schickt den zweiten Vornamen mit', () {
      expect(quelle('lib/screens/wizard_stufe_1a_screen.dart'), contains("'vorname2':"));
    });

    test('Stufe 4: ohne SEPA, Zahltag bis zahlungstagMax', () {
      final s = quelle('lib/screens/wizard_stufe_4_screen.dart');
      expect(s, contains('for (final key in zahlungsmethodeWaehlbar)'));
      expect(s, contains('List.generate(zahlungstagMax'));
      expect(s, isNot(contains("'sepa_lastschrift'")));
    });
  });
}
