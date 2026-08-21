import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';
import '../utils/app_theme.dart';

/// Stufe 1b — Birthdate + birth place, plus the age gate. The date
/// picker is the gate: as soon as the visitor picks a date and taps
/// Next, the server's `check_age.php` decides what comes next:
///
///   < 16  → tooYoung   → parent navigates to AgeGate screen, the
///                         device gets a SharedPreferences lock until
///                         the visitor would actually turn 16
///   16-17 → minor      → parent advances to Stufe 1b1 (parent hint)
///   ≥ 18  → ok         → parent advances to Stufe 1c
///
/// The screen itself just collects + calls; routing is the parent's
/// job, signalled through [onAdvance].
class WizardStufe1bScreen extends StatefulWidget {
  /// Initial values from the draft (`geburtsdatum`, `geburtsort`).
  final Map<String, dynamic>? initial;

  /// Called once the step saves successfully. The provided status
  /// tells the parent which screen to render next.
  final void Function(
    WizardAgeStatus status, {
    WizardDuplicateAction? duplicateAction,
  }) onAdvance;

  /// Back arrow + Back button handler. Null disables them.
  final VoidCallback? onBack;

  const WizardStufe1bScreen({
    super.key,
    required this.onAdvance,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1bScreen> createState() => _WizardStufe1bScreenState();
}

class _WizardStufe1bScreenState extends State<WizardStufe1bScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _geburtsort;
  DateTime? _date;
  bool _saving = false;

  static final _placeRegex = RegExp(r"^[\p{L}\s\-'.,/]+$", unicode: true);

  @override
  void initState() {
    super.initState();
    _geburtsort =
        TextEditingController(text: widget.initial?['geburtsort'] ?? '');
    final iso = widget.initial?['geburtsdatum'];
    if (iso is String && iso.isNotEmpty) {
      _date = DateTime.tryParse(iso);
    }
  }

  @override
  void dispose() {
    _geburtsort.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    // Sensible default: 25 years ago, since that's the most common
    // member age. Lets first-time pickers skip a lot of swiping.
    final initial = _date ?? DateTime(now.year - 25, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 120),
      lastDate: now,
      helpText: AppLocalizations.of(context)!.wizardStufe1bGeburtsdatumLabel,
    );
    if (picked != null && mounted) {
      setState(() => _date = picked);
    }
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    if (_date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrRequired),
          backgroundColor: context.colors.dangerSolid,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _saving = true);

    // 1) Server age verdict — single source of truth. Also returns
    //    a duplicate flag if a users row already matches this
    //    applicant's name + DOB.
    final ageResult = await WizardService().checkAge(_date!);
    if (!mounted) return;
    if (ageResult == null) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrSaveFailed),
          backgroundColor: context.colors.dangerSolid,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final verdict = ageResult.status;

    // 2) Under-16: device gets locked (already done inside checkAge),
    //    don't persist any further data. Tell the parent to navigate
    //    to the AgeGate screen.
    if (verdict == WizardAgeStatus.tooYoung) {
      setState(() => _saving = false);
      widget.onAdvance(verdict, duplicateAction: null);
      return;
    }

    // 3) Persist 1b first — that way a duplicate-action visitor whose
    //    record we want to surface to the Vorstand still has an audit
    //    trail of having reached this screen.
    final iso = '${_date!.year.toString().padLeft(4, '0')}-'
        '${_date!.month.toString().padLeft(2, '0')}-'
        '${_date!.day.toString().padLeft(2, '0')}';
    final ok = await WizardService().saveStep(WizardStep.stufe1b, {
      'geburtsdatum': iso,
      'geburtsort': _geburtsort.text.trim(),
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrSaveFailed),
          backgroundColor: context.colors.dangerSolid,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    widget.onAdvance(verdict, duplicateAction: ageResult.duplicateAction);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1bTitle),
      prompt: l10n.wizardStufe1bPrompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _dateField(l10n),
            const SizedBox(height: 16),
            TextFormField(
              controller: _geburtsort,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 100,
              textCapitalization: TextCapitalization.words,
              decoration: _inputDecoration(
                label: l10n.wizardStufe1bGeburtsortLabel,
                helper: l10n.wizardStufe1bGeburtsortHelper,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return l10n.wizardErrRequired;
                if (v.length < 2) return l10n.wizardErrTooShort(2);
                if (!_placeRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField(AppLocalizations l10n) {
    final formatted = _date != null
        ? DateFormat.yMMMMd(Localizations.localeOf(context).toString())
            .format(_date!)
        : '';
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: _inputDecoration(
          label: l10n.wizardStufe1bGeburtsdatumLabel,
          helper: l10n.wizardStufe1bGeburtsdatumHelper,
        ).copyWith(
          prefixIcon: const Icon(Icons.cake, color: Colors.white70),
          suffixIcon: const Icon(Icons.calendar_today, color: Colors.white70),
        ),
        isEmpty: _date == null,
        child: Text(
          formatted,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String helper,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
      helperText: helper,
      helperMaxLines: 3,
      helperStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 11.5,
      ),
      counterStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.dangerBorder),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.dangerBorder, width: 2),
      ),
      errorStyle: TextStyle(color: context.colors.onDarkDanger),
    );
  }
}
