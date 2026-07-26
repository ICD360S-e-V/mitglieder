import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'http_client_factory.dart';

/// Update Service - checks for app updates and handles download.
///
/// Update channel: GitHub Releases. Each release tag uploads four manifest
/// JSONs as release assets — version_mitglieder_{android,windows,macos,
/// linux}.json — and the binaries themselves. The `releases/latest/download/`
/// URL always redirects to the most recent tag, so the client never has to
/// be told which version to check against.
///
/// Supports: Android (APK), iOS (App Store), Windows (EXE), macOS (DMG),
/// Linux (AppImage).
class UpdateService {
  static const String _releaseAssetBase =
      'https://github.com/ICD360S-e-V/mitglieder/releases/latest/download/';

  /// Platform-specific manifest URL hosted on GitHub Releases.
  static String get versionUrl {
    if (Platform.isAndroid) return '${_releaseAssetBase}version_mitglieder_android.json';
    if (Platform.isWindows) return '${_releaseAssetBase}version_mitglieder_windows.json';
    if (Platform.isMacOS) return '${_releaseAssetBase}version_mitglieder_macos.json';
    if (Platform.isLinux) return '${_releaseAssetBase}version_mitglieder_linux.json';
    return '${_releaseAssetBase}version_mitglieder_android.json';
  }

  /// TODO(ios-release): replace with the real numeric App Store ID once the
  /// iOS build is published in App Store Connect (e.g. '6451234567').
  /// While left at the placeholder, [openAppStore] launches a non-resolving
  /// URL — acceptable only because the iOS flavor is not shipped yet.
  static const String _iosAppStoreId = '000000000';
  static String _currentVersion = 'unknown';

  /// Initialize version from pubspec.yaml via package_info_plus
  static Future<void> initVersion() async {
    final info = await PackageInfo.fromPlatform();
    _currentVersion = info.version;
  }

  static String get currentVersion => _currentVersion;

  /// Build number computed from the current version string using the same
  /// MAJOR*10000 + MINOR*100 + PATCH encoding the server uses in
  /// `/api/data/version_mitglieder_<platform>.json`. Returns 0 if the version
  /// string can't be parsed (e.g. `unknown` before [initVersion] runs).
  ///
  /// Used to be a hardcoded `const int = 122` which silently rotted across
  /// releases — every server response with a higher number was treated as
  /// "update available", causing the update prompt loop after install.
  static int get currentBuildNumber {
    final parts = _currentVersion.split('.');
    if (parts.length < 3) return 0;
    final major = int.tryParse(parts[0]);
    final minor = int.tryParse(parts[1]);
    final patch = int.tryParse(parts[2]);
    if (major == null || minor == null || patch == null) return 0;
    return major * 10000 + minor * 100 + patch;
  }

  late http.Client _client;
  late HttpClient _httpClient;

