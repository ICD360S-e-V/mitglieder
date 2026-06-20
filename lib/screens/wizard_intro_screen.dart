import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import '../widgets/icd360s_header.dart';

/// First screen of the onboarding wizard — Claudiu narrates the
/// association's founding story across six bubbles that fade in on a
/// scripted timeline. The visitor reads, then taps "Let's start" once
/// the closing bubble lands.
///
/// Timeline (each bubble fades in over 400ms after its delay):
///
///   T+0s    👋 Welcome.
///   T+3s    The vision.
///   T+7s    The 6 founders meet in July 2025.
///   T+12s   The Verein is registered on 2025-08-01.
///   T+17s   What we do + who we help (+ inclusive Vorstand note).
///   T+22s   "Your turn — let's enrol you in 5 minutes."
///   T+24s   Closing CTA button slides in.
///
/// Story copy is provided by .arb (no inline fallback). The mascot
/// is the same placeholder icon as the rest of Claudiu's surfaces —
/// swap to Rive/Lottie in the dedicated task.
class WizardIntroScreen extends StatefulWidget {
  /// Called when the visitor taps the closing CTA. The wizard parent
  /// is responsible for advancing to the next step (Stufe 1a).
  final VoidCallback onStart;

  const WizardIntroScreen({super.key, required this.onStart});

  @override
  State<WizardIntroScreen> createState() => _WizardIntroScreenState();
}

class _WizardIntroScreenState extends State<WizardIntroScreen> {
  static const _bubbleDelays = [
    Duration(seconds: 0),
    Duration(seconds: 3),
    Duration(seconds: 7),
    Duration(seconds: 12),
    Duration(seconds: 17),
    Duration(seconds: 22),
  ];
  static const _ctaDelay = Duration(seconds: 24);

  bool _saving = false;

  Future<void> _start() async {
    if (_saving) return;
    setState(() => _saving = true);
    // Mark intro as done in the server draft so a resume picks the
    // wizard up at Stufe 1a instead of replaying the story.
    await WizardService().saveStep(WizardStep.introDone, const {});
    if (!mounted) return;
    setState(() => _saving = false);
    widget.onStart();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bubbles = [
      l10n.wizardIntroBubble1,
      l10n.wizardIntroBubble2,
      l10n.wizardIntroBubble3,
      l10n.wizardIntroBubble4,
      l10n.wizardIntroBubble5,
      l10n.wizardIntroBubble6,
    ];

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
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Icd360sHeader(compact: true),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < bubbles.length; i++) ...[
                        _bubble(bubbles[i])
                            .animate()
                            .fadeIn(
                              delay: _bubbleDelays[i],
                              duration: 400.ms,
                            )
                            .slideY(
                              begin: 0.15,
                              end: 0,
                              delay: _bubbleDelays[i],
                              duration: 400.ms,
                              curve: Curves.easeOut,
                            ),
                        if (i < bubbles.length - 1) const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                child: _startButton(l10n)
                    .animate()
                    .fadeIn(delay: _ctaDelay, duration: 500.ms)
                    .slideY(
                      begin: 0.4,
                      end: 0,
                      delay: _ctaDelay,
                      duration: 500.ms,
                      curve: Curves.easeOutCubic,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bubble(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mascot(),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                  text,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF0d47a1),
                    height: 1.5,
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

  Widget _startButton(AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _saving ? null : _start,
        icon: _saving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Color(0xFF0d47a1),
                  strokeWidth: 2.5,
                ),
              )
            : const Icon(Icons.arrow_forward, size: 22),
        label: Text(
          l10n.wizardIntroStart,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0d47a1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
