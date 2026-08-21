import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// Der Einstieg zu den Unterschriften auf der Übersichtsseite.
///
/// Liegt etwas zur Unterschrift, wird die Karte auffällig — eine Frist läuft,
/// und wer sie übersieht, verliert nicht nur Zeit. Liegt nichts an, bleibt sie
/// eine ruhige Zeile: eine Dauerwarnung, die immer leuchtet, sieht man nach
/// zwei Wochen nicht mehr.
class SignaturCard extends StatelessWidget {
  final int offen;
  final VoidCallback onOeffnen;

  const SignaturCard({
    super.key,
    required this.offen,
    required this.onOeffnen,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final wartet = offen > 0;

    return Card(
      elevation: wartet ? 3 : 1,
      color: wartet ? context.colors.warningBg : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: wartet ? context.colors.warningBorder : context.colors.divider,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: wartet ? context.colors.warningBg : context.colors.dividerSubtle,
          child: Icon(
            Icons.draw,
            color: wartet ? context.colors.warningFg : context.colors.textSecondary,
          ),
        ),
        title: Text(
          l10n.signaturTitel,
          style: TextStyle(
            fontWeight: wartet ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        subtitle: Text(
          wartet ? l10n.signaturStatusOffen : l10n.signaturNichtsOffen,
          style: TextStyle(
            fontSize: 12,
            color: wartet ? context.colors.warningFg : context.colors.textSecondary,
          ),
        ),
        trailing: wartet
            ? Badge(
                label: Text('$offen'),
                backgroundColor: context.colors.warningSolid,
                // Ohne textColor nimmt Badge colorScheme.onError. Das ist im
                // hellen Theme weiß und im dunklen ein tiefes Rot — die Zahl
                // wechselte also die Farbe, ohne dass es jemand so gemeint
                // hätte. Auf einer Statusfläche gilt onSolid, in beiden Themes.
                textColor: context.colors.onSolid,
                child: const Icon(Icons.chevron_right),
              )
            : const Icon(Icons.chevron_right),
        onTap: onOeffnen,
      ),
    );
  }
}
