import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

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
  final List<WizardBescheidFile> _files = [];
  bool _uploading = false;
  bool _saving = false;

  // Mirror the per-file caps so we can fail fast without burning a
  // round-trip. The 100 MB cumulative cap is enforced exclusively
  // server-side (we don't track per-file sizes once they're accepted)
  // and surfaced through the 413 path. Keep in sync with
  // upload_leistungsbescheid.php.
  static const int _kMaxCount       = 20;
  static const int _kMaxPerFile     = 10 * 1024 * 1024;    // 10 MB

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
    // Files come pre-parsed by the orchestrator via getState — the
    // server returns a JOIN of wizard_draft_files at the top level
    // and the orchestrator forwards the list under this key.
    final raw = widget.initial?['leistungsbescheid_files'];
    if (raw is List) {
      _files.addAll(raw.whereType<WizardBescheidFile>());
    }
  }

  bool get _needsUpload =>
      _situation != null && _exemptOptions.contains(_situation);

  /// Bottom sheet offering Camera / Gallery / Documents — camera +
  /// gallery only show on Android / iOS since image_picker has no
  /// desktop backend. Visitors on desktop see only the file picker
  /// option, same as the legacy verifizierung_tab.dart flow.
  Future<void> _showAttachmentSheet() async {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = Platform.isAndroid || Platform.isIOS;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (isMobile) ...[
              ListTile(
                leading: const Icon(Icons.camera_alt,
                    color: Color(0xFF0d47a1)),
                title: Text(l10n.camera),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _pickFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library,
                    color: Color(0xFF0d47a1)),
                title: Text(l10n.gallery),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _pickFromGallery();
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.attach_file,
                  color: Color(0xFF0d47a1)),
              title: Text(l10n.documents),
              subtitle: Text(
                l10n.wizardStufe3UploadHint,
                style: const TextStyle(fontSize: 11.5),
              ),
              onTap: () {
                Navigator.pop(sheetCtx);
                _pickFromFiles();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Camera path — one Bescheid photo at a time. The visitor can tap
  /// the Add button again to keep adding pages of the same Bescheid.
  Future<void> _pickFromCamera() async {
    try {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: ImageSource.camera,
        // Compress to keep the upload reasonable for a Bescheid photo.
        imageQuality: 85,
        maxWidth: 2400,
      );
      if (picked == null) return;
      await _uploadFiles([File(picked.path)]);
    } catch (e) {
      _toastUploadFailed();
    }
  }

  /// Gallery path — multi-select native picker. Each photo is
  /// uploaded sequentially through the same endpoint so the server
  /// can enforce its caps file-by-file.
  Future<void> _pickFromGallery() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 2400,
      );
      if (picked.isEmpty) return;
      await _uploadFiles(picked.map((x) => File(x.path)).toList());
    } catch (e) {
      _toastUploadFailed();
    }
  }

  /// File-system picker with multi-select on. Mirrors the
  /// verifizierung_tab.dart filter set (PDF / JPG / JPEG / PNG).
  Future<void> _pickFromFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) return;
    final files = result.files
        .where((f) => f.path != null)
        .map((f) => File(f.path!))
        .toList();
    if (files.isEmpty) return;
    await _uploadFiles(files);
  }

  /// Sequential upload loop. Count and per-file caps are checked
  /// client-side (cheap, known); the cumulative size cap is enforced
  /// server-side and surfaced through the 413 response. We stop the
  /// loop on first server rejection so the toast lines up with the
  /// offending file rather than dumping a generic "some failed".
  Future<void> _uploadFiles(List<File> files) async {
    if (_uploading) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _uploading = true);
    try {
      for (final file in files) {
        if (_files.length >= _kMaxCount) {
          _toast(l10n.wizardStufe3UploadLimitCount, Colors.amber.shade800);
          break;
        }
        final size = await file.length();
        if (size > _kMaxPerFile) {
          _toast(l10n.wizardStufe3FileTooLarge, Colors.red.shade700);
          continue;
        }
        // The radio is non-null here because _showAttachmentSheet is
        // gated behind _needsUpload, which itself requires a category.
        final res = await WizardService().uploadLeistungsbescheid(
          file,
          _situation!,
        );
        if (!mounted) return;
        if (!res.isSuccess) {
          // 413 = the server tripped the 100 MB cumulative cap, 409 =
          // the 20-file cap — both are user-actionable; anything else
          // gets the generic upload-failed toast.
          final msg = switch (res.errorCode) {
            413 => l10n.wizardStufe3UploadLimitTotal,
            409 => l10n.wizardStufe3UploadLimitCount,
            _   => res.errorMessage ?? l10n.wizardStufe3UploadFailed,
          };
          _toast(msg, Colors.amber.shade800);
          break;
        }
        setState(() {
          _files
            ..clear()
            ..addAll(res.allFiles);
        });
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _deleteFile(WizardBescheidFile f) async {
    if (_uploading) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _uploading = true);
    final updated = await WizardService().deleteLeistungsbescheid(f.id);
    if (!mounted) return;
    setState(() => _uploading = false);
    if (updated == null) {
      _toast(l10n.wizardStufe3UploadFailed, Colors.red.shade700);
      return;
    }
    // Sync to the server's authoritative list.
    setState(() {
      _files
        ..clear()
        ..addAll(updated);
    });
  }

  void _toast(String message, Color bg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toastUploadFailed() {
    if (!mounted) return;
    _toast(
      AppLocalizations.of(context)!.wizardStufe3UploadFailed,
      Colors.red.shade700,
    );
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
    if (_needsUpload && _files.isEmpty) {
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

  /// Multi-file Bescheid block: an "Add" tile (or "Add more" when the
  /// list is non-empty), a count/limit pill, and the list of uploaded
  /// items with per-item delete buttons. The "Add" tile is disabled
  /// once the 20-file cap is reached.
  Widget _uploadTile(AppLocalizations l10n) {
    final atCap = _files.length >= _kMaxCount;
    final hasFiles = _files.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _addTile(l10n, atCap: atCap, hasFiles: hasFiles),
        if (hasFiles) ...[
          const SizedBox(height: 10),
          _countPill(l10n),
          const SizedBox(height: 8),
          for (final f in _files) ...[
            _fileRow(f, l10n),
            const SizedBox(height: 6),
          ],
        ],
      ],
    );
  }

  Widget _addTile(AppLocalizations l10n,
      {required bool atCap, required bool hasFiles}) {
    final disabled = atCap || _uploading;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled ? null : _showAttachmentSheet,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: atCap
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.orange.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: atCap
                  ? Colors.white.withValues(alpha: 0.15)
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
                  hasFiles ? Icons.add_circle_outline : Icons.upload_file,
                  color: atCap
                      ? Colors.white.withValues(alpha: 0.45)
                      : Colors.orange.shade200,
                  size: 24,
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasFiles
                          ? l10n.wizardStufe3UploadAddMore
                          : l10n.wizardStufe3UploadTitle,
                      style: TextStyle(
                        color: atCap
                            ? Colors.white.withValues(alpha: 0.55)
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      atCap
                          ? l10n.wizardStufe3UploadLimitCount
                          : l10n.wizardStufe3UploadHint,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 11.5,
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

  Widget _countPill(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.folder_zip,
              color: Colors.white70, size: 16),
          const SizedBox(width: 6),
          Text(
            l10n.wizardStufe3UploadCounter(_files.length, _kMaxCount),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fileRow(WizardBescheidFile f, AppLocalizations l10n) {
    final ext = f.name.contains('.')
        ? f.name.split('.').last.toLowerCase()
        : '';
    final icon = ext == 'pdf' ? Icons.picture_as_pdf : Icons.image;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade200, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              f.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: _uploading ? null : () => _deleteFile(f),
            tooltip: l10n.wizardStufe3UploadDeleteTooltip,
            icon: Icon(Icons.delete_outline,
                color: Colors.white.withValues(alpha: 0.8)),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
