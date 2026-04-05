import 'dart:async';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../screens/webview_screen.dart';
import '../services/update_service.dart';
import '../services/logger_service.dart';
import 'changelog_dialog.dart';
import 'update_dialog.dart';

const String appVersion = '1.1.16';

class LegalFooter extends StatefulWidget {
  final bool darkMode;

  const LegalFooter({
    super.key,
    this.darkMode = false,
  });

  @override
  State<LegalFooter> createState() => _LegalFooterState();
}

class _LegalFooterState extends State<LegalFooter> with SingleTickerProviderStateMixin {
  final _log = LoggerService();
  bool _isChecking = false;
  Timer? _autoCheckTimer;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Start auto-check timer (every 24 hours)
    // F-Droid will handle updates, this is just a fallback
    _autoCheckTimer = Timer.periodic(const Duration(hours: 24), (_) {
      _checkForUpdates(silent: true);
    });
  }

  @override
  void dispose() {
    _autoCheckTimer?.cancel();
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _checkForUpdates({bool silent = false}) async {
    if (_isChecking) return;

    setState(() => _isChecking = true);
    _rotationController.repeat();

    if (!silent && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)?.searchingForUpdates ?? 'Suche nach Updates...'),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.blue.shade700,
        ),
      );
    }

    _log.info('Checking for updates...', tag: 'UPDATE');

    try {
      final updateService = UpdateService();
      final updateInfo = await updateService.checkForUpdate();

      if (!mounted) return;

      _rotationController.stop();
      _rotationController.reset();
      setState(() => _isChecking = false);

      if (updateInfo != null) {
        _log.info('Update available: ${updateInfo.version}', tag: 'UPDATE');
        // Show update dialog
        showDialog(
          context: context,
          barrierDismissible: !updateInfo.forceUpdate,
          builder: (context) => UpdateDialog(updateInfo: updateInfo),
        );
      } else if (!silent && mounted) {
        _log.info('No updates available', tag: 'UPDATE');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)?.appUpToDate ?? 'Die App ist auf dem neuesten Stand'),
              ],
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }
    } catch (e) {
      _log.error('Update check failed: $e', tag: 'UPDATE');
      if (!mounted) return;

      _rotationController.stop();
      _rotationController.reset();
      setState(() => _isChecking = false);

      if (!silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(AppLocalizations.of(context)?.updateCheckError ?? 'Fehler bei der Update-Prufung'),
              ],
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  void _showChangelog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ChangelogDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.darkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final dividerColor = widget.darkMode ? Colors.grey.shade600 : Colors.grey.shade400;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: widget.darkMode ? const Color(0xFF1a1a2e) : Colors.grey.shade100,
        border: Border(
          top: BorderSide(
            color: widget.darkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Line 1: Copyright + Version
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2025-${DateTime.now().year} ICD360S e.V',
                style: TextStyle(
                  color: textColor,
                  fontSize: 11,
                ),
              ),
              _buildDivider(dividerColor),
              InkWell(
                onTap: () => _showChangelog(context),
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    'v$appVersion',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                      decorationColor: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Line 2: Links
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLink(context, 'Impressum', 'https://icd360s.de/impressum', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Datenschutz', 'https://icd360s.de/datenschutz', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Widerrufsrecht', 'https://icd360s.de/widerrufsrecht', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Kundigung', 'https://icd360s.de/kundigung', textColor),
                _buildDivider(dividerColor),
                _buildLink(context, 'Satzung', 'https://icd360s.de/satzung360s/', textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLink(BuildContext context, String text, String url, Color textColor) {
    return InkWell(
      onTap: () {
        WebViewScreen.openUrl(context, text, url);
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            decoration: TextDecoration.underline,
            decorationColor: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '|',
        style: TextStyle(
          color: color,
          fontSize: 12,
        ),
      ),
    );
  }
}
