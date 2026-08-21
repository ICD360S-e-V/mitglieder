import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';
import '../utils/app_theme.dart';

/// Stufe 2 — Mitgliedsart. Three option cards mirroring the existing
/// `verifizierung_tab.dart` enum (ordentlich / foerdermitglied /
/// ehrenmitglied). Each card carries title + multi-line description
/// so the visitor knows what each membership type implies before
/// committing.
///
/// Ehrenmitglied is shown but flagged in the description as
/// "Vorstand-awarded only" so a visitor knows they can't actually
/// claim it — the Vorstand can flip the value during Stufe 2 review
/// if the visitor was already granted that honour offline.
class WizardStufe2Screen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe2Screen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe2Screen> createState() => _WizardStufe2ScreenState();
}

class _WizardStufe2ScreenState extends State<WizardStufe2Screen> {
  String? _mitgliedsart;
  bool _saving = false;

  static const _options = <String>[
    'ordentlich',
    'foerdermitglied',
    'ehrenmitglied',
  ];

  @override
  void initState() {
    super.initState();
    _mitgliedsart = widget.initial?['mitgliedsart'];
  }

  Future<void> _submit() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (_mitgliedsart == null) {
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
    final ok = await WizardService().saveStep(WizardStep.stufe2, {
      'mitgliedsart': _mitgliedsart,
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

  ({String title, String body, IconData icon}) _optionInfo(
    String key,
    AppLocalizations l10n,
  ) =>
      switch (key) {
        'ordentlich' => (
          title: l10n.wizardStufe2OrdentlichTitle,
          body: l10n.wizardStufe2OrdentlichBody,
          icon: Icons.workspace_premium_outlined,
        ),
        'foerdermitglied' => (
          title: l10n.wizardStufe2FoerderTitle,
          body: l10n.wizardStufe2FoerderBody,
          icon: Icons.favorite_outline,
        ),
        'ehrenmitglied' => (
          title: l10n.wizardStufe2EhrenTitle,
          body: l10n.wizardStufe2EhrenBody,
          icon: Icons.military_tech_outlined,
        ),
        _ => (title: key, body: '', icon: Icons.circle_outlined),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(2, 8, l10n.wizardStufe2Title),
      prompt: l10n.wizardStufe2Prompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final key in _options) ...[
            _optionCard(key, l10n),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _optionCard(String key, AppLocalizations l10n) {
    final info = _optionInfo(key, l10n);
    final selected = _mitgliedsart == key;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _mitgliedsart = key),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? Colors.white.withValues(alpha: 0.75)
                  : Colors.white.withValues(alpha: 0.25),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: selected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 24,
              ),
              const SizedBox(width: 10),
              Icon(
                info.icon,
                color: Colors.white.withValues(alpha: 0.85),
                size: 26,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight:
                            selected ? FontWeight.w800 : FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      info.body,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
