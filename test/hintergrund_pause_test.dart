import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/hintergrund_pause.dart';

/// Zählt, wie oft der Takt gefeuert hat.
class _Probe extends StatefulWidget {
  const _Probe({required this.intervall, this.sofort = false});
  final Duration intervall;
  final bool sofort;

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> with HintergrundPause<_Probe> {
  int takte = 0;

  @override
  void initState() {
    super.initState();
    taktSetzen(#probe, widget.intervall, () => takte++, sofort: widget.sofort);
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

void main() {
  /// Bringt das Widget in den Baum und gibt seinen State zurück.
  Future<_ProbeState> aufbauen(
    WidgetTester tester, {
    Duration intervall = const Duration(seconds: 10),
    bool sofort = false,
  }) async {
    await tester.pumpWidget(
      MaterialApp(home: _Probe(intervall: intervall, sofort: sofort)),
    );
    return tester.state<_ProbeState>(find.byType(_Probe));
  }

  group('HintergrundPause', () {
    testWidgets('taktet im Vordergrund', (tester) async {
      final s = await aufbauen(tester);
      await tester.pump(const Duration(seconds: 35));
      expect(s.takte, 3);
      s.taktLoeschen(#probe);
    });

    testWidgets('sofort führt die Arbeit zusätzlich direkt aus',
        (tester) async {
      final s = await aufbauen(tester, sofort: true);
      expect(s.takte, 1);
      s.taktLoeschen(#probe);
    });

    testWidgets('im Hintergrund ruht der Takt', (tester) async {
      final s = await aufbauen(tester);
      await tester.pump(const Duration(seconds: 25));
      expect(s.takte, 2);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump();
      expect(s.imVordergrund, isFalse);
      expect(s.taktLaeuft(#probe), isFalse);

      // Eine Minute Hintergrund darf nichts auslösen.
      await tester.pump(const Duration(seconds: 60));
      expect(s.takte, 2);
      s.taktLoeschen(#probe);
    });

    testWidgets('beim Zurückkehren wird einmal sofort nachgeholt',
        (tester) async {
      // Der Grund, warum solche Pausen sonst wieder ausgebaut werden: ohne
      // das Nachholen sähe das Mitglied bis zum ersten Tick alte Daten.
      final s = await aufbauen(tester);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump(const Duration(seconds: 60));
      expect(s.takte, 0);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(s.takte, 1, reason: 'sofortiges Nachholen fehlt');
      expect(s.taktLaeuft(#probe), isTrue);

      await tester.pump(const Duration(seconds: 10));
      expect(s.takte, 2);
      s.taktLoeschen(#probe);
    });

    testWidgets('inactive gilt nicht als Hintergrund', (tester) async {
      // Tritt auch beim kurzen Überlagern auf (Anrufbildschirm,
      // Benachrichtigungsleiste) und wäre ein zu hektischer Auslöser.
      final s = await aufbauen(tester);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await tester.pump();
      expect(s.imVordergrund, isFalse);
      s.taktLoeschen(#probe);
    });

    testWidgets('derselbe Schlüssel ersetzt, statt zu verdoppeln',
        (tester) async {
      final s = await aufbauen(tester);
      s.taktSetzen(#probe, const Duration(seconds: 10), () => s.takte += 100);
      await tester.pump(const Duration(seconds: 10));
      // Nur der neue Takt feuert: 100, nicht 101.
      expect(s.takte, 100);
      s.taktLoeschen(#probe);
    });

    testWidgets('dispose räumt den Takt ab', (tester) async {
      final s = await aufbauen(tester);
      await tester.pump(const Duration(seconds: 10));
      expect(s.takte, 1);
      // Ohne Abräumen bemängelte das Testgerüst einen offenen Timer.
      await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
      await tester.pump(const Duration(seconds: 60));
      expect(s.takte, 1);
    });

    testWidgets('taktLoeschen mit unbekanntem Schlüssel ist folgenlos',
        (tester) async {
      final s = await aufbauen(tester);
      s.taktLoeschen(#gibtesnicht);
      expect(s.taktLaeuft(#probe), isTrue);
      s.taktLoeschen(#probe);
    });
  });
}
