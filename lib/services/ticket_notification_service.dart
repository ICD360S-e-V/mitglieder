import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'device_key_service.dart';
import 'battery_usage_service.dart';

/// Ticket Notification Service - Android (NO Google FCM!)
/// Uses HTTP Polling + WorkManager for background
class TicketNotificationService {
  static final TicketNotificationService _instance =
      TicketNotificationService._internal();
  factory TicketNotificationService() => _instance;
  TicketNotificationService._internal();

  Timer? _pollTimer;
  bool _isPolling = false;
  String? _mitgliedernummer;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final _apiService = ApiService();
  final _deviceKeyService = DeviceKeyService();

  // Stream for notifying UI about new notifications
  final _notificationController = StreamController<int>.broadcast();
  Stream<int> get notificationStream => _notificationController.stream;

  /// Sicherheitsnetz, nicht der Zustellweg.
  ///
  /// Waren 60 s. Das war Verdopplung: der WebSocket liefert Ticket-Meldungen
  /// bereits als `ticket_notification` — ChatService zeigt daraufhin die
  /// Benachrichtigung an und meldet das Ereignis weiter, und im Hintergrund-
  /// Isolate tut BackgroundService dasselbe. Die Abfrage holte also
  /// sechzigmal pro Stunde ab, was in aller Regel schon da war, und weckte
  /// dafür jedes Mal das Funkmodem.
  ///
  /// Bleiben muss sie trotzdem: liegt der WebSocket beim Eintreffen einer
  /// Meldung gerade unten, wäre sie sonst verloren, bis das Mitglied die
  /// Ticketliste von Hand öffnet. Eine Viertelstunde deckt diesen Fall ab und
  /// entspricht dem Takt, den auch der WorkManager-Hintergrundlauf verwendet.
  static const Duration _pollInterval = Duration(minutes: 15);
  static const String _apiUrl =
      'https://icd360sev.icd360s.de/api/tickets/poll_notifications_member.php';
  static const String _backgroundTaskName = 'ticketNotificationPoll';

  /// Initialize notification service
  Future<void> initialize() async {
    // Setup local notifications (cross-platform)
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(settings: initializationSettings);

    // Register WorkManager background task (Android only)
    if (Platform.isAndroid) {
      await Workmanager().initialize(
        callbackDispatcher,
      );
    }

    debugPrint('[TICKET_NOTIF] Service initialized');
  }

  /// Start foreground polling (when app is open)
  Future<void> start(String mitgliedernummer) async {
    if (_isPolling) return;

    _mitgliedernummer = mitgliedernummer;
    _isPolling = true;

    // Save for background task
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_mitgliedernummer', mitgliedernummer);

    // Start foreground polling
    await _pollNotifications();
    _pollTimer = Timer.periodic(_pollInterval, (_) async {
      await _pollNotifications();
    });

    // Register background task (15 minute intervals) - Android only
    if (Platform.isAndroid) {
      await Workmanager().registerPeriodicTask(
        _backgroundTaskName,
        _backgroundTaskName,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
    }

    debugPrint(
        '[TICKET_NOTIF] Service started (foreground: 10s, background: 15min)');
  }

  /// Stop polling
  void stop() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _isPolling = false;
    _mitgliedernummer = null;

    // Keep background task running even when app closes
    // User can disable in Android settings if desired
    debugPrint('[TICKET_NOTIF] Foreground polling stopped');
  }

  /// Dispose resources
  void dispose() {
    _pollTimer?.cancel();
    _notificationController.close();
  }

