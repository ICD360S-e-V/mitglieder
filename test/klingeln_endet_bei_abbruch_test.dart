// Haelt fest, WER erfaehrt, dass der Anrufer aufgelegt hat.
//
// Am 11.09.2026 niemand, der es brauchte. Auf `callEndedStream` hoerte allein
// der Chat-Dialog; klingelt das Telefon vom Dashboard aus, ist der gar nicht
// offen, und ein `broadcast`-Strom puffert nichts — das Ereignis war weg.
// Gemessen an den Protokollen beider Seiten: der Anrufer legt nach ~30 s auf,
// der Klingelschirm der Gegenseite laeutet weiter, und wer danach abnimmt,
// baut eine Verbindung zu einer Gegenstelle auf, die es nicht mehr gibt. Der
// Server antwortete darauf sogar mit {"error":"No active call"}; die App
// drehte trotzdem 15 s „verbinde…", bis ICE aufgab. FUENFMAL an einem Abend —
// das ist das gemeldete „der erste Anruf geht nie, der zweite schon".
//
// Ein laufender Anruf ist von einem Test aus nicht herstellbar (WebSocket,
// TURN, Mikrofon), deshalb wird der Quelltext geprueft. Jede Zusicherung ist
// gegengeprobt: nimmt man die Reparatur zurueck, wird sie rot.
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Zeilenkommentare weg — sonst bestaetigt der Test die Erklaerung ueber dem
/// Code statt den Code. Die Laenge bleibt gleich, damit Fundstellen stimmen.
String ohneKommentare(String q) => q
    // ⚠️ BLOCKkommentare zuerst, und zwar laengentreu: sonst bestaetigt eine
    // Zusicherung auskommentierten Code. Genau daran ist die Gegenprobe
    // dieses Tests im ersten Anlauf vorbeigelaufen — `/*handleCallEnded();*/`
    // blieb gruen.
    .replaceAllMapped(RegExp(r'/\*.*?\*/', dotAll: true),
        (m) => m[0]!.replaceAll(RegExp(r'[^\n]'), ' '))
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i);
    })
    .join('\n');

/// Schneidet die Closure hinter einem Anker aus — ab der ersten `{` DANACH.
///
/// ⚠️ [rumpf] taugt dafuer nicht: bei `stream.listen((e) {` steht die
/// oeffnende Klammer nicht auf runder Tiefe 0.
String closureNach(String quelle, String anker) {
  final a = quelle.indexOf(anker);
  expect(a, greaterThanOrEqualTo(0), reason: 'Anker nicht gefunden: $anker');
  var i = quelle.indexOf('{', a);
  expect(i, greaterThanOrEqualTo(0), reason: 'keine Closure nach: $anker');
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
  fail('Closure nicht geschlossen: $anker');
}

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
  late String dashboard;

  setUpAll(() {
    dienst = ohneKommentare(
        File('lib/services/voice_call_service.dart').readAsStringSync());
    dashboard = ohneKommentare(
        File('lib/screens/mitglied_dashboard.dart').readAsStringSync());
  });

  String beendetMethode() =>
      rumpf(dienst, 'void _signalAnrufBeendet(CallEndedEvent event)');
  String klingeln() =>
      rumpf(dashboard, 'void _handleIncomingCall(CallOfferEvent event)');
  String annehmen() => rumpf(dashboard,
      'void _acceptCall(CallOfferEvent event, {VoidCallback? beiFehlschlag})');

  group('Der Dienst erfaehrt das Auflegen selbst', () {
    test('abonniert im Konstruktor, nicht in einem Widget', () {
      final ctor = rumpf(dienst, 'VoiceCallService._internal()');
      expect(ctor, contains('callEndedStream.listen'),
          reason: 'ohne Abo im Dienst haengt es wieder am Live-Chat-Dialog, '
              'der beim Klingeln vom Dashboard aus nicht offen ist');
      expect(ctor, contains('_signalAnrufBeendet'));
    });

    test('gefiltert auf die Konversation des laufenden Anrufs', () {
      expect(beendetMethode(),
          contains('event.conversationId != _currentConversationId'));
    });

    test('ein schon aufgeraeumter Anruf wird nicht noch einmal abgeraeumt', () {
      expect(beendetMethode(), contains('_callState == CallState.idle'));
    });

    test('und es raeumt wirklich ab', () {
      expect(beendetMethode(), contains('handleCallEnded()'),
          reason: 'nur so faellt der Zustand auf idle — und nur dann wird der '
              'NAECHSTE eingehende Anruf nicht als „besetzt" abgewiesen');
    });

    test('das Abo endet mit dem Dienst', () {
      expect(dienst, contains('_signalEndeAbo?.cancel()'));
    });
  });

  group('Der Klingelschirm', () {
    test('schliesst sich selbst, wenn der Anrufer auflegt', () {
      final k = klingeln();
      expect(k, contains('callEndedStream.listen'),
          reason: 'DAS ist der Fehler vom 11.09.2026');
      expect(k, contains('schliessen(ctx)'));
    });

    test('nur bei SEINER Konversation', () {
      expect(klingeln(), contains('e.conversationId != event.conversationId'));
    });

    test('sagt es auch, statt nur zu verschwinden', () {
      // ⚠️ Im Zuhoerer selbst, nicht irgendwo im Rumpf: dieselbe Meldung
      // steht auch im Ausgang fuer „zu spaet angenommen", und eine Suche
      // ueber die ganze Methode blieb deshalb gruen, als sie hier fehlte.
      expect(closureNach(klingeln(), 'callEndedStream.listen'),
          contains('_anrufWeggemeldet()'),
          reason: 'ein wortlos verschwindender Schirm ist von einem Absturz '
              'nicht zu unterscheiden');
    });

    test('und laesst kein Abo hinter sich', () {
      expect(klingeln(), contains('endeAbo?.cancel()'));
    });

    test('lehnt ueber den DIENST ab, nicht an ihm vorbei', () {
      // ⚠️ Hier ist der Dienst `ringing` (das Dashboard meldet ihm den Anruf
      // selbst). Der direkte Weg ueber `_chatService` liess ihn darauf
      // stehen — der naechste eingehende Anruf wurde dann als „besetzt"
      // abgewiesen, ohne dass jemand telefonierte. Am 11.09.2026 dreimal.
      expect(klingeln(), contains('_voiceCallService.rejectCall()'));
      expect(klingeln().contains('_chatService.sendCallReject('), isFalse);
    });
  });

  group('Zu spaet angenommen', () {
    test('fuehrt aus dem Klingelschirm heraus, statt ihn stehen zu lassen', () {
      expect(annehmen(), contains('beiFehlschlag?.call()'),
          reason: 'acceptCall() weist einen abgelaufenen Anruf ab; ohne '
              'Ausgang bliebe der Schirm stumm stehen');
    });

    test('der Ausgang haengt am Fehlschlag, nicht am Erfolg', () {
      // Bei Erfolg ersetzt _acceptCall den Schirm selbst — ein Pop dort
      // wuerde den frisch geoeffneten Gespraechsschirm mitnehmen.
      final k = klingeln();
      expect(k, contains('beiFehlschlag:'));
      expect(k, contains('_acceptCall(event, beiFehlschlag:'));
    });
  });
}
