import 'dart:async';
import 'api_service.dart';
import 'logger_service.dart';
import 'network_info_service.dart';

final _log = LoggerService();

/// Heartbeat Service - updates last_seen in real-time
/// Sends heartbeat to server every 15 seconds to update last_seen timestamp
/// This ensures support/admin can see when member is online
class HeartbeatService {
  static const Duration _interval = Duration(seconds: 60);

  Timer? _timer;
  String? _currentMitgliedernummer;
  ApiService? _apiService;
  bool _isActive = false;
  bool _isSending = false;

  // Singleton
  static final HeartbeatService _instance = HeartbeatService._internal();
  factory HeartbeatService(ApiService apiService) {
    _instance._apiService = apiService;
    return _instance;
  }
  HeartbeatService._internal();

  /// Start heartbeat updates
  void start(String mitgliedernummer) {
    _log.info('Heartbeat: Starting for $mitgliedernummer', tag: 'HEARTBEAT');
    _currentMitgliedernummer = mitgliedernummer;
    _isActive = true;

    // Cancel existing timer
    _timer?.cancel();

    // Start periodic heartbeat
    _timer = Timer.periodic(_interval, (_) => _sendHeartbeat());

    // Send initial heartbeat immediately
    _sendHeartbeat();
  }

  /// Stop heartbeat updates
  void stop() {
    _log.info('Heartbeat: Stopping', tag: 'HEARTBEAT');
    _timer?.cancel();
    _timer = null;
    _isActive = false;
    _currentMitgliedernummer = null;
  }

  /// Send heartbeat to server (with network info)
  Future<void> _sendHeartbeat() async {
    if (!_isActive || _currentMitgliedernummer == null || _apiService == null) {
      return;
    }
    if (_isSending) return;
    _isSending = true;

    try {
      // Collect network info
      final networkInfo = await NetworkInfoService().getNetworkInfo(
        '${ApiService.baseUrl}/auth/heartbeat_app.php',
      );

      final result = await _apiService!.sendHeartbeat(
        _currentMitgliedernummer!,
        connectionType: networkInfo['connection_type'],
        latencyMs: networkInfo['latency_ms'],
        networkQuality: networkInfo['quality'],
      );

      if (result['success'] == true) {
        _log.debug('Heartbeat: OK [${networkInfo['connection_type']} ${networkInfo['latency_ms']}ms ${networkInfo['quality']}]', tag: 'HEARTBEAT');
      } else {
        _log.warning('Heartbeat: Failed - ${result['message']}', tag: 'HEARTBEAT');
      }
    } catch (e) {
      // Silently fail - don't interrupt app for heartbeat failures
      _log.error('Heartbeat: Error sending - $e', tag: 'HEARTBEAT');
    } finally {
      _isSending = false;
    }
  }

  /// Check if heartbeat is active
  bool get isActive => _isActive;

  /// Dispose service
  void dispose() {
    stop();
  }
}
