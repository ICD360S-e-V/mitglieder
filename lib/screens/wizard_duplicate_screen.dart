import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/icd360s_header.dart';
import '../widgets/wizard_chat_fab.dart';
import 'anonymous_chat.dart';

/// Polite "you already have an account" screen routed from Stufe 1b
/// when check_age.php finds a users row with the same lowercased
/// (vorname, nachname, geburtsdatum). Five variants drive off
/// [WizardDuplicateAction]:
///
///   • login                — existing active account; CTA → login
///                            (visitor is funnelled back to welcome
///                            where Login is the obvious next tap).
///   • pending              — application under review; ask the visitor
///                            to wait for the notification.
///   • recentlyWithdrawn    — gekuendigt_selbst within 90 days; hard
///                            block + ask them to call us.
///   • previouslyWithdrawn  — gekuendigt_selbst > 90 days ago; we let
///                            them know but invite them to call us so
///                            the Vorstand can review.
///   • callUs               — sensitive status (suspended, ausgeschlossen,
///                            verstorben, …); decline to enumerate,
///                            point to the phone.
class WizardDuplicateScreen extends StatelessWidget {
  final WizardDuplicateAction action;

  /// Returns the visitor to the welcome screen.
  final VoidCallback onClose;

  const WizardDuplicateScreen({
    super.key,
    required this.action,
    required this.onClose,
  });

  String _title(AppLocalizations l10n) => switch (action) {
        WizardDuplicateAction.login              => l10n.wizardDuplicateLoginTitle,
        WizardDuplicateAction.pending            => l10n.wizardDuplicatePendingTitle,
        WizardDuplicateAction.recentlyWithdrawn  => l10n.wizardDuplicateRecentlyWithdrawnTitle,
        WizardDuplicateAction.previouslyWithdrawn=> l10n.wizardDuplicatePreviouslyWithdrawnTitle,
        WizardDuplicateAction.callUs             => l10n.wizardDuplicateCallUsTitle,
      };

  String _body(AppLocalizations l10n) => switch (action) {
        WizardDuplicateAction.login              => l10n.wizardDuplicateLoginBody,
        WizardDuplicateAction.pending            => l10n.wizardDuplicatePendingBody,
        WizardDuplicateAction.recentlyWithdrawn  => l10n.wizardDuplicateRecentlyWithdrawnBody,
        WizardDuplicateAction.previouslyWithdrawn=> l10n.wizardDuplicatePreviouslyWithdrawnBody,
        WizardDuplicateAction.callUs             => l10n.wizardDuplicateCallUsBody,
      };

  IconData _icon() => switch (action) {
        WizardDuplicateAction.login              => Icons.login,
        WizardDuplicateAction.pending            => Icons.hourglass_top,
        WizardDuplicateAction.recentlyWithdrawn  => Icons.block,
        WizardDuplicateAction.previouslyWithdrawn=> Icons.history,
        WizardDuplicateAction.callUs             => Icons.phone_in_talk,
      };

  bool get _isHardBlock => action == WizardDuplicateAction.recentlyWithdrawn;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final accent = _isHardBlock
        ? Colors.red.shade700
        : const Color(0xFF1565c0);
    return Scaffold(
      floatingActionButton: const WizardChatFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              accent,
              accent.withValues(alpha: 0.85),
              accent.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                const Icd360sHeader(compact: true),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _mascot(),
                        const SizedBox(height: 24),
                        Text(
                          _title(l10n),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                        ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            _body(l10n),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              height: 1.5,
                            ),
                          ),
                        ).animate().fadeIn(delay: 500.ms, duration: 500.ms),
                        const SizedBox(height: 16),
                        _chatAction(context, l10n),
                      ],
                    ),
                  ),
                ),
                _closeButton(l10n, accent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mascot() {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.45),
            width: 3,
          ),
        ),
        child: Icon(_icon(), size: 56, color: Colors.white),
      )
          .animate()
          .scale(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
            duration: 600.ms,
            curve: Curves.easeOutBack,
          )
          .fadeIn(duration: 400.ms),
    );
  }

  Widget _chatAction(BuildContext context, AppLocalizations l10n) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AnonymousChatScreen()),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.45),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.chat_bubble_outline,
                  color: Colors.white, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.wizardChatHelp,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.wizardChatHelpSubtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.7), size: 22),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 500.ms);
  }

  Widget _closeButton(AppLocalizations l10n, Color accent) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onClose,
        icon: const Icon(Icons.home_outlined, size: 22),
        label: Text(
          l10n.wizardAgeGateBackHome,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
    ).animate().fadeIn(delay: 900.ms, duration: 500.ms);
  }
}
