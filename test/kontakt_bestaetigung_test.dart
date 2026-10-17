import 'dart:convert';
import 'dart:io';

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
  late DateTime jetzt;

  setUp(() {
    server = _Server();
    ApiService().testClient = server.client;
    // Feste Uhr: die Restzeit an „Code erneut senden“ läuft nur, wenn ein
    // Test sie vorstellt.
    jetzt = DateTime(2026, 10, 17, 18, 28, 53);
    KontaktBestaetigung.uhr = () => jetzt;
  });

  tearDown(() => KontaktBestaetigung.uhr = DateTime.now);

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
    expect(find.text('Wir haben Ihnen eine E-Mail an a***@beispiel.de geschickt.'), findsOneWidget);
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
    expect(find.text('Wir haben Ihnen eine E-Mail an a***@beispiel.de geschickt.'), findsOneWidget);
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

  // ── Kein deutscher Text mehr in der Karte (17.10.2026) ────────────────
  // „Wir haben Ihnen eine E-Mail/SMS geschickt …“, „Neue $titel“ (bei der
  // Nummer „Neue Telefon (Mobil)“), „nicht hinterlegt“ und „name@beispiel.de“
  // standen fest im Code — in jeder der 28 Sprachen auf Deutsch.

  group('Texte der Karte in der Sprache der App', () {
    const ro = Locale('ro');

    testWidgets('rumänisch: Code aus der Mail — „V-am trimis un e-mail.“', (tester) async {
      server.email = _offen(code: true);
      await _zeigen(tester, sprache: ro);
      expect(find.text('V-am trimis un e-mail.'), findsOneWidget);
    });

    testWidgets('rumänisch: SMS mit Ziel — „V-am trimis un SMS la …5611.“', (tester) async {
      server.email = _bestaetigt();
      server.telefon = _offen(code: false, wert: '+4917612345611');
      await _zeigen(tester, sprache: ro);
      await tester.tap(find.widgetWithText(TextButton, 'Confirmă'));
      await tester.pumpAndSettle();
      expect(find.text('V-am trimis un SMS la …5611.'), findsOneWidget);
    });

    testWidgets('rumänisch: keine Nummer — „necompletat“; Dialog für die Adresse rumänisch', (tester) async {
      server.email = _offen(code: false);
      server.telefon = {..._offen(code: false, wert: ''), 'vorhanden': false};
      await _zeigen(tester, sprache: ro);
      expect(find.text('necompletat'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();
      expect(find.text('Adresă de e-mail nouă'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'name@example.com'), findsOneWidget);
    });

    testWidgets('rumänisch: Dialog für die Nummer — „Număr de mobil nou“', (tester) async {
      server.email = _bestaetigt();
      server.telefon = _offen(code: false, wert: '+4917612345611');
      await _zeigen(tester, sprache: ro);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.text('Număr de mobil nou'), findsOneWidget);
    });

    testWidgets('deutsch: „… eine SMS an …5611 geschickt.“ und „Neue Mobilnummer“ statt „Neue Telefon (Mobil)“',
        (tester) async {
      server.email = _bestaetigt();
      server.telefon = _offen(code: false, wert: '+4917612345611');
      await _zeigen(tester);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.text('Neue Mobilnummer'), findsOneWidget);
      expect(find.text('Neue Telefon (Mobil)'), findsNothing);
      await tester.tap(find.widgetWithText(TextButton, 'Abbrechen'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(TextButton, 'Bestätigen'));
      await tester.pumpAndSettle();
      expect(find.text('Wir haben Ihnen eine SMS an …5611 geschickt.'), findsOneWidget);
    });

    test('alle 28 Sprachen haben die 8 Texte — übersetzt, mit {ziel} wo nötig', () {
      const schluessel = ['kontaktMailGeschickt', 'kontaktMailGeschicktAn', 'kontaktSmsGeschickt', 'kontaktSmsGeschicktAn',
          'kontaktNeueMailTitel', 'kontaktNeueNummerTitel', 'kontaktNichtHinterlegt', 'kontaktMailBeispiel'];
      final de = jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync()) as Map<String, dynamic>;
      final dateien = Directory('lib/l10n').listSync().whereType<File>().where((f) => f.path.endsWith('.arb')).toList();
      expect(dateien, hasLength(28));
      for (final f in dateien) {
        final arb = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in schluessel) {
          final v = arb[k] as String?;
          expect(v?.trim(), isNotEmpty, reason: '${f.path}: $k fehlt');
          expect(v!.contains('{ziel}'), k.endsWith('An'), reason: '${f.path}: $k und {ziel}');
          if (!f.path.endsWith('app_de.arb')) {
            expect(v, isNot(de[k]), reason: '${f.path}: $k ist noch deutsch');
          }
        }
      }
    });

    test('in der Karte steht kein deutscher Satz mehr im Code', () {
      final code = File('lib/widgets/kontakt_bestaetigung.dart')
          .readAsLinesSync()
          .where((z) => !z.trimLeft().startsWith('//') && !z.trimLeft().startsWith('///'))
          .join('\n');
      for (final alt in ["'Wir haben Ihnen", "'Neue \$titel'", "'nicht hinterlegt'", "'name@beispiel.de'", 'geschickt\${']) {
        expect(code.contains(alt), isFalse, reason: alt);
      }
    });
  });

  // ── Restzeit an „Code erneut senden“ (App-Fehler #130) ─────────────────
  // Ein Mitglied tippte 2 s nach dem Versand auf „Code erneut senden“ und las
  // „Bitte warten Sie 118 Sekunden …“: der Server lässt erst nach 2 Minuten
  // einen neuen Code zu. Jetzt steht die Zeit am Knopf, und er ist bis dahin
  // gesperrt.

  group('Restzeit an „Code erneut senden“', () {
    TextButton knopf(WidgetTester tester, String text) =>
        tester.widget<TextButton>(find.widgetWithText(TextButton, text));
    Future<void> vorstellen(WidgetTester tester, int sekunden) async {
      jetzt = jetzt.add(Duration(seconds: sekunden));
      await tester.pump(const Duration(seconds: 1));
    }

    testWidgets('nach dem Versand gesperrt, die Zeit läuft herunter, nach 2 Minuten wieder frei', (tester) async {
      server.email = _offen(code: false);
      await _zeigen(tester);
      await tester.tap(find.widgetWithText(TextButton, 'Bestätigen'));
      await tester.pumpAndSettle();

      expect(knopf(tester, 'Code erneut senden (2:00)').onPressed, isNull);
      await vorstellen(tester, 61);
      expect(knopf(tester, 'Code erneut senden (0:59)').onPressed, isNull);
      await vorstellen(tester, 59);
      expect(knopf(tester, 'Code erneut senden').onPressed, isNotNull);

      await tester.tap(find.widgetWithText(TextButton, 'Code erneut senden'));
      await tester.pumpAndSettle();
      expect(server.aktionen.where((a) => a == 'code_anfordern'), hasLength(2));
      expect(knopf(tester, 'Code erneut senden (2:00)').onPressed, isNull, reason: 'jeder neue Code sperrt wieder');
    });

    testWidgets('„Abbrechen“ und gleich wieder „Bestätigen“: das Feld, kein zweiter Code', (tester) async {
      server.email = _offen(code: false);
      await _zeigen(tester);
      await tester.tap(find.widgetWithText(TextButton, 'Bestätigen'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Abbrechen'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(TextButton, 'Bestätigen'));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(server.aktionen.where((a) => a == 'code_anfordern'), hasLength(1),
          reason: 'Der Code von eben gilt — der Stand der Karte wusste noch nichts von ihm.');
    });

    testWidgets('der Server sagt „warten“ (Code von vorhin): das Feld mit seiner Zeit, keine rote Meldung',
        (tester) async {
      server.email = _offen(code: false);   // Stand von vor dem Code
      server.wartenSekunden = 79;
      await _zeigen(tester);
      await tester.tap(find.widgetWithText(TextButton, 'Bestätigen'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Bitte warten Sie'), findsNothing);
      expect(find.byType(TextField), findsOneWidget, reason: 'Der Code von vorhin gilt noch (30 Minuten).');
      expect(knopf(tester, 'Code erneut senden (1:19)').onPressed, isNull);
    });

    testWidgets('neue Adresse während der Sperre: die Meldung des Servers bleibt, kein Feld für den alten Code',
        (tester) async {
      server.email = _offen(code: false);
      server.wartenSekunden = 79;
      await _zeigen(tester);
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'neu@beispiel.de');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Code per E-Mail anfordern'));
      await tester.pumpAndSettle();

      expect(server.letzte('code_anfordern'), {'aktion': 'code_anfordern', 'kanal': 'email', 'neu': 'neu@beispiel.de'});
      expect(find.text('Bitte warten Sie 79 Sekunden, bevor Sie einen neuen Code anfordern.'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
    });
  });

  // ── Neue Adresse / neue Nummer: der Knopf nennt den richtigen Weg ──────
  // Bis 17.10.2026 stand auch bei einer neuen E-Mail-Adresse „Code per SMS
  // anfordern“ — der Code geht aber per Mail an die neue Adresse.

  group('Knopf im Dialog „Neue …“', () {
    testWidgets('neue E-Mail-Adresse: „Code per E-Mail anfordern“, kein „per SMS“', (tester) async {
      server.email = _offen(code: false);
      await _zeigen(tester);
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Code per E-Mail anfordern'), findsOneWidget);
      expect(find.text('Code per SMS anfordern'), findsNothing);
    });

    testWidgets('neue Mobilnummer: „Code per SMS anfordern“ — wie bisher', (tester) async {
      server.email = _bestaetigt();
      server.telefon = _offen(code: false, wert: '+4917612345611');
      await _zeigen(tester);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Code per SMS anfordern'), findsOneWidget);
      expect(find.text('Code per E-Mail anfordern'), findsNothing);
    });

    test('alle 28 Sprachen haben den Text für die Mail — ohne „SMS“, anders als der für die SMS', () {
      final dateien = Directory('lib/l10n').listSync().whereType<File>().where((f) => f.path.endsWith('.arb')).toList();
      expect(dateien, hasLength(28));
      for (final f in dateien) {
        final arb = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        final mail = arb['kontaktCodePerMailAnfordern'] as String?;
        expect(mail, isNotNull, reason: '${f.path}: Text fehlt');
        expect(mail!.trim(), isNotEmpty, reason: f.path);
        expect(RegExp('sms|смс|رسالة نصية|tekstiviesti', caseSensitive: false).hasMatch(mail), isFalse,
            reason: '${f.path}: „$mail“ nennt die SMS');
        expect(mail, isNot(arb['signaturCodeAnfordern']), reason: f.path);
      }
    });
  });

}

Future<void> _zeigen(
  WidgetTester tester, {
  VoidCallback? onBestaetigt,
  KontaktCodeAusLink? codeAusLink,
  bool nurWennFaellig = true,
  Locale sprache = const Locale('de'),
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
    sprache: sprache,
  ));
  await tester.pumpAndSettle();
}

Widget _app(Widget body, {Locale sprache = const Locale('de')}) => MaterialApp(
      locale: sprache,
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

  /// Gesetzt: „code_anfordern“ antwortet wie die Sperre des Servers (429).
  int? wartenSekunden;

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
            final w = wartenSekunden;
            if (w != null) {
              return _json({
                'success': false,
                'message': 'Bitte warten Sie $w Sekunden, bevor Sie einen neuen Code anfordern.',
                'warten_sekunden': w,
              }, 429);
            }
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
