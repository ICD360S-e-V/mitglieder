// Besondere Berechtigungen: kein Laufzeit-Dialog, nur die Systemeinstellungen.
//
// 🔴 WARUM DAS HIER GEMEINSAM STEHT. Es gibt inzwischen ZWEI solche
// Berechtigungen, und beide fallen stumm aus:
//
//   • „Über anderen Apps anzeigen" (SYSTEM_ALERT_WINDOW) — ohne sie erscheint
//     das Anruffenster nicht, `WindowManager.addView` wirft und wir fangen.
//   • „Vollbild-Benachrichtigungen" (USE_FULL_SCREEN_INTENT) — ohne sie
//     erscheint der Klingelschirm über dem Sperrbildschirm nicht, die Meldung
//     wird bloss zur Kopfzeile.
//
// Beide brauchen dieselben fünf Dinge: einen einmaligen Hinweis, einen Weg in
// die Einstellungen, eine dauerhafte Zeile im Konto, ein Nachlesen bei der
// Rückkehr aus der fremden App und einen Satz für den Fehlschlag. Als zweite
// Kopie liefen die beiden auseinander, und eine abweichende Kopie fällt
// niemandem auf — sie fragt nur nicht mehr.
import 'dart:io';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Eine besondere Berechtigung, beschrieben in der Sprache des Mitglieds.
@immutable
class Sonderberechtigung {
  const Sonderberechtigung({
    required this.symbol,
    required this.titel,
    required this.zweck,
    required this.androidHinweis,
    required this.ohneErlaubnis,
    required this.erteiltText,
    required this.nichtErteiltText,
    required this.vonHandText,
    required this.nurAndroidText,
    required this.lesen,
    required this.oeffnen,
  });

  final IconData symbol;
  final String titel;
  final String zweck;
  final String androidHinweis;
  final String ohneErlaubnis;
  final String erteiltText;
  final String nichtErteiltText;

  /// Was zu tun ist, wenn sich der Einstellungs-Bildschirm nicht öffnen liess.
  final String vonHandText;
  final String nurAndroidText;

  /// Ist sie erteilt?
  final Future<bool> Function() lesen;

  /// Öffnet die Systemeinstellung. `false`, wenn kein Weg aufging.
  final Future<bool> Function() oeffnen;
}

/// Fragt einmal nach — und nur, solange die App im Blick ist.
///
/// ⚠️ Ein Dialog, während der Mensch schon in einer anderen App ist, sähe
/// niemand: genau dann liegt unsere App im Hintergrund.
Future<void> sonderberechtigungHinweis(
  BuildContext context,
  Sonderberechtigung b,
) async {
  final l = AppLocalizations.of(context);
  if (l == null) return;
  final erlauben = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(b.titel),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(b.zweck, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 12),
          Text(b.androidHinweis, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 12),
          Text(b.ohneErlaubnis, style: const TextStyle(fontSize: 12)),
        ],
      ),
      actions: [
        // ⚠️ `later` und `fernwartungErlauben` sind BESTEHENDE, in allen 28
        // Sprachen übersetzte Schlüssel. `securityPermissionDialogAllow` sieht
        // gleich aus, ist aber in 23 von 26 Sprachen noch das englische
        // „Allow" — gemessen, nicht vermutet.
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(l.later),
        ),
        FilledButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(l.fernwartungErlauben),
        ),
      ],
    ),
  );
  if (erlauben != true) return;
  final offen = await b.oeffnen();
  // ⚠️ Nach dem Dialog kann der Bildschirm weg sein.
  if (offen || !context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(b.vonHandText)),
  );
}

/// Die dauerhafte Stelle im Konto.
///
/// ⚠️ Ohne sie wäre die Berechtigung nach einem „Später" für immer
/// unerreichbar — ein einmaliger Hinweis ist kein Weg zurück.
class SonderberechtigungZeile extends StatefulWidget {
  const SonderberechtigungZeile({super.key, required this.berechtigung});

  final Sonderberechtigung berechtigung;

  @override
  State<SonderberechtigungZeile> createState() =>
      _SonderberechtigungZeileState();
}

class _SonderberechtigungZeileState extends State<SonderberechtigungZeile>
    with WidgetsBindingObserver {
  bool? _erlaubt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lesen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ⚠️ Der Mensch erteilt die Berechtigung in einer FREMDEN App (den
    // Systemeinstellungen) und kommt dann zurück. Ohne dieses Nachlesen
    // stünde hier weiter „nicht erteilt", obwohl sie gerade gegeben wurde —
    // die Zeile würde also das Gegenteil der Wahrheit behaupten.
    if (state == AppLifecycleState.resumed) _lesen();
  }

  Future<void> _lesen() async {
    final e = await widget.berechtigung.lesen();
    if (mounted) setState(() => _erlaubt = e);
  }

  /// ⚠️ Ein Knopf, der schweigend nichts tut, ist genau die Stille, wegen der
  /// das Fenster monatelang nie erschien. Also wird der Fehlschlag gesagt.
  Future<void> _oeffnen() async {
    final l = AppLocalizations.of(context);
    final offen = await widget.berechtigung.oeffnen();
    if (offen || !mounted || l == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(widget.berechtigung.vonHandText)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    if (l == null) return const SizedBox.shrink();
    final b = widget.berechtigung;

    // ⚠️ Nur Android hat diese Berechtigungen. Auf Linux, macOS und Windows
    // gibt es den Kanal nicht — eine Zeile, die dort „nicht erteilt" sagt,
    // wäre eine erfundene Baustelle.
    if (!Platform.isAndroid) {
      return ListTile(
        leading: Icon(b.symbol, size: 20),
        title: Text(b.titel),
        subtitle: Text(b.nurAndroidText),
      );
    }

    final erlaubt = _erlaubt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(
            erlaubt == null
                ? Icons.hourglass_empty
                : erlaubt
                    ? Icons.check_circle
                    : Icons.error_outline,
            size: 20,
            color: erlaubt == null
                ? null
                : erlaubt
                    ? Colors.green.shade700
                    : Colors.orange.shade800,
          ),
          title: Text(b.titel),
          subtitle: Text(
            erlaubt == null
                // ⚠️ „wird geprüft" ist ein eigener Zustand: `null` heisst
                // „noch nicht gelesen", nicht „nicht erteilt".
                ? l.welcomeLoading
                : erlaubt
                    ? b.erteiltText
                    : b.nichtErteiltText,
          ),
          // ⚠️ Der Knopf bleibt auch bei „erteilt" da: die Berechtigung kann
          // jederzeit wieder entzogen werden, und dann braucht es denselben
          // Weg. Nur die Beschriftung richtet sich nach dem Zustand.
          trailing: TextButton(
            onPressed: _oeffnen,
            child: Text(erlaubt == true ? l.openFile : l.fernwartungErlauben),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(b.zweck,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
        ),
      ],
    );
  }
}
