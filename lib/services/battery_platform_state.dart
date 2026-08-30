import 'dart:io';
import 'package:flutter/services.dart';

/// Der Energiezustand, in dem das Betriebssystem die App gerade hält.
///
/// Diese Werte erklären eine gemessene Entladerate. Ohne sie ist ein Wert wie
/// „3,8 %/h" nicht einzuordnen: dieselbe App entlädt völlig unterschiedlich,
/// je nachdem ob Android sie im Bucket `active` laufen lässt oder im Bucket
/// `rare` schon fast stillgelegt hat, und ob die Doze-Ausnahme greift.
///
/// Alles ausser [powerSaveMode] ist Android-spezifisch. Auf iOS, Windows,
/// macOS und Linux bleiben die Felder leer — die Plattformen kennen weder
/// Standby-Buckets noch Doze. Das ist kein Fehler, sondern der ehrliche
/// Umfang dessen, was dort erhebbar ist.
class BatteryPlatformState {
  /// Android `PowerManager.isPowerSaveMode()` — Energiesparmodus des Systems.
  final bool? powerSaveMode;

  /// Android `UsageStatsManager.getAppStandbyBucket()`, ab API 28.
  /// 10 = active, 20 = working_set, 30 = frequent, 40 = rare, 45 = restricted.
  ///
  /// Der aussagekräftigste Einzelwert überhaupt: rutscht die App auf 40 oder
  /// 45, hat Android sie bereits als auffällig eingestuft und drosselt Jobs,
  /// Alarme und Netzzugriff. Das ist dieselbe Bewertung, aus der sich am Ende
  /// eine Play-Store-Warnung wegen Akkuverbrauchs speist.
  final int? standbyBucket;

  /// Android `PowerManager.isIgnoringBatteryOptimizations()` — ob die App von
  /// Doze ausgenommen ist. Genau die Ausnahme, die diese App über
  /// `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` anfragt; sie kostet laut Messungen
  /// zweistellige Prozentwerte an Standby-Laufzeit.
  final bool? dozeExempt;

  /// Android `PowerManager.getCurrentThermalStatus()`, ab API 29.
  /// 0 = none … 6 = shutdown. Ab 2 (`moderate`) drosselt das System, was jede
  /// Verbrauchsmessung im selben Fenster verzerrt.
  final int? thermalStatus;

  /// Momentaner Strom aus dem Akku in Mikroampere (Android
  /// `BATTERY_PROPERTY_CURRENT_NOW`). Gerätweit, nicht pro App, und je nach
  /// Hersteller mit umgekehrtem Vorzeichen oder gar nicht implementiert —
  /// deshalb nur als Zusatzsignal für A/B-Messungen am selben Gerät zu
  /// gebrauchen, nie als absolute Aussage.
  final int? currentNowMicroAmps;

  /// Verbleibende Ladung in Mikroamperestunden (Android
  /// `BATTERY_PROPERTY_CHARGE_COUNTER`).
  ///
  /// Der wichtigste Wert dieser Klasse. Der Akkustand kommt plattformweit als
  /// ganze Prozent — über ein 20-Minuten-Fenster ist ein einziger Schritt von
  /// 1 % bereits ±3 %/h Messfehler, was jeden Vorher/Nachher-Vergleich einer
  /// Optimierung unbrauchbar macht. CHARGE_COUNTER löst dieselbe Entladung um
  /// Grössenordnungen feiner auf. Wo das Gerät ihn liefert, ist er die
  /// belastbare Messgrösse und der Prozentwert nur noch Kontext.
  final int? chargeCounterUah;

  const BatteryPlatformState({
    this.powerSaveMode,
    this.standbyBucket,
    this.dozeExempt,
    this.thermalStatus,
    this.currentNowMicroAmps,
    this.chargeCounterUah,
  });

  static const BatteryPlatformState unknown = BatteryPlatformState();

  static const MethodChannel _ch =
      MethodChannel('de.icd360sev.mitglied/battery_state');

  /// Liest den aktuellen Zustand. Rein lokal — ein Binder-Aufruf, kein
  /// Netzzugriff, kein Funkmodem. Fällt auf [unknown] zurück, wo der Kanal
  /// nicht existiert (alle Nicht-Android-Plattformen und Embeddings ohne
  /// unsere MainActivity).
  static Future<BatteryPlatformState> read() async {
    if (!Platform.isAndroid) return unknown;
    try {
      final raw = await _ch.invokeMapMethod<String, dynamic>('read');
      if (raw == null) return unknown;
      return BatteryPlatformState(
        powerSaveMode: raw['power_save_mode'] as bool?,
        standbyBucket: (raw['standby_bucket'] as num?)?.toInt(),
        dozeExempt: raw['doze_exempt'] as bool?,
        thermalStatus: (raw['thermal_status'] as num?)?.toInt(),
        currentNowMicroAmps: (raw['current_now_ua'] as num?)?.toInt(),
        chargeCounterUah: (raw['charge_counter_uah'] as num?)?.toInt(),
      );
    } catch (_) {
      return unknown;
    }
  }
}
