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
  /// True once `users.status === 'active'`. Flips the status card
  /// from ⏳ În verificare → ✓ Activat and stops the polling timer.
  bool _isActive = false;

  /// Per-Stufe verifizierung snapshot from check_status.php. Drives
  /// the chronological details sheet (tap the status card to open).
  List<WizardStufeStatus> _stufen = const [];

  /// Live ticker so the status card + details sheet flip the moment
  /// the Vorstand approves. 30 s cadence is gentle on the server,
  /// snappy enough for a screen the visitor stares at for a few
  /// minutes at most.
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
    setState(() {
      _stufen = probe.stufen;
      if (probe.isActive) _isActive = true;
    });
    if (_isActive) _statusTimer?.cancel();
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
    // System back (Android / iOS swipe / desktop ESC) is the only exit
    // affordance now — the dedicated "Acasă" button has been retired.
    // PopScope catches the pop attempt and runs the same cleanup the
    // button used to (resets anonymous_id, then lets the navigator pop).
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) onClose();
      },
      child: Scaffold(
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icd360sHeader(compact: true),
                  const SizedBox(height: 24),
                  _mascot(isMinor),
                  const SizedBox(height: 20),
                  _titleBubble(l10n, isMinor),
                  const SizedBox(height: 14),
                  _mitgliedernummerCard(l10n),
                  if (!isMinor) ...[
                    const SizedBox(height: 12),
                    _statusCard(l10n),
                  ],
                  const SizedBox(height: 10),
                  _callAction(l10n, isMinor),
                  const SizedBox(height: 16),
                  _bodyBubble(l10n, isMinor),
                  const SizedBox(height: 12),
                ],
              ),
            ),
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

  /// Compact "Status cerere" card — replaces the old 4-step timeline.
  /// One row, two states: ⏳ În verificare (amber, pulsing hourglass)
  /// or ✓ Activat (green check). The 30 s polling timer flips it
  /// from one to the other when the Vorstand approves.
  Widget _statusCard(AppLocalizations l10n) {
    final activeIcon = _isActive ? Icons.check_circle : Icons.hourglass_top;
    final activeTint = _isActive
        ? Colors.lightGreenAccent.shade100
        : Colors.amber.shade100;
    final mainLabel = _isActive
        ? l10n.wizardFinalTimelineActivated
        : l10n.wizardFinalTimelineProcessing;

    Widget iconWidget = Icon(activeIcon, color: activeTint, size: 26);
    if (!_isActive) {
      iconWidget = iconWidget
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fadeIn(duration: 1200.ms)
          .then()
          .fadeOut(duration: 1200.ms);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showStufenSheet(l10n),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
          ),
          child: Row(
            children: [
              iconWidget,
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.wizardFinalStatusTitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mainLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.7),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 500.ms);
  }

  /// Chronological details bottom sheet. Tap the Status Card to open.
  /// Lists all 8 verifizierung Stufen with completion timestamps and
  /// Vorstand review status. Re-binds to live data via _stufen so the
  /// next polling tick reflects in the open sheet.
  Future<void> _showStufenSheet(AppLocalizations l10n) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: StatefulBuilder(
          builder: (innerCtx, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    l10n.wizardFinalStufeSheetTitle,
                    style: const TextStyle(
                      color: Color(0xFF0d47a1),
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.wizardFinalStufeSheetHint,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ..._stufenRows(l10n),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build the 8 rows. When the probe hasn't returned yet we still
  /// render placeholders so the sheet has shape — no empty spinner.
  List<Widget> _stufenRows(AppLocalizations l10n) {
    final byStufe = {for (final s in _stufen) s.stufe: s};
    return List.generate(8, (i) {
      final stufe = i + 1;
      final data = byStufe[stufe];
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _stufenRow(stufe, data, l10n),
      );
    });
  }

  Widget _stufenRow(
    int stufe,
    WizardStufeStatus? data,
    AppLocalizations l10n,
  ) {
    final title = _stufeTitle(stufe, l10n);
    final status = data?.status ?? 'offen';
    final (badgeIcon, badgeColor, badgeText) =
        _statusBadge(status, l10n);
    final timestamp = data?.geprueftAm ?? data?.ausgefuelltAm;
    final timestampPrefix = data?.geprueftAm != null
        ? l10n.wizardFinalStufeReviewedAt
        : l10n.wizardFinalStufeFilledAt;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(top: 2),
            decoration: const BoxDecoration(
              color: Color(0xFF0d47a1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stufe',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0d47a1),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (timestamp != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '$timestampPrefix '
                    '${_fmtDateTime(timestamp)}',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 11.5,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: badgeColor.withValues(alpha: 0.55)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(badgeIcon, color: badgeColor, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        badgeText,
                        style: TextStyle(
                          color: badgeColor.shade900,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _stufeTitle(int stufe, AppLocalizations l10n) => switch (stufe) {
        1 => l10n.wizardStufe1aTitle,
        2 => l10n.wizardStufe2Title,
        3 => l10n.wizardStufe3Title,
        4 => l10n.wizardStufe4Title,
        5 => l10n.wizardStufe5Title,
        6 => 'Satzung',
        7 => 'Datenschutzerklärung',
        8 => 'Widerrufsbelehrung',
        _ => 'Stufe $stufe',
      };

  (IconData, MaterialColor, String) _statusBadge(
    String status,
    AppLocalizations l10n,
  ) {
    return switch (status) {
      'geprueft' => (
          Icons.check_circle,
          Colors.green,
          l10n.wizardFinalStufeStatusApproved,
        ),
      'ausgefuellt' => (
          Icons.hourglass_top,
          Colors.amber,
          l10n.wizardFinalStufeStatusPending,
        ),
      'abgelehnt' => (
          Icons.cancel,
          Colors.red,
          l10n.wizardFinalStufeStatusRejected,
        ),
      _ => (
          Icons.remove_circle_outline,
          Colors.grey,
          l10n.wizardFinalStufeStatusSkipped,
        ),
    };
  }

  String _fmtDateTime(DateTime dt) {
    String two(int v) => v.toString().padLeft(2, '0');
    final local = dt.toLocal();
    return '${two(local.day)}.${two(local.month)}.${local.year} '
        '${two(local.hour)}:${two(local.minute)}:${two(local.second)}';
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

}
