import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'anruf_vordergrund.dart';
import 'logger_service.dart';
import 'voice_call_service.dart';

// PORTIERT aus der Vorsitzer-App (PR #702/#707) am 12.09.2026. Unterschied:
// die Titelzeile des Fensters kommt uebersetzt von der Oberflaeche herein,
// weil diese App in 28 Sprachen ausgeliefert wird.

final _log = LoggerService();

/// Das Fenster ÜBER ANDEREN APPS, solange ein Anruf läuft und unsere App aus
/// dem Blick ist.
///
/// Die schwebende Karte in der App ([AnrufOverlay]) verschwindet, sobald der
/// Mensch die App verlässt — und seit dem Vordergrunddienst läuft der Anruf
/// dort weiter. Es blieb die dauerhafte Benachrichtigung; die sieht aber nur,
/// wer die Leiste herunterzieht.
///
/// ⚠️ DIE REGEL STEHT NUR HIER, nicht auch nativ. Nativ wüsste niemand, ob ein
/// Anruf läuft (WebRTC lebt in Dart) — eine zweite Wahrheit über denselben
/// Zustand liefe beim nächsten Umbau auseinander, und man sähe es erst an
/// einem Fenster, das über einer fremden App stehen bleibt.
///
/// ⚠️ Nur Android. Auf Linux, macOS und Windows gibt es den Kanal nicht.
class AnrufSystemkarte with WidgetsBindingObserver {
  AnrufSystemkarte._();
  static final AnrufSystemkarte _instance = AnrufSystemkarte._();
  factory AnrufSystemkarte() => _instance;

  final VoiceCallService _dienst = VoiceCallService();
  StreamSubscription<CallState>? _abo;
  bool _aktiv = false;
  bool _imVordergrund = true;
  bool _sichtbar = false;
  bool _schonGefragt = false;
  String _titelAnruf = '';
  String _titelVideoanruf = '';
  String _titelAuflegen = '';
  int _standStartzeit = -1;
  int _standGuete = -1;

  /// Die beiden Woerter auf dem Fenster, schon UEBERSETZT.
  ///
  /// ⚠️ Diese App gibt es in 28 Sprachen, und das Fenster ist nativ gezeichnet.
  /// Eine String-Ressource in `values-xx/` waere eine zweite
  /// Uebersetzungsquelle neben den ARB-Dateien; deshalb reicht die Oberflaeche
  /// die fertigen Texte herein. Aufgerufen aus `didChangeDependencies` des
  /// Dashboards, damit ein Sprachwechsel mitkommt — `aktivieren()` laeuft nur
  /// einmal und wuerde ihn verpassen.
  void texte({
    required String anruf,
    required String videoanruf,
    required String auflegen,
  }) {
    _titelAnruf = anruf;
    _titelVideoanruf = videoanruf;
    _titelAuflegen = auflegen;
  }

  /// Springt EINMAL auf `true`, wenn ein Gespräch beginnt und die
  /// Berechtigung fehlt. Die Oberfläche hängt daran und fragt nach.
  ///
  /// 🔴 Warum ein Melder und nicht der Dialog hier: dieser Dienst hat keinen
  /// `BuildContext`, und er darf auch keinen bekommen — sonst hinge die Regel,
  /// wann ein Fenster fällig ist, an einem Bildschirm, der geschlossen werden
  /// kann. Genau daran ist am 11.09.2026 der Klingelschirm gescheitert.
  final ValueNotifier<bool> erlaubnisFehlt = ValueNotifier<bool>(false);

  /// Einmal beim App-Start aufrufen.
  void aktivieren() {
    if (_aktiv || !Platform.isAndroid) return;
    _aktiv = true;
    WidgetsBinding.instance.addObserver(this);
    _abo = _dienst.callStateStream.listen((_) => _pruefen());
    _dienst.anrufGuete.addListener(_standSenden);
    _pruefen();
  }

  @visibleForTesting
  /// Startzeit als Millisekunden, oder `-1` solange das Gespraech nicht steht.
  int _startzeitMs() =>
      _dienst.gespraechBeginn?.millisecondsSinceEpoch ?? -1;

