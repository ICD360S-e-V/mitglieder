import 'dart:async';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/remote_agent_service.dart';
import '../utils/app_theme.dart';

/// Always-visible banner shown on the MEMBER side while a Fernwartung session is
/// being set up or is live. Two jobs: make it unmistakable that the screen is
/// being shared, and give a one-tap "Stop" that is always reachable.
///
/// Place it at the top of the member's home scaffold; it renders nothing when
/// no session is active.
class RemoteSharingBanner extends StatefulWidget {
  const RemoteSharingBanner({super.key});

  @override
  State<RemoteSharingBanner> createState() => _RemoteSharingBannerState();
}

class _RemoteSharingBannerState extends State<RemoteSharingBanner> {
  final RemoteAgentService _agent = RemoteAgentService();
  StreamSubscription<RemoteAgentState>? _sub;
  RemoteAgentState _state = RemoteAgentState.idle;
  bool _stumm = false;

  @override
  void initState() {
    super.initState();
    _state = _agent.state;
    _sub = _agent.stateStream.listen((s) {
      // Nach dem Sitzungsende wieder auf „nicht stumm": der naechste Anlauf
      // faengt sonst mit einem Mikrofon an, das der Schalter als offen anzeigt.
      if (!mounted) return;
      setState(() {
        _state = s;
        if (s == RemoteAgentState.idle) _stumm = false;
      });
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_state == RemoteAgentState.idle) return const SizedBox.shrink();
    // 🔴 Vorher eine eigene Tabelle mit sechs Sprachen und deutschem Rückfall —
    // ausgerechnet in der Zeile, die sagt, dass gerade der Bildschirm geteilt
    // wird. Jetzt aus den .arb-Dateien, also in allen 28.
    final l10n = AppLocalizations.of(context)!;
    final connecting = _state == RemoteAgentState.connecting;
    final label = connecting ? l10n.fernwartungVerbindet : l10n.fernwartungAktiv;
    return Material(
      color: connecting ? context.colors.warningFg : context.colors.dangerFg,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(connecting ? Icons.sync : Icons.screen_share, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              // Stummschalten, ohne die Sitzung zu beenden. Nur wenn ueberhaupt
              // ein Mikrofon anliegt — sonst waere der Knopf ein Versprechen
              // ohne Deckung.
              if (_agent.hatMikrofon)
                IconButton(
                  tooltip: _stumm ? l10n.fernwartungMikroAn : l10n.fernwartungMikroAus,
                  icon: Icon(_stumm ? Icons.mic_off : Icons.mic, color: Colors.white),
                  onPressed: () {
                    _agent.mikrofonStumm(!_stumm);
                    setState(() => _stumm = !_stumm);
                  },
                ),
              TextButton(
                onPressed: () => _agent.stop(reason: 'member_stop'),
                style: TextButton.styleFrom(
                  backgroundColor: context.colors.card,
                  foregroundColor: context.colors.dangerFg,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                ),
                child: Text(l10n.fernwartungStopp, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
