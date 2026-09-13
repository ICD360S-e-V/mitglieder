// Die Berechtigung „Über anderen Apps anzeigen" — der eine Schalter, ohne den
// das Anruffenster nie erscheint.
//
// 🔴 PORTIERT aus der Vorsitzer-App (PR #707) am 12.09.2026, weil der
// gemeldete Fall genau dieser war: „membru intră pe browser". Ohne die
// Berechtigung wirft `WindowManager.addView` eine `BadTokenException`, die
// native Seite fängt sie ab, und der Anruf läuft weiter — kein Absturz, keine
// Meldung, kein Fenster. Sie ist eine BESONDERE Berechtigung: kein
// Laufzeit-Dialog, nur die Systemeinstellungen.
//
// ⚠️ Der Aufbau steht seit dem 13.09.2026 in [Sonderberechtigung] — es gibt
// inzwischen eine ZWEITE solche Berechtigung (Vollbild-Benachrichtigungen für
// den Klingelschirm), und zwei Kopien desselben Ablaufs liefen auseinander,
// ohne dass etwas fehlschlägt. Hier bleiben nur die Texte und die zwei Wege
// in die native Seite.
//
// ⚠️ Die Berechtigung ist NIE Bedingung für einen Anruf. Fehlt sie, fehlt nur
// dieses Fenster — telefonieren, auflegen und die Dauerbenachrichtigung
// funktionieren unverändert.
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/anruf_vordergrund.dart';
import 'sonderberechtigung.dart';

Sonderberechtigung? _anruffenster(BuildContext context) {
  final l = AppLocalizations.of(context);
  if (l == null) return null;
  return Sonderberechtigung(
    symbol: Icons.picture_in_picture_alt,
    titel: l.anruffensterTitel,
    zweck: l.anruffensterZweck,
    androidHinweis: l.anruffensterAndroidHinweis,
    ohneErlaubnis: l.anruffensterOhneErlaubnis,
    erteiltText: l.anruffensterErteilt,
    nichtErteiltText: l.anruffensterNichtErteilt,
    vonHandText: l.anruffensterVonHand,
    nurAndroidText: l.anruffensterNurAndroid,
    lesen: AnrufVordergrund.systemfensterErlaubt,
    oeffnen: AnrufVordergrund.systemfensterEinstellung,
  );
}

/// Fragt einmal nach — und nur, solange die App im Blick ist.
///
/// ⚠️ Gerufen von [AnrufSystemkarte] beim BEGINN des Gesprächs, nicht erst
/// wenn das Fenster fällig wäre: dann steckt der Mensch schon im Browser.
Future<void> anruffensterHinweisZeigen(BuildContext context) async {
  final b = _anruffenster(context);
  if (b == null) return;
  await sonderberechtigungHinweis(context, b);
}

/// Die dauerhafte Stelle: Konto ▸ Anruffenster.
class AnruffensterErlaubnis extends StatelessWidget {
  const AnruffensterErlaubnis({super.key});

  @override
  Widget build(BuildContext context) {
    final b = _anruffenster(context);
    if (b == null) return const SizedBox.shrink();
    return SonderberechtigungZeile(berechtigung: b);
  }
}
