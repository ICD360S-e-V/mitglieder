import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/update_service.dart';

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

  /// Consent for unattended updates, offered inline instead of as a separate
  /// dialog so the user answers it in the one moment it is actually relevant:
  /// the checkbox sits directly above the button that acts on it.
  bool _autoUpdateChecked = true;
  bool _askAutoUpdate = false;

  @override
  void initState() {
    super.initState();
    _resolveAutoUpdatePrompt();
  }

  Future<void> _resolveAutoUpdatePrompt() async {
    if (!UpdateService().supportsSilentUpdate) return;

    // Already on: this dialog is not even part of the unattended path, so
    // there is nothing to offer. Turning it back off is done from the profile
    // dialog's Updates switch.
    if (await UpdateService.isAutoUpdateEnabled()) return;

    // Otherwise keep offering it on every update — a "no" last time should not
    // lock the user out forever — but pre-check it only on the first ask, so
    // re-offering reads as available rather than as nagging.
    final asked = await UpdateService.autoUpdateAsked();
    if (mounted) {
      setState(() {
        _askAutoUpdate = true;
        _autoUpdateChecked = !asked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.system_update, color: Colors.blue.shade700),
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
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
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
                  color: Colors.grey.shade100,
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
            if (_askAutoUpdate && !_isDownloading) ...[
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckboxListTile(
                      value: _autoUpdateChecked,
                      onChanged: (v) =>
                          setState(() => _autoUpdateChecked = v ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                      title: Text(
                        l.autoUpdateEnableTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 6),
                        child: Text(
                          l.autoUpdateEnableHint,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                l.appWillRestart,
                style: TextStyle(
                  color: Colors.blue.shade700,
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
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red.shade700),
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
              backgroundColor: Colors.blue.shade700,
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
                    color: Colors.blue.shade700,
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
    // Persist the consent answer before the download starts: this install
    // ends with the process being replaced, so anything deferred to "after"
    // would never run.
    if (_askAutoUpdate) {
      await UpdateService.setAutoUpdateEnabled(_autoUpdateChecked);
    }

    if (!mounted) return;
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
      // Runs the wizard visibly here — the user is watching this dialog and
      // opted into this specific update. Unattended installs (the consent
      // above) take the silent path from checkAndShowUpdateDialog instead.
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

/// Checks for an update and either applies it unattended or prompts.
///
/// Once the user has consented to automatic updates the whole thing runs
/// without UI: download, silent install, relaunch. If any step of that fails
/// (offline mid-download, installer refused to start) it degrades to the
/// normal dialog rather than leaving the user silently stuck on an old build.
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
