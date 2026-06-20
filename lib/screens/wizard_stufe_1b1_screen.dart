import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 1b1 — Parent-hint capture for 16-17 year-old minors. The
/// step appears between 1b (where the birthdate revealed the visitor
/// is still a minor) and 1c. The four fields below land in the draft
/// columns `data_parent_hint_*` and surface in the Vorstand queue
/// once the wizard finalises with `status='waiting_for_parent_consent'`.
///
/// Communication with the parent happens by phone, not email — the
/// Vorstand calls the number captured here, arranges an in-person or
/// video meeting, and only then triggers the existing
/// `admin_vormund_link.php` to link the parent's separate (normally
/// registered) account to the child via vormund_user_id.
class WizardStufe1b1Screen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe1b1Screen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1b1Screen> createState() => _WizardStufe1b1ScreenState();
}

class _WizardStufe1b1ScreenState extends State<WizardStufe1b1Screen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _vorname;
  late final TextEditingController _nachname;
  late final TextEditingController _telefon;
  String? _relation;
  bool _saving = false;

  static final _nameRegex = RegExp(r"^[\p{L}\s\-'.]+$", unicode: true);
  static final _phoneRegex = RegExp(r"^[+0-9\s\-/()]{5,20}$");

  static const _relations = <String>[
    'mutter',
    'vater',
    'sorgeberechtigter',
    'andere',
  ];

  @override
  void initState() {
    super.initState();
    _vorname = TextEditingController(
        text: widget.initial?['parent_hint_vorname'] ?? '');
    _nachname = TextEditingController(
        text: widget.initial?['parent_hint_nachname'] ?? '');
    _telefon = TextEditingController(
        text: widget.initial?['parent_hint_telefon'] ?? '');
    _relation = widget.initial?['parent_hint_relation'];
  }

  @override
  void dispose() {
    _vorname.dispose();
    _nachname.dispose();
    _telefon.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    if (_relation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrRequired),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1b1, {
      'parent_hint_vorname': _vorname.text.trim(),
      'parent_hint_nachname': _nachname.text.trim(),
      'parent_hint_telefon': _telefon.text.trim(),
      'parent_hint_relation': _relation,
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

  String _relationLabel(String key, AppLocalizations l10n) => switch (key) {
        'mutter'           => l10n.wizardStufe1b1RelationMutter,
        'vater'            => l10n.wizardStufe1b1RelationVater,
        'sorgeberechtigter'=> l10n.wizardStufe1b1RelationSorgeberechtigter,
        'andere'           => l10n.wizardStufe1b1RelationAndere,
        _                  => key,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1b1Title),
      prompt: l10n.wizardStufe1b1Prompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _vorname,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 100,
              textCapitalization: TextCapitalization.words,
              decoration: _input(
                label: l10n.wizardStufe1b1VornameLabel,
                helper: l10n.wizardStufe1b1VornameHelper,
              ),
              validator: (v) => _validateName(v, l10n),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _nachname,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 100,
              textCapitalization: TextCapitalization.words,
              decoration: _input(
                label: l10n.wizardStufe1b1NachnameLabel,
                helper: l10n.wizardStufe1b1NachnameHelper,
              ),
              validator: (v) => _validateName(v, l10n),
            ),
            const SizedBox(height: 14),
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
                label: l10n.wizardStufe1b1TelefonLabel,
                helper: l10n.wizardStufe1b1TelefonHelper,
                prefixIcon: Icons.phone,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return l10n.wizardErrRequired;
                if (!_phoneRegex.hasMatch(v)) {
                  return l10n.wizardErrInvalidPhone;
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            Text(
              l10n.wizardStufe1b1RelationLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            for (final key in _relations)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _relationTile(key, _relationLabel(key, l10n)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _relationTile(String key, String label) {
    final selected = _relation == key;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _relation = key),
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
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.white.withValues(alpha: 0.25),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateName(String? value, AppLocalizations l10n) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return l10n.wizardErrRequired;
    if (v.length < 2) return l10n.wizardErrTooShort(2);
    if (!_nameRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
    return null;
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
