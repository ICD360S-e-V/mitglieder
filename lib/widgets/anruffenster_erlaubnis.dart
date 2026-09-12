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
// ⚠️ Unterschied zur Vorsitzer-App: hier ist jeder Text ÜBERSETZT. Diese App
// wird in 28 Sprachen ausgeliefert, und ein deutscher Satz vor einem Mitglied,
// das die App auf Arabisch bedient, ist kein Hinweis, sondern ein Rätsel.
//
// ⚠️ Die Berechtigung ist NIE Bedingung für einen Anruf. Fehlt sie, fehlt nur
// dieses Fenster — telefonieren, auflegen und die Dauerbenachrichtigung
// funktionieren unverändert.
import 'dart:io';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/anruf_vordergrund.dart';

/// Fragt einmal nach — und nur, solange die App im Blick ist.
///
/// ⚠️ Ein Dialog, während der Mensch schon in einer anderen App ist, sähe
/// niemand: genau dann liegt unsere App im Hintergrund. Deshalb ruft
/// [AnrufSystemkarte] diesen Hinweis beim BEGINN des Gesprächs.
Future<void> anruffensterHinweisZeigen(BuildContext context) async {
  final l = AppLocalizations.of(context);
  if (l == null) return;
  final erlauben = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l.anruffensterTitel),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.anruffensterZweck, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 12),
          Text(l.anruffensterAndroidHinweis,
              style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 12),
          Text(l.anruffensterOhneErlaubnis,
              style: const TextStyle(fontSize: 12)),
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
  final offen = await AnrufVordergrund.systemfensterEinstellung();
  // ⚠️ Nach dem Dialog kann der Bildschirm weg sein.
  if (offen || !context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(l.anruffensterVonHand)),
  );
}

/// Die dauerhafte Stelle: Konto ▸ Anruffenster.
///
/// ⚠️ Ohne sie wäre die Berechtigung nach einem „Später" für immer
/// unerreichbar — ein einmaliger Hinweis ist kein Weg zurück.
class AnruffensterErlaubnis extends StatefulWidget {
  const AnruffensterErlaubnis({super.key});

  @override
  State<AnruffensterErlaubnis> createState() => _AnruffensterErlaubnisState();
}

class _AnruffensterErlaubnisState extends State<AnruffensterErlaubnis>
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
    final e = await AnrufVordergrund.systemfensterErlaubt();
    if (mounted) setState(() => _erlaubt = e);
  }

  /// ⚠️ Ein Knopf, der schweigend nichts tut, ist genau die Stille, wegen der
  /// das Fenster monatelang nie erschien. Also wird der Fehlschlag gesagt.
  Future<void> _oeffnen() async {
    final l = AppLocalizations.of(context);
    final offen = await AnrufVordergrund.systemfensterEinstellung();
    if (offen || !mounted || l == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.anruffensterVonHand)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    if (l == null) return const SizedBox.shrink();

    // ⚠️ Nur Android hat diese Berechtigung. Auf Linux, macOS und Windows
    // gibt es den Kanal nicht — eine Zeile, die dort „nicht erteilt" sagt,
    // wäre eine erfundene Baustelle.
    if (!Platform.isAndroid) {
      return ListTile(
        leading: const Icon(Icons.picture_in_picture_alt, size: 20),
        title: Text(l.anruffensterTitel),
        subtitle: Text(l.anruffensterNurAndroid),
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
          title: Text(l.anruffensterTitel),
          subtitle: Text(
            erlaubt == null
                // ⚠️ „wird geprüft" ist ein eigener Zustand: `null` heisst
                // „noch nicht gelesen", nicht „nicht erteilt".
                ? l.welcomeLoading
                : erlaubt
                    ? l.anruffensterErteilt
                    : l.anruffensterNichtErteilt,
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
          child: Text(l.anruffensterZweck,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
        ),
      ],
    );
  }
}
