import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_theme.dart';

/// Widget for displaying registered devices and active sessions
/// Used in admin user details dialog (Tab: Geräte)
class MitgliederDeviceWidget extends StatelessWidget {
  final List<dynamic> sessions;
  final List<dynamic> devices;
  final bool isLoading;
  final Function(int) onRevokeSession;

  const MitgliederDeviceWidget({
    super.key,
    required this.sessions,
    required this.devices,
    required this.isLoading,
    required this.onRevokeSession,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Registrierte Geräte
          _buildSectionHeader(context, 
            Icons.devices,
            'Registrierte Geräte',
            '${devices.length} Geräte',
          ),
          const SizedBox(height: 8),
          if (devices.isEmpty)
            _buildEmptyCard(context, 'Keine registrierten Geräte')
          else
            ...devices.map((d) => _buildDeviceCard(context, d)),

          const SizedBox(height: 24),

          // Aktive Sitzungen
          _buildSectionHeader(context, 
            Icons.login,
            'Aktive Sitzungen',
            '${sessions.length} Sitzungen',
          ),
          const SizedBox(height: 8),
          if (sessions.isEmpty)
            _buildEmptyCard(context, 'Keine aktiven Sitzungen')
          else
            ...sessions.map((s) => _buildSessionCard(context, s)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, IconData icon, String title, String badge) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.colors.infoFg),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: context.colors.infoBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(badge, style: TextStyle(fontSize: 12, color: context.colors.infoFg)),
        ),
      ],
    );
  }

  Widget _buildEmptyCard(BuildContext context, String text) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: Text(text, style: TextStyle(color: context.colors.textTertiary))),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, dynamic device) {
    final deviceName = device['device_name'] ?? 'Unbekannt';
    final platform = device['platform'] ?? '';
    final deviceType = device['device_type'] ?? 'unknown';
    final appVersion = device['app_version'] ?? '';
    final osVersion = device['os_version'] ?? platform;
    final batteryLevel = device['battery_level'];
    final batteryState = device['battery_state'] ?? '';
    final connectionType = device['connection_type'] ?? '';
    final isVpn = device['is_vpn'] == 1 || device['is_vpn'] == true;
    final diskTotalGb = device['disk_total_gb'];
    final diskFreeGb = device['disk_free_gb'];
    final smartStatus = device['smart_status'] ?? '';
    final diskEncrypted = device['disk_encrypted'] == 1 || device['disk_encrypted'] == true;
    final firewallActive = device['firewall_active'] == 1 || device['firewall_active'] == true;
    final isRooted = device['is_rooted'] == 1 || device['is_rooted'] == true;
    final osUpToDate = device['os_up_to_date'] == 1 || device['os_up_to_date'] == true;
    final lastSeen = device['last_validated'] ?? device['updated_at'] ?? '';

    final typeIcon = _getDeviceTypeIcon(deviceType);
    final isActive = _isRecentlyActive(lastSeen);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: device name + status
            Row(
              children: [
                Icon(typeIcon, size: 20, color: context.colors.infoFg),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(deviceName, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                _buildBadge(isActive ? 'Aktiv' : 'Inaktiv', isActive ? context.colors.successFg : context.colors.textSecondary),
                const SizedBox(width: 4),
                _buildBadge(_deviceTypeLabel(deviceType), context.colors.infoFg),
              ],
            ),
            const Divider(height: 16),

            // Info rows
            _buildInfoRow(context, '💻', 'Betriebssystem', osVersion),
            if (appVersion.isNotEmpty)
              _buildInfoRow(context, '🔄', 'Client-Version', 'ICD360S v$appVersion'),
            if (connectionType.isNotEmpty)
              _buildInfoRow(context, '📶', 'Verbindung', connectionType),
            _buildInfoRow(context, '🔑', 'VPN', isVpn ? 'Aktiv' : 'Nicht aktiv'),
            if (batteryLevel != null)
              _buildInfoRow(context, '🔋', 'Akku', '$batteryLevel% ($batteryState)'),
            if (diskTotalGb != null && diskFreeGb != null)
              _buildInfoRow(context, '💾', 'Speicher', '$diskFreeGb GB frei / $diskTotalGb GB'),
            if (smartStatus.isNotEmpty)
              _buildInfoRow(context, '💿', 'Festplatte', smartStatus),
            _buildInfoRow(context, '🔄', 'System-Update', osUpToDate ? 'Auf neuestem Stand' : 'Updates verfügbar'),
            if (lastSeen.isNotEmpty)
              _buildInfoRow(context, '🕐', 'Zuletzt aktiv', _formatDateTime(lastSeen)),

            // Security section
            const SizedBox(height: 8),
            const Text('Sicherheit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                _buildSecurityBadge(context, '🔒 Verschlüsselung', diskEncrypted),
                _buildSecurityBadge(context, '🛡️ Firewall', firewallActive),
                _buildSecurityBadge(context, isRooted ? '⚠️ Gerootet' : '✅ Nicht gerootet', !isRooted),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, dynamic session) {
    final deviceName = session['device_info'] ?? session['device_name'] ?? 'Unbekannt';
    final ip = session['ip_address'] ?? '';
    final createdAt = session['created_at'] ?? '';
    final expiresAt = session['expires_at'] ?? '';
    final sessionId = int.tryParse(session['id']?.toString() ?? '') ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: device name + logout button
            Row(
              children: [
                Icon(Icons.phone_android, size: 18, color: context.colors.infoFg),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _parseDeviceName(deviceName),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => onRevokeSession(sessionId),
                  icon: Icon(Icons.logout, size: 16, color: context.colors.dangerFg),
                  label: Text('Logout', style: TextStyle(color: context.colors.dangerFg, fontSize: 12)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                  ),
                ),
              ],
            ),
            const Divider(height: 12),
            if (ip.isNotEmpty) _buildInfoRow(context, '🌐', 'IP', ip),
            if (createdAt.isNotEmpty) _buildInfoRow(context, '🔓', 'Angemeldet', _formatDateTime(createdAt)),
            if (expiresAt.isNotEmpty) _buildInfoRow(context, '⏰', 'Läuft ab', _formatDateTime(expiresAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: Text(label, style: TextStyle(color: context.colors.textSecondary, fontSize: 13)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSecurityBadge(BuildContext context, String text, bool isGood) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isGood ? context.colors.successBg : context.colors.dangerBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isGood ? context.colors.successBorder : context.colors.dangerBorder),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: isGood ? context.colors.successFg : context.colors.dangerFg)),
    );
  }

  IconData _getDeviceTypeIcon(String type) {
    switch (type) {
      case 'phone': return Icons.phone_android;
      case 'tablet': return Icons.tablet_android;
      case 'desktop': return Icons.desktop_windows;
      default: return Icons.devices;
    }
  }

  String _deviceTypeLabel(String type) {
    switch (type) {
      case 'phone': return 'Phone';
      case 'tablet': return 'Tablet';
      case 'desktop': return 'Desktop';
      default: return 'Unbekannt';
    }
  }

  bool _isRecentlyActive(String lastSeen) {
    if (lastSeen.isEmpty) return false;
    try {
      final dt = DateTime.parse(lastSeen);
      return DateTime.now().difference(dt).inMinutes < 30;
    } catch (_) {
      return false;
    }
  }

  String _formatDateTime(String dateStr) {
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('dd.MM.yyyy HH:mm').format(dt);
    } catch (_) {
      return dateStr;
    }
  }

  String _parseDeviceName(String deviceInfo) {
    try {
      final map = Map<String, dynamic>.from(
        deviceInfo.startsWith('{') ? _jsonDecode(deviceInfo) : {'name': deviceInfo},
      );
      return map['device_name'] ?? map['name'] ?? deviceInfo;
    } catch (_) {
      return deviceInfo;
    }
  }

  dynamic _jsonDecode(String s) {
    try {
      return Map<String, dynamic>.from(
        Uri.splitQueryString(s.replaceAll('{', '').replaceAll('}', '').replaceAll('"', '')),
      );
    } catch (_) {
      return {'name': s};
    }
  }
}
