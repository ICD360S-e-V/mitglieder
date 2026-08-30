import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;
import '../services/remote_agent_service.dart';

/// While a Fernwartung session is active, draws a visible ripple wherever the
/// member touches the screen. The ripple is rendered INTO the app, so it is
/// picked up by the screen capture — the Vorsitzer sees exactly where the member
/// is tapping ("mark what the member pressed"). Renders nothing and adds no
/// overhead when no session is active. Passive: it observes pointer events but
/// never blocks them, so the app keeps working normally.
class RemoteTouchOverlay extends StatefulWidget {
  final Widget child;
  const RemoteTouchOverlay({super.key, required this.child});

  @override
  State<RemoteTouchOverlay> createState() => _RemoteTouchOverlayState();
}

class _RemoteTouchOverlayState extends State<RemoteTouchOverlay>
    with SingleTickerProviderStateMixin {
  final RemoteAgentService _agent = RemoteAgentService();
  StreamSubscription<RemoteAgentState>? _sub;
  bool _sharing = false;

  final Map<int, Offset> _active = {}; // live touches by pointer id
  final List<_Ripple> _ripples = [];   // released taps, fading out
  static const int _fadeMs = 650;

  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _sharing = _agent.isSharing;
    _sub = _agent.stateStream.listen((s) {
      final sharing = s != RemoteAgentState.idle;
      if (mounted && sharing != _sharing) {
        setState(() {
          _sharing = sharing;
          if (!sharing) {
            _active.clear();
            _ripples.clear();
          }
        });
        _taktAnpassen();
      }
    });
    _ticker = createTicker(_tick);
    if (_sharing) _ticker.start();
  }

  /// Der Ticker laeuft NUR waehrend einer Sitzung.
  ///
  /// ⚠️ Ein aktiver Ticker fordert bei JEDEM vsync einen Frame an — die App
  /// zeichnet dann dauerhaft mit 60/120 fps, statt in den Leerlauf zu gehen.
  /// Er stand hier unbedingt in `initState`, also auf jedem Mitgliedsgeraet,
  /// rund um die Uhr, fuer eine Funktion, die noch nie benutzt wurde. `_tick`
  /// stieg zwar sofort wieder aus, aber die Frames waren da.
  /// Dieses Widget haengt ueber dem Navigator, hat also keinen `TickerMode`
  /// als Vorfahren, der ihn stummschalten koennte.
  void _taktAnpassen() {
    if (_sharing && !_ticker.isActive) {
      _ticker.start();
    } else if (!_sharing && _ticker.isActive) {
      _ticker.stop();
    }
  }

  void _tick(Duration _) {
    if (!_sharing) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final before = _ripples.length;
    _ripples.removeWhere((r) => now - r.startMs > _fadeMs);
    if (_active.isNotEmpty || _ripples.isNotEmpty || _ripples.length != before) {
      setState(() {});
    }
  }

  void _down(PointerDownEvent e) {
    if (_sharing) setState(() => _active[e.pointer] = e.localPosition);
  }

  void _move(PointerMoveEvent e) {
    if (_sharing && _active.containsKey(e.pointer)) {
      setState(() => _active[e.pointer] = e.localPosition);
    }
  }

  void _end(PointerEvent e) {
    if (!_sharing) return;
    setState(() {
      final p = _active.remove(e.pointer);
      if (p != null) _ripples.add(_Ripple(p, DateTime.now().millisecondsSinceEpoch));
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _ticker
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_sharing) return widget.child;
    return Stack(
      children: [
        Listener(
          behavior: HitTestBehavior.deferToChild,
          onPointerDown: _down,
          onPointerMove: _move,
          onPointerUp: _end,
          onPointerCancel: _end,
          child: widget.child,
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _TouchPainter(
                Map<int, Offset>.from(_active),
                List<_Ripple>.from(_ripples),
                _fadeMs,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Ripple {
  final Offset pos;
  final int startMs;
  _Ripple(this.pos, this.startMs);
}

class _TouchPainter extends CustomPainter {
  final Map<int, Offset> active;
  final List<_Ripple> ripples;
  final int fadeMs;
  _TouchPainter(this.active, this.ripples, this.fadeMs);

  static const Color _c = Color(0xFF2196F3);

  @override
  void paint(Canvas canvas, Size size) {
    // Live touches: solid dot + ring.
    for (final p in active.values) {
      canvas.drawCircle(p, 22, Paint()..color = _c.withValues(alpha: 0.25));
      canvas.drawCircle(p, 10, Paint()..color = _c.withValues(alpha: 0.9));
      canvas.drawCircle(
        p,
        22,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = _c.withValues(alpha: 0.9),
      );
    }
    // Released taps: expanding, fading ring.
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final r in ripples) {
      final t = ((now - r.startMs) / fadeMs).clamp(0.0, 1.0);
      final radius = 14 + 30 * t;
      final alpha = (1.0 - t) * 0.8;
      canvas.drawCircle(
        r.pos,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = _c.withValues(alpha: alpha),
      );
    }
  }

  @override
  bool shouldRepaint(_TouchPainter old) => true;
}