  // Singleton
  static final UpdateService _instance = UpdateService._internal();
  factory UpdateService() => _instance;
  UpdateService._internal() {
    // No certificate pinning here. The update channel is github.com /
    // objects.githubusercontent.com, both signed by DigiCert, so the
    // Let's-Encrypt-only pinning used for our own API would reject the
    // TLS handshake. System trust store is the correct policy for
    // third-party download infrastructure.
    _httpClient = HttpClientFactory.createDefaultHttpClient();
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

  // ---------------------------------------------------------------------------
  // Unattended updates
  // ---------------------------------------------------------------------------

  static const String _prefAutoUpdate = 'auto_update_enabled';

  /// Platforms where an update can be applied end-to-end with no clicks.
  ///
  /// Windows only, and only because the Inno Setup installer is a per-user
  /// install: `{autopf}` under `PrivilegesRequired=lowest` resolves to
  /// %LocalAppData%\Programs, so `/VERYSILENT` completes without a UAC prompt.
  /// macOS (DMG drag-install), Linux (AppImage) and Android (PackageInstaller)
  /// all require user interaction and stay on the prompt-every-time path.
  bool get supportsSilentUpdate => Platform.isWindows;

  /// Whether unattended updates are switched on. **Defaults to true**: staying
  /// current is the desired behaviour, so the update applies itself without
  /// ever asking.
  ///
  /// The stored value is still honoured when present, which is what keeps the
  /// profile-dialog switch meaningful and preserves the decision of anyone who
  /// explicitly turned this off under the earlier consent-prompt build.
  static Future<bool> isAutoUpdateEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefAutoUpdate) ?? true;
  }

  /// Persist the switch state from the profile dialog.
  static Future<void> setAutoUpdateEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefAutoUpdate, enabled);
  }

  /// Apply [updateInfo] with no user interaction: download, silent install,
  /// relaunch.
  ///
  /// Returns true when the installer was handed off, in which case this process
  /// is seconds away from being terminated by it — callers must not assume any
  /// code after this runs. Returns false on every failure so the caller can
  /// fall back to the interactive dialog.
  Future<bool> installUnattended(UpdateInfo updateInfo) async {
    if (!supportsSilentUpdate) return false;

    debugPrint('[Update] Unattended update to ${updateInfo.version} starting');
    final installerPath = await downloadUpdate(
      updateInfo.downloadUrl,
      (_) {},
      expectedSha256: updateInfo.sha256,
    );
    if (installerPath == null) {
      debugPrint('[Update] Unattended download failed or failed verification '
          '- staying on current version');
      return false;
    }
    return launchInstaller(installerPath, silent: true);
  }

  /// Check if an update is available
  Future<UpdateInfo?> checkForUpdate() async {
    try {
      // Device key is intentionally not forwarded — GitHub.com is third
      // party and has no use for it; sending it would leak the identifier
      // outside our trust boundary.
      final response = await _client.get(
        Uri.parse(versionUrl),
        headers: {
          'User-Agent': _userAgent,
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
        final sha256Hex = json['sha256'] as String?;

        // Compare versions
        if (_isNewerVersion(serverVersion, serverBuildNumber)) {
          return UpdateInfo(
            version: serverVersion,
            buildNumber: serverBuildNumber,
            downloadUrl: downloadUrl,
            changelog: changelog,
            minVersion: minVersion,
            forceUpdate: forceUpdate,
            sha256: sha256Hex,
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
  ///
  /// Returns the file path of the downloaded installer, or null if the download
  /// failed or did not match [expectedSha256] (the `sha256` field of the
  /// release manifest). A rejected file is deleted rather than left behind.
  Future<String?> downloadUpdate(
    String downloadUrl,
    Function(double) onProgress, {
    String? expectedSha256,
  }) async {
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

        // Integrity check before anything executes the file. This matters most
        // on the unattended path, where nobody is watching the installer run
        // and a truncated or substituted download would otherwise be launched
        // silently. Streamed off disk so a 40 MB installer is not held in RAM.
        if (expectedSha256 != null && expectedSha256.isNotEmpty) {
          final digest = await sha256.bind(file.openRead()).first;
          final actual = digest.toString().toLowerCase();
          if (actual != expectedSha256.toLowerCase()) {
            debugPrint('[Update] SHA-256 mismatch: expected $expectedSha256, got $actual');
            await file.delete();
            return null;
          }
          debugPrint('[Update] SHA-256 verified');
        }

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
  /// - Windows: Runs the Inno Setup EXE (silently when [silent])
  /// - macOS: Mounts DMG and opens it
  /// - Linux: Runs AppImage
  ///
  /// [silent] is honoured on Windows only; every other platform ignores it
  /// because their installers cannot run unattended.
  ///
  /// Returns false when the installer could not be started, so the caller can
  /// drop its progress indicator and surface an error instead of waiting for a
  /// restart that will never come.
  Future<bool> launchInstaller(String installerPath, {bool silent = false}) async {
    try {
      if (Platform.isAndroid) {
        // Android: Open APK with system installer
        final result = await OpenFilex.open(installerPath);
        if (result.type != ResultType.done) {
          debugPrint('[Update] Failed to open APK installer: ${result.message}');
          return false;
        }
        return true;
      } else if (Platform.isIOS) {
        // iOS: Open App Store page (self-update not supported)
        // This should ideally be called with the App Store URL instead
        debugPrint('[Update] iOS: Redirecting to App Store');
        final appStoreUrl = Uri.parse('https://apps.apple.com/app/icd360s-mitglieder/id$_iosAppStoreId');
        if (await canLaunchUrl(appStoreUrl)) {
          await launchUrl(appStoreUrl, mode: LaunchMode.externalApplication);
          return true;
        }
        return false;
      } else if (Platform.isWindows) {
        return await _launchWindowsInstaller(installerPath, silent: silent);
      } else if (Platform.isMacOS) {
        // macOS: Mount DMG and open it
        debugPrint('[Update] macOS: Mounting DMG');
        await Process.run('hdiutil', ['attach', installerPath]);
        // Try to open the mounted volume
        await Process.run('open', ['/Volumes/ICD360S Mitglieder']);
        return true;
      } else if (Platform.isLinux) {
        // Linux: Run AppImage directly
        debugPrint('[Update] Linux: Running AppImage');
        await Process.start(installerPath, [], runInShell: true);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[Update] Error launching installer: $e');
      return false;
    }
  }

  /// Hand the running app over to the Inno Setup installer and exit.
  ///
  /// The installer cannot replace `icd360sev_mitglied.exe` while we hold it
  /// open, so this function never returns on success: it spawns the installer
  /// and calls `exit(0)`. windows/installer.iss relaunches the app afterwards
  /// (the `skipifnotsilent` entry in its `[Run]` section) so a silent update
  /// looks like a quick self-restart to the user.
  Future<bool> _launchWindowsInstaller(String installerPath, {required bool silent}) async {
    final logPath = '${Directory.systemTemp.path}\\icd360sev_update.log';
    final args = <String>[
      if (silent) ...[
        // VERYSILENT suppresses the wizard AND the progress window;
        // CLOSEAPPLICATIONS lets Restart Manager shut down anything still
        // holding a file in the install directory; NOCANCEL stops a stray
        // keystroke from aborting a half-applied upgrade.
        '/VERYSILENT',
        '/SUPPRESSMSGBOXES',
        '/NORESTART',
        '/CLOSEAPPLICATIONS',
        '/NOCANCEL',
      ],
      '/LOG=$logPath',
    ];

    debugPrint('[Update] Windows: launching installer (silent=$silent) $args');

    // `cmd /c start` rather than a plain detached spawn: ProcessStartMode
    // .detached still leaves the child inside this process's Windows job
    // object, so the exit(0) below would kill the installer along with us
    // before it finished copying files. `start` creates the child with
    // CREATE_BREAKAWAY_FROM_JOB, which survives.
    // See https://github.com/dart-lang/sdk/issues/49234
    await Process.start(
      'cmd',
      ['/c', 'start', '/B', '"icd360sev-updater"', installerPath, ...args],
      mode: ProcessStartMode.detached,
    );

    // Let the cmd → start → setup.exe chain get far enough to break away.
    await Future.delayed(const Duration(milliseconds: 800));
    exit(0);
  }

  /// Open the App Store page for iOS updates
  /// Call this instead of downloadUpdate on iOS
  Future<void> openAppStore() async {
    try {
      final appStoreUrl = Uri.parse('https://apps.apple.com/app/icd360s-mitglieder/id$_iosAppStoreId');
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

  /// Expected SHA-256 of the installer, lower-case hex, from the release
  /// manifest. Null for manifests published before the field existed, in
  /// which case the download is accepted unverified.
  final String? sha256;

  UpdateInfo({
    required this.version,
    required this.buildNumber,
    required this.downloadUrl,
    required this.changelog,
    this.minVersion,
    this.forceUpdate = false,
    this.sha256,
  });
}
