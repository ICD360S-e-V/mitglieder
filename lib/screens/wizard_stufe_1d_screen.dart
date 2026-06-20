import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/language_service.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 1d — Staatsangehörigkeit + Aufenthaltsstatus + Muttersprache.
/// All three help us route the right kind of support to the visitor:
/// citizenship + residence status surface refugee / Aufenthaltstitel
/// scenarios, while mother tongue lets us connect them with the right
/// language buddy.
///
/// Defaults follow the schema: Staatsangehörigkeit pre-fills with
/// "deutsch" (the most common case for new sign-ups today), and
/// Muttersprache pre-fills with whatever language they picked in the
/// language selector on app launch (LanguageService.currentCode).
class WizardStufe1dScreen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe1dScreen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1dScreen> createState() => _WizardStufe1dScreenState();
}

class _WizardStufe1dScreenState extends State<WizardStufe1dScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _staatsangehoerigkeit;
  late final TextEditingController _aufenthaltsstatus;
  late final TextEditingController _muttersprache;
  bool _saving = false;

  static final _wordRegex = RegExp(r"^[\p{L}\s\-'.,/()]+$", unicode: true);

  @override
  void initState() {
    super.initState();
    _staatsangehoerigkeit = TextEditingController(
      text: widget.initial?['staatsangehoerigkeit'] ?? 'deutsch',
    );
    _aufenthaltsstatus = TextEditingController(
      text: widget.initial?['aufenthaltsstatus'] ?? '',
    );
    // Best-effort default: visitor's selected app language. Better
    // than blank for the 80% case where the choice matches reality.
    _muttersprache = TextEditingController(
      text: widget.initial?['muttersprache'] ??
          LanguageService.instance.currentCode,
    );
  }

  @override
  void dispose() {
    _staatsangehoerigkeit.dispose();
    _aufenthaltsstatus.dispose();
    _muttersprache.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1d, {
      'staatsangehoerigkeit': _staatsangehoerigkeit.text.trim(),
      'aufenthaltsstatus': _aufenthaltsstatus.text.trim(),
      'muttersprache': _muttersprache.text.trim(),
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrSaveFailed),
          backgroundColor: Colors.red.shade700,
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
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1dTitle),
      prompt: l10n.wizardStufe1dPrompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _staatsangehoerigkeit,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 100,
              textCapitalization: TextCapitalization.sentences,
              decoration: _input(
                label: l10n.wizardStufe1dStaatLabel,
                helper: l10n.wizardStufe1dStaatHelper,
                prefixIcon: Icons.flag_outlined,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return l10n.wizardErrRequired;
                if (v.length < 2) return l10n.wizardErrTooShort(2);
                if (!_wordRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _aufenthaltsstatus,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 100,
              textCapitalization: TextCapitalization.sentences,
              decoration: _input(
                label: l10n.wizardStufe1dAufenthaltLabel,
                helper: l10n.wizardStufe1dAufenthaltHelper,
                prefixIcon: Icons.badge_outlined,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return null; // optional
                if (v.length < 2) return l10n.wizardErrTooShort(2);
                if (!_wordRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _muttersprache,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 50,
              textCapitalization: TextCapitalization.words,
              decoration: _input(
                label: l10n.wizardStufe1dMutterspracheLabel,
                helper: l10n.wizardStufe1dMutterspracheHelper,
                prefixIcon: Icons.translate,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return l10n.wizardErrRequired;
                if (v.length < 2) return l10n.wizardErrTooShort(2);
                if (!_wordRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _input({
    required String label,
    required String helper,
    IconData? prefixIcon,
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
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.white.withValues(alpha: 0.7))
          : null,
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
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      errorStyle: TextStyle(color: Colors.red.shade200),
    );
  }
}
