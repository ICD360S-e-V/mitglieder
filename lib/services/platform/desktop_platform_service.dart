import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import '../notification_service.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../http_client_factory.dart';

import 'platform_service.dart';
import 'platform_factory.dart';
import '../chat_service.dart';

/// Desktop platform service implementation (Windows, macOS, Linux)
/// Uses main isolate WebSocket instead of background service
class DesktopPlatformService implements PlatformService {
  // WebSocket connection
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  bool _isConnected = false;
  int _reconnectAttempts = 0;
  String? _token;
  String? _mitgliedernummer;

  // System tray
  bool _trayInitialized = false;

  // State
  bool _initialized = false;
  String? _deviceId;

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    await initializeNotifications();
    await _initializeWindowManager();
    await _initializeTray();

    _initialized = true;
    debugPrint('[DesktopPlatformService] Initialized');
  }

  @override
  Future<void> dispose() async {
    await clearCredentials();
    _initialized = false;
  }

  Future<void> _initializeWindowManager() async {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(1280, 800),
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: Color(0x00000000),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'ICD360S e.V - Mitgliederportal',
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    // Prevent close - minimize to tray instead
    windowManager.setPreventClose(true);
  }

  Future<void> _initializeTray() async {
    if (_trayInitialized) return;

    String iconPath;
    if (Platform.isWindows) {
      iconPath = 'assets/app_icon.ico';
    } else {
      iconPath = 'assets/app_icon.png';
    }

    // Check if icon exists, use default if not
    final iconFile = File(iconPath);
    if (!await iconFile.exists()) {
      debugPrint('[DesktopPlatformService] Tray icon not found at $iconPath');
      // Skip tray initialization if no icon
      return;
    }

    await trayManager.setIcon(iconPath);
    if (!Platform.isLinux) {
      await trayManager.setToolTip('ICD360S e.V - Mitgliederportal');
    }

    final menu = Menu(
      items: [
        MenuItem(
          key: 'open',
          label: 'Öffnen',
        ),
        MenuItem.separator(),
        MenuItem(
          key: 'exit',
          label: 'Beenden',
        ),
      ],
    );

    await trayManager.setContextMenu(menu);

    trayManager.addListener(_TrayClickListener(this));

    _trayInitialized = true;
    debugPrint('[DesktopPlatformService] System tray initialized');
  }

  // ============================================
  // BACKGROUND CONNECTION MANAGEMENT
  // ============================================

  @override
  Future<void> initializeBackgroundConnection() async {
    // On desktop, WebSocket runs in main isolate
    // No separate background service needed
    if (_token != null && _mitgliedernummer != null) {
      await _connect();
    }
    debugPrint('[DesktopPlatformService] Background connection ready');
  }

  @override
  Future<void> setCredentials(String token, String mitgliedernummer) async {
    _token = token;
    _mitgliedernummer = mitgliedernummer;
    await _connect();
  }

  @override
  Future<void> clearCredentials() async {
    _token = null;
    _mitgliedernummer = null;
    _disconnect();
  }

  @override
  bool get isBackgroundConnectionActive => _isConnected;

  Future<void> _connect() async {
    if (_token == null || _mitgliedernummer == null) return;
    if (_isConnected) return;

    try {
      // Security: Token NOT in URL (would appear in server logs)
      final uri = Uri(
        scheme: 'wss',
        host: 'icd360sev.icd360s.de',
        port: 443,
        path: '/wss/',
      );

      _channel = IOWebSocketChannel.connect(
        uri,
        customClient: HttpClientFactory.createPinnedHttpClient(),
      );
      await _channel!.ready;
      _isConnected = true;
      _reconnectAttempts = 0;

      // Send auth message with token (secure: not visible in URL/logs)
      _channel?.sink.add(jsonEncode({
        'type': 'auth',
        'mitgliedernummer': _mitgliedernummer,
        'token': _token,
      }));

      // Start ping timer (45 seconds - battery optimized, Nginx timeout is 60s)
      _pingTimer?.cancel();
      _pingTimer = Timer.periodic(const Duration(seconds: 45), (_) {
        if (_isConnected) {
          _channel?.sink.add(jsonEncode({'type': 'ping'}));
        }
      });

      // Listen for messages
      _channel!.stream.listen(
        _handleMessage,
        onError: (_) => _scheduleReconnect(),
        onDone: () => _scheduleReconnect(),
      );

      debugPrint('[DesktopPlatformService] WebSocket connected');
    } catch (e) {
      debugPrint('[DesktopPlatformService] Connection failed: $e');
      _scheduleReconnect();
    }
  }

  void _handleMessage(dynamic data) {
    try {
      final message = jsonDecode(data);
      final type = message['type'];

      switch (type) {
        case 'new_message':
          // Skip if ChatService is already connected (it handles its own notifications)
          if (ChatService().isConnected) {
            debugPrint('[DesktopPlatformService] Skipping notification - ChatService active');
            break;
          }
          // Skip own messages
          final senderMitgliedernummer = message['sender_mitgliedernummer']?.toString() ?? '';
          final senderId = message['sender_id']?.toString() ?? '';
          if (_mitgliedernummer != null &&
              (senderMitgliedernummer == _mitgliedernummer ||
               senderId == _mitgliedernummer)) {
            debugPrint('[DesktopPlatformService] Skipping notification for own message');
            break;
          }
          showChatNotification(
            senderName: message['sender_name'] ?? 'Support',
            message: message['message'] ?? '',
            conversationId: message['conversation_id']?.toString(),
          );
          break;
        case 'call_offer':
          showCallNotification(
            callerName: message['from_name'] ?? 'Unbekannt',
            callId: message['call_id']?.toString(),
          );
          break;
        case 'pong':
          debugPrint('[DesktopPlatformService] Pong received');
          break;
        case 'ticket_update':
          showTicketNotification(
            title: message['title'] ?? 'Ticket Update',
            message: message['message'] ?? '',
            ticketId: message['ticket_id']?.toString(),
          );
          break;
      }
    } catch (e) {
      debugPrint('[DesktopPlatformService] Error parsing message: $e');
    }
  }

  void _scheduleReconnect() {
    if (_token == null) return;

    _isConnected = false;
    _pingTimer?.cancel();

    final delay = (2 * (1 << _reconnectAttempts.clamp(0, 4))).clamp(2, 30);
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: delay), () {
      _reconnectAttempts++;
      _connect();
    });

    debugPrint(
        '[DesktopPlatformService] Reconnecting in $delay seconds (attempt ${_reconnectAttempts + 1})');
  }

  void _disconnect() {
    _isConnected = false;
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
    debugPrint('[DesktopPlatformService] Disconnected');
  }

  // ============================================
  // NOTIFICATIONS
  // ============================================

  @override
  Future<void> initializeNotifications() async {
    await NotificationService().initialize();
    debugPrint('[DesktopPlatformService] Notifications initialized');
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await NotificationService().show(
      title: title,
      body: body,
      payload: payload,
    );
  }

  @override
  Future<void> showChatNotification({
    required String senderName,
    required String message,
    String? conversationId,
  }) async {
    await showNotification(
      title: 'Neue Nachricht von $senderName',
      body: message,
      payload: conversationId,
    );
  }

  @override
  Future<void> showCallNotification({
    required String callerName,
    String? callId,
  }) async {
    await showNotification(
      title: 'Eingehender Anruf',
      body: '$callerName ruft an...',
      payload: callId,
    );

    // Also restore window on incoming call
    await restoreFromTray();
  }

  @override
  Future<void> showTicketNotification({
    required String title,
    required String message,
    String? ticketId,
  }) async {
    await showNotification(
      title: title,
      body: message,
      payload: ticketId,
    );
  }

  // ============================================
  // DEVICE IDENTIFICATION
  // ============================================

  @override
  Future<String> getDeviceId() async {
    if (_deviceId != null) return _deviceId!;

    final deviceInfo = DeviceInfoPlugin();
    String combined;

    if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      combined = '${windowsInfo.computerName}|${windowsInfo.deviceId}';
    } else if (Platform.isMacOS) {
      final macInfo = await deviceInfo.macOsInfo;
      combined = '${macInfo.computerName}|${macInfo.systemGUID ?? macInfo.hostName}';
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      combined = '${linuxInfo.name}|${linuxInfo.machineId ?? linuxInfo.id}';
    } else {
      combined = const Uuid().v4();
    }

    // Create hash from combined string
    final hash = combined.hashCode.toRadixString(16).padLeft(8, '0');
    _deviceId = '${PlatformFactory.platformPrefix}_$hash';

    return _deviceId!;
  }

  @override
  Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isWindows) {
      final info = await deviceInfo.windowsInfo;
      return {
        'device_name': info.computerName,
        'platform':
            'Windows ${info.majorVersion}.${info.minorVersion} Build ${info.buildNumber}',
        'device_id': await getDeviceId(),
      };
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return {
        'device_name': info.computerName,
        'platform': 'macOS ${info.osRelease}',
        'device_id': await getDeviceId(),
      };
    } else if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return {
        'device_name': info.name,
        'platform': 'Linux ${info.prettyName}',
        'device_id': await getDeviceId(),
      };
    }

    return {
      'device_name': 'Unknown Desktop',
      'platform': Platform.operatingSystem,
      'device_id': await getDeviceId(),
    };
  }

  @override
  String get platformName => PlatformFactory.platformName;

  // ============================================
  // AUTO-UPDATE
  // ============================================

  @override
  Future<Map<String, dynamic>?> checkForUpdate() async {
    // Will be implemented in update_service.dart modifications
    return null;
  }

  @override
  Future<bool> downloadAndInstallUpdate({
    required String downloadUrl,
    required Function(double progress) onProgress,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      String fileName;

      if (Platform.isWindows) {
        fileName = 'ICD360S_Mitglieder_Setup.exe';
      } else if (Platform.isMacOS) {
        fileName = 'ICD360S_Mitglieder.dmg';
      } else {
        fileName = 'ICD360S_Mitglieder.AppImage';
      }

      final filePath = '${tempDir.path}${Platform.pathSeparator}$fileName';
      final file = File(filePath);

      if (await file.exists()) await file.delete();

      final client = http.Client();
      final request = http.Request('GET', Uri.parse(downloadUrl));
      final response = await client.send(request);

      final totalBytes = response.contentLength ?? 0;
      int receivedBytes = 0;

      final sink = file.openWrite();
      await for (final chunk in response.stream) {
        sink.add(chunk);
        receivedBytes += chunk.length;
        if (totalBytes > 0) {
          onProgress(receivedBytes / totalBytes);
        }
      }
      await sink.close();

      // Launch installer
      await _launchInstaller(filePath);
      return true;
    } catch (e) {
      debugPrint('[DesktopPlatformService] Update download failed: $e');
      return false;
    }
  }

  Future<void> _launchInstaller(String filePath) async {
    if (Platform.isWindows) {
      await Process.start(filePath, [], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('hdiutil', ['attach', filePath]);
      await Process.run('open', ['/Volumes/ICD360S Mitglieder']);
    } else if (Platform.isLinux) {
      await Process.run('chmod', ['+x', filePath]);
      await Process.start(filePath, [], runInShell: true);
    }
  }

  // ============================================
  // WINDOW MANAGEMENT
  // ============================================

  @override
  Future<void> minimizeToTray() async {
    await windowManager.hide();
    debugPrint('[DesktopPlatformService] Minimized to tray');
  }

  @override
  Future<void> restoreFromTray() async {
    await windowManager.show();
    await windowManager.focus();
    debugPrint('[DesktopPlatformService] Restored from tray');
  }

  @override
  Future<void> setAlwaysOnTop(bool value) async {
    await windowManager.setAlwaysOnTop(value);
  }

  @override
  bool get isDesktop => true;

  @override
  bool get isMobile => false;
}

/// Tray click listener for handling tray icon and menu events
class _TrayClickListener extends TrayListener {
  final DesktopPlatformService _service;
  _TrayClickListener(this._service);

  @override
  void onTrayIconMouseDown() {
    _service.restoreFromTray();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case 'open':
        _service.restoreFromTray();
        break;
      case 'exit':
        windowManager.setPreventClose(false);
        windowManager.destroy();
        break;
    }
  }
}
