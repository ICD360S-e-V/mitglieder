// Haelt fest, WER die ICE-Kandidaten aus der Signalisierung abholt.
//
// Am 10.09.2026 tat es allein `live_chat_dialog.dart`. Das Annehmen eines
// Anrufs war laengst in `mitglied_dashboard.dart` gewandert; war der Dialog
// nicht montiert, fielen die Kandidaten des Anrufers in einen
// `broadcast`-Stream ohne Zuhoerer und waren weg. Ergebnis: die angerufene
// Seite legte am TURN-Server keine Permission an, ihr Relay verwarf jede
// Verbindungspruefung, ICE blieb fuer immer in `Checking` — kein einziges Byte,
// und es sah nach einem Zufall aus, weil es davon abhing, ob der Chat-Dialog
// offen stand.
//
// Ein laufender Anruf ist von einem Test aus nicht herstellbar (WebSocket,
// TURN, Kamera), deshalb wird der Quelltext geprueft. Jede Zusicherung ist
// gegengeprobt: nimmt man die Reparatur zurueck, wird sie rot.
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Zeilenkommentare weg — sonst bestaetigt der Test die Erklaerung ueber dem
/// Code statt den Code. Die Laenge bleibt gleich, damit Fundstellen stimmen.
String ohneKommentare(String q) => q
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i);
    })
    .join('\n');

/// Schneidet ab dem Kopf bis zur ausgeglichenen schliessenden Klammer.
///
/// ⚠️ Erst die runden Klammern des Kopfes ausgleichen, dann die geschweiften:
/// bei `foo({int a}) {` ist die erste `{` die PARAMETERLISTE, und ein Test, der
/// dort zu schneiden beginnt, prueft einen anderen Bereich als er sagt.
String rumpf(String quelle, String kopf) {
  final start = quelle.indexOf(kopf);
  expect(start, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  var i = start;
  var rund = 0;
  while (i < quelle.length) {
    final c = quelle[i];
    if (c == '(') rund++;
    if (c == ')') rund--;
    if (c == '{' && rund == 0) break;
    i++;
  }
  expect(i, lessThan(quelle.length), reason: 'kein Rumpfanfang: $kopf');
  var tiefe = 0;
  final ab = i;
  while (i < quelle.length) {
    if (quelle[i] == '{') tiefe++;
    if (quelle[i] == '}') {
      tiefe--;
      if (tiefe == 0) return quelle.substring(ab, i + 1);
    }
    i++;
  }
  fail('Rumpf nicht geschlossen: $kopf');
}

void main() {
  late String dienst;
  late String dialog;

  setUpAll(() {
    dienst = ohneKommentare(
        File('lib/services/voice_call_service.dart').readAsStringSync());
    dialog = ohneKommentare(
        File('lib/widgets/live_chat_dialog.dart').readAsStringSync());
  });

  group('ICE-Kandidaten', () {
    test('der DIENST abonniert sie, und zwar im Konstruktor', () {
      final ctor = rumpf(dienst, 'VoiceCallService._internal()');
      expect(ctor, contains('iceCandidateStream.listen'),
          reason: 'ohne Abo im Dienst haengt das Abholen wieder an einem Widget');
      expect(ctor, contains('_signalIceKandidat'));
    });

    test('KEIN Widget abonniert sie mehr', () {
      // Ein zweiter Zuhoerer wuerde jeden Kandidaten doppelt einreichen.
      expect(dialog.contains('iceCandidateStream'), isFalse,
          reason: 'live_chat_dialog.dart darf die Kandidaten nicht abholen');
      for (final p in Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => !f.path.endsWith('services/chat_service.dart'))
          .where((f) => !f.path.endsWith('services/voice_call_service.dart'))) {
        expect(ohneKommentare(p.readAsStringSync()).contains('iceCandidateStream'),
            isFalse,
            reason: '${p.path} abonniert die ICE-Kandidaten ebenfalls');
      }
    });

    test('gefiltert wird auf die Konversation des laufenden Anrufs', () {
      final h = rumpf(dienst, 'void _signalIceKandidat(');
      expect(h, contains('_currentConversationId == null'),
          reason: 'ohne Anruf darf kein Kandidat in die Warteschlange fallen');
      expect(h, contains('event.conversationId != _currentConversationId'));
      expect(h, contains('handleIceCandidate('));
    });

    test('das Abo ueberlebt das Ende eines Anrufs', () {
      // _cleanup() laeuft nach JEDEM Anruf. Wird das Abo dort abgebaut, ist
      // der zweite Anruf der Sitzung wieder stumm — genau der Fehler von
      // vorher, nur eine Ebene tiefer versteckt.
      final c = rumpf(dienst, 'void _cleanup()');
      expect(c.contains('_signalIceAbo'), isFalse,
          reason: '_cleanup() darf das Abo nicht anfassen');
    });
  });
}
