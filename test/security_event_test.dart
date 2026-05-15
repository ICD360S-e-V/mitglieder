import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/network_error_classifier.dart';
import 'package:icd360sev_mitglied/services/security_event.dart';

void main() {
  group('SecurityEvent', () {
    test('coalescingKey groups by host+category+fingerprint', () {
      final a = SecurityEvent(
        host: 'icd360sev.icd360s.de',
        category: NetworkErrorCategory.tlsInterception,
        firstSeen: DateTime(2026, 5, 15),
        presentedFingerprint: 'aa:bb',
      );
      final b = SecurityEvent(
        host: 'icd360sev.icd360s.de',
        category: NetworkErrorCategory.tlsInterception,
        firstSeen: DateTime(2026, 5, 15, 0, 5),
        presentedFingerprint: 'aa:bb',
      );
      final c = SecurityEvent(
        host: 'icd360sev.icd360s.de',
        category: NetworkErrorCategory.dnsFailure,
        firstSeen: DateTime(2026, 5, 15),
        presentedFingerprint: 'aa:bb',
      );
      expect(a.coalescingKey, b.coalescingKey);
      expect(a.coalescingKey, isNot(c.coalescingKey));
    });

    test('JSON roundtrip preserves fields', () {
      final original = SecurityEvent(
        host: 'icd360sev.icd360s.de',
        category: NetworkErrorCategory.tlsInterception,
        firstSeen: DateTime.utc(2026, 5, 15, 22, 23, 36),
        lastSeen: DateTime.utc(2026, 5, 15, 22, 24, 14),
        occurrenceCount: 3,
        errorMessage: 'HandshakeException',
        presentedSubject: 'CN=Kaspersky Local Root',
        presentedIssuer: 'CN=Kaspersky Lab AG',
        presentedFingerprint: 'ab:cd:ef',
        networkType: 'wifi',
        networkSsid: 'Hotel-Guest',
        networkBssid: 'aa:bb:cc:dd:ee:ff',
        networkSsidDenied: false,
      );
      final json = original.toJson();
      final restored = SecurityEvent.fromJson({
        ...json,
        'failed_at': json['first_seen'],
      });

      expect(restored.host, original.host);
      expect(restored.category, original.category);
      expect(restored.occurrenceCount, original.occurrenceCount);
      expect(restored.firstSeen, original.firstSeen);
      expect(restored.lastSeen, original.lastSeen);
      expect(restored.errorMessage, original.errorMessage);
      expect(restored.presentedSubject, original.presentedSubject);
      expect(restored.presentedIssuer, original.presentedIssuer);
      expect(restored.presentedFingerprint, original.presentedFingerprint);
      expect(restored.networkType, original.networkType);
      expect(restored.networkSsid, original.networkSsid);
      expect(restored.networkBssid, original.networkBssid);
      expect(restored.networkSsidDenied, original.networkSsidDenied);
    });

    test('JSON omits null fields', () {
      final event = SecurityEvent(
        host: 'icd360sev.icd360s.de',
        category: NetworkErrorCategory.dnsFailure,
        firstSeen: DateTime.utc(2026, 5, 15),
      );
      final json = event.toJson();
      expect(json.containsKey('error_message'), isFalse);
      expect(json.containsKey('presented_subject'), isFalse);
      expect(json.containsKey('network_ssid'), isFalse);
      expect(json['network_ssid_denied'], isFalse);
    });

    test('default lastSeen equals firstSeen', () {
      final t = DateTime.utc(2026, 5, 15);
      final event = SecurityEvent(
        host: 'h',
        category: NetworkErrorCategory.unknown,
        firstSeen: t,
      );
      expect(event.lastSeen, t);
    });
  });
}
