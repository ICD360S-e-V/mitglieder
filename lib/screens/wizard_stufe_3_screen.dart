import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';
import '../utils/app_theme.dart';
import '../utils/mitglied_felder.dart';

/// Stufe 3 — Finanzielle Situation. Five radio options covering every
/// fee-exempt social benefit the Vorstand accepts under Satzung §6
/// Abs. 4 ("Ermäßigung, Stundung oder Erlass möglich"): Bürgergeld,
/// Sozialamt, ALG I, Krankengeld — or none, then the regular fee applies.
///
/// ⚠️ Kein Hochladen mehr (Entscheidung des Vorstands, 05.10.2026): Ein
/// Bescheid wird nicht beim Antrag verlangt. Braucht der Vorstand einen —
/// für Jobcenter, Rente, Arbeitsagentur … —, fordert er ihn selbst an.
/// Genauso im Online-Formular und in der Verifizierung des Vorstandspanels.
class WizardStufe3Screen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe3Screen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe3Screen> createState() => _WizardStufe3ScreenState();
}

class _WizardStufe3ScreenState extends State<WizardStufe3Screen> {
  String? _situation;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final gespeichert = widget.initial?['finanzielle_situation'] as String?;
    _situation =
        finanzielleSituationWerte.contains(gespeichert) ? gespeichert : null;
  }

  Future<void> _submit() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (_situation == null) {
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
    final ok = await WizardService().saveStep(WizardStep.stufe3, {
      'finanzielle_situation': _situation,
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

  ({String title, IconData icon, Color color}) _optionInfo(
    String key,
    AppLocalizations l10n,
  ) =>
      switch (key) {
        'buergergeld' => (
          title: l10n.wizardStufe3OptionBuergergeld,
          icon: Icons.account_balance,
          color: context.colors.warningFg,
        ),
        'sozialamt' => (
          title: l10n.wizardStufe3OptionSozialamt,
          icon: Icons.health_and_safety,
          color: Colors.lightBlueAccent,
        ),
        'alg1' => (
          title: l10n.wizardStufe3OptionAlg1,
          icon: Icons.business_center,
          color: Colors.deepOrangeAccent,
        ),
        'krankengeld' => (
          title: l10n.wizardStufe3OptionKrankengeld,
          icon: Icons.medical_services,
          color: Colors.pinkAccent,
        ),
        'nein' => (
          title: l10n.wizardStufe3OptionNein,
          icon: Icons.work_outline,
          color: Colors.greenAccent,
        ),
        _ => (title: key, icon: Icons.circle, color: Colors.white),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(3, 8, l10n.wizardStufe3Title),
      prompt: l10n.wizardStufe3Prompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final key in finanzielleSituationWerte) ...[
            _optionTile(key, l10n),
            const SizedBox(height: 8),
          ],
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _conditionalBlock(l10n),
          ),
        ],
      ),
    );
  }

  Widget _optionTile(String key, AppLocalizations l10n) {
    final info = _optionInfo(key, l10n);
    final selected = _situation == key;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _situation = key),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? Colors.white.withValues(alpha: 0.75)
                  : Colors.white.withValues(alpha: 0.25),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: selected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 22,
              ),
              const SizedBox(width: 10),
              Icon(info.icon, color: info.color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  info.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight:
                        selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _conditionalBlock(AppLocalizations l10n) {
    if (istBeitragsfrei(_situation)) {
      return Padding(
        key: const ValueKey('beitragsfrei'),
        padding: const EdgeInsets.only(top: 12),
        child: _hintBox(
          color: context.colors.successFg,
          icon: Icons.check_circle,
          title: l10n.wizardStufe3FeeExemptTitle,
          body: l10n.wizardStufe3FeeExemptBodyOhneNachweis,
        ),
      ).animate().fadeIn(duration: 250.ms);
    }
    if (_situation == 'nein') {
      return Padding(
        key: const ValueKey('regularFee'),
        padding: const EdgeInsets.only(top: 12),
        child: _hintBox(
          color: Colors.lightBlueAccent.shade100,
          icon: Icons.euro,
          title: l10n.wizardStufe3RegularFeeTitle,
          body: l10n.wizardStufe3RegularFeeBody,
        ),
      ).animate().fadeIn(duration: 250.ms);
    }
    return const SizedBox.shrink(key: ValueKey('empty'));
  }

  Widget _hintBox({
    required Color color,
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
