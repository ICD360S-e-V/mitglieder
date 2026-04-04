import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

import 'platform_service.dart';
import 'platform_factory.dart';
import '../background_service.dart';
import '../notification_service.dart';

/// Mobile platform service implementation (Android & iOS)
/// Uses existing background_service.dart and notification_service.dart
class MobilePlatformService implements PlatformService {
  final NotificationService _notificationService = NotificationService();
  bool _initialized = false;
  String? _deviceId;
  bool _backgroundActive = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    await initializeNotifications();
    _initialized = true;
    debugPrint('[MobilePlatformService] Initialized');
  }

  @override
  Future<void> dispose() async {
    await clearCredentials();
    _initialized = false;
  }

  // ============================================
  // BACKGROUND CONNECTION MANAGEMENT
  // ============================================

  @override
  Future<void> initializeBackgroundConnection() async {
    // Use existing BackgroundService for Android/iOS
    await BackgroundService.initializeService();
    _backgroundActive = true;
    debugPrint('[MobilePlatformService] Background service initialized');
  }

  @override
  Future<void> setCredentials(String token, String mitgliedernummer) async {
    await BackgroundService.setCredentials(token, mitgliedernummer);
  }

  @override
  Future<void> clearCredentials() async {
    await BackgroundService.clearCredentials();
    _backgroundActive = false;
  }

  @override
  bool get isBackgroundConnectionActive => _backgroundActive;

  // ============================================
  // NOTIFICATIONS
  // ============================================

  @override
  Future<void> initializeNotifications() async {
    await _notificationService.initialize();
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notificationService.show(
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
    await _notificationService.showChatMessage(
      senderName: senderName,
      message: message,
      conversationId: conversationId != null ? int.tryParse(conversationId) : null,
    );
  }

  @override
  Future<void> showCallNotification({
    required String callerName,
    String? callId,
  }) async {
    await _notificationService.showIncomingCall(
      callerName: callerName,
      conversationId: callId != null ? int.tryParse(callId) : null,
    );
  }

  @override
  Future<void> showTicketNotification({
    required String title,
    required String message,
    String? ticketId,
  }) async {
    await _notificationService.showTicketUpdate(
      title: title,
      message: message,
      ticketId: ticketId != null ? int.tryParse(ticketId) : null,
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

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      combined =
          '${androidInfo.model}|${androidInfo.id}|${androidInfo.brand}|${androidInfo.device}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      combined =
          '${iosInfo.name}|${iosInfo.identifierForVendor}|${iosInfo.model}';
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

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return {
        'device_name': '${info.brand} ${info.model}',
        'platform':
            'Android ${info.version.release} (SDK ${info.version.sdkInt})',
        'device_id': await getDeviceId(),
      };
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return {
        'device_name': info.name,
        'platform': '${info.systemName} ${info.systemVersion}',
        'device_id': await getDeviceId(),
      };
    }

    return {
      'device_name': 'Unknown Mobile',
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
    // Delegate to existing UpdateService
    // Will be implemented when we modify update_service.dart
    return null;
  }

  @override
  Future<bool> downloadAndInstallUpdate({
    required String downloadUrl,
    required Function(double progress) onProgress,
  }) async {
    // Delegate to existing UpdateService
    // Will be implemented when we modify update_service.dart
    return false;
  }

  // ============================================
  // WINDOW MANAGEMENT (No-op on mobile)
  // ============================================

  @override
  Future<void> minimizeToTray() async {
    // No-op on mobile
  }

  @override
  Future<void> restoreFromTray() async {
    // No-op on mobile
  }

  @override
  Future<void> setAlwaysOnTop(bool value) async {
    // No-op on mobile
  }

  @override
  bool get isDesktop => false;

  @override
  bool get isMobile => true;
}
