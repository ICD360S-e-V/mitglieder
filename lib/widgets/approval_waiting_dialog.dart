import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../utils/app_theme.dart';

/// Conversational replacement for the original German static "warten auf
/// Genehmigung" alert. While the visitor's login request is pending
/// approval from a Vorsitzer, Claudiu walks them through what's
/// happening: greets them by name (T+0), explains the safety check
/// (T+2s), then unrolls the "we do this every 30 days, like a security
/// check-up" reassurance (T+15s).
///
/// The public API matches the previous dialog so [login.dart] doesn't
/// need to change: same constructor args, same `onApproved` /
/// `onDenied` / `onExpired` callbacks.
class ApprovalWaitingDialog extends StatefulWidget {
  /// Token returned by `/api/auth/login_request.php`; used by the poll
  /// loop against `/api/auth/check_approval.php`.
  final String requestToken;

  /// Member name resolved server-side from the mitgliedernummer.
  /// Empty string means the server didn't echo a name; the dialog
  /// degrades to the "Bună!" greeting without a personal touch.
  final String memberName;

  /// ISO timestamp at which the request token expires (currently 5
  /// minutes from creation). Not displayed verbatim — the countdown
  /// uses [_kTotalSeconds] internally.
  final String expiresAt;

  /// Phone number rendered on the denied + expired action panels.
  /// Same default as the rest of the Claudiu surfaces so a future
  /// contact-info endpoint can swap one constant.
  final String supportPhone;

  /// Called by the poll loop when status flips to "approved". The data
  /// map includes `token`, `refresh_token`, `user`, and (optionally)
  /// `approval_token` for next-time auto-login.
  final void Function(Map<String, dynamic> result) onApproved;

  /// Vorsitzer pressed Reject. Triggers the denied-state bubble + close.
  final VoidCallback onDenied;

  /// Either the 5-minute countdown ran out OR the server returned
  /// status=expired. Triggers the expired-state bubble + close.
  final VoidCallback onExpired;

  const ApprovalWaitingDialog({
    super.key,
    required this.requestToken,
    required this.memberName,
    required this.expiresAt,
    required this.onApproved,
    required this.onDenied,
    required this.onExpired,
    this.supportPhone = '+4916094482053',
  });

  @override
  State<ApprovalWaitingDialog> createState() => _ApprovalWaitingDialogState();
}

enum _Status { waiting, approved, denied, expired }

class _ApprovalWaitingDialogState extends State<ApprovalWaitingDialog> {
  static const int _kTotalSeconds = 300; // 5 minutes
  static const Duration _kMonthlyExplainDelay = Duration(seconds: 15);

  final _api = ApiService();
  Timer? _pollTimer;
  Timer? _countdownTimer;
  Timer? _monthlyExplainTimer;

  _Status _status = _Status.waiting;
  int _remaining = _kTotalSeconds;
  bool _showMonthlyExplain = false;

