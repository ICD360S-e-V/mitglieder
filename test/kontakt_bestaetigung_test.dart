import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/widgets/kontakt_bestaetigung.dart';

/// „Kontaktdaten bestätigen" mit einem Code, der schon unterwegs ist.
///
/// Meldung des Vorsitzenden, 17.10.2026: „membrii primesc mailuri cu coduri …
/// si ghici codul e invalid". Die Erinnerungsmail des Vereins bringt einen Code
/// (7 Tage) und sagte „tippen Sie auf „Bestätigen“ und geben Sie diesen Code
/// ein“. „Bestätigen" forderte aber einen NEUEN Code an — und bis zum
/// 17.10.2026 löschte der Server dabei den aus der Mail. Wer der Mail folgte,
/// las „Der Code stimmt nicht“.
///
/// Jetzt meldet der Server den Code der Mail als `code_offen`, und die Karte
/// zeigt dann gleich das Eingabefeld. Der Server hier ist ein Ersatz, der
/// antwortet wie `member/kontakt_bestaetigen.php` — nur im Test.
void main() {
  late _Server server;

  setUp(() {
    server = _Server();
    ApiService().testClient = server.client;
  });

  testWidgets('Code aus der Erinnerungsmail: das Feld steht sofort da, kein neuer Code',
      (tester) async {
    server.email = _offen(code: true);
    var bestaetigt = 0;
    await _zeigen(tester, onBestaetigt: () => bestaetigt++);

    expect(find.byType(TextField), findsOneWidget,
        reason: 'Das Eingabefeld gehört nach vorn — die Mail sagt „geben Sie den Code ein“.');
    expect(find.text('Wir haben Ihnen eine E-Mail geschickt.'), findsOneWidget);
    expect(server.aktionen, ['status'], reason: 'Kein code_anfordern: das wäre eine zweite Mail mit anderem Code.');

    await tester.enterText(find.byType(TextField), _Server.richtig);
    await tester.pumpAndSettle();

    expect(server.letzte('code_pruefen'), {'aktion': 'code_pruefen', 'kanal': 'email', 'code': _Server.richtig});
    expect(bestaetigt, 1);
    expect(find.byType(Card), findsNothing, reason: 'Bestätigt und nichts mehr fällig: die Karte verschwindet.');
  });

  testWidgets('ohne offenen Code fordert „Bestätigen“ einen an — wie bisher', (tester) async {
    server.email = _offen(code: false);
    await _zeigen(tester);

    expect(find.byType(TextField), findsNothing);
    await tester.tap(find.widgetWithText(TextButton, 'Bestätigen'));
    await tester.pumpAndSettle();

    expect(server.letzte('code_anfordern'), {'aktion': 'code_anfordern', 'kanal': 'email'});
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Wir haben Ihnen eine E-Mail geschickt an a***@beispiel.de.'), findsOneWidget);
  });

  testWidgets('„Abbrechen“, dann „Bestätigen“: wieder das Feld, kein neuer Code', (tester) async {
    server.email = _offen(code: true);
    await _zeigen(tester);

    await tester.tap(find.widgetWithText(TextButton, 'Abbrechen'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Bestätigen'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);
    expect(server.aktionen, ['status'], reason: 'Der Code aus der Mail gilt — kein zweiter.');
  });

  testWidgets('„Code erneut senden“ fordert einen neuen an', (tester) async {
    server.email = _offen(code: true);
    await _zeigen(tester);

    await tester.tap(find.widgetWithText(TextButton, 'Code erneut senden'));
    await tester.pumpAndSettle();

    expect(server.letzte('code_anfordern'), {'aktion': 'code_anfordern', 'kanal': 'email'});
    expect(find.text('Wir haben Ihnen eine E-Mail geschickt an a***@beispiel.de.'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('ein falscher Code zeigt die Meldung des Servers, das Feld bleibt', (tester) async {
    server.email = _offen(code: true);
    await _zeigen(tester);

    await tester.enterText(find.byType(TextField), '000000');
    await tester.pumpAndSettle();

    expect(find.text('Der Code stimmt nicht. Noch 4 Versuche.'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('nur die Nummer hat einen Code: das Feld für die SMS', (tester) async {
    server.email = _bestaetigt();
    server.telefon = _offen(code: true, wert: '+4917612345611');
    await _zeigen(tester);

    expect(find.text('Wir haben Ihnen eine SMS geschickt.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), _Server.richtig);
    await tester.pumpAndSettle();
    expect(server.letzte('code_pruefen'), {'aktion': 'code_pruefen', 'kanal': 'telefon', 'code': _Server.richtig});
  });

  testWidgets('beide mit Code: erst die Mail, nach der Bestätigung die SMS', (tester) async {
    server.email = _offen(code: true);
    server.telefon = _offen(code: true, wert: '+4917612345611');
    await _zeigen(tester);

    expect(find.text('Wir haben Ihnen eine E-Mail geschickt.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), _Server.richtig);
    await tester.pumpAndSettle();

    expect(find.text('Wir haben Ihnen eine SMS geschickt.'), findsOneWidget);
    expect(server.aktionen.where((a) => a == 'code_anfordern'), isEmpty);
  });

  testWidgets('zugemacht bleibt zu, auch wenn die Karte neu lädt', (tester) async {
    server.email = _offen(code: true);
    server.telefon = _offen(code: true, wert: '+4917612345611');
    await _zeigen(tester);

    await tester.tap(find.widgetWithText(TextButton, 'Abbrechen'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Bestätigen').last);   // die Nummer
    await tester.pumpAndSettle();
    expect(find.text('Wir haben Ihnen eine SMS geschickt.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), _Server.richtig);
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNothing,
        reason: 'Die Mail hat das Mitglied selbst zugemacht — nach dem Neuladen springt sie nicht wieder auf.');
    expect(find.widgetWithText(TextButton, 'Bestätigen'), findsOneWidget);
  });

  testWidgets('passt auf ein schmales Telefon mit großer Schrift (277 dp, 130 %)', (tester) async {
    server.email = _offen(code: true);
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(277, 616) * 2.0;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await _zeigen(tester);

    expect(tester.takeException(), isNull);
    expect(find.widgetWithText(TextButton, 'Code erneut senden'), findsOneWidget);
  });
}

Future<void> _zeigen(WidgetTester tester, {VoidCallback? onBestaetigt}) async {
  await tester.pumpWidget(MaterialApp(
    locale: const Locale('de'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light,
    home: Scaffold(
      body: SingleChildScrollView(
        child: KontaktBestaetigung(apiService: ApiService(), onBestaetigt: onBestaetigt),
      ),
    ),
  ));
  await tester.pumpAndSettle();
}

Map<String, dynamic> _offen({required bool code, String wert = 'anna@beispiel.de'}) => {
      'wert': wert,
      'vorhanden': true,
      'bestaetigt_am': null,
      'faellig': true,
      'code_offen': code,
      'code_bis': code ? '2026-10-24 10:00:00' : null,
      'versuche_uebrig': code ? 5 : null,
      'sms_moeglich': true,
    };

Map<String, dynamic> _bestaetigt() => {
      'wert': 'anna@beispiel.de',
      'vorhanden': true,
      'bestaetigt_am': '2026-10-10 12:00:00',
      'faellig': false,
      'code_offen': false,
      'code_bis': null,
      'versuche_uebrig': null,
    };

/// Antwortet wie member/kontakt_bestaetigen.php und schreibt jede Anfrage mit.
class _Server {
  static const richtig = '482913';
  Map<String, dynamic> email = _bestaetigt();
  Map<String, dynamic> telefon = _bestaetigt();
  final anfragen = <Map<String, dynamic>>[];

  List<String> get aktionen => [for (final a in anfragen) a['aktion'] as String];
  Map<String, dynamic>? letzte(String aktion) => anfragen.lastWhere((a) => a['aktion'] == aktion, orElse: () => {});

  // ⚠️ Kein expect() hier drin: der Ersatz antwortet, während tester.enterText
  // noch läuft, und flutter_test wirft dann „Guarded function conflict“ — die
  // Anfrage schiene nie angekommen. Ein falscher Pfad bekommt 404.
  http.Client get client => MockClient((r) async {
        if (!r.url.path.endsWith('/member/kontakt_bestaetigen.php')) return http.Response('falscher Pfad', 404);
        final b = jsonDecode(r.body) as Map<String, dynamic>;
        anfragen.add(b);
        switch (b['aktion']) {
          case 'status':
            return _json({'success': true, 'email': email, 'telefon': telefon, 'gueltig_tage': 90});
          case 'code_anfordern':
            final kanal = b['kanal'] as String;
            if (kanal == 'email') email = {...email, 'code_offen': true};
            if (kanal == 'telefon') telefon = {...telefon, 'code_offen': true};
            return _json({
              'success': true,
              'kanal': kanal,
              'ziel_kurz': kanal == 'email' ? 'a***@beispiel.de' : '…5611',
              'minuten': 30,
            });
          case 'code_pruefen':
            if (b['code'] != richtig) {
              return _json({'success': false, 'message': 'Der Code stimmt nicht. Noch 4 Versuche.', 'versuche_uebrig': 4}, 400);
            }
            if (b['kanal'] == 'email') email = _bestaetigt();
            if (b['kanal'] == 'telefon') telefon = {..._bestaetigt(), 'wert': '+4917612345611'};
            return _json({'success': true, 'kanal': b['kanal'], 'message': 'Bestätigt'});
        }
        return _json({'success': false, 'message': 'Unbekannte Aktion'}, 400);
      });

  static http.Response _json(Map<String, dynamic> j, [int status = 200]) => http.Response(
        jsonEncode(j),
        status,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
}
