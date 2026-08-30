/// Model für die Akku-Verbrauchsmessung.
///
/// Was hier gemessen wird — und was nicht:
///
/// Keine der unterstützten Plattformen gibt einer App Auskunft darüber, wie
/// viel Akku *sie selbst* verbraucht hat. Android hält die Zuordnung pro UID
/// in `HealthStats`/`BatteryStatsManager.getUidStats`, beides `@SystemApi`
/// und für normale Apps gesperrt; iOS, Windows, macOS und Linux bieten
/// überhaupt nichts Vergleichbares. Wer etwas anderes behauptet, misst in
/// Wahrheit den Geräteverbrauch und schreibt ihn einer App zu.
///
/// Gemessen wird deshalb das, was tatsächlich messbar ist:
///
///  1. die **Entladerate des Geräts** (%/h) über zusammenhängende Fenster, in
///     denen das Gerät nicht am Strom hing, getrennt nach Vorder- und
///     Hintergrund der App, und
///  2. die **Verursacher auf unserer Seite** — Netzanfragen, WebSocket-
///     Reconnects, Push-Aufwachvorgänge — als Zähler im selben Fenster.
///
/// Erst beides zusammen erlaubt eine Aussage: „bei 60 Netzanfragen/h lag die
/// Entladerate bei 4,1 %/h, bei 15 bei 1,3 %/h" ist eine belastbare Messung
/// eines Vorher/Nachher. Eine absolute Zahl „die App hat 7 % verbraucht" wäre
/// erfunden, und diese Klasse gibt sie bewusst nicht her.
///
/// Genauigkeitsgrenze: der Akkustand kommt plattformweit als ganze Prozent.
/// Über ein 10-Minuten-Fenster ist ein einziger Schritt von 1 % bereits ±6 %/h
/// Messfehler. [BatteryUsageSegment.isReliable] hält deshalb fest, ob ein
/// Fenster lang genug war, um überhaupt etwas auszusagen — der Server wertet
/// nur zuverlässige Segmente aus, sammelt die übrigen aber weiter ein, weil
/// viele kurze Fenster in der Summe erkennen lassen, ob ein Gerät gar nicht
/// erst lange genug ununterbrochen läuft.
library;

/// Warum ein Messfenster geschlossen wurde. Landet als `closed_reason` beim
/// Server und trennt saubere Messungen von abgebrochenen.
enum BatterySegmentClose {
  /// Gerät wurde ans Ladegerät gehängt — sauberes Ende.
  charging,

  /// App wurde beendet bzw. der Dienst gestoppt — sauberes Ende.
  stopped,

  /// Fenster hat die Maximaldauer erreicht und wurde umgebrochen. Das nächste
  /// beginnt nahtlos, damit ein Gerät, das tagelang nicht geladen wird, nicht
  /// ein einziges unbrauchbar grobes Segment liefert.
  rollover,

  /// Zwischen zwei Messpunkten lag eine Lücke oder ein Sprung im Akkustand,
  /// der sich nicht durch Entladung erklären lässt (Suspend/Resume, Uhr
  /// verstellt, Akkutreiber kalibriert neu). Das Fenster ist unbrauchbar.
  gap,
}

/// Ein Messpunkt: Akkustand zu einem Zeitpunkt.
///
/// [chargeUah] ist die verbleibende Ladung in Mikroamperestunden, sofern die
/// Plattform sie liefert (Android `BATTERY_PROPERTY_CHARGE_COUNTER`). Wo
/// vorhanden, ist sie der genaue Messwert und [level] nur noch Kontext.
class BatterySample {
  final DateTime at;
  final int level;
  final int? chargeUah;

  const BatterySample({required this.at, required this.level, this.chargeUah});
}

/// Ein zusammenhängendes Entladefenster samt der App-Aktivität darin.
class BatteryUsageSegment {
  /// Kürzer als das ist die 1-%-Granularität des Akkustands zu grob, um eine
  /// Rate auszurechnen. Fenster darunter werden gemeldet, aber als unzuver-
  /// lässig markiert.
  static const Duration minReliableDuration = Duration(minutes: 20);

  /// Ein einzelner Prozentschritt kann auch Rundung sein. Ab zwei Schritten
  /// ist eine Richtung erkennbar.
  static const int minReliableDrop = 2;

  /// Ab hier wird umgebrochen (siehe [BatterySegmentClose.rollover]).
  static const Duration maxDuration = Duration(hours: 6);

  /// Grösserer Sprung zwischen zwei Messpunkten als das ist keine Entladung
  /// mehr, sondern eine Lücke.
  static const int maxPlausibleDropPerSample = 25;

  final DateTime startedAt;
  DateTime endedAt;

  final int startLevel;
  int endLevel;

  /// Verbleibende Ladung in µAh am Anfang und Ende des Fensters, wo die
  /// Plattform sie hergibt (Android). Erlaubt eine Entladungsmessung ohne die
  /// 1-%-Quantisierung von [startLevel]/[endLevel].
  final int? startChargeUah;
  int? endChargeUah;