  @override
  void initState() {
    super.initState();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _checkStatus(),
    );
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _remaining--);
      if (_remaining <= 0 && _status == _Status.waiting) {
        _resolve(_Status.expired);
      }
    });
    _monthlyExplainTimer = Timer(_kMonthlyExplainDelay, () {
      if (!mounted || _status != _Status.waiting) return;
      setState(() => _showMonthlyExplain = true);
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _countdownTimer?.cancel();
    _monthlyExplainTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkStatus() async {
    if (_status != _Status.waiting) return;
    final result = await _api.checkApprovalStatus(widget.requestToken);
    if (!mounted || _status != _Status.waiting) return;
    final status = result['status'] ?? result['data']?['status'];
    if (status == 'approved') {
      _resolve(_Status.approved, data: result['data'] ?? result);
    } else if (status == 'denied') {
      _resolve(_Status.denied);
    } else if (status == 'expired') {
      _resolve(_Status.expired);
    }
  }

  void _resolve(_Status status, {Map<String, dynamic>? data}) {
    _pollTimer?.cancel();
    _countdownTimer?.cancel();
    _monthlyExplainTimer?.cancel();
    setState(() => _status = status);

    // Give Claudiu time to deliver the closing line; success auto-
    // navigates while denied/expired wait for the user to dismiss.
    if (status == _Status.approved && data != null) {
      Future.delayed(const Duration(milliseconds: 1400), () {
        if (mounted) widget.onApproved(data);
      });
    } else if (status == _Status.expired) {
      // Expired stays open so the user can see the call/retry actions.
    }
  }

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: widget.supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _formatTime(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  IconData _mascotIcon() {
    switch (_status) {
      case _Status.approved:
        return Icons.celebration;
      case _Status.denied:
        return Icons.sentiment_dissatisfied;
      case _Status.expired:
        return Icons.access_time;
      case _Status.waiting:
        return Icons.accessible_forward;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: context.colors.heroGradientShort,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _topBar(l10n),
                const SizedBox(height: 8),
                _mascotAndBubble(l10n),
                if (_status == _Status.waiting && _showMonthlyExplain) ...[
                  const SizedBox(height: 10),
                  _explainBubble(l10n),
                ],
                const SizedBox(height: 18),
                if (_status == _Status.waiting)
                  _countdown()
                else
                  _resolutionActions(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(AppLocalizations l10n) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: IconButton(
        tooltip: l10n.claudiuApprovalCancel,
        onPressed: _status == _Status.waiting
            ? () {
                _pollTimer?.cancel();
                _countdownTimer?.cancel();
                _monthlyExplainTimer?.cancel();
                Navigator.of(context).pop();
              }
            : () => Navigator.of(context).pop(),
        icon: Icon(Icons.close,
            color: Colors.white.withValues(alpha: 0.85), size: 22),
      ),
    );
  }

  Widget _mascotAndBubble(AppLocalizations l10n) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mascot()
              .animate()
              .slideX(
                  begin: -0.5,
                  end: 0,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic)
              .fadeIn(duration: 400.ms),
          const SizedBox(width: 12),
          Expanded(
            child: _bubble(l10n)
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms),
          ),
        ],
      ),
    );
  }

  Widget _mascot() {
    final icon = _mascotIcon();
    final tint = switch (_status) {
      _Status.approved => Colors.greenAccent.shade100,
      _Status.denied => context.colors.warningBorder,
      _Status.expired => context.colors.warningBorder,
      _Status.waiting => Colors.white,
    };
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 2,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          icon,
          key: ValueKey(icon),
          size: 40,
          color: tint,
        ),
      ),
    );
  }

  Widget _bubble(AppLocalizations l10n) {
    final lines = <Widget>[];

    // First line varies per state.
    final greeting = _greetingLine(l10n);
    if (greeting != null) {
      lines.add(Text(
        greeting,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: context.colors.brandStrong,
          height: 1.3,
        ),
      ));
    }

    // Second + third line vary per state.
    final body = _bodyLines(l10n);
    for (final line in body) {
      lines.add(const SizedBox(height: 6));
      lines.add(Text(
        line,
        style: TextStyle(
          fontSize: 13.5,
          color: context.colors.textPrimary,
          height: 1.4,
        ),
      ));
    }

    lines.add(const SizedBox(height: 6));
    lines.add(Text(
      '— Claudiu',
      style: TextStyle(
        fontSize: 11,
        color: context.colors.textTertiary,
        fontStyle: FontStyle.italic,
      ),
    ));

    return Container(
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
        children: lines,
      ),
    );
  }

  /// Top line of the bubble — greeting (waiting) or short closer
  /// (approved / denied / expired). Returns null if no greeting line
  /// is needed (the body alone carries the message).
  String? _greetingLine(AppLocalizations l10n) {
    if (_status != _Status.waiting) return null;
    final name = widget.memberName.trim();
    if (name.isEmpty) return l10n.claudiuApprovalGreetingNoName;
    // Prefer the first name if the server sent the full one.
    final firstName = name.split(' ').first;
    return l10n.claudiuApprovalGreeting(firstName);
  }

  /// Body text under the greeting. Different per state and timing.
  List<String> _bodyLines(AppLocalizations l10n) {
    switch (_status) {
      case _Status.waiting:
        return [
          l10n.claudiuApprovalGladToSeeYou,
          l10n.claudiuApprovalCheckingForSafety,
        ];
      case _Status.approved:
        return [l10n.claudiuApprovalSuccess];
      case _Status.denied:
        return [
          l10n.claudiuApprovalDenied,
          l10n.claudiuApprovalDeniedHelp,
        ];
      case _Status.expired:
        return [
          l10n.claudiuApprovalExpired,
          l10n.claudiuApprovalExpiredHelp,
        ];
    }
  }

  /// The yellow-tinted "💡 we do this every 30 days" callout that
  /// slides in after 15s of waiting. Bound to [_showMonthlyExplain] so
  /// it only ever appears in the [_Status.waiting] state.
  Widget _explainBubble(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 84),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.colors.warningBg.withValues(alpha: 0.92),
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(4),
          topEnd: Radius.circular(12),
          bottomStart: Radius.circular(12),
          bottomEnd: Radius.circular(12),
        ),
      ),
      child: Text(
        l10n.claudiuApprovalMonthlyExplain,
        style: TextStyle(
          fontSize: 12.5,
          color: context.colors.textPrimary,
          height: 1.4,
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _countdown() {
    final progress = _remaining / _kTotalSeconds;
    final urgent = _remaining < 60;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer_outlined,
              color: urgent ? context.colors.onDarkWarning : Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              _formatTime(_remaining),
              style: TextStyle(
                color: urgent ? context.colors.onDarkWarning : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: Colors.white.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation(
              urgent ? context.colors.warningBorder : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _resolutionActions(AppLocalizations l10n) {
    switch (_status) {
      case _Status.approved:
        // Success auto-navigates; no buttons.
        return const SizedBox(height: 4);
      case _Status.denied:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _callAction(l10n),
            const SizedBox(height: 10),
            _textCloseAction(l10n, widget.onDenied),
          ],
        );
      case _Status.expired:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _callAction(l10n),
            const SizedBox(height: 8),
            _retryAction(l10n),
            const SizedBox(height: 4),
            _textCloseAction(l10n, widget.onExpired),
          ],
        );
      case _Status.waiting:
        return const SizedBox.shrink();
    }
  }

  Widget _callAction(AppLocalizations l10n) {
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
              color: Colors.white.withValues(alpha: 0.4),
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
                      l10n.claudiuApprovalCallUs,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.supportPhone,
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
                  color: Colors.white.withValues(alpha: 0.7), size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _retryAction(AppLocalizations l10n) {
    return OutlinedButton.icon(
      onPressed: widget.onExpired,
      icon: const Icon(Icons.refresh, color: Colors.white),
      label: Text(
        l10n.claudiuApprovalTryAgain,
        style: const TextStyle(color: Colors.white),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white.withValues(alpha: 0.45)),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _textCloseAction(AppLocalizations l10n, VoidCallback onTap) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white.withValues(alpha: 0.85),
        ),
        child: Text(l10n.claudiuApprovalClose),
      ),
    );
  }
}
