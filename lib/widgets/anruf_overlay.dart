import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../services/anruf_rueckweg.dart';

import '../services/voice_call_service.dart';

/// Schwebende Karte für einen laufenden **Chat-Anruf** (WebRTC), sichtbar über
/// jedem Bildschirm.
///
/// WOFÜR
/// Seit dem 11.09.2026 überlebt ein Anruf das Schliessen des Chat-Fensters —
/// der Anrufschirm ist eine geschobene Route, der Dienst besitzt den Anruf. Ohne diese Karte liefe er
/// unsichtbar weiter: kein Rückweg, kein Auflegen. Und ein unsichtbarer Anruf
/// ist nicht bloss unschön, er weist jeden nächsten mit „busy" ab.
///
/// ⚠️ WARUM DAS EIN `OverlayEntry` IST UND NICHT `MaterialApp.builder`
/// In `main.dart` steht der Weg über `builder` mit
/// `Positioned.fill(child: GlobalChatOverlay())` **auskommentiert**, weil er
/// auf Android die Knöpfe blockierte: eine Fläche über der ganzen App nimmt
/// jede Berührung an, auch dort, wo sie nichts zeichnet. Es sah nach einem
/// Freeze aus, und die Ursache war unsichtbar.
///
/// ⚠️ Die erste Fassung dieser Funktion (10.09.2026) war eine `AnrufLeiste` in
/// genau jenem `MaterialApp.builder` — also gegen eine Lehre gebaut, die im
/// Quelltext daneben stand. Sie ist ersetzt, nicht ergänzt.
///
/// Die Karte hängt deshalb als `OverlayEntry` im Navigator-Overlay, dasselbe
/// Muster wie [SipgateAnrufOverlay] der Vorsitzer-App, und benutzt ein `Positioned` in
/// Kartengrösse — **niemals** `Positioned.fill`. Getroffen wird nur, was man
/// auch sieht; `anruf_overlay_test.dart` prüft das an einem Knopf darunter.
class AnrufOverlay {
  AnrufOverlay._internal();
  static final AnrufOverlay _instance = AnrufOverlay._internal();
  factory AnrufOverlay() => _instance;

  /// ⚠️ Die Mitglieder-App hatte bis zum 11.09.2026 GAR KEINEN globalen
  /// Navigator-Schluessel. Ein `OverlayEntry` braucht einen; er steht deshalb
  /// hier, bei dem, der ihn benoetigt, und wird in `main.dart` an die
  /// `MaterialApp` gehaengt. Wer ihn dort entfernt, nimmt der Karte den Platz —
  /// sie erscheint dann nie, ohne dass etwas fehlschlaegt.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  final VoiceCallService _dienst = VoiceCallService();
  OverlayEntry? _eintrag;
  StreamSubscription<CallState>? _abo;
  bool _aktiv = false;
  bool _unterdrueckt = false;

  /// Wohin der Nutzer die Karte gezogen hat. `null` = Standardplatz.
  Offset? _position;

  /// Einmal beim App-Start aufrufen. Ab dann erscheint die Karte von selbst,
  /// sobald ein Anruf läuft, und verschwindet, wenn er endet.
  void aktivieren() {
    if (_aktiv) return;
    _aktiv = true;
    _abo = _dienst.callStateStream.listen((_) => _pruefen());
    _pruefen();
  }

  /// Dort ausblenden, wo der Anruf schon gross auf der Seite steht — im
  /// Chat-Fenster. Zweimal dasselbe verwirrt nur, und die Karte deckte die
  /// Gesprächsfläche zu.
  void unterdruecken(bool an) {
    if (_unterdrueckt == an) return;
    _unterdrueckt = an;
    _pruefen();
  }

  /// Nur für Tests: den Dienst wieder abbauen.
  @visibleForTesting
  void abbauen() {
    _abo?.cancel();
    _abo = null;
    _aktiv = false;
    _unterdrueckt = false;
    _verbergen();
  }

  void _pruefen() {
    // ⚠️ `ringing` gehört NICHT hierher: dafür gibt es den Annehmen-Schirm.
    // Diese Karte ist für einen Anruf, den man aus den Augen verloren hat.
    final s = _dienst.callState;
    final laeuft = s == CallState.calling ||
        s == CallState.connecting ||
        s == CallState.inCall;
    if (laeuft && !_unterdrueckt) {
      _zeigen();
    } else {
      _verbergen();
    }
  }

  void _zeigen() {
    if (_eintrag != null) return;
    final overlay = AnrufOverlay.navigatorKey.currentState?.overlay;
    // Kein Overlay heisst: die App baut gerade erst auf. Kein Grund für einen
    // Fehler — beim nächsten Zustandswechsel ist es da.
    if (overlay == null) return;
    _position = null; // jeder Anruf fängt am Standardplatz an
    _eintrag = OverlayEntry(builder: (ctx) => _Karte(overlay: this));
    overlay.insert(_eintrag!);
  }

  void _verbergen() {
    _eintrag?.remove();
    _eintrag = null;
  }

