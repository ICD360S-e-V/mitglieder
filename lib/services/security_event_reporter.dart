import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'circuit_breaker.dart';
import 'device_key_service.dart';
import 'http_client_factory.dart';
import 'logger_service.dart';
import 'network_details_service.dart';
import 'network_error_classifier.dart';
import 'network_resilience.dart';
import 'secure_storage_helper.dart';
import 'security_event.dart';

/// Collects [SecurityEvent]s from the [CircuitBreaker] event stream, coalesces
/// duplicates within a 5-minute window, persists the queue to SecureStorage so
/// nothing is lost across app restarts, and flushes the batch to the server's
/// security endpoint whenever the network recovers.
///
/// Reports go through the SAME pinned HTTPS channel as the rest of the app —
/// no fallback transport — so the queue may sit on the device for a while on
/// a persistently hostile network. A connectivity change or an open->closed
/// transition is enough to drain it.
class SecurityEventReporter {
  SecurityEventReporter._();
  static final SecurityEventReporter instance = SecurityEventReporter._();

  /// Endpoint URL. Defaults to the **staging** path during development; switch
  /// to the non-`_test` path once promotion to production is done.
  static const String _endpoint =
      'https://icd360sev.icd360s.de/api/security/tls_failure_test.php';

  static const String _queueStorageKey = 'security_event_queue_v1';
  static const Duration _coalescingWindow = Duration(minutes: 5);
  static const int _maxQueueSize = 200;
  static const int _maxBatchSize = 50;

  final LoggerService _log = LoggerService();
  final _secureStorage = createSecureStorage();
  final DeviceKeyService _deviceKey = DeviceKeyService();

  final List<SecurityEvent> _queue = [];
  StreamSubscription<CircuitBreakerEvent>? _eventsSub;

  String? _mitgliedernummer;
  String? _appVersion;
  String? _platform;
  String? _osVersion;
  String? _deviceId;
  bool _pushing = false;
  bool _started = false;
  late final http.Client _httpClient;

  /// Initialise: load persisted queue, subscribe to circuit events, start a
  /// non-blocking drain attempt. Idempotent.
  Future<void> start({
    required String deviceId,
    String? mitgliedernummer,
    String? appVersion,
    String? platform,
    String? osVersion,
  }) async {
    if (_started) {
      _mitgliedernummer = mitgliedernummer ?? _mitgliedernummer;
      _appVersion = appVersion ?? _appVersion;
      _platform = platform ?? _platform;
      _osVersion = osVersion ?? _osVersion;
      return;
    }
    _started = true;

    _deviceId = deviceId;
    _mitgliedernummer = mitgliedernummer;
    _appVersion = appVersion;
    _platform = platform;
    _osVersion = osVersion;

    _httpClient = IOClient(HttpClientFactory.createPinnedHttpClient(
      connectionTimeout: const Duration(seconds: 10),
      idleTimeout: const Duration(seconds: 10),
    ));

    await _loadQueue();
    _eventsSub = NetworkResilience.instance.events.listen(_onCircuitEvent);

    // Best-effort drain on launch.
    unawaited(_attemptPush());
  }

  Future<void> stop() async {
    await _eventsSub?.cancel();
    _eventsSub = null;
    _started = false;
    try {
      _httpClient.close();
    } catch (_) {}
  }

  void _onCircuitEvent(CircuitBreakerEvent ev) {
    // Record on trip (transition into open).
    if (ev.newState == CircuitState.open && ev.triggerError != null) {
      unawaited(_recordFromCircuit(ev));
    }

    // Drain on recovery.
    if (ev.newState == CircuitState.closed) {
      unawaited(_attemptPush());
    }
  }

  Future<void> _recordFromCircuit(CircuitBreakerEvent ev) async {
    final error = ev.triggerError!;
    final connectionType = await _currentConnectionType();
    final details = await NetworkDetailsService.instance.collectIfGranted();

    await record(SecurityEvent(
      host: _hostFromError(error) ?? 'icd360sev.icd360s.de',
      category: ev.errorCategory ?? NetworkErrorClassifier.categorize(error),
      firstSeen: ev.timestamp,
      errorMessage: error.toString(),
      networkType: connectionType,
      networkSsid: details.ssid,
      networkBssid: details.bssid,
      networkSsidDenied: details.denied,
    ));
  }

