import 'package:http/http.dart' as http;

import 'network_resilience.dart';

/// An [http.Client] decorator that routes every request through the global
/// [NetworkResilience] circuit breaker.
///
/// Why only the breaker, not retry+breaker:
///   - Many requests are non-idempotent POSTs (login, sendMessage). Silent
///     retries would risk duplicate side-effects.
///   - The breaker alone gives us what we need: detect TLS interception,
///     trip on systemic errors, fast-fail while open, recover on connectivity
///     change. Retry stays the caller's choice.
class ResilientHttpClient extends http.BaseClient {
  final http.Client _inner;

  ResilientHttpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return NetworkResilience.instance.breaker.execute(() => _inner.send(request));
  }

  @override
  void close() => _inner.close();
}
