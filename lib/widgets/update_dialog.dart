import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/update_service.dart';
import '../utils/app_theme.dart';

/// Update Available Dialog - prompts user to download and install update
class UpdateDialog extends StatefulWidget {
  final UpdateInfo updateInfo;

  const UpdateDialog({super.key, required this.updateInfo});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.system_update, color: context.colors.infoFg),
          const SizedBox(width: 12),
          Text(l.updateAvailable),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.newVersionAvailable(widget.updateInfo.version),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              l.currentVersionLabel(UpdateService.currentVersion),
              style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
            ),
            if (widget.updateInfo.changelog.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                l.changes,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.cardSubtle,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(maxHeight: 150),
                child: SingleChildScrollView(
                  child: Text(
                    widget.updateInfo.changelog,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
            if (_isDownloading) ...[
              const SizedBox(height: 20),
              LinearProgressIndicator(value: _downloadProgress),
              const SizedBox(height: 8),
              Text(
                _downloadProgress < 1.0
                    ? l.downloadProgress((_downloadProgress * 100).toStringAsFixed(0))
                    : l.installationStarting,
                style: TextStyle(color: context.colors.textSecondary),
              ),
              const SizedBox(height: 8),
              Text(
                l.appWillRestart,
                style: TextStyle(
                  color: context.colors.infoFg,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.dangerBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colors.dangerBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: context.colors.dangerFg),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: context.colors.dangerFg),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        if (!_isDownloading && !widget.updateInfo.forceUpdate)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l.later),
          ),
        if (!_isDownloading)
          ElevatedButton.icon(
            onPressed: _downloadAndInstall,
            icon: const Icon(Icons.download),
            label: Text(l.updateNow),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.infoSolid,
              foregroundColor: Colors.white,
            ),
          ),
        if (_isDownloading)
          TextButton(
            onPressed: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colors.infoFg,
                  ),
                ),
                const SizedBox(width: 8),
                Text(l.downloading),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _downloadAndInstall() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _errorMessage = null;
    });

    final updateService = UpdateService();
    final installerPath = await updateService.downloadUpdate(
      widget.updateInfo.downloadUrl,
      (progress) {
        if (mounted) setState(() => _downloadProgress = progress);
      },
      expectedSha256: widget.updateInfo.sha256,
    );

    bool started = false;
    if (installerPath != null) {
      // Wizard runs visibly here: this dialog is only reached on platforms
      // that cannot install unattended, or after the silent path failed. In
      // both cases the user is watching and pressed the button themselves.
      started = await updateService.launchInstaller(installerPath);
    }

    // Only reachable if the hand-off failed; on success the installer has
    // already terminated this process.
    if (!started && mounted) {
      final l = AppLocalizations.of(context)!;
      setState(() {
        _isDownloading = false;
        _errorMessage = l.downloadFailed;
      });
    }
  }
}

/// Checks GitHub for a newer release and applies it.
///
/// On Windows this asks nothing and shows no dialog: it downloads the
/// installer, verifies its hash, installs it silently and relaunches the app.
/// A short snackbar is the only UI, so the restart is not a surprise. Users who
/// would rather approve each update turn the switch off in the profile dialog.
///
/// Everywhere else — and on Windows if the silent path fails, e.g. the download
/// died halfway or the installer refused to start — it falls back to the
/// [UpdateDialog] prompt rather than leaving the user stuck on an old build.
Future<void> checkAndShowUpdateDialog(BuildContext context) async {
  final updateService = UpdateService();
  final updateInfo = await updateService.checkForUpdate();
  if (updateInfo == null) return;

  if (updateService.supportsSilentUpdate &&
      await UpdateService.isAutoUpdateEnabled()) {
    if (context.mounted) {
      final l = AppLocalizations.of(context)!;
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          content: Text(l.autoUpdateInstalling(updateInfo.version)),
          duration: const Duration(seconds: 8),
        ),
      );
    }
    if (await updateService.installUnattended(updateInfo)) {
      return; // process is being replaced
    }
  }

  if (!context.mounted) return;
  showDialog(
    context: context,
    barrierDismissible: !updateInfo.forceUpdate,
    builder: (context) => UpdateDialog(updateInfo: updateInfo),
  );
}