  Future<String?> _currentConnectionType() async {
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

  /// Public API: external collectors (e.g. badCertificateCallback) can record
  /// events with richer fields than what comes through the circuit stream.
  Future<void> record(SecurityEvent event) async {
    final key = event.coalescingKey;
    final now = DateTime.now();

    // Coalesce with any in-window entry sharing the same key.
    for (final existing in _queue) {
      if (existing.coalescingKey == key &&
          now.difference(existing.lastSeen) <= _coalescingWindow) {
        existing.lastSeen = event.lastSeen;
        existing.occurrenceCount += event.occurrenceCount;
        await _persistQueue();
        return;
      }
    }

    if (_queue.length >= _maxQueueSize) {
      _queue.removeAt(0);
    }
    _queue.add(event);
    await _persistQueue();
  }

  Future<void> drainNow() => _attemptPush();

  Future<void> _attemptPush() async {
    if (_pushing || _queue.isEmpty) return;
    if (_deviceKey.deviceKey == null) return;

    _pushing = true;
    try {
      while (_queue.isNotEmpty) {
        final batch = _queue.take(_maxBatchSize).toList();
        final sent = await _pushBatch(batch);
        if (!sent) break;
        _queue.removeRange(0, batch.length);
        await _persistQueue();
      }
    } finally {
      _pushing = false;
    }
  }

  Future<bool> _pushBatch(List<SecurityEvent> batch) async {
    try {
      final body = jsonEncode({
        'device_id': _deviceId ?? 'unknown',
        if (_mitgliedernummer != null) 'mitgliedernummer': _mitgliedernummer,
        if (_platform != null) 'platform': _platform,
        if (_osVersion != null) 'os_version': _osVersion,
        if (_appVersion != null) 'app_version': _appVersion,
        'user_agent': 'ICD360S-Mitglied/${_appVersion ?? "unknown"}',
        'events': batch.map((e) => e.toJson()).toList(),
      });

      final response = await _httpClient
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'ICD360S-Mitglied/${_appVersion ?? "unknown"}',
              'X-Device-Key': _deviceKey.deviceKey!,
            },
            body: body,
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        _log.info(
          'Pushed ${batch.length} TLS failure events',
          tag: 'SECURITY',
        );
        return true;
      }
      _log.warning(
        'TLS failure push failed: HTTP ${response.statusCode}',
        tag: 'SECURITY',
      );
      return false;
    } catch (e) {
      // Network still bad — keep batch in queue, try later.
      _log.debug('TLS failure push deferred: $e', tag: 'SECURITY');
      return false;
    }
  }

  Future<void> _loadQueue() async {
    try {
      final raw = await _secureStorage.read(key: _queueStorageKey);
      if (raw == null || raw.isEmpty) return;
      final list = jsonDecode(raw) as List<dynamic>;
      _queue.addAll(list
          .whereType<Map<String, dynamic>>()
          .map(SecurityEvent.fromJson));
    } catch (e) {
      _log.warning('Could not load security queue: $e', tag: 'SECURITY');
    }
  }

  Future<void> _persistQueue() async {
    try {
      final list = _queue.map((e) => e.toJson()).toList();
      await _secureStorage.write(
        key: _queueStorageKey,
        value: jsonEncode(list),
      );
    } catch (e) {
      _log.warning('Could not persist security queue: $e', tag: 'SECURITY');
    }
  }

  String? _hostFromError(Object error) {
    final msg = error.toString();
    final hostMatch = RegExp(r'host:\s*([^\s,]+)').firstMatch(msg);
    if (hostMatch != null) return hostMatch.group(1);
    final uriMatch = RegExp(r'https?://([^/\s]+)').firstMatch(msg);
    if (uriMatch != null) return uriMatch.group(1);
    return null;
  }

}
