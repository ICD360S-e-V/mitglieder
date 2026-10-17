import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/widgets/verifizierung_tab.dart';

/// „① Persönliche Daten“ steht offen, wenn eine Bestätigung fällig ist.
///
/// Hinweis des Vorsitzenden, 17.10.2026: „in aplicatia mitglieder … este in
/// header la iconita omulet apoi la verifizierung apoi la stufe 1“ — und Stufe 1
/// war zu. Wer den Code aus der Mail abtippt, musste sie erst aufmachen, bevor
/// die Karte „Stimmen diese Angaben noch?“ überhaupt zu sehen war. Der Server
/// hier ist ein Ersatz, der antwortet wie verifizierung_list.php und
/// kontakt_bestaetigen.php — nur im Test.
void main() {
  late _Server server;

  setUp(() {
    server = _Server();
    ApiService().testClient = server.client;
  });

  ExpansionTile stufe1(WidgetTester tester) =>
      tester.widget<ExpansionTile>(find.widgetWithText(ExpansionTile, '① Persönliche Daten'));

  testWidgets('E-Mail fällig: Stufe 1 ist offen, die Karte steht oben', (tester) async {
    server.email = _faellig;
    await _zeigen(tester);

    expect(stufe1(tester).initiallyExpanded, isTrue);
    expect(find.text('Stimmen diese Angaben noch?'), findsOneWidget);
    expect(find.text('Vorname *'), findsOneWidget, reason: 'Der Rest der Stufe steht darunter wie immer.');
  });

  testWidgets('nur die Nummer fällig: Stufe 1 ist auch offen', (tester) async {
    server.telefon = _faellig;
    await _zeigen(tester);

    expect(stufe1(tester).initiallyExpanded, isTrue);
    expect(find.text('Stimmen diese Angaben noch?'), findsOneWidget);
  });

  testWidgets('nichts fällig: Stufe 1 bleibt zu wie bisher', (tester) async {
    await _zeigen(tester);

    expect(stufe1(tester).initiallyExpanded, isFalse);
    expect(find.text('Vorname *'), findsNothing);
    expect(find.text('Stimmen diese Angaben noch?'), findsNothing);
  });

  testWidgets('der Status scheitert: der Reiter kommt trotzdem, Stufe 1 zu', (tester) async {
    server.statusKaputt = true;
    await _zeigen(tester);

    expect(stufe1(tester).initiallyExpanded, isFalse);
    expect(find.byIcon(Icons.error_outline), findsNothing, reason: 'Kein Fehler im Reiter — nur Stufe 1 bleibt zu.');
  });

  testWidgets('nur Stufe 1 — die anderen Stufen bleiben zu', (tester) async {
    server.email = _faellig;
    await _zeigen(tester);

    final offen = tester
        .widgetList<ExpansionTile>(find.byType(ExpansionTile))
        .where((t) => t.initiallyExpanded)
        .toList();
    expect(offen, hasLength(1));
  });
}

Future<void> _zeigen(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    locale: const Locale('de'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light,
    home: const Scaffold(body: VerifizierungTab(mitgliedernummer: 'M10011')),
  ));
  await tester.pumpAndSettle();
}

const _faellig = {
  'wert': 'anna@beispiel.de',
  'vorhanden': true,
  'bestaetigt_am': null,
  'faellig': true,
  'code_offen': false,
  'code_bis': null,
  'versuche_uebrig': null,
  'sms_moeglich': true,
};

const _bestaetigt = {
  'wert': 'anna@beispiel.de',
  'vorhanden': true,
  'bestaetigt_am': '2026-10-10 12:00:00',
  'faellig': false,
  'code_offen': false,
  'code_bis': null,
  'versuche_uebrig': null,
};

/// Antwortet wie verifizierung_list.php, staatsangehoerigkeiten_list.php und
/// kontakt_bestaetigen.php. ⚠️ Kein expect() hier drin (siehe
/// kontakt_bestaetigung_test.dart); ein unbekannter Pfad bekommt 404.
class _Server {
  Map<String, dynamic> email = _bestaetigt;
  Map<String, dynamic> telefon = _bestaetigt;
  bool statusKaputt = false;

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
          if (statusKaputt) return http.Response('kaputt', 500);
          return _json({'success': true, 'email': email, 'telefon': telefon, 'gueltig_tage': 90});
        }
        return http.Response('falscher Pfad', 404);
      });

  static http.Response _json(Map<String, dynamic> j) => http.Response(
        jsonEncode(j),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
}
