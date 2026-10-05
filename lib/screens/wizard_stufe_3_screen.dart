import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';
import '../utils/app_theme.dart';
import '../utils/mitglied_felder.dart';

/// Stufe 3 — Finanzielle Situation.
///
/// ⚠️ Seit 05.10.2026 (Vorstand): sechs Gründe für eine Ermäßigung —
/// Bürgergeld, Sozialamt, ALG I, Krankengeld, Rente, Behinderung — oder
/// „nichts davon", dann gilt der volle Beitrag. Eine Ermäßigung gibt es NUR MIT
/// NACHWEIS; die Karte nennt ihn (Rentenbescheid …), hochgeladen wird nichts —
/// er wird gebracht oder geschickt, und der Vorstand prüft und entscheidet.
/// Vorher stand hier „Beitrag: 0 €" als Zusage.
///
/// Unter 18 gibt es keine Auswahl: die Mitgliedschaft ist beitragsfrei, und
/// gespeichert wird 'minderjaehrig' (der Server setzt es ohnehin selbst).
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

  /// Noch nicht 18 (aus dem Geburtsdatum in Stufe 1b) — dann keine Auswahl.
  late final bool _minderjaehrig;

  @override
  void initState() {
    super.initState();
    _minderjaehrig =
        istMinderjaehrigAm(widget.initial?['geburtsdatum'] as String?);
    final gespeichert = widget.initial?['finanzielle_situation'] as String?;
    _situation = _minderjaehrig
        ? finanzielleSituationMinderjaehrig
        : (finanzielleSituationWerte.contains(gespeichert) ? gespeichert : null);
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
        'rente' => (
          title: l10n.wizardStufe3OptionRente,
          icon: Icons.elderly,
          color: Colors.amberAccent,
        ),
        'behinderung' => (
          title: l10n.wizardStufe3OptionBehinderung,
          icon: Icons.accessible,
          color: Colors.cyanAccent,
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
    if (_minderjaehrig) {
      return WizardStepShell(
        stepLabel: l10n.wizardStepLabel(3, 8, l10n.wizardStufe3Title),
        prompt: l10n.minderjaehrigBeitragsfrei,
        onBack: widget.onBack,
        onNext: _submit,
        saving: _saving,
        child: _hintBox(
          color: context.colors.successFg,
          icon: Icons.check_circle,
          title: l10n.finanzMinderjaehrig,
        ),
      );
    }
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
    final nachweis = nachweisFuer(_situation, l10n);
    if (istErmaessigungBeantragt(_situation) && nachweis != null) {
      // Je Grund ein eigener Schlüssel: beim Wechsel zwischen zwei Gründen
      // blendet der Hinweis neu ein und nennt den richtigen Nachweis.
      return Padding(
        key: ValueKey('ermaessigung_$_situation'),
        padding: const EdgeInsets.only(top: 12),
        child: _hintBox(
          color: Colors.lightBlueAccent.shade100,
          icon: Icons.fact_check,
          title: l10n.ermaessigungBeantragtTitel,
          body: l10n.ermaessigungNurMitNachweis(nachweis),
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
    String? body,
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
                if (body != null) ...[
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
