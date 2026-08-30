import 'dart:async';
import 'package:flutter/material.dart';
import '../services/language_service.dart';
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

  Map<String, String> get _t {
    // ⚠️ `ru` fehlte, obwohl Mitglieder Russisch eingestellt haben — die sahen
    // hier bisher Deutsch, ausgerechnet in dem Streifen, der sagt, dass gerade
    // ihr Bildschirm geteilt wird.
    const table = {
      'de': {'connecting': 'Verbindung wird aufgebaut …', 'active': 'Ihr Bildschirm wird geteilt', 'stop': 'Stopp', 'mic_on': 'Mikrofon aus', 'mic_off': 'Mikrofon an'},
      'ro': {'connecting': 'Se conectează …', 'active': 'Ecranul dvs. este partajat', 'stop': 'Stop', 'mic_on': 'Oprește microfonul', 'mic_off': 'Pornește microfonul'},
      'ru': {'connecting': 'Подключение …', 'active': 'Ваш экран демонстрируется', 'stop': 'Стоп', 'mic_on': 'Выключить микрофон', 'mic_off': 'Включить микрофон'},
      'uk': {'connecting': 'З’єднання …', 'active': 'Ваш екран демонструється', 'stop': 'Стоп', 'mic_on': 'Вимкнути мікрофон', 'mic_off': 'Увімкнути мікрофон'},
      'tr': {'connecting': 'Bağlanıyor …', 'active': 'Ekranınız paylaşılıyor', 'stop': 'Durdur', 'mic_on': 'Mikrofonu kapat', 'mic_off': 'Mikrofonu aç'},
      'en': {'connecting': 'Connecting …', 'active': 'Your screen is being shared', 'stop': 'Stop', 'mic_on': 'Mute microphone', 'mic_off': 'Unmute microphone'},
    };
    return table[LanguageService.instance.currentCode] ?? table['de']!;
  }

  @override
  Widget build(BuildContext context) {
    if (_state == RemoteAgentState.idle) return const SizedBox.shrink();
    final t = _t;
    final connecting = _state == RemoteAgentState.connecting;
    final label = connecting ? t['connecting']! : t['active']!;
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
                  tooltip: _stumm ? t['mic_off']! : t['mic_on']!,
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
                child: Text(t['stop']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
