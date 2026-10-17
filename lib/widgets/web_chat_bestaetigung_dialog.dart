import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/web_chat_bestaetigung.dart';

/// Holt eine offene Frage des Vorstands ab und zeigt sie — oder tut nichts.
/// Hintergrund in [WebChatBestaetigung].
///
/// ⚠️ `useRootNavigator`: der Dialog steht über jedem Bildschirm der App,
/// auch wenn das Mitglied gerade im Chat oder bei den Terminen ist — die
/// Frage gilt nur zehn Minuten, und im Website-Chat wartet jemand.
Future<void> webChatBestaetigungPruefen(BuildContext context, {bool sofort = false}) {
  return WebChatBestaetigung.instance.pruefen(
    sofort: sofort,
    zeigen: (anfrage) async {
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (_) => WebChatBestaetigungDialog(anfrage: anfrage),
      );
    },
  );
}

/// „Der Vorstand fragt": drei Zahlen und „Nein, das bin ich nicht".
class WebChatBestaetigungDialog extends StatefulWidget {
  const WebChatBestaetigungDialog({super.key, required this.anfrage});

  final WebChatAnfrage anfrage;

  @override
  State<WebChatBestaetigungDialog> createState() => _WebChatBestaetigungDialogState();
}

class _WebChatBestaetigungDialogState extends State<WebChatBestaetigungDialog> {
  bool _sendet = false;
  WebChatErgebnis? _ergebnis;

  Future<void> _antworten({int? zahl}) async {
    setState(() {
      _sendet = true;
      _ergebnis = null;
    });
    final e = await WebChatBestaetigung.instance.antworten(widget.anfrage, zahl: zahl);
    if (!mounted) return;
    setState(() {
      _sendet = false;
      _ergebnis = e;
    });
  }

  static String _text(AppLocalizations l10n, WebChatErgebnis e) => switch (e) {
        WebChatErgebnis.bestaetigt => l10n.webChatBestaetigt,
        WebChatErgebnis.abgelehnt => l10n.webChatAbgelehnt,
        WebChatErgebnis.falsch => l10n.webChatFalsch,
        WebChatErgebnis.abgelaufen => l10n.webChatAbgelaufen,
        WebChatErgebnis.fehler => l10n.webChatFehler,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final e = _ergebnis;
    // Ein Netzfehler beendet nichts: die Zahlen bleiben, das Mitglied tippt
    // noch einmal. Jedes andere Ergebnis ist das Ende der Frage.
    final fertig = e != null && e != WebChatErgebnis.fehler;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.forum_outlined, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.webChatFrageTitel,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (!fertig)
                    IconButton(
                      key: const ValueKey('webchat-schliessen'),
                      tooltip: l10n.close,
                      icon: const Icon(Icons.close),
                      onPressed: _sendet ? null : () => Navigator.of(context).pop(),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              if (e != null && e != WebChatErgebnis.fehler) ...[
                Text(_text(l10n, e), style: theme.textTheme.bodyLarge?.copyWith(height: 1.4)),
                const SizedBox(height: 18),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: FilledButton(
                    key: const ValueKey('webchat-fertig'),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.close),
                  ),
                ),
              ] else ...[
                Text(l10n.webChatFrageText, style: theme.textTheme.bodyLarge?.copyWith(height: 1.4)),
                const SizedBox(height: 6),
                Text(l10n.webChatFrageZahl, style: theme.textTheme.bodyMedium?.copyWith(height: 1.4)),
                const SizedBox(height: 18),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (final z in widget.anfrage.zahlen)
                      SizedBox(
                        width: 88,
                        height: 64,
                        child: FilledButton.tonal(
                          key: ValueKey('webchat-zahl-$z'),
                          onPressed: _sendet ? null : () => _antworten(zahl: z),
                          child: Text(
                            '$z',
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                TextButton(
                  key: const ValueKey('webchat-nein'),
                  onPressed: _sendet ? null : () => _antworten(),
                  child: Text(l10n.webChatNein, textAlign: TextAlign.center),
                ),
                if (_sendet)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (e == WebChatErgebnis.fehler)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      l10n.webChatFehler,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
