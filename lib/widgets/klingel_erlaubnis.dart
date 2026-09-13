// Die Berechtigung „Vollbild-Benachrichtigungen" (USE_FULL_SCREEN_INTENT) —
// ohne sie erscheint der Klingelschirm über dem Sperrbildschirm nicht.
//
// 🔴 SIE KANN FEHLEN, OBWOHL SIE IM MANIFEST STEHT. Bis Android 13 wird sie
// bei der Installation erteilt und es gibt nichts zu prüfen. Ab Android 14
// entzieht der Play Store sie bei der Installation jeder App, die er nicht als
// Telefonie- oder Weckerapp einordnet (durchgesetzt seit 22.01.2025) — diese
// App hat eine `googleplay`-Variante. Auf F-Droid und bei Seitenladung bleibt
// sie erteilt. Also: auf manchen Tablets erscheint der Klingelschirm, auf
// anderen nicht, und zwar SCHWEIGEND.
//
// ⚠️ Sie ist NIE Bedingung dafür, einen Anruf annehmen zu können. Fehlt sie,
// bleibt die Meldung mit „Annehmen" und „Ablehnen" — der Anruf ist weiter
// annehmbar, nur nicht über den ganzen Bildschirm. Genau deshalb gibt es
// beide Wege.
import 'package:flutter/material.dart';
import 'package:icd_klingel/icd_klingel.dart';

import '../l10n/app_localizations.dart';
import 'sonderberechtigung.dart';

Sonderberechtigung? _klingel(BuildContext context) {
  final l = AppLocalizations.of(context);
  if (l == null) return null;
  return Sonderberechtigung(
    symbol: Icons.ring_volume,
    titel: l.klingelTitel,
    zweck: l.klingelZweck,
    androidHinweis: l.klingelAndroidHinweis,
    ohneErlaubnis: l.klingelOhneErlaubnis,
    erteiltText: l.klingelErteilt,
    nichtErteiltText: l.klingelNichtErteilt,
    vonHandText: l.klingelVonHand,
    nurAndroidText: l.klingelNurAndroid,
    lesen: IcdKlingel.erlaubt,
    oeffnen: IcdKlingel.einstellungOeffnen,
  );
}

/// Fragt einmal nach.
Future<void> klingelHinweisZeigen(BuildContext context) async {
  final b = _klingel(context);
  if (b == null) return;
  await sonderberechtigungHinweis(context, b);
}

/// Die dauerhafte Stelle: Konto ▸ Anruf auf dem Sperrbildschirm.
class KlingelErlaubnis extends StatelessWidget {
  const KlingelErlaubnis({super.key});

  @override
  Widget build(BuildContext context) {
    final b = _klingel(context);
    if (b == null) return const SizedBox.shrink();
    return SonderberechtigungZeile(berechtigung: b);
  }
}
