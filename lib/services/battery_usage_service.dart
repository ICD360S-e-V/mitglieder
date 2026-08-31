import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'battery_platform_state.dart';
import 'battery_usage.dart';
// NetworkSource gehoert zum oeffentlichen Vertrag dieses Dienstes: wer ihn
// benutzt, muss den Verursacher benennen koennen.
export 'battery_usage.dart' show NetworkSource;
import 'device_key_service.dart';
import 'http_client_factory.dart';
import 'logger_service.dart';

/// Misst, wie schnell sich das Gerät entlädt, während diese App läuft, und
/// zählt im selben Fenster mit, was die App dabei tut.
///
/// Der Dienst ist so gebaut, dass er die Messung nicht selbst verfälscht — was
/// bei einem Akku-Messdienst die eigentliche Schwierigkeit ist:
///
///  * **Kein eigener Netz-Timer.** Gemeldet wird huckepack, wenn ohnehin
///    gesendet wird ([flush] wird von aussen angestossen) oder wenn ein
///    Messfenster endet. Ein Fenster dauert Stunden, ein Bericht ist ein paar
///    hundert Byte.
///  * **Abtastung ist rein lokal.** [_sampleInterval] löst einen Binder- bzw.
///    D-Bus-Aufruf aus, kein Funkmodem. 15 Minuten entsprechen dem Minimum,
///    das WorkManager für periodische Arbeit erlaubt, und damit dem Takt, den
///    Android für Hintergrundarbeit ohnehin für vertretbar hält.
///  * **Beim Laden wird gar nicht abgetastet.** Ohne Entladung gibt es nichts
///    zu messen, also läuft der Timer dann nicht.
///
/// Was der Dienst *nicht* kann, steht ausführlich in [battery_usage.dart]:
/// keine Plattform gibt den Verbrauch einer einzelnen App heraus. Gemessen
/// wird die Geräterate plus die Verursacherzähler; die Aussage entsteht aus
/// dem Vergleich zweier Zeiträume, nicht aus einer Einzelzahl.
class BatteryUsageService {
  BatteryUsageService._();
  static final BatteryUsageService instance = BatteryUsageService._();

  /// Wie [SecurityEventReporter] zeigt der Pfad zunächst auf Staging. Nach der
  /// Freigabe auf die Variante ohne `_test` wechseln.
  static const String _endpoint =
      'https://icd360sev.icd360s.de/api/telemetry/battery_usage_test.php';

  static const String _segmentsKey = 'battery_usage_segments_v1';

  /// Dieselbe Zustimmung, die [DiagnosticService] freischaltet — gesetzt vom
  /// DiagnosticConsentDialog.
  ///
  /// Bewusst kein zweiter Dialog: was hier anfällt, ist dieselbe Art von Datum
  /// wie dort (Akkustand, Sitzungsdauer stehen im Transparenzpanel bereits),
  /// und Mitglieder ein zweites Mal dieselbe Frage zu stellen erhöht die
  /// Zustimmungsquote nicht, sondern die Ermüdung. Ohne Zustimmung wird gar
  /// nicht erst gemessen — nicht etwa gemessen und dann nicht gesendet.
  static const String _consentKey = 'diagnostic_enabled';

  /// Zähler, den der Hintergrund-Isolate hochzählt. Der WebSocket lebt dort,
  /// nicht im UI-Isolate, und Reconnects sind der teuerste Einzelvorgang, den
  /// wir haben — ein vollständiger TLS-Handshake. Ohne diesen Umweg über
  /// SharedPreferences wären sie in der Messung unsichtbar.
  static const String _bgReconnectKey = 'battery_usage_bg_ws_reconnects';

  static const Duration _sampleInterval = Duration(minutes: 15);
  static const int _maxStoredSegments = 200;
  static const int _maxBatchSize = 50;

  final Battery _battery = Battery();
  final LoggerService _log = LoggerService();
  final DeviceKeyService _deviceKey = DeviceKeyService();

  final List<BatteryUsageSegment> _pending = [];
  BatteryUsageSegment? _current;

  Timer? _sampleTimer;
  StreamSubscription<BatteryState>? _stateSub;
  _LifecycleBridge? _lifecycle;
  late final http.Client _httpClient;

  bool _started = false;
  bool _pushing = false;
  bool _charging = false;
  bool _foreground = true;