  /// Zeit, die die App in diesem Fenster im Vordergrund bzw. im Hintergrund
  /// verbracht hat. Die Summe kann kleiner als die Fensterdauer sein, wenn die
  /// App zwischendurch gar nicht lief.
  int foregroundMs;
  int backgroundMs;

  /// Verursacher-Zähler. [networkRequests] zählt jede abgesetzte HTTP-Anfrage
  /// — die Grösse, die laut Messungen den Mobilfunk-Modem-Zustand bestimmt und
  /// damit den Verbrauch dominiert, nicht die übertragene Datenmenge.
  int networkRequests;
  int wsReconnects;
  int pushWakeups;

  /// Plattformzustand am Ende des Fensters. Alles optional: nur Android
  /// liefert Standby-Bucket, Doze-Ausnahme und Thermalstatus, die übrigen
  /// Plattformen lassen die Felder leer.
  final String? connectionType;
  bool? powerSaveMode;
  int? standbyBucket;
  bool? dozeExempt;
  int? thermalStatus;

  BatterySegmentClose? closedReason;

  BatteryUsageSegment({
    required this.startedAt,
    required this.startLevel,
    DateTime? endedAt,
    int? endLevel,
    this.startChargeUah,
    int? endChargeUah,
    this.foregroundMs = 0,
    this.backgroundMs = 0,
    this.networkRequests = 0,
    this.wsReconnects = 0,
    this.pushWakeups = 0,
    this.connectionType,
    this.powerSaveMode,
    this.standbyBucket,
    this.dozeExempt,
    this.thermalStatus,
    this.closedReason,
  })  : endedAt = endedAt ?? startedAt,
        endLevel = endLevel ?? startLevel,
        endChargeUah = endChargeUah ?? startChargeUah;

  Duration get duration => endedAt.difference(startedAt);

  /// Verbrauchte Prozentpunkte. Negativ wäre Laden — kommt vor, wenn der
  /// Zustandswechsel später gemeldet wird als der erste steigende Messwert,
  /// und macht das Fenster unbrauchbar (siehe [isReliable]).
  int get drainPercent => startLevel - endLevel;

  /// Entladerate in Prozent pro Stunde. `null`, solange kein Zeitraum vorliegt.
  double? get drainPerHour {
    final ms = duration.inMilliseconds;
    if (ms <= 0) return null;
    return drainPercent * 3600000 / ms;
  }

  /// Entnommene Ladung in mAh, wo die Plattform den Ladungszähler liefert.
  /// Anders als [drainPercent] nicht auf ganze Prozent quantisiert — das ist
  /// die Grösse, mit der sich eine Optimierung tatsächlich belegen lässt.
  double? get drainMah {
    final start = startChargeUah;
    final end = endChargeUah;
    if (start == null || end == null) return null;
    return (start - end) / 1000.0;
  }

  /// Mittlere Stromaufnahme des Geräts in mA über das Fenster. Nur verfügbar,
  /// wo [drainMah] es ist.
  double? get averageMilliAmps {
    final mah = drainMah;
    final ms = duration.inMilliseconds;
    if (mah == null || ms <= 0) return null;
    return mah * 3600000 / ms;
  }

  /// Netzanfragen pro Stunde — die Grösse, gegen die sich [drainPerHour] bzw.
  /// [averageMilliAmps] auftragen lässt, um eine Optimierung zu belegen.
  double? get requestsPerHour {
    final ms = duration.inMilliseconds;
    if (ms <= 0) return null;
    return networkRequests * 3600000 / ms;
  }

  /// Ob aus diesem Fenster überhaupt eine Rate abgeleitet werden darf.
  ///
  /// Die Mindestdauer gilt immer: sie mittelt kurze Lastspitzen heraus, die
  /// sonst als Dauerverbrauch durchgingen. Die Mindestentladung von zwei
  /// Prozentpunkten entfällt dagegen, wo ein Ladungszähler vorliegt — dessen
  /// Auflösung braucht sie nicht.
  bool get isReliable {
    if (closedReason == BatterySegmentClose.gap) return false;
    if (duration < minReliableDuration) return false;
    final mah = drainMah;
    if (mah != null) return mah > 0;
    return drainPercent >= minReliableDrop;
  }