  /// Poll for notifications (foreground)
  Future<void> _pollNotifications() async {
    debugPrint('[TICKET_NOTIF] Polling for notifications...');

    if (_mitgliedernummer == null) {
      debugPrint('[TICKET_NOTIF] No mitgliedernummer, skipping');
      return;
    }

    try {
      final token = _apiService.token;
      if (token == null) {
        debugPrint('[TICKET_NOTIF] No token, skipping poll');
        return;
      }

      final deviceKey = _deviceKeyService.deviceKey ?? '';

      BatteryUsageService.instance.noteNetworkRequest(NetworkSource.ticketPoll);
      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'ICD360S-Mitglieder-Android/1.0',
              'Authorization': 'Bearer $token',
              'X-Device-Key': deviceKey,
            },
            body: jsonEncode({
              'mitgliedernummer': _mitgliedernummer,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final notifications = data['notifications'] as List<dynamic>? ?? [];
          final count = data['count'] as int? ?? 0;

          if (count > 0) {
            debugPrint('[TICKET_NOTIF] Found $count new notifications');
            // Notify UI listeners about new notifications
            _notificationController.add(count);
            for (var notification in notifications) {
              await _showLocalNotification(notification);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('[TICKET_NOTIF] Poll error: $e');
    }
  }

  /// Show local Android notification
  Future<void> _showLocalNotification(Map<String, dynamic> notification) async {
    final title = notification['title'] as String? ?? 'Neue Benachrichtigung';
    final message = notification['message'] as String? ?? '';
    final ticketId = int.tryParse(notification['ticket_id']?.toString() ?? '') ?? 0;
    // Use ticketId-based ID (1000-1999 range) to avoid collisions with other notification types
    final notifId = ticketId > 0 ? (1000 + (ticketId % 1000)) : 1000;

    const androidDetails = AndroidNotificationDetails(
      'ticket_notifications',
      'Ticket Benachrichtigungen',
      channelDescription: 'Benachrichtigungen für Ticket-Updates',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );

    await _localNotifications.show(
      id: notifId,
      title: title,
      body: message,
      notificationDetails: notificationDetails,
    );

    debugPrint('[TICKET_NOTIF] Notification shown: $title');
  }
}

/// Background task callback (runs even when app is closed!)
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'ticketNotificationPoll') {
      await _pollInBackground();
    }
    return Future.value(true);
  });
}

/// Background polling (called by WorkManager)
Future<void> _pollInBackground() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final mitgliedernummer = prefs.getString('current_mitgliedernummer');

    if (mitgliedernummer == null) {
      debugPrint('[BACKGROUND] No mitgliedernummer, skipping');
      return;
    }

    final token = prefs.getString('auth_token') ?? '';
    final deviceKey = prefs.getString('device_key') ?? '';
    final response = await http
        .post(
          Uri.parse(
              'https://icd360sev.icd360s.de/api/tickets/poll_notifications_member.php'),
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'ICD360S-Mitglieder-Android/1.0',
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
            if (deviceKey.isNotEmpty) 'X-Device-Key': deviceKey,
          },
          body: jsonEncode({'mitgliedernummer': mitgliedernummer}),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == true && data['count'] > 0) {
        final notifications = data['notifications'] as List<dynamic>;

        debugPrint('[BACKGROUND] Found ${data['count']} notifications');

        // Initialize notifications plugin in background isolate
        final localNotifications = FlutterLocalNotificationsPlugin();
        const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
        const initSettings = InitializationSettings(android: initSettingsAndroid);
        await localNotifications.initialize(settings: initSettings);

        for (var notification in notifications) {
          final title = notification['title'] ?? 'Neue Benachrichtigung';
          final message = notification['message'] ?? '';
          final ticketId = int.tryParse(notification['ticket_id']?.toString() ?? '') ?? 0;
          final bgNotifId = ticketId > 0 ? (1000 + (ticketId % 1000)) : 1000;

          await localNotifications.show(
            id: bgNotifId,
            title: title,
            body: message,
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                'ticket_notifications',
                'Ticket Benachrichtigungen',
                importance: Importance.high,
                priority: Priority.high,
              ),
            ),
          );

          debugPrint('[BACKGROUND] Notification shown: $title');
        }
      }
    }
  } catch (e) {
    debugPrint('[BACKGROUND] Poll error: $e');
  }
}
