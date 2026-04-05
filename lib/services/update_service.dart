import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'device_key_service.dart';
import 'http_client_factory.dart';

/// Update Service - checks for app updates and handles download
/// Supports: Android (APK), iOS (App Store), Windows (EXE), macOS (DMG), Linux (AppImage)
class UpdateService {
  static const String versionUrl = 'https://icd360sev.icd360s.de/api/version_mitglieder.php';
  static const String currentVersion = '1.1.15';
  static const int currentBuildNumber = 111;

  late http.Client _client;
  late HttpClient _httpClient;
  final DeviceKeyService _deviceKeyService = DeviceKeyService();

  // Singleton
  static final UpdateService _instance = UpdateService._internal();
  factory UpdateService() => _instance;
  UpdateService._internal() {
    // Certificate pinning: only trusts Let's Encrypt (ISRG Root X1)
    _httpClient = HttpClientFactory.createPinnedHttpClient();
    _client = IOClient(_httpClient);
  }

  /// Get platform-specific User-Agent string
  String get _userAgent {
    if (Platform.isAndroid) return 'ICD360S-Mitglieder/1.0 (Android)';
    if (Platform.isIOS) return 'ICD360S-Mitglieder/1.0 (iOS)';
    if (Platform.isWindows) return 'ICD360S-Mitglieder/1.0 (Windows)';
    if (Platform.isMacOS) return 'ICD360S-Mitglieder/1.0 (macOS)';
    if (Platform.isLinux) return 'ICD360S-Mitglieder/1.0 (Linux)';
    return 'ICD360S-Mitglieder/1.0';
  }

  /// Get platform-specific file extension for installer
  String get _installerExtension {
    if (Platform.isAndroid) return 'apk';
    if (Platform.isIOS) return ''; // iOS uses App Store
    if (Platform.isWindows) return 'exe';
    if (Platform.isMacOS) return 'dmg';
    if (Platform.isLinux) return 'AppImage';
    return '';
  }

  /// Check if platform supports self-update (iOS doesn't)
  bool get supportsSelfUpdate => !Platform.isIOS;

  /// Check if an update is available
  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final deviceKey = _deviceKeyService.deviceKey;

      final response = await _client.get(
        Uri.parse(versionUrl),
        headers: {
          'User-Agent': _userAgent,
          if (deviceKey != null) 'X-Device-Key': deviceKey,
        },
      ).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final serverVersion = json['version'] as String;
        final serverBuildNumber = json['build_number'] as int;
        final downloadUrl = json['download_url'] as String;
        final changelog = json['changelog'] as String? ?? '';
        final minVersion = json['min_version'] as String?;
        final forceUpdate = json['force_update'] as bool? ?? false;

