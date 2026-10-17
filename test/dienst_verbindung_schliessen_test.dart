import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/background_service.dart';
import 'package:web_socket_channel/io.dart';

/// App-Fehler #133: der Dienst schloss seine Verbindung mit 1001 (goingAway).
/// web_socket_channel 3 baut auch IOWebSocketChannel auf package:web_socket,
/// und das wirft dann — asynchron, am try/catch vorbei — einen ArgumentError
/// und schliesst die Verbindung NICHT; die alte blieb neben der neuen offen.
///
/// Geprüft am Lauf: ein WebSocket auf localhost, verbunden mit derselben
/// Klasse wie im Dienst (IOWebSocketChannel), dann
/// [BackgroundService.closeConnection]. Der Server muss das Schliessen mit 1000
/// sehen, in der Zone darf kein Fehler landen, und das Abo des Dienstes darf
/// danach nichts mehr melden — auch kein onDone.
///
/// Ohne TestWidgetsFlutterBinding; die Verbindung läuft trotzdem unter
/// [_EchtesNetz], falls eine Bindung den HttpClient ersetzt hat.
void main() {
  late HttpServer server;
  late Completer<WebSocket> serverSeite;

  setUp(() async {
    serverSeite = Completer<WebSocket>();
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((anfrage) async => serverSeite.complete(await WebSocketTransformer.upgrade(anfrage)));
  });

  tearDown(() => server.close(force: true));

  /// Verbindet wie der Dienst, schliesst mit [BackgroundService.closeConnection]
  /// und liefert, was dabei geschah. `schliesscode` -1: der Server sah binnen
  /// 3 s kein Schliessen — die Verbindung blieb offen.
  Future<({int? schliesscode, List<Object> fehler, bool onDone})> lauf() {
    return HttpOverrides.runWithHttpOverrides(() async {
      final fehler = <Object>[];
      var onDone = false;
      final ende = Completer<int?>();
      await runZonedGuarded(() async {
        final channel = IOWebSocketChannel.connect(Uri.parse('ws://127.0.0.1:${server.port}/'));
        await channel.ready;
        final ws = await serverSeite.future;
        ws.listen((_) {}, onDone: () => ende.complete(ws.closeCode));
        final abo = channel.stream.listen((_) {}, onDone: () => onDone = true);
        BackgroundService.closeConnection(channel, abo);
      }, (e, _) => fehler.add(e));
      final code = await ende.future.timeout(const Duration(seconds: 3), onTimeout: () => -1);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return (schliesscode: code, fehler: fehler, onDone: onDone);
    }, _EchtesNetz());
  }

  test('closeConnection schliesst mit 1000 — der Server sieht es, kein Fehler in der Zone', () async {
    final r = await lauf();
    expect(r.fehler, isEmpty, reason: 'ein Fehler beim Schliessen (1001 → ArgumentError, App-Fehler #133)');
    expect(r.schliesscode, 1000, reason: '-1 = Verbindung blieb offen');
  });

  test('nach closeConnection meldet das alte Abo nichts mehr — auch kein onDone', () async {
    final r = await lauf();
    expect(r.schliesscode, 1000);
    expect(r.onDone, isFalse, reason: 'das späte onDone der alten Verbindung brach im Dienst die neue ab');
  });

  test('ohne Verbindung und ohne Abo: kein Fehler', () {
    expect(() => BackgroundService.closeConnection(null, null), returnsNormally);
  });
}

class _EchtesNetz extends HttpOverrides {}
