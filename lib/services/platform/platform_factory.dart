import 'dart:io';

import 'platform_service.dart';
import 'mobile_platform_service.dart';
import 'desktop_platform_service.dart';

/// Factory for creating platform-specific service instances
class PlatformFactory {
  static PlatformService? _instance;

  /// Get the singleton platform service instance
  static PlatformService get instance {
    _instance ??= _createPlatformService();
    return _instance!;
  }

  /// Create the appropriate platform service based on current platform
  static PlatformService _createPlatformService() {
    if (Platform.isAndroid || Platform.isIOS) {
      return MobilePlatformService();
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return DesktopPlatformService();
    }

    throw UnsupportedError(
      'Platform ${Platform.operatingSystem} is not supported',
    );
  }

  /// Reset the singleton (useful for testing)
  static void reset() {
    _instance?.dispose();
    _instance = null;
  }

  /// Check if running on mobile platform
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;

  /// Check if running on desktop platform
  static bool get isDesktop =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  /// Get platform name for display
  static String get platformName {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return Platform.operatingSystem;
  }

  /// Get platform prefix for device ID
  static String get platformPrefix {
    if (Platform.isAndroid) return 'AND';
    if (Platform.isIOS) return 'IOS';
    if (Platform.isWindows) return 'WIN';
    if (Platform.isMacOS) return 'MAC';
    if (Platform.isLinux) return 'LIN';
    return 'UNK';
  }
}
