import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/retry_policy.dart';

void main() {
  group('RetryPolicy', () {
    test('returns on first success without retrying', () async {
      final policy = RetryPolicy(
        maxAttempts: 3,
        initialDelay: const Duration(milliseconds: 1),
        random: Random(0),
      );
      var calls = 0;
      final result = await policy.execute(() async {
        calls++;
        return 'ok';
      });
      expect(result, 'ok');
      expect(calls, 1);
    });

    test('retries transient errors up to maxAttempts', () async {
      final policy = RetryPolicy(
        maxAttempts: 3,
        initialDelay: const Duration(milliseconds: 1),
        random: Random(0),
      );
      var calls = 0;
      await expectLater(
        policy.execute(() async {
          calls++;
          throw TimeoutException('boom');
        }),
        throwsA(isA<TimeoutException>()),
      );
      expect(calls, 3);
    });

    test('does NOT retry systemic errors', () async {
      final policy = RetryPolicy(
        maxAttempts: 5,
        initialDelay: const Duration(milliseconds: 1),
        random: Random(0),
      );
      var calls = 0;
      await expectLater(
        policy.execute(() async {
          calls++;
          throw const HandshakeException();
        }),
        throwsA(isA<HandshakeException>()),
      );
      expect(calls, 1);
    });

    test('succeeds on a later attempt', () async {
      final policy = RetryPolicy(
        maxAttempts: 4,
        initialDelay: const Duration(milliseconds: 1),
        random: Random(0),
      );
      var calls = 0;
      final result = await policy.execute(() async {
        calls++;
        if (calls < 3) throw TimeoutException('flaky');
        return 'recovered';
      });
      expect(result, 'recovered');
      expect(calls, 3);
    });

    test('respects custom shouldRetry predicate', () async {
      final policy = RetryPolicy(
        maxAttempts: 5,
        initialDelay: const Duration(milliseconds: 1),
        random: Random(0),
      );
      var calls = 0;
      await expectLater(
        policy.execute(
          () async {
            calls++;
            throw TimeoutException('boom');
          },
          shouldRetry: (_) => false, // override classifier
        ),
        throwsA(isA<TimeoutException>()),
      );
      expect(calls, 1);
    });
  });
}
