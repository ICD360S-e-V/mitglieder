import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/icd360s_header.dart';

/// Terminal screen of the onboarding wizard. Two variants drive off
/// the [WizardFinalizeResult]:
///
///   • adult (`status='neu'`) — celebration. The visitor's
///     mitgliedernummer is the headline; Vorstand reviews the
///     stages they just filled and the result lands on their
///     dashboard within a few days.
///   • minor (`status='waiting_for_parent_consent'`) — waiting
///     message. The same mitgliedernummer is shown (it's a real id;
///     the Vorstand uses it to track the parent-link queue) plus
///     the "up to 7 days" expectation the visitor verbally set when
///     we agreed the flow.
///
/// Both variants end with a single button back to the welcome
/// screen. The minor variant also surfaces the support phone in
/// case the visitor wants to nudge the parent or ask follow-up
/// questions.
class WizardFinalScreen extends StatelessWidget {
  final WizardFinalizeResult result;

  /// Phone surfaced on the "call us" affordance for minors. Same
  /// default as the rest of Claudiu's surfaces; a future contact
  /// endpoint can swap one constant.
  final String supportPhone;

  /// Closes the wizard and returns the user to the welcome screen.
  /// The orchestrator wipes the local anonymous_id before invoking
  /// so a new visitor on the same device starts clean.
  final VoidCallback onClose;

  const WizardFinalScreen({
    super.key,
    required this.result,
    required this.onClose,
    this.supportPhone = '+4916094482053',
  });

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMinor = result.isMinor;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isMinor
                ? const [
                    Color(0xFF0d47a1),
                    Color(0xFF1565c0),
                    Color(0xFF1976d2),
                  ]
                : const [
                    Color(0xFF1B5E20),
                    Color(0xFF2E7D32),
                    Color(0xFF388E3C),
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
                        _mascot(isMinor),
                        const SizedBox(height: 24),
                        _titleBubble(l10n, isMinor),
                        const SizedBox(height: 14),
                        _mitgliedernummerCard(l10n),
                        const SizedBox(height: 14),
                        _bodyBubble(l10n, isMinor),
                        const SizedBox(height: 12),
                        _rulesRecapBubble(l10n),
                        const SizedBox(height: 12),
                        _callAction(l10n, isMinor),
                      ],
                    ),
                  ),
                ),
                _closeButton(l10n, isMinor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mascot(bool isMinor) {
    final icon = isMinor ? Icons.hourglass_top : Icons.celebration;
    final tint =
        isMinor ? Colors.amber.shade100 : Colors.lightGreenAccent.shade100;
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
        child: Icon(icon, size: 64, color: tint),
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

  Widget _titleBubble(AppLocalizations l10n, bool isMinor) {
    final title = isMinor
        ? l10n.wizardFinalMinorTitle
        : l10n.wizardFinalAdultTitle;
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w800,
        height: 1.3,
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
  }

  Widget _mitgliedernummerCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.badge, color: Color(0xFF0d47a1), size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.wizardFinalMitgliedernummerLabel,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11.5,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  result.mitgliedernummer,
                  style: const TextStyle(
                    color: Color(0xFF0d47a1),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 500.ms);
  }

  Widget _bodyBubble(AppLocalizations l10n, bool isMinor) {
    final body = isMinor
        ? l10n.wizardFinalMinorBody
        : l10n.wizardFinalAdultBody;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        body,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13.5,
          height: 1.5,
        ),
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 500.ms);
  }

  /// Recap of the rules from Satzung §6 that were also reminded in
  /// Stufe 3 / 4 / 5 inline. The bubble re-grounds the visitor
  /// against the contract they just signed: monthly fee, cancellation
  /// notice, what happens if dues fall behind. Same text for adult
  /// and minor — minors are members too once the parent consents.
  Widget _rulesRecapBubble(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.amber.shade300.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.amber.shade300.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline,
              color: Colors.amber.shade100, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.wizardFinalRulesRecap,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 500.ms);
  }

  Widget _callAction(AppLocalizations l10n, bool isMinor) {
    // The minor variant labels the action around nudging the parent,
    // the adult variant around discussing rules and payment.
    final title = isMinor
        ? l10n.wizardFinalMinorCallTitle
        : l10n.wizardFinalAdultCallTitle;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _call,
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
              const Icon(Icons.phone_in_talk, color: Colors.white, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      supportPhone,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5,
                        letterSpacing: 0.6,
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
    ).animate().fadeIn(delay: 900.ms, duration: 500.ms);
  }

  Widget _closeButton(AppLocalizations l10n, bool isMinor) {
    final color = isMinor ? const Color(0xFF0d47a1) : const Color(0xFF1B5E20);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onClose,
        icon: const Icon(Icons.home_outlined, size: 22),
        label: Text(
          l10n.wizardFinalCloseButton,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
    ).animate().fadeIn(delay: 1000.ms, duration: 500.ms);
  }
}
