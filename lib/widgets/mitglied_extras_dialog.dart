import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// Was ein Mitglied kann und ein Besucher nicht.
///
/// Hinter dem Stern in der Leiste. Bewusst eine eigene Fläche und keine
/// weitere Schaltfläche oben: die Leiste war mit sechs Zielen schon am Rand
/// dessen, was auf ein 320 dp breites Telefon passt, und jedes Werkzeug, das
/// hier dazukommt, hätte sie endgültig gesprengt.
///
/// Der Untertitel sagt, was die Liste ist, statt nur zu schmücken. Ein Mitglied,
/// das den Stern zum ersten Mal antippt, soll nicht raten müssen, warum diese
/// Dinge zusammen in einem Fenster stehen.
class MitgliedExtrasDialog extends StatelessWidget {
  /// Öffnet das Werkzeug „eigenes PDF unterschreiben".
  final VoidCallback onPdfUnterschreiben;

  const MitgliedExtrasDialog({
    super.key,
    required this.onPdfUnterschreiben,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        // Ohne Obergrenze zieht sich der Dialog auf einem Tablet über die
        // ganze Breite, und eine Liste aus zwei Zeilen steht dann verloren in
        // einer Fläche, die für ein Dokument gedacht wäre.
        constraints: const BoxConstraints(maxWidth: 420),
        // Scrollbar, nicht nur „passt normalerweise".
        //
        // Bei der größten Systemschrift wächst allein die Zeile unter dem
        // Werkzeugnamen auf ein Vielfaches; im Test lief der Inhalt um 1411
        // Pixel über den unteren Rand hinaus. Wer diese Schriftgröße
        // eingestellt hat, braucht sie — ihm das Fenster abzuschneiden wäre
        // genau die Gruppe, die es am wenigsten verkraftet.
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 8),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: context.colors.brandFill),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.extrasTitel,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.extrasUntertitel,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: context.colors.divider),
              _Werkzeug(
                symbol: Icons.draw_outlined,
                titel: l10n.extrasPdfUnterschreibenTitel,
                text: l10n.extrasPdfUnterschreibenText,
                // Erst schließen, dann öffnen. Andersherum schöbe sich der neue
                // Bildschirm unter den Dialog, und das `Navigator.pop` danach
                // träfe ihn statt des Dialogs.
                onDruck: () {
                  Navigator.pop(context);
                  onPdfUnterschreiben();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _Werkzeug extends StatelessWidget {
  final IconData symbol;
  final String titel;
  final String text;
  final VoidCallback onDruck;

  const _Werkzeug({
    required this.symbol,
    required this.titel,
    required this.text,
    required this.onDruck,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: context.colors.dividerSubtle,
        child: Icon(symbol, color: context.colors.brandFill),
      ),
      title: Text(
        titel,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: context.colors.textPrimary,
        ),
      ),
      subtitle: Text(
        text,
        style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onDruck,
    );
  }
}
