import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';
import 'http_client_factory.dart';

/// Diagnostic Service - sends app diagnostics to server every 15 seconds
class DiagnosticService {
  static const String _diagnosticUrl = 'https://icd360sev.icd360s.de/api/diagnostic/log.php';
  static const Duration _interval = Duration(seconds: 120);

  Timer? _timer;
  String? _currentUser;
  String? _currentRole;
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

  /// Start diagnostic reporting
  void start({String? userId, String? userRole}) {
    _currentUser = userId;
    _currentRole = userRole;
    _sessionStart = DateTime.now();
    _appState = 'running';

    // Cancel existing timer
    _timer?.cancel();

    // Start periodic reporting
    _timer = Timer.periodic(_interval, (_) => _sendDiagnostics());

    // Send initial diagnostic immediately
    _sendDiagnostics();

    debugPrint('[Diagnostic] Started for user: $_currentUser');
  }

  /// Stop diagnostic reporting
  void stop() {
    _timer?.cancel();
    _timer = null;
    _appState = 'stopped';
    _sendDiagnostics(); // Send final state
    debugPrint('[Diagnostic] Stopped');
  }

  /// Update current user info
  void setUser(String? userId, String? userRole) {
    _currentUser = userId;
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
        'user_id': _currentUser,
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

      final response = await _client.post(
        Uri.parse(_diagnosticUrl),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'ICD360S-Mitglieder-${Platform.operatingSystem}/1.0',
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
