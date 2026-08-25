import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/chat_service.dart';

/// 🔴 Befund vom 26.08.2026: der Chat im Vordergrund hatte GAR KEINE
/// Wiederverbindung. Riss die Verbindung — Netzwechsel, Funkloch,
/// Serverneustart —, blieb er stumm, bis jemand die Anwendung neu startete.
///
/// Der Hintergrunddienst bringt seine eigene mit; genau deshalb fiel es nicht
/// auf: Benachrichtigungen kamen weiter an, waehrend das offene Chatfenster
/// daneben tot war.
///
/// ⚠️ Geprueft gegen einen WebSocket-Server auf `localhost`, nicht gegen das
/// Netz: ein Test, der ohne Leitung rot wird, sagt am Ende nichts mehr.
void main() {
  late HttpServer server;
  late List<WebSocket> verbindungen;
  late int nochAblehnen;

  setUp(() async {
    verbindungen = [];
    nochAblehnen = 0;
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((anfrage) async {
      final ws = await WebSocketTransformer.upgrade(anfrage);
      verbindungen.add(ws);
      ws.listen((roh) {
        final data = jsonDecode(roh as String) as Map<String, dynamic>;
        if (data['type'] != 'auth') return;
        if (nochAblehnen > 0) {
          nochAblehnen--;
          // So verhaelt sich der echte Server: er behaelt den Draht und lehnt
          // nur die Anmeldung ab. Weder onDone noch onError melden sich dabei.
          ws.add(jsonEncode(
              {'type': 'auth_error', 'error': 'Authentication required'}));
        } else {
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

  group('Die Adresse des Kanals', () {
    test('zeigt auf unseren Server', () {
      expect(ChatService.wsUrl, startsWith('wss://'));
      expect(ChatService.wsUrl, contains('icd360sev.icd360s.de'),
          reason: 'nur der eigene Rechner darf auf unsere Anker gepinnt werden');
    });

    test('nennt den Anschluss ausdruecklich', () {
      // 🔴 `Uri` kennt Standardanschluesse nur fuer http und https; fuer wss
      // gibt der Aufrufer 0 zurueck, und `WebSocket.connect` reicht diese 0
      // weiter. Eine eigene connectionFactory liest sie woertlich und haengt
      // dann bis zum Zeitablauf — daran lag der Live-Chat der Vorsitzer-App
      // drei Tage fest. Hier gibt es diese Fabrik nicht; die 443 kostet
      // trotzdem nichts und nimmt der Falle die Wirkung.
      expect(Uri.parse(ChatService.wsUrl).port, 443);
      expect(Uri.parse('wss://icd360sev.icd360s.de/wss/').port, 0,
          reason: 'so sieht dieselbe Adresse ohne die Angabe aus');
    });
  });

  test('eine abgelehnte Anmeldung stoesst einen neuen Versuch an', () async {
    nochAblehnen = 99;
    final ergebnis = await ChatService().connect('M68650');
    expect(ergebnis, isFalse);
    expect(ChatService().wiederverbindungWartet, isTrue,
        reason: 'vorher wartete hier gar nichts');
    expect(ChatService().versucheBisher, 1,
        reason: 'eine Stoerung darf genau einen der zehn Versuche kosten');
  });

  test('der abgelehnte Draht bleibt nicht offen liegen', () async {
    nochAblehnen = 99;
    await ChatService().connect('M68650');
    for (var i = 0; i < 20 && verbindungen.first.closeCode == null; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    expect(verbindungen.first.closeCode, isNotNull);
  });

  test('der naechste Versuch heilt die Verbindung von allein', () async {
    nochAblehnen = 1;
    expect(await ChatService().connect('M68650'), isFalse);

    var verbunden = false;
    final horcher =
        ChatService().connectionStream.listen((an) => verbunden |= an);
    // Der erste Abstand betraegt zwei Sekunden.
    for (var i = 0; i < 60 && !verbunden; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
    await horcher.cancel();
    expect(verbunden, isTrue, reason: 'ohne Zutun wieder da');
    expect(ChatService().versucheBisher, 0, reason: 'nach Erfolg zurueckgesetzt');
  }, timeout: const Timeout(Duration(seconds: 30)));

  test('ein Aufruf von aussen laeuft den Zaehler nicht voll', () async {
    nochAblehnen = 99;
    await ChatService().connect('M68650');
    for (var i = 0; i < 5; i++) {
      await ChatService().connect('M68650');
    }
    expect(ChatService().versucheBisher, lessThanOrEqualTo(1));
    expect(ChatService().wiederverbindungWartet, isTrue);
  });

  test('disconnect laesst keinen wartenden Versuch zurueck', () async {
    nochAblehnen = 99;
    await ChatService().connect('M68650');
    expect(ChatService().wiederverbindungWartet, isTrue);
    ChatService().disconnect();
    expect(ChatService().wiederverbindungWartet, isFalse,
        reason: 'ein liegengebliebener Zeitgeber weckt eine geschlossene App');
  });
}
