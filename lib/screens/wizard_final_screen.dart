import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/icd360s_header.dart';
import 'anonymous_chat.dart';
import 'wizard_stufe_1a_screen.dart';
import 'wizard_stufe_1b_screen.dart';
import 'wizard_stufe_1c_screen.dart';
import 'wizard_stufe_1d_screen.dart';
import 'wizard_stufe_1e_screen.dart';
import 'wizard_stufe_1f_screen.dart';
import 'wizard_stufe_2_screen.dart';
import 'wizard_stufe_3_screen.dart';
import 'wizard_stufe_4_screen.dart';
import 'wizard_stufe_5_screen.dart';

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

  /// Closes the wizard and returns the user to the welcome screen.
  /// The orchestrator wipes the local anonymous_id before invoking
  /// so a new visitor on the same device starts clean.
  final VoidCallback onClose;

  const WizardFinalScreen({
    super.key,
    required this.result,
    required this.onClose,
  });

  @override
  State<WizardFinalScreen> createState() => _WizardFinalScreenState();
}

class _WizardFinalScreenState extends State<WizardFinalScreen> {
  /// True once `users.status === 'active'`. Flips the status card
  /// from ⏳ În verificare → ✓ Activat and stops the polling timer.
  bool _isActive = false;

  /// True after the visitor confirmed they want to withdraw the
  /// request. PopScope.canPop reads this — back-gesture stays
  /// blocked while we wait, but Navigator.pop after the explicit
  /// withdraw call works because canPop is briefly true.
  bool _withdrawn = false;

  /// Guards against double-tap on the withdraw link.
  bool _withdrawing = false;

  /// Guards the "Corectează acum" buttons in the rejection sheet so a
  /// double-tap doesn't push two correction screens on top of each
  /// other while the data fetch is in flight.
  bool _correcting = false;

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

  WizardFinalizeResult get result => widget.result;
  VoidCallback get onClose => widget.onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMinor = result.isMinor;
    // Non-dismissable on purpose. The visitor has just submitted the
    // application — there is nowhere meaningful for them to "go
    // back" to. The Vorstand reviews the request and a push
    // notification will let them know when the account is active;
    // until then the only useful actions are tapping the Status Card
    // for details or Sună-ne to talk to us. System back / iOS swipe
    // / desktop ESC are absorbed silently; backgrounding via the
    // platform home gesture is the normal way to leave the screen.
    return PopScope(
      canPop: _withdrawn,
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
                  const SizedBox(height: 22),
                  _withdrawLink(l10n),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }

  /// Discreet text-only affordance at the bottom of the screen: the
  /// visitor can voluntarily retract their application. Designed to
  /// be undertorquished (low contrast, small font) so a thumb resting
  /// on the screen doesn't trigger it accidentally — taps still open
  /// a hard confirmation dialog before anything irreversible happens.
  Widget _withdrawLink(AppLocalizations l10n) {
    return Center(
      child: TextButton(
        onPressed: _withdrawing ? null : _confirmWithdraw,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white.withValues(alpha: 0.65),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        child: Text(
          l10n.wizardFinalWithdrawLink,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white.withValues(alpha: 0.35),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 3000.ms, duration: 600.ms);
  }

  Future<void> _confirmWithdraw() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.wizardFinalWithdrawDialogTitle),
        content: Text(l10n.wizardFinalWithdrawDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.wizardFinalWithdrawKeep),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red.shade700),
            child: Text(l10n.wizardFinalWithdrawConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await _withdraw();
  }

