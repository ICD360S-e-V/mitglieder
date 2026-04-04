import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Service to collect network information (connection type + latency)
/// Data is sent to server with heartbeat for Vorsitzer to see in live chat
class NetworkInfoService {
  static final NetworkInfoService _instance = NetworkInfoService._internal();
  factory NetworkInfoService() => _instance;
  NetworkInfoService._internal();

  final Connectivity _connectivity = Connectivity();

  String _connectionType = 'unknown';
  int _latencyMs = -1;
  DateTime? _lastPingTime;

  String get connectionType => _connectionType;
  int get latencyMs => _latencyMs;
  DateTime? get lastPingTime => _lastPingTime;

  /// Get current connection type as readable string
  /// Returns: wifi, mobile_5g, mobile_4g, mobile_3g, mobile, ethernet, vpn, none, unknown
  Future<String> getConnectionType() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.contains(ConnectivityResult.wifi)) {
        _connectionType = 'wifi';
      } else if (results.contains(ConnectivityResult.mobile)) {
        _connectionType = 'mobile';
      } else if (results.contains(ConnectivityResult.ethernet)) {
        _connectionType = 'ethernet';
      } else if (results.contains(ConnectivityResult.vpn)) {
        _connectionType = 'vpn';
      } else if (results.contains(ConnectivityResult.none)) {
        _connectionType = 'none';
      } else {
        _connectionType = 'unknown';
      }
    } catch (e) {
      debugPrint('[NetworkInfo] Error getting connection type: $e');
      _connectionType = 'unknown';
    }
    return _connectionType;
  }

  /// Measure latency (ping) to server
  /// Returns latency in milliseconds, -1 on failure
  Future<int> measureLatency(String serverUrl) async {
    HttpClient? client;
    try {
      final stopwatch = Stopwatch()..start();
      client = HttpClient()..connectionTimeout = const Duration(seconds: 5);
      final request = await client.headUrl(Uri.parse(serverUrl));
      request.headers.set('User-Agent', 'ICD360S-Mitglied/1.0');
      final response = await request.close();
      await response.drain();
      stopwatch.stop();

      _latencyMs = stopwatch.elapsedMilliseconds;
      _lastPingTime = DateTime.now();
      return _latencyMs;
    } catch (e) {
      debugPrint('[NetworkInfo] Ping failed: $e');
      _latencyMs = -1;
      return -1;
    } finally {
      client?.close();
    }
  }

  /// Get network quality label based on latency
  /// good: <100ms, medium: 100-300ms, poor: >300ms, offline: -1
  String getQuality() {
    if (_latencyMs < 0) return 'offline';
    if (_latencyMs < 100) return 'good';
    if (_latencyMs <= 300) return 'medium';
    return 'poor';
  }

  /// Get all network info as a map (for sending to server)
  /// Ping is only measured every 5 minutes to save battery
  static const Duration _pingInterval = Duration(minutes: 5);

  Future<Map<String, dynamic>> getNetworkInfo(String serverUrl) async {
    await getConnectionType();
    // Only measure latency every 5 minutes (expensive: creates HttpClient)
    if (_lastPingTime == null || DateTime.now().difference(_lastPingTime!) > _pingInterval) {
      await measureLatency(serverUrl);
    }
    return {
      'connection_type': _connectionType,
      'latency_ms': _latencyMs,
      'quality': getQuality(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
