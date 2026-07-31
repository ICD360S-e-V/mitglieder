import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

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
      color: wartet ? Colors.orange.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: wartet ? Colors.orange.shade300 : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: wartet ? Colors.orange.shade100 : Colors.grey.shade200,
          child: Icon(
            Icons.draw,
            color: wartet ? Colors.orange.shade800 : Colors.grey.shade600,
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
            color: wartet ? Colors.orange.shade900 : Colors.grey.shade600,
          ),
        ),
        trailing: wartet
            ? Badge(
                label: Text('$offen'),
                backgroundColor: Colors.orange.shade800,
                child: const Icon(Icons.chevron_right),
              )
            : const Icon(Icons.chevron_right),
        onTap: onOeffnen,
      ),
    );
  }
}
