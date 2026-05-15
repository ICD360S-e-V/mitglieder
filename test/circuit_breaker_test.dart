import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/circuit_breaker.dart';

void main() {
  group('CircuitBreaker', () {
    test('starts closed and stays closed on success', () async {
      final cb = CircuitBreaker(name: 'test');
      expect(cb.state, CircuitState.closed);
      final result = await cb.execute(() async => 42);
      expect(result, 42);
      expect(cb.state, CircuitState.closed);
      cb.dispose();
    });

    test('opens immediately on a single systemic error (default threshold=1)', () async {
      final cb = CircuitBreaker(
        name: 'test',
        initialOpenTimeout: const Duration(seconds: 30),
      );
      await expectLater(
        cb.execute(() async => throw const HandshakeException()),
        throwsA(isA<HandshakeException>()),
      );
      expect(cb.state, CircuitState.open);
      cb.dispose();
    });

    test('requires 3 transient errors to open (default failureThreshold)', () async {
      final cb = CircuitBreaker(
        name: 'test',
        initialOpenTimeout: const Duration(seconds: 30),
      );
      for (var i = 0; i < 2; i++) {
        await expectLater(
          cb.execute(() async => throw TimeoutException('t')),
          throwsA(isA<TimeoutException>()),
        );
        expect(cb.state, CircuitState.closed, reason: 'after $i transient errors');
      }
      await expectLater(
        cb.execute(() async => throw TimeoutException('t')),
        throwsA(isA<TimeoutException>()),
      );
      expect(cb.state, CircuitState.open);
      cb.dispose();
    });

    test('open circuit fast-fails with CircuitBreakerOpenException', () async {
      final cb = CircuitBreaker(
        name: 'test',
        initialOpenTimeout: const Duration(seconds: 30),
      );
      await expectLater(
        cb.execute(() async => throw const HandshakeException()),
        throwsA(isA<HandshakeException>()),
      );
      expect(cb.state, CircuitState.open);

      var underlyingCalled = false;
      await expectLater(
        cb.execute(() async {
          underlyingCalled = true;
          return 1;
        }),
        throwsA(isA<CircuitBreakerOpenException>()),
      );
      expect(underlyingCalled, isFalse, reason: 'underlying must not be invoked while OPEN');
      cb.dispose();
    });

    test('connectivity change fast-paths open -> half-open', () async {
      final cb = CircuitBreaker(
        name: 'test',
        initialOpenTimeout: const Duration(seconds: 30),
      );
      await expectLater(
        cb.execute(() async => throw const HandshakeException()),
        throwsA(isA<HandshakeException>()),
      );
      expect(cb.state, CircuitState.open);

      cb.onConnectivityChanged();
      expect(cb.state, CircuitState.halfOpen);

      final ok = await cb.execute(() async => 'recovered');
      expect(ok, 'recovered');
      expect(cb.state, CircuitState.closed);
      cb.dispose();
    });

    test('half-open failure re-opens with longer timeout', () async {
      final cb = CircuitBreaker(
        name: 'test',
        initialOpenTimeout: const Duration(seconds: 30),
      );
      await expectLater(
        cb.execute(() async => throw const HandshakeException()),
        throwsA(isA<HandshakeException>()),
      );
      cb.onConnectivityChanged();
      expect(cb.state, CircuitState.halfOpen);

      await expectLater(
        cb.execute(() async => throw const HandshakeException()),
        throwsA(isA<HandshakeException>()),
      );
      expect(cb.state, CircuitState.open);
      cb.dispose();
    });

    test('emits events on state transitions', () async {
      final cb = CircuitBreaker(
        name: 'test',
        initialOpenTimeout: const Duration(seconds: 30),
      );
      final events = <CircuitState>[];
      final sub = cb.events.listen((e) => events.add(e.newState));

      await expectLater(
        cb.execute(() async => throw const HandshakeException()),
        throwsA(isA<HandshakeException>()),
      );
      cb.onConnectivityChanged();
      await cb.execute(() async => 'ok');

      // Broadcast stream delivers events on the microtask queue; drain it.
      await Future<void>.delayed(Duration.zero);

      await sub.cancel();
      cb.dispose();

      expect(events, [CircuitState.open, CircuitState.halfOpen, CircuitState.closed]);
    });

    test('reset() returns to CLOSED unconditionally', () async {
      final cb = CircuitBreaker(
        name: 'test',
        initialOpenTimeout: const Duration(seconds: 30),
      );
      await expectLater(
        cb.execute(() async => throw const HandshakeException()),
        throwsA(isA<HandshakeException>()),
      );
      expect(cb.state, CircuitState.open);

      cb.reset();
      expect(cb.state, CircuitState.closed);
      cb.dispose();
    });
  });
}
