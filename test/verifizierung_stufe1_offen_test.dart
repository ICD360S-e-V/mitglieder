import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/services/kontakt_link.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_profile_dialog.dart';
import 'package:icd360sev_mitglied/widgets/verifizierung_tab.dart';

/// „① Persönliche Daten“ steht offen, wenn eine Bestätigung fällig ist — und
/// der Link aus der Mail führt genau dorthin.
///
/// Hinweis des Vorsitzenden, 17.10.2026: „in aplicatia mitglieder … este in
/// header la iconita omulet apoi la verifizierung apoi la stufe 1“ — und Stufe 1
/// war zu. Dann: „se deschide aplicatia singura se duce la omulet apoi
/// verifizierung apoi stufe 1 apoi la verifizierung email si aici ar trebui sa
/// apara codul automat“. Der Server hier ist ein Ersatz, der antwortet wie
/// verifizierung_list.php und kontakt_bestaetigen.php — nur im Test.
void main() {
  late _Server server;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    server = _Server();
    ApiService().testClient = server.client;
  });

  ExpansionTile stufe1(WidgetTester tester) =>
      tester.widget<ExpansionTile>(find.widgetWithText(ExpansionTile, '① Persönliche Daten'));

  group('Stufe 1 bei fälliger Bestätigung', () {
    testWidgets('E-Mail fällig: Stufe 1 ist offen, die Karte steht oben', (tester) async {
      server.email = _faellig();
      await _zeigen(tester, const VerifizierungTab(mitgliedernummer: 'M10011'));

      expect(stufe1(tester).initiallyExpanded, isTrue);
      expect(find.text('Stimmen diese Angaben noch?'), findsOneWidget);
      expect(find.text('Vorname *'), findsOneWidget, reason: 'Der Rest der Stufe steht darunter wie immer.');
    });

    testWidgets('nur die Nummer fällig: Stufe 1 ist auch offen', (tester) async {
      server.telefon = _faellig();
      await _zeigen(tester, const VerifizierungTab(mitgliedernummer: 'M10011'));

      expect(stufe1(tester).initiallyExpanded, isTrue);
      expect(find.text('Stimmen diese Angaben noch?'), findsOneWidget);
    });

    testWidgets('nichts fällig: Stufe 1 bleibt zu wie bisher', (tester) async {
      await _zeigen(tester, const VerifizierungTab(mitgliedernummer: 'M10011'));

      expect(stufe1(tester).initiallyExpanded, isFalse);
      expect(find.text('Vorname *'), findsNothing);
      expect(find.text('Stimmen diese Angaben noch?'), findsNothing);
    });

    testWidgets('der Status scheitert: der Reiter kommt trotzdem, Stufe 1 zu', (tester) async {
      server.statusKaputt = true;
      await _zeigen(tester, const VerifizierungTab(mitgliedernummer: 'M10011'));

      expect(stufe1(tester).initiallyExpanded, isFalse);
      expect(find.byIcon(Icons.error_outline), findsNothing, reason: 'Kein Fehler im Reiter — nur Stufe 1 bleibt zu.');
    });

    testWidgets('nur Stufe 1 — die anderen Stufen bleiben zu', (tester) async {
      server.email = _faellig();
      await _zeigen(tester, const VerifizierungTab(mitgliedernummer: 'M10011'));

      final offen = tester
          .widgetList<ExpansionTile>(find.byType(ExpansionTile))
          .where((t) => t.initiallyExpanded)
          .toList();
      expect(offen, hasLength(1));
    });
  });

  group('der Code aus dem Link landet in Stufe 1', () {
    const ausMail = KontaktCodeAusLink('email', _Server.richtig);

    testWidgets('Stufe 1 offen, Code eingetragen und geprüft — danach „bestätigt am …“ an seinem Ort',
        (tester) async {
      server.email = _faellig(code: true);
      await _zeigen(tester, const VerifizierungTab(mitgliedernummer: 'M10011', codeAusLink: ausMail));

      expect(server.letzte('code_pruefen'), {'aktion': 'code_pruefen', 'kanal': 'email', 'code': _Server.richtig});
      expect(server.anzahl('code_anfordern'), 0, reason: 'Der Link bringt den Code mit — kein neuer.');
      expect(stufe1(tester).initiallyExpanded, isTrue, reason: 'Nach dem Neuladen bleibt Stufe 1 offen.');
      expect(find.text('bestätigt am 17.10.2026'), findsOneWidget);
    });

    testWidgets('schon bestätigt: Stufe 1 offen mit „bestätigt am …“, nichts geprüft', (tester) async {
      server.email = _bestaetigt('2026-10-10 12:00:00');
      server.telefon = {..._bestaetigt('2026-09-01 08:00:00'), 'wert': '+4917612345611'};
      await _zeigen(tester, const VerifizierungTab(mitgliedernummer: 'M10011', codeAusLink: ausMail));

      expect(stufe1(tester).initiallyExpanded, isTrue);
      expect(find.text('bestätigt am 10.10.2026'), findsOneWidget);
      expect(server.anzahl('code_pruefen'), 0, reason: 'Ein zweites Öffnen des Links zählt keinen Fehlversuch.');
    });

    testWidgets('falscher Code: die Meldung des Servers und das Feld, in Stufe 1', (tester) async {
      server.email = _faellig(code: true);
      await _zeigen(tester,
          const VerifizierungTab(mitgliedernummer: 'M10011', codeAusLink: KontaktCodeAusLink('email', '000000')));

      expect(stufe1(tester).initiallyExpanded, isTrue);
      expect(find.text('Der Code stimmt nicht. Noch 4 Versuche.'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Code erneut senden'), findsOneWidget);
    });

    testWidgets('das Profil öffnet sich gleich auf „Verifizierung“, der Code steht in Stufe 1', (tester) async {
      server.email = _faellig(code: true);
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(1280, 900);
      addTearDown(tester.view.reset);
      await _zeigen(
        tester,
        MitgliedProfileDialog(
          userName: 'Anna Probe',
          mitgliedernummer: 'M10011',
          email: 'anna@beispiel.de',
          status: 'active',
          apiService: ApiService(),
          onEmailChanged: (_) {},
          codeAusLink: ausMail,
        ),
      );

      final reiter = tester.widget<TabBar>(find.byType(TabBar));
      expect(reiter.controller!.index, MitgliedProfileDialog.reiterVerifizierung);
      expect(find.byType(VerifizierungTab), findsOneWidget);
      expect(server.letzte('code_pruefen'), {'aktion': 'code_pruefen', 'kanal': 'email', 'code': _Server.richtig});
      expect(find.text('bestätigt am 17.10.2026'), findsOneWidget);
    });

    testWidgets('ohne Link öffnet sich das Profil wie bisher auf dem ersten Reiter', (tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(1280, 900);
      addTearDown(tester.view.reset);
      await _zeigen(
        tester,
        MitgliedProfileDialog(
          userName: 'Anna Probe',
          mitgliedernummer: 'M10011',
          email: 'anna@beispiel.de',
          status: 'active',
          apiService: ApiService(),
          onEmailChanged: (_) {},
        ),
      );

      expect(tester.widget<TabBar>(find.byType(TabBar)).controller!.index, 0);
      expect(server.anzahl('code_pruefen'), 0);
    });
  });
}

Future<void> _zeigen(WidgetTester tester, Widget kind) async {
  await tester.pumpWidget(MaterialApp(
    locale: const Locale('de'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light,
    home: Scaffold(body: kind),
  ));
  await tester.pumpAndSettle();
}

Map<String, dynamic> _faellig({bool code = false}) => {
      'wert': 'anna@beispiel.de',
      'vorhanden': true,
      'bestaetigt_am': null,
      'faellig': true,
      'code_offen': code,
      'code_bis': code ? '2026-10-24 10:00:00' : null,
      'versuche_uebrig': code ? 5 : null,
      'sms_moeglich': true,
    };

Map<String, dynamic> _bestaetigt(String am) => {
      'wert': 'anna@beispiel.de',
      'vorhanden': true,
      'bestaetigt_am': am,
      'faellig': false,
      'code_offen': false,
      'code_bis': null,
      'versuche_uebrig': null,
    };

/// Antwortet wie verifizierung_list.php, staatsangehoerigkeiten_list.php und
/// kontakt_bestaetigen.php und schreibt die Aktionen mit. ⚠️ Kein expect()
/// hier drin (siehe kontakt_bestaetigung_test.dart); jeder andere Pfad — das
/// Profil fragt noch nach Sitzungen, Geräten … — bekommt 404.
class _Server {
  static const richtig = '482913';
  Map<String, dynamic> email = _bestaetigt('2026-10-10 12:00:00');
  Map<String, dynamic> telefon = _bestaetigt('2026-10-10 12:00:00');
  bool statusKaputt = false;
  final anfragen = <Map<String, dynamic>>[];

  Map<String, dynamic>? letzte(String aktion) => anfragen.lastWhere((a) => a['aktion'] == aktion, orElse: () => {});
  int anzahl(String aktion) => anfragen.where((a) => a['aktion'] == aktion).length;

  http.Client get client => MockClient((r) async {
        final pfad = r.url.path;
        if (pfad.endsWith('/member/verifizierung_list.php')) {
          return _json({
            'success': true,
            'data': {
              'stufen': [
                {'stufe': 1, 'status': 'ausgefuellt'},
                {'stufe': 2, 'status': 'ausgefuellt'},
              ],
              'personal_data': {'vorname': 'Anna', 'nachname': 'Probe', 'email': 'anna@beispiel.de'},
              'document_acceptances': <String, dynamic>{},
            },
          });
        }
        if (pfad.endsWith('/member/staatsangehoerigkeiten_list.php')) {
          return _json({'success': true, 'data': <dynamic>[]});
        }
        if (pfad.endsWith('/member/kontakt_bestaetigen.php')) {
          final b = jsonDecode(r.body) as Map<String, dynamic>;
          anfragen.add(b);
          if (b['aktion'] == 'status') {
            if (statusKaputt) return http.Response('kaputt', 500);
            return _json({'success': true, 'email': email, 'telefon': telefon, 'gueltig_tage': 90});
          }
          if (b['aktion'] == 'code_pruefen') {
            if (b['code'] != richtig) {
              return _json({'success': false, 'message': 'Der Code stimmt nicht. Noch 4 Versuche.', 'versuche_uebrig': 4}, 400);
            }
            email = _bestaetigt('2026-10-17 17:30:00');
            return _json({'success': true, 'kanal': b['kanal'], 'message': 'Bestätigt'});
          }
          return _json({'success': false, 'message': 'Unbekannte Aktion'}, 400);
        }
        return http.Response('falscher Pfad', 404);
      });

  static http.Response _json(Map<String, dynamic> j, [int status = 200]) => http.Response(
        jsonEncode(j),
        status,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
}
