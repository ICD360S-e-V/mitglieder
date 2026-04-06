import 'dart:async';
import 'dart:io';
import '../l10n/app_localizations.dart';
import '../services/logger_service.dart';

/// Converts raw exceptions to user-friendly localized error messages.
/// Technical details are logged via LoggerService for debugging.
String getUserFriendlyError(AppLocalizations l10n, Object error, {String? tag}) {
  // Log technical details for debugging
  LoggerService().error('$error', tag: tag ?? 'ERROR');

  if (error is SocketException) {
    return l10n.errorNoInternet;
  } else if (error is TimeoutException) {
    return l10n.errorTimeout;
  } else if (error is HttpException) {
    return l10n.errorServer;
  } else if (error is FormatException) {
    return l10n.errorServer;
  } else if (error is HandshakeException || error is TlsException) {
    return l10n.errorConnection;
  } else {
    final msg = error.toString().toLowerCase();
    if (msg.contains('socketexception') || msg.contains('no route') || msg.contains('network is unreachable')) {
      return l10n.errorNoInternet;
    } else if (msg.contains('timeout') || msg.contains('timed out')) {
      return l10n.errorTimeout;
    } else if (msg.contains('connection refused') || msg.contains('connection reset')) {
      return l10n.errorServer;
    } else if (msg.contains('certificate') || msg.contains('handshake')) {
      return l10n.errorConnection;
    }
    return l10n.errorUnexpected;
  }
}
