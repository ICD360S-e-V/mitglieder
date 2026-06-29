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

  /// Snapshot of the visitor's wizard_drafts data, fetched once on
  /// mount and refreshed whenever a correction screen pops. Drives the
  /// per-Stufe data preview in the sheet (tap a Stufe row → expands
  /// to show what was actually filled).
  Map<String, dynamic> _userData = const {};

  /// Which stufe row in the bottom sheet is currently expanded to show
  /// its filled-data preview. Null = all rows collapsed. Survives
  /// across sheet open/close so the visitor doesn't have to re-tap
  /// after dismissing and re-opening.
  int? _sheetExpandedStufe;

  /// Live ticker so the status card + details sheet flip the moment
  /// the Vorstand approves. 30 s cadence is gentle on the server,
  /// snappy enough for a screen the visitor stares at for a few
  /// minutes at most.
  Timer? _statusTimer;

  @override
  void initState() {
    super.initState();
    _kickOffStatusPolling();
    _loadUserData();
  }

  /// Pull the visitor's wizard_drafts data so the sheet can render the
  /// actual field values under each Stufe. Non-fatal — if the fetch
  /// fails, the sheet falls back to "no data available" placeholders
  /// rather than erroring.
  Future<void> _loadUserData() async {
    final state = await WizardService().getState();
    if (!mounted) return;
    final data = (state?['data'] as Map<String, dynamic>?) ?? const {};
    setState(() => _userData = data);
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
      // for the 30 s polling tick. Also re-pull the draft data so the
      // sheet's per-Stufe field preview reflects the edits.
      if (mounted) {
        await _checkStatus();
        await _loadUserData();
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
          builder: (innerCtx, setSheetState) {
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
                        children: _stufenRows(
                          l10n,
                          expandedStufe: _sheetExpandedStufe,
                          onToggle: (stufe) => setSheetState(() {
                            _sheetExpandedStufe =
                                _sheetExpandedStufe == stufe ? null : stufe;
                          }),
                        ),
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
  List<Widget> _stufenRows(
    AppLocalizations l10n, {
    required int? expandedStufe,
    required ValueChanged<int> onToggle,
  }) {
    final byStufe = {for (final s in _stufen) s.stufe: s};
    return List.generate(8, (i) {
      final stufe = i + 1;
      final data = byStufe[stufe];
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _stufenRow(
          stufe,
          data,
          l10n,
          expanded: expandedStufe == stufe,
          onToggle: () => onToggle(stufe),
        ),
      );
    });
  }

  Widget _stufenRow(
    int stufe,
    WizardStufeStatus? data,
    AppLocalizations l10n, {
    required bool expanded,
    required VoidCallback onToggle,
  }) {
    final title = _stufeTitle(stufe, l10n);
    final status = data?.status ?? 'offen';
    final isRejected = status == 'abgelehnt';
    final (badgeIcon, badgeColor, badgeText) =
        _statusBadge(status, l10n);
    final timestamp = data?.geprueftAm ?? data?.ausgefuelltAm;
    final timestampPrefix = data?.geprueftAm != null
        ? l10n.wizardFinalStufeReviewedAt
        : l10n.wizardFinalStufeFilledAt;
    return Material(
      color: isRejected ? Colors.red.shade50 : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(10),
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF0d47a1),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more,
                        color: Colors.grey.shade600,
                        size: 22,
                      ),
                    ),
                  ],
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
                    _notizBox(data.notiz!, l10n),
                  ],
                  // Stufe 6/7/8 are legal-document accepts; the server
                  // now rejects 'abgelehnt' for them with HTTP 400, so
                  // they shouldn't appear here. Defensive: hide the CTA
                  // anyway in case an old draft slipped through.
                  if (stufe <= 5) ...[
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
                if (expanded) ...[
                  const SizedBox(height: 10),
                  _stufenDataPreview(stufe, l10n),
                ],
              ],
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }

  /// Per-Stufe data preview rendered under the row when expanded.
  /// Pulls values from _userData (the wizard_drafts snapshot fetched
  /// on mount) and formats them as a compact "Label: value" list.
  /// Stufe 6/7/8 don't carry data, just a "Read on …" line driven by
  /// the ausgefuellt_am timestamp on the verifizierung row.
  Widget _stufenDataPreview(int stufe, AppLocalizations l10n) {
    final entries = _previewEntriesFor(stufe, l10n);
    if (entries.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          l10n.wizardFinalStufeNoDataYet,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0) const SizedBox(height: 6),
            _previewLine(entries[i].label, entries[i].value),
          ],
        ],
      ),
    );
  }

  Widget _previewLine(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? '—' : value,
            style: TextStyle(
              color: value.isEmpty
                  ? Colors.grey.shade400
                  : const Color(0xFF0d47a1),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Map a Stufe number to the list of (label, value) pairs we want to
  /// preview under its expanded row. Values come from _userData. Empty
  /// list means "no preview available for this Stufe yet" — the caller
  /// renders the placeholder.
  List<({String label, String value})> _previewEntriesFor(
      int stufe, AppLocalizations l10n) {
    final d = _userData;
    if (d.isEmpty && stufe <= 5) return const [];
    String s(String key) => (d[key] ?? '').toString().trim();

    switch (stufe) {
      case 1:
        final addressLine = [s('strasse'), s('hausnummer')]
            .where((p) => p.isNotEmpty)
            .join(' ');
        final cityLine = [s('plz'), s('ort')]
            .where((p) => p.isNotEmpty)
            .join(' ');
        return [
          (label: l10n.wizardStufe1aVornameLabel,         value: s('vorname')),
          (label: l10n.wizardStufe1aNachnameLabel,        value: s('nachname')),
          if (s('geburtsname').isNotEmpty)
            (label: l10n.wizardStufe1aGeburtsnameLabel,   value: s('geburtsname')),
          (label: l10n.wizardStufe1bGeburtsdatumLabel,    value: _fmtBirthdate(s('geburtsdatum'))),
          (label: l10n.wizardStufe1bGeburtsortLabel,      value: s('geburtsort')),
          (label: l10n.wizardStufe1cGeschlechtLabel,      value: _geschlechtLabel(s('geschlecht'), l10n)),
          (label: l10n.wizardStufe1cFamilienstandLabel,   value: _familienstandLabel(s('familienstand'), l10n)),
          (label: l10n.wizardStufe1dStaatLabel,           value: s('staatsangehoerigkeit')),
          (label: l10n.wizardStufe1dAufenthaltLabel,      value: _aufenthaltsstatusLabel(s('aufenthaltsstatus'), l10n)),
          (label: l10n.wizardStufe1dMutterspracheLabel,   value: s('muttersprache')),
          (label: l10n.wizardStufe1eStrasseLabel,         value: addressLine),
          (label: l10n.wizardStufe1ePlzLabel,             value: cityLine),
          (label: l10n.wizardStufe1eLandLabel,            value: s('land')),
          (label: l10n.wizardStufe1fTelefonLabel,         value: s('telefon_mobil')),
          (label: l10n.wizardStufe1fEmailLabel,           value: s('email')),
        ];
      case 2:
        return [
          (label: l10n.wizardStufe2Title,
           value: _mitgliedsartLabel(s('mitgliedsart'), l10n)),
        ];
      case 3:
        return [
          (label: l10n.wizardStufe3Title,
           value: _finanzielleSituationLabel(s('finanzielle_situation'), l10n)),
        ];
      case 4:
        if (_isBeitragsfreiFromData(d)) {
          return [
            (label: l10n.wizardStufe4Title,
             value: l10n.wizardFinalStufeBeitragsfrei),
          ];
        }
        return [
          (label: 'Zahlungsmethode',
           value: _zahlungsmethodeLabel(s('zahlungsmethode'), l10n)),
          (label: 'Zahlungstag',
           value: s('zahlungstag')),
        ];
      case 5:
        final opt = s('mitgliedschaftsbeginn_option');
        final dt  = s('mitgliedschaftsbeginn_datum');
        final value = opt == 'anderes_datum' && dt.isNotEmpty
            ? '${_mitgliedschaftsbeginnLabel(opt, l10n)} (${_fmtBirthdate(dt)})'
            : _mitgliedschaftsbeginnLabel(opt, l10n);
        return [
          (label: l10n.wizardStufe5Title, value: value),
        ];
      case 6:
      case 7:
      case 8:
        // Documents have no payload — surface accepted-at if we have it.
        final stufeStatus = _stufen.firstWhere(
          (st) => st.stufe == stufe,
          orElse: () => const WizardStufeStatus(stufe: 0, status: 'offen'),
        );
        final ts = stufeStatus.ausgefuelltAm;
        return [
          (label: l10n.wizardFinalStufeReadAt,
           value: ts != null ? _fmtDateTime(ts) : '—'),
        ];
      default:
        return const [];
    }
  }

  String _fmtBirthdate(String iso) {
    if (iso.isEmpty) return '';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(dt.day)}.${two(dt.month)}.${dt.year}';
  }

  String _geschlechtLabel(String key, AppLocalizations l10n) => switch (key) {
        'maennlich' => l10n.wizardStufe1cGeschlechtMaennlich,
        'weiblich'  => l10n.wizardStufe1cGeschlechtWeiblich,
        'divers'    => l10n.wizardStufe1cGeschlechtDivers,
        _           => key,
      };

  String _familienstandLabel(String key, AppLocalizations l10n) => switch (key) {
        'ledig'       => l10n.wizardStufe1cFamilienstandLedig,
        'verheiratet' => l10n.wizardStufe1cFamilienstandVerheiratet,
        'geschieden'  => l10n.wizardStufe1cFamilienstandGeschieden,
        'verwitwet'   => l10n.wizardStufe1cFamilienstandVerwitwet,
        _             => key,
      };

  String _aufenthaltsstatusLabel(String key, AppLocalizations l10n) => switch (key) {
        ''                          => '',
        'deutsch'                   => l10n.wizardStufe1dAufenthaltGerman,
        'eu_eea_freizuegigkeit'     => l10n.wizardStufe1dAufenthaltEuEea,
        'aufenthaltserlaubnis'      =>
          'Aufenthaltserlaubnis (${l10n.wizardStufe1dAufenthaltTempHint})',
        'niederlassungserlaubnis'   =>
          'Niederlassungserlaubnis (${l10n.wizardStufe1dAufenthaltPermHint})',
        'daueraufenthalt_eu'        => 'Daueraufenthalt-EU',
        'blaue_karte_eu'            => 'Blaue Karte EU',
        'asylberechtigt'            => 'Asylberechtigt (Art. 16a GG)',
        'fluechtling_gfk'           => 'Anerkannter Flüchtling (GFK § 25 Abs. 2)',
        'subsidiaerer_schutz'       => 'Subsidiärer Schutz',
        'aufenthaltsgestattung'     =>
          'Aufenthaltsgestattung (${l10n.wizardStufe1dAufenthaltAsylumProcessHint})',
        'duldung'                   => 'Duldung (§ 60a)',
        'humanitaer'                => 'Humanitärer Aufenthalt (§ 25 Abs. 4/5)',
        'sonstige'                  => l10n.wizardStufe1dAufenthaltOther,
        _                           => key,  // Vorstand-written free text passes through
      };

  String _mitgliedsartLabel(String key, AppLocalizations l10n) => switch (key) {
        'ordentlich'      => l10n.memberType_ordentlich,
        'foerdermitglied' => l10n.memberType_foerder,
        'ehrenmitglied'   => l10n.memberType_ehren,
        _                 => key,
      };

  String _finanzielleSituationLabel(String key, AppLocalizations l10n) => switch (key) {
        'buergergeld'   => 'Bürgergeld (SGB II)',
        'sozialamt'     => 'Sozialamt (SGB XII)',
        'alg1'          => 'Arbeitslosengeld I',
        'krankengeld'   => 'Krankengeld',
        'nein'          => l10n.wizardFinalStufeNotExempt,
        _               => key,
      };

  String _zahlungsmethodeLabel(String key, AppLocalizations l10n) => switch (key) {
        'ueberweisung'      => l10n.payMethod_ueberweisung,
        'sepa_lastschrift'  => 'SEPA-Lastschrift',
        'dauerauftrag'      => l10n.payMethod_dauerauftrag,
        _                   => key,
      };

  String _mitgliedschaftsbeginnLabel(String key, AppLocalizations l10n) => switch (key) {
        'ab_verifizierung' => l10n.wizardFinalStufeBeginAtVerification,
        'gruendungsdatum'  => l10n.wizardFinalStufeBeginAtFoundation,
        'anderes_datum'    => l10n.wizardFinalStufeBeginAtCustom,
        _                  => key,
      };

  /// Parse a multi-line notiz coming back from check_status.php into
  /// labeled per-field rows. Vorsitzer's Verifizierung tab now lets the
  /// Vorstand ✓/✗ individual Stufe-1 fields and aggregates the picked
  /// reasons into a notiz of the form:
  ///
  ///     Vorname: Bitte vollständig eintragen
  ///     Geburtsdatum: TT.MM.JJJJ-Format verwenden
  ///     Telefon: Vorwahl fehlt
  ///
  /// We split by newline, try the `^Field: Reason$` pattern, and look
  /// the label up in a German→column-name map. Lines that don't match
  /// keep their full text and `field` stays null (caller renders them
  /// as a general note in the same red box). Plain notiz strings
  /// without any `:` still work — they all fall through to the
  /// `field=null` branch.
  static const Map<String, String> _notizFieldMap = {
    // canonical German labels vorsitzer emits
    'vorname': 'vorname',
    'nachname': 'nachname',
    'geburtsname': 'geburtsname',
    'geburtsdatum': 'geburtsdatum',
    'geburtsort': 'geburtsort',
    'geschlecht': 'geschlecht',
    'familienstand': 'familienstand',
    'staatsangehörigkeit': 'staatsangehoerigkeit',
    'staatsangehoerigkeit': 'staatsangehoerigkeit',
    'aufenthaltsstatus': 'aufenthaltsstatus',
    'muttersprache': 'muttersprache',
    'straße': 'strasse',
    'strasse': 'strasse',
    'hausnummer': 'hausnummer',
    'plz': 'plz',
    'ort': 'ort',
    'land': 'land',
    'telefon': 'telefon_mobil',
    'telefon (mobil)': 'telefon_mobil',
    'telefonnummer': 'telefon_mobil',
    'telefon mobil': 'telefon_mobil',
    'e-mail': 'email',
    'email': 'email',
  };

  /// One parsed notiz line. `fieldKey` is the DB column the line is
  /// pinned to (vorname, geburtsdatum, …) or null when the line is a
  /// freeform note. `label` keeps the original German label as the
  /// Vorstand wrote it — we use it as-is for display rather than
  /// re-localizing, so the visitor sees the same field name the
  /// reviewer typed.
  List<({String? fieldKey, String label, String reason})> _parseNotiz(
      String notiz) {
    final out = <({String? fieldKey, String label, String reason})>[];
    final pattern = RegExp(r'^\s*([^:]+?):\s*(.+?)\s*$');
    for (final raw in notiz.split('\n')) {
      final line = raw.trim();
      if (line.isEmpty) continue;
      final m = pattern.firstMatch(line);
      if (m == null) {
        out.add((fieldKey: null, label: '', reason: line));
        continue;
      }
      final label = m.group(1)!.trim();
      final reason = m.group(2)!.trim();
      final key = _notizFieldMap[label.toLowerCase()];
      out.add((fieldKey: key, label: label, reason: reason));
    }
    return out;
  }

  /// Render the rejection notiz as either a stack of per-field rows
  /// (when the Vorstand wrote it in `Field: Reason` form) or a single
  /// red text block (legacy / freeform notiz). The header always reads
  /// "Vorstand's reason:" — the field labels below carry the detail.
  Widget _notizBox(String notiz, AppLocalizations l10n) {
    final parsed = _parseNotiz(notiz);
    final hasLabeledLines = parsed.any((p) => p.label.isNotEmpty);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          const SizedBox(height: 4),
          if (!hasLabeledLines)
            Text(
              notiz,
              style: TextStyle(
                color: Colors.red.shade900,
                fontSize: 12.5,
                height: 1.4,
              ),
            )
          else
            ...parsed.map((p) {
              final isLabeled = p.label.isNotEmpty;
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.red.shade700,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                          children: [
                            if (isLabeled) ...[
                              TextSpan(
                                text: '${p.label}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(text: p.reason),
                            ] else
                              TextSpan(text: p.reason),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
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
