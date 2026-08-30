import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';

import '../logger_service.dart';
import 'input_injector.dart';

final _log = LoggerService();

/// Fernsteuerung auf Android ueber den [FernwartungService] (AccessibilityService).
///
/// ⚠️ Android kennt keinen Mauszeiger fuer fremde Apps — es gibt nur Gesten.
/// Deshalb wird hier UEBERSETZT statt weitergereicht: aus Druecken/Bewegen/
/// Loslassen der Maus entsteht ein Tipp, ein langes Tippen oder ein Wischen.
///
/// Der Vorteil dieser Uebersetzung ist, dass das Protokoll (`m`/`b`/`w`/`k`)
/// UNVERAENDERT bleibt: eine bereits ausgelieferte Vorsitzer-App kann ein neu
/// aktualisiertes Mitgliedsgeraet steuern, ohne selbst etwas zu wissen.
///
/// ⚠️ Tastatureingaben lassen sich nicht in Textfelder schreiben — dafuer
/// braeuchte der Dienst Lesezugriff auf den Bildschirminhalt, und genau den
/// bekommt er bewusst nicht (siehe res/xml/fernwartung_accessibility.xml).
/// Getippt wird auf der Bildschirmtastatur des Mitglieds, die im geteilten Bild
/// zu sehen ist. Nur `Escape` und `Home` gehen als globale Aktion durch.
class AndroidInputInjector extends InputInjector {
  static const MethodChannel _kanal =
      MethodChannel('de.icd360sev.mitglied/fernsteuerung');

  bool _verfuegbar = false;

  /// Bewegung unter diesem Anteil der Bildschirmdiagonale gilt als Tippen und
  /// nicht als Wischen. Ein Finger wackelt, eine Maus auch.
  static const double _tippToleranz = 0.02;

  /// Ab dieser Haltedauer wird aus einem Tipp ein langes Tippen.
  static const int _langMs = 500;

  /// Kuerzeste Geste. Eine Geste mit 0 ms wird vom System entweder abgelehnt
  /// oder als Schleuderbewegung gedeutet.
  static const int _kurzMs = 60;

  Offset2? _unten;
  Offset2? _zuletzt;
  int _untenZeit = 0;
  int _untenKnopf = 0;

  // Radabrollen kommt in Schueben. Eine Geste je Ereignis wuerde den Dienst
  // ueberrollen — dispatchGesture bricht eine laufende Geste ab, wenn die
  // naechste kommt, also kaeme am Ende weniger an, nicht mehr.
  double _radSumme = 0;
  Timer? _radUhr;

  /// Gesten ueberlappen sich nicht: dispatchGesture bricht die laufende ab.
  Future<void> _kette = Future<void>.value();
  int _wartend = 0;

  @override
  bool get isSupported => _verfuegbar;

  @override
  Future<void> vorbereiten() async {
    try {
      _verfuegbar = await _kanal.invokeMethod<bool>('verfuegbar') ?? false;
    } on PlatformException catch (e) {
      _verfuegbar = false;
      _log.warning('AndroidInput: Verfuegbarkeit nicht lesbar: ${e.message}',
          tag: 'REMOTE');
    }
    if (_verfuegbar) await _freigeben(true);
    _log.info('AndroidInput: Steuerung ${_verfuegbar ? "aktiv" : "nicht aktiviert"}',
        tag: 'REMOTE');
  }

  Future<void> _freigeben(bool frei) async {
    try {
      await _kanal.invokeMethod('freigeben', {'frei': frei});
    } on PlatformException catch (e) {
      _log.warning('AndroidInput: Freigabe fehlgeschlagen: ${e.message}', tag: 'REMOTE');
    }
  }

  @override
  void setScreenSize(int width, int height) {
    // Nicht noetig: die Normkoordinaten werden nativ gegen die ECHTE Anzeige
    // gerechnet. Die Videomasse taugen dafuer nicht — WebRTC skaliert den Strom
    // je nach Bandbreite herunter, die Anzeige bleibt gleich gross.
  }

  void _zug(double x1, double y1, double x2, double y2, int ms) {
    if (!_verfuegbar) return;
    // Rueckstau begrenzen: lieber eine Geste verwerfen als sekundenlang
    // Bewegungen nachspielen, die der Vorsitz laengst vergessen hat.
    if (_wartend >= 4) return;
    _wartend++;
    _kette = _kette.then((_) async {
      try {
        await _kanal.invokeMethod('zug', {
          'x1': x1, 'y1': y1, 'x2': x2, 'y2': y2, 'ms': ms,
        });
      } on PlatformException catch (e) {
        _log.warning('AndroidInput: Zug fehlgeschlagen: ${e.message}', tag: 'REMOTE');
      } finally {
        _wartend--;
      }
    });
  }

  @override
  Future<void> mouseMove(double nx, double ny) async {
    _zuletzt = Offset2(nx, ny);
  }

