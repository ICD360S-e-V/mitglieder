import 'dart:async';

import 'network_error_classifier.dart';

/// State of a [CircuitBreaker].
///
/// - [closed]: requests pass through normally.
/// - [open]: requests fail immediately without hitting the network.
/// - [halfOpen]: a single probe request is allowed to check recovery.
enum CircuitState { closed, open, halfOpen }

/// Emitted on every state transition. UI can listen to drive banners and
/// telemetry pipelines can persist to disk / push to server.
class CircuitBreakerEvent {
  final String circuitName;
  final CircuitState newState;
  final CircuitState previousState;
  final Object? triggerError;
  final NetworkErrorCategory? errorCategory;
  final DateTime timestamp;
  final Duration? nextProbeIn;

  CircuitBreakerEvent({
    required this.circuitName,
    required this.newState,
    required this.previousState,
    this.triggerError,
    this.errorCategory,
    this.nextProbeIn,
  }) : timestamp = DateTime.now();
}

/// Thrown when an operation is short-circuited because the breaker is OPEN.
/// Callers should treat this as a non-retryable, expected condition.
class CircuitBreakerOpenException implements Exception {
  final String circuitName;
  final DateTime willHalfOpenAt;

  CircuitBreakerOpenException(this.circuitName, this.willHalfOpenAt);

  @override
  String toString() =>
      'CircuitBreakerOpenException($circuitName, retry after $willHalfOpenAt)';
}

/// Per-host circuit breaker with capped exponential backoff and a
/// connectivity-change fast-path back into HALF_OPEN.
///
/// Trip rules:
///   - One systemic error (TLS handshake / cert / DNS) -> immediate OPEN.
///   - [failureThreshold] consecutive transient errors -> OPEN.
///
/// Recovery:
///   - On the open timer expiring (60s, 120s, 240s, ... capped at
///     [maxOpenTimeout]), the breaker enters HALF_OPEN and allows one probe.
///   - On a connectivity change (e.g. user toggled WiFi / data), the breaker
///     enters HALF_OPEN immediately regardless of the timer.
class CircuitBreaker {
  final String name;
  final int failureThreshold;
  final int systemicFailureThreshold;
  final Duration initialOpenTimeout;
  final Duration maxOpenTimeout;

  CircuitState _state = CircuitState.closed;
  int _consecutiveTransientFailures = 0;
  int _consecutiveSystemicFailures = 0;
  int _openCycles = 0;
  Timer? _halfOpenTimer;
  DateTime? _willHalfOpenAt;

  final StreamController<CircuitBreakerEvent> _eventController =
      StreamController<CircuitBreakerEvent>.broadcast();

  CircuitBreaker({
    required this.name,
    this.failureThreshold = 3,
    this.systemicFailureThreshold = 1,
    this.initialOpenTimeout = const Duration(seconds: 60),
    this.maxOpenTimeout = const Duration(minutes: 10),
  })  : assert(failureThreshold >= 1),
        assert(systemicFailureThreshold >= 1);

  CircuitState get state => _state;
  Stream<CircuitBreakerEvent> get events => _eventController.stream;
  DateTime? get willHalfOpenAt => _willHalfOpenAt;

  /// Execute [operation] under the circuit.
  ///
  /// Throws [CircuitBreakerOpenException] if the circuit is OPEN.
  /// In HALF_OPEN: success closes the circuit, failure re-opens it with a
  /// longer timeout. In CLOSED: failures count toward the trip threshold.
  Future<T> execute<T>(Future<T> Function() operation) async {
    if (_state == CircuitState.open) {
      throw CircuitBreakerOpenException(
        name,
        _willHalfOpenAt ?? DateTime.now(),
      );
    }

    try {
      final result = await operation();
      _onSuccess();
      return result;
    } catch (e) {
      _onFailure(e);
      rethrow;
    }
  }

  void _onSuccess() {
    final previous = _state;
    _consecutiveTransientFailures = 0;
    _consecutiveSystemicFailures = 0;

    if (_state != CircuitState.closed) {
      _openCycles = 0;
      _halfOpenTimer?.cancel();
      _willHalfOpenAt = null;
      _state = CircuitState.closed;
      _emit(previous: previous);
    }
  }

  void _onFailure(Object error) {
    if (_state == CircuitState.halfOpen) {
      _trip(error);
      return;
    }

    if (NetworkErrorClassifier.isSystemic(error)) {
      _consecutiveSystemicFailures++;
      if (_consecutiveSystemicFailures >= systemicFailureThreshold) {
        _trip(error);
      }
      return;
    }

    if (NetworkErrorClassifier.isTransient(error)) {
      _consecutiveTransientFailures++;
      if (_consecutiveTransientFailures >= failureThreshold) {
        _trip(error);
      }
    }
  }

  void _trip(Object error) {
    final previous = _state;
    _state = CircuitState.open;

    final timeout = _computeOpenTimeout();
    _openCycles++;
    _willHalfOpenAt = DateTime.now().add(timeout);

    _halfOpenTimer?.cancel();
    _halfOpenTimer = Timer(timeout, _transitionToHalfOpen);

    _emit(
      previous: previous,
      error: error,
      nextProbeIn: timeout,
    );
  }

  Duration _computeOpenTimeout() {
    final ms = initialOpenTimeout.inMilliseconds * (1 << _openCycles);
    final capped = ms > maxOpenTimeout.inMilliseconds
        ? maxOpenTimeout.inMilliseconds
        : ms;
    return Duration(milliseconds: capped);
  }

  void _transitionToHalfOpen() {
    if (_state != CircuitState.open) return;
    final previous = _state;
    _state = CircuitState.halfOpen;
    _willHalfOpenAt = null;
    _emit(previous: previous);
  }

  /// Hook for `connectivity_plus`. When the device's connectivity changes
  /// (e.g. WiFi -> Mobile), an open breaker fast-paths into HALF_OPEN so the
  /// next request can immediately probe the new network.
  void onConnectivityChanged() {
    if (_state == CircuitState.open) {
      _halfOpenTimer?.cancel();
      _transitionToHalfOpen();
    }
  }

  /// Force the circuit back to CLOSED. Use for testing or admin actions.
  void reset() {
    final previous = _state;
    _halfOpenTimer?.cancel();
    _consecutiveTransientFailures = 0;
    _consecutiveSystemicFailures = 0;
    _openCycles = 0;
    _willHalfOpenAt = null;
    _state = CircuitState.closed;
    if (previous != CircuitState.closed) {
      _emit(previous: previous);
    }
  }

  void _emit({
    required CircuitState previous,
    Object? error,
    Duration? nextProbeIn,
  }) {
    if (_eventController.isClosed) return;
    _eventController.add(CircuitBreakerEvent(
      circuitName: name,
      newState: _state,
      previousState: previous,
      triggerError: error,
      errorCategory: error == null ? null : NetworkErrorClassifier.categorize(error),
      nextProbeIn: nextProbeIn,
    ));
  }

  void dispose() {
    _halfOpenTimer?.cancel();
    _eventController.close();
  }
}
