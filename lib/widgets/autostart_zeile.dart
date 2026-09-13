// Konto ▸ „Beim Anmelden starten" — nur auf dem Rechner.
//
// 🔴 WARUM ES DAS BRAUCHT. Auf Android hält ein Vordergrunddienst die
// Verbindung; auf dem Rechner gibt es keinen. Die App ist EIN Prozess mit EINER
// Verbindung — läuft sie nicht, kommt kein Anruf an, und es klingelt nirgends.
// Das Schliessen des Fensters minimiert schon in den Infobereich; was fehlte,
// war der Start nach dem Anmelden.
//
// ⚠️ VOREINGESTELLT AUS, und nie von selbst umgelegt. Eine App, die sich ohne
// Zutun in den Autostart des Rechners einträgt, ist eine Zumutung — auch wenn
// sie es gut meint.
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/autostart_desktop.dart';

class AutostartZeile extends StatefulWidget {
  const AutostartZeile({super.key});

  @override
  State<AutostartZeile> createState() => _AutostartZeileState();
}

class _AutostartZeileState extends State<AutostartZeile> {
  bool? _an;
  bool _laeuft = false;

  @override
  void initState() {
    super.initState();
    _lesen();
  }

  Future<void> _lesen() async {
    final a = await AutostartDesktop.istAn();
    if (mounted) setState(() => _an = a);
  }

  Future<void> _umlegen(bool gewuenscht) async {
    if (_laeuft) return;
    setState(() => _laeuft = true);
    // ⚠️ Der Schalter springt NICHT vorab um. Er zeigt, was danach wirklich
    // gilt — `setzen` liest den Zustand nach, statt dem Rückgabewert zu
    // glauben. Ein Schalter, der „an" zeigt, während im Register nichts steht,
    // ist die stille Lüge, die dieses Projekt zweimal eingesammelt hat.
    final jetzt = await AutostartDesktop.setzen(gewuenscht);
    if (!mounted) return;
    setState(() {
      _an = jetzt;
      _laeuft = false;
    });
    if (jetzt == gewuenscht) return;
    final l = AppLocalizations.of(context);
    if (l == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.autostartFehlgeschlagen)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    if (l == null) return const SizedBox.shrink();

    // ⚠️ Auf dem Telefon gibt es diesen Schalter nicht — dort hält der
    // Vordergrunddienst die Verbindung. Eine Zeile, die dort etwas anbietet,
    // wäre eine erfundene Baustelle. Und im Flatpak bewirkt er nichts, siehe
    // [AutostartDesktop.imFlatpak].
    if (!AutostartDesktop.verfuegbar) return const SizedBox.shrink();
    if (AutostartDesktop.imFlatpak) {
      return ListTile(
        leading: const Icon(Icons.power_settings_new, size: 20),
        title: Text(l.autostartTitel),
        subtitle: Text(l.autostartFlatpak),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          secondary: Icon(
            Icons.power_settings_new,
            size: 20,
            color: _an == true ? Colors.green.shade700 : null,
          ),
          title: Text(l.autostartTitel),
          // ⚠️ Drei Zustände: `null` heisst „liess sich nicht feststellen",
          // nicht „aus".
          subtitle: Text(_an == null
              ? l.welcomeLoading
              : _an!
                  ? l.autostartAn
                  : l.autostartAus),
          value: _an ?? false,
          onChanged: _laeuft ? null : _umlegen,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(l.autostartZweck,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
        ),
      ],
    );
  }
}