  /// Zeitpunkt, seit dem die App ununterbrochen im aktuellen Zustand ist —
  /// Grundlage für die Vorder-/Hintergrund-Aufteilung eines Fensters.
  DateTime _stateSince = DateTime.now().toUtc();

  String? _deviceId;
  String? _appVersion;

  /// Nur für Tests: erlaubt es, ohne Wartezeit einen Messpunkt einzuspeisen.
  @visibleForTesting
  List<BatteryUsageSegment> get pendingSegments => List.unmodifiable(_pending);

  @visibleForTesting
  BatteryUsageSegment? get currentSegment => _current;

  /// Startet die Messung. Mehrfach aufrufbar — spätere Aufrufe aktualisieren
  /// nur noch die App-Version.
  ///
  /// Bewusst OHNE Mitgliedernummer. Zwei Gründe, die beide für sich reichen:
  ///
  ///  * Sie trägt zur Auswertung nichts bei. Entladeraten zwischen zwei
  ///    Geräten mit verschiedenen Akkus, Funkmodems und Android-Versionen sind
  ///    nicht vergleichbar; jede belastbare Aussage entsteht aus dem Vergleich
  ///    EINES Geräts mit sich selbst über App-Versionen hinweg. Dafür ist die
  ///    device_id die richtige und ausreichende Kennung.
  ///  * Der Zustimmungsdialog sagt Mitgliedern wörtlich zu, es werde „ein
  ///    anonymer Gerätecode (NICHT die Mitgliedsnummer)" gesendet. Ein zweiter
  ///    Kanal, der sie doch mitschickt, würde diese Zusage aushebeln — und
  ///    Akkustand und Sitzungsdauer, die hier anfallen, sind dort bereits als
  ///    das aufgeführt, was anonym übertragen wird.
  /// Ohne erteilte Diagnose-Zustimmung passiert nichts — kein Timer, kein
  /// Messfenster, keine Warteschlange. Der Aufruf aus `main()` läuft deshalb
  /// bei den meisten Starts ins Leere und ist trotzdem richtig dort: sagt ein
  /// Mitglied später zu, startet der Zustimmungsdialog den Dienst nach, und
  /// beim nächsten App-Start greift wieder dieser Aufruf.
  Future<void> start({
    required String deviceId,
    String? appVersion,
  }) async {
    _appVersion = appVersion ?? _appVersion;
    if (_started) return;

    if (!await _hasConsent()) {
      _log.info(
        'Akku-Messung nicht gestartet: keine Diagnose-Zustimmung',
        tag: 'BATTERY',
      );
      return;
    }

    _started = true;
    _deviceId = deviceId;

    _httpClient = IOClient(HttpClientFactory.createPinnedHttpClient(
      connectionTimeout: const Duration(seconds: 10),
      idleTimeout: const Duration(seconds: 10),
    ));

    await _loadPending();

    _lifecycle = _LifecycleBridge(_onLifecycle);
    WidgetsBinding.instance.addObserver(_lifecycle!);

    // Zustandswechsel kommen als Broadcast vom System — kostenlos, kein
    // Polling. Sie sind der Auslöser dafür, ein Fenster zu öffnen oder zu
    // schliessen.
    try {
      _stateSub = _battery.onBatteryStateChanged.listen(
        _onBatteryState,
        onError: (Object e) =>
            _log.debug('Akkuzustand nicht lesbar: $e', tag: 'BATTERY'),
      );
    } catch (e) {
      _log.warning('Akku-Zustandsstrom nicht verfügbar: $e', tag: 'BATTERY');
    }

    await _refreshChargingState();
    await _sampleNow();

    _log.info(
      'Akku-Messung gestartet (Abtastung alle ${_sampleInterval.inMinutes} min)',
      tag: 'BATTERY',
    );
  }

