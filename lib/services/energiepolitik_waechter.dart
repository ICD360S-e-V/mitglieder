import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import 'battery_platform_state.dart';
import 'energiepolitik.dart';
import 'logger_service.dart';

/// Hält die [Energiepolitik] aktuell und meldet Änderungen.
///
/// Der Wächter darf nicht selbst kosten, was er einspart. Deshalb hat er
/// **keinen eigenen Timer**: er lauscht auf den Zustandswechsel des Akkus, den
/// das System ohnehin als Broadcast verschickt, und wird ausserdem von aussen
/// angestossen, wenn die App in den Vordergrund zurückkehrt — ein Zeitpunkt,
/// zu dem das Gerät sowieso wach ist.
///
/// Zwischen diesen Anlässen kann die Politik veralten: der Akku fällt von 55 %
/// auf 45 %, ohne dass jemand es bemerkt. Das ist gewollt. Die Alternative
/// wäre regelmässiges Nachsehen — also genau die Sorte Aufwachvorgang, die
/// hier abgeschafft werden soll. Eine um Minuten verspätete Anpassung kostet
/// nichts; ein zusätzlicher Takt schon.
class EnergiepolitikWaechter {
  EnergiepolitikWaechter._();
  static final EnergiepolitikWaechter instance = EnergiepolitikWaechter._();

  final Battery _battery = Battery();
  final LoggerService _log = LoggerService();

  /// Die aktuelle Politik. Hören Sie darauf, um Takte neu zu setzen.
  final ValueNotifier<Energiepolitik> politik =
      ValueNotifier<Energiepolitik>(Energiepolitik.standard);

  StreamSubscription<BatteryState>? _zustandsSub;
  bool _gestartet = false;
  bool _laeuftGerade = false;

  /// Beginnt zu beobachten. Mehrfachaufruf ist folgenlos.
  Future<void> starten() async {
    if (_gestartet) return;
    _gestartet = true;

    try {
      _zustandsSub = _battery.onBatteryStateChanged.listen(
        (_) => unawaited(auffrischen()),
        onError: (Object e) =>
            _log.debug('Energiepolitik: Zustandsstrom: $e', tag: 'ENERGIE'),
      );
    } catch (e) {
      // Ohne Strom bleibt es beim Anstossen von aussen; die App läuft weiter,
      // nur eben mit einer Politik, die seltener nachgeführt wird.
      _log.warning('Energiepolitik: kein Zustandsstrom: $e', tag: 'ENERGIE');
    }

    await auffrischen();
  }

  Future<void> beenden() async {
    await _zustandsSub?.cancel();
    _zustandsSub = null;
    _gestartet = false;
  }

  /// Liest den Gerätezustand neu und aktualisiert [politik].
  ///
  /// Rein lokale Abfragen — Binder beziehungsweise D-Bus, kein Funkmodem.
  Future<void> auffrischen() async {
    if (_laeuftGerade) return;
    _laeuftGerade = true;
    try {
      final zustand = await _zustandLesen();
      final stand = await _standLesen();
      final plattform = await BatteryPlatformState.read();
      final zaehlend = await _zaehlendesNetz();

      final neu = Energiepolitik.ausZustand(
        ladend: zustand,
        akkustand: stand,
        energiesparmodus: plattform.powerSaveMode,
        standbyBucket: plattform.standbyBucket,
        thermalStatus: plattform.thermalStatus,
        zaehlendesNetz: zaehlend,
      );

      if (neu.stufe != politik.value.stufe ||
          neu.faktor != politik.value.faktor) {
        _log.info('Energiepolitik: $neu', tag: 'ENERGIE');
        politik.value = neu;
      }
    } catch (e) {
      // Im Zweifel nichts ändern: eine falsch gestreckte Politik fiele dem
      // Mitglied als hängende Anzeige auf.
      _log.warning('Energiepolitik nicht bestimmbar: $e', tag: 'ENERGIE');
    } finally {
      _laeuftGerade = false;
    }
  }

  Future<bool> _zustandLesen() async {
    try {
      final z =
          await _battery.batteryState.timeout(const Duration(seconds: 3));
      return z == BatteryState.charging ||
          z == BatteryState.full ||
          z == BatteryState.connectedNotCharging;
    } catch (_) {
      // Unbekannt heisst „nicht am Ladegerät": lieber sparsam als grosszügig.
      return false;
    }
  }

  Future<int?> _standLesen() async {
    try {
      final stand =
          await _battery.batteryLevel.timeout(const Duration(seconds: 3));
      // battery_plus meldet auf manchen Geräten kurz nach dem Start -1, und
      // Rechner ohne Akku liefern gar nichts Sinnvolles.
      return (stand < 0 || stand > 100) ? null : stand;
    } catch (_) {
      return null;
    }
  }

  Future<bool> _zaehlendesNetz() async {
    try {
      final ergebnisse = await Connectivity().checkConnectivity();
      return ergebnisse.contains(ConnectivityResult.mobile);
    } catch (_) {
      return false;
    }
  }
}
