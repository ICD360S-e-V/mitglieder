import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 6/7/8 — Document acceptance. One reusable screen instantiated
/// three times by the orchestrator, once per legal document:
///
///   • Stufe 6 — Satzung
///   • Stufe 7 — Datenschutzerklärung
///   • Stufe 8 — Widerrufsbelehrung
///
/// On platforms that support an embedded WebView (Android / iOS /
/// macOS) the doc renders inline and a JavaScript scroll listener
/// flips a flag when the visitor reaches the bottom. Only then does
/// the "I have read and agree" checkbox light up — proof they at
/// least scrolled the page rather than instantly tapping a tickbox.
///
/// On platforms without WebView (Linux, Windows, web) we open the
/// URL in the system browser and enable the checkbox after the
/// visitor returns — same legal outcome, simpler UX.
class WizardDocumentAcceptScreen extends StatefulWidget {
  /// Which Stufe this is (6, 7 or 8). Used for the top-bar
  /// indicator + the WizardStep enum lookup.
  final int stepNumber;

  /// The enum value the server expects in save_step.php (stufe6 /
  /// stufe7 / stufe8).
  final WizardStep step;

  /// The data field name (without `data_` prefix) to flip true on
  /// save — `satzung_read`, `datenschutz_read`, or
  /// `widerrufsbelehrung_read`. The server adds the prefix.
  final String dataKey;

  /// Human-readable document name surfaced in prompts and buttons —
  /// "Satzung", "Datenschutzerklärung", "Widerrufsbelehrung". Not
  /// translated; the document files themselves are in German and
  /// keeping the term recognisable is more important than
  /// translation here.
  final String documentName;

  /// Public URL to render. Comes from the orchestrator.
  final String url;

  /// Whether the visitor previously confirmed this document in a
  /// past wizard session (from `wizard_drafts.data_*_read`). Pre-
  /// flags the checkbox so a resume doesn't make them re-read.
  final bool initialAccepted;

  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardDocumentAcceptScreen({
    super.key,
    required this.stepNumber,
    required this.step,
    required this.dataKey,
    required this.documentName,
    required this.url,
    required this.onNext,
    this.onBack,
    this.initialAccepted = false,
  });

  @override
  State<WizardDocumentAcceptScreen> createState() =>
      _WizardDocumentAcceptScreenState();
}

class _WizardDocumentAcceptScreenState
    extends State<WizardDocumentAcceptScreen> {
  static bool get _supportsInlineWebView =>
      Platform.isAndroid || Platform.isIOS || Platform.isMacOS;

  WebViewController? _webController;
  bool _scrolledToBottom = false;
  bool _opened = false;
  bool _confirmed = false;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _confirmed = widget.initialAccepted;
    if (widget.initialAccepted) {
      _scrolledToBottom = true; // resume: don't gate the checkbox again
      _opened = true;
    }
    if (_supportsInlineWebView) {
      _initWebView();
    }
  }

  void _initWebView() {
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel(
        'ScrollChannel',
        onMessageReceived: (msg) {
          if (msg.message == 'bottom' && mounted && !_scrolledToBottom) {
            setState(() => _scrolledToBottom = true);
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _loading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
            // Inject the scroll listener. The 60-px tolerance handles
            // address-bar height differences on iOS Safari WebView.
            _webController?.runJavaScript('''
              (function() {
                var notified = false;
                function check() {
                  if (notified) return;
                  var doc = document.documentElement;
                  var threshold = (doc.scrollHeight - 60);
                  if ((window.innerHeight + window.scrollY) >= threshold) {
                    notified = true;
                    ScrollChannel.postMessage('bottom');
                  }
                }
                window.addEventListener('scroll', check, { passive: true });
                // Also poll once a second to catch short pages whose
                // content fits without ever firing a scroll event.
                setInterval(check, 1000);
                check();
              })();
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _openExternal() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (mounted) {
        setState(() {
          _opened = true;
          _scrolledToBottom = true; // can't detect from external browser
        });
      }
    }
  }

  bool get _canConfirm => _scrolledToBottom || _opened;
  bool get _canSubmit => _confirmed && !_saving;

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(widget.step, {
      widget.dataKey: 1,
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrSaveFailed),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(
        widget.stepNumber,
        8,
        widget.documentName,
      ),
      prompt: l10n.wizardDocumentPrompt(widget.documentName),
      onBack: widget.onBack,
      onNext: _canSubmit ? _submit : null,
      saving: _saving,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_supportsInlineWebView)
            _inlineWebView(l10n)
          else
            _externalLauncher(l10n),
          const SizedBox(height: 14),
          _statusLine(l10n),
          const SizedBox(height: 8),
          _confirmRow(l10n),
        ],
      ),
    );
  }

  Widget _inlineWebView(AppLocalizations l10n) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (_webController != null)
            WebViewWidget(controller: _webController!)
          else
            const SizedBox.shrink(),
          if (_loading)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _externalLauncher(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.description_outlined,
              color: Colors.white, size: 48),
          const SizedBox(height: 10),
          Text(
            widget.documentName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.wizardDocumentExternalHint,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: _openExternal,
            icon: const Icon(Icons.open_in_new),
            label: Text(l10n.wizardDocumentOpenButton(widget.documentName)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0d47a1),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusLine(AppLocalizations l10n) {
    final IconData icon;
    final String text;
    final Color color;
    if (_supportsInlineWebView) {
      if (_scrolledToBottom) {
        icon = Icons.check_circle;
        text = l10n.wizardDocumentScrolledOk;
        color = Colors.greenAccent.shade100;
      } else {
        icon = Icons.swap_vert;
        text = l10n.wizardDocumentScrollHint;
        color = Colors.amber.shade100;
      }
    } else {
      if (_opened) {
        icon = Icons.check_circle;
        text = l10n.wizardDocumentOpenedOk;
        color = Colors.greenAccent.shade100;
      } else {
        icon = Icons.open_in_new;
        text = l10n.wizardDocumentExternalHint;
        color = Colors.amber.shade100;
      }
    }
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _confirmRow(AppLocalizations l10n) {
    return InkWell(
      onTap: _canConfirm ? () => setState(() => _confirmed = !_confirmed) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: _canConfirm
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _canConfirm
                ? Colors.white.withValues(alpha: 0.45)
                : Colors.white.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _confirmed
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: _canConfirm
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.45),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.wizardDocumentConfirm(widget.documentName),
                style: TextStyle(
                  color: _canConfirm
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.55),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
