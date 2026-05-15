import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/network_error_classifier.dart';

void main() {
  group('isSystemic', () {
    test('HandshakeException -> systemic', () {
      expect(NetworkErrorClassifier.isSystemic(const HandshakeException()), isTrue);
    });

    test('TlsException -> systemic', () {
      expect(NetworkErrorClassifier.isSystemic(const TlsException()), isTrue);
    });

    test('CERTIFICATE_VERIFY_FAILED string -> systemic', () {
      final err = Exception('CERTIFICATE_VERIFY_FAILED: self signed certificate');
      expect(NetworkErrorClassifier.isSystemic(err), isTrue);
    });

    test('Failed host lookup -> systemic', () {
      final err = Exception("Failed host lookup: 'icd360sev.icd360s.de' (OS Error: No address)");
      expect(NetworkErrorClassifier.isSystemic(err), isTrue);
    });

    test('TimeoutException -> not systemic', () {
      expect(NetworkErrorClassifier.isSystemic(TimeoutException('timeout')), isFalse);
    });

    test('SocketException with connection refused -> not systemic', () {
      expect(NetworkErrorClassifier.isSystemic(const SocketException('Connection refused')), isFalse);
    });
  });

  group('isTransient', () {
    test('TimeoutException -> transient', () {
      expect(NetworkErrorClassifier.isTransient(TimeoutException('timeout')), isTrue);
    });

    test('SocketException -> transient', () {
      expect(NetworkErrorClassifier.isTransient(const SocketException('reset')), isTrue);
    });

    test('HandshakeException -> not transient (it is systemic)', () {
      expect(NetworkErrorClassifier.isTransient(const HandshakeException()), isFalse);
    });

    test('"connection timed out" string -> transient', () {
      final err = Exception('HTTP connection timed out after 0:00:15.000000');
      expect(NetworkErrorClassifier.isTransient(err), isTrue);
    });
  });

  group('categorize', () {
    test('TLS -> tlsInterception', () {
      expect(
        NetworkErrorClassifier.categorize(const HandshakeException()),
        NetworkErrorCategory.tlsInterception,
      );
    });

    test('DNS lookup -> dnsFailure', () {
      expect(
        NetworkErrorClassifier.categorize(Exception('Failed host lookup: x')),
        NetworkErrorCategory.dnsFailure,
      );
    });

    test('connection refused -> connectionRefused', () {
      expect(
        NetworkErrorClassifier.categorize(const SocketException('Connection refused')),
        NetworkErrorCategory.connectionRefused,
      );
    });

    test('timeout -> timeout', () {
      expect(
        NetworkErrorClassifier.categorize(TimeoutException('timed out')),
        NetworkErrorCategory.timeout,
      );
    });

    test('unknown -> unknown', () {
      expect(
        NetworkErrorClassifier.categorize(StateError('weird')),
        NetworkErrorCategory.unknown,
      );
    });
  });
}