  void _verschieben(Offset delta, Size flaeche, Size karte) {
    final start = _position ?? _standardOrt(flaeche, karte);
    // Innerhalb des Bildschirms halten — eine Karte, die man an den Rand
    // schiebt und nicht mehr erreicht, wäre schlimmer als eine feste.
    _position = Offset(
      (start.dx + delta.dx)
          .clamp(8.0, (flaeche.width - karte.width - 8).clamp(8.0, double.infinity)),
      (start.dy + delta.dy)
          .clamp(8.0, (flaeche.height - karte.height - 8).clamp(8.0, double.infinity)),
    );
    _eintrag?.markNeedsBuild();
  }

  Offset _standardOrt(Size flaeche, Size karte) =>
      Offset((flaeche.width - karte.width) / 2, 12);
}

class _Karte extends StatelessWidget {
  const _Karte({required this.overlay});
  final AnrufOverlay overlay;

  static const double _breite = 320;
  static const double _hoehe = 76;

  /// Tönung und Deckung der Glasscheibe.
  ///
  /// 🔴 ÜBERNOMMEN AUS [SipgateAnrufOverlay] der Vorsitzer-App, NICHT NEU GEWÄHLT. Dort sind die
  /// beiden Zahlen gegen Weiss, Hellgrau, Gelb, Indigo, Schwarz und das eigene
  /// Grün durchgerechnet: weisser Text schlechtestenfalls 11,36:1, Kanten
  /// 3,56:1. Eine hübschere Fassung (0,78 / 0,62) kam dort im schlimmsten Fall
  /// auf 2,09:1 — unlesbar. Wer eine der Zahlen senkt, rechnet nach.
  static const double _glasToenung = 0.86;
  static const double _glasDeckung = 0.82;
  static const double _glasUnschaerfe = 18;
  static const double _rundung = 20;

  @override
  Widget build(BuildContext context) {
    final flaeche = MediaQuery.of(context).size;
    final breite = _breite > flaeche.width - 16 ? flaeche.width - 16 : _breite;
    final groesse = Size(breite, _hoehe);
    final ort = overlay._position ?? overlay._standardOrt(flaeche, groesse);

    return Positioned(
      left: ort.dx,
      top: ort.dy,
      width: breite,
      child: StreamBuilder<CallState>(
        stream: VoiceCallService().callStateStream,
        initialData: VoiceCallService().callState,
        builder: (ctx, snap) {
          final s = snap.data ?? CallState.idle;
          // Zwischen dem Entfernen des Eintrags und dem letzten Neubau kann ein
          // Takt liegen; dann lieber nichts zeichnen als werfen.
          //
          // ⚠️ Hier steht NUR `idle`, nicht auch `ringing`. Ob die Karte bei
          // `ringing` erscheint, entscheidet allein [_pruefen] — eine zweite
          // Kopie derselben Regel liefe beim naechsten Umbau auseinander, und
          // eine Gegenprobe am 11.09.2026 zeigte, dass sie die Zusicherung
          // wertlos macht: die Mutation in [_pruefen] blieb unsichtbar.
          if (s == CallState.idle) {
            return const SizedBox.shrink();
          }
          return _inhalt(ctx, s, groesse, flaeche);
        },
      ),
    );
  }

  Widget _inhalt(BuildContext ctx, CallState s, Size groesse, Size flaeche) {
    final imGespraech = s == CallState.inCall;
    final zurueckMoeglich = AnrufRueckweg.oeffner != null;

    return GestureDetector(
      onPanUpdate: (d) => overlay._verschieben(d.delta, flaeche, groesse),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_rundung),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
              sigmaX: _glasUnschaerfe, sigmaY: _glasUnschaerfe),
          child: Container(
            height: groesse.height,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Color.lerp(kAnrufKarteGruen, Colors.black, _glasToenung)!
                  .withValues(alpha: _glasDeckung),
              borderRadius: BorderRadius.circular(_rundung),
              border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
            ),
            child: Row(
              children: [
                Icon(imGespraech ? Icons.call : Icons.call_made,
                    color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        imGespraech ? 'Anruf läuft' : 'Wird verbunden …',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if (zurueckMoeglich)
                        const Text(
                          'Tippen für den Anruf',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                    ],
                  ),
                ),
                if (zurueckMoeglich)
                  IconButton(
                    tooltip: 'Zurück zum Anruf',
                    onPressed: () => AnrufRueckweg.zurueck(),
                    icon: const Icon(Icons.open_in_full,
                        color: Colors.white, size: 20),
                  ),
                // ⚠️ Auflegen MUSS hier sein. Ohne ihn liesse sich ein Anruf,
                // dessen Gegenstelle nicht mehr antwortet, nur per App-Neustart
                // beenden — und bis dahin weist er jeden neuen Anruf ab.
                IconButton(
                  tooltip: 'Auflegen',
                  onPressed: () => VoiceCallService().endCall(),
                  icon: const Icon(Icons.call_end, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Grundton der Karte — dasselbe Grün wie auf der Gesprächskarte.
const Color kAnrufKarteGruen = Color(0xFF2E7D32);
