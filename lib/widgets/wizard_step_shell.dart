import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../screens/anonymous_chat.dart';
import '../services/wizard_service.dart';
import 'icd360s_header.dart';
import 'wizard_exit_sheet.dart';
import '../utils/app_theme.dart';

/// Reusable chrome for every step screen in the onboarding wizard.
/// Provides the consistent ICD360S blue gradient background, the
/// brand header, a back arrow + step indicator at the top, a Claudiu
/// mascot + speech bubble with the screen's prompt, then a scrollable
/// child area for the actual form, then a sticky bottom row with
/// Back + Next buttons.
///
/// Sub-step screens supply the prompt text, the form, and the two
/// callbacks; the shell handles everything else uniformly so the look
/// stays identical across 14+ screens.
class WizardStepShell extends StatelessWidget {
  /// Top-bar step indicator like "Pas 1 din 8 · Identitate".
  final String stepLabel;

  /// Claudiu's spoken prompt — the question this step asks.
  final String prompt;

  /// Form content under the bubble.
  final Widget child;

  /// Called when the visitor taps the back arrow or the Back button.
  /// Null disables both (use for the very first screen where Back
  /// just exits the wizard via Navigator.pop in the caller).
  final VoidCallback? onBack;

  /// Called when the visitor taps the primary Next button.
  /// Null disables it visually.
  final VoidCallback? onNext;

  /// When true, the Next button shows a spinner instead of its label.
  /// Useful while the server save is in flight.
  final bool saving;

  /// Label override for the Next button. Falls back to the shared
  /// "wizardNext" l10n key when null.
  final String? nextLabel;

  const WizardStepShell({
    super.key,
    required this.stepLabel,
    required this.prompt,
    required this.child,
    this.onBack,
    this.onNext,
    this.saving = false,
    this.nextLabel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          child: Column(
            children: [
              _topBar(context, l10n),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icd360sHeader(compact: true),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _bubble(context).animate().fadeIn(duration: 400.ms),
                      const SizedBox(height: 20),
                      child,
                    ],
                  ),
                ),
              ),
              _bottomBar(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context, AppLocalizations l10n) {
    final mnr = WizardService().mitgliedernummer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back,
              color: onBack == null
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.white,
            ),
            tooltip: l10n.wizardBack,
          ),
          Expanded(
            child: Text(
              stepLabel,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
          ),
          // Live-chat affordance pinned in the top bar — replaces the
          // previous endFloat FAB, which overlapped the bottom Next
          // button. Same anonymous chat the welcome screen's "Am o
          // problemă → Vorbim acum" path uses, so visitor and Vorstand
          // share one inbox throughout registration.
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AnonymousChatScreen(),
              ),
            ),
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            tooltip: l10n.wizardChatHelp,
          ),
          if (mnr != null) _mnrPill(mnr),
        ],
      ),
    );
  }

  /// Shown in the top-right corner once check_age.php has reserved a
  /// mitgliedernummer for this draft. Same id the visitor will see on
  /// the final screen — gives the visitor an early sense of identity
  /// and ownership.
  Widget _mnrPill(String mnr) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.badge_outlined, color: Colors.white, size: 14),
          const SizedBox(width: 5),
          Text(
            mnr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              letterSpacing: 0.9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mascot(),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: context.colors.card,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(4),
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
                Text(
                  prompt,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: context.colors.brandStrong,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 4),
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
          ),
        ),
      ],
    );
  }

  Widget _mascot() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.accessible_forward,
        size: 32,
        color: Colors.white,
      ),
    );
  }

  Widget _bottomBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
      // Beide Schaltflächen flexibel: auf einem schmalen Telefon mit
      // großgestellter Systemschrift passten „Zurück" und „Weiter"
      // nebeneinander nicht mehr — abgeschnitten wurde ausgerechnet „Weiter",
      // die einzige Schaltfläche, die im Wizard weiterführt.
      //
      // Der Ausstieg steht bewusst UNTER der Zeile und nicht als viertes
      // Symbol in der Kopfleiste: auf 320 px blieb neben Zurück-Pfeil, Chat
      // und Mitgliedsnummer-Pille kein Platz mehr für die Schrittanzeige.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _actionRow(context, l10n),
          _exitLink(context, l10n),
        ],
      ),
    );
  }

  Widget _actionRow(BuildContext context, AppLocalizations l10n) {
    return Row(
        children: [
          if (onBack != null)
            Flexible(
              child: OutlinedButton.icon(
              onPressed: saving ? null : onBack,
              icon: const Icon(Icons.arrow_back, size: 18),
              label: Text(
                l10n.wizardBack,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              ),
            ),
          const Spacer(),
          Flexible(
            child: ElevatedButton.icon(
            onPressed: (onNext == null || saving) ? null : onNext,
            icon: saving
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: context.colors.brandStrong,
                      strokeWidth: 2.4,
                    ),
                  )
                : const Icon(Icons.arrow_forward, size: 18),
            label: Text(
              nextLabel ?? l10n.wizardNext,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.card,
              foregroundColor: context.colors.brandStrong,
              disabledBackgroundColor:
                  Colors.white.withValues(alpha: 0.4),
              disabledForegroundColor:
                  context.colors.brandStrong.withValues(alpha: 0.7),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            ),
          ),
        ],
    );
  }

  /// Low-emphasis way out of the registration, mirroring the withdraw
  /// link on the final screen. Opens [showWizardExitSheet], which owns
  /// both the "later" and the "abandon" paths and pops this route.
  ///
  /// Deliberately quiet: the visitor should feel free to leave, but
  /// never be nudged out of a half-finished application by a button
  /// that competes with „Weiter".
  Widget _exitLink(BuildContext context, AppLocalizations l10n) {
    return TextButton(
      onPressed: saving ? null : () => showWizardExitSheet(context),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white.withValues(alpha: 0.7),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: const Size(0, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        l10n.wizardExitLink,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          decorationColor: Colors.white.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}

