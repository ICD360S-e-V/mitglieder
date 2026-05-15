import 'network_error_classifier.dart';

/// One reportable security event (TLS handshake fail, DNS hijack, etc.).
///
/// Same `(host, category, fingerprint)` within a coalescing window collapse
/// into a single instance with [occurrenceCount] incremented and [lastSeen]
/// advanced — keeps server-side noise low.
class SecurityEvent {
  final String host;
  final NetworkErrorCategory category;
  final String? errorMessage;
  final String? presentedSubject;
  final String? presentedIssuer;
  final String? presentedFingerprint;
  final String? networkType;
  final String? networkSsid;
  final String? networkBssid;
  final bool networkSsidDenied;

  final DateTime firstSeen;
  DateTime lastSeen;
  int occurrenceCount;

  SecurityEvent({
    required this.host,
    required this.category,
    required this.firstSeen,
    DateTime? lastSeen,
    this.occurrenceCount = 1,
    this.errorMessage,
    this.presentedSubject,
    this.presentedIssuer,
    this.presentedFingerprint,
    this.networkType,
    this.networkSsid,
    this.networkBssid,
    this.networkSsidDenied = false,
  }) : lastSeen = lastSeen ?? firstSeen;

  String get coalescingKey =>
      '$host|${category.name}|${presentedFingerprint ?? ''}';

  Map<String, dynamic> toJson() => {
        'failed_at': _format(firstSeen),
        'first_seen': _format(firstSeen),
        'last_seen': _format(lastSeen),
        'occurrence_count': occurrenceCount,
        'host': host,
        'error_category': category.name,
        if (errorMessage != null) 'error_message': errorMessage,
        if (presentedSubject != null) 'presented_subject': presentedSubject,
        if (presentedIssuer != null) 'presented_issuer': presentedIssuer,
        if (presentedFingerprint != null) 'presented_fingerprint': presentedFingerprint,
        if (networkType != null) 'network_type': networkType,
        if (networkSsid != null) 'network_ssid': networkSsid,
        if (networkBssid != null) 'network_bssid': networkBssid,
        'network_ssid_denied': networkSsidDenied,
      };

  factory SecurityEvent.fromJson(Map<String, dynamic> json) => SecurityEvent(
        host: json['host'] as String,
        category: _categoryFromName(json['error_category'] as String?),
        firstSeen: _parseUtc(json['first_seen'] as String),
        lastSeen: _parseUtc(json['last_seen'] as String),
        occurrenceCount: (json['occurrence_count'] as int?) ?? 1,
        errorMessage: json['error_message'] as String?,
        presentedSubject: json['presented_subject'] as String?,
        presentedIssuer: json['presented_issuer'] as String?,
        presentedFingerprint: json['presented_fingerprint'] as String?,
        networkType: json['network_type'] as String?,
        networkSsid: json['network_ssid'] as String?,
        networkBssid: json['network_bssid'] as String?,
        networkSsidDenied: json['network_ssid_denied'] == true,
      );

  /// We emit `YYYY-MM-DD HH:MM:SS` (server-compatible). `DateTime.parse`
  /// without a trailing `Z` treats that as LOCAL time, which would shift the
  /// instant on a roundtrip. We always serialise UTC, so always parse UTC.
  static DateTime _parseUtc(String s) {
    final normalised = s.contains('T') ? s : s.replaceFirst(' ', 'T');
    return DateTime.parse('${normalised}Z');
  }

  static String _format(DateTime dt) {
    final d = dt.toUtc();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)} '
        '${two(d.hour)}:${two(d.minute)}:${two(d.second)}';
  }

  static NetworkErrorCategory _categoryFromName(String? name) {
    for (final c in NetworkErrorCategory.values) {
      if (c.name == name) return c;
    }
    return NetworkErrorCategory.unknown;
  }
}
