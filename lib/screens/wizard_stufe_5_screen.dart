import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 5 — Mitgliedschaftsbeginn. Three options for when the
/// membership formally starts:
///
///   • ab_verifizierung — from the moment the Vorstand approves
///                         (default; no retroactive fee).
///   • gruendungsdatum  — backdated to the association's founding
///                         date 2025-08-01.
///   • anderes_datum    — backdated to a custom date the visitor
///                         picks between 2025-08-01 and today.
///
/// The screen also surfaces the retroactive fee preview. For visitors
/// whose Stufe 3 was bürgergeld or sozialamt (`isBeitragsfrei = true`)
/// the preview turns into a green "Fee exempt" hint instead — they
/// would be paying €0 anyway. The retroactive sum is calculated
/// client-side as `months × 25€`, same logic as
/// verifizierung_tab.dart.
class WizardStufe5Screen extends StatefulWidget {
  final Map<String, dynamic>? initial;

  /// True when Stufe 3 resolved to bürgergeld or sozialamt. Passed in
  /// so we can show the right fee preview without re-asking.
  final bool isBeitragsfrei;

  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe5Screen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
    this.isBeitragsfrei = false,
  });

  @override
  State<WizardStufe5Screen> createState() => _WizardStufe5ScreenState();
}

class _WizardStufe5ScreenState extends State<WizardStufe5Screen> {
  static final DateTime _gruendungsdatum = DateTime(2025, 8, 1);
  static const double _monthlyFee = 25.0;
  static const _options = <String>[
    'ab_verifizierung',
    'gruendungsdatum',
    'anderes_datum',
  ];

  String? _option;
  DateTime? _customDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _option = widget.initial?['mitgliedschaftsbeginn_option'];
    final iso = widget.initial?['mitgliedschaftsbeginn_datum'];
    if (iso is String && iso.isNotEmpty) {
      _customDate = DateTime.tryParse(iso);
    }
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final initial = _customDate ?? today;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: _gruendungsdatum,
      lastDate: today,
      helpText: AppLocalizations.of(context)!.wizardStufe5DatePickerHelp,
    );
    if (picked != null && mounted) {
      setState(() => _customDate = picked);
    }
  }

  Future<void> _submit() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (_option == null) {
      _toast(l10n.wizardErrRequired, Colors.red.shade700);
      return;
    }
    if (_option == 'anderes_datum' && _customDate == null) {
      _toast(l10n.wizardStufe5PickDateFirst, Colors.amber.shade800);
      return;
    }

    String? datum;
    if (_option == 'gruendungsdatum') {
      datum = DateFormat('yyyy-MM-dd').format(_gruendungsdatum);
    } else if (_option == 'anderes_datum' && _customDate != null) {
      datum = DateFormat('yyyy-MM-dd').format(_customDate!);
    }

    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe5, {
      'mitgliedschaftsbeginn_option': _option,
      'mitgliedschaftsbeginn_datum': datum ?? '',
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (!ok) {
      _toast(l10n.wizardErrSaveFailed, Colors.red.shade700);
      return;
    }
    widget.onNext();
  }

  void _toast(String text, Color bg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Count months from [start] to [end], inclusive. Mirrors the
  /// formula used in verifizierung_tab.dart::_monthsBetween.
  int _monthsBetween(DateTime start, DateTime end) {
    final months = (end.year - start.year) * 12 + (end.month - start.month);
    return months < 0 ? 0 : months + 1;
  }

  ({String title, String body, IconData icon}) _optionInfo(
    String key,
    AppLocalizations l10n,
  ) =>
      switch (key) {
        'ab_verifizierung' => (
          title: l10n.wizardStufe5OptionAbVerifizierungTitle,
          body: l10n.wizardStufe5OptionAbVerifizierungBody,
          icon: Icons.check_circle_outline,
        ),
        'gruendungsdatum' => (
          title: l10n.wizardStufe5OptionGruendungsdatumTitle,
          body: l10n.wizardStufe5OptionGruendungsdatumBody,
          icon: Icons.history,
        ),
        'anderes_datum' => (
          title: l10n.wizardStufe5OptionAnderesDatumTitle,
          body: l10n.wizardStufe5OptionAnderesDatumBody,
          icon: Icons.date_range,
        ),
        _ => (title: key, body: '', icon: Icons.circle),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(5, 8, l10n.wizardStufe5Title),
      prompt: l10n.wizardStufe5Prompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final key in _options) ...[
            _optionCard(key, l10n),
            const SizedBox(height: 8),
          ],
          if (_option == 'anderes_datum') ...[
            const SizedBox(height: 8),
            _customDatePicker(l10n).animate().fadeIn(duration: 250.ms),
          ],
          if (_shouldShowFeePreview()) ...[
            const SizedBox(height: 14),
            _feePreview(l10n).animate().fadeIn(duration: 250.ms),
          ],
          const SizedBox(height: 16),
          _kuendigungInfo(l10n),
        ],
      ),
    );
  }

  /// Neutral info pill about Satzung §6 Abs. 3: notice has to reach
  /// us by 30 September to take effect on 31 December — no minimum
  /// membership duration but the deadline is what it is. Placed at
  /// the end of Stufe 5 so the start-of-membership decision and the
  /// end-of-membership rule live next to each other.
  Widget _kuendigungInfo(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.shade100.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.lightBlueAccent.shade100.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline,
              color: Colors.lightBlueAccent.shade100, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.wizardStufe5KuendigungInfo,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _shouldShowFeePreview() {
    if (_option == 'gruendungsdatum') return true;
    if (_option == 'anderes_datum' && _customDate != null) return true;
    return false;
  }

  Widget _optionCard(String key, AppLocalizations l10n) {
    final info = _optionInfo(key, l10n);
    final selected = _option == key;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _option = key),
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
              Icon(info.icon,
                  color: Colors.white.withValues(alpha: 0.9), size: 22),
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

  Widget _customDatePicker(AppLocalizations l10n) {
    final formatted = _customDate != null
        ? DateFormat.yMMMMd(Localizations.localeOf(context).toString())
            .format(_customDate!)
        : '';
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today,
                color: Colors.white70, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _customDate != null
                        ? formatted
                        : l10n.wizardStufe5PickDate,
                    style: TextStyle(
                      color: _customDate != null
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.7),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.wizardStufe5DateRange(
                      DateFormat.yMMMd(
                              Localizations.localeOf(context).toString())
                          .format(_gruendungsdatum),
                    ),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white54),
          ],
        ),
      ),
    );
  }

  Widget _feePreview(AppLocalizations l10n) {
    DateTime start;
    if (_option == 'gruendungsdatum') {
      start = _gruendungsdatum;
    } else {
      start = _customDate!;
    }
    final today = DateTime.now();
    final months = _monthsBetween(start, today);
    final retroBeitrag = months * _monthlyFee;
    final localeStr = Localizations.localeOf(context).toString();
    final startStr = DateFormat.yMMMd(localeStr).format(start);
    final todayStr = DateFormat.yMMMd(localeStr).format(today);

    if (widget.isBeitragsfrei) {
      return _hintBox(
        color: Colors.green.shade400,
        icon: Icons.check_circle,
        title: l10n.wizardStufe5FeeExemptTitle,
        body: l10n.wizardStufe5FeeExemptBody,
      );
    }

    return _hintBox(
      color: Colors.amber.shade300,
      icon: Icons.info_outline,
      title: l10n.wizardStufe5RetroactiveTitle,
      body: l10n.wizardStufe5RetroactiveBody(
        startStr,
        todayStr,
        months,
        retroBeitrag.toStringAsFixed(2),
      ),
    );
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
