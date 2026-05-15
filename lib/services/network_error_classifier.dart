import 'dart:async';
import 'dart:io';

/// Classifies network errors as systemic (won't recover via retry) or
/// transient (likely to recover). Used by [CircuitBreaker] and [RetryPolicy].
///
/// Systemic = trip the circuit, show banner, send report.
/// Transient = retry with backoff inside the circuit's CLOSED state.
class NetworkErrorClassifier {
  const NetworkErrorClassifier._();

  /// True if the error indicates a fundamental problem with the network or
  /// security context. Retrying won't help until the user changes networks.
  static bool isSystemic(Object error) {
    if (error is HandshakeException) return true;
    if (error is TlsException) return true;
    if (error is CertificateException) return true;

    final msg = error.toString().toLowerCase();
    if (msg.contains('certificate_verify_failed')) return true;
    if (msg.contains('self signed') || msg.contains('self-signed')) return true;
    if (msg.contains('handshake')) return true;
    if (msg.contains('failed host lookup')) return true;
    if (msg.contains('no address associated')) return true;
    return false;
  }

  /// True if retrying after a short backoff has a reasonable chance to succeed.
  static bool isTransient(Object error) {
    if (isSystemic(error)) return false;
    if (error is TimeoutException) return true;
    if (error is SocketException) return true;
    if (error is HttpException) return true;

    final msg = error.toString().toLowerCase();
    if (msg.contains('timeout') || msg.contains('timed out')) return true;
    if (msg.contains('connection refused')) return true;
    if (msg.contains('connection reset')) return true;
    if (msg.contains('connection closed')) return true;
    if (msg.contains('network is unreachable')) return true;
    if (msg.contains('broken pipe')) return true;
    return false;
  }

  /// Category for telemetry / banner color.
  static NetworkErrorCategory categorize(Object error) {
    if (error is HandshakeException ||
        error is TlsException ||
        error is CertificateException ||
        error.toString().toLowerCase().contains('certificate_verify_failed') ||
        error.toString().toLowerCase().contains('handshake')) {
      return NetworkErrorCategory.tlsInterception;
    }

    final msg = error.toString().toLowerCase();
    if (msg.contains('failed host lookup') ||
        msg.contains('no address associated')) {
      return NetworkErrorCategory.dnsFailure;
    }
    if (msg.contains('timeout') || msg.contains('timed out')) {
      return NetworkErrorCategory.timeout;
    }
    if (msg.contains('connection refused') ||
        msg.contains('connection reset') ||
        msg.contains('network is unreachable')) {
      return NetworkErrorCategory.connectionRefused;
    }
    return NetworkErrorCategory.unknown;
  }
}

enum NetworkErrorCategory {
  tlsInterception,
  dnsFailure,
  timeout,
  connectionRefused,
  unknown,
}
