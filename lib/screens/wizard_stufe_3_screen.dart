import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 3 — Finanzielle Situation. Five radio options covering every
/// fee-exempt social benefit the Vorstand accepts under Satzung §6
/// Abs. 4 ("Ermäßigung, Stundung oder Erlass möglich"):
///
///   • bürgergeld   → fee waived; upload Leistungsbescheid (Jobcenter)
///   • sozialamt    → fee waived; upload Sozialhilfebescheid
///   • alg1         → fee waived; upload ALG-I-Bescheid (Arbeitsagentur)
///   • krankengeld  → fee waived; upload Krankengeld-Bescheinigung
///                    (Krankenkasse)
///   • nein         → regular monthly fee applies
///
/// All four exempt options share the same upload tile (PDF/JPG/PNG
/// ≤ 10 MB). The upload calls `WizardService().uploadLeistungsbescheid()`
/// which streams the file to `/api/public/wizard/upload_leistungsbescheid.php`
/// and writes the relative path into the draft so finalize.php picks
/// it up later.
class WizardStufe3Screen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe3Screen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe3Screen> createState() => _WizardStufe3ScreenState();
}

class _WizardStufe3ScreenState extends State<WizardStufe3Screen> {
  String? _situation;
  String? _uploadedPath; // relative server path after successful upload
  String? _uploadedName;  // original filename for the visitor's confirmation
  bool _uploading = false;
  bool _saving = false;

  static const _options = <String>[
    'buergergeld',
    'sozialamt',
    'alg1',
    'krankengeld',
    'nein',
  ];

  static const _exemptOptions = <String>{
    'buergergeld',
    'sozialamt',
    'alg1',
    'krankengeld',
  };

  @override
  void initState() {
    super.initState();
    _situation = widget.initial?['finanzielle_situation'];
    final existing = widget.initial?['leistungsbescheid_file'];
    if (existing is String && existing.isNotEmpty) {
      _uploadedPath = existing;
      _uploadedName = existing.split('/').last;
    }
  }

  bool get _needsUpload =>
      _situation != null && _exemptOptions.contains(_situation);

  Future<void> _pickAndUpload() async {
    final l10n = AppLocalizations.of(context)!;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result == null || result.files.single.path == null) return;
    final file = File(result.files.single.path!);
    final size = await file.length();
    if (size > 10 * 1024 * 1024) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardStufe3FileTooLarge),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _uploading = true);
    final relPath = await WizardService().uploadLeistungsbescheid(file);
    if (!mounted) return;
    setState(() => _uploading = false);
    if (relPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardStufe3UploadFailed),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() {
      _uploadedPath = relPath;
      _uploadedName = result.files.single.name;
    });
  }

  Future<void> _submit() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (_situation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardErrRequired),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_needsUpload && _uploadedPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.wizardStufe3UploadRequired),
          backgroundColor: Colors.amber.shade800,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe3, {
      'finanzielle_situation': _situation,
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

  ({String title, IconData icon, Color color}) _optionInfo(
    String key,
    AppLocalizations l10n,
  ) =>
      switch (key) {
        'buergergeld' => (
          title: l10n.wizardStufe3OptionBuergergeld,
          icon: Icons.account_balance,
          color: Colors.amber,
        ),
        'sozialamt' => (
          title: l10n.wizardStufe3OptionSozialamt,
          icon: Icons.health_and_safety,
          color: Colors.lightBlueAccent,
        ),
        'alg1' => (
          title: l10n.wizardStufe3OptionAlg1,
          icon: Icons.business_center,
          color: Colors.deepOrangeAccent,
        ),
        'krankengeld' => (
          title: l10n.wizardStufe3OptionKrankengeld,
          icon: Icons.medical_services,
          color: Colors.pinkAccent,
        ),
        'nein' => (
          title: l10n.wizardStufe3OptionNein,
          icon: Icons.work_outline,
          color: Colors.greenAccent,
        ),
        _ => (title: key, icon: Icons.circle, color: Colors.white),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(3, 8, l10n.wizardStufe3Title),
      prompt: l10n.wizardStufe3Prompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final key in _options) ...[
            _optionTile(key, l10n),
            const SizedBox(height: 8),
          ],
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _conditionalBlock(l10n),
          ),
        ],
      ),
    );
  }

  Widget _optionTile(String key, AppLocalizations l10n) {
    final info = _optionInfo(key, l10n);
    final selected = _situation == key;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _situation = key),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
              Icon(info.icon, color: info.color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  info.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight:
                        selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _conditionalBlock(AppLocalizations l10n) {
    if (_needsUpload) {
      return Padding(
        key: const ValueKey('upload'),
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _hintBox(
              color: Colors.green.shade600,
              icon: Icons.check_circle,
              title: l10n.wizardStufe3FeeExemptTitle,
              body: l10n.wizardStufe3FeeExemptBody,
            ),
            const SizedBox(height: 12),
            _uploadTile(l10n),
          ],
        ),
      ).animate().fadeIn(duration: 250.ms);
    }
    if (_situation == 'nein') {
      return Padding(
        key: const ValueKey('regularFee'),
        padding: const EdgeInsets.only(top: 12),
        child: _hintBox(
          color: Colors.lightBlueAccent.shade100,
          icon: Icons.euro,
          title: l10n.wizardStufe3RegularFeeTitle,
          body: l10n.wizardStufe3RegularFeeBody,
        ),
      ).animate().fadeIn(duration: 250.ms);
    }
    return const SizedBox.shrink(key: ValueKey('empty'));
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

  Widget _uploadTile(AppLocalizations l10n) {
    final uploaded = _uploadedPath != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _uploading ? null : _pickAndUpload,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: uploaded
                ? Colors.green.withValues(alpha: 0.18)
                : Colors.orange.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: uploaded
                  ? Colors.green.shade300
                  : Colors.orange.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              if (_uploading)
                const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.4,
                  ),
                )
              else
                Icon(
                  uploaded ? Icons.check_circle : Icons.upload_file,
                  color: uploaded
                      ? Colors.green.shade300
                      : Colors.orange.shade200,
                  size: 24,
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uploaded
                          ? l10n.wizardStufe3UploadDone
                          : l10n.wizardStufe3UploadTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      uploaded
                          ? (_uploadedName ?? '')
                          : l10n.wizardStufe3UploadHint,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (uploaded)
                IconButton(
                  onPressed: _uploading ? null : _pickAndUpload,
                  tooltip: l10n.wizardStufe3UploadReplace,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
