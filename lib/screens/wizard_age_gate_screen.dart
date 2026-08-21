import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../widgets/icd360s_header.dart';
import 'anonymous_chat.dart';
import '../utils/app_theme.dart';

/// Terminal screen the wizard pivots to when `check_age.php` returns
/// `tooYoung`. Satzung §6 sets the floor at 16; visitors below that
/// cannot become members. The screen explains why, offers the office
/// line for ad-hoc volunteer questions (which the law DOES allow at
/// any age with parental consent — separate from membership), and
/// closes the wizard. The device-level block was already set by
/// `WizardService.checkAge`, so a fresh launch on the same device
/// short-circuits straight back here until the visitor would turn 16.
class WizardAgeGateScreen extends StatelessWidget {
  /// The visitor's age — surfaced in the body so the message reads
  /// personal rather than generic.
  final int age;

  /// Closes the wizard and pops the navigator back to welcome.
  final VoidCallback onExit;

  const WizardAgeGateScreen({
    super.key,
    required this.age,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final yearsLeft = (16 - age).clamp(1, 100);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: context.colors.heroGradient,
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
                        _mascot(context)
                            .animate()
                            .scale(
                              begin: const Offset(0.7, 0.7),
                              end: const Offset(1, 1),
                              duration: 400.ms,
                              curve: Curves.easeOutBack,
                            )
                            .fadeIn(duration: 400.ms),
                        const SizedBox(height: 18),
                        _bubble(context, 
                          title: l10n.wizardAgeGatePrompt,
                          body: l10n.wizardAgeGateBody1(age, yearsLeft),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 12),
                        _bubble(context, 
                          body: l10n.wizardAgeGateBody2,
                        ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
                      ],
                    ),
                  ),
                ),
                _chatAction(context, l10n),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: onExit,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white.withValues(alpha: 0.85),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(l10n.wizardAgeGateBackHome),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mascot(BuildContext context) {
    return Center(
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: context.colors.warningBorder.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colors.warningBorder.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Icon(
          Icons.sentiment_dissatisfied,
          size: 52,
          color: context.colors.onDarkWarning,
        ),
      ),
    );
  }

  Widget _bubble(BuildContext context, {String? title, required String body}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(14),
          topEnd: Radius.circular(14),
          bottomStart: Radius.circular(14),
          bottomEnd: Radius.circular(14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: context.colors.brandStrong,
              ),
            ),
            const SizedBox(height: 6),
          ],
          Text(
            body,
            style: TextStyle(
              fontSize: 13.5,
              color: context.colors.textPrimary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '— Claudiu',
            style: TextStyle(
              fontSize: 11,
              color: context.colors.textTertiary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
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
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
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
                        fontSize: 15,
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
                  color: Colors.white.withValues(alpha: 0.7), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
