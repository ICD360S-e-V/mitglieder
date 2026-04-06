import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:shared_preferences/shared_preferences.dart';
import 'http_client_factory.dart';

/// Background Service für persistent WebSocket connection
/// Läuft als Foreground Service mit Notification auf Android
/// Auf Desktop wird WebSocket in DesktopPlatformService gehandhabt
@pragma('vm:entry-point')
class BackgroundService {

  /// Check if background service is supported on current platform
  static bool get isSupported => Platform.isAndroid || Platform.isIOS;

  /// Initialize and start background service
  /// Only runs on Android and iOS - desktop uses DesktopPlatformService
  @pragma('vm:entry-point')
  static Future<void> initializeService() async {
    // Skip on desktop - handled by DesktopPlatformService
    if (!isSupported) {
      debugPrint('[BackgroundService] Skipping on ${Platform.operatingSystem} - not supported');
      return;
    }

    final service = FlutterBackgroundService();

    // Create notification channels
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Background service channel (silent)
    const AndroidNotificationChannel serviceChannel = AndroidNotificationChannel(
      'background_service_channel',
      'Background Service',
      description: 'Hält die Verbindung für Chat und Anrufe aktiv',
      importance: Importance.low,
      showBadge: false,
    );

    // Chat messages channel (high priority)
    const AndroidNotificationChannel chatChannel = AndroidNotificationChannel(
      'chat_messages',
      'Chat Nachrichten',
      description: 'Benachrichtigungen für neue Chat-Nachrichten',
      importance: Importance.high,
      playSound: true,
      showBadge: true,
    );

    // Voice calls channel (max priority)
    const AndroidNotificationChannel callChannel = AndroidNotificationChannel(
      'voice_calls',
      'Sprachanrufe',
      description: 'Benachrichtigungen für eingehende Anrufe',
      importance: Importance.max,
      playSound: true,
      showBadge: true,
    );

    // 🆕 Urgent chat messages channel (max priority + full-screen)
    const AndroidNotificationChannel urgentChatChannel = AndroidNotificationChannel(
      'urgent_chat_messages',
      'Dringende Nachrichten',
      description: 'Wichtige Nachrichten vom Vereinsvorstand (Full-Screen Alert)',
      importance: Importance.max,
      playSound: true,
      showBadge: true,
      enableLights: true,
      enableVibration: true,
    );

    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(serviceChannel);
    await androidPlugin?.createNotificationChannel(chatChannel);
    await androidPlugin?.createNotificationChannel(callChannel);
    await androidPlugin?.createNotificationChannel(urgentChatChannel);  // 🆕 CREATE URGENT CHANNEL!

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        autoStartOnBoot: true,
        isForegroundMode: true,
        notificationChannelId: 'background_service_channel',
        initialNotificationTitle: 'ICD360S Mitglieder',
        initialNotificationContent: '...',
        foregroundServiceNotificationId: 888,
        foregroundServiceTypes: [
          AndroidForegroundType.remoteMessaging,
        ],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );

