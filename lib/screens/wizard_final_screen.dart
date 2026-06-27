import 'dart:async';

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
class WizardFinalScreen extends StatefulWidget {
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

  @override
  State<WizardFinalScreen> createState() => _WizardFinalScreenState();
}

class _WizardFinalScreenState extends State<WizardFinalScreen> {
  /// True once `users.status === 'active'`. Lights up step 3 of the
  /// timeline green and stops the polling timer.
  bool _isActive = false;

  /// Live ticker so the timeline flips the moment the Vorstand
  /// approves. 30 s cadence is gentle on the server, snappy enough
  /// for a screen the visitor stares at for a few minutes at most.
  Timer? _statusTimer;

  @override
  void initState() {
    super.initState();
    _kickOffStatusPolling();
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }

  void _kickOffStatusPolling() {
    // Probe once immediately so a visitor returning to a finalized
    // wizard sees the up-to-date timeline without a 30 s delay, then
    // settle into the periodic cadence.
    _checkStatus();
    _statusTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkStatus(),
    );
  }

  Future<void> _checkStatus() async {
    final probe = await WizardService().checkUserStatus();
    if (!mounted || probe == null) return;
    if (probe.isActive && !_isActive) {
      setState(() => _isActive = true);
      _statusTimer?.cancel();
    }
  }

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: widget.supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  WizardFinalizeResult get result => widget.result;
  VoidCallback get onClose => widget.onClose;
  String get supportPhone => widget.supportPhone;

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
                        if (!isMinor) ...[
                          const SizedBox(height: 14),
                          _timeline(l10n),
                        ],
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

  /// 4-step timeline shown only on the adult flow. Step 1 is always
  /// done (we just got here), step 2 turns from pending → done when
  /// the polling probe sees `users.status === 'active'`, step 3
  /// mirrors that, step 4 stays "upcoming" since the first meeting
  /// is a future event the Vorstand will schedule separately.
  Widget _timeline(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _timelineRow(
            label: l10n.wizardFinalTimelineSubmitted,
            state: _StepState.done,
            isLast: false,
            delayMs: 700,
          ),
          _timelineRow(
            label: l10n.wizardFinalTimelineProcessing,
            state: _isActive ? _StepState.done : _StepState.inProgress,
            isLast: false,
            delayMs: 850,
          ),
          _timelineRow(
            label: l10n.wizardFinalTimelineActivated,
            state: _isActive ? _StepState.done : _StepState.upcoming,
            isLast: false,
            delayMs: 1000,
          ),
          _timelineRow(
            label: l10n.wizardFinalTimelineFirstMeeting,
            state: _StepState.upcoming,
            isLast: true,
            delayMs: 1150,
          ),
        ],
      ),
    );
  }

  Widget _timelineRow({
    required String label,
    required _StepState state,
    required bool isLast,
    required int delayMs,
  }) {
    final Color iconColor = switch (state) {
      _StepState.done       => Colors.lightGreenAccent.shade100,
      _StepState.inProgress => Colors.amber.shade100,
      _StepState.upcoming   => Colors.white.withValues(alpha: 0.45),
    };
    final IconData iconData = switch (state) {
      _StepState.done       => Icons.check_circle,
      _StepState.inProgress => Icons.hourglass_top,
      _StepState.upcoming   => Icons.radio_button_unchecked,
    };
    Widget icon = Icon(iconData, color: iconColor, size: 22);
    if (state == _StepState.inProgress) {
      icon = icon
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fadeIn(duration: 1200.ms)
          .then()
          .fadeOut(duration: 1200.ms);
    }
    final textColor = state == _StepState.upcoming
        ? Colors.white.withValues(alpha: 0.55)
        : Colors.white;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 2),
              icon,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: state == _StepState.done
                        ? Colors.lightGreenAccent.shade100
                            .withValues(alpha: 0.55)
                        : Colors.white.withValues(alpha: 0.20),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 14),
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13.5,
                  fontWeight: state == _StepState.done
                      ? FontWeight.w700
                      : FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delayMs.ms, duration: 400.ms);
  }

  Widget _bodyBubble(AppLocalizations l10n, bool isMinor) {
    if (isMinor) {
      return _minorBubble(l10n);
    }
    // Adult flow: three conversational beats. They cascade in with a
    // slight slide-up + fade so the screen feels like Claudiu is
    // talking the visitor through what happens next, rather than a
    // wall of paragraph text.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _convBubble(l10n.wizardFinalAdultThank,        delayMs: 1300),
        const SizedBox(height: 8),
        _convBubble(l10n.wizardFinalAdultUsual,        delayMs: 1900),
        const SizedBox(height: 8),
        _convBubble(l10n.wizardFinalAdultExceptional,  delayMs: 2500),
      ],
    );
  }

  /// Single chat-style bubble in the adult conversational body.
  Widget _convBubble(String text, {required int delayMs}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(4),
          topEnd: Radius.circular(14),
          bottomStart: Radius.circular(14),
          bottomEnd: Radius.circular(14),
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13.5,
          height: 1.45,
        ),
      ),
    )
        .animate()
        .fadeIn(delay: delayMs.ms, duration: 500.ms)
        .slideY(
          begin: 0.08,
          end: 0,
          delay: delayMs.ms,
          duration: 500.ms,
          curve: Curves.easeOut,
        );
  }

  /// Minor flow keeps the existing single-paragraph bubble — the
  /// content there is about contacting the parent, which reads more
  /// naturally as one block than as a cascade.
  Widget _minorBubble(AppLocalizations l10n) {
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
        l10n.wizardFinalMinorBody,
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

/// Visual state for a row in the 4-step adult timeline.
enum _StepState { done, inProgress, upcoming }
