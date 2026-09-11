import 'package:flutter/material.dart';

import '../services/anruf_rueckweg.dart';
import '../services/voice_call_service.dart';

/// Gruen der Anruf-Leiste. Weiss darauf kommt auf 5,13:1, ueber dem
/// AA-Schwellwert von 4,5:1 — `anruf_leiste_test.dart` rechnet es nach.
const Color kAnrufLeisteGruen = Color(0xFF2E7D32);

/// Schmale Leiste ueber der ganzen App, solange ein Anruf laeuft und der
/// Anrufschirm nicht zu sehen ist.
class AnrufLeiste extends StatelessWidget {
  const AnrufLeiste({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dienst = VoiceCallService();
    return Stack(
      children: [
        child,
        StreamBuilder<CallState>(
          stream: dienst.callStateStream,
          initialData: dienst.callState,
          builder: (context, z) {
            final s = z.data ?? CallState.idle;
            // `ringing` gehoert dem Annehmen-Schirm, nicht der Leiste.
            final laeuft = s == CallState.calling ||
                s == CallState.connecting ||
                s == CallState.inCall;
            if (!laeuft) return const SizedBox.shrink();
            return ValueListenableBuilder<bool>(
              valueListenable: AnrufRueckweg.schirmSichtbar,
              builder: (context, sichtbar, _) {
                if (sichtbar) return const SizedBox.shrink();
                return Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: SafeArea(
                      bottom: false,
                      child: Container(
                        color: kAnrufLeisteGruen,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.call,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                s == CallState.inCall
                                    ? 'Anruf läuft'
                                    : 'Anruf wird verbunden …',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (AnrufRueckweg.oeffner != null)
                              TextButton(
                                onPressed: AnrufRueckweg.zurueck,
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.white),
                                child: const Text('Zurück'),
                              ),
                            // ⚠️ Auflegen MUSS hier sein: sonst laesst sich ein
                            // Anruf, dessen Gegenstelle nicht mehr antwortet,
                            // nur per App-Neustart beenden — und bis dahin
                            // weist er jeden neuen Anruf mit „busy" ab.
                            IconButton(
                              tooltip: 'Auflegen',
                              onPressed: () => VoiceCallService().endCall(),
                              icon: const Icon(Icons.call_end,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