  Future<bool> _hasConsent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_consentKey) ?? false;
    } catch (e) {
      // Im Zweifel nicht messen. Eine unlesbare Einstellung ist keine
      // Zustimmung, und ein fehlendes Messfenster kostet nichts ausser einer
      // etwas kleineren Stichprobe.
      _log.warning('Zustimmung nicht lesbar: $e', tag: 'BATTERY');
      return false;
    }
  }

  /// Beendet die Messung und schliesst das laufende Fenster sauber ab, damit
  /// die bis hierher gesammelte Zeit nicht verloren geht.
  ///
  /// [discardPending] verwirft zusätzlich alles, was noch auf Versand wartet —
  /// für den Fall, dass eine Zustimmung zurückgenommen wird: dann darf auch
  /// nichts mehr abfliessen, was vorher aufgelaufen ist.
  Future<void> stop({bool discardPending = false}) async {
    if (_started) {
      _started = false;

      _sampleTimer?.cancel();
      _sampleTimer = null;
      await _stateSub?.cancel();
      _stateSub = null;
      if (_lifecycle != null) {
        WidgetsBinding.instance.removeObserver(_lifecycle!);
        _lifecycle = null;
      }

      // Beim Widerruf hat das Abschliessen keinen Zweck: das Fenster landete
      // nur in derselben Warteschlange, die gleich darauf geleert wird.
      if (!discardPending) {
        await _closeCurrent(BatterySegmentClose.stopped);
      } else {
        _current = null;
      }

      try {
        _httpClient.close();
      } catch (_) {}
    }

    // Auch dann ausführen, wenn der Dienst gar nicht lief — nach einem
    // Neustart ohne Zustimmung liegt die alte Warteschlange sonst unbegrenzt
    // auf dem Gerät.
    if (discardPending) {
      _pending.clear();
      await _persistPending();
      _log.info('Akku-Messung widerrufen, Warteschlange geleert',
          tag: 'BATTERY');
    }
  }

  // --- Verursacherzähler ----------------------------------------------------

  /// Schlüssel, unter dem [runAs] den Verursacher in der Zone hinterlegt.
  static const Object _sourceZoneKey = #icd360sevBatteryNetworkSource;

  /// Eine abgesetzte HTTP-Anfrage, zugeordnet zu ihrem Verursacher.
  void noteNetworkRequest(NetworkSource source, [int count = 1]) {
    _current?.addRequest(source, count);
  }

  /// Führt [body] so aus, dass jede darin abgesetzte Anfrage [source]
  /// zugeschrieben wird — auch quer über `await`-Grenzen hinweg.
  ///
  /// Nötig, weil die periodischen Dienste, die den Akku tatsächlich kosten,
  /// nicht alle einen eigenen HTTP-Client haben: HeartbeatService etwa ruft
  /// ApiService auf, und dort zählt ResilientHttpClient zentral mit. Ohne
  /// diese Markierung landete der Heartbeat in derselben Sammelkategorie wie
  /// ein Mitglied, das eine Ticketliste öffnet — und genau die beiden
  /// auseinanderzuhalten ist der Zweck der Aufschlüsselung.
  ///
  /// Eine Zone statt eines Feldes, weil zwei Anfragen gleichzeitig laufen
  /// können; ein gesetztes Feld gehörte dann der falschen.
  static T runAs<T>(NetworkSource source, T Function() body) =>
      runZoned(body, zoneValues: {_sourceZoneKey: source});

  /// Der Verursacher, in dessen [runAs] wir gerade stecken. Ausserhalb jeder
  /// Markierung ist es eine gewöhnliche Anfrage des Mitglieds.
  static NetworkSource get currentSource {
    final value = Zone.current[_sourceZoneKey];
    return value is NetworkSource ? value : NetworkSource.api;
  }

  /// Ein WebSocket-Neuaufbau im UI-Isolate.
  void noteWebSocketReconnect([int count = 1]) {
    _current?.wsReconnects += count;
  }

  /// Eine eingegangene Push-Nachricht, die das Gerät geweckt hat.
  void notePushWakeup([int count = 1]) {
    _current?.pushWakeups += count;
  }

  /// Aus dem Hintergrund-Isolate aufzurufen, wo [instance] einen eigenen,
  /// leeren Zustand hätte. Zählt persistent hoch; das UI-Isolate übernimmt den
  /// Stand beim nächsten Messpunkt.
  static Future<void> noteBackgroundWsReconnect() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(
        _bgReconnectKey,
        (prefs.getInt(_bgReconnectKey) ?? 0) + 1,
      );
    } catch (_) {
      // Zählerverlust ist folgenlos — die Messung läuft weiter.
    }
  }

  Future<void> _drainBackgroundCounters() async {
    if (_current == null) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final n = prefs.getInt(_bgReconnectKey) ?? 0;
      if (n > 0) {
        _current!.wsReconnects += n;
        await prefs.setInt(_bgReconnectKey, 0);
      }
    } catch (_) {}
  }

  // --- Abtastung ------------------------------------------------------------

  void _onLifecycle(AppLifecycleState state) {
    final nowForeground = state == AppLifecycleState.resumed;
    if (nowForeground == _foreground) return;
    _accrueStateTime();
    _foreground = nowForeground;

    // Ein Wechsel ist ein kostenloser Anlass, den Akkustand mitzunehmen: das
    // Gerät ist ohnehin wach.
    unawaited(_sampleNow());
  }

  void _onBatteryState(BatteryState state) {
    final charging = state == BatteryState.charging ||
        state == BatteryState.full ||
        state == BatteryState.connectedNotCharging;
    if (charging == _charging) return;
    _charging = charging;

    if (charging) {
      // Am Strom gibt es keine Entladung zu messen.
      unawaited(_closeCurrent(BatterySegmentClose.charging));
      _sampleTimer?.cancel();
      _sampleTimer = null;
    } else {
      unawaited(_sampleNow());
    }
  }

  Future<void> _refreshChargingState() async {
    try {
      final state = await _battery.batteryState
          .timeout(const Duration(seconds: 3));
      _charging = state == BatteryState.charging ||
          state == BatteryState.full ||
          state == BatteryState.connectedNotCharging;
    } catch (_) {
      _charging = false;
    }
  }

  void _ensureSampleTimer() {
    if (_sampleTimer != null || _charging || !_started) return;
    _sampleTimer = Timer.periodic(_sampleInterval, (_) => _sampleNow());
  }

  /// Nimmt einen Messpunkt. Rein lokal.
  Future<void> _sampleNow() async {
    if (!_started) return;
    if (_charging) return;

    final level = await _readLevel();
    if (level == null) return;

    final now = DateTime.now().toUtc();
    _accrueStateTime(now);
    await _drainBackgroundCounters();

    // Auf Android der genaue Messwert, sonst null — siehe
    // BatteryPlatformState.chargeCounterUah.
    final charge = (await BatteryPlatformState.read()).chargeCounterUah;
    final sample = BatterySample(at: now, level: level, chargeUah: charge);
    final current = _current;

    if (current == null) {
      await _openSegment(sample);
    } else if (!current.addSample(sample)) {
      // Fenster hat den Punkt abgelehnt und sich dabei selbst als beendet
      // markiert. Abschliessen und mit diesem Punkt neu beginnen.
      await _closeCurrent(current.closedReason ?? BatterySegmentClose.gap);
      await _openSegment(sample);
    } else if (current.closedReason == BatterySegmentClose.rollover) {
      await _closeCurrent(BatterySegmentClose.rollover);
      await _openSegment(sample);
    }

    _ensureSampleTimer();
  }

  Future<void> _openSegment(BatterySample sample) async {
    _current = BatteryUsageSegment(
      startedAt: sample.at,
      startLevel: sample.level,
      startChargeUah: sample.chargeUah,
      connectionType: await _connectionType(),
    );
    _stateSince = sample.at;
  }

  Future<int?> _readLevel() async {
    try {
      final level =
          await _battery.batteryLevel.timeout(const Duration(seconds: 3));
      // battery_plus liefert auf manchen Android-Geräten kurz nach dem Start
      // -1, und Desktops ohne Akku melden gar nichts Sinnvolles.
      if (level < 0 || level > 100) return null;
      return level;
    } catch (_) {
      return null;
    }
  }

  Future<String?> _connectionType() async {
    try {
      final results = await Connectivity().checkConnectivity();
      if (results.contains(ConnectivityResult.wifi)) return 'wifi';
      if (results.contains(ConnectivityResult.mobile)) return 'mobile';
      if (results.contains(ConnectivityResult.ethernet)) return 'ethernet';
      if (results.contains(ConnectivityResult.vpn)) return 'vpn';
      if (results.contains(ConnectivityResult.none)) return 'none';
    } catch (_) {}
    return null;
  }

  /// Schreibt die seit dem letzten Wechsel vergangene Zeit dem passenden Topf
  /// des laufenden Fensters gut.
  void _accrueStateTime([DateTime? now]) {
    final at = now ?? DateTime.now().toUtc();
    final elapsed = at.difference(_stateSince).inMilliseconds;
    _stateSince = at;
    final current = _current;
    if (current == null || elapsed <= 0) return;
    if (_foreground) {
      current.foregroundMs += elapsed;
    } else {
      current.backgroundMs += elapsed;
    }
  }

  Future<void> _closeCurrent(BatterySegmentClose reason) async {
    final current = _current;
    if (current == null) return;
    _accrueStateTime();

    final platform = await BatteryPlatformState.read();
    current
      ..powerSaveMode = platform.powerSaveMode
      ..standbyBucket = platform.standbyBucket
      ..dozeExempt = platform.dozeExempt
      ..thermalStatus = platform.thermalStatus
      ..close(reason);

    _current = null;

    // Ein Fenster ohne jede Entladung sagt nichts aus und muss nicht über das
    // Netz — verworfen, bevor es Platz oder Funkzeit kostet.
    if (current.drainPercent <= 0 &&
        current.closedReason != BatterySegmentClose.gap) {
      return;
    }

    if (_pending.length >= _maxStoredSegments) {
      _pending.removeAt(0);
    }
    _pending.add(current);
    await _persistPending();

    final rate = current.drainPerHour;
    _log.info(
      'Akku-Fenster abgeschlossen: ${current.drainPercent} % in '
      '${current.duration.inMinutes} min'
      '${rate == null ? '' : ' (${rate.toStringAsFixed(2)} %/h)'}, '
      '${current.networkRequests} Netzanfragen '
      '(${current.requestsBySource.entries.map((e) => '${e.key.name}=${e.value}').join(', ')}), '
      '${current.wsReconnects} WS-Reconnects, '
      'zuverlässig=${current.isReliable}',
      tag: 'BATTERY',
    );

    unawaited(flush());
  }

  // --- Meldung --------------------------------------------------------------

  /// Schickt fertige Messfenster an den Server. Von aussen anzustossen, wenn
  /// ohnehin Netzverkehr stattfindet — der Dienst hält dafür keinen eigenen
  /// Timer.
  Future<void> flush() async {
    if (_pushing || _pending.isEmpty) return;
    if (_deviceKey.deviceKey == null) return;

    _pushing = true;
    try {
      while (_pending.isNotEmpty) {
        final batch = _pending.take(_maxBatchSize).toList();
        if (!await _pushBatch(batch)) break;
        _pending.removeRange(0, batch.length);
        await _persistPending();
      }
    } finally {
      _pushing = false;
    }
  }

  Future<bool> _pushBatch(List<BatteryUsageSegment> batch) async {
    try {
      final response = await _httpClient
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'ICD360S-Mitglied/${_appVersion ?? "unknown"}',
              'X-Device-Key': _deviceKey.deviceKey!,
            },
            body: jsonEncode({
              'device_id': _deviceId ?? 'unknown',
              'platform': Platform.operatingSystem,
              'os_version': Platform.operatingSystemVersion,
              if (_appVersion != null) 'app_version': _appVersion,
              'segments': batch.map((s) => s.toJson()).toList(),
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        _log.info('${batch.length} Akku-Fenster gemeldet', tag: 'BATTERY');
        return true;
      }
      _log.warning(
        'Akku-Meldung fehlgeschlagen: HTTP ${response.statusCode}',
        tag: 'BATTERY',
      );
      return false;
    } catch (e) {
      // Bleibt in der Warteschlange; der nächste Anlass versucht es erneut.
      _log.debug('Akku-Meldung verschoben: $e', tag: 'BATTERY');
      return false;
    }
  }

  // --- Persistenz -----------------------------------------------------------

  Future<void> _loadPending() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_segmentsKey);
      if (raw == null || raw.isEmpty) return;
      final list = jsonDecode(raw) as List<dynamic>;
      _pending.addAll(list
          .whereType<Map<String, dynamic>>()
          .map(BatteryUsageSegment.fromJson));
    } catch (e) {
      _log.warning('Akku-Warteschlange nicht lesbar: $e', tag: 'BATTERY');
    }
  }

  Future<void> _persistPending() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _segmentsKey,
        jsonEncode(_pending.map((s) => s.toJson()).toList()),
      );
    } catch (e) {
      _log.warning('Akku-Warteschlange nicht speicherbar: $e', tag: 'BATTERY');
    }
  }
}

/// Reicht Lebenszyklus-Wechsel an den Dienst weiter. Eigene Klasse, weil
/// [WidgetsBindingObserver] ein Mixin auf einem Objekt braucht, das der
/// Singleton selbst nicht sein soll — er wird auch ohne gebundenes
/// Widgets-Binding in Tests benutzt.
class _LifecycleBridge with WidgetsBindingObserver {
  _LifecycleBridge(this.onState);
  final void Function(AppLifecycleState) onState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => onState(state);
}
