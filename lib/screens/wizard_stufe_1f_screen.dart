import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 1f — Contact: Mobile phone only. The Vorstand reaches out by
/// phone for urgent matters; everything else (Satzung, invoices,
/// meeting reminders) goes through the in-app message channel, so we
/// don't ask for an email address. Phone gets the +49 prefix
/// pre-populated since the vast majority of new members live in
/// Germany; visitors abroad just overwrite it.
class WizardStufe1fScreen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe1fScreen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1fScreen> createState() => _WizardStufe1fScreenState();
}

class _WizardStufe1fScreenState extends State<WizardStufe1fScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _telefon;
  bool _saving = false;

  static final _phoneRegex = RegExp(r"^[+0-9\s\-/()]{5,20}$");

  @override
  void initState() {
    super.initState();
    final initialPhone = widget.initial?['telefon_mobil'] as String?;
    _telefon = TextEditingController(
      text: (initialPhone == null || initialPhone.isEmpty) ? '+49 ' : initialPhone,
    );
  }

  @override
  void dispose() {
    _telefon.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1f, {
      'telefon_mobil': _telefon.text.trim(),
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
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1fTitle),
      prompt: l10n.wizardStufe1fPrompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _telefon,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              keyboardType: TextInputType.phone,
              maxLength: 20,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[+0-9\s\-/()]"),
                ),
              ],
              decoration: _input(
                label: l10n.wizardStufe1fTelefonLabel,
                helper: l10n.wizardStufe1fTelefonHelper,
                prefixIcon: Icons.phone_iphone,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty || v == '+49') return l10n.wizardErrRequired;
                if (!_phoneRegex.hasMatch(v)) {
                  return l10n.wizardErrInvalidPhone;
                }
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
