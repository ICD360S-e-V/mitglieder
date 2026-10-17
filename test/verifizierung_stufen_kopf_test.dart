import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/widgets/verifizierung_tab.dart';

/// Der Kopf jeder Stufe im Reiter „Verifizierung“: Name und Abzeichen
/// („Ausgefüllt“, „Gesperrt“, „Entfällt“).
///
/// Hinweis des Vorsitzenden, 17.10.2026 („da repara si eticheta“): auf einem
/// schmalen Telefon mit großer Schrift nahm das Abzeichen — als `trailing` der
/// Kachel — fast die ganze Zeile ein; vom Namen blieben ein paar Buchstaben,
/// und in der Testumgebung warf Flutter sogar „Trailing widget consumes the
/// entire tile width“. Jetzt steht es rechts, solange beides passt, sonst unter
/// dem Namen. Der Server hier ist ein Ersatz — nur im Test.
void main() {
  late _Server server;

  setUp(() {
    server = _Server();
    ApiService().testClient = server.client;
  });

  void schmal(WidgetTester tester) {
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(277, 616) * 2.0;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  }

  /// Name und Abzeichen im Kopf einer Stufe.
  (Rect, Rect) kopf(WidgetTester tester, String name, String abzeichen) {
    final kachel = find.ancestor(of: find.text(name), matching: find.byType(ListTile)).first;
    return (
      tester.getRect(find.text(name)),
      tester.getRect(find.descendant(of: kachel, matching: find.text(abzeichen))),
    );
  }

  testWidgets('schmales Telefon, große Schrift: nichts läuft über, das Abzeichen steht unter dem Namen',
      (tester) async {
    schmal(tester);
    await _zeigen(tester);

    expect(tester.takeException(), isNull);
    for (final (name, abzeichen) in [
      ('① Persönliche Daten', 'Ausgefüllt'),
      ('② Mitgliedsart', 'Ausgefüllt'),
      ('③ Finanzielle Situation', 'Offen'),
      ('④ Zahlungsmethode', 'Gesperrt'),
      ('⑤ Mitgliedschaftsbeginn', 'Gesperrt'),
    ]) {
      final (n, a) = kopf(tester, name, abzeichen);
      expect(a.top, greaterThanOrEqualTo(n.bottom - 1), reason: '$name: das Abzeichen „$abzeichen“ steht darunter');
    }
  });

  testWidgets('schmales Telefon: „Entfällt“ (Stufe 4 bei Minderjährigen) läuft auch nicht über', (tester) async {
    server.geburtsdatum = '2015-01-01';
    schmal(tester);
    await _zeigen(tester);

    expect(tester.takeException(), isNull);
    final (n, a) = kopf(tester, '④ Zahlungsmethode', 'Entfällt');
    expect(a.top, greaterThanOrEqualTo(n.bottom - 1));
  });

  testWidgets('breiter Bildschirm: das Abzeichen bleibt rechts in derselben Zeile', (tester) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1280, 900);
    addTearDown(tester.view.reset);
    await _zeigen(tester);

    expect(tester.takeException(), isNull);
    final kachel = tester.getRect(find.widgetWithText(ExpansionTile, '① Persönliche Daten'));
    final (n, a) = kopf(tester, '① Persönliche Daten', 'Ausgefüllt');
    expect((a.center.dy - n.center.dy).abs(), lessThan(4), reason: 'eine Zeile');
    expect(a.left, greaterThan(n.right));
    // Ganz rechts, nur der Pfeil der Kachel (24 dp + Abstände) steht noch dahinter.
    expect(kachel.right - a.right, lessThan(80));
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

/// Antwortet wie verifizierung_list.php, staatsangehoerigkeiten_list.php und
/// kontakt_bestaetigen.php (nichts fällig). ⚠️ Kein expect() hier drin; ein
/// anderer Pfad bekommt 404.
class _Server {
  String geburtsdatum = '1980-05-01';

  http.Client get client => MockClient((r) async {
        final pfad = r.url.path;
        if (pfad.endsWith('/member/verifizierung_list.php')) {
          return _json({
            'success': true,
            'data': {
              'stufen': [
                {'stufe': 1, 'status': 'ausgefuellt'},
                {'stufe': 2, 'status': 'ausgefuellt'},
                {'stufe': 3, 'status': 'offen'},
              ],
              'personal_data': {
                'vorname': 'Anna',
                'nachname': 'Probe',
                'email': 'anna@beispiel.de',
                'geburtsdatum': geburtsdatum,
              },
              'document_acceptances': <String, dynamic>{},
            },
          });
        }
        if (pfad.endsWith('/member/staatsangehoerigkeiten_list.php')) {
          return _json({'success': true, 'data': <dynamic>[]});
        }
        if (pfad.endsWith('/member/kontakt_bestaetigen.php')) {
          const bestaetigt = {
            'wert': 'anna@beispiel.de',
            'vorhanden': true,
            'bestaetigt_am': '2026-10-10 12:00:00',
            'faellig': false,
            'code_offen': false,
            'code_bis': null,
            'versuche_uebrig': null,
          };
          return _json({'success': true, 'email': bestaetigt, 'telefon': bestaetigt, 'gueltig_tage': 90});
        }
        return http.Response('falscher Pfad', 404);
      });

  static http.Response _json(Map<String, dynamic> j) => http.Response(
        jsonEncode(j),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
}
