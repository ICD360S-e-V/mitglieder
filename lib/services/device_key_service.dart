import 'dart:convert';
import 'dart:io';
import 'dart:ui' show PlatformDispatcher;
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:safe_device/safe_device.dart';
import 'secure_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:uuid/uuid.dart';
import 'http_client_factory.dart';
import 'logger_service.dart';

/// Service pentru gestionarea Device Key unic per instalare
/// Înlocuiește API Key-ul hardcodat cu un key dinamic stocat securizat
class DeviceKeyService {
  static const String _baseUrl = 'https://icd360sev.icd360s.de/api';
  static const String _deviceKeyStorageKey = 'device_key';
  static const String _deviceIdStorageKey = 'device_id';

  final _secureStorage = createSecureStorage();
  final LoggerService _logger = LoggerService();

  late http.Client _client;
  String? _deviceKey;
  String? _deviceId;

  // Singleton pattern
  static final DeviceKeyService _instance = DeviceKeyService._internal();
  factory DeviceKeyService() => _instance;
  DeviceKeyService._internal() {
    // Create HttpClient with proper certificate validation
    // Security: SSL/TLS certificates are now properly validated
    _client = IOClient(HttpClientFactory.createPinnedHttpClient());
  }

  /// Returnează device key-ul (sau null dacă nu e înregistrat)
  String? get deviceKey => _deviceKey;

  /// Returnează device ID-ul
  String? get deviceId => _deviceId;

  /// Verifică dacă device-ul este înregistrat
  bool get isRegistered => _deviceKey != null;

  /// Inițializează service-ul - încarcă sau generează device key
  Future<bool> initialize() async {
    try {
      // Încercă să încarce device key existent
      _deviceKey = await _secureStorage.read(key: _deviceKeyStorageKey);
      _deviceId = await _secureStorage.read(key: _deviceIdStorageKey);

      if (_deviceKey != null && _deviceId != null) {
        // Device key există, verifică dacă e valid
        return await _validateDeviceKey();
      }

      // Nu există device key, înregistrează device-ul
      return await _registerDevice();
    } catch (e) {
      _logger.error('DeviceKeyService.initialize error: $e', tag: 'DEVICE');
      return false;
    }
  }

  /// Returnează prefixul platformei curente
  String get _platformPrefix {
    if (Platform.isAndroid) return 'AND';
    if (Platform.isIOS) return 'IOS';
    if (Platform.isWindows) return 'WIN';
    if (Platform.isMacOS) return 'MAC';
    if (Platform.isLinux) return 'LIN';
    return 'UNK';
  }

