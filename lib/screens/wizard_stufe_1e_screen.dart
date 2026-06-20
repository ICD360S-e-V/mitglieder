import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 1e — Address. Five fields laid out on three rows so the
/// proportions match a printed Personalausweis address block:
/// Straße + Hausnummer (3:1), PLZ + Ort (1:3), Land alone with the
/// "Deutschland" default. We don't ask for Bundesland because for
/// the postal needs we have it's redundant given the PLZ already
/// pins the state.
class WizardStufe1eScreen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe1eScreen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1eScreen> createState() => _WizardStufe1eScreenState();
}

class _WizardStufe1eScreenState extends State<WizardStufe1eScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _strasse;
  late final TextEditingController _hausnummer;
  late final TextEditingController _plz;
  late final TextEditingController _ort;
  late final TextEditingController _land;
  bool _saving = false;

  static final _streetRegex = RegExp(r"^[\p{L}0-9\s\-'./.]+$", unicode: true);
  static final _houseRegex = RegExp(r"^[0-9]+[a-zA-Z]?(?:[/-][0-9]+[a-zA-Z]?)?$");
  static final _plzRegex = RegExp(r"^[0-9]{4,10}$");
  static final _cityRegex = RegExp(r"^[\p{L}\s\-'./,()]+$", unicode: true);

  @override
  void initState() {
    super.initState();
    _strasse = TextEditingController(text: widget.initial?['strasse'] ?? '');
    _hausnummer =
        TextEditingController(text: widget.initial?['hausnummer'] ?? '');
    _plz = TextEditingController(text: widget.initial?['plz'] ?? '');
    _ort = TextEditingController(text: widget.initial?['ort'] ?? '');
    _land = TextEditingController(
        text: widget.initial?['land'] ?? 'Deutschland');
  }

  @override
  void dispose() {
    _strasse.dispose();
    _hausnummer.dispose();
    _plz.dispose();
    _ort.dispose();
    _land.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1e, {
      'strasse': _strasse.text.trim(),
      'hausnummer': _hausnummer.text.trim(),
      'plz': _plz.text.trim(),
      'ort': _ort.text.trim(),
      'land': _land.text.trim(),
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
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1eTitle),
      prompt: l10n.wizardStufe1ePrompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _strasse,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    maxLength: 255,
                    textCapitalization: TextCapitalization.words,
                    decoration: _input(
                      label: l10n.wizardStufe1eStrasseLabel,
                      prefixIcon: Icons.home_outlined,
                    ),
                    validator: (value) {
                      final v = (value ?? '').trim();
                      if (v.isEmpty) return l10n.wizardErrRequired;
                      if (v.length < 2) return l10n.wizardErrTooShort(2);
                      if (!_streetRegex.hasMatch(v)) {
                        return l10n.wizardErrInvalidStreet;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _hausnummer,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    maxLength: 20,
                    decoration: _input(
                      label: l10n.wizardStufe1eHausnummerLabel,
                    ),
                    validator: (value) {
                      final v = (value ?? '').trim();
                      if (v.isEmpty) return l10n.wizardErrRequired;
                      if (!_houseRegex.hasMatch(v)) {
                        return l10n.wizardErrInvalidHausnummer;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                l10n.wizardStufe1eStrasseHelper,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11.5,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: TextFormField(
                    controller: _plz,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: _input(
                      label: l10n.wizardStufe1ePlzLabel,
                    ),
                    validator: (value) {
                      final v = (value ?? '').trim();
                      if (v.isEmpty) return l10n.wizardErrRequired;
                      if (!_plzRegex.hasMatch(v)) {
                        return l10n.wizardErrInvalidPlz;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _ort,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    maxLength: 100,
                    textCapitalization: TextCapitalization.words,
                    decoration: _input(
                      label: l10n.wizardStufe1eOrtLabel,
                    ),
                    validator: (value) {
                      final v = (value ?? '').trim();
                      if (v.isEmpty) return l10n.wizardErrRequired;
                      if (v.length < 2) return l10n.wizardErrTooShort(2);
                      if (!_cityRegex.hasMatch(v)) {
                        return l10n.wizardErrOnlyLetters;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _land,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 100,
              textCapitalization: TextCapitalization.words,
              decoration: _input(
                label: l10n.wizardStufe1eLandLabel,
                helper: l10n.wizardStufe1eLandHelper,
                prefixIcon: Icons.public,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return l10n.wizardErrRequired;
                if (v.length < 2) return l10n.wizardErrTooShort(2);
                if (!_cityRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
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
    String? helper,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
      helperText: helper,
      helperMaxLines: 2,
      helperStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 11.5,
      ),
      counterText: '',
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
