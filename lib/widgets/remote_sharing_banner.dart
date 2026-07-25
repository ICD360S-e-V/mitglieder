import 'dart:async';
import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../services/remote_agent_service.dart';

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

  @override
  void initState() {
    super.initState();
    _state = _agent.state;
    _sub = _agent.stateStream.listen((s) {
      if (mounted) setState(() => _state = s);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Map<String, String> get _t {
    const table = {
      'de': {'connecting': 'Verbindung wird aufgebaut …', 'active': 'Ihr Bildschirm wird geteilt', 'stop': 'Stopp'},
      'ro': {'connecting': 'Se conectează …', 'active': 'Ecranul dvs. este partajat', 'stop': 'Stop'},
      'uk': {'connecting': 'З’єднання …', 'active': 'Ваш екран демонструється', 'stop': 'Стоп'},
      'tr': {'connecting': 'Bağlanıyor …', 'active': 'Ekranınız paylaşılıyor', 'stop': 'Durdur'},
      'en': {'connecting': 'Connecting …', 'active': 'Your screen is being shared', 'stop': 'Stop'},
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
      color: connecting ? Colors.orange.shade800 : Colors.red.shade700,
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
              TextButton(
                onPressed: () => _agent.stop(reason: 'member_stop'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red.shade800,
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
