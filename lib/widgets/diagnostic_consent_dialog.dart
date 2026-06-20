import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../services/diagnostic_service.dart';

/// Conversational diagnostic-consent surface — Claudiu asks for permission
/// to send anonymous app diagnostics. Replaces the corporate AlertDialog
/// the previous revision used. Three options:
///   • "Da, vreau să ajut"               → consent granted, service starts
///   • "Nu, doar exploram"               → consent denied, service stays off
///   • "Spune-mi mai mult"               → expands a brutally-honest
///     transparency panel listing every field the diagnostic payload
///     actually contains. Decision can still be made after expanding.
///
/// The transparency text is the SOURCE OF TRUTH for what
/// diagnostic_service.dart sends. If the payload schema there changes,
/// this list has to change too — they document each other.
class DiagnosticConsentDialog extends StatefulWidget {
  const DiagnosticConsentDialog({super.key});

  @override
  State<DiagnosticConsentDialog> createState() =>
      _DiagnosticConsentDialogState();
}

class _DiagnosticConsentDialogState extends State<DiagnosticConsentDialog> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 640),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mascotAndBubble(l10n),
              const SizedBox(height: 20),
              _option(
                icon: Icons.check_circle_outline,
                label: l10n.claudiuDiagnosticYes,
                color: const Color(0xFF2E7D32),
                onTap: () => _handleResponse(true),
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 300.ms)
                  .slideY(begin: 0.2, end: 0, delay: 600.ms),
              const SizedBox(height: 10),
              _option(
                icon: Icons.cancel_outlined,
                label: l10n.claudiuDiagnosticNo,
                color: Colors.grey.shade700,
                onTap: () => _handleResponse(false),
              )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 300.ms)
                  .slideY(begin: 0.2, end: 0, delay: 800.ms),
              const SizedBox(height: 10),
              _option(
                icon: _expanded
                    ? Icons.expand_less
                    : Icons.help_outline,
                label: l10n.claudiuDiagnosticTellMore,
                color: theme.colorScheme.primary,
                onTap: () => setState(() => _expanded = !_expanded),
              )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 300.ms)
                  .slideY(begin: 0.2, end: 0, delay: 1000.ms),
              AnimatedCrossFade(
                firstChild: const SizedBox(height: 0),
                secondChild: _transparency(l10n),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Mascot (placeholder Material icon — same as ClaudiuWelcome) + speech bubble.
  // ---------------------------------------------------------------------------

  Widget _mascotAndBubble(AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF1565c0).withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF1565c0).withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.accessible_forward,
            size: 38,
            color: Color(0xFF1565c0),
          ),
        )
            .animate()
            .slideX(begin: -0.5, end: 0, duration: 500.ms, curve: Curves.easeOut)
            .fadeIn(duration: 400.ms),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(4),
                topEnd: Radius.circular(14),
                bottomStart: Radius.circular(14),
                bottomEnd: Radius.circular(14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.claudiuDiagnosticGreeting,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0d47a1),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.claudiuDiagnosticAsk,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '— Claudiu',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 400.ms),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Brutal-honesty transparency panel. Source of truth for what the diagnostic
  // service actually transmits — keep this in lockstep with diagnostic_service
  // .dart's `_sendDiagnostics()` payload schema.
  // ---------------------------------------------------------------------------

  Widget _transparency(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _transparencySection(
            header: l10n.claudiuDiagnosticSendsHeader,
            items: [
              l10n.claudiuDiagnosticSends1,
              l10n.claudiuDiagnosticSends2,
              l10n.claudiuDiagnosticSends3,
              l10n.claudiuDiagnosticSends4,
              l10n.claudiuDiagnosticSends5,
              l10n.claudiuDiagnosticSends6,
              l10n.claudiuDiagnosticSends7,
              l10n.claudiuDiagnosticSends8,
              l10n.claudiuDiagnosticSends9,
            ],
            color: Colors.blue.shade700,
            iconBuilder: () => Icon(
              Icons.check,
              size: 16,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 12),
          _transparencySection(
            header: l10n.claudiuDiagnosticNeverHeader,
            items: [
              l10n.claudiuDiagnosticNever1,
              l10n.claudiuDiagnosticNever2,
              l10n.claudiuDiagnosticNever3,
              l10n.claudiuDiagnosticNever4,
              l10n.claudiuDiagnosticNever5,
              l10n.claudiuDiagnosticNever6,
              l10n.claudiuDiagnosticNever7,
            ],
            color: Colors.green.shade700,
            iconBuilder: () => Icon(
              Icons.close,
              size: 16,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 12),
          _transparencySection(
            header: l10n.claudiuDiagnosticTechHeader,
            items: [
              l10n.claudiuDiagnosticTech1,
              l10n.claudiuDiagnosticTech2,
              l10n.claudiuDiagnosticTech3,
            ],
            color: Colors.grey.shade700,
            iconBuilder: () =>
                Icon(Icons.info_outline, size: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _transparencySection({
    required String header,
    required List<String> items,
    required Color color,
    required Widget Function() iconBuilder,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: iconBuilder(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12.5, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Option row.
  // ---------------------------------------------------------------------------

  Widget _option({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Persist decision + start the service if granted.
  // ---------------------------------------------------------------------------

  Future<void> _handleResponse(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('diagnostic_asked', true);
    await prefs.setBool('diagnostic_enabled', enabled);

    if (enabled) {
      // Fire-and-forget; the service handles the anonymous-id bootstrap.
      DiagnosticService().start();
    }

    if (mounted) {
      Navigator.of(context).pop(enabled);
    }
  }
}


// ---------------------------------------------------------------------------
// Same public helpers the previous version exposed — main.dart / welcome.dart
// keep calling these unchanged.
// ---------------------------------------------------------------------------

/// Check if diagnostic consent dialog should be shown
Future<bool> shouldShowDiagnosticConsent() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('diagnostic_asked') != true;
}

/// Check if diagnostics are enabled
Future<bool> isDiagnosticEnabled() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('diagnostic_enabled') ?? false;
}

/// Show diagnostic consent dialog if not already asked
Future<void> checkAndShowDiagnosticConsent(BuildContext context) async {
  if (await shouldShowDiagnosticConsent()) {
    if (context.mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const DiagnosticConsentDialog(),
      );
    }
  } else {
    // Already asked - start service if enabled
    if (await isDiagnosticEnabled()) {
      DiagnosticService().start();
    }
  }
}
