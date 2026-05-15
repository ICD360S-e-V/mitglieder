import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'logger_service.dart';

/// Collects SSID/BSSID from the currently connected WiFi, used to enrich
/// security event reports so an admin can see exactly which network the
/// interception happened on.
///
/// Permission policy: we never ask at launch. The permission flow runs ONLY
/// on demand (after a TLS interception is detected) via [requestSsidAccess].
/// Routine queries via [collectIfGranted] return null when permission is not
/// already granted — the user is never silently nagged.
class NetworkDetailsService {
  NetworkDetailsService._();
  static final NetworkDetailsService instance = NetworkDetailsService._();

  final NetworkInfo _networkInfo = NetworkInfo();
  final LoggerService _log = LoggerService();

  /// Returns true on platforms where reading SSID requires no permission
  /// (desktop) or where the permission API isn't relevant.
  bool get _ssidNeedsPermission =>
      Platform.isAndroid || Platform.isIOS;

  /// True if the OS would currently let us read SSID. On non-mobile, always
  /// true. On mobile, true iff location permission is already granted.
  Future<bool> hasSsidAccess() async {
    if (!_ssidNeedsPermission) return true;
    final status = await Permission.locationWhenInUse.status;
    return status.isGranted;
  }

  /// Best-effort collection. Returns:
  ///   - ssid/bssid populated when access is granted and we got a value
  ///   - ssid/bssid null and `denied: true` when permission is missing
  ///   - ssid/bssid null and `denied: false` when permission was granted but
  ///     the OS still refused (rare; airplane mode, etc.)
  Future<NetworkDetails> collectIfGranted() async {
    if (!await hasSsidAccess()) {
      return const NetworkDetails(denied: true);
    }
    return _read(deniedOnMissing: false);
  }

  /// Active permission request. Call this from a dialog after the user has
  /// seen the explanation and tapped "Allow". Returns the resulting details
  /// (which may still have null ssid if the user denied).
  Future<NetworkDetails> requestSsidAccess() async {
    if (!_ssidNeedsPermission) return _read(deniedOnMissing: false);

    final status = await Permission.locationWhenInUse.request();
    if (!status.isGranted) {
      _log.info(
        'Location permission denied; SSID collection disabled',
        tag: 'SECURITY',
      );
      return const NetworkDetails(denied: true);
    }
    return _read(deniedOnMissing: false);
  }

  Future<NetworkDetails> _read({required bool deniedOnMissing}) async {
    String? ssid;
    String? bssid;
    try {
      ssid = await _networkInfo.getWifiName();
      // network_info_plus returns SSID surrounded by quotes on some platforms.
      if (ssid != null) {
        ssid = ssid.replaceAll('"', '').trim();
        if (ssid.isEmpty || ssid == '<unknown ssid>') ssid = null;
      }
    } catch (e) {
      _log.debug('SSID read failed: $e', tag: 'SECURITY');
    }
    try {
      bssid = await _networkInfo.getWifiBSSID();
      if (bssid != null) {
        bssid = bssid.trim();
        if (bssid.isEmpty || bssid == '00:00:00:00:00:00') bssid = null;
      }
    } catch (e) {
      _log.debug('BSSID read failed: $e', tag: 'SECURITY');
    }
    return NetworkDetails(ssid: ssid, bssid: bssid, denied: deniedOnMissing);
  }
}

class NetworkDetails {
  final String? ssid;
  final String? bssid;
  final bool denied;

  const NetworkDetails({this.ssid, this.bssid, this.denied = false});

  bool get isEmpty => ssid == null && bssid == null;
}
