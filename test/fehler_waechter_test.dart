import 'dart:convert';
import 'dart:io';
import 'dart:ui' show ErrorCallback, PlatformDispatcher;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:icd360sev_mitglied/services/fehler_waechter.dart';
import 'package:icd360sev_mitglied/services/logger_service.dart';
import 'package:icd360sev_mitglied/utils/fehler_text.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Etappe 2.1 (16.10.2026, „continua cu etapa 2“): der FehlerWaechter der
/// Vorsitzer-App, kopiert in die Mitglieder-App.
///
/// Bis dahin kamen zwei Arten von Fehlern nie beim Server an:
/// - was niemand fing — `FlutterError.onError` zeigte es nur an, und für
///   Future, Timer und Stream gab es gar keinen Handler;
/// - alles aus den Engines im Hintergrund (WorkManager, Vordergrunddienst):
///   sie luden nie etwas hoch. Der Ticket-Abruf im Hintergrund wurde eine
///   Woche lang 5.493-mal abgewiesen, und niemand sah es.
///
/// Diese Datei prüft den Weg in Dart und hält im Quelltext fest, dass JEDER
/// Einstieg und JEDER Kanal angeschlossen ist.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FlutterExceptionHandler? flutterVorher;
  late ErrorCallback? plattformVorher;
  final log = LoggerService();

  /// Die Zeilen des Wächters, die seit dem Anfang des Tests im Protokoll
  /// stehen.
  List<LogEntry> fehlerZeilen() =>
      log.logs.where((e) => e.tag == LoggerService.fehlerTag).toList();

  Future<void> warten() async {
    for (var i = 0; i < 10; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  setUp(() {
    flutterVorher = FlutterError.onError;
    plattformVorher = PlatformDispatcher.instance.onError;
    FehlerWaechter.zuruecksetzen();
    log.zuruecksetzen();
    LoggerService.testClient = null;
  });

  tearDown(() {
    FlutterError.onError = flutterVorher;
    PlatformDispatcher.instance.onError = plattformVorher;
    FehlerWaechter.zuruecksetzen();
    log.zuruecksetzen();
    LoggerService.testClient = null;
  });

  group('die Handler', () {
    test('FlutterError: als FEHLER-Zeile mit Engine, Stapel und Merkmal — und '
        'der bisherige Handler läuft weiter', () {
      final bisher = <FlutterErrorDetails>[];
      FlutterError.onError = bisher.add;
      FehlerWaechter.einrichten('haupt');

      FlutterError.onError!(FlutterErrorDetails(
        exception: StateError('kaputt'),
        stack: StackTrace.current,
      ));

      expect(bisher, hasLength(1),
          reason: 'Konsole und Startprotokoll müssen weiterlaufen');
      final z = fehlerZeilen().single;
      expect(z.level, LogLevel.error);
      expect(z.message, contains('Flutter-Fehler in „haupt“'));
      expect(z.message, contains('Bad state: kaputt'));
      expect(z.felder!['engine'], 'haupt');
      expect(z.felder!['stack'], contains('main.<anonymous closure>'));
      expect(z.felder!['fingerprint'], startsWith('StateError|'));
      expect(z.felder!['count'], 1);
      expect(z.felder!['version'], isA<String>());
      expect(z.message, isNot(contains('main.<anonymous closure>')),
          reason: 'der Stapel geht als eigenes Feld mit, nicht im Text');
    });

    test('ohne bisherigen Handler: presentError wie Flutter selbst', () {
      FlutterError.onError = null;
      FehlerWaechter.einrichten('haupt');
      // presentError schreibt nur auf die Konsole — es darf nicht werfen.
      FlutterError.onError!(FlutterErrorDetails(exception: StateError('x')));
      expect(fehlerZeilen(), hasLength(1));
    });

    test('PlatformDispatcher: gemeldet, und die Antwort bleibt false wie bisher',
        () {
      PlatformDispatcher.instance.onError = null;
      FehlerWaechter.einrichten('haupt');

      final antwort = PlatformDispatcher.instance.onError!(
          const FormatException('Unexpected character', '{"name":"Max"}', 1),
          StackTrace.current);

      expect(antwort, isFalse,
          reason: 'false = die Engine schreibt es weiter ins Logcat, wie ohne Wächter');
      final z = fehlerZeilen().single;
      expect(z.message, contains('Dart-Fehler in „haupt“'));
      expect(z.message, isNot(contains('Max')),
          reason: 'FormatException zitiert die Eingabe — die bleibt draußen');
    });

    test('ein vorhandener PlatformDispatcher-Handler behält das letzte Wort', () {
      PlatformDispatcher.instance.onError = (e, s) => true;
      FehlerWaechter.einrichten('haupt');
      expect(PlatformDispatcher.instance.onError!(StateError('x'), StackTrace.empty),
          isTrue);
    });

    test('leise Fehler (silent, z. B. ein Bild lädt nicht) nur als Warnung', () {
      FehlerWaechter.einrichten('haupt');
      FlutterError.onError!(FlutterErrorDetails(exception: Exception('404'), silent: true));
      expect(fehlerZeilen().single.level, LogLevel.warning);
    });

    test('die Tastatur unter Windows (Tasten-Versatz) ist kein Fehler der App', () {
      final bisher = <FlutterErrorDetails>[];
      FlutterError.onError = bisher.add;
      FehlerWaechter.einrichten('haupt');
      FlutterError.onError!(FlutterErrorDetails(
        exception: Exception('A KeyDownEvent is dispatched, but the state shows '
            'that the physical key is already pressed.'),
      ));
      expect(fehlerZeilen(), isEmpty);
      expect(bisher, hasLength(1));
    });

    test('derselbe Fehler 12-mal: das 1. und das 10. Mal, mit der Zahl', () {
      FehlerWaechter.einrichten('haupt');
      for (var i = 0; i < 12; i++) {
        FehlerWaechter.melden(StateError('immer wieder'), StackTrace.current,
            quelle: 'Flutter');
      }
      final z = fehlerZeilen();
      expect(z, hasLength(2));
      expect(z[0].message, isNot(contains('Mal')));
      expect(z[1].message, contains('zum 10. Mal'));
      expect(z[1].felder!['count'], 10);
    });

    test('höchstens ${FehlerWaechter.hoechstensJeMinute} Meldungen je Minute', () {
      var jetzt = DateTime(2026, 10, 16, 9, 30, 5);
      FehlerWaechter.uhr = () => jetzt;
      FehlerWaechter.einrichten('haupt');
      // Lauter verschiedene Fehler, jeder zum ersten Mal (Buchstaben statt
      // Ziffern: ohne Stapel macht das Merkmal aus jeder Ziffer eine 0).
      String name(int i) =>
          String.fromCharCode(65 + i % 26) + String.fromCharCode(65 + i ~/ 26);
      for (var i = 0; i < FehlerWaechter.hoechstensJeMinute + 20; i++) {
        FehlerWaechter.melden(StateError('Fehler ${name(i)}'), null, quelle: 'Dart');
      }
      expect(fehlerZeilen(), hasLength(FehlerWaechter.hoechstensJeMinute));
      jetzt = jetzt.add(const Duration(minutes: 1));
      FehlerWaechter.melden(StateError('Fehler neu'), null, quelle: 'Dart');
      expect(fehlerZeilen(), hasLength(FehlerWaechter.hoechstensJeMinute + 1));
    });

    test('ein Kanal-Handler: gemeldet und weiter geworfen — Kotlin behält '
        'seine Fehlerantwort', () async {
      FehlerWaechter.einrichten('haupt');
      final h = FehlerWaechter.kanal('anruf', (ruf) async => throw StateError('weg'));
      await expectLater(h(const MethodCall('auflegen')), throwsStateError);
      expect(fehlerZeilen().single.message, contains('Kanal anruf · auflegen-Fehler'));

      final antwort = FehlerWaechter.kanal('anruf',
          (ruf) async => throw PlatformException(code: 'nein'));
      await expectLater(antwort(const MethodCall('x')), throwsA(isA<PlatformException>()));
      expect(fehlerZeilen(), hasLength(1),
          reason: 'eine PlatformException ist die Antwort des Handlers, kein Fehler');
    });
  });

  group('Text und Merkmal', () {
    test('Merkmal ohne Zeilennummer: eine neue Fassung ist kein neuer Fehler', () {
      const a = '#0      _Foo.bar (package:icd360sev_mitglied/screens/x.dart:120:7)\n'
          '#1      main (package:flutter/src/y.dart:5:1)';
      const b = '#0      _Foo.bar (package:icd360sev_mitglied/screens/x.dart:131:9)\n'
          '#1      main (package:flutter/src/y.dart:5:1)';
      final fa = FehlerWaechter.merkmalVon(StateError('x'), a);
      expect(fa, FehlerWaechter.merkmalVon(StateError('x'), b));
      expect(fa, 'StateError|_Foo.bar (package:icd360sev_mitglied/screens/x.dart)');
      expect(fa, isNot(FehlerWaechter.merkmalVon(ArgumentError('x'), a)));
    });

    test('der erste EIGENE Rahmen zählt, nicht der aus Flutter', () {
      const s = '#0      Element.build (package:flutter/src/widgets/framework.dart:1:1)\n'
          '#1      _ChatState.build (package:icd360sev_mitglied/screens/chat_screen.dart:9:9)';
      expect(FehlerWaechter.merkmalVon(StateError('x'), s), contains('chat_screen.dart'));
    });

    test('PlatformException: Code und Meldung, keine Details — dafür der '
        'Java-Stapel im Stapel', () {
      final e = PlatformException(
        code: 'error',
        message: 'open failed',
        details: 'java.io.IOException: x\n\tat de.icd360s.mitglieder.A.b(SourceFile:12)',
      );
      expect(FehlerWaechter.fehlerAlsText(e), 'PlatformException(error): open failed');
      final st = FehlerWaechter.stapelAlsText(StackTrace.current, e);
      expect(st, contains('— Java —'));
      expect(st, contains('at de.icd360s.mitglieder.A.b(SourceFile:12)'));
    });

    test('ein Stapel bleibt bei 40 Rahmen stehen', () {
      final lang = StackTrace.fromString(
          List.generate(100, (i) => '#$i      f$i (package:x/y.dart:$i:1)').join('\n'));
      final st = FehlerWaechter.stapelAlsText(lang, StateError('x'));
      expect(st.split('\n'), hasLength(41));
      expect(st.split('\n').last, '…');
    });
  });

  group('fehlerSaeubern', () {
    test('Pfade unter Android nur mit Endung — auch mit Leerzeichen im Namen', () {
      expect(
        fehlerSaeubern("FileSystemException: Cannot open file, path = "
            "'/data/user/0/de.icd360s.mitglieder/app_flutter/Max Muster Vollmacht.pdf' "
            '(OS Error: No such file or directory, errno = 2)'),
        "FileSystemException: Cannot open file, path = '<Datei>.pdf' "
        '(OS Error: No such file or directory, errno = 2)',
      );
      expect(
        fehlerSaeubern('java.io.FileNotFoundException: '
            '/storage/emulated/0/Download/Erika Muster.jpg: open failed: ENOENT'),
        'java.io.FileNotFoundException: <Datei>.jpg: open failed: ENOENT',
      );
    });

    test('🔴 Pfade unter Windows: der Benutzername ist oft der Name des Mitglieds', () {
      expect(
        fehlerSaeubern("PathAccessException: Cannot open file, path = "
            "'C:\\Users\\Max Muster\\Documents\\Bescheid (Kopie).pdf' (OS Error: 5)"),
        "PathAccessException: Cannot open file, path = '<Datei>.pdf' (OS Error: 5)",
      );
      expect(
        fehlerSaeubern(r'Zugriff verweigert: C:\Users\Erika Muster\Downloads\Brief.docx: gesperrt'),
        'Zugriff verweigert: <Datei>.docx: gesperrt',
      );
    });

    test('der Pfad einer Adresse ist kein Dateipfad, die Abfrage geht weg', () {
      expect(fehlerSaeubern('https://icd360sev.icd360s.de/data/x.php failed'),
          'https://icd360sev.icd360s.de/data/x.php failed');
      expect(
        fehlerSaeubern('HttpException: Connection closed, uri = '
            'https://icd360sev.icd360s.de/api/x.php?mgnr=M10001&name=Max'),
        'HttpException: Connection closed, uri = https://icd360sev.icd360s.de/api/x.php?…',
      );
    });

    test('E-Mail, Rufnummer und IBAN — keine Zeilennummer, keine Mitgliedsnummer', () {
      expect(fehlerSaeubern('Mail an erika.muster@example.org scheiterte'),
          'Mail an <E-Mail> scheiterte');
      expect(fehlerSaeubern('Rufnummer +49 151 1234 5678 besetzt'), 'Rufnummer <Nummer> besetzt');
      expect(fehlerSaeubern('IBAN DE89 3704 0044 0532 0130 00 ungültig'),
          'IBAN DE89 <Nummer> ungültig');
      expect(fehlerSaeubern('Mitglied M10001 Status 404'), 'Mitglied M10001 Status 404');
      expect(fehlerSaeubern('x.dart:12345678:5', nummern: false), 'x.dart:12345678:5');
    });

    test('lange Texte werden gekürzt', () {
      final t = fehlerSaeubern('x' * 5000, hoechstens: 100);
      expect(t.length, lessThanOrEqualTo(102));
      expect(t, endsWith(' …'));
    });
  });

  group('die Übertragung', () {
    test('🔴 eine FEHLER-Zeile geht mit ihren Feldern hinaus, jede andere wie bisher', () {
      final fehler = LogEntry(
        timestamp: DateTime(2026, 10, 16, 20, 0),
        message: 'Dart-Fehler in „haupt“: Bad state: x',
        level: LogLevel.error,
        tag: LoggerService.fehlerTag,
        felder: {
          'engine': 'haupt',
          'stack': '#0 a (package:icd360sev_mitglied/a.dart:1:1)',
          'fingerprint': 'StateError|a (package:icd360sev_mitglied/a.dart)',
          'count': 1,
          'version': '1.109.0+20900',
          // Ein Feld, das eines der vier überschriebe, gewinnt nicht.
          'message': 'anders',
        },
      ).alsJson();
      expect(fehler['tag'], 'FEHLER');
      expect(fehler['message'], 'Dart-Fehler in „haupt“: Bad state: x');
      expect(fehler['level'], 'error');
      expect(fehler['engine'], 'haupt');
      expect(fehler['fingerprint'], startsWith('StateError|'));
      expect(fehler['version'], '1.109.0+20900');

      final normal = LogEntry(
        timestamp: DateTime(2026, 10, 16, 20, 0),
        message: 'Dashboard geladen',
        level: LogLevel.info,
        tag: 'DASH',
      ).alsJson();
      expect(normal.keys.toSet(), {'timestamp', 'message', 'level', 'tag'});
    });

    test('🔴 im Hintergrund: die Fehlerzeile geht selbst hinaus — unter der '
        'Mitgliedsnummer, mit Fassung und Feldern', () async {
      FlutterSecureStorage.setMockInitialValues({'device_id': 'geraet-1'});
      SharedPreferences.setMockInitialValues({'current_mitgliedernummer': 'M10001'});
      PackageInfo.setMockInitialValues(
        appName: 'ICD360S Mitglieder',
        packageName: 'de.icd360s.mitglieder',
        version: '1.109.0',
        buildNumber: '10900',
        buildSignature: '',
      );
      final gesendet = <Map<String, dynamic>>[];
      LoggerService.testClient = MockClient((anfrage) async {
        gesendet.add(jsonDecode(anfrage.body) as Map<String, dynamic>);
        return http.Response('{"success":true}', 200);
      });

      FehlerWaechter.einrichten('hintergrund', hochladen: true);
      await warten(); // die Fassung — wie im Lauf, der erst danach arbeitet
      FehlerWaechter.melden(StateError('im Hintergrund'), StackTrace.current,
          quelle: 'Dart');
      await log.fehlerHochladen();
      await warten();

      expect(gesendet, isNotEmpty, reason: 'ohne Takt lud diese Engine nie etwas hoch');
      final u = gesendet.first;
      expect(u['mitgliedernummer'], 'M10001');
      expect(u['device_id'], 'geraet-1');
      expect(u['app_version'], '1.109.0');
      final z = (u['logs'] as List)
          .cast<Map<String, dynamic>>()
          .singleWhere((z) => z['tag'] == 'FEHLER');
      expect(z['engine'], 'hintergrund');
      expect(z['message'], contains('Dart-Fehler in „hintergrund“'));
      expect(z['stack'], contains('main.<anonymous closure>'));
      expect(z['fingerprint'], startsWith('StateError|'));
      expect(z['version'], '1.109.0+20900',
          reason: 'Build-Nummer wie UpdateService sie rechnet: 1·10000 + 109·100 + 0');
    });

    test('🔴 WorkManager: ein Fehler gleich am Anfang des Laufs ist hinaus, wenn '
        'fehlerHochladen zurückkehrt — es wartet, bis der Schlüssel steht', () async {
      FlutterSecureStorage.setMockInitialValues({'device_id': 'geraet-1'});
      SharedPreferences.setMockInitialValues({'current_mitgliedernummer': 'M10001'});
      final nummern = <Object?>[];
      LoggerService.testClient = MockClient((anfrage) async {
        nummern.add((jsonDecode(anfrage.body) as Map)['mitgliedernummer']);
        return http.Response('{"success":true}', 200);
      });

      FehlerWaechter.einrichten('hintergrund', hochladen: true);
      // Noch bevor Geräte-ID und Mitgliedsnummer gelesen sind.
      FehlerWaechter.melden(StateError('sofort'), null, quelle: 'Dart');
      await log.fehlerHochladen();
      // KEIN warten(): was fehlerHochladen nicht abwartet, ginge mit dem Ende
      // des Laufs verloren.
      expect(nummern, ['M10001']);
    });

    test('im Hintergrund: eine error-Zeile geht ebenso hinaus, Kontext allein nicht',
        () async {
      FlutterSecureStorage.setMockInitialValues({'device_id': 'geraet-1'});
      SharedPreferences.setMockInitialValues({'current_mitgliedernummer': 'M10001'});
      var anfragen = 0;
      LoggerService.testClient = MockClient((anfrage) async {
        anfragen++;
        return http.Response('{"success":true}', 200);
      });

      FehlerWaechter.einrichten('hintergrund', hochladen: true);
      log.info('nur Kontext', tag: 'HINTERGRUND');
      await log.fehlerHochladen();
      expect(anfragen, 0, reason: 'ohne Fehler funkt die Engine nicht');

      log.error('Ticket-Abruf im Hintergrund abgewiesen: HTTP 403', tag: 'HINTERGRUND');
      await log.fehlerHochladen();
      await warten();
      expect(anfragen, 1);
    });

    test('🔴 im Vordergrunddienst (läuft lange, ohne Ende eines Laufs): eine '
        'Fehlerzeile geht von selbst hinaus', () async {
      FlutterSecureStorage.setMockInitialValues({'device_id': 'geraet-1'});
      SharedPreferences.setMockInitialValues({'current_mitgliedernummer': 'M10001'});
      var anfragen = 0;
      LoggerService.testClient = MockClient((anfrage) async {
        anfragen++;
        return http.Response('{"success":true}', 200);
      });

      FehlerWaechter.einrichten('dienst', hochladen: true);
      await warten(); // Schlüssel und Fassung stehen
      expect(anfragen, 0);
      FehlerWaechter.melden(StateError('im Dienst'), null, quelle: 'Dart');
      await warten();
      expect(anfragen, 1, reason: 'niemand ruft hier fehlerHochladen');
    });

    test('in der Haupt-Engine: ein Fehler beim Start wartet auf startUpload — und '
        'geht dann gleich hinaus, nicht erst nach fünf Minuten', () async {
      FehlerWaechter.einrichten('haupt');
      var anfragen = 0;
      LoggerService.testClient = MockClient((anfrage) async {
        anfragen++;
        return http.Response('{}', 200);
      });
      FehlerWaechter.melden(StateError('vor startUpload'), null, quelle: 'Dart');
      expect(anfragen, 0, reason: 'ohne Schlüssel und Takt kein Hochladen');
      expect(fehlerZeilen(), hasLength(1));

      log.startUpload('M10001', '1.109.0');
      await warten();
      expect(anfragen, 1);
    });
  });

  group('Quelltext: jeder Einstieg, jeder Kanal', () {
    String lies(String p) => File(p).readAsStringSync();

    /// Rumpf ab [kopf] bis zur passenden schließenden Klammer.
    String rumpf(String q, String kopf) {
      final i = q.indexOf(kopf);
      expect(i, greaterThanOrEqualTo(0), reason: 'nicht gefunden: $kopf');
      var tiefe = 0;
      for (var j = q.indexOf('{', i); j < q.length; j++) {
        if (q[j] == '{') tiefe++;
        if (q[j] == '}' && --tiefe == 0) return q.substring(i, j + 1);
      }
      fail('kein Ende: $kopf');
    }

    // Einstieg einer eigenen Engine → (Datei, Kopf, Aufruf des Wächters).
    const einstiege = <String, (String, String, String)>{
      'callbackDispatcher': ('lib/services/ticket_notification_service.dart',
          'void callbackDispatcher() {',
          "FehlerWaechter.einrichten('hintergrund', hochladen: true);"),
      'onStart': ('lib/services/background_service.dart',
          'static void onStart(ServiceInstance service) async {',
          "FehlerWaechter.einrichten('dienst', hochladen: true);"),
    };

    // Mit `vm:entry-point` markiert, aber KEIN Einstieg einer Engine: nur vor
    // dem Tree-Shaker geschützt, und sie laufen in einer Engine, die den
    // Wächter schon hat.
    const keinEinstieg = <String>{
      'BackgroundService',
      'initializeService',
      'setCredentials',
      'clearCredentials',
      'onIosBackground', // iOS: kehrt sofort mit true zurück
      '_handleWebSocketMessage',
      '_showChatNotification',
      '_showCallNotification',
      '_schlichteAnrufmeldung',
      '_showRemoteNotification',
      'stopService',
      'isServiceRunning',
    };

    test('🔴 jede Markierung `vm:entry-point` in lib/ ist eingeordnet', () {
      final gefunden = <String>{};
      final muster = RegExp(
          r"@pragma\('vm:entry-point'\)\s*(?:static\s+)?(?:class\s+(\w+)|[\w<>?, ]+?\s+(\w+)\s*\()");
      for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) {
        if (!f.path.endsWith('.dart')) continue;
        for (final m in muster.allMatches(f.readAsStringSync())) {
          gefunden.add(m.group(1) ?? m.group(2)!);
        }
      }
      expect(gefunden, {...einstiege.keys, ...keinEinstieg},
          reason: 'Ein neuer Einstieg ist eine neue Engine mit eigenen '
              'Handlern — er braucht FehlerWaechter.einrichten und gehört in '
              'die Liste `einstiege`.');
    });

    test('🔴 jeder Einstieg richtet den Wächter ein, vor der eigentlichen Arbeit', () {
      for (final MapEntry(key: name, value: (datei, kopf, aufruf)) in einstiege.entries) {
        final r = rumpf(lies(datei), kopf);
        final i = r.indexOf(aufruf);
        expect(i, greaterThan(0), reason: '$name: $aufruf fehlt in $datei');
        for (final danach in ['executeTask(', 'debugPrint(', 'Timer', 'WebSocket']) {
          final j = r.indexOf(danach);
          if (j >= 0) expect(i, lessThan(j), reason: '$name: Wächter nach $danach');
        }
      }
    });

    test('🔴 main: der Wächter steht hinter dem eigenen FlutterError-Handler und vor runApp',
        () {
      final r = rumpf(lies('lib/main.dart'), 'void main() async {');
      final handler = r.lastIndexOf('FlutterError.onError =');
      final waechter = r.indexOf("FehlerWaechter.einrichten('haupt');");
      expect(handler, greaterThan(0));
      expect(waechter, greaterThan(handler),
          reason: 'sonst überschriebe der Handler von main den Wächter');
      expect(waechter, lessThan(r.indexOf('runApp(const MitgliedApp())')));
      expect(waechter, lessThan(r.indexOf('LoggerService().init()')),
          reason: 'so früh wie möglich — auch ein Fehler beim Start zählt');
    });

    test('🔴 niemand sonst setzt die Handler (sonst wäre der Wächter weg)', () {
      final befunde = <String>[];
      for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) {
        if (!f.path.endsWith('.dart')) continue;
        if (f.path.endsWith('fehler_waechter.dart') ||
            f.path.endsWith('${Platform.pathSeparator}main.dart')) {
          continue;
        }
        final q = f.readAsStringSync();
        if (RegExp(r'FlutterError\.onError\s*=(?!=)').hasMatch(q) ||
            RegExp(r'PlatformDispatcher\.instance\.onError\s*=(?!=)').hasMatch(q)) {
          befunde.add(f.path);
        }
      }
      expect(befunde, isEmpty);
    });

    test('🔴 jeder Kanal-Handler in Dart ist umhüllt', () {
      final befunde = <String>[];
      var umhuellt = 0;
      for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) {
        if (!f.path.endsWith('.dart')) continue;
        final q = f.readAsStringSync();
        for (final m in RegExp(r'setMethodCallHandler\(').allMatches(q)) {
          final rest = q.substring(m.end, (m.end + 120).clamp(0, q.length));
          if (rest.startsWith('null)')) continue;
          if (rest.startsWith('FehlerWaechter.kanal(')) {
            umhuellt++;
            continue;
          }
          befunde.add('${f.path}: setMethodCallHandler(${rest.split('\n').first}');
        }
      }
      expect(befunde, isEmpty);
      expect(umhuellt, greaterThanOrEqualTo(2), reason: 'Test blind?');
    });

    test('🔴 WorkManager: vor dem Ende alle Fehler hinaus', () {
      final r = rumpf(lies('lib/services/ticket_notification_service.dart'),
          'void callbackDispatcher() {');
      final arbeit = r.indexOf('await _pollInBackground();');
      final hinaus = r.indexOf('await LoggerService().fehlerHochladen();');
      expect(arbeit, greaterThan(0));
      expect(hinaus, greaterThan(arbeit));
      expect(hinaus, lessThan(r.indexOf('return Future.value(true);')));
    });

    test('🔴 der Ticket-Abruf im Hintergrund schreibt Abweisung und Absturz als '
        'Fehler — nicht nur debugPrint', () {
      final r = rumpf(lies('lib/services/ticket_notification_service.dart'),
          'Future<void> _pollInBackground() async {');
      expect(r, contains("'Ticket-Abruf im Hintergrund abgewiesen: HTTP \${response.statusCode}'"));
      expect(r, contains("LoggerService().error('Ticket-Abruf im Hintergrund gescheitert: \$e'"));
    });
  });
}
