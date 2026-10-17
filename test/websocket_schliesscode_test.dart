import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// App-Fehler #133: `channel?.sink.close(status.goingAway)` im Dienst. Für die
/// WebSocket-Kanäle (web_socket_channel 3 → package:web_socket) gilt als
/// Schliesscode nur 1000 oder 3000–4999 — sonst ArgumentError, und die
/// Verbindung bleibt offen.
///
/// Der Wächter liest jeden Aufruf `sink.close(…)` in lib/ (Kommentarzeilen
/// ausgenommen) und lässt nur ohne Code, mit normalClosure, 1000 oder
/// 3000–4999 durch. Im Dienst geht jedes Schliessen über closeConnection —
/// dort steht `sink.close(` genau einmal. Die zweite Prüfung, am Lauf:
/// `dienst_verbindung_schliessen_test.dart`.
final _schliessen = RegExp(r'\bsink\s*\.\s*close\s*\(([^)]*)\)');

/// Ist das Argument eines `sink.close(…)` ein erlaubter Schliesscode?
bool erlaubt(String argumente) {
  final code = argumente.split(',').first.trim();
  if (code.isEmpty) return true;
  if (code == 'status.normalClosure' || code == 'WebSocketStatus.normalClosure') return true;
  final zahl = int.tryParse(code);
  return zahl != null && (zahl == 1000 || (zahl >= 3000 && zahl <= 4999));
}

/// Jeder Aufruf `sink.close(…)` außerhalb von Kommentarzeilen: (Ort, Argumente).
List<(String, String)> aufrufe(File datei) {
  final aus = <(String, String)>[];
  final zeilen = datei.readAsLinesSync();
  for (var i = 0; i < zeilen.length; i++) {
    final z = zeilen[i].trimLeft();
    if (z.startsWith('//') || z.startsWith('*') || z.startsWith('/*')) continue;
    for (final m in _schliessen.allMatches(zeilen[i])) {
      aus.add(('${datei.path}:${i + 1}', m.group(1)!));
    }
  }
  return aus;
}

void main() {
  test('der Wächter selbst: was er erlaubt und was nicht', () {
    expect(erlaubt(''), isTrue);
    expect(erlaubt('status.normalClosure'), isTrue);
    expect(erlaubt("status.normalClosure, 'tschüss'"), isTrue);
    expect(erlaubt('1000'), isTrue);
    expect(erlaubt('3000'), isTrue);
    expect(erlaubt('4999'), isTrue);
    expect(erlaubt('status.goingAway'), isFalse);
    expect(erlaubt('WebSocketStatus.goingAway'), isFalse);
    expect(erlaubt('1001'), isFalse);
    expect(erlaubt('5000'), isFalse);
    expect(_schliessen.firstMatch('channel?.sink.close(status.goingAway);')!.group(1), 'status.goingAway');
  });

  test('kein sink.close(…) in lib/ mit einem Code, den package:web_socket ablehnt', () {
    final dateien = Directory('lib').listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
    final alle = [for (final f in dateien) ...aufrufe(f)];
    expect(alle.length, greaterThanOrEqualTo(5), reason: 'der Wächter findet die Aufrufe nicht mehr');
    final falsch = [for (final (ort, arg) in alle) if (!erlaubt(arg)) '$ort: sink.close($arg)'];
    expect(falsch, isEmpty);
  });

  test('im Dienst geht jedes Schliessen über closeConnection', () {
    final imDienst = aufrufe(File('lib/services/background_service.dart'));
    expect(imDienst.map((a) => a.$2), ['status.normalClosure'],
        reason: 'ein zweites sink.close( im Dienst kündigt das Abo nicht — die alte Verbindung meldete weiter');
  });
}
