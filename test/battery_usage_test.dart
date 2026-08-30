import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/battery_usage.dart';

/// Basiszeit für alle Fenster. Fest verdrahtet statt DateTime.now(), damit die
/// Tests nicht davon abhängen, wann sie laufen.
final _t0 = DateTime.utc(2026, 8, 30, 12, 0, 0);

BatteryUsageSegment _segment({
  int startLevel = 80,
  int? startChargeUah,
}) =>
    BatteryUsageSegment(
      startedAt: _t0,
      startLevel: startLevel,
      startChargeUah: startChargeUah,
    );

void main() {
  group('BatteryUsageSegment — Ratenberechnung', () {
    test('drainPerHour rechnet Prozent auf die Stunde hoch', () {
      final s = _segment(startLevel: 80);
      // 5 Prozentpunkte in 30 Minuten sind 10 %/h.
      expect(
        s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 30)), level: 75)),
        isTrue,
      );
      expect(s.drainPercent, 5);
      expect(s.drainPerHour, closeTo(10.0, 0.001));
    });

    test('drainPerHour ist null, solange kein Zeitraum vorliegt', () {
      expect(_segment().drainPerHour, isNull);
    });

    test('requestsPerHour normiert die Verursacherzähler auf die Stunde', () {
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 15)), level: 79));
      s.networkRequests = 30;
      // 30 Anfragen in einer Viertelstunde sind 120/h.
      expect(s.requestsPerHour, closeTo(120.0, 0.001));
    });

    test('drainMah und averageMilliAmps nutzen den Ladungszähler', () {
      final s = _segment(startLevel: 80, startChargeUah: 3000000);
      s.addSample(BatterySample(
        at: _t0.add(const Duration(hours: 2)),
        level: 76,
        chargeUah: 2800000,
      ));
      // 200 000 µAh entnommen = 200 mAh, verteilt auf zwei Stunden = 100 mA.
      expect(s.drainMah, closeTo(200.0, 0.001));
      expect(s.averageMilliAmps, closeTo(100.0, 0.001));
    });

    test('ohne Ladungszähler bleiben die mAh-Grössen null', () {
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(hours: 1)), level: 75));
      expect(s.drainMah, isNull);
      expect(s.averageMilliAmps, isNull);
    });

    test('Endstand des Zählers wird ignoriert, wenn der Startwert fehlt', () {
      // Sonst stünde einem Endwert kein Startwert gegenüber und die Differenz
      // wäre frei erfunden.
      final s = _segment(startChargeUah: null);
      s.addSample(BatterySample(
        at: _t0.add(const Duration(hours: 1)),
        level: 75,
        chargeUah: 2800000,
      ));
      expect(s.endChargeUah, isNull);
      expect(s.drainMah, isNull);
    });
  });

  group('BatteryUsageSegment — Zuverlässigkeit', () {
    test('zu kurzes Fenster gilt nicht als zuverlässig', () {
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 5)), level: 75));
      expect(s.isReliable, isFalse);
    });

    test('lang genug, aber nur ein Prozentschritt: nicht zuverlässig', () {
      // Ein einzelner Schritt kann Rundung sein — daraus lässt sich keine
      // Rate ableiten.
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 45)), level: 79));
      expect(s.drainPercent, 1);
      expect(s.isReliable, isFalse);
    });

    test('lang genug und zwei Prozentschritte: zuverlässig', () {
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 45)), level: 78));
      expect(s.isReliable, isTrue);
    });

    test('Ladungszähler macht auch einen Prozentschritt auswertbar', () {
      // Genau der Grund, warum CHARGE_COUNTER gelesen wird: die Auflösung
      // braucht die Zwei-Prozent-Hürde nicht.
      final s = _segment(startChargeUah: 3000000);
      s.addSample(BatterySample(
        at: _t0.add(const Duration(minutes: 45)),
        level: 79,
        chargeUah: 2970000,
      ));
      expect(s.drainPercent, 1);
      expect(s.isReliable, isTrue);
    });

    test('als gap geschlossenes Fenster ist nie zuverlässig', () {
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(hours: 1)), level: 70));
      expect(s.isReliable, isTrue);
      s.close(BatterySegmentClose.gap);
      expect(s.isReliable, isFalse);
    });
  });

  group('BatteryUsageSegment — Plausibilität', () {
    test('steigender Akkustand schliesst das Fenster als gap', () {
      // Laden während eines Entladefensters: der Zustandswechsel kam später
      // als der erste steigende Messwert.
      final s = _segment(startLevel: 70);
      expect(
        s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 30)), level: 72)),
        isFalse,
      );
      expect(s.closedReason, BatterySegmentClose.gap);
    });

    test('rückwärts laufende Uhr schliesst das Fenster als gap', () {
      final s = _segment();
      expect(
        s.addSample(BatterySample(at: _t0.subtract(const Duration(minutes: 1)), level: 79)),
        isFalse,
      );
      expect(s.closedReason, BatterySegmentClose.gap);
    });

    test('unplausibler Sturz zwischen zwei Messpunkten gilt als gap', () {
      // Gerät war suspendiert oder der Akkutreiber hat neu kalibriert — das
      // ist keine Entladung, die wir gemessen haben.
      final s = _segment(startLevel: 90);
      expect(
        s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 30)), level: 40)),
        isFalse,
      );
      expect(s.closedReason, BatterySegmentClose.gap);
    });

    test('Sturz knapp unter der Grenze wird noch akzeptiert', () {
      final s = _segment(startLevel: 90);
      expect(
        s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 30)), level: 66)),
        isTrue,
      );
      expect(s.closedReason, isNull);
    });

    test('geschlossenes Fenster nimmt keine weiteren Messpunkte an', () {
      final s = _segment();
      s.close(BatterySegmentClose.charging);
      expect(
        s.addSample(BatterySample(at: _t0.add(const Duration(minutes: 30)), level: 70)),
        isFalse,
      );
      expect(s.endLevel, 80);
    });

    test('close überschreibt einen bereits gesetzten Grund nicht', () {
      // Ein gap darf nicht nachträglich zu einem sauberen charging werden.
      final s = _segment();
      s.close(BatterySegmentClose.gap);
      s.close(BatterySegmentClose.charging);
      expect(s.closedReason, BatterySegmentClose.gap);
    });

    test('Überschreiten der Maximaldauer markiert einen rollover', () {
      // Simuliert die echte Abtastkadenz: alle 15 Minuten ein Messpunkt, ein
      // Prozentpunkt weniger. Nach sechs Stunden greift der Umbruch.
      final s = _segment(startLevel: 80);
      for (var i = 1; i <= 24; i++) {
        final accepted = s.addSample(BatterySample(
          at: _t0.add(Duration(minutes: 15 * i)),
          level: 80 - i,
        ));
        expect(accepted, isTrue, reason: 'Messpunkt $i wurde abgelehnt');
      }
      expect(s.duration, const Duration(hours: 6));
      expect(s.closedReason, BatterySegmentClose.rollover);
    });

    test('rollover lehnt weitere Messpunkte ab, statt weiterzulaufen', () {
      // Der Dienst muss danach ein neues Fenster öffnen — täte er es nicht,
      // liefe ein einziges, immer gröber werdendes Segment ewig weiter.
      final s = _segment(startLevel: 80);
      for (var i = 1; i <= 24; i++) {
        s.addSample(BatterySample(
          at: _t0.add(Duration(minutes: 15 * i)),
          level: 80 - i,
        ));
      }
      expect(
        s.addSample(BatterySample(
          at: _t0.add(const Duration(hours: 6, minutes: 15)),
          level: 55,
        )),
        isFalse,
      );
      expect(s.endLevel, 56);
    });
  });

  group('BatteryUsageSegment — Serialisierung', () {
    test('JSON-Roundtrip erhält alle Felder', () {
      final original = _segment(startLevel: 88, startChargeUah: 4100000)
        ..addSample(BatterySample(
          at: _t0.add(const Duration(hours: 3)),
          level: 61,
          chargeUah: 3800000,
        ))
        ..foregroundMs = 120000
        ..backgroundMs = 10680000
        ..networkRequests = 690
        ..wsReconnects = 4
        ..pushWakeups = 12
        ..powerSaveMode = false
        ..standbyBucket = 20
        ..dozeExempt = true
        ..thermalStatus = 0
        ..close(BatterySegmentClose.charging);

      final restored = BatteryUsageSegment.fromJson(original.toJson());

      expect(restored.startedAt, original.startedAt);
      expect(restored.endedAt, original.endedAt);
      expect(restored.startLevel, original.startLevel);
      expect(restored.endLevel, original.endLevel);
      expect(restored.startChargeUah, original.startChargeUah);
      expect(restored.endChargeUah, original.endChargeUah);
      expect(restored.foregroundMs, original.foregroundMs);
      expect(restored.backgroundMs, original.backgroundMs);
      expect(restored.networkRequests, original.networkRequests);
      expect(restored.wsReconnects, original.wsReconnects);
      expect(restored.pushWakeups, original.pushWakeups);
      expect(restored.powerSaveMode, original.powerSaveMode);
      expect(restored.standbyBucket, original.standbyBucket);
      expect(restored.dozeExempt, original.dozeExempt);
      expect(restored.thermalStatus, original.thermalStatus);
      expect(restored.closedReason, original.closedReason);
      expect(restored.connectionType, original.connectionType);
      expect(restored.isReliable, original.isReliable);
    });

    test('Zeitstempel werden als UTC serialisiert und wieder eingelesen', () {
      // Ohne trailing Z liest DateTime.parse Ortszeit — ein Roundtrip würde
      // den Zeitpunkt sonst um den UTC-Offset verschieben und jede Rate
      // verfälschen.
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(hours: 1)), level: 75));
      final json = s.toJson();

      expect(json['started_at'], '2026-08-30 12:00:00');
      expect(json['ended_at'], '2026-08-30 13:00:00');

      final restored = BatteryUsageSegment.fromJson(json);
      expect(restored.startedAt.isUtc, isTrue);
      expect(restored.startedAt, _t0);
      expect(restored.duration, const Duration(hours: 1));
    });

    test('unbekannter closed_reason fällt auf null zurück statt zu werfen', () {
      final s = _segment();
      s.addSample(BatterySample(at: _t0.add(const Duration(hours: 1)), level: 75));
      final json = s.toJson()..['closed_reason'] = 'etwas-neues-vom-server';
      expect(BatteryUsageSegment.fromJson(json).closedReason, isNull);
    });
  });
}
