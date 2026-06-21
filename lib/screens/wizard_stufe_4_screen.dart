import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 4 — Payment method + payment day.
///
/// Three radio options for `users.zahlungsmethode` (ueberweisung /
/// sepa_lastschrift / dauerauftrag) and a dropdown of 1-31 for
/// `users.zahlungstag`. The screen is skipped by the wizard
/// orchestrator when Stufe 3's finanzielle_situation is bürgergeld
/// or sozialamt — those visitors are fully fee-exempt under the
/// Satzung so there's nothing to pay.
class WizardStufe4Screen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe4Screen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe4Screen> createState() => _WizardStufe4ScreenState();
}

class _WizardStufe4ScreenState extends State<WizardStufe4Screen> {
  String? _method;
  int? _day;
  bool _saving = false;

  static const _methods = <String>[
    'ueberweisung',
    'sepa_lastschrift',
    'dauerauftrag',
  ];

  @override
  void initState() {
    super.initState();
    _method = widget.initial?['zahlungsmethode'];
    final rawDay = widget.initial?['zahlungstag'];
    if (rawDay is int) {
      _day = rawDay;
    } else if (rawDay is String) {
      _day = int.tryParse(rawDay);
    }
  }

  Future<void> _submit() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (_method == null || _day == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardErrRequired),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe4, {
      'zahlungsmethode': _method,
      'zahlungstag': _day,
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardErrSaveFailed),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    widget.onNext();
  }

  ({String title, String body, IconData icon}) _methodInfo(
    String key,
    AppLocalizations l10n,
  ) =>
      switch (key) {
        'ueberweisung' => (
          title: l10n.wizardStufe4MethodUeberweisungTitle,
          body: l10n.wizardStufe4MethodUeberweisungBody,
          icon: Icons.swap_horiz,
        ),
        'sepa_lastschrift' => (
          title: l10n.wizardStufe4MethodSepaTitle,
          body: l10n.wizardStufe4MethodSepaBody,
          icon: Icons.account_balance,
        ),
        'dauerauftrag' => (
          title: l10n.wizardStufe4MethodDauerauftragTitle,
          body: l10n.wizardStufe4MethodDauerauftragBody,
          icon: Icons.repeat,
        ),
        _ => (title: key, body: '', icon: Icons.payment),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(4, 8, l10n.wizardStufe4Title),
      prompt: l10n.wizardStufe4Prompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final key in _methods) ...[
            _methodCard(key, l10n),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 12),
          Text(
            l10n.wizardStufe4DayLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          _dayDropdown(l10n),
          if (_day != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline,
                    size: 16,
                    color: Colors.lightBlueAccent.shade100),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    l10n.wizardStufe4DayReminder(_day!),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _methodCard(String key, AppLocalizations l10n) {
    final info = _methodInfo(key, l10n);
    final selected = _method == key;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _method = key),
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
                size: 22,
              ),
              const SizedBox(width: 10),
              Icon(info.icon, color: Colors.white.withValues(alpha: 0.9), size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
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

  Widget _dayDropdown(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _day,
          isExpanded: true,
          dropdownColor: const Color(0xFF1565c0),
          iconEnabledColor: Colors.white,
          hint: Text(
            l10n.wizardStufe4DayHint,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 15),
          items: List.generate(31, (i) => i + 1)
              .map(
                (d) => DropdownMenuItem<int>(
                  value: d,
                  child: Text(l10n.wizardStufe4DayItem(d)),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => _day = v),
        ),
      ),
    );
  }
}
