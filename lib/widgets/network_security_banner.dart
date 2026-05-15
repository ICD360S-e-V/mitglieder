import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/circuit_breaker.dart';
import '../services/network_details_service.dart';
import '../services/network_error_classifier.dart';
import '../services/network_resilience.dart';
import '../services/secure_storage_helper.dart';

/// Global, non-dismissable banner that surfaces network-security events to the
/// user. Wraps the entire app via MaterialApp.builder so it's visible no
/// matter the current screen.
///
/// Behaviour:
///   - Listens to [NetworkResilience.events] for circuit-breaker trips.
///   - Shows a colored banner sized to one or two lines, scoped above the
///     existing UI (does not push content down).
///   - Auto-dismisses after 5 seconds (per product decision). NOT manually
///     dismissable — server already has the report, the user just needs the
///     hint that something on their network is interfering.
///   - The FIRST time a TLS interception fires, also prompts for location
///     permission (needed for WiFi name access on Android/iOS). Subsequent
///     trips do not re-prompt; the system handles that.
class NetworkSecurityBanner extends StatefulWidget {
  final Widget child;

  const NetworkSecurityBanner({super.key, required this.child});

  @override
  State<NetworkSecurityBanner> createState() => _NetworkSecurityBannerState();
}

class _NetworkSecurityBannerState extends State<NetworkSecurityBanner> {
  static const Duration _displayDuration = Duration(seconds: 5);
  static const String _permissionAskedKey = 'security_perm_asked_v1';

  StreamSubscription<CircuitBreakerEvent>? _eventsSub;
  Timer? _dismissTimer;
  _BannerData? _current;
  bool _promptingPermission = false;

  @override
  void initState() {
    super.initState();
    _eventsSub = NetworkResilience.instance.events.listen(_onEvent);
  }

  @override
  void dispose() {
    _eventsSub?.cancel();
    _dismissTimer?.cancel();
    super.dispose();
  }

  void _onEvent(CircuitBreakerEvent ev) {
    if (!mounted) return;
    if (ev.newState != CircuitState.open) return;

    final data = _bannerFor(ev.errorCategory ?? NetworkErrorCategory.unknown);
    if (data == null) return;

    setState(() => _current = data);
    _dismissTimer?.cancel();
    _dismissTimer = Timer(_displayDuration, () {
      if (mounted) setState(() => _current = null);
    });

    if (ev.errorCategory == NetworkErrorCategory.tlsInterception) {
      _maybeRequestSsidPermission();
    }
  }

  Future<void> _maybeRequestSsidPermission() async {
    if (_promptingPermission) return;
    final storage = createSecureStorage();
    final asked = await storage.read(key: _permissionAskedKey);
    if (asked == 'true') return;
    if (await NetworkDetailsService.instance.hasSsidAccess()) {
      await storage.write(key: _permissionAskedKey, value: 'true');
      return;
    }

    _promptingPermission = true;
    try {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      final allow = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.securityPermissionDialogTitle),
          content: Text(l10n.securityPermissionDialogBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.securityPermissionDialogDeny),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.securityPermissionDialogAllow),
            ),
          ],
        ),
      );
      if (allow == true) {
        await NetworkDetailsService.instance.requestSsidAccess();
      }
      await storage.write(key: _permissionAskedKey, value: 'true');
    } finally {
      _promptingPermission = false;
    }
  }

  _BannerData? _bannerFor(NetworkErrorCategory category) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return null;
    switch (category) {
      case NetworkErrorCategory.tlsInterception:
        return _BannerData(
          message: l10n.securityBannerTlsInterception,
          color: const Color(0xFFB71C1C),
          icon: Icons.shield_outlined,
        );
      case NetworkErrorCategory.dnsFailure:
        return _BannerData(
          message: l10n.securityBannerDnsFailure,
          color: const Color(0xFFE65100),
          icon: Icons.dns_outlined,
        );
      case NetworkErrorCategory.connectionRefused:
      case NetworkErrorCategory.timeout:
        return _BannerData(
          message: l10n.securityBannerSlowNetwork,
          color: const Color(0xFF1565C0),
          icon: Icons.wifi_tethering_error_outlined,
        );
      case NetworkErrorCategory.unknown:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final banner = _current;
    return Stack(
      children: [
        widget.child,
        if (banner != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Material(
                color: banner.color,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(banner.icon, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          banner.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _BannerData {
  final String message;
  final Color color;
  final IconData icon;
  const _BannerData({
    required this.message,
    required this.color,
    required this.icon,
  });
}
