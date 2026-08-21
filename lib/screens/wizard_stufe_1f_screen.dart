import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';
import '../utils/app_theme.dart';

/// Stufe 1f — Contact: Mobile phone (required) + Email (auto-derived).
/// The Vorstand reaches out by phone for urgent matters and uses the
/// in-app end-to-end encrypted channel for everything else. The email
/// is **not** typed by the visitor — every member gets a managed
/// `<mitgliedernummer>@icd360s.de` mailbox provisioned the moment the
/// Vorstand validates the application. We display it read-only here so
/// the visitor knows what their member email will be. Phone gets the
/// +49 prefix pre-populated since the vast majority of new members live
/// in Germany; visitors abroad just overwrite it.
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

  /// Auto-derived from the mitgliedernummer reserved at Stufe 1b.
  /// The M/J prefix is dropped so the email reads identically for
  /// adults and minors — `M12345` becomes `12345@icd360s.de`.
  String? get _derivedEmail {
    final mnr = WizardService().mitgliedernummer;
    if (mnr == null || mnr.length < 2) return null;
    return '${mnr.substring(1)}@icd360s.de';
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1f, {
      'telefon_mobil': _telefon.text.trim(),
      // Email is server-derivable from mitgliedernummer but we send it
      // so the saved draft is self-describing — the Vorstand panel can
      // show what the assigned address will be without recomputing.
      'email': _derivedEmail ?? '',
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
            const SizedBox(height: 20),
            _emailInfoCard(l10n),
          ],
        ),
      ),
    );
  }

  /// Read-only display of the auto-assigned member email. When the
  /// mitgliedernummer isn't cached yet (defensive — should only happen
  /// if the visitor somehow lands here without passing Stufe 1b), we
  /// fall back to a placeholder so the layout doesn't collapse.
  Widget _emailInfoCard(AppLocalizations l10n) {
    final email = _derivedEmail;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.alternate_email,
                  color: Colors.white.withValues(alpha: 0.85), size: 18),
              const SizedBox(width: 8),
              Text(
                l10n.wizardStufe1fEmailLabel,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SelectableText(
            email ?? '—',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.wizardStufe1fEmailHelper,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
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
