import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/chat_service.dart';
import 'package:icd360sev_mitglied/services/logger_service.dart';

/// Die zweite Prüfung zu `kein_inhalt_im_protokoll_test.dart`: nicht am
/// Quelltext, sondern am Lauf. Ein WebSocket auf localhost schickt, was der
/// Chat-Server schickt — eine Nachricht des Vorstands, eine
/// Ticket-Benachrichtigung —, jeweils mit einer Marke. Danach darf keine Marke
/// in den Zeilen stehen, die `LoggerService` zum Server lädt.
///
/// ⚠️ In der Schatzmeister-App fand genau diese Art Test die Zeile
/// `WS received: <erste 100 Zeichen>`, die der Quelltext-Wächter nicht sieht —
/// dieselbe Zeile stand hier. Der Inhalt steht VORN im Rahmen, sonst sähe eine
/// Zeile, die nur den Anfang protokolliert, ihn nicht.
///
/// MIT TestWidgetsFlutterBinding: eine Nachricht des Vorstands geht als
/// dringende Benachrichtigung hinaus — dafür braucht das Benachrichtigungs-
/// Plugin eine Gegenstelle (die Android-Fassung, ihr Kanal antwortet hier).
/// Die Bindung ersetzt aber jeden HttpClient durch eine Attrappe — deshalb
/// läuft die Verbindung unter [_EchtesNetz].
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  AndroidFlutterLocalNotificationsPlugin.registerWith();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      (aufruf) async => aufruf.method == 'initialize' ? true : null);

  late HttpServer server;
  late List<WebSocket> verbindungen;

  setUp(() async {
    verbindungen = [];
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((anfrage) async {
      final ws = await WebSocketTransformer.upgrade(anfrage);
      verbindungen.add(ws);
      ws.listen((roh) {
        final data = jsonDecode(roh as String) as Map<String, dynamic>;
        if (data['type'] == 'auth') {
          ws.add(jsonEncode({'type': 'auth_success', 'user_id': 13}));
        }
      }, onError: (_) {}, cancelOnError: true);
    });
    ChatService.testWsUrl = 'ws://127.0.0.1:${server.port}/';
    final verbunden =
        await HttpOverrides.runWithHttpOverrides(() => ChatService().connect('M10001'), _EchtesNetz());
    expect(verbunden, isTrue);
  });

  tearDown(() async {
    ChatService().disconnect();
    ChatService.testWsUrl = null;
    for (final ws in verbindungen) {
      await ws.close().catchError((_) => null);
    }
    await server.close(force: true);
  });

  Future<void> kurz() => Future<void>.delayed(const Duration(milliseconds: 150));
  Iterable<String> zeilen() => LoggerService().logs.map((e) => e.message);

  test('eine Nachricht des Vorstands: kein Wort davon im Protokoll — aber die Zeile ist da', () async {
    verbindungen.single.add(jsonEncode({
      'type': 'new_message',
      'message': 'MARKE-CHATTEXT Ihr Bescheid ist da',
      'sender_name': 'MARKE-ABSENDER',
      'message_id': 901,
      'conversation_id': 34,
      'sender_id': 2,
      'sender_role': 'vorsitzer',
      'is_admin': true,
      'created_at': '2026-10-17 10:00:00',
    }));
    await kurz();

    expect(zeilen().where((z) => z.contains('MARKE-CHATTEXT')), isEmpty);
    expect(zeilen().where((z) => z.startsWith('WS received: ') && z.endsWith(' Z.')), isNotEmpty,
        reason: 'nicht blind: der Rahmen kam an, die Länge steht da');
  });

  test('eine Ticket-Benachrichtigung: weder Titel noch Text', () async {
    verbindungen.single.add(jsonEncode({
      'type': 'ticket_notification',
      'title': 'MARKE-TITEL',
      'message': 'MARKE-TICKETTEXT',
      'ticket_subject': 'MARKE-BETREFF',
      'ticket_id': 42,
      'notification_type': 'comment_added',
      'sender_name': 'Vorsitz',
      'timestamp': '2026-10-17 10:00:00',
    }));
    await kurz();

    for (final marke in ['MARKE-TITEL', 'MARKE-TICKETTEXT', 'MARKE-BETREFF']) {
      expect(zeilen().where((z) => z.contains(marke)), isEmpty, reason: marke);
    }
  });
}

/// Ein echter HttpClient statt der Attrappe der Testbindung.
class _EchtesNetz extends HttpOverrides {}
