import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:battery_plus/battery_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_client_factory.dart';
import 'battery_usage_service.dart';

/// Diagnostic Service - sends app diagnostics to server every 15 seconds
class DiagnosticService {
  static const String _diagnosticUrl = 'https://icd360sev.icd360s.de/api/diagnostic/log.php';
  /// Waren 120 s — 30 Funkaufwachvorgänge pro Stunde für eine Momentaufnahme,
  /// die sich zwischen zwei Messungen so gut wie nie ändert. Der Bildschirm,
  /// auf dem jemand steht, und der Akkustand sind keine Grössen, die eine
  /// Auflösung von zwei Minuten brauchen; die Fehlerliste geht davon
  /// unabhängig raus.
  ///
  /// 15 Minuten entsprechen dem Minimum, das WorkManager für periodische
  /// Arbeit erlaubt — der Takt, den Android für Hintergrundarbeit selbst für
  /// vertretbar hält.
  ///
  /// ACHTUNG: Dieser Wert steht Mitgliedern wörtlich im Zustimmungsdialog
  /// (`claudiuDiagnosticTech1`, alle 28 Sprachen). Wer ihn ändert, ändert
  /// diese Zeichenkette mit — sonst sagt die App etwas zu, was sie nicht hält.
  static const Duration _interval = Duration(minutes: 15);

  /// Derselbe Schluessel, den startup_diagnostics.dart schon liest: zur
  /// Bauzeit per --dart-define aus dem Secret MITGLIEDER_STARTUP_DIAG_KEY.
  /// Leer bei `flutter run` — dann geht die Meldung wie bisher ohne
  /// Kopfzeile hinaus.
  ///
  /// Hintergrund: api/diagnostic/log.php hatte bis 25.08.2026 GAR KEINE
  /// Pruefung. Jeder im Netz konnte Zeilen unter beliebiger
  /// Mitgliedsnummer schreiben. Der Server nimmt schluessellose Meldungen
  /// vorerst weiter an und protokolliert sie — erst wenn dort keine mehr
  /// auftauchen, wird auf 401 umgestellt. Ohne diese Staffelung waere die
  /// Diagnose aller Geraete sofort tot gewesen, denn den Endpunkt
  /// benutzen alle drei Apps.
  static const String _diagKey =
      String.fromEnvironment('STARTUP_DIAG_KEY', defaultValue: '');

  Timer? _timer;
  String? _currentRole;
  /// Random hex generated once per device install and persisted in
  /// SharedPreferences under [_anonymousIdKey]. Replaces the previous
  /// `user_id` field which was the literal mitgliedernummer — that
  /// uniquely identified a real member on the diagnostic server, which
  /// directly contradicted the "no personal data collected" promise the
  /// consent dialog shows. The anonymous id keeps per-device grouping
  /// useful for debugging without exposing membership identity.
  String? _anonymousId;
  static const String _anonymousIdKey = 'diagnostic_anonymous_id';
  String _appState = 'unknown';
  String _lastScreen = 'unknown';
  final List<String> _recentErrors = [];
  final List<String> _recentActions = [];
  DateTime _sessionStart = DateTime.now();
  bool _isConnected = false;
  late http.Client _client;
  final Battery _battery = Battery();

  // Singleton
  static final DiagnosticService _instance = DiagnosticService._internal();
  factory DiagnosticService() => _instance;
  DiagnosticService._internal() {
    // Security: Proper SSL certificate validation
    _client = IOClient(HttpClientFactory.createPinnedHttpClient());
  }

  /// Start diagnostic reporting. `userId` is accepted for backwards
  /// compatibility with callers that still pass the mitgliedernummer but
  /// is intentionally ignored — the payload always carries the
  /// anonymous_id instead.
  Future<void> start({String? userId, String? userRole}) async {
    await _ensureAnonymousId();
    _currentRole = userRole;
    _sessionStart = DateTime.now();
    _appState = 'running';

    // Cancel existing timer
    _timer?.cancel();

    // Start periodic reporting
    _timer = Timer.periodic(_interval, (_) => _sendDiagnostics());

    // Send initial diagnostic immediately
    _sendDiagnostics();

    debugPrint('[Diagnostic] Started (anonymous_id=$_anonymousId)');
  }