    await service.startService();
    debugPrint('[BackgroundService] Service initialized and started');
  }

  /// Send credentials to background service (call this after login)
  @pragma('vm:entry-point')
  static Future<void> setCredentials(String token, String mitgliedernummer) async {
    if (!isSupported) return;
    final service = FlutterBackgroundService();
    service.invoke('setCredentials', {
      'token': token,
      'mitgliedernummer': mitgliedernummer,
    });
    debugPrint('[BackgroundService] Credentials sent to background service');
  }

  /// Clear credentials (call this on logout)
  @pragma('vm:entry-point')
  static Future<void> clearCredentials() async {
    if (!isSupported) return;
    final service = FlutterBackgroundService();
    service.invoke('clearCredentials');
    debugPrint('[BackgroundService] Credentials cleared');
  }

  /// iOS background handler
  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  /// Main service entry point - MUST be top-level or static
  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    debugPrint('[BackgroundService] onStart called');

    // Variables for WebSocket connection
    String? token;
    String? mitgliedernummer;
    WebSocketChannel? channel;
    Timer? reconnectTimer;
    Timer? pingTimer;
    bool isConnected = false;
    bool isConnecting = false;  // Prevent duplicate connection attempts
    int reconnectAttempts = 0;

    // Initialize notifications (cross-platform: Android + iOS)
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(settings: initializationSettings);
    debugPrint('[BackgroundService] Notifications initialized');

    // Load translated notification texts from SharedPreferences
    final l10nPrefs = await SharedPreferences.getInstance();
    final l10nConnected = l10nPrefs.getString('l10n_notifConnected') ?? 'Verbunden';
    final l10nReconnecting = l10nPrefs.getString('l10n_notifReconnecting') ?? 'Verbindung wird wiederhergestellt...';
    final l10nWaitingLogin = l10nPrefs.getString('l10n_notifWaitingLogin') ?? 'Warte auf Anmeldung...';

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    // Forward declarations for mutual recursion
    late void Function() connect;
    late void Function() scheduleReconnect;
    late void Function() disconnect;

    // Disconnect from WebSocket
    disconnect = () {
      debugPrint('[BackgroundService] Disconnecting...');
      isConnected = false;
      isConnecting = false;
      pingTimer?.cancel();
      reconnectTimer?.cancel();
      try {
        channel?.sink.close(status.goingAway);
      } catch (_) {}
      channel = null;

      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: 'ICD360S Mitglieder',
          content: l10nWaitingLogin,
        );
      }
    };

    // Schedule reconnect with exponential backoff
    scheduleReconnect = () {
      if (token == null || mitgliedernummer == null) {
        debugPrint('[BackgroundService] No credentials - not reconnecting');
        return;
      }

      reconnectTimer?.cancel();
      // Exponential backoff: 2s, 4s, 8s, 16s, max 30s
      final delay = (2 * (1 << (reconnectAttempts.clamp(0, 4)))).clamp(2, 30);
      debugPrint('[BackgroundService] Reconnecting in ${delay}s...');

      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: 'ICD360S Mitglieder',
          content: l10nReconnecting,
        );
      }

      reconnectTimer = Timer(Duration(seconds: delay), connect);
    };

    // Connect to WebSocket
    connect = () async {
      if (token == null || mitgliedernummer == null) {
        debugPrint('[BackgroundService] No credentials - cannot connect');
        return;
      }

      if (isConnecting) {
        debugPrint('[BackgroundService] Already connecting - skipping');
        return;
      }

      try {
        isConnecting = true;
        reconnectAttempts++;
        debugPrint('[BackgroundService] Connecting to WebSocket (attempt $reconnectAttempts)...');

        // Security: Token NOT in URL (would appear in server logs)
        // Token is sent in auth message instead
        final uri = Uri(
          scheme: 'wss',
          host: 'icd360sev.icd360s.de',
          port: 443,
          path: '/wss/',
        );
        debugPrint('[BackgroundService] Connecting to WebSocket...');
        channel = IOWebSocketChannel.connect(
          uri,
          customClient: HttpClientFactory.createPinnedHttpClient(),
        );

        await channel!.ready.timeout(const Duration(seconds: 15));
        isConnected = true;
        isConnecting = false;
        reconnectAttempts = 0;
        debugPrint('[BackgroundService] WebSocket connected!');

        // Send auth message with token (secure: not visible in URL/logs)
        channel?.sink.add(jsonEncode({
          'type': 'auth',
          'mitgliedernummer': mitgliedernummer,
          'token': token,
        }));
        debugPrint('[BackgroundService] Auth message sent for user $mitgliedernummer');

        // Update notification
        if (service is AndroidServiceInstance) {
          service.setForegroundNotificationInfo(
            title: 'ICD360S Mitglieder',
            content: l10nConnected,
          );
        }

        // Start ping timer (every 30 seconds)
        pingTimer?.cancel();
        pingTimer = Timer.periodic(const Duration(seconds: 45), (timer) {
          if (isConnected && channel != null) {
            try {
              channel?.sink.add(jsonEncode({'type': 'ping'}));
              debugPrint('[BackgroundService] Ping sent');
            } catch (e) {
              debugPrint('[BackgroundService] Ping failed: $e');
              isConnected = false;
              timer.cancel();
              try {
                channel?.sink.close(status.goingAway);
              } catch (_) {}
              scheduleReconnect();
            }
          }
        });

        // Listen to messages
        channel!.stream.listen(
          (data) {
            try {
              debugPrint('[BackgroundService] Message received: $data');
              final message = jsonDecode(data);
              _handleWebSocketMessage(message, flutterLocalNotificationsPlugin);
            } catch (e) {
              debugPrint('[BackgroundService] Error parsing message: $e');
            }
          },
          onError: (error) {
            debugPrint('[BackgroundService] WebSocket error: $error');
            isConnected = false;
            scheduleReconnect();
          },
          onDone: () {
            debugPrint('[BackgroundService] WebSocket closed');
            isConnected = false;
            pingTimer?.cancel();
            scheduleReconnect();
          },
        );
      } catch (e) {
        debugPrint('[BackgroundService] Connection failed: $e');
        isConnected = false;
        isConnecting = false;
        scheduleReconnect();
      }
    };

    // Listen for credentials from main app
    service.on('setCredentials').listen((event) {
      if (event != null) {
        final newToken = event['token'] as String?;
        final newMitgliedernummer = event['mitgliedernummer'] as String?;

        debugPrint('[BackgroundService] Credentials received: user=$newMitgliedernummer, connected=$isConnected, connecting=$isConnecting');

        // Only connect if we have credentials
        if (newToken != null && newMitgliedernummer != null) {
          // Check if credentials actually changed
          final tokenChanged = token != newToken;
          final userChanged = mitgliedernummer != newMitgliedernummer;
          final credentialsChanged = tokenChanged || userChanged;
          debugPrint('[BackgroundService] Token changed: $tokenChanged, User changed: $userChanged');

          // Skip if already connected or connecting with same credentials
          if ((isConnected || isConnecting) && !credentialsChanged) {
            debugPrint('[BackgroundService] Already ${isConnected ? "connected" : "connecting"} with same credentials - skipping');
            return;
          }

          // Update credentials
          token = newToken;
          mitgliedernummer = newMitgliedernummer;

          // Only disconnect and reconnect if credentials changed AND we're connected
          if (credentialsChanged && isConnected) {
            debugPrint('[BackgroundService] Credentials changed - reconnecting...');
            disconnect();
            reconnectAttempts = 0;
          }

          // Connect if not already connected or connecting
          if (!isConnected && !isConnecting) {
            debugPrint('[BackgroundService] Starting connection...');
            connect();
          }
        }
      }
    });

    // Listen for credential clear (logout)
    service.on('clearCredentials').listen((event) {
      debugPrint('[BackgroundService] Clearing credentials...');
      token = null;
      mitgliedernummer = null;
      disconnect();
    });

    // Listen for service stop
    service.on('stopService').listen((event) {
      debugPrint('[BackgroundService] Stopping service...');
      disconnect();
      service.stopSelf();
    });

    // Health check removed - notification is already updated reactively in
    // connect(), disconnect(), scheduleReconnect() (saves battery: -1 timer)

    debugPrint('[BackgroundService] Service ready - waiting for credentials');
  }

  /// Handle incoming WebSocket messages
  @pragma('vm:entry-point')
  static void _handleWebSocketMessage(
    Map<String, dynamic> message,
    FlutterLocalNotificationsPlugin notificationsPlugin,
  ) async {
    final type = message['type'];
    debugPrint('[BackgroundService] Handling message type: $type');

    switch (type) {
      case 'new_message':
        // Skip own messages - check sender against stored mitgliedernummer
        final senderMitgliedernummer = message['sender_mitgliedernummer']?.toString() ?? '';
        final senderId = message['sender_id']?.toString() ?? '';
        final prefs = await SharedPreferences.getInstance();
        final currentUser = prefs.getString('mitgliedernummer') ?? '';
        if (currentUser.isNotEmpty &&
            (senderMitgliedernummer == currentUser || senderId == currentUser)) {
          debugPrint('[BackgroundService] Skipping notification for own message');
          break;
        }
        await _showChatNotification(message, notificationsPlugin);
        break;
      case 'call_offer':
        await _showCallNotification(message, notificationsPlugin);
        break;
      case 'pong':
        debugPrint('[BackgroundService] Pong received - connection alive');
        break;
      case 'system_notification':  // WebSocket server sends this type
      case 'ticket_notification':  // Keep for compatibility
        debugPrint('[BackgroundService] Ticket notification received');
        final rawTicketId = int.tryParse(message['ticket_id']?.toString() ?? '') ?? 0;
        final ticketNotifId = rawTicketId > 0 ? (1000 + (rawTicketId % 1000)) : 1000;
        await notificationsPlugin.show(
          id: ticketNotifId,
          title: message['title'] ?? 'Ticket Update',
          body: message['message'] ?? 'New ticket notification',
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              'icd360sev_tickets',
              'ICD360S Tickets',
              channelDescription: 'Ticket-Updates und Benachrichtigungen',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
        break;
      default:
        debugPrint('[BackgroundService] Unknown message type: $type');
    }
  }

  /// Show notification for new chat message
  @pragma('vm:entry-point')
  static Future<void> _showChatNotification(
    Map<String, dynamic> message,
    FlutterLocalNotificationsPlugin notificationsPlugin,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final senderName = message['sender_name'] ?? 'Support';
    final messageText = message['message'] ?? (prefs.getString('l10n_notifNewMessageFrom') ?? 'Neue Nachricht');
    final conversationId = message['conversation_id'];
    final isUrgent = message['urgent'] == true || message['urgent'] == 1;
    final senderRole = message['sender_role']?.toString().toLowerCase() ?? '';

    // Auto-detect urgent: Admin messages (vorsitzer, schatzmeister, etc.)
    final isFromAdmin = senderRole.contains('vorsitzer') ||
                        senderRole.contains('schatzmeister') ||
                        senderRole.contains('kassierer') ||
                        senderRole.contains('mitgliedergrunder');

    final shouldUseFullScreen = isUrgent || isFromAdmin;

    debugPrint('[BackgroundService] Chat notification from $senderName (urgent: $shouldUseFullScreen)');

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      shouldUseFullScreen ? 'urgent_chat_messages' : 'chat_messages',
      shouldUseFullScreen ? 'Dringende Nachrichten' : 'Chat Nachrichten',
      channelDescription: shouldUseFullScreen
          ? 'Wichtige Nachrichten vom Vereinsvorstand'
          : 'Benachrichtigungen für neue Chat-Nachrichten',
      importance: shouldUseFullScreen ? Importance.max : Importance.high,  // Max doar pentru urgent!
      priority: shouldUseFullScreen ? Priority.max : Priority.high,  // Max doar pentru urgent!
      fullScreenIntent: shouldUseFullScreen,  // 🚨 FULL-SCREEN doar pentru admin messages!
      category: AndroidNotificationCategory.message,
      visibility: NotificationVisibility.private,
      showWhen: true,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      autoCancel: !shouldUseFullScreen,  // Urgent must be dismissed manually, normal auto-cancel
      ongoing: false,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      styleInformation: BigTextStyleInformation(messageText),
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final urgentPrefix = prefs.getString('l10n_notifUrgentPrefix') ?? 'DRINGEND';
    final notificationTitle = shouldUseFullScreen
        ? '🚨 $urgentPrefix: $senderName'
        : senderName;

    // Use conversationId-based ID (100-999 range) to avoid overwriting and int32 overflow
    final notifId = conversationId != null ? (100 + (conversationId.hashCode.abs() % 900)) : (100 + (DateTime.now().second % 900));
    await notificationsPlugin.show(
      id: notifId,
      title: notificationTitle,
      body: messageText,
      notificationDetails: notificationDetails,
      payload: 'chat:$conversationId',
    );
    debugPrint('[BackgroundService] Chat notification shown (fullScreen: $shouldUseFullScreen)');
  }

  /// Show notification for incoming call
  @pragma('vm:entry-point')
  static Future<void> _showCallNotification(
    Map<String, dynamic> message,
    FlutterLocalNotificationsPlugin notificationsPlugin,
  ) async {
    final callPrefs = await SharedPreferences.getInstance();
    final callerName = message['from_name'] ?? (callPrefs.getString('l10n_unknown') ?? 'Unknown');

    debugPrint('[BackgroundService] Showing call notification from $callerName');

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'voice_calls',
      'Sprachanrufe',
      channelDescription: 'Benachrichtigungen für eingehende Anrufe',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: true,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.call,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      ongoing: true,
      autoCancel: false,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final incomingCallText = callPrefs.getString('l10n_notifIncomingCall') ?? 'Incoming call';
    final callingYouText = callPrefs.getString('l10n_notifCallingYou') ?? 'is calling...';
    await notificationsPlugin.show(
      id: 999,
      title: incomingCallText,
      body: '$callerName $callingYouText',
      notificationDetails: notificationDetails,
      payload: 'call:${message['from']}',
    );
    debugPrint('[BackgroundService] Call notification shown');
  }

  /// Stop background service
  @pragma('vm:entry-point')
  static Future<void> stopService() async {
    if (!isSupported) return;
    final service = FlutterBackgroundService();
    service.invoke('stopService');
  }

  /// Check if service is running
  @pragma('vm:entry-point')
  static Future<bool> isServiceRunning() async {
    if (!isSupported) return false;
    final service = FlutterBackgroundService();
    return await service.isRunning();
  }
}
