import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'logger_service.dart';
import 'notification_service.dart';

final _log = LoggerService();

/// Ntfy Push Notification Service for Mitglieder app.
/// Subscribes to ntfy topic via NDJSON stream (HTTP GET long-polling).
/// Server-side: NtfyService.php sends notifications with prefix 'icd360s_'.
/// Authentication: token fetched from /api/auth/ntfy_token.php (JWT protected).
class NtfyService {
  static final NtfyService _instance = NtfyService._internal();
  factory NtfyService() => _instance;
  NtfyService._internal();

  static const String _ntfyBaseUrl = 'https://icd360sev.icd360s.de/ntfy';
  static const String _topicPrefix = 'icd360s_';

  String? _mitgliedernummer;
  String? _ntfyToken;
  bool _isListening = false;
  http.Client? _client;
  StreamSubscription? _subscription;

  /// Start listening for push notifications on this user's topic.
  void start(String mitgliedernummer) {
    if (_isListening && _mitgliedernummer == mitgliedernummer) return;
    stop();
    _mitgliedernummer = mitgliedernummer;
    _isListening = true;
    _log.info('NtfyService: Starting for $mitgliedernummer', tag: 'NTFY');
    _fetchTokenAndConnect();
  }

  /// Stop listening.
  void stop() {
    _isListening = false;
    _subscription?.cancel();
    _subscription = null;
    _client?.close();
    _client = null;
    if (_mitgliedernummer != null) {
      _log.info('NtfyService: Stopped', tag: 'NTFY');
    }
  }

  /// Fetch ntfy auth token from server, then connect.
  void _fetchTokenAndConnect() async {
    if (!_isListening) return;

    try {
      final apiService = ApiService();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/auth/ntfy_token.php'),
        headers: {'Authorization': 'Bearer ${apiService.token}'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['ntfy_token'] != null) {
          _ntfyToken = data['ntfy_token'] as String;
          debugPrint('[NTFY] Token received');
        }
      }
    } catch (e) {
      debugPrint('[NTFY] Token fetch error: $e');
    }
    _connect();
  }

  /// Connect to ntfy NDJSON stream.
  void _connect() async {
    if (!_isListening || _mitgliedernummer == null) return;

    final topic = '$_topicPrefix${_mitgliedernummer!.toLowerCase()}';
    final url = '$_ntfyBaseUrl/$topic/json';

    debugPrint('[NTFY] Connecting to $topic...');

    try {
      _client = http.Client();
      final request = http.Request('GET', Uri.parse(url));
      request.headers['Accept'] = 'application/x-ndjson';

      // Add auth token if available
      if (_ntfyToken != null) {
        request.headers['Authorization'] = 'Bearer $_ntfyToken';
      }

      final response = await _client!.send(request);

      if (response.statusCode == 403 || response.statusCode == 401) {
        debugPrint('[NTFY] Auth failed (${response.statusCode}), refetching token...');
        _ntfyToken = null;
        _scheduleReconnect();
        return;
      }

      if (response.statusCode != 200) {
        debugPrint('[NTFY] HTTP ${response.statusCode}, reconnecting...');
        _scheduleReconnect();
        return;
      }

      debugPrint('[NTFY] Connected to $topic');

      _subscription = response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
        (line) {
          if (line.trim().isNotEmpty) _handleMessage(line);
        },
        onError: (e) {
          debugPrint('[NTFY] Stream error: $e');
          _scheduleReconnect();
        },
        onDone: () {
          debugPrint('[NTFY] Stream closed');
          _scheduleReconnect();
        },
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('[NTFY] Connection error: $e');
      _scheduleReconnect();
    }
  }

  /// Handle incoming ntfy message.
  void _handleMessage(String line) {
    try {
      final data = jsonDecode(line);

      // Skip non-message events (open, keepalive, etc.)
      if (data['event'] != 'message') return;

      final title = data['title'] as String? ?? 'Benachrichtigung';
      final body = data['message'] as String? ?? '';

      debugPrint('[NTFY] Notification: $title - $body');
      _log.info('NtfyService: Received: $title', tag: 'NTFY');

      NotificationService().show(
        title: title,
        body: body,
      );
    } catch (e) {
      debugPrint('[NTFY] Parse error: $e');
    }
  }

  /// Schedule reconnection after 5 seconds.
  void _scheduleReconnect() {
    _subscription?.cancel();
    _client?.close();
    _subscription = null;
    _client = null;

    if (!_isListening) return;

    debugPrint('[NTFY] Reconnecting in 5s...');
    Future.delayed(const Duration(seconds: 5), () {
      if (_isListening) {
        if (_ntfyToken == null) {
          _fetchTokenAndConnect();
        } else {
          _connect();
        }
      }
    });
  }
}
