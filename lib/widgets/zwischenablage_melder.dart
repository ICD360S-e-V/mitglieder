import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/sicher_clipboard.dart';

/// Zeigt, dass die Zwischenablage gelöscht wurde — „Zwischenablage gelöscht",
/// oder mit der Uhrzeit, wenn die App in dem Augenblick im Hintergrund war
/// (Android sagt es dann beim Zurückkommen).
///
/// Sitzt in `MaterialApp.builder` (main.dart): darüber liegen der
/// ScaffoldMessenger von MaterialApp und die Übersetzungen. Ein Test hält das
/// fest.
class ZwischenablageMelder extends StatefulWidget {
  const ZwischenablageMelder({super.key, required this.child});

  final Widget child;

  @override
  State<ZwischenablageMelder> createState() => _ZwischenablageMelderState();
}

class _ZwischenablageMelderState extends State<ZwischenablageMelder> {
  @override
  void initState() {
    super.initState();
    SicherClipboard.melderSetzen(_zeigen);
  }

  @override
  void dispose() {
    SicherClipboard.melderLoesen(_zeigen);
    super.dispose();
  }

  void _zeigen(DateTime zeit, {required bool spaet}) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;
    final text = spaet
        ? l10n.zwischenablageGeloeschtUm(
            MaterialLocalizations.of(context).formatTimeOfDay(
              TimeOfDay.fromDateTime(zeit),
              alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
            ),
          )
        : l10n.zwischenablageGeloescht;
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
      content: _Geloescht(text),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _Geloescht extends StatelessWidget {
  const _Geloescht(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    // In der Farbe des Textes der SnackBar: passt zu Hell und Dunkel.
    final farbe = DefaultTextStyle.of(context).style.color ??
        Theme.of(context).colorScheme.onInverseSurface;
    return Row(
      children: [
        Icon(Icons.content_paste_off, size: 18, color: farbe),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }
}
