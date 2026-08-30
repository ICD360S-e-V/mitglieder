import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/chat_service.dart';
import 'package:icd360sev_mitglied/services/remote_input/input_injector_android.dart';
import 'package:icd360sev_mitglied/widgets/remote_touch_overlay.dart';

/// Prueft die drei Reparaturen an der Fernwartung auf der Mitgliedsseite:
/// erneuter Raumbeitritt nach einer Wiederverbindung, der Takt der
/// Beruehrungsanzeige, und die Uebersetzung Maus → Geste auf Android.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // ─────────────────────────────────────────────────────────────────────────
  group('Nach einer Wiederverbindung wird der Raum erneut betreten', () {
    late HttpServer server;
    late List<WebSocket> verbindungen;
    late List<Map<String, dynamic>> empfangen;

    setUp(() async {
      verbindungen = [];
      empfangen = [];
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      server.listen((anfrage) async {
        final ws = await WebSocketTransformer.upgrade(anfrage);
        verbindungen.add(ws);
        ws.listen((roh) {
          final data = jsonDecode(roh as String) as Map<String, dynamic>;
          empfangen.add(data);
          if (data['type'] == 'auth') {
            ws.add(jsonEncode({'type': 'auth_success', 'user_id': 13}));
          }
        }, onError: (_) {}, cancelOnError: true);
      });
      ChatService.testWsUrl = 'ws://127.0.0.1:${server.port}/';
    });

    tearDown(() async {
      ChatService().disconnect();
      ChatService.testWsUrl = null;
      for (final ws in verbindungen) {
        await ws.close().catchError((_) => null);
      }
      await server.close(force: true);
    });

    /// 🔴 Der Beitritt haengt am SOCKET. Nach einer Wiederverbindung ist die
    /// Verbindung auf dem Server eine neue und in keinem Raum mehr — der
    /// Vorsitz sendet ICE und Sitzungsende weiterhin an den Raum, und beides
    /// erreicht das Mitglied nicht mehr. Vorher trat niemand erneut bei.
    test('der gemerkte Raum wird nach dem Abriss erneut betreten', () async {
      expect(await ChatService().connect('M68650'), isTrue);
      ChatService().joinConversation(19);

      await Future<void>.delayed(const Duration(milliseconds: 120));
      expect(empfangen.where((m) => m['type'] == 'join').length, 1,
          reason: 'der erste Beitritt');

      // Der Server wirft die Verbindung weg — Netzwechsel, Funkloch, Neustart.
      empfangen.clear();
      await verbindungen.first.close();

      // Der erste Versuch steht nach 2 Sekunden an (2, 4, 8 … Sekunden).
      await Future<void>.delayed(const Duration(seconds: 3));

      expect(ChatService().isConnected, isTrue, reason: 'wieder verbunden');
      final wieder = empfangen.where(
          (m) => m['type'] == 'join' && m['conversation_id'] == 19);
      expect(wieder.length, 1,
          reason: 'ohne erneuten Beitritt bleibt das Mitglied stumm im Nichts');
    }, timeout: const Timeout(Duration(seconds: 30)));

    /// Die Reihenfolge ist kein Schoenheitsfehler: vor der Anmeldung weist der
    /// Server jedes `join` mit „Not authenticated" ab, und zwar lautlos.
    test('der Beitritt kommt NACH der Anmeldung', () async {
      await ChatService().connect('M68650');
      ChatService().joinConversation(19);
      // ⚠️ Erst abwarten, dann leeren: die Rahmen laufen asynchron beim Server
      // ein, und ein zu fruehes Leeren laesst genau die Rahmen stehen, die
      // gerade weggeraeumt werden sollten.
      await Future<void>.delayed(const Duration(milliseconds: 120));
      empfangen.clear();
      await verbindungen.first.close();
      await Future<void>.delayed(const Duration(seconds: 3));

      final reihenfolge =
          empfangen.map((m) => m['type']).where((t) => t == 'auth' || t == 'join').toList();
      expect(reihenfolge.first, 'auth');
      expect(reihenfolge, contains('join'));
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('ein verlassener Raum wird nicht erneut betreten', () async {
      await ChatService().connect('M68650');
      ChatService().joinConversation(19);
      ChatService().leaveConversation(19);
      await Future<void>.delayed(const Duration(milliseconds: 120));
      empfangen.clear();
      await verbindungen.first.close();
      await Future<void>.delayed(const Duration(seconds: 3));

      expect(empfangen.where((m) => m['type'] == 'join'), isEmpty);
    }, timeout: const Timeout(Duration(seconds: 30)));
  });

  // ─────────────────────────────────────────────────────────────────────────
  /// 🔴 Der Ticker der Beruehrungsanzeige lief unbedingt ab `initState` — also
  /// auf JEDEM Mitgliedsgeraet, rund um die Uhr, fuer eine Funktion, die noch
  /// nie benutzt wurde. Ein aktiver Ticker fordert bei jedem vsync einen Frame
  /// an; die App zeichnet dann dauernd, statt in den Leerlauf zu gehen.
  ///
  /// Genau das macht diesen Test moeglich: mit laufendem Ticker kommt
  /// `pumpAndSettle` nie zur Ruhe und laeuft in seinen Zeitablauf.
  testWidgets('ohne Sitzung ruht die Beruehrungsanzeige', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RemoteTouchOverlay(child: Scaffold(body: Text('inhalt'))),
    ));
    await tester.pumpAndSettle();
    expect(find.text('inhalt'), findsOneWidget);
    expect(tester.binding.hasScheduledFrame, isFalse,
        reason: 'ein laufender Ticker haelt das Geraet dauerhaft am Zeichnen');
  });

  // ─────────────────────────────────────────────────────────────────────────
  group('Android: Maus wird zu Gesten', () {
    const kanal = MethodChannel('de.icd360sev.mitglied/fernsteuerung');
    late List<MethodCall> rufe;
    late bool dienstLaeuft;

    setUp(() {
      rufe = [];
      dienstLaeuft = true;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(kanal, (ruf) async {
        rufe.add(ruf);
        if (ruf.method == 'verfuegbar') return dienstLaeuft;
        return true;
      });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(kanal, null);
    });

    Future<AndroidInputInjector> bereit() async {
      final i = AndroidInputInjector();
      await i.vorbereiten();
      rufe.clear();
      return i;
    }

    List<MethodCall> zuege() => rufe.where((r) => r.method == 'zug').toList();

    test('kurz gedrueckt am selben Punkt ergibt einen Tipp', () async {
      final i = await bereit();
      await i.mouseMove(0.4, 0.6);
      await i.mouseButton(0, true);
      await i.mouseButton(0, false);

      expect(zuege().length, 1);
      final a = zuege().single.arguments as Map;
      expect(a['x1'], closeTo(0.4, 1e-9));
      expect(a['x2'], closeTo(0.4, 1e-9), reason: 'ein Tipp bewegt sich nicht');
      expect(a['ms'] as int, lessThan(500), reason: 'kurz, sonst waere es ein langes Tippen');
    });

    test('die rechte Maustaste ergibt ein langes Tippen', () async {
      final i = await bereit();
      await i.mouseMove(0.2, 0.3);
      await i.mouseButton(2, true);
      await i.mouseButton(2, false);

      final a = zuege().single.arguments as Map;
      expect(a['ms'] as int, greaterThanOrEqualTo(500),
          reason: 'Rechtsklick heisst auf dem Touchgeraet Kontextmenue');
    });

    test('gedrueckt ziehen ergibt ein Wischen von A nach B', () async {
      final i = await bereit();
      await i.mouseMove(0.1, 0.8);
      await i.mouseButton(0, true);
      await i.mouseMove(0.1, 0.2);
      await i.mouseButton(0, false);

      final a = zuege().single.arguments as Map;
      expect(a['y1'], closeTo(0.8, 1e-9));
      expect(a['y2'], closeTo(0.2, 1e-9));
    });

    /// ⚠️ Nach unten scrollen heisst: der Inhalt wandert nach oben, der Finger
    /// wischt also nach OBEN. Ein Vorzeichenfehler faellt am Geraet sofort auf,
    /// ist aber genau das Detail, das man beim Nachbauen verdreht.
    test('Rad nach unten wischt nach oben', () async {
      final i = await bereit();
      await i.mouseMove(0.5, 0.5);
      await i.mouseWheel(0, 120);
      await Future<void>.delayed(const Duration(milliseconds: 200));

      final a = zuege().single.arguments as Map;
      expect(a['y2'] as double, lessThan(a['y1'] as double));
    });

    test('ein Schub Radereignisse wird zu EINER Geste zusammengefasst', () async {
      final i = await bereit();
      await i.mouseMove(0.5, 0.5);
      for (var n = 0; n < 8; n++) {
        await i.mouseWheel(0, 40);
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(zuege().length, 1,
          reason: 'eine Geste je Ereignis wuerde die laufende jeweils abbrechen');
    });

    /// Der Dienst laeuft, sobald das Mitglied ihn eingeschaltet hat — auch
    /// ausserhalb einer Sitzung. Ist er nicht eingeschaltet, darf nichts
    /// hinausgehen, statt am Kanal abzuprallen.
    test('ohne eingeschalteten Dienst geht keine Geste hinaus', () async {
      dienstLaeuft = false;
      final i = AndroidInputInjector();
      await i.vorbereiten();
      expect(i.isSupported, isFalse);
      rufe.clear();

      await i.mouseMove(0.5, 0.5);
      await i.mouseButton(0, true);
      await i.mouseButton(0, false);
      await i.mouseWheel(0, 120);
      await i.systemAktion('home');
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(rufe, isEmpty);
    });

    test('das Sitzungsende sperrt die Steuerung wieder zu', () async {
      final i = await bereit();
      i.dispose();
      await Future<void>.delayed(Duration.zero);

      final frei = rufe.where((r) => r.method == 'freigeben').toList();
      expect(frei.single.arguments['frei'], isFalse,
          reason: 'sonst blieben Gesten nach der Sitzung erlaubt');
    });

    test('Escape wird zu Zurueck, andere Tasten fallen weg', () async {
      final i = await bereit();
      await i.keyEvent(hid: 0x29, character: null, down: true); // Escape
      await i.keyEvent(hid: 0x04, character: 'a', down: true);  // Buchstabe a

      final aktionen = rufe.where((r) => r.method == 'aktion').toList();
      expect(aktionen.length, 1);
      expect(aktionen.single.arguments['name'], 'back');
    });
  });
}
