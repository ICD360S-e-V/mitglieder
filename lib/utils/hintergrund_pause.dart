import 'dart:async';

import 'package:flutter/widgets.dart';

import '../services/energiepolitik.dart';
import '../services/energiepolitik_waechter.dart';

/// Hält periodische Arbeit an, solange die App im Hintergrund ist.
///
/// Warum es das gibt: ein Widget wird **nicht** entsorgt, wenn die App in den
/// Hintergrund wechselt — nur `dispose()` räumt seine Timer ab. Ein
/// `Timer.periodic`, der in `initState` startet, läuft also weiter, bis der
/// Bildschirm tatsächlich verlassen wird. Wer die App auf der Terminübersicht
/// liegen lässt und wegwischt, fragt den Server danach jede Minute weiter ab,
/// tagelang, ohne dass jemand hinsieht.
///
/// Gemessen waren das rund 60 Netzanfragen pro Stunde allein aus der
/// Terminübersicht — mehr als alle bis dahin eingesparten Takte zusammen.
/// Jede weckt das Funkmodem, und über 60 % der Energie einer Funkverbindung
/// entfällt auf dessen Nachlaufzeit.
///
/// Von zwanzig Dateien mit periodischen Timern reagierten drei auf den
/// Lebenszyklus. Dieses Mixin ist die Antwort darauf, dieselbe Behandlung ein
/// viertes und fünftes Mal von Hand zu kopieren — genau die Verdopplung, aus
/// der im Dashboard bereits ein Fehler entstanden war (Timer in `paused`
/// abgeräumt, im `resumed`-Zweig vergessen).
///
/// Benutzung:
///
/// ```dart
/// class _MeinState extends State<Mein> with HintergrundPause<Mein> {
///   @override
///   void initState() {
///     super.initState();
///     taktSetzen(#termine, const Duration(seconds: 60), _nachladen);
///   }
/// }
/// ```
///
/// Beim Zurückkehren in den Vordergrund wird jede Arbeit **einmal sofort**
/// ausgeführt und der Takt dann neu aufgesetzt. Ohne das sähe das Mitglied
/// nach der Rückkehr bis zu ein Intervall lang veraltete Daten — schlechter
/// als vorher, und der häufigste Grund, warum solche Pausen wieder
/// ausgebaut werden.
mixin HintergrundPause<T extends StatefulWidget> on State<T> {
  final Map<Object, _Takt> _takte = {};
  _LebenszyklusBruecke? _bruecke;
  bool _imVordergrund = true;

  /// Zuletzt angewandte Politik. Ändert sie sich, werden alle laufenden Takte
  /// mit dem neuen Intervall neu aufgesetzt.
  Energiepolitik _politik = Energiepolitik.standard;
  VoidCallback? _politikHoerer;

  /// Setzt einen Takt unter [schluessel]. Ein bereits vorhandener mit
  /// demselben Schlüssel wird ersetzt, nicht verdoppelt.
  ///
  /// [sofort] führt [arbeit] zusätzlich direkt aus — für den üblichen Fall,
  /// dass beim Öffnen erst einmal geladen werden soll.
  void taktSetzen(
    Object schluessel,
    Duration intervall,
    VoidCallback arbeit, {
    bool sofort = false,
  }) {
    taktLoeschen(schluessel);

    if (_bruecke == null) {
      _bruecke = _LebenszyklusBruecke(_zustandGewechselt);
      WidgetsBinding.instance.addObserver(_bruecke!);
    }

    final waechter = EnergiepolitikWaechter.instance;
    if (_politikHoerer == null) {
      _politik = waechter.politik.value;
      _politikHoerer = _politikGewechselt;
      waechter.politik.addListener(_politikHoerer!);
    }

    final takt = _Takt(intervall, arbeit);
    _takte[schluessel] = takt;
    if (_imVordergrund) takt.starten(_politik);
    if (sofort) arbeit();
  }

  /// Beendet den Takt unter [schluessel]. Unbekannte Schlüssel sind
  /// folgenlos.
  void taktLoeschen(Object schluessel) => _takte.remove(schluessel)?.stoppen();

  /// Nur für Tests: ob unter [schluessel] gerade eine Uhr läuft.
  @visibleForTesting
  bool taktLaeuft(Object schluessel) => _takte[schluessel]?.laeuft ?? false;

  /// Nur für Tests: ob das Mixin die App im Vordergrund wähnt.
  @visibleForTesting
  bool get imVordergrund => _imVordergrund;

  void _zustandGewechselt(AppLifecycleState zustand) {
    // Nur `resumed` gilt als Vordergrund. `inactive` tritt auch beim
    // kurzzeitigen Überlagern auf (Anrufbildschirm, Benachrichtigungsleiste
    // aufgezogen) und wäre ein zu hektischer Auslöser; `hidden` und `paused`
    // sind eindeutig Hintergrund.
    final vordergrund = zustand == AppLifecycleState.resumed;
    if (vordergrund == _imVordergrund) return;
    _imVordergrund = vordergrund;

    for (final takt in _takte.values) {
      if (vordergrund) {
        // Erst nachholen, dann takten: sonst stünden bis zum ersten
        // Tick veraltete Daten auf dem Bildschirm.
        takt.arbeit();
        takt.starten(_politik);
      } else {
        takt.stoppen();
      }
    }

    if (vordergrund) {
      // Kostenloser Anlass: das Gerät ist gerade ohnehin wach. Der Wächter
      // hält deswegen keinen eigenen Timer.
      unawaited(EnergiepolitikWaechter.instance.auffrischen());
    }
  }

  void _politikGewechselt() {
    final neu = EnergiepolitikWaechter.instance.politik.value;
    if (neu.faktor == _politik.faktor) return;
    _politik = neu;
    if (!_imVordergrund) return;
    // Nur die Uhren neu stellen, nicht die Arbeit auslösen: ein Wechsel der
    // Politik ist kein Grund, Daten nachzuladen.
    for (final takt in _takte.values) {
      takt.starten(_politik);
    }
  }

  @override
  void dispose() {
    for (final takt in _takte.values) {
      takt.stoppen();
    }
    _takte.clear();
    if (_politikHoerer != null) {
      EnergiepolitikWaechter.instance.politik.removeListener(_politikHoerer!);
      _politikHoerer = null;
    }
    if (_bruecke != null) {
      WidgetsBinding.instance.removeObserver(_bruecke!);
      _bruecke = null;
    }
    super.dispose();
  }
}

class _Takt {
  _Takt(this.intervall, this.arbeit);

  final Duration intervall;
  final VoidCallback arbeit;
  Timer? _uhr;

  bool get laeuft => _uhr?.isActive ?? false;

  void starten([Energiepolitik politik = Energiepolitik.standard]) {
    _uhr?.cancel();
    _uhr = Timer.periodic(politik.intervall(intervall), (_) => arbeit());
  }

  void stoppen() {
    _uhr?.cancel();
    _uhr = null;
  }
}

/// Reicht Lebenszyklus-Wechsel weiter.
///
/// Eigene Klasse statt `with WidgetsBindingObserver` am State, damit das Mixin
/// sich nicht mit den Mixins streitet, die betroffene Bildschirme ohnehin
/// tragen (etwa `TickerProviderStateMixin`).
class _LebenszyklusBruecke with WidgetsBindingObserver {
  _LebenszyklusBruecke(this.beiWechsel);

  final void Function(AppLifecycleState) beiWechsel;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => beiWechsel(state);
}
