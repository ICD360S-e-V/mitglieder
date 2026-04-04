/// Abstract interface for platform-specific services
/// Provides a unified API for Android, iOS, Windows, macOS, and Linux
abstract class PlatformService {
  /// Initialize the platform service
  Future<void> initialize();

  /// Dispose resources
  Future<void> dispose();

  // ============================================
  // BACKGROUND CONNECTION MANAGEMENT
  // ============================================

  /// Initialize persistent WebSocket connection
  /// - Android: Foreground service
  /// - iOS: Background fetch + VoIP
  /// - Desktop: Main isolate (app stays running)
  Future<void> initializeBackgroundConnection();

  /// Set user credentials for WebSocket authentication
  Future<void> setCredentials(String token, String mitgliedernummer);

  /// Clear credentials (logout)
  Future<void> clearCredentials();

  /// Check if background connection is active
  bool get isBackgroundConnectionActive;

  // ============================================
  // NOTIFICATIONS
  // ============================================

  /// Initialize notification system
  Future<void> initializeNotifications();

  /// Show a general notification
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  });

  /// Show a chat message notification
  Future<void> showChatNotification({
    required String senderName,
    required String message,
    String? conversationId,
  });

  /// Show an incoming call notification
  Future<void> showCallNotification({
    required String callerName,
    String? callId,
  });

  /// Show a ticket update notification
  Future<void> showTicketNotification({
    required String title,
    required String message,
    String? ticketId,
  });

  // ============================================
  // DEVICE IDENTIFICATION
  // ============================================

  /// Get unique device ID
  /// Format: [PLATFORM_PREFIX]_[HASH]
  /// - Android: AND_xxx
  /// - iOS: IOS_xxx
  /// - Windows: WIN_xxx
  /// - macOS: MAC_xxx
  /// - Linux: LIN_xxx
  Future<String> getDeviceId();

  /// Get device info for display
  Future<Map<String, String>> getDeviceInfo();

  /// Get platform name
  String get platformName;

  // ============================================
  // AUTO-UPDATE
  // ============================================

  /// Check for updates
  Future<Map<String, dynamic>?> checkForUpdate();

  /// Download and install update
  /// Returns true if download started successfully
  Future<bool> downloadAndInstallUpdate({
    required String downloadUrl,
    required Function(double progress) onProgress,
  });

  // ============================================
  // WINDOW MANAGEMENT (Desktop Only)
  // ============================================

  /// Minimize to system tray (desktop only, no-op on mobile)
  Future<void> minimizeToTray();

  /// Restore from system tray (desktop only, no-op on mobile)
  Future<void> restoreFromTray();

  /// Set window always on top (desktop only)
  Future<void> setAlwaysOnTop(bool value);

  /// Check if running on desktop
  bool get isDesktop;

  /// Check if running on mobile
  bool get isMobile;
}
