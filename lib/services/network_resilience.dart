import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'circuit_breaker.dart';
import 'retry_policy.dart';

/// Top-level orchestrator that wires together [CircuitBreaker], [RetryPolicy]
/// and a `connectivity_plus` listener.
///
/// Usage:
///   await NetworkResilience.instance.start();
///   final result = await NetworkResilience.instance.execute(() => api.call());
///
/// Behaviour:
///   - Transient errors are retried with capped exponential backoff + jitter
///     while the circuit is CLOSED.
///   - Systemic errors (TLS handshake, DNS failure) immediately trip the
///     circuit; the retry policy does not waste attempts on them.
///   - When the breaker is OPEN, [execute] throws [CircuitBreakerOpenException]
///     fast, without hitting the network.
///   - Connectivity changes fast-path the breaker into HALF_OPEN so the next
///     request probes the new network immediately.
class NetworkResilience {
  static final NetworkResilience instance = NetworkResilience._();

  NetworkResilience._();

  late final CircuitBreaker _breaker = CircuitBreaker(name: 'api.icd360sev');
  late final RetryPolicy _retry = RetryPolicy();

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  List<ConnectivityResult>? _lastConnectivity;
  bool _started = false;

  CircuitBreaker get breaker => _breaker;
  Stream<CircuitBreakerEvent> get events => _breaker.events;
  CircuitState get circuitState => _breaker.state;

  /// Initialise. Idempotent.
  Future<void> start() async {
    if (_started) return;
    _started = true;

    final connectivity = Connectivity();
    try {
      _lastConnectivity = await connectivity.checkConnectivity();
    } catch (_) {
      // Non-fatal: we still want resilience even if connectivity probe failed.
    }

    _connectivitySub = connectivity.onConnectivityChanged.listen((results) {
      final changed = _lastConnectivity == null ||
          !_setEquals(_lastConnectivity!, results);
      _lastConnectivity = results;
      if (changed) {
        _breaker.onConnectivityChanged();
      }
    });
  }

  /// Execute [operation] under the circuit, retrying transient errors.
  /// Re-throws [CircuitBreakerOpenException] when the circuit is open.
  Future<T> execute<T>(Future<T> Function() operation) {
    return _breaker.execute(() => _retry.execute(operation));
  }

  Future<void> dispose() async {
    await _connectivitySub?.cancel();
    _connectivitySub = null;
    _breaker.dispose();
    _started = false;
  }

  bool _setEquals(List<ConnectivityResult> a, List<ConnectivityResult> b) {
    if (a.length != b.length) return false;
    final aSet = a.toSet();
    for (final x in b) {
      if (!aSet.contains(x)) return false;
    }
    return true;
  }
}