  Future<void> _withdraw() async {
    if (_withdrawing) return;
    setState(() => _withdrawing = true);
    final ok = await WizardService().withdrawRequest();
    if (!mounted) return;
    if (!ok) {
      setState(() => _withdrawing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrSaveFailed),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    // Stop the polling timer, wipe the local anonymous_id so a fresh
    // visitor on this device starts clean, then let PopScope allow
    // the back-navigation we're about to issue.
    _statusTimer?.cancel();
    await WizardService().resetLocal();
    if (!mounted) return;
    setState(() => _withdrawn = true);
    // canPop is now true; pop the wizard route. The orchestrator's
    // onClose hook (if any) is intentionally bypassed — the withdraw
    // already did the resetLocal cleanup directly.
    await Future<void>.delayed(Duration.zero);
    if (mounted) Navigator.of(context).maybePop();
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
  /// Count of user_verifizierung rows the Vorstand has reviewed
  /// (status='geprueft'). Drives the "X/8" pill on the Status Card +
  /// the linear progress bar — visitor sees concrete movement as each
  /// Stufe gets approved instead of staring at an opaque "in progress".
  int get _geprueftCount =>
      _stufen.where((s) => s.status == 'geprueft').length;

  /// Stufen the Vorstand explicitly rejected — visitor needs to fix
  /// these before the application can move forward.
  List<WizardStufeStatus> get _rejectedStufen =>
      _stufen.where((s) => s.status == 'abgelehnt').toList();

  Widget _statusCard(AppLocalizations l10n) {
    final hasRejection = _rejectedStufen.isNotEmpty;
    final reviewed = _geprueftCount;
    final progress = reviewed / 8;

    final activeIcon = hasRejection
        ? Icons.error_outline
        : (_isActive ? Icons.check_circle : Icons.hourglass_top);
    final activeTint = hasRejection
        ? Colors.red.shade100
        : (_isActive
            ? Colors.lightGreenAccent.shade100
            : Colors.amber.shade100);
    final mainLabel = hasRejection
        ? l10n.wizardFinalStatusRejectionCount(_rejectedStufen.length)
        : (_isActive
            ? l10n.wizardFinalTimelineActivated
            : l10n.wizardFinalTimelineProcessing);

    Widget iconWidget = Icon(activeIcon, color: activeTint, size: 26);
    if (!_isActive && !hasRejection) {
      // Pulsing hourglass while waiting. Rejection is a hard stop —
      // don't pulse; the static red error icon reads as "action needed".
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
                  _progressPill(reviewed),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 22,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    hasRejection
                        ? Colors.red.shade200
                        : (_isActive
                            ? Colors.lightGreenAccent.shade200
                            : Colors.amber.shade200),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.wizardFinalStatusStepsValidated(reviewed, 8),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 500.ms);
  }

  /// Compact "X/8" pill rendered to the right of the status text.
  /// Tinted green once fully reviewed, amber while the Vorstand is
  /// still working through it.
  Widget _progressPill(int reviewed) {
    final done = reviewed >= 8;
    final tint = done
        ? Colors.lightGreenAccent.shade100
        : Colors.amber.shade100;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tint.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (done)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(Icons.check, color: tint, size: 13),
            ),
          Text(
            '$reviewed/8',
            style: TextStyle(
              color: tint,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Correction flow — invoked from the "Corectează acum" button on a
  // rejected stufe row in the bottom sheet.
  //
  // Re-uses the original wizard step screens so we don't fork the form
  // UI; their saveStep call already mirrors the data into users +
  // flips user_verifizierung from 'abgelehnt' back to 'ausgefuellt'
  // server-side (save_step.php). The polling on this screen picks the
  // change up within 30s, the red badge becomes amber, and the
  // Vorstand re-reviews.
  //
  // Stufe 1 has 6 sub-screens (1a–1f). Vorstand rejection is per-stufe
  // not per-field, so we chain through all of them — the visitor edits
  // anything that's wrong on the way.
  // ---------------------------------------------------------------------------

  Future<void> _correctStufe(int stufe) async {
    if (_correcting) return;
    setState(() => _correcting = true);
    // Close the bottom sheet first so the correction screen pushes on
    // top of WizardFinalScreen, not on top of the sheet.
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    try {
      final state = await WizardService().getState();
      if (!mounted) return;
      final initial =
          (state?['data'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
      switch (stufe) {
        case 1:
          await _pushStufe1Chain(0, initial);
        case 2:
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => WizardStufe2Screen(
              initial: initial,
              onNext: () => Navigator.of(context).pop(),
              onBack: () => Navigator.of(context).pop(),
            ),
          ));
        case 3:
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => WizardStufe3Screen(
              initial: initial,
              onNext: () => Navigator.of(context).pop(),
              onBack: () => Navigator.of(context).pop(),
            ),
          ));
        case 4:
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => WizardStufe4Screen(
              initial: initial,
              onNext: () => Navigator.of(context).pop(),
              onBack: () => Navigator.of(context).pop(),
            ),
          ));
        case 5:
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => WizardStufe5Screen(
              initial: initial,
              isBeitragsfrei: _isBeitragsfreiFromData(initial),
              onNext: () => Navigator.of(context).pop(),
              onBack: () => Navigator.of(context).pop(),
            ),
          ));
        default:
          // Stufe 6/7/8 are legal-document accepts; the Vorstand
          // shouldn't be able to reject them. If it happens anyway,
          // bail silently — the chat button on the screen is the
          // visitor's escalation path.
          break;
      }
      // Force an immediate status refresh after the correction screen
      // pops so the rejected badge flips back to amber without waiting
      // for the 30 s polling tick.
      if (mounted) {
        await _checkStatus();
      }
    } finally {
      if (mounted) {
        setState(() => _correcting = false);
      }
    }
  }

  /// Chain Stufe 1's six sub-screens (1a–1f). At each onNext we pop the
  /// current screen and re-push the next, refreshing `initial` from the
  /// server in between so the new sub-screen sees the just-saved data.
  /// After 1f saves, the chain bottoms out and we return to the final
  /// screen.
  Future<void> _pushStufe1Chain(int subStep, Map<String, dynamic> initial) async {
    if (!mounted) return;
    Widget screen;
    Future<void> advance() async {
      if (!mounted) return;
      Navigator.of(context).pop();
      if (subStep >= 5) return; // 1f was the last — done.
      // Refresh initial so the next sub-screen reflects what was just
      // saved (mirror to users + draft both updated).
      final state = await WizardService().getState();
      if (!mounted) return;
      final fresh =
          (state?['data'] as Map<String, dynamic>?) ?? initial;
      await _pushStufe1Chain(subStep + 1, fresh);
    }
    switch (subStep) {
      case 0:
        screen = WizardStufe1aScreen(initial: initial, onNext: advance);
      case 1:
        screen = WizardStufe1bScreen(
          initial: initial,
          // We don't re-gate by age — the visitor is already a member.
          onAdvance: (_, {duplicateAction}) => advance(),
        );
      case 2:
        screen = WizardStufe1cScreen(initial: initial, onNext: advance);
      case 3:
        screen = WizardStufe1dScreen(initial: initial, onNext: advance);
      case 4:
        screen = WizardStufe1eScreen(initial: initial, onNext: advance);
      case 5:
        screen = WizardStufe1fScreen(initial: initial, onNext: advance);
      default:
        return;
    }
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  bool _isBeitragsfreiFromData(Map<String, dynamic> data) {
    final fs = data['finanzielle_situation'];
    return fs == 'buergergeld' ||
        fs == 'sozialamt' ||
        fs == 'alg1' ||
        fs == 'krankengeld';
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
      // Constrain max height so the sheet never grows past most of
      // the screen, then put the 8 stufen rows inside a scrollable
      // region. Header (handle + title + hint) stays pinned at top.
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
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
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _stufenRows(l10n),
                      ),
                    ),
                  ),
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
    final isRejected = status == 'abgelehnt';
    final (badgeIcon, badgeColor, badgeText) =
        _statusBadge(status, l10n);
    final timestamp = data?.geprueftAm ?? data?.ausgefuelltAm;
    final timestampPrefix = data?.geprueftAm != null
        ? l10n.wizardFinalStufeReviewedAt
        : l10n.wizardFinalStufeFilledAt;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isRejected ? Colors.red.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isRejected ? Colors.red.shade200 : Colors.grey.shade300,
          width: isRejected ? 1.5 : 1,
        ),
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
                if (isRejected) ...[
                  if (data?.notiz != null && data!.notiz!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.wizardFinalStufeRejectionReason,
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            data.notiz!,
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: _correcting
                          ? null
                          : () => _correctStufe(stufe),
                      icon: const Icon(Icons.edit, size: 16),
                      label: Text(l10n.wizardFinalStufeCorrectNow),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red.shade700,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.red.shade400),
                        ),
                      ),
                    ),
                  ),
                ],
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
    ).animate().fadeIn(delay: 900.ms, duration: 500.ms);
  }

}
