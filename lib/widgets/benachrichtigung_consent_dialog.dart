import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';

/// Fragt das Mitglied, ob der Verein Erinnerungen per SMS schicken darf.
///
/// Zwei getrennte Fragen, und das ist keine Kosmetik: die
/// Medikamenten-Erinnerung nennt den Medikamentennamen in der SMS. Das sind
/// Gesundheitsdaten nach Art. 9 DSGVO und verlangen eine ausdrückliche, auf
/// genau diese Verarbeitung bezogene Zustimmung — mit den Terminen zusammen
/// abgefragt wäre sie unwirksam.
///
/// Der Dialog blockiert nichts. Wer „später" wählt, kommt normal weiter; der
/// Server merkt sich das und fragt frühestens in zwei Wochen wieder, höchstens
/// dreimal insgesamt. Eine erzwungene oder ergnervte Zustimmung wäre keine
/// freiwillige und damit keine gültige.
///
/// Rückgabe: `true`, wenn gespeichert wurde.
class BenachrichtigungConsentDialog extends StatefulWidget {
  final ApiService apiService;

  const BenachrichtigungConsentDialog({super.key, required this.apiService});

  /// Fragt den Server, ob gefragt werden soll, und zeigt den Dialog nur dann.
  /// Fehler werden geschluckt: eine nicht gestellte Frage ist harmlos, ein
  /// Fehlerdialog beim App-Start nicht.
  static Future<void> zeigenFallsNoetig(
    BuildContext context,
    ApiService apiService,
  ) async {
    try {
      final res = await apiService.getBenachrichtigung();
      if (res['success'] != true || res['fragen'] != true) return;
      if (!context.mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => BenachrichtigungConsentDialog(apiService: apiService),
      );
    } catch (_) {
      // Nächster Start fragt wieder.
    }
  }

  @override
  State<BenachrichtigungConsentDialog> createState() =>
      _BenachrichtigungConsentDialogState();
}

class _BenachrichtigungConsentDialogState
    extends State<BenachrichtigungConsentDialog> {
  bool? _termine;
  bool? _medikamente;
  bool _speichert = false;

  bool get _vollstaendig => _termine != null && _medikamente != null;

  Future<void> _speichern() async {
    setState(() => _speichert = true);
    final res = await widget.apiService.saveBenachrichtigung(
      termine: _termine,
      medikamente: _medikamente,
    );
    if (!mounted) return;
    setState(() => _speichert = false);
    final l10n = AppLocalizations.of(context)!;
    Navigator.of(context).pop(res['success'] == true);
    if (res['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.benachrichtigungGespeichert)),
      );
    }
  }

  Future<void> _spaeter() async {
    setState(() => _speichert = true);
    await widget.apiService.benachrichtigungSpaeter();
    if (!mounted) return;
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sms_outlined, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.benachrichtigungTitel,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(l10n.benachrichtigungIntro,
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.45)),
              const SizedBox(height: 20),

              _frage(
                frage: l10n.benachrichtigungTermineFrage,
                detail: l10n.benachrichtigungTermineDetail,
                wert: _termine,
                onAntwort: (v) => setState(() => _termine = v),
                l10n: l10n,
              ),
              const SizedBox(height: 16),
              _frage(
                frage: l10n.benachrichtigungMedikamenteFrage,
                detail: l10n.benachrichtigungMedikamenteDetail,
                wert: _medikamente,
                onAntwort: (v) => setState(() => _medikamente = v),
                l10n: l10n,
              ),

              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  l10n.benachrichtigungHinweis,
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                ),
              ),
              const SizedBox(height: 18),

              Row(
                children: [
                  TextButton(
                    onPressed: _speichert ? null : _spaeter,
                    child: Text(l10n.benachrichtigungSpaeter),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _speichert || !_vollstaendig ? null : _speichern,
                    child: _speichert
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.benachrichtigungSpeichern),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _frage({
    required String frage,
    required String detail,
    required bool? wert,
    required ValueChanged<bool> onAntwort,
    required AppLocalizations l10n,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(frage,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600, height: 1.35)),
        const SizedBox(height: 4),
        Text(detail,
            style: theme.textTheme.bodySmall?.copyWith(height: 1.35)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _antwortKnopf(
                text: l10n.benachrichtigungJa,
                gewaehlt: wert == true,
                farbe: Colors.green,
                onTap: () => onAntwort(true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _antwortKnopf(
                text: l10n.benachrichtigungNein,
                gewaehlt: wert == false,
                farbe: Colors.red,
                onTap: () => onAntwort(false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _antwortKnopf({
    required String text,
    required bool gewaehlt,
    required MaterialColor farbe,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: _speichert ? null : onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: gewaehlt ? farbe.shade600 : null,
        foregroundColor: gewaehlt ? Colors.white : farbe.shade700,
        side: BorderSide(color: farbe.shade300),
      ),
      child: Text(text),
    );
  }
}
