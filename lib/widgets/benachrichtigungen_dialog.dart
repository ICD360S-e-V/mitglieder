import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../utils/app_theme.dart';

/// Der Posteingang hinter der Glocke.
///
/// Vorher stand hier eine fest verdrahtete Begrüßung und ein erfundener
/// Beitragshinweis — für jedes Mitglied dieselben zwei Zeilen, egal was
/// tatsächlich anlag. Jetzt kommen dieselben Erinnerungen an, die auch als SMS
/// rausgehen: wer die App benutzt, sieht sie hier, wer sie nie öffnet, hat die
/// SMS. Niemand bleibt außen vor.
class BenachrichtigungenDialog extends StatefulWidget {
  final ApiService apiService;

  /// Wird nach dem Schließen mit der neuen Anzahl Ungelesener aufgerufen,
  /// damit der Punkt auf der Glocke stimmt.
  final ValueChanged<int>? onUngelesen;

  const BenachrichtigungenDialog({
    super.key,
    required this.apiService,
    this.onUngelesen,
  });

  @override
  State<BenachrichtigungenDialog> createState() => _BenachrichtigungenDialogState();
}

class _BenachrichtigungenDialogState extends State<BenachrichtigungenDialog> {
  bool _laedt = true;
  List<Map<String, dynamic>> _liste = [];
  int _ungelesen = 0;

  @override
  void initState() {
    super.initState();
    _laden();
  }

  Future<void> _laden() async {
    final res = await widget.apiService.getBenachrichtigungen();
    if (!mounted) return;
    setState(() {
      if (res['success'] == true) {
        _liste = (res['benachrichtigungen'] as List? ?? [])
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
        _ungelesen = res['ungelesen'] is int ? res['ungelesen'] : 0;
      }
      _laedt = false;
    });
  }

  Future<void> _alleGelesen() async {
    await widget.apiService.markiereAlleGelesen();
    if (!mounted) return;
    setState(() {
      _liste = _liste
          .map((e) => {...e, 'gelesen_am': e['gelesen_am'] ?? 'jetzt'})
          .toList();
      _ungelesen = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.notifications, color: context.colors.brand),
          const SizedBox(width: 12),
          Expanded(child: Text(l10n.notifications)),
          if (_ungelesen > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: context.colors.dangerSolid,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('$_ungelesen',
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: _laedt
            ? const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              )
            : _liste.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.notifications_none,
                            size: 40, color: context.colors.textDisabled),
                        const SizedBox(height: 10),
                        Text(l10n.benachrichtigungenLeer,
                            style: TextStyle(color: context.colors.textSecondary)),
                      ],
                    ),
                  )
                : ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 420),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _liste.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) => _zeile(_liste[i]),
                    ),
                  ),
      ),
      actions: [
        if (_ungelesen > 0)
          TextButton(
            onPressed: _alleGelesen,
            child: Text(l10n.benachrichtigungenAlleGelesen),
          ),
        TextButton(
          onPressed: () {
            widget.onUngelesen?.call(_ungelesen);
            Navigator.pop(context);
          },
          child: Text(l10n.close),
        ),
      ],
    );
  }

  Widget _zeile(Map<String, dynamic> b) {
    final ungelesen = b['gelesen_am'] == null;
    final typ = b['typ']?.toString() ?? 'info';
    // Vordergrund und Füllung reisen zusammen: ein Theme-Token ist eine
    // einzelne Farbe, aus der sich keine passende Tönung ableiten lässt.
    final (IconData icon, Color farbe, Color fuellung) = switch (typ) {
      'termin' => (Icons.event, context.colors.infoFg, context.colors.infoBg),
      'medikament' => (Icons.medication, Colors.teal, Colors.teal.shade100),
      'wetter' => (Icons.thunderstorm, context.colors.warningFg, context.colors.warningBg),
      _ => (Icons.info, context.colors.textSecondary, context.colors.cardSubtle),
    };

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: fuellung,
        child: Icon(icon, color: farbe, size: 20),
      ),
      title: Text(
        b['titel']?.toString() ?? '',
        style: TextStyle(
          fontSize: 14,
          fontWeight: ungelesen ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(b['text']?.toString() ?? '',
          style: const TextStyle(fontSize: 12)),
      trailing: Text(
        _wann(b['created_at']?.toString()),
        style: TextStyle(fontSize: 11, color: context.colors.textSecondary),
      ),
      onTap: ungelesen
          ? () async {
              final id = b['id'] is int ? b['id'] : int.tryParse('${b['id']}') ?? 0;
              if (id <= 0) return;
              await widget.apiService.markiereGelesen(id);
              if (!mounted) return;
              setState(() {
                b['gelesen_am'] = 'jetzt';
                if (_ungelesen > 0) _ungelesen--;
              });
            }
          : null,
    );
  }

  String _wann(String? iso) {
    final d = DateTime.tryParse(iso ?? '');
    if (d == null) return '';
    final jetzt = DateTime.now();
    final diff = jetzt.difference(d);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    return DateFormat('dd.MM.').format(d.toLocal());
  }
}