  /// Generează un device ID unic bazat pe informații hardware
  Future<String> _generateDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      List<String> components;

      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        components = [
          info.model,
          info.id,
          info.brand,
          info.device,
          info.hardware,
        ];
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        components = [
          info.name,
          info.identifierForVendor ?? '',
          info.model,
          info.systemName,
        ];
      } else if (Platform.isWindows) {
        final info = await deviceInfo.windowsInfo;
        components = [
          info.computerName,
          info.deviceId,
          info.userName,
        ];
      } else if (Platform.isMacOS) {
        final info = await deviceInfo.macOsInfo;
        components = [
          info.computerName,
          info.systemGUID ?? info.hostName,
          info.model,
        ];
      } else if (Platform.isLinux) {
        final info = await deviceInfo.linuxInfo;
        components = [
          info.name,
          info.machineId ?? info.id,
          info.prettyName,
        ];
      } else {
        components = [const Uuid().v4()];
      }

      // Hash-uiește componentele pentru un ID consistent
      final combined = components.join('|');
      final bytes = utf8.encode(combined);
      final hash = base64Encode(bytes);

      return '${_platformPrefix}_${hash.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').substring(0, 32)}';
    } catch (e) {
      // Fallback: generează UUID
      return '${_platformPrefix}_${const Uuid().v4().replaceAll('-', '')}';
    }
  }

  /// Obține informații despre device pentru înregistrare
  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    // Screen-based tablet detection (Material Design: shortestSide >= 600dp)
    final screenSize = PlatformDispatcher.instance.views.first.physicalSize /
        PlatformDispatcher.instance.views.first.devicePixelRatio;
    final shortestSide = screenSize.shortestSide;

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      final isTablet = shortestSide >= 600;
      return {
        'device_name': '${info.brand} ${info.model}',
        'platform': 'Android ${info.version.release} (SDK ${info.version.sdkInt})',
        'device_type': isTablet ? 'tablet' : 'phone',
        'os_version': 'Android ${info.version.release} (SDK ${info.version.sdkInt}, Patch ${info.version.securityPatch ?? "unknown"})',
      };
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      final isTablet = shortestSide >= 600 || info.model.toLowerCase().contains('ipad');
      return {
        'device_name': info.name,
        'platform': '${info.systemName} ${info.systemVersion}',
        'device_type': isTablet ? 'tablet' : 'phone',
        'os_version': '${info.systemName} ${info.systemVersion} (${info.utsname.machine})',
      };
    } else if (Platform.isWindows) {
      final info = await deviceInfo.windowsInfo;
      return {
        'device_name': info.computerName,
        'platform': 'Windows ${info.majorVersion}.${info.minorVersion} Build ${info.buildNumber}',
        'device_type': 'desktop',
        'os_version': '${info.productName} (Build ${info.buildNumber})',
      };
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return {
        'device_name': info.computerName,
        'platform': 'macOS ${info.osRelease}',
        'device_type': 'desktop',
        'os_version': 'macOS ${info.majorVersion}.${info.minorVersion}.${info.patchVersion} (${info.model})',
      };
    } else if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return {
        'device_name': info.name,
        'platform': 'Linux ${info.prettyName}',
        'device_type': 'desktop',
        'os_version': info.prettyName,
      };
    }

    return {
      'device_name': 'Unknown Device',
      'platform': Platform.operatingSystem,
      'device_type': 'unknown',
      'os_version': Platform.operatingSystemVersion,
    };
  }

  /// Colectează date extinse despre device (battery, connection, VPN)
  Future<Map<String, dynamic>> _collectExtendedDeviceData() async {
    final data = <String, dynamic>{};

    try {
      // Battery (may return -1 on desktops without battery)
      final battery = Battery();
      final level = await battery.batteryLevel;
      if (level >= 0) {
        data['battery_level'] = level;
        final state = await battery.batteryState;
        data['battery_state'] = state.toString().split('.').last;
      }
    } catch (_) {}

    try {
      // Connection type
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity.isNotEmpty) {
        final type = connectivity.first.toString().split('.').last;
        data['connection_type'] = type;
      }
    } catch (_) {}

    try {
      // VPN detection
      if (Platform.isAndroid || Platform.isIOS) {
        // Mobile: connectivity_plus can detect VPN
        final connectivity = await Connectivity().checkConnectivity();
        final hasVpn = connectivity.any((c) => c == ConnectivityResult.vpn);
        data['is_vpn'] = hasVpn ? 1 : 0;
      } else {
        // Desktop: check network interfaces for VPN adapters
        final interfaces = await NetworkInterface.list();
        final vpnPrefixes = ['utun', 'tun', 'tap', 'ppp', 'wg', 'ipsec', 'vpn'];
        final hasVpn = interfaces.any((i) =>
            vpnPrefixes.any((p) => i.name.toLowerCase().startsWith(p)));
        data['is_vpn'] = hasVpn ? 1 : 0;
      }
    } catch (_) {}

    // Root/Jailbreak detection (mobile only)
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        final isRooted = await SafeDevice.isJailBroken;
        data['is_rooted'] = isRooted ? 1 : 0;
      } catch (_) {}
    }

    return data;
  }

  /// Înregistrează device-ul pe server și obține device key
  Future<bool> _registerDevice() async {
    try {
      // Generează device ID
      _deviceId = await _generateDeviceId();

      // Obține informații despre device
      final info = await _getDeviceInfo();

      final extendedData = await _collectExtendedDeviceData();

      final response = await _client.post(
        Uri.parse('$_baseUrl/device/register.php'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'ICD360S-Mitglied/1.0',
        },
        body: jsonEncode({
          'device_id': _deviceId,
          'device_name': info['device_name'],
          'platform': info['platform'],
          'app_version': '1.1.20',
          'device_type': info['device_type'],
          'os_version': info['os_version'],
          ...extendedData,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _deviceKey = data['device_key'];

        // Salvează în secure storage
        await _secureStorage.write(key: _deviceKeyStorageKey, value: _deviceKey);
        await _secureStorage.write(key: _deviceIdStorageKey, value: _deviceId);

        _logger.info('Device registered successfully', tag: 'DEVICE');
        return true;
      } else {
        _logger.warning('Device registration failed: ${data['message'] ?? 'Unknown error'}', tag: 'DEVICE');
        return false;
      }
    } catch (e) {
      _logger.error('Device registration error: $e', tag: 'DEVICE');
      return false;
    }
  }

  /// Validează device key-ul existent cu serverul
  Future<bool> _validateDeviceKey() async {
    try {
      final info = await _getDeviceInfo();
      final extendedData = await _collectExtendedDeviceData();

      final response = await _client.post(
        Uri.parse('$_baseUrl/device/validate.php'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'ICD360S-Mitglied/1.0',
        },
        body: jsonEncode({
          'device_key': _deviceKey,
          'app_version': '1.1.20',
          'device_type': info['device_type'],
          'os_version': info['os_version'],
          ...extendedData,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      } else if (response.statusCode == 403) {
        // Device revocat - șterge key-ul și re-înregistrează
        _logger.warning('Device key revoked, re-registering...', tag: 'DEVICE');
        await _clearDeviceKey();
        return await _registerDevice();
      } else {
        _logger.warning('Device key validation failed: ${data['message'] ?? 'Unknown error'}', tag: 'DEVICE');
        return false;
      }
    } catch (e) {
      // Eroare de rețea - presupunem că key-ul e valid (offline mode)
      _logger.info('Device key validation error (assuming valid): $e', tag: 'DEVICE');
      return true;
    }
  }

  /// Șterge device key-ul (pentru re-înregistrare)
  Future<void> _clearDeviceKey() async {
    try {
      await _secureStorage.delete(key: _deviceKeyStorageKey);
      await _secureStorage.delete(key: _deviceIdStorageKey);
    } catch (e) {
      _logger.warning('SecureStorage delete failed: $e', tag: 'DEVICE');
    }
    _deviceKey = null;
    _deviceId = null;
  }

  /// Forțează re-înregistrarea device-ului
  Future<bool> reregister() async {
    await _clearDeviceKey();
    return await _registerDevice();
  }
}
