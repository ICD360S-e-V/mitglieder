import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

/// Notification Service - Cross-platform notifications
/// All platforms: flutter_local_notifications
class NotificationService {
  static bool _isInitialized = false;

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Singleton
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Initialize the notification service
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _initFlutterNotifications();

    _isInitialized = true;
    debugPrint('[Notification] Service initialized for ${Platform.operatingSystem}');
  }

  Future<void> _initFlutterNotifications() async {
    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS/macOS initialization settings
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _notifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('[Notification] Tapped: ${response.payload}');
      },
    );

    // Request notification permissions
    await _requestPermissions();
  }

  /// Request notification permissions (Android 13+, iOS, macOS)
  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    } else if (Platform.isIOS || Platform.isMacOS) {
      // macOS uses the same Darwin implementation as iOS
      if (Platform.isIOS) {
        final IOSFlutterLocalNotificationsPlugin? iosImplementation =
            _notifications.resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>();
        await iosImplementation?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      } else {
        final MacOSFlutterLocalNotificationsPlugin? macImplementation =
            _notifications.resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin>();
        await macImplementation?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    }
  }

  /// Show a simple notification
  Future<void> show({
    required String title,
    required String body,
    String? payload,
    int id = 0,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    await _showFlutterNotification(title: title, body: body, payload: payload, id: id);
  }

  Future<void> _showFlutterNotification({
    required String title,
    required String body,
    String? payload,
    required int id,
    AndroidNotificationDetails? androidDetails,
    DarwinNotificationDetails? darwinDetails,
  }) async {
    final android = androidDetails ?? const AndroidNotificationDetails(
      'chat_messages',
      'Chat Nachrichten',
      channelDescription: 'Benachrichtigungen für neue Chat-Nachrichten',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    final darwin = darwinDetails ?? const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: android,
      iOS: darwin,
      macOS: darwin,
    );

    await _notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }

  // ==================== Translatable notification texts ====================
  // These can be overridden by callers who have access to BuildContext/l10n.
  // Defaults are in German (app's primary language).

  String notifNewMessageFrom = 'Neue Nachricht von';
  String notifUrgentPrefix = 'DRINGEND';
  String notifUrgentMessage = 'DRINGENDE NACHRICHT';
  String notifIncomingCall = 'Eingehender Anruf';
  String notifCallingYou = 'ruft an...';
  String notifUpdateAvailable = 'Update verfügbar';
  String notifVersionAvailable = 'ist jetzt verfügbar';
  String notifConnected = 'Verbunden';
  String notifDisconnected = 'Verbindung getrennt';
  String notifConnectedBody = 'Sie sind jetzt mit dem Server verbunden.';
  String notifDisconnectedBody = 'Die Verbindung zum Server wurde unterbrochen.';
  String notifError = 'Fehler';
  String notifNewLoginDetected = 'Neue Anmeldung erkannt';

  /// Update notification texts with translations (call from a widget with BuildContext)
  void updateTexts({
    String? newMessageFrom,
    String? urgentPrefix,
    String? urgentMessage,
    String? incomingCall,
    String? callingYou,
    String? updateAvailable,
    String? versionAvailable,
    String? connected,
    String? disconnected,
    String? connectedBody,
    String? disconnectedBody,
    String? error,
    String? newLoginDetected,
  }) {
    if (newMessageFrom != null) notifNewMessageFrom = newMessageFrom;
    if (urgentPrefix != null) notifUrgentPrefix = urgentPrefix;
    if (urgentMessage != null) notifUrgentMessage = urgentMessage;
    if (incomingCall != null) notifIncomingCall = incomingCall;
    if (callingYou != null) notifCallingYou = callingYou;
    if (updateAvailable != null) notifUpdateAvailable = updateAvailable;
    if (versionAvailable != null) notifVersionAvailable = versionAvailable;
    if (connected != null) notifConnected = connected;
    if (disconnected != null) notifDisconnected = disconnected;
    if (connectedBody != null) notifConnectedBody = connectedBody;
    if (disconnectedBody != null) notifDisconnectedBody = disconnectedBody;
    if (error != null) notifError = error;
    if (newLoginDetected != null) notifNewLoginDetected = newLoginDetected;
  }

  /// Show a chat message notification (normal)
  /// Uses conversationId as notification ID so each conversation gets its own notification
  Future<void> showChatMessage({
    required String senderName,
    required String message,
    int? conversationId,
  }) async {
    // Use conversationId-based ID (100-999 range) so different conversations don't overwrite each other
    final notifId = conversationId != null ? (100 + (conversationId % 900)) : 1;
    await show(
      title: '$notifNewMessageFrom $senderName',
      body: message,
      payload: conversationId != null ? 'chat_$conversationId' : null,
      id: notifId,
    );
  }

  /// Show URGENT full-screen message notification (like WarnWarn/NINA emergency alerts)
  Future<void> showUrgentMessage({
    required String title,
    required String message,
    String? senderName,
    int? conversationId,
    int id = 99,
  }) async {
    if (!_isInitialized) await initialize();

    const androidDetails = AndroidNotificationDetails(
      'urgent_chat_messages',
      'Dringende Nachrichten',
      channelDescription: 'Wichtige Nachrichten vom Vereinsvorstand (Full-Screen Alert)',
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.message,
      visibility: NotificationVisibility.public,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      sound: null, // Uses default system notification sound
      autoCancel: false,
      ongoing: false,
      ticker: 'Dringende Nachricht',
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
      sound: 'default',
    );

    final displayTitle = senderName != null
        ? '🚨 $notifUrgentPrefix: $senderName'
        : '🚨 $notifUrgentMessage';

    await _showFlutterNotification(
      title: displayTitle,
      body: message,
      payload: conversationId != null ? 'urgent_chat_$conversationId' : 'urgent_message',
      id: id,
      androidDetails: androidDetails,
      darwinDetails: darwinDetails,
    );

    debugPrint('[Notification] URGENT full-screen message shown: $title');
  }

  /// Show an incoming call notification
  Future<void> showIncomingCall({
    required String callerName,
    int? conversationId,
  }) async {
    if (!_isInitialized) await initialize();

    const androidDetails = AndroidNotificationDetails(
      'voice_calls',
      'Sprachanrufe',
      channelDescription: 'Benachrichtigungen für eingehende Anrufe',
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.call,
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    await _showFlutterNotification(
      title: notifIncomingCall,
      body: '$callerName $notifCallingYou',
      payload: conversationId != null ? 'call_$conversationId' : null,
      id: 2,
      androidDetails: androidDetails,
      darwinDetails: darwinDetails,
    );
  }

  /// Show update available notification
  Future<void> showUpdateAvailable({
    required String version,
  }) async {
    await show(
      title: notifUpdateAvailable,
      body: 'Version $version $notifVersionAvailable.',
      payload: 'update_$version',
      id: 3,
    );
  }

  /// Show connection status notification
  Future<void> showConnectionStatus({
    required bool connected,
  }) async {
    await show(
      title: connected ? notifConnected : notifDisconnected,
      body: connected ? notifConnectedBody : notifDisconnectedBody,
      id: 4,
    );
  }

  /// Show error notification
  Future<void> showError({
    required String message,
  }) async {
    await show(
      title: notifError,
      body: message,
      id: 5,
    );
  }

  /// Show success notification
  Future<void> showSuccess({
    required String title,
    required String message,
  }) async {
    await show(
      title: title,
      body: message,
      id: 6,
    );
  }

  /// Show ticket update notification
  Future<void> showTicketUpdate({
    required String title,
    required String message,
    int? ticketId,
  }) async {
    if (!_isInitialized) await initialize();

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

    // Use ticketId-based ID (1000-1999 range) so different tickets don't overwrite each other
    final notifId = ticketId != null ? (1000 + (ticketId % 1000)) : 7;
    await _showFlutterNotification(
      title: title,
      body: message,
      payload: ticketId != null ? 'ticket_$ticketId' : null,
      id: notifId,
      androidDetails: androidDetails,
      darwinDetails: darwinDetails,
    );
  }

  /// Cancel a specific notification
  Future<void> cancel(int id) async {
    await _notifications.cancel(id: id);
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
