// Die schwebende Karte für einen laufenden Chat-Anruf — und vor allem:
// dass sie NICHTS blockiert.
//
// ⚠️ WARUM DIESER TEST DER WICHTIGSTE HIER IST
// In `main.dart` steht der frühere Weg über `MaterialApp.builder` mit
// `Positioned.fill(child: GlobalChatOverlay())` **auskommentiert**, weil er auf
// Android die Knöpfe blockierte — eine Fläche über der ganzen App nimmt jede
// Berührung an, auch dort, wo sie nichts zeichnet. Es sah nach einem Freeze
// aus, und die Ursache war unsichtbar.
//
// 🔴 Die erste Fassung dieser Funktion (10.09.2026) war eine `AnrufLeiste` in
// genau jenem `builder` — gegen eine Lehre gebaut, die im Quelltext daneben
// stand. Dieser Test fällt, sobald jemand das wieder tut.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/anruf_rueckweg.dart';
import 'package:icd360sev_mitglied/services/voice_call_service.dart';
import 'package:icd360sev_mitglied/widgets/anruf_overlay.dart';

void main() {
  final dienst = VoiceCallService();

  /// Eine App mit demselben `navigatorKey`, den das Overlay benutzt, und einem
  /// Knopf am unteren Rand — also weit weg von der Karte.
  Widget appMitKnopf(VoidCallback beiDruck) => MaterialApp(
        navigatorKey: AnrufOverlay.navigatorKey,
        home: Scaffold(
          body: Column(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: beiDruck,
                child: const Text('Knopf darunter'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );

  tearDown(() {
    AnrufOverlay().abbauen();
    dienst.testZustand(CallState.idle);
    AnrufRueckweg.oeffner = null;
  });

  testWidgets('ein Knopf DARUNTER ist weiter erreichbar', (t) async {
    // Der eigentliche Zweck dieser Datei. Fällt dieser Test, blockiert das
    // Overlay die App — genau der Fehler, an dem GlobalChatOverlay gescheitert
    // ist, und den die erste Fassung dieser Karte wiederholt hat.
    var gedrueckt = 0;
    await t.pumpWidget(appMitKnopf(() => gedrueckt++));
    AnrufOverlay().aktivieren();
    dienst.testZustand(CallState.inCall, conversationId: 7);
    await t.pump();

    expect(find.text('Anruf läuft'), findsOneWidget,
        reason: 'die Karte muss da sein, sonst prüft der Test nichts');

    await t.tap(find.text('Knopf darunter'));
    await t.pump();
    expect(gedrueckt, 1,
        reason: 'Das Overlay darf nur dort Berührungen annehmen, wo es auch '
            'zeichnet. Ein Positioned.fill nimmt sie überall an — dann wirkt '
            'die App eingefroren, ohne dass etwas rot wird.');
  });

  testWidgets('bei `ringing` erscheint die Karte NICHT', (t) async {
    // Dafür gibt es den Annehmen-Schirm. Zwei Anrufanzeigen übereinander sind
    // schlimmer als eine.
    await t.pumpWidget(appMitKnopf(() {}));
    AnrufOverlay().aktivieren();
    dienst.testZustand(CallState.ringing, conversationId: 7);
    await t.pump();
    expect(find.text('Anruf läuft'), findsNothing);
    expect(find.text('Wird verbunden …'), findsNothing);
  });

  testWidgets('sie verschwindet, wenn der Anruf endet', (t) async {
    await t.pumpWidget(appMitKnopf(() {}));
    AnrufOverlay().aktivieren();
    dienst.testZustand(CallState.inCall, conversationId: 7);
    await t.pump();
    expect(find.text('Anruf läuft'), findsOneWidget);

    dienst.testZustand(CallState.idle);
    // ⚠️ ZWEI Takte. Der Zustand kommt ueber einen Stream: der Zuhoerer laeuft
    // in einem Microtask, entfernt den OverlayEntry, und erst der NAECHSTE
    // Rahmen zeichnet das Overlay ohne ihn. Mit einem Takt sieht man die Karte
    // noch — das ist Rahmen-Buchhaltung, kein stehengebliebenes Fenster.
    await t.pump();
    await t.pump();
    expect(find.text('Anruf läuft'), findsNothing,
        reason: 'eine Karte über einem beendeten Anruf wäre eine Falschaussage');
  });

  testWidgets('unterdruecken() blendet sie aus und wieder ein', (t) async {
    // So blendet der Chat-Dialog sie aus, solange er den Anruf selbst zeigt.
    await t.pumpWidget(appMitKnopf(() {}));
    AnrufOverlay().aktivieren();
    dienst.testZustand(CallState.inCall, conversationId: 7);
    await t.pump();
    expect(find.text('Anruf läuft'), findsOneWidget);

    AnrufOverlay().unterdruecken(true);
    await t.pump();
    expect(find.text('Anruf läuft'), findsNothing);

    AnrufOverlay().unterdruecken(false);
    await t.pump();
    expect(find.text('Anruf läuft'), findsOneWidget);
  });

  testWidgets('Auflegen und Rückweg sind beide erreichbar', (t) async {
    var zurueck = 0;
    AnrufRueckweg.oeffner = () => zurueck++;
    await t.pumpWidget(appMitKnopf(() {}));
    AnrufOverlay().aktivieren();
    dienst.testZustand(CallState.inCall, conversationId: 7);
    await t.pump();

    // ⚠️ Der Auflegen-Knopf ist der Kern: ohne ihn liesse sich ein Anruf,
    // dessen Gegenstelle nicht mehr antwortet, nur per App-Neustart beenden —
    // und bis dahin weist er jeden neuen Anruf mit „busy" ab.
    expect(find.byIcon(Icons.call_end), findsOneWidget);

    await t.tap(find.byIcon(Icons.open_in_full));
    await t.pump();
    expect(zurueck, 1, reason: 'der Rückweg muss den Öffner rufen');
  });

  testWidgets('ohne registrierten Öffner gibt es keinen Rückweg-Knopf', (t) async {
    AnrufRueckweg.oeffner = null;
    await t.pumpWidget(appMitKnopf(() {}));
    AnrufOverlay().aktivieren();
    dienst.testZustand(CallState.inCall, conversationId: 7);
    await t.pump();
    expect(find.byIcon(Icons.open_in_full), findsNothing,
        reason: 'ein Knopf, der nichts tut, ist schlimmer als keiner');
    expect(find.byIcon(Icons.call_end), findsOneWidget,
        reason: 'Auflegen muss es trotzdem geben');
  });

  test('der Anrufschirm unterdrueckt die Karte und gibt sie wieder frei', () {
    // Sonst stuenden zwei Anrufanzeigen uebereinander — und schlimmer: gaebe
    // der Schirm sie beim Schliessen nicht frei, waere der Anruf wieder
    // unsichtbar, nur eine Ebene tiefer versteckt.
    final dash = File('lib/screens/mitglied_dashboard.dart').readAsStringSync();
    final ohneKommentar = dash
        .split('\n')
        .map((z) {
          final i = z.indexOf('//');
          return i < 0 ? z : z.substring(0, i);
        })
        .join('\n');
    expect(ohneKommentar, contains('AnrufOverlay().unterdruecken(true)'));
    expect(ohneKommentar, contains('AnrufOverlay().unterdruecken(false)'));
    expect(ohneKommentar, contains('AnrufOverlay().aktivieren()'),
        reason: 'ohne aktivieren() erscheint die Karte nie');
  });
}