  @override
  Future<void> mouseButton(int button, bool down) async {
    if (!_verfuegbar) return;
    final jetzt = DateTime.now().millisecondsSinceEpoch;
    if (down) {
      _unten = _zuletzt ?? const Offset2(0.5, 0.5);
      _untenZeit = jetzt;
      _untenKnopf = button;
      return;
    }

    final start = _unten;
    if (start == null) return;
    _unten = null;
    final ende = _zuletzt ?? start;
    final dauer = jetzt - _untenZeit;
    final weg = math.sqrt(
      math.pow(ende.x - start.x, 2) + math.pow(ende.y - start.y, 2),
    );

    // Rechte Maustaste = langes Tippen. Das ist auf einem Touchgeraet die
    // Geste, die dasselbe bedeutet: Kontextmenue.
    if (_untenKnopf == 2) {
      _zug(start.x, start.y, start.x, start.y, _langMs + 100);
      return;
    }

    if (weg < _tippToleranz) {
      final ms = dauer >= _langMs ? math.min(dauer, 2000) : _kurzMs;
      _zug(start.x, start.y, start.x, start.y, ms);
    } else {
      // Ziehen. Die echte Dauer beibehalten, damit aus einer langsamen
      // Bewegung kein Schleudern wird — aber nicht unter _kurzMs.
      _zug(start.x, start.y, ende.x, ende.y, math.max(dauer, _kurzMs));
    }
  }

  @override
  Future<void> mouseWheel(double dx, double dy) async {
    if (!_verfuegbar) return;
    _radSumme += dy;
    _radUhr ??= Timer(const Duration(milliseconds: 120), _radAusloesen);
  }

  void _radAusloesen() {
    _radUhr = null;
    final summe = _radSumme;
    _radSumme = 0;
    if (summe == 0) return;

    // Nach unten scrollen heisst: der Inhalt wandert nach oben, der Finger
    // wischt also nach OBEN. Ein Vorzeichenfehler hier faellt sofort auf, ist
    // aber genau die Art Detail, die man beim Nachbauen verdreht.
    final anker = _zuletzt ?? const Offset2(0.5, 0.5);
    // 100 Radeinheiten ~ ein Mausrad-Rasten ~ ein Drittel Bildschirm.
    final weite = (summe.abs() / 100.0 * 0.33).clamp(0.08, 0.6);
    final richtung = summe > 0 ? -1.0 : 1.0;
    final y1 = (anker.y - richtung * weite / 2).clamp(0.05, 0.95);
    final y2 = (anker.y + richtung * weite / 2).clamp(0.05, 0.95);
    if ((y2 - y1).abs() < 0.02) return;
    _zug(anker.x, y1, anker.x, y2, 220);
  }

  @override
  Future<void> keyEvent({
    required int hid,
    String? character,
    required bool down,
  }) async {
    if (!_verfuegbar || !down) return;
    // USB-HID: 0x29 Escape, 0x4A Home. Alles andere braeuchte Schreibzugriff
    // auf das fokussierte Textfeld und damit Inhaltszugriff — den hat der
    // Dienst bewusst nicht.
    final usage = hid & 0xFFFF;
    final name = usage == 0x29 ? 'back' : (usage == 0x4A ? 'home' : null);
    if (name == null) return;
    await systemAktion(name);
  }

  @override
  Future<void> systemAktion(String name) async {
    if (!_verfuegbar) return;
    try {
      await _kanal.invokeMethod('aktion', {'name': name});
    } on PlatformException catch (e) {
      _log.warning('AndroidInput: Aktion $name fehlgeschlagen: ${e.message}',
          tag: 'REMOTE');
    }
  }

  @override
  void dispose() {
    _radUhr?.cancel();
    _radUhr = null;
    // Schloss wieder zu. Ohne das bliebe die Freigabe nach dem Sitzungsende
    // stehen, und der Dienst wuerde beim naechsten Mal ohne Zustimmung Gesten
    // ausfuehren.
    _freigeben(false);
  }

  /// Oeffnet die Android-Bedienungshilfen. Eine App kann sich diese
  /// Berechtigung nicht selbst erteilen — das Mitglied muss den Dienst dort
  /// einschalten.
  static Future<bool> einstellungenOeffnen() async {
    try {
      return await _kanal.invokeMethod<bool>('einstellungenOeffnen') ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Laeuft der Dienst? Fuer die Anzeige in den Mitglieds-Einstellungen.
  static Future<bool> istAktiviert() async {
    try {
      return await _kanal.invokeMethod<bool>('verfuegbar') ?? false;
    } on PlatformException {
      return false;
    }
  }
}

/// Kleiner Punkt-Typ, damit diese Datei nicht wegen zweier Koordinaten
/// `dart:ui` (und damit Flutter-Bindings) hereinziehen muss.
class Offset2 {
  final double x;
  final double y;
  const Offset2(this.x, this.y);
}
