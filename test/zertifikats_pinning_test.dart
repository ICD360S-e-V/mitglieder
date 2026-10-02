// Die Vertrauensanker der gepinnten Verbindungen — in Dart
// (HttpClientFactory) und für alles andere unter Android
// (network_security_config.xml).
//
// ⚠️ Seit 10/2026 endet die Kette des Servers an Let's Encrypts neuer
// „Root YE"; X2 trägt sie nur über eine Kreuzsignatur. Fällt die weg und
// stehen YE/YR nicht unter den Ankern, reisst jede gepinnte Verbindung ab —
// Anmeldung, Chat, Anrufe.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/http_client_factory.dart';

void main() {
  final pems = RegExp(
          r'-----BEGIN CERTIFICATE-----[\s\S]*?-----END CERTIFICATE-----')
      .allMatches(HttpClientFactory.vertrauensanker)
      .map((m) => m.group(0)!)
      .toList();

  test('vier Wurzeln: ISRG X1, X2, YE und YR', () {
    expect(pems, hasLength(4));
    expect(pems.toSet(), hasLength(4), reason: 'keine doppelt');
  });

  test('jede Wurzel lässt sich als Vertrauensanker laden', () {
    for (final pem in pems) {
      expect(
          () => SecurityContext(withTrustedRoots: false)
              .setTrustedCertificatesBytes(utf8.encode(pem)),
          returnsNormally);
    }
    // Und alle zusammen, so wie die Fabrik sie lädt.
    expect(
        () => SecurityContext(withTrustedRoots: false)
            .setTrustedCertificatesBytes(
                utf8.encode(HttpClientFactory.vertrauensanker)),
        returnsNormally);
  });

  test('🔴 Android pinnt dieselben vier Wurzeln', () {
    final xml = File('android/app/src/main/res/xml/network_security_config.xml')
        .readAsStringSync();
    // SHA-256 des SubjectPublicKeyInfo, mit openssl aus den PEMs oben
    // berechnet (dieselbe Rechnung ergibt die beiden alten Pins exakt).
    const pins = {
      'ISRG Root X1': 'C5+lpZ7tcVwmwQIMcRtPbsQtWLABXhQzejna0wHFr8M=',
      'ISRG Root X2': 'diGVwiVYbubAI3RW4hB9xU8e/CH2GnkuvVFZE8zmgzI=',
      'ISRG Root YE': 'sCkq5UWXjg+7mKu9lMhhYF5bGLsy7VI/UNW3tccdR7w=',
      'ISRG Root YR': 'fk6IOKit1ild5647BH06ujSIq5XbCgqlbYl6ANhhi88=',
    };
    pins.forEach((wurzel, pin) {
      expect(xml, contains('<pin digest="SHA-256">$pin</pin>'),
          reason: '$wurzel fehlt in network_security_config.xml');
    });
  });
}
