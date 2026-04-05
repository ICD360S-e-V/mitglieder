import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../screens/webview_screen.dart';
import '../services/update_service.dart';
import '../services/logger_service.dart';
import 'changelog_dialog.dart';
import 'update_dialog.dart';

const String appVersion = '1.1.23';

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
  bool _updateAvailable = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Check once per day silently (not every time app opens)
    _checkOncePerDay();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _checkOncePerDay() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastCheck = prefs.getString('last_update_check') ?? '';
      final today = DateTime.now().toIso8601String().substring(0, 10);

      if (lastCheck != today) {
        await prefs.setString('last_update_check', today);
        _checkForUpdates(silent: true);
      }
    } catch (_) {}
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
        setState(() => _updateAvailable = true);
        // Show update dialog only if user clicked manually (not silent auto-check)
        if (!silent) {
          showDialog(
            context: context,
            barrierDismissible: !updateInfo.forceUpdate,
            builder: (context) => UpdateDialog(updateInfo: updateInfo),
          );
        }
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
          // Line 1: Copyright + Version + Update button
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
              const SizedBox(width: 4),
              InkWell(
                onTap: _isChecking ? null : () => _checkForUpdates(silent: false),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: _isChecking
                      ? SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: textColor,
                          ),
                        )
                      : Icon(
                          _updateAvailable ? Icons.system_update : Icons.refresh,
                          size: 14,
                          color: _updateAvailable ? Colors.green : textColor,
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
