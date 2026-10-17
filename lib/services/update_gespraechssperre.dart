import 'dart:async';

import 'remote_agent_service.dart';
import 'voice_call_service.dart';

/// Kein automatisches Update während eines Gesprächs.
///
/// Kopie aus der Vorsitzer-App (17.10.2026). WARUM dort (06.10.2026, Protokoll
/// des Fold): Android beendet die App, sobald es ihr Paket ersetzt — und mit
/// ihr jedes Gespräch, denn WebRTC lebt in ihrem Prozess. Eine
/// Selbstaktualisierung, die VOR dem Gespräch zu laden begann, installierte
/// mitten hinein; das Gespräch war weg.
///
/// Gesperrt ist, solange
///  * ein Anruf mit dem Verein klingelt, gewählt wird, aufgebaut wird oder
///    läuft,
///  * eine Fernwartung aufgebaut wird oder läuft — der Vorsitzende sieht
///    gerade den Bildschirm des Mitglieds; mit der App wäre auch sie weg.
///
/// ⚠️ ZWEIMAL PRÜFEN: vor dem Laden UND vor dem Installieren. Das Laden dauert
/// eine Weile — genau in die fiel bei der Vorsitzer-App die Annahme des
/// Gesprächs.
///
/// Nur die AUTOMATISCHE Aktualisierung wartet. Wer im Dialog selbst
/// „Jetzt aktualisieren" drückt, entscheidet selbst.
abstract final class UpdateGespraechssperre {
  /// Darf jetzt automatisch installiert werden?
  static bool get gesperrt => grund != null;

  /// Was gerade sperrt — fürs Protokoll, ohne Namen; `null`: nichts.
  static String? get grund {
    if (VoiceCallService().callState != CallState.idle) return 'Anruf';
    if (RemoteAgentService().isSharing) return 'Fernwartung';
    return null;
  }

  /// Wartet, bis nichts mehr sperrt — sofort, wenn nichts sperrt.
  static Future<void> abwarten() {
    if (!gesperrt) return Future<void>.value();
    final fertig = Completer<void>();
    StreamSubscription<CallState>? anruf;
    StreamSubscription<RemoteAgentState>? fernwartung;
    void pruefen() {
      if (fertig.isCompleted || gesperrt) return;
      unawaited(anruf?.cancel());
      unawaited(fernwartung?.cancel());
      fertig.complete();
    }

    anruf = VoiceCallService().callStateStream.listen((_) => pruefen());
    fernwartung = RemoteAgentService().stateStream.listen((_) => pruefen());
    return fertig.future;
  }
}