  /// Nimmt einen Messpunkt auf. Gibt `false` zurück, wenn der Punkt nicht mehr
  /// in dieses Fenster passt — dann ist das Segment über [closedReason]
  /// bereits als beendet markiert und der Aufrufer beginnt ein neues.
  bool addSample(BatterySample sample) {
    if (closedReason != null) return false;

    // Rückwärts laufende Uhr oder ein Akkustand, der ohne Ladevorgang steigt:
    // beides lässt sich nicht als Entladung deuten.
    if (sample.at.isBefore(endedAt) || sample.level > endLevel) {
      closedReason = BatterySegmentClose.gap;
      return false;
    }

    // Ein Sturz um mehr als [maxPlausibleDropPerSample] zwischen zwei Punkten
    // ist kein Verbrauch, sondern eine Lücke: Gerät war suspendiert, der
    // Prozess wurde gekillt, oder der Akkutreiber hat neu kalibriert.
    if (endLevel - sample.level > maxPlausibleDropPerSample) {
      closedReason = BatterySegmentClose.gap;
      return false;
    }

    endedAt = sample.at;
    endLevel = sample.level;
    // Nur übernehmen, wenn das Fenster von Anfang an einen Zähler hatte —
    // sonst stünde einem Endwert kein Startwert gegenüber und die Differenz
    // wäre sinnlos.
    if (startChargeUah != null && sample.chargeUah != null) {
      endChargeUah = sample.chargeUah;
    }

    if (duration >= maxDuration) {
      closedReason = BatterySegmentClose.rollover;
    }
    return true;
  }

  /// Schliesst das Fenster, sofern nicht schon geschehen. Ein bereits
  /// gesetzter Grund bleibt stehen — ein `gap` darf nicht nachträglich zu
  /// einem sauberen `charging` werden.
  void close(BatterySegmentClose reason) {
    closedReason ??= reason;
  }

  Map<String, dynamic> toJson() => {
        'started_at': _format(startedAt),
        'ended_at': _format(endedAt),
        'start_level': startLevel,
        'end_level': endLevel,
        'duration_ms': duration.inMilliseconds,
        if (startChargeUah != null) 'start_charge_uah': startChargeUah,
        if (endChargeUah != null) 'end_charge_uah': endChargeUah,
        'foreground_ms': foregroundMs,
        'background_ms': backgroundMs,
        'network_requests': networkRequests,
        'ws_reconnects': wsReconnects,
        'push_wakeups': pushWakeups,
        'is_reliable': isReliable,
        'closed_reason': (closedReason ?? BatterySegmentClose.stopped).name,
        if (connectionType != null) 'connection_type': connectionType,
        if (powerSaveMode != null) 'power_save_mode': powerSaveMode,
        if (standbyBucket != null) 'standby_bucket': standbyBucket,
        if (dozeExempt != null) 'doze_exempt': dozeExempt,
        if (thermalStatus != null) 'thermal_status': thermalStatus,
      };

  factory BatteryUsageSegment.fromJson(Map<String, dynamic> json) =>
      BatteryUsageSegment(
        startedAt: _parseUtc(json['started_at'] as String),
        endedAt: _parseUtc(json['ended_at'] as String),
        startLevel: (json['start_level'] as num).toInt(),
        endLevel: (json['end_level'] as num).toInt(),
        startChargeUah: (json['start_charge_uah'] as num?)?.toInt(),
        endChargeUah: (json['end_charge_uah'] as num?)?.toInt(),
        foregroundMs: (json['foreground_ms'] as num?)?.toInt() ?? 0,
        backgroundMs: (json['background_ms'] as num?)?.toInt() ?? 0,
        networkRequests: (json['network_requests'] as num?)?.toInt() ?? 0,
        wsReconnects: (json['ws_reconnects'] as num?)?.toInt() ?? 0,
        pushWakeups: (json['push_wakeups'] as num?)?.toInt() ?? 0,
        connectionType: json['connection_type'] as String?,
        powerSaveMode: json['power_save_mode'] as bool?,
        standbyBucket: (json['standby_bucket'] as num?)?.toInt(),
        dozeExempt: json['doze_exempt'] as bool?,
        thermalStatus: (json['thermal_status'] as num?)?.toInt(),
        closedReason: _closeFromName(json['closed_reason'] as String?),
      );

  /// Serialisiert als `YYYY-MM-DD HH:MM:SS` in UTC — dasselbe Format wie
  /// [SecurityEvent], damit der Server beide Telemetriewege gleich behandeln
  /// kann. Ohne `Z` interpretiert `DateTime.parse` den String als Ortszeit,
  /// deshalb wird beim Lesen explizit UTC erzwungen.
  static String _format(DateTime dt) {
    final u = dt.toUtc();
    String p(int v, [int w = 2]) => v.toString().padLeft(w, '0');
    return '${p(u.year, 4)}-${p(u.month)}-${p(u.day)} '
        '${p(u.hour)}:${p(u.minute)}:${p(u.second)}';
  }

  static DateTime _parseUtc(String s) {
    final normalised = s.contains('T') ? s : s.replaceFirst(' ', 'T');
    return DateTime.parse(
      normalised.endsWith('Z') ? normalised : '${normalised}Z',
    ).toUtc();
  }

  static BatterySegmentClose? _closeFromName(String? name) {
    if (name == null) return null;
    for (final v in BatterySegmentClose.values) {
      if (v.name == name) return v;
    }
    return null;
  }
}
