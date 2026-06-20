import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../widgets/icd360s_header.dart';

/// "I have a problem with the app" surface — reached from the Claudiu
/// welcome flow. A guided form: checklist of what to include, free-text
/// area for the user's own description, send to the server. We do NOT
/// attach OS / app version / device-id payload here — that already
/// arrives via the periodic diagnostic POST when consent is granted, and
/// the user explicitly asked us not to duplicate it.
///
/// The only fallback channel is a `tel:` link to the office line. No
/// email, no WhatsApp, by user request.
class ProblemReportScreen extends StatefulWidget {
  /// Phone number rendered at the bottom of the screen for the
  /// "call us instead" path. Defaults to the same line used by SOS /
  /// ClaudiuLoginCoach so a future contact-info endpoint can replace
  /// one place.
  final String supportPhone;

  const ProblemReportScreen({
    super.key,
    this.supportPhone = '+4916094482053',
  });

  @override
  State<ProblemReportScreen> createState() => _ProblemReportScreenState();
}

class _ProblemReportScreenState extends State<ProblemReportScreen> {
  /// Bug report descriptions shorter than this are unlikely to be
  /// actionable. The submit button stays disabled until reached and the
  /// character counter shows the user how close they are.
  static const int _minChars = 20;

  final TextEditingController _descController = TextEditingController();
  bool _isSending = false;


  @override
  void initState() {
    super.initState();
    _descController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      !_isSending && _descController.text.trim().length >= _minChars;

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isSending = true);
    try {
      final result = await ApiService().submitBugReport(
        description: _descController.text.trim(),
      );
      if (!mounted) return;
      if (result['success'] == true) {
        await _showSentDialog(l10n);
        if (mounted) Navigator.of(context).pop();
      } else {
        _showFailedSnack(l10n);
      }
    } catch (_) {
      if (mounted) _showFailedSnack(l10n);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _showSentDialog(AppLocalizations l10n) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
            const SizedBox(width: 10),
            Text(l10n.claudiuProblemReportSentTitle),
          ],
        ),
        content: Text(l10n.claudiuProblemReportSentBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.claudiuProblemReportSentClose),
          ),
        ],
      ),
    );
  }

  void _showFailedSnack(AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.claudiuProblemReportSendFailed),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: widget.supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final charCount = _descController.text.trim().length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0d47a1),
              Color(0xFF1565c0),
              Color(0xFF1976d2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _header(l10n),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icd360sHeader(compact: true),
                      const SizedBox(height: 16),
                      _mascotAndBubble(l10n),
                      const SizedBox(height: 16),
                      _checklist(l10n),
                      const SizedBox(height: 16),
                      _descriptionField(l10n, charCount),
                      const SizedBox(height: 16),
                      _submitButton(l10n),
                      const SizedBox(height: 24),
                      _altCallSection(l10n),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          Expanded(
            child: Text(
              l10n.claudiuProblemReportTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _mascotAndBubble(AppLocalizations l10n) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.bug_report_outlined,
              size: 38,
              color: Colors.white,
            ),
          )
              .animate()
              .slideX(
                begin: -0.5,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              )
              .fadeIn(duration: 400.ms),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    l10n.claudiuProblemReportGreeting,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0d47a1),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.claudiuProblemReportAsk,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey[800],
                      height: 1.3,
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
            ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
          ),
        ],
      ),
    );
  }

  Widget _checklist(AppLocalizations l10n) {
    final bullets = [
      l10n.claudiuProblemReportIncludeBullets1,
      l10n.claudiuProblemReportIncludeBullets2,
      l10n.claudiuProblemReportIncludeBullets3,
      l10n.claudiuProblemReportIncludeBullets4,
      l10n.claudiuProblemReportIncludeBullets5,
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 ${l10n.claudiuProblemReportIncludeHeader}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          for (final bullet in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullet,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _descriptionField(AppLocalizations l10n, int charCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '✍️ ${l10n.claudiuProblemReportDescriptionLabel}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descController,
          maxLines: 8,
          minLines: 6,
          enabled: !_isSending,
          style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
          decoration: InputDecoration(
            hintText: l10n.claudiuProblemReportDescriptionHint,
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
              height: 1.4,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                charCount < _minChars
                    ? l10n.claudiuProblemReportTooShort(_minChars)
                    : '',
                style: TextStyle(
                  color: Colors.amber.shade200,
                  fontSize: 11.5,
                ),
              ),
            ),
            Text(
              '$charCount / $_minChars',
              style: TextStyle(
                color: charCount >= _minChars
                    ? Colors.greenAccent.shade100
                    : Colors.white.withValues(alpha: 0.6),
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _submitButton(AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _canSubmit ? _submit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.18),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.white.withValues(alpha: 0.05),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.4),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.45),
            width: 2,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: _isSending
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(l10n.claudiuProblemReportSubmitting),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send_outlined, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    l10n.claudiuProblemReportSubmit,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _altCallSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '⬇️ ${l10n.claudiuProblemReportAlt}',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _call,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone_in_talk,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.claudiuProblemReportCallLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.supportPhone,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

