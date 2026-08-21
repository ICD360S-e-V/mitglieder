import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';
import '../utils/app_theme.dart';

/// Stufe 1a — Identity (Vornamen + Familienname + optional
/// Geburtsname). The labels match the canonical Personalausweis /
/// Reisepass / Aufenthaltstitel wording so a visitor can copy values
/// straight off their document. We collapse "all first names" into a
/// single field so people with hyphen-compounded (Hans-Peter) or
/// space-separated (Maria Anna Sophie) Vornamen don't have to think
/// about which slot to use.
class WizardStufe1aScreen extends StatefulWidget {
  /// Initial values when resuming the draft. Map keys come from
  /// `WizardService.getState()` (`vorname`, `nachname`, `geburtsname`).
  final Map<String, dynamic>? initial;

  /// Called after the step saves successfully so the parent can route
  /// to Stufe 1b.
  final VoidCallback onNext;

  /// Called when the visitor taps Back. Null disables the affordance.
  final VoidCallback? onBack;

  const WizardStufe1aScreen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1aScreen> createState() => _WizardStufe1aScreenState();
}

class _WizardStufe1aScreenState extends State<WizardStufe1aScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _vorname;
  late final TextEditingController _nachname;
  late final TextEditingController _geburtsname;
  bool _saving = false;

  /// Accept letters from every supported locale plus space, hyphen,
  /// apostrophe and dot (Jr. / Sr.). Length is enforced separately so
  /// the regex stays focused on the character class.
  static final _nameRegex = RegExp(r"^[\p{L}\s\-'.]+$", unicode: true);

  @override
  void initState() {
    super.initState();
    _vorname = TextEditingController(text: widget.initial?['vorname'] ?? '');
    _nachname = TextEditingController(text: widget.initial?['nachname'] ?? '');
    _geburtsname =
        TextEditingController(text: widget.initial?['geburtsname'] ?? '');
  }

  @override
  void dispose() {
    _vorname.dispose();
    _nachname.dispose();
    _geburtsname.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1a, {
      'vorname': _vorname.text.trim(),
      'nachname': _nachname.text.trim(),
      'geburtsname': _geburtsname.text.trim(),
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
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1aTitle),
      prompt: l10n.wizardStufe1aPrompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(
              controller: _vorname,
              label: l10n.wizardStufe1aVornameLabel,
              helper: l10n.wizardStufe1aVornameHelper,
              required: true,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            _field(
              controller: _nachname,
              label: l10n.wizardStufe1aNachnameLabel,
              helper: l10n.wizardStufe1aNachnameHelper,
              required: true,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            _field(
              controller: _geburtsname,
              label: l10n.wizardStufe1aGeburtsnameLabel,
              helper: l10n.wizardStufe1aGeburtsnameHelper,
              required: false,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String helper,
    required bool required,
    bool autofocus = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      maxLength: 100,
      decoration: InputDecoration(
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
      ),
      validator: (value) {
        final v = (value ?? '').trim();
        if (v.isEmpty) {
          return required ? l10n.wizardErrRequired : null;
        }
        if (v.length < 2) {
          return l10n.wizardErrTooShort(2);
        }
        if (!_nameRegex.hasMatch(v)) {
          return l10n.wizardErrOnlyLetters;
        }
        return null;
      },
    );
  }
}