  /// Load the persistent random id, or generate + store one on first use.
  /// 16 random bytes → 32 hex chars. Survives logout/login but not a
  /// reinstall — that's the privacy property we want.
  Future<void> _ensureAnonymousId() async {
    if (_anonymousId != null) return;
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_anonymousIdKey);
    if (id == null || id.isEmpty) {
      final rng = Random.secure();
      final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
      id = bytes
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join();
      await prefs.setString(_anonymousIdKey, id);
    }
    _anonymousId = id;
  }

  /// Stop diagnostic reporting
  void stop() {
    _timer?.cancel();
    _timer = null;
    _appState = 'stopped';
    _sendDiagnostics(); // Send final state
    debugPrint('[Diagnostic] Stopped');
  }

  /// Update current user info. `userId` (mitgliedernummer) is ignored —
  /// the payload uses the anonymous_id instead. Only the role is kept,
  /// since "vorstand sees X bug more often than mitglied" is useful
  /// debugging signal and doesn't identify an individual.
  void setUser(String? userId, String? userRole) {
    _currentRole = userRole;
  }

  /// Update app state
  void setAppState(String state) {
    _appState = state;
  }

  /// Update current screen
  void setScreen(String screen) {
    _lastScreen = screen;
    _addAction('screen:$screen');
  }

  /// Set connection status
  void setConnected(bool connected) {
    _isConnected = connected;
  }

  /// Log an error
  void logError(String error) {
    final timestamp = DateTime.now().toIso8601String();
    _recentErrors.add('[$timestamp] $error');
    // Keep only last 10 errors
    if (_recentErrors.length > 10) {
      _recentErrors.removeAt(0);
    }
  }

  /// Log a user action
  void logAction(String action) {
    _addAction(action);
  }

  void _addAction(String action) {
    final timestamp = DateTime.now().toIso8601String();
    _recentActions.add('[$timestamp] $action');
    // Keep only last 20 actions
    if (_recentActions.length > 20) {
      _recentActions.removeAt(0);
    }
  }

  /// Get battery info (level + state) with retry for Android
  Future<Map<String, dynamic>> _getBatteryInfo() async {
    for (int attempt = 0; attempt < 2; attempt++) {
      try {
        final level = await _battery.batteryLevel.timeout(const Duration(seconds: 3));
        final state = await _battery.batteryState.timeout(const Duration(seconds: 3));
        final stateStr = switch (state) {
          BatteryState.charging => 'charging',
          BatteryState.discharging => 'discharging',
          BatteryState.full => 'full',
          BatteryState.connectedNotCharging => 'connected_not_charging',
          BatteryState.unknown => 'unknown',
        };
        if (level >= 0) return {'level': level, 'state': stateStr};
        // level -1: retry after short delay
        if (attempt == 0) await Future.delayed(const Duration(milliseconds: 300));
      } catch (e) {
        debugPrint('[Diagnostic] Battery attempt ${attempt + 1} failed: $e');
        if (attempt == 0) await Future.delayed(const Duration(milliseconds: 300));
      }
    }
    return {'level': -1, 'state': 'error'};
  }

  /// Send diagnostics to server
  Future<void> _sendDiagnostics() async {
    try {
      final batteryInfo = await _getBatteryInfo();
      final diagnostics = {
        'timestamp': DateTime.now().toIso8601String(),
        'anonymous_id': _anonymousId,
        'user_role': _currentRole,
        'app_state': _appState,
        'last_screen': _lastScreen,
        'session_start': _sessionStart.toIso8601String(),
        'session_duration_seconds': DateTime.now().difference(_sessionStart).inSeconds,
        'is_connected': _isConnected,
        'platform': Platform.operatingSystem,
        'platform_version': Platform.operatingSystemVersion,
        'locale': Platform.localeName,
        'battery_level': batteryInfo['level'],
        'battery_state': batteryInfo['state'],
        'recent_errors': _recentErrors,
        'recent_actions': _recentActions.take(10).toList(),
        'memory_usage': _getMemoryInfo(),
      };

      BatteryUsageService.instance.noteNetworkRequest();
      final response = await _client.post(
        Uri.parse(_diagnosticUrl),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'ICD360S-Mitglieder-${Platform.operatingSystem}/1.0',
          if (_diagKey.isNotEmpty) 'X-Diag-Key': _diagKey,
        },
        body: jsonEncode(diagnostics),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        debugPrint('[Diagnostic] Sent successfully');
      }
    } catch (e) {
      // Silently fail - don't interrupt app for diagnostic failures
      debugPrint('[Diagnostic] Failed to send: $e');
    }
  }

  Map<String, dynamic> _getMemoryInfo() {
    try {
      return {
        'pid': pid,
      };
    } catch (e) {
      return {};
    }
  }

  /// Dispose service
  void dispose() {
    stop();
  }
}