  /// Dauer und Guete an eine BEREITS sichtbare Karte nachreichen — nur wenn
  /// sich etwas geaendert hat, damit der Kanal nicht im Sekundentakt spricht.
  void _standSenden() {
    if (!_sichtbar) return;
    final s = _startzeitMs();
    final g = _dienst.anrufGuete.value;
    if (s == _standStartzeit && g == _standGuete) return;
    _standStartzeit = s;
    _standGuete = g;
    AnrufVordergrund.systemfensterStand(startzeit: s, guete: g);
  }

  void abbauen() {
    _dienst.anrufGuete.removeListener(_standSenden);
    if (!_aktiv) return;
    WidgetsBinding.instance.removeObserver(this);
    _abo?.cancel();
    _abo = null;
    _aktiv = false;
    _imVordergrund = true;
    _sichtbar = false;
    _schonGefragt = false;
    erlaubnisFehlt.value = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ⚠️ `inactive` zählt NICHT als Hintergrund: den Zustand gibt es auch
    // beim Herunterziehen der Leiste oder bei einem Systemdialog über der
    // App. Ein Fenster, das dabei aufblitzt, wirkt wie ein Fehler.
    _imVordergrund = state == AppLifecycleState.resumed;
    _pruefen();
  }

  /// Läuft gerade ein Anruf, der ein Fenster verdient?
  ///
  /// ⚠️ `ringing` gehört NICHT dazu — dafür gibt es den Annehmen-Schirm, der
  /// sich von selbst in den Vordergrund holt.
  static bool laeuft(CallState s) =>
      s == CallState.calling || s == CallState.connecting || s == CallState.inCall;

  /// ⚠️ Höchstens EINMAL je App-Lauf. Bei jedem Gespräch zu fragen wäre
  /// Nötigung, und wer zweimal „Später" gesagt hat, sagt es auch beim
  /// dritten Mal. Der dauerhafte Weg steht in den Einstellungen.
  Future<void> _erlaubnisPruefen() async {
    if (_schonGefragt) return;
    _schonGefragt = true;
    final erlaubt = await AnrufVordergrund.systemfensterErlaubt();
    if (erlaubt) return;
    _log.info(
      'AnrufSystemkarte: „Über anderen Apps anzeigen" fehlt — es wird gefragt',
      tag: 'CALL',
    );
    erlaubnisFehlt.value = true;
  }

  void _pruefen() {
    // ⚠️ Die Berechtigung wird GEFRAGT, solange die App im Blick ist — nicht
    // erst, wenn das Fenster fällig wäre. Dann steckt der Mensch schon in
    // einer fremden App, und ein Dialog dort sieht niemand.
    if (laeuft(_dienst.callState) && _imVordergrund) _erlaubnisPruefen();

    final soll = laeuft(_dienst.callState) &&
        !_imVordergrund &&
        _titelAnruf.isNotEmpty;
    if (soll != _sichtbar) {
      _sichtbar = soll;
      if (soll) {
        _standStartzeit = _startzeitMs();
        _standGuete = _dienst.anrufGuete.value;
        AnrufVordergrund.systemfensterZeigen(
          video: _dienst.isVideoCall,
          titel: _dienst.isVideoCall ? _titelVideoanruf : _titelAnruf,
          auflegen: _titelAuflegen,
          startzeit: _standStartzeit,
          guete: _standGuete,
        );
      } else {
        _standStartzeit = -1;
        _standGuete = -1;
        AnrufVordergrund.systemfensterVerbergen();
      }
    } else {
      // ⚠️ Ohne diesen Zweig bliebe die Karte auf dem Stand des Augenblicks
      // stehen, in dem sie erschien. Wer die App waehrend des Klingelns
      // verlaesst, saehe nie eine Dauer: beim Uebergang zu `inCall` bleibt
      // `soll` true, es wird also nichts neu gezeigt.
      _standSenden();
      return;
    }
    _log.info('AnrufSystemkarte: Fenster ${soll ? "gezeigt" : "verborgen"}',
        tag: 'CALL');
  }
}
