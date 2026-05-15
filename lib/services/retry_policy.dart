import 'dart:async';
import 'dart:math';

import 'network_error_classifier.dart';

/// Retry policy with capped exponential backoff and jitter.
///
/// Only retries errors classified as transient by [NetworkErrorClassifier].
/// Systemic errors (TLS handshake, DNS failure) propagate immediately so the
/// [CircuitBreaker] can trip without burning extra attempts.
///
/// Delays: 1s, 2s, 4s, ... capped at [maxDelay], with +/- [jitterFactor]
/// random jitter to avoid thundering-herd retry storms.
class RetryPolicy {
  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final double jitterFactor;
  final Random _random;

  RetryPolicy({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 8),
    this.jitterFactor = 0.25,
    Random? random,
  })  : assert(maxAttempts >= 1),
        assert(jitterFactor >= 0 && jitterFactor < 1),
        _random = random ?? Random();

  /// Execute [operation], retrying transient failures.
  /// The last failure is rethrown if all attempts are exhausted.
  Future<T> execute<T>(
    Future<T> Function() operation, {
    bool Function(Object error)? shouldRetry,
  }) async {
    Object? lastError;
    StackTrace? lastStack;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        return await operation();
      } catch (e, st) {
        lastError = e;
        lastStack = st;

        final retryable = shouldRetry?.call(e) ?? NetworkErrorClassifier.isTransient(e);
        if (!retryable) rethrow;
        if (attempt == maxAttempts - 1) break;

        await Future<void>.delayed(_computeDelay(attempt));
      }
    }

    Error.throwWithStackTrace(lastError!, lastStack!);
  }

  Duration _computeDelay(int attempt) {
    final base = initialDelay.inMilliseconds * pow(2, attempt).toInt();
    final capped = base > maxDelay.inMilliseconds ? maxDelay.inMilliseconds : base;
    final jitterRange = (capped * jitterFactor).round();
    final jitter = _random.nextInt(jitterRange * 2 + 1) - jitterRange;
    return Duration(milliseconds: capped + jitter);
  }
}
