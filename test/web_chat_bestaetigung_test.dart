import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/services/ntfy_service.dart';
import 'package:icd360sev_mitglied/services/web_chat_bestaetigung.dart';
import 'package:icd360sev_mitglied/widgets/web_chat_bestaetigung_dialog.dart';

/// Live-Chat der Website, Schritt 2: jemand schreibt auf icd360s.de „Ich bin
/// Mitglied", der Vorstand lässt ein Mitglied fragen, und die App zeigt drei
/// Zahlen — das Mitglied tippt die, die im Website-Chat steht
/// (Server: member/web_chat_bestaetigen.php, Vertrag im Paket
/// ~/website-live-chat-schritt2/API.md).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temp;
  setUp(() {
    temp = Directory.systemTemp.createTempSync('webchat');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'), (call) async => temp.path);
    WebChatBestaetigung.instance.zuruecksetzen();
  });
  tearDown(() {
    WebChatBestaetigung.instance.zuruecksetzen();
    try {
      temp.deleteSync(recursive: true);
    } catch (_) {}
  });

  http.Response json(Object rumpf, [int status = 200]) =>
      http.Response(jsonEncode(rumpf), status, headers: {'content-type': 'application/json'});

  Map<String, dynamic> offen(int id, List<Object> zahlen) => {
        'success': true,
        'anfrage': {'id': id, 'zahlen': zahlen, 'gefragt_am': '2026-10-17 21:30:00', 'gueltig_bis': '2026-10-17 21:40:00'},
      };

  group('Antwort auf „offen" lesen', () {
    test('drei verschiedene Zahlen und eine id → eine Frage', () {
      final a = WebChatAnfrage.ausAntwort(offen(5, [47, 12, 85]))!;
      expect(a.id, 5);
      expect(a.zahlen, [47, 12, 85]);
    });

    test('Zahlen als Text gehen auch (der Server rechnet in PHP)', () {
      final a = WebChatAnfrage.ausAntwort(offen(7, ['47', '12', '85']))!;
      expect(a.id, 7);
      expect(a.zahlen, [47, 12, 85]);
    });

    test('keine Frage offen → null', () {
      expect(WebChatAnfrage.ausAntwort({'success': true, 'anfrage': null}), isNull);
      expect(WebChatAnfrage.ausAntwort({'success': true}), isNull);
      expect(WebChatAnfrage.ausAntwort(null), isNull);
      expect(WebChatAnfrage.ausAntwort('kaputt'), isNull);
    });

    test('lieber kein Dialog als einer mit falschen Zahlen', () {
      expect(WebChatAnfrage.ausAntwort(offen(5, [47, 12])), isNull, reason: 'nur zwei');
      expect(WebChatAnfrage.ausAntwort(offen(5, [47, 12, 85, 3])), isNull, reason: 'vier');
      expect(WebChatAnfrage.ausAntwort(offen(5, [47, 47, 85])), isNull, reason: 'doppelt');
      expect(WebChatAnfrage.ausAntwort(offen(5, [47, -1, 85])), isNull, reason: 'negativ');
      expect(WebChatAnfrage.ausAntwort(offen(5, [47, 'x', 85])), isNull, reason: 'keine Zahl');
      expect(WebChatAnfrage.ausAntwort(offen(0, [47, 12, 85])), isNull, reason: 'id 0');
    });
  });

  group('Antwort auf „antworten" deuten', () {
    test('bestätigt / abgelehnt nur mit 200 und success', () {
      expect(WebChatBestaetigung.ergebnisAus(200, {'success': true, 'status': 'bestaetigt'}),
          WebChatErgebnis.bestaetigt);
      expect(WebChatBestaetigung.ergebnisAus(200, {'success': true, 'status': 'abgelehnt'}),
          WebChatErgebnis.abgelehnt);
      expect(WebChatBestaetigung.ergebnisAus(200, {'success': false, 'status': 'bestaetigt'}),
          WebChatErgebnis.fehler);
      expect(WebChatBestaetigung.ergebnisAus(500, {'success': true, 'status': 'bestaetigt'}),
          WebChatErgebnis.fehler);
    });

    test('falsche Zahl gilt mit jedem Statuscode — die Frage ist verbraucht', () {
      expect(WebChatBestaetigung.ergebnisAus(200, {'success': true, 'status': 'falsch'}),
          WebChatErgebnis.falsch);
      expect(WebChatBestaetigung.ergebnisAus(400, {'success': false, 'status': 'falsch'}),
          WebChatErgebnis.falsch);
    });

    test('abgelaufen: 404/410 oder grund keine', () {
      expect(WebChatBestaetigung.ergebnisAus(404, {'success': false, 'grund': 'keine'}),
          WebChatErgebnis.abgelaufen);
      expect(WebChatBestaetigung.ergebnisAus(410, null), WebChatErgebnis.abgelaufen);
      expect(WebChatBestaetigung.ergebnisAus(200, {'success': false, 'grund': 'keine'}),
          WebChatErgebnis.abgelaufen);
    });

    test('alles andere: Netz-/Serverfehler, das Mitglied darf noch einmal tippen', () {
      expect(WebChatBestaetigung.ergebnisAus(502, null), WebChatErgebnis.fehler);
      expect(WebChatBestaetigung.ergebnisAus(200, 'kein json'), WebChatErgebnis.fehler);
      expect(WebChatBestaetigung.ergebnisAus(200, {'success': true, 'status': 'unbekannt'}),
          WebChatErgebnis.fehler);
    });
  });

  group('ApiService: Adresse und Rumpf', () {
    test('Rumpf: mit Zahl „das bin ich", ohne „nein" — nie beides', () {
      expect(ApiService.webChatAntwortRumpf(5, zahl: 47), {'aktion': 'antworten', 'id': 5, 'zahl': 47});
      expect(ApiService.webChatAntwortRumpf(5), {'aktion': 'antworten', 'id': 5, 'antwort': 'nein'});
    });

    test('offen und antworten gehen als POST an member/web_chat_bestaetigen.php, mit Token', () async {
      FlutterSecureStorage.setMockInitialValues({'access_token': 'tok-9', 'refresh_token': 'ref-9'});
      await ApiService().loadTokens();
      final anfragen = <http.Request>[];
      ApiService().testClient = MockClient((r) async {
        anfragen.add(r);
        return json({'success': true, 'anfrage': null});
      });
      await ApiService().webChatOffen();
      await ApiService().webChatAntworten(5, zahl: 12);
      expect(anfragen, hasLength(2));
      for (final r in anfragen) {
        expect(r.method, 'POST');
        expect(r.url.toString(), 'https://icd360sev.icd360s.de/api/member/web_chat_bestaetigen.php');
        expect(r.headers['Authorization'], 'Bearer tok-9');
      }
      expect(jsonDecode(anfragen[0].body), {'aktion': 'offen'});
      expect(jsonDecode(anfragen[1].body), {'aktion': 'antworten', 'id': 5, 'zahl': 12});
    });
  });

  group('Wann gefragt wird', () {
    late int abfragen;
    late DateTime uhr;
    late List<WebChatAnfrage> gezeigt;

    setUp(() {
      abfragen = 0;
      uhr = DateTime(2026, 10, 17, 21, 30);
      gezeigt = [];
      final b = WebChatBestaetigung.instance;
      b.jetzt = () => uhr;
      b.holen = () async {
        abfragen++;
        return json(offen(5, [47, 12, 85]));
      };
    });

    Future<void> zeigen(WebChatAnfrage a) async => gezeigt.add(a);

    test('von selbst höchstens alle 30 s — ein Push fragt sofort', () async {
      final b = WebChatBestaetigung.instance;
      await b.pruefen(zeigen: zeigen);
      expect(abfragen, 1);
      uhr = uhr.add(const Duration(seconds: 10));
      await b.pruefen(zeigen: zeigen);
      expect(abfragen, 1, reason: 'Zurückkommen nach 10 s fragt nicht noch einmal');
      await b.pruefen(zeigen: zeigen, sofort: true);
      expect(abfragen, 2, reason: 'der Push des Vorstands fragt sofort');
      uhr = uhr.add(const Duration(seconds: 31));
      await b.pruefen(zeigen: zeigen);
      expect(abfragen, 3);
      expect(gezeigt.map((a) => a.id), [5, 5, 5]);
    });

    test('keine Frage offen → kein Dialog', () async {
      final b = WebChatBestaetigung.instance;
      b.holen = () async => json({'success': true, 'anfrage': null});
      await b.pruefen(zeigen: zeigen);
      expect(gezeigt, isEmpty);
    });

    test('Server- oder Netzfehler → still kein Dialog, nichts wirft', () async {
      final b = WebChatBestaetigung.instance;
      b.holen = () async => http.Response('kaputt', 500);
      await b.pruefen(zeigen: zeigen);
      b.holen = () async => throw const SocketException('weg');
      await b.pruefen(zeigen: zeigen, sofort: true);
      b.holen = () async => http.Response('<html>', 200);
      await b.pruefen(zeigen: zeigen, sofort: true);
      expect(gezeigt, isEmpty);
    });

    test('während ein Dialog steht, öffnet kein zweiter Auslöser einen zweiten', () async {
      final b = WebChatBestaetigung.instance;
      final dialogZu = Completer<void>();
      final erster = b.pruefen(zeigen: (a) async {
        gezeigt.add(a);
        await dialogZu.future;
      });
      await pumpEventQueue();
      expect(b.beschaeftigt, isTrue);
      await b.pruefen(zeigen: zeigen, sofort: true);
      await b.pruefen(zeigen: zeigen);
      expect(gezeigt, hasLength(1));
      dialogZu.complete();
      await erster;
      expect(b.beschaeftigt, isFalse);
      expect(gezeigt, hasLength(1), reason: 'die Frage stand ja schon');
    });

    test('Push während der Abfrage, die noch nichts fand → danach gleich noch einmal', () async {
      final b = WebChatBestaetigung.instance;
      final antwort = Completer<http.Response>();
      var n = 0;
      b.holen = () {
        n++;
        return n == 1 ? antwort.future : Future.value(json(offen(9, [3, 4, 5])));
      };
      final erster = b.pruefen(zeigen: zeigen);
      await pumpEventQueue();
      await b.pruefen(zeigen: zeigen, sofort: true); // der Push kommt jetzt
      antwort.complete(json({'success': true, 'anfrage': null}));
      await erster;
      expect(n, 2);
      expect(gezeigt.single.id, 9);
    });
  });

  group('ntfy', () {
    test('Tag web_chat erkennt die Frage — andere Pushs nicht', () {
      expect(NtfyService.hatWebChatTag({'event': 'message', 'tags': ['web_chat']}), isTrue);
      expect(NtfyService.hatWebChatTag({'event': 'message', 'tags': ['chat', 'web_chat']}), isTrue);
      expect(NtfyService.hatWebChatTag({'event': 'message', 'tags': ['chat']}), isFalse);
      expect(NtfyService.hatWebChatTag({'event': 'message'}), isFalse);
      expect(NtfyService.hatWebChatTag({'tags': 'web_chat'}), isFalse, reason: 'ntfy schickt eine Liste');
      expect(NtfyService.hatWebChatTag(null), isFalse);
    });

    test('_handleMessage zählt den Tag hoch', () {
      final quelle = File('lib/services/ntfy_service.dart').readAsStringSync();
      expect(quelle, contains('if (hatWebChatTag(data)) webChatSignal.value++;'));
    });
  });

  group('Dashboard: die drei Auslöser', () {
    final quelle = File('lib/screens/mitglied_dashboard.dart').readAsStringSync();

    test('nach dem Start, beim Zurückkommen und nach einem Push', () {
      expect(quelle, contains('.whenComplete(_webChatPruefen);'));
      expect(quelle, contains('NtfyService().webChatSignal.addListener(_webChatAusPush);'));
      expect(quelle, contains('NtfyService().webChatSignal.removeListener(_webChatAusPush);'));
      final resumed = quelle.indexOf('} else if (state == AppLifecycleState.resumed) {');
      final ende = quelle.indexOf("debugPrint('[Dashboard] App resumed - UI timers restarted');");
      expect(resumed, greaterThan(0));
      expect(quelle.substring(resumed, ende), contains('_webChatPruefen();'));
    });

    test('nie im Hintergrund, nie über einem Anruf', () {
      final start = quelle.indexOf('void _webChatPruefen({bool sofort = false}) {');
      final rumpf = quelle.substring(start, quelle.indexOf('void _webChatAusPush()', start));
      expect(rumpf, contains('zustand != AppLifecycleState.resumed) return;'));
      expect(rumpf, contains('_voiceCallService.callState != CallState.idle || _klingelschirmOffen) return;'));
      expect(rumpf, contains('webChatBestaetigungPruefen(context, sofort: sofort);'));
    });
  });

  group('Dialog', () {
    late List<int?> gesendet;
    late http.Response Function(int? zahl) antwort;

    setUp(() {
      gesendet = [];
      antwort = (_) => json({'success': true, 'status': 'bestaetigt'});
      final b = WebChatBestaetigung.instance;
      b.holen = () async => json(offen(5, [47, 12, 85]));
      b.senden = (id, {zahl}) async {
        expect(id, 5);
        gesendet.add(zahl);
        return antwort(zahl);
      };
    });

    Future<void> starten(WidgetTester tester, {int mal = 1}) async {
      await tester.pumpWidget(MaterialApp(
        locale: const Locale('de'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () {
                for (var i = 0; i < mal; i++) {
                  webChatBestaetigungPruefen(context, sofort: true);
                }
              },
              child: const Text('los'),
            ),
          ),
        ),
      ));
      await tester.tap(find.text('los'));
      await tester.pumpAndSettle();
    }

    testWidgets('zeigt drei Zahlen und „Nein, das bin ich nicht"', (tester) async {
      await starten(tester);
      expect(find.text('Der Vorstand fragt'), findsOneWidget);
      expect(find.text('Schreiben Sie gerade im Chat auf icd360s.de?'), findsOneWidget);
      for (final z in [47, 12, 85]) {
        expect(find.byKey(ValueKey('webchat-zahl-$z')), findsOneWidget);
        expect(find.text('$z'), findsOneWidget);
      }
      expect(find.text('Nein, das bin ich nicht'), findsOneWidget);
    });

    testWidgets('die richtige Zahl → bestätigt', (tester) async {
      await starten(tester);
      await tester.tap(find.byKey(const ValueKey('webchat-zahl-12')));
      await tester.pumpAndSettle();
      expect(gesendet, [12]);
      expect(find.text('Danke! Der Vorstand weiß jetzt, dass Sie es sind.'), findsOneWidget);
      expect(find.byKey(const ValueKey('webchat-zahl-12')), findsNothing);
      expect(find.byKey(const ValueKey('webchat-schliessen')), findsNothing, reason: 'nur noch „Schließen" unten');
      await tester.tap(find.byKey(const ValueKey('webchat-fertig')));
      await tester.pumpAndSettle();
      expect(find.text('Der Vorstand fragt'), findsNothing);
    });

    testWidgets('Nein → ohne Zahl gesendet, abgelehnt', (tester) async {
      antwort = (_) => json({'success': true, 'status': 'abgelehnt'});
      await starten(tester);
      await tester.tap(find.byKey(const ValueKey('webchat-nein')));
      await tester.pumpAndSettle();
      expect(gesendet, [null]);
      expect(find.text('In Ordnung. Der Vorstand erfährt, dass Sie es nicht sind.'), findsOneWidget);
    });

    testWidgets('falsche Zahl → „Bitten Sie den Vorstand, noch einmal zu fragen"', (tester) async {
      antwort = (_) => json({'success': true, 'status': 'falsch'});
      await starten(tester);
      await tester.tap(find.byKey(const ValueKey('webchat-zahl-85')));
      await tester.pumpAndSettle();
      expect(find.text('Diese Zahl stimmt nicht. Bitten Sie den Vorstand, noch einmal zu fragen.'),
          findsOneWidget);
      expect(find.byKey(const ValueKey('webchat-zahl-47')), findsNothing, reason: 'die Frage ist verbraucht');
    });

    testWidgets('abgelaufen → dieselbe Bitte, andere Begründung', (tester) async {
      antwort = (_) => json({'success': false, 'grund': 'keine'}, 404);
      await starten(tester);
      await tester.tap(find.byKey(const ValueKey('webchat-zahl-47')));
      await tester.pumpAndSettle();
      expect(find.text('Die Frage gilt nicht mehr. Bitten Sie den Vorstand, noch einmal zu fragen.'),
          findsOneWidget);
    });

    testWidgets('Netzfehler → Zahlen bleiben, noch einmal tippen geht', (tester) async {
      var n = 0;
      antwort = (_) {
        n++;
        return n == 1 ? http.Response('kaputt', 502) : json({'success': true, 'status': 'bestaetigt'});
      };
      await starten(tester);
      await tester.tap(find.byKey(const ValueKey('webchat-zahl-47')));
      await tester.pumpAndSettle();
      expect(find.text('Keine Verbindung zum Server. Bitte versuchen Sie es noch einmal.'), findsOneWidget);
      expect(find.byKey(const ValueKey('webchat-zahl-47')), findsOneWidget);
      expect(find.byKey(const ValueKey('webchat-schliessen')), findsOneWidget,
          reason: 'die Frage ist nicht beendet — schließen ohne Antwort bleibt möglich');
      await tester.tap(find.byKey(const ValueKey('webchat-zahl-47')));
      await tester.pumpAndSettle();
      expect(gesendet, [47, 47]);
      expect(find.text('Danke! Der Vorstand weiß jetzt, dass Sie es sind.'), findsOneWidget);
    });

    testWidgets('zwei Auslöser auf einmal → genau EIN Dialog', (tester) async {
      await starten(tester, mal: 2);
      expect(find.text('Der Vorstand fragt'), findsOneWidget);
      expect(find.byKey(const ValueKey('webchat-zahl-47')), findsOneWidget);
    });

    testWidgets('Schließen ohne Antwort → nichts gesendet, die Frage kommt später wieder', (tester) async {
      await starten(tester);
      await tester.tap(find.byKey(const ValueKey('webchat-schliessen')));
      await tester.pumpAndSettle();
      expect(find.text('Der Vorstand fragt'), findsNothing);
      expect(gesendet, isEmpty);
      expect(WebChatBestaetigung.instance.beschaeftigt, isFalse);
    });

    test('alle 28 Sprachen haben die Texte', () async {
      for (final locale in AppLocalizations.supportedLocales) {
        final l = await AppLocalizations.delegate.load(locale);
        for (final t in [
          l.webChatFrageTitel, l.webChatFrageText, l.webChatFrageZahl, l.webChatNein,
          l.webChatBestaetigt, l.webChatAbgelehnt, l.webChatFalsch, l.webChatAbgelaufen, l.webChatFehler,
        ]) {
          expect(t.trim(), isNotEmpty, reason: locale.languageCode);
        }
        expect(l.webChatFrageText, contains('icd360s.de'), reason: locale.languageCode);
      }
      expect(AppLocalizations.supportedLocales, hasLength(28));
    });
  });
}
