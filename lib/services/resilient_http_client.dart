import 'package:http/http.dart' as http;

import 'battery_usage_service.dart';
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
    // Zählpunkt für die Akkumessung. Jede abgesetzte Anfrage weckt das
    // Funkmodem, und die Anzahl pro Stunde — nicht die Datenmenge — ist die
    // Grösse, die den Verbrauch bestimmt. Hier zu zählen erfasst alles, was
    // über ApiService läuft, an genau einer Stelle.
    //
    // Welcher Dienst es war, sagt die Zone: periodische Aufrufer umschliessen
    // sich mit BatteryUsageService.runAs(...). Ohne Markierung ist es eine
    // gewöhnliche Anfrage des Mitglieds. Die Dienste mit eigenem HTTP-Client
    // (LoggerService, DiagnosticService, Ticket-Abfrage, ntfy, Device-Key)
    // zählen jeweils selbst.
    BatteryUsageService.instance
        .noteNetworkRequest(BatteryUsageService.currentSource);
    return NetworkResilience.instance.breaker.execute(() => _inner.send(request));
  }

  @override
  void close() => _inner.close();
}
