import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';
import '../utils/app_theme.dart';

/// Stufe 1c — Geschlecht + Familienstand. Two radio lists, no
/// freeform text. We keep the gender options aligned with German
/// §22 PStG (since 2018) — Männlich, Weiblich, Divers, Keine Angabe
/// — and the marital status options to the four canonical buckets
/// associations care about (ledig / verheiratet / geschieden /
/// verwitwet). Anything more nuanced (eingetragene Lebenspartnerschaft
/// etc.) is rare enough to be captured in a follow-up if the Vorstand
/// ever asks.
class WizardStufe1cScreen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe1cScreen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1cScreen> createState() => _WizardStufe1cScreenState();
}

class _WizardStufe1cScreenState extends State<WizardStufe1cScreen> {
  String? _geschlecht;
  String? _familienstand;
  bool _saving = false;

  static const _geschlechtOptions = <String>[
    'maennlich',
    'weiblich',
    'divers',
    'keine_angabe',
  ];
  static const _familienstandOptions = <String>[
    'ledig',
    'verheiratet',
    'geschieden',
    'verwitwet',
  ];

  @override
  void initState() {
    super.initState();
    _geschlecht = widget.initial?['geschlecht'];
    _familienstand = widget.initial?['familienstand'];
  }

  Future<void> _submit() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (_geschlecht == null || _familienstand == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardErrRequired),
          backgroundColor: context.colors.dangerSolid,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1c, {
      'geschlecht': _geschlecht,
      'familienstand': _familienstand,
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardErrSaveFailed),
          backgroundColor: context.colors.dangerSolid,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    widget.onNext();
  }

  String _geschlechtLabel(String key, AppLocalizations l10n) => switch (key) {
        'maennlich'    => l10n.wizardStufe1cGeschlechtMaennlich,
        'weiblich'     => l10n.wizardStufe1cGeschlechtWeiblich,
        'divers'       => l10n.wizardStufe1cGeschlechtDivers,
        'keine_angabe' => l10n.wizardStufe1cGeschlechtKeineAngabe,
        _              => key,
      };

  String _familienstandLabel(String key, AppLocalizations l10n) =>
      switch (key) {
        'ledig'        => l10n.wizardStufe1cFamilienstandLedig,
        'verheiratet'  => l10n.wizardStufe1cFamilienstandVerheiratet,
        'geschieden'   => l10n.wizardStufe1cFamilienstandGeschieden,
        'verwitwet'    => l10n.wizardStufe1cFamilienstandVerwitwet,
        _              => key,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1cTitle),
      prompt: l10n.wizardStufe1cPrompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle(l10n.wizardStufe1cGeschlechtLabel),
          for (final key in _geschlechtOptions)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _radioTile(
                key: key,
                label: _geschlechtLabel(key, l10n),
                selected: _geschlecht == key,
                onTap: () => setState(() => _geschlecht = key),
              ),
            ),
          const SizedBox(height: 18),
          _sectionTitle(l10n.wizardStufe1cFamilienstandLabel),
          for (final key in _familienstandOptions)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _radioTile(
                key: key,
                label: _familienstandLabel(key, l10n),
                selected: _familienstand == key,
                onTap: () => setState(() => _familienstand = key),
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _radioTile({
    required String key,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.white.withValues(alpha: 0.25),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
