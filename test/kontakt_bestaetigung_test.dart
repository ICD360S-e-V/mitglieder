import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/services/kontakt_link.dart';
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

  // ── Der Link in der Mail (KontaktLink) ─────────────────────────────────
  // „… un link care sa duca in aplicatie si codul sa se completeze automat“.

  group('Code aus dem Link', () {
    const ausMail = KontaktCodeAusLink('email', _Server.richtig);

    testWidgets('wird eingetragen und gleich geprüft — ohne Tippen', (tester) async {
      server.email = _offen(code: true);
      var bestaetigt = 0;
      await _zeigen(tester, codeAusLink: ausMail, nurWennFaellig: false, onBestaetigt: () => bestaetigt++);

      // Kein code_anfordern: der Link bringt den Code schon mit. Nach der
      // Bestätigung lädt die Karte ihren Stand neu.
      expect(server.aktionen, ['status', 'code_pruefen', 'status']);
      expect(server.letzte('code_pruefen'), {'aktion': 'code_pruefen', 'kanal': 'email', 'code': _Server.richtig});
      expect(bestaetigt, 1);
    });

    testWidgets('schon bestätigt: nichts geprüft, „bestätigt am …“ statt eines Fehlers', (tester) async {
      server.email = _bestaetigt();
      server.telefon = {..._bestaetigt(), 'wert': '+4917612345611', 'bestaetigt_am': '2026-09-01 08:00:00'};
      await _zeigen(tester, codeAusLink: ausMail, nurWennFaellig: false);

      expect(server.aktionen, ['status'], reason: 'Ein zweites Öffnen des Links darf keinen Fehlversuch zählen.');
      expect(find.text('bestätigt am 10.10.2026'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('falscher Code: Meldung des Servers, das Feld bleibt, kein zweiter Versuch von selbst',
        (tester) async {
      server.email = _offen(code: true);
      await _zeigen(tester, codeAusLink: const KontaktCodeAusLink('email', '000000'), nurWennFaellig: false);

      expect(find.text('Der Code stimmt nicht. Noch 4 Versuche.'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Code erneut senden'), findsOneWidget);
      expect(server.aktionen.where((a) => a == 'code_pruefen'), hasLength(1));
    });

    testWidgets('Link für die Mail: kein SMS-Feld springt dazwischen auf', (tester) async {
      server.email = _bestaetigt();
      server.telefon = _offen(code: true, wert: '+4917612345611');
      await _zeigen(tester, codeAusLink: ausMail, nurWennFaellig: false);

      expect(find.byType(TextField), findsNothing);
      expect(find.text('Wir haben Ihnen eine SMS geschickt.'), findsNothing);
      expect(server.aktionen, ['status']);
    });
  });

  group('Fenster für den Link (KontaktCodeDialog)', () {
    setUp(() => KontaktLink.instance.abholen());

    Future<void> oeffnen(WidgetTester tester) async {
      await tester.pumpWidget(_app(Builder(
        builder: (context) => TextButton(
          onPressed: () => KontaktCodeDialog.offenenZeigen(context, ApiService()),
          child: const Text('los'),
        ),
      )));
      await tester.tap(find.text('los'));
      await tester.pumpAndSettle();
    }

    testWidgets('bestätigt, geht zu, die grüne Meldung steht darunter', (tester) async {
      server.email = _offen(code: true);
      KontaktLink.instance.aufnehmen(Uri.parse('https://icd360sev.icd360s.de/code/#email=${_Server.richtig}'));
      await oeffnen(tester);

      expect(server.letzte('code_pruefen'), {'aktion': 'code_pruefen', 'kanal': 'email', 'code': _Server.richtig});
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Daten erfolgreich gespeichert'), findsOneWidget);
      expect(KontaktLink.instance.offen.value, isNull, reason: 'Abgeholt — ein zweites Fenster gibt es nicht.');
    });

    testWidgets('falscher Code: bleibt offen, mit „Schließen“', (tester) async {
      server.email = _offen(code: true);
      KontaktLink.instance.aufnehmen(Uri.parse('https://icd360sev.icd360s.de/code/#email=000000'));
      await oeffnen(tester);

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Der Code stimmt nicht. Noch 4 Versuche.'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, 'Schließen'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('ohne wartenden Code kein Fenster und keine Anfrage', (tester) async {
      await oeffnen(tester);

      expect(find.byType(AlertDialog), findsNothing);
      expect(server.anfragen, isEmpty);
    });

    testWidgets('passt auf ein schmales Telefon mit großer Schrift (277 dp, 130 %)', (tester) async {
      server.email = _offen(code: true);
      tester.view.devicePixelRatio = 2.0;
      tester.view.physicalSize = const Size(277, 616) * 2.0;
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      KontaktLink.instance.aufnehmen(Uri.parse('https://icd360sev.icd360s.de/code/#email=000000'));
      await oeffnen(tester);

      expect(tester.takeException(), isNull);
      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}

Future<void> _zeigen(
  WidgetTester tester, {
  VoidCallback? onBestaetigt,
  KontaktCodeAusLink? codeAusLink,
  bool nurWennFaellig = true,
}) async {
  await tester.pumpWidget(_app(
    SingleChildScrollView(
      child: KontaktBestaetigung(
        apiService: ApiService(),
        onBestaetigt: onBestaetigt,
        codeAusLink: codeAusLink,
        nurWennFaellig: nurWennFaellig,
      ),
    ),
  ));
  await tester.pumpAndSettle();
}

Widget _app(Widget body) => MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      home: Scaffold(body: body),
    );

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
