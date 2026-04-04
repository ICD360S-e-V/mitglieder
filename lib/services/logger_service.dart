import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'secure_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';

/// Logger Service - captures app logs for debugging
class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;
  LoggerService._internal();

  final List<LogEntry> _logs = [];
  final List<LogEntry> _uploadQueue = [];
  final _controller = StreamController<List<LogEntry>>.broadcast();
  final _secureStorage = createSecureStorage();
  Timer? _uploadTimer;

  String? _deviceId;
  String? _machineName;
  String? _mitgliedernummer;
  String? _appVersion;

  static String get _uploadUrl {
    if (Platform.isWindows) return 'https://icd360sev.icd360s.de/api/logs/mitglieder_windows.php';
    return 'https://icd360sev.icd360s.de/api/logs/mitglieder_android.php';
  }
  static const Duration _uploadInterval = Duration(seconds: 30);

  Stream<List<LogEntry>> get logStream => _controller.stream;
  List<LogEntry> get logs => List.unmodifiable(_logs);
  String get deviceId => _deviceId ?? 'unknown';
  String get machineName => _machineName ?? 'unknown';

  /// Initialize device ID (call once at app startup)
  Future<void> init() async {
    // Get machine name
    try {
      _machineName = Platform.localHostname;
    } catch (e) {
      _machineName = 'unknown';
    }

    // Get or generate persistent device ID
    try {
      _deviceId = await _secureStorage.read(key: 'device_id');
      if (_deviceId == null) {
        _deviceId = _generateDeviceId();
        await _secureStorage.write(key: 'device_id', value: _deviceId);
      }
    } catch (e) {
      _deviceId = _generateDeviceId();
    }

    info('Logger initialized: deviceId=$_deviceId, machine=$_machineName', tag: 'SYS');
  }

  /// Start periodic log upload to server
  void startUpload(String mitgliedernummer, String appVersion) {
    _mitgliedernummer = mitgliedernummer;
    _appVersion = appVersion;
    _uploadTimer?.cancel();
    _uploadTimer = Timer.periodic(_uploadInterval, (_) => _uploadLogsToServer());
    info('Log upload started for $mitgliedernummer v$appVersion (every ${_uploadInterval.inSeconds}s)', tag: 'LOG');
  }

  /// Stop log upload
  void stopUpload() {
    _uploadTimer?.cancel();
    _uploadTimer = null;
    info('Log upload stopped', tag: 'LOG');
  }

  String _generateDeviceId() {
    final random = Random.secure();
    final values = List<int>.generate(16, (_) => random.nextInt(256));
    return values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  void log(String message, {LogLevel level = LogLevel.info, String? tag}) {
    final entry = LogEntry(
      timestamp: DateTime.now(),
      message: message,
      level: level,
      tag: tag,
    );
    _logs.add(entry);
    if (_logs.length > 500) {
      _logs.removeAt(0);
    }
    _controller.add(_logs);

    // Add to upload queue
    _uploadQueue.add(entry);

    // Upload immediately for errors
    if (level == LogLevel.error && _mitgliedernummer != null) {
      _uploadLogsToServer();
    }
  }

  /// Upload logs to server
  Future<void> _uploadLogsToServer() async {
    if (_uploadQueue.isEmpty || _mitgliedernummer == null) return;

    final logsToUpload = List<LogEntry>.from(_uploadQueue);
    _uploadQueue.clear();

    try {
      final logsJson = logsToUpload.map((log) => {
        'timestamp': log.timestamp.toIso8601String(),
        'message': log.message,
        'level': log.level.toString().split('.').last,
        'tag': log.tag,
      }).toList();

      final response = await http.post(
        Uri.parse(_uploadUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mitgliedernummer': _mitgliedernummer,
          'device_id': _deviceId,
          'platform': Platform.operatingSystem,
          'app_version': _appVersion,
          'logs': logsJson,
        }),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        debugPrint('[LOG] Uploaded ${logsToUpload.length} logs to server');
      } else {
        debugPrint('[LOG] Upload failed: ${response.statusCode}');
        _uploadQueue.addAll(logsToUpload);
      }
    } catch (e) {
      debugPrint('[LOG] Upload error: $e');
      _uploadQueue.addAll(logsToUpload);
    }
  }

  void info(String message, {String? tag}) => log(message, level: LogLevel.info, tag: tag);
  void warning(String message, {String? tag}) => log(message, level: LogLevel.warning, tag: tag);
  void error(String message, {String? tag}) => log(message, level: LogLevel.error, tag: tag);
  void debug(String message, {String? tag}) => log(message, level: LogLevel.debug, tag: tag);

  void clear() {
    _logs.clear();
    _controller.add(_logs);
  }

  String exportLogs() {
    final buffer = StringBuffer();
    buffer.writeln('=== ICD360S e.V Log Export ===');
    buffer.writeln('Exported: ${DateTime.now()}');
    buffer.writeln('Device ID: $_deviceId');
    buffer.writeln('Machine: $_machineName');
    buffer.writeln('Platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');
    buffer.writeln('Total entries: ${_logs.length}');
    buffer.writeln('');

    for (final entry in _logs) {
      buffer.writeln(entry.toString());
    }
    return buffer.toString();
  }

  /// Push logs to server after user login
  Future<bool> pushToServer(String mitgliedernummer) async {
    if (_logs.isEmpty) return true;

    try {
      final logsJson = _logs.map((e) => {
        'timestamp': e.timestamp.toIso8601String(),
        'level': e.level.name,
        'tag': e.tag,
        'message': e.message,
      }).toList();

      final result = await ApiService().pushLogs(
        mitgliedernummer: mitgliedernummer,
        deviceId: deviceId,
        machineName: machineName,
        platform: '${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
        logs: logsJson,
      );

      if (result['success'] == true) {
        info('Logs pushed to server (${_logs.length} entries)', tag: 'SYS');
        return true;
      } else {
        warning('Failed to push logs: ${result['message']}', tag: 'SYS');
        return false;
      }
    } catch (e) {
      error('Push logs error: $e', tag: 'SYS');
      return false;
    }
  }
}

enum LogLevel { debug, info, warning, error }

class LogEntry {
  final DateTime timestamp;
  final String message;
  final LogLevel level;
  final String? tag;

  LogEntry({
    required this.timestamp,
    required this.message,
    required this.level,
    this.tag,
  });

  String get levelIcon {
    switch (level) {
      case LogLevel.debug:
        return '[D]';
      case LogLevel.info:
        return '[I]';
      case LogLevel.warning:
        return '[W]';
      case LogLevel.error:
        return '[E]';
    }
  }

  @override
  String toString() {
    final time = '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
    final tagStr = tag != null ? '[$tag] ' : '';
    return '$time $levelIcon $tagStr$message';
  }
}