        // Compare versions
        if (_isNewerVersion(serverVersion, serverBuildNumber)) {
          return UpdateInfo(
            version: serverVersion,
            buildNumber: serverBuildNumber,
            downloadUrl: downloadUrl,
            changelog: changelog,
            minVersion: minVersion,
            forceUpdate: forceUpdate,
          );
        }
      }
    } catch (e) {
      // Silently fail - don't interrupt user if update check fails
    }
    return null;
  }

  /// Compare versions to determine if server has newer version
  bool _isNewerVersion(String serverVersion, int serverBuildNumber) {
    // First compare build numbers (most reliable)
    if (serverBuildNumber > currentBuildNumber) {
      return true;
    }

    // Then compare version strings
    final serverParts = serverVersion.split('.').map(int.parse).toList();
    final currentParts = currentVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < serverParts.length && i < currentParts.length; i++) {
      if (serverParts[i] > currentParts[i]) {
        return true;
      } else if (serverParts[i] < currentParts[i]) {
        return false;
      }
    }

    return false;
  }

  /// Download the update installer for current platform
  /// Returns the file path of the downloaded installer
  Future<String?> downloadUpdate(String downloadUrl, Function(double) onProgress) async {
    // iOS doesn't support self-update - redirect to App Store
    if (Platform.isIOS) {
      debugPrint('[Update] iOS detected - self-update not supported');
      return null;
    }

    try {
      // Get platform-specific download directory
      final Directory downloadDir = await _getDownloadDirectory();
      final String fileName = 'icd360sev_mitglied_update.$_installerExtension';
      final filePath = '${downloadDir.path}${Platform.pathSeparator}$fileName';
      final file = File(filePath);

      // Delete old installer if exists
      if (await file.exists()) {
        await file.delete();
      }

      debugPrint('[Update] Downloading to: $filePath');

      final request = http.Request('GET', Uri.parse(downloadUrl));
      final response = await _client.send(request);

      if (response.statusCode == 200) {
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

        // Make AppImage executable on Linux
        if (Platform.isLinux) {
          await Process.run('chmod', ['+x', filePath]);
        }

        debugPrint('[Update] Download complete: $filePath');
        return filePath;
      }
    } catch (e) {
      debugPrint('[Update] Download failed: $e');
    }
    return null;
  }

  /// Get platform-specific download directory
  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      // Android: Use external storage directory
      final dir = await getExternalStorageDirectory();
      return dir ?? await getTemporaryDirectory();
    } else if (Platform.isIOS) {
      // iOS: Use temporary directory (won't be used, but needed for compilation)
      return await getTemporaryDirectory();
    } else {
      // Desktop: Use temporary directory
      return await getTemporaryDirectory();
    }
  }

  /// Launch the installer for current platform
  /// - Android: Opens APK with system installer
  /// - iOS: Opens App Store URL
  /// - Windows: Runs EXE installer
  /// - macOS: Mounts DMG and opens it
  /// - Linux: Runs AppImage
  Future<void> launchInstaller(String installerPath, {bool silent = true}) async {
    try {
      if (Platform.isAndroid) {
        // Android: Open APK with system installer
        final result = await OpenFilex.open(installerPath);
        if (result.type != ResultType.done) {
          debugPrint('[Update] Failed to open APK installer: ${result.message}');
        }
      } else if (Platform.isIOS) {
        // iOS: Open App Store page (self-update not supported)
        // This should ideally be called with the App Store URL instead
        debugPrint('[Update] iOS: Redirecting to App Store');
        final appStoreUrl = Uri.parse('https://apps.apple.com/app/icd360s-mitglieder/id000000000');
        if (await canLaunchUrl(appStoreUrl)) {
          await launchUrl(appStoreUrl, mode: LaunchMode.externalApplication);
        }
      } else if (Platform.isWindows) {
        // Windows: Run EXE installer
        debugPrint('[Update] Windows: Launching EXE installer');
        await Process.start(installerPath, [], runInShell: true);
      } else if (Platform.isMacOS) {
        // macOS: Mount DMG and open it
        debugPrint('[Update] macOS: Mounting DMG');
        await Process.run('hdiutil', ['attach', installerPath]);
        // Try to open the mounted volume
        await Process.run('open', ['/Volumes/ICD360S Mitglieder']);
      } else if (Platform.isLinux) {
        // Linux: Run AppImage directly
        debugPrint('[Update] Linux: Running AppImage');
        await Process.start(installerPath, [], runInShell: true);
      }
    } catch (e) {
      debugPrint('[Update] Error launching installer: $e');
    }
  }

  /// Open the App Store page for iOS updates
  /// Call this instead of downloadUpdate on iOS
  Future<void> openAppStore() async {
    try {
      final appStoreUrl = Uri.parse('https://apps.apple.com/app/icd360s-mitglieder/id000000000');
      if (await canLaunchUrl(appStoreUrl)) {
        await launchUrl(appStoreUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('[Update] Error opening App Store: $e');
    }
  }
}

/// Update information model
class UpdateInfo {
  final String version;
  final int buildNumber;
  final String downloadUrl;
  final String changelog;
  final String? minVersion;
  final bool forceUpdate;

  UpdateInfo({
    required this.version,
    required this.buildNumber,
    required this.downloadUrl,
    required this.changelog,
    this.minVersion,
    this.forceUpdate = false,
  });
}
