import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'logger_service.dart';
import 'battery_usage_service.dart';
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

  /// Zahl der Verbindungsversuche seit dem letzten Erfolg. Steuert die
  /// Wartezeit in [_scheduleReconnect].
  int _reconnectAttempts = 0;

  /// Der anstehende Wiederverbindungsversuch.
  ///
  /// Bewusst ein [Timer] und kein `Future.delayed`: der lässt sich abbrechen.
  /// Vorher wurde die Wartezeit als `Future.delayed` geplant und in [stop]
  /// lediglich `_isListening` auf false gesetzt — der Callback lief also ins
  /// Leere, der Timer selbst aber blieb bestehen und überlebte damit jede
  /// Abmeldung. Zusätzlich verhindert das Festhalten des Handles, dass sich
  /// zwei Ketten überlagern: `onError` und `onDone` desselben Streams können
  /// beide feuern, und ohne diese Prüfung liefen danach zwei
  /// Wiederverbindungsketten parallel, die sich bei jedem weiteren Fehler
  /// erneut verdoppeln.
  Timer? _reconnectTimer;

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
    // Muss abgebrochen werden, nicht nur entwertet: sonst überlebt der
    // anstehende Wiederverbindungsversuch die Abmeldung.
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    // Die nächste Sitzung fängt wieder bei fünf Sekunden an. Sonst erbte ein
    // frischer Start die Wartezeit einer alten, gescheiterten Verbindung.
    _reconnectAttempts = 0;
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

      BatteryUsageService.instance.noteNetworkRequest(NetworkSource.ntfy);
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

      // Erst hier zurücksetzen, nicht schon beim Absetzen der Anfrage: sonst
      // würde eine Verbindung, die sofort wieder abbricht, den Backoff bei
      // jedem Versuch neu auf 5 s stellen — also genau das Verhalten
      // wiederherstellen, das abgeschafft werden sollte.
      _reconnectAttempts = 0;

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

      // Getrennt von noteNetworkRequest gezählt: hier hat der Server das Gerät
      // geweckt, nicht wir. Beides kostet Funkzeit, aber nur das eine lässt
      // sich durch Optimierung im Client verringern.
      BatteryUsageService.instance.notePushWakeup();

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

  /// Plant einen neuen Verbindungsversuch mit exponentiell wachsender
  /// Wartezeit: 5 s, 10 s, 20 s, 40 s, 80 s, 160 s, dann konstant 300 s.
  ///
  /// Vorher waren es unverändert 5 s. Auf einer gesunden Verbindung fällt das
  /// nicht auf, weil es kaum vorkommt — aber genau dann, wenn es darauf
  /// ankommt, war es ruinös: bei nicht erreichbarem Server oder schwachem
  /// Empfang sind das 720 vollständige TLS-Handshakes pro Stunde, jeder ein
  /// Funkaufwachvorgang. Das ist der teuerste Zustand, in den die App geraten
  /// konnte, und er trat ausgerechnet dort ein, wo der Akku ohnehin schon
  /// unter schlechtem Empfang leidet.
  ///
  /// Die Obergrenze von fünf Minuten ist der Kompromiss: lange genug, damit
  /// das Modem zwischendurch wirklich schläft, kurz genug, dass eine
  /// zurückgekehrte Verbindung nicht minutenlang ungenutzt bleibt.
  void _scheduleReconnect() {
    _subscription?.cancel();
    _client?.close();
    _subscription = null;
    _client = null;

    if (!_isListening) return;

    // onError und onDone können beide für denselben Stream feuern. Ohne diese
    // Prüfung entstünde daraus je eine eigene Wiederverbindungskette.
    if (_reconnectTimer?.isActive ?? false) {
      debugPrint('[NTFY] Reconnect already scheduled - skipping');
      return;
    }

    final delay = _reconnectDelay();
    _reconnectAttempts++;
    debugPrint('[NTFY] Reconnecting in ${delay.inSeconds}s '
        '(attempt $_reconnectAttempts)...');

    _reconnectTimer = Timer(delay, () {
      _reconnectTimer = null;
      if (!_isListening) return;
      if (_ntfyToken == null) {
        _fetchTokenAndConnect();
      } else {
        _connect();
      }
    });
  }

  /// 5 s verdoppelt pro Fehlversuch, gedeckelt bei 5 Minuten.
  ///
  /// Der Shift ist auf 6 begrenzt, damit `1 << n` nicht irgendwann überläuft,
  /// wenn ein Gerät tagelang ohne Verbindung läuft.
  Duration _reconnectDelay() {
    const base = 5;
    const maxSeconds = 300;
    final seconds = base * (1 << _reconnectAttempts.clamp(0, 6));
    return Duration(seconds: seconds > maxSeconds ? maxSeconds : seconds);
  }
}
