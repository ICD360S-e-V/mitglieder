import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/wizard_service.dart';
import 'wizard_age_gate_screen.dart';
import 'wizard_document_accept_screen.dart';
import 'wizard_final_screen.dart';
import 'wizard_intro_screen.dart';
import 'wizard_stufe_1a_screen.dart';
import 'wizard_stufe_1b_screen.dart';
import 'wizard_stufe_1b1_screen.dart';
import 'wizard_stufe_1c_screen.dart';
import 'wizard_stufe_1d_screen.dart';
import 'wizard_stufe_1e_screen.dart';
import 'wizard_stufe_1f_screen.dart';
import 'wizard_stufe_2_screen.dart';
import 'wizard_stufe_3_screen.dart';
import 'wizard_stufe_4_screen.dart';
import 'wizard_stufe_5_screen.dart';

/// Top-level orchestrator for the onboarding wizard. Wires the 14
/// stage screens together, drives the navigation graph, hides Stufe 4
/// for fee-exempt visitors (bürgergeld / sozialamt), short-circuits
/// to the AgeGate when the visitor is under 16, and finalises the
/// draft into a real `users` row when Stufe 8 ships. Welcome screen
/// pushes this widget onto the navigator and `Navigator.pop` exits
/// back to welcome.
class WizardScreen extends StatefulWidget {
  const WizardScreen({super.key});

  @override
  State<WizardScreen> createState() => _WizardScreenState();
}

/// Lifecycle phases. Drives the top-level switch in [build].
enum _Phase { loading, active, ageGate, finished, error }

/// Document metadata fed into the reusable Stufe 6/7/8 screen.
class _DocSpec {
  final int stepNumber;
  final WizardStep step;
  final String dataKey;
  final String documentName;
  final String url;
  const _DocSpec({
    required this.stepNumber,
    required this.step,
    required this.dataKey,
    required this.documentName,
    required this.url,
  });
}

const _kDocs = <_DocSpec>[
  _DocSpec(
    stepNumber: 6,
    step: WizardStep.stufe6,
    dataKey: 'satzung_read',
    documentName: 'Satzung',
    url: 'https://icd360s.de/satzung360s/',
  ),
  _DocSpec(
    stepNumber: 7,
    step: WizardStep.stufe7,
    dataKey: 'datenschutz_read',
    documentName: 'Datenschutzerklärung',
    url: 'https://icd360s.de/datenschutz',
  ),
  _DocSpec(
    stepNumber: 8,
    step: WizardStep.stufe8,
    dataKey: 'widerrufsbelehrung_read',
    documentName: 'Widerrufsbelehrung',
    url: 'https://icd360s.de/widerrufsrecht',
  ),
];

class _WizardScreenState extends State<WizardScreen> {
  _Phase _phase = _Phase.loading;
  WizardStep _step = WizardStep.intro;
  Map<String, dynamic> _data = const {};

  /// Verdict computed (or recomputed) from the visitor's birthdate.
  /// Drives whether Stufe 1b1 is part of the flow and whether the
  /// AgeGate fires.
  WizardAgeStatus? _ageStatus;

  /// Used by AgeGate / minor flows; computed from the birthdate (or
  /// from the device block date when the visitor was previously
  /// rejected and is now coming back).
  int _gateAge = 0;

  /// Set after Stufe 8 + finalize succeeds. Drives [WizardFinalScreen].
  WizardFinalizeResult? _finalizeResult;

  /// Last error code returned by finalize.php — surfaces specific UX
  /// when the server rejects with a recognised code (e.g.
  /// 'too_many_withdrawals'). Null when error was a generic failure.
  String? _errorCode;

  /// Visitor falls into the fee-exempt bucket when their Stufe 3
  /// answer is one of the recognised social benefits — Bürgergeld
  /// (SGB II), Sozialamt (SGB XII), Arbeitslosengeld I (SGB III) or
  /// Krankengeld (SGB V). Satzung §6 Abs. 4 allows the Vorstand to
  /// grant Erlass for these categories without amending the bylaws.
  bool get _isBeitragsfrei {
    final fs = _data['finanzielle_situation'];
    return fs == 'buergergeld' ||
        fs == 'sozialamt' ||
        fs == 'alg1' ||
        fs == 'krankengeld';
  }

  bool get _isMinor => _ageStatus == WizardAgeStatus.minor;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  // ---------------------------------------------------------------------------
  // Bootstrap.
  // ---------------------------------------------------------------------------

  Future<void> _bootstrap() async {
    // 0) Device-level under-16 block. Set during a previous wizard run
    // when check_age.php returned tooYoung. Survives until the visitor
    // would actually turn 16.
    if (await WizardService().isDeviceBlocked()) {
      final until = await WizardService().deviceBlockedUntil();
      // Block date == the visitor's 16th birthday. Today's age is
      // therefore 16 minus (year diff). Rough but the AgeGate copy
      // only uses it to compose "see you in N years" so the
      // approximation reads naturally.
      if (until != null) {
        final yearsUntil16 = until.year - DateTime.now().year;
        _gateAge = (16 - yearsUntil16).clamp(0, 16);
      }
      if (!mounted) return;
      setState(() => _phase = _Phase.ageGate);
      return;
    }

    // 1) Start or resume the draft.
    final startRes = await WizardService().start();
    if (startRes == null) {
      if (mounted) setState(() => _phase = _Phase.error);
      return;
    }

    // 2) Pull whatever the visitor previously saved.
    final state = await WizardService().getState();
    final dataRaw = (state?['data'] as Map<String, dynamic>?) ?? const {};
    // Stufe 3 reads files from data['leistungsbescheid_files'] — the
    // wizard_draft_files JOIN sits at the top of the getState payload,
    // so we merge it into the data map here.
    final data = <String, dynamic>{
      ...dataRaw,
      'leistungsbescheid_files': state?['leistungsbescheid_files'] ?? const [],
    };

    // 3) Recompute age status from the stored birthdate (resume case).
    WizardAgeStatus? ageStatus;
    int gateAge = 0;
    final iso = data['geburtsdatum'];
    if (iso is String && iso.isNotEmpty) {
      final birth = DateTime.tryParse(iso);
      if (birth != null) {
        final age = _computeAge(birth);
        if (age < 16) {
          ageStatus = WizardAgeStatus.tooYoung;
          gateAge = age;
        } else if (age < 18) {
          ageStatus = WizardAgeStatus.minor;
        } else {
          ageStatus = WizardAgeStatus.ok;
        }
      }
    }

    if (!mounted) return;
    setState(() {
      _data = data;
      _ageStatus = ageStatus;
      _gateAge = gateAge;
      _step = startRes.currentStep == WizardStep.introDone
          ? WizardStep.stufe1a
          : startRes.currentStep;
      _phase = ageStatus == WizardAgeStatus.tooYoung
          ? _Phase.ageGate
          : _Phase.active;
    });
  }

  int _computeAge(DateTime birth) {
    final now = DateTime.now();
    int age = now.year - birth.year;
    if (now.month < birth.month ||
        (now.month == birth.month && now.day < birth.day)) {
      age--;
    }
    return age;
  }

  // ---------------------------------------------------------------------------
  // Navigation.
  // ---------------------------------------------------------------------------

  /// Compute the next visible step. Skips Stufe 4 for fee-exempt
  /// visitors and Stufe 1b1 for non-minors.
  WizardStep? _nextStep(WizardStep from) {
    switch (from) {
      case WizardStep.intro:
      case WizardStep.introDone:
        return WizardStep.stufe1a;
      case WizardStep.stufe1a:
        return WizardStep.stufe1b;
      case WizardStep.stufe1b:
        // Handled by the screen's onAdvance callback (because the age
        // verdict only arrives at submit time). Defensive default:
        // route through 1b1 if we already know the visitor is a minor.
        return _isMinor ? WizardStep.stufe1b1 : WizardStep.stufe1c;
      case WizardStep.stufe1b1:
        return WizardStep.stufe1c;
      case WizardStep.stufe1c:
        return WizardStep.stufe1d;
      case WizardStep.stufe1d:
        return WizardStep.stufe1e;
      case WizardStep.stufe1e:
        return WizardStep.stufe1f;
      case WizardStep.stufe1f:
        return WizardStep.stufe2;
      case WizardStep.stufe2:
        return WizardStep.stufe3;
      case WizardStep.stufe3:
        return _isBeitragsfrei ? WizardStep.stufe5 : WizardStep.stufe4;
      case WizardStep.stufe3Upload:
        return _isBeitragsfrei ? WizardStep.stufe5 : WizardStep.stufe4;
      case WizardStep.stufe4:
        return WizardStep.stufe5;
      case WizardStep.stufe5:
        return WizardStep.stufe6;
      case WizardStep.stufe6:
        return WizardStep.stufe7;
      case WizardStep.stufe7:
        return WizardStep.stufe8;
      case WizardStep.stufe8:
        return null; // → finalize
      case WizardStep.done:
        return null;
    }
  }

  /// Compute the previous visible step. Mirrors the forward graph
  /// including the same skip logic so Back never lands on a screen
  /// that was hidden.
  WizardStep? _prevStep(WizardStep from) {
    switch (from) {
      case WizardStep.stufe1a:
        return WizardStep.intro;
      case WizardStep.stufe1b:
        return WizardStep.stufe1a;
      case WizardStep.stufe1b1:
        return WizardStep.stufe1b;
      case WizardStep.stufe1c:
        return _isMinor ? WizardStep.stufe1b1 : WizardStep.stufe1b;
      case WizardStep.stufe1d:
        return WizardStep.stufe1c;
      case WizardStep.stufe1e:
        return WizardStep.stufe1d;
      case WizardStep.stufe1f:
        return WizardStep.stufe1e;
      case WizardStep.stufe2:
        return WizardStep.stufe1f;
      case WizardStep.stufe3:
        return WizardStep.stufe2;
      case WizardStep.stufe4:
        return WizardStep.stufe3;
      case WizardStep.stufe5:
        return _isBeitragsfrei ? WizardStep.stufe3 : WizardStep.stufe4;
      case WizardStep.stufe6:
        return WizardStep.stufe5;
      case WizardStep.stufe7:
        return WizardStep.stufe6;
      case WizardStep.stufe8:
        return WizardStep.stufe7;
      default:
        return null;
    }
  }

  Future<void> _refreshData() async {
    final state = await WizardService().getState();
    if (state == null || !mounted) return;
    final dataRaw = (state['data'] as Map<String, dynamic>?) ?? const {};
    setState(() => _data = <String, dynamic>{
          ...dataRaw,
          'leistungsbescheid_files':
              state['leistungsbescheid_files'] ?? const [],
        });
  }

  Future<void> _goNext() async {
    // Always refresh the local snapshot before deciding — Stufe 3 may
    // have just flipped `finanzielle_situation`, which steers the
    // skip on the next call.
    await _refreshData();
    final next = _nextStep(_step);
    if (next == null) {
      await _finalize();
      return;
    }
    if (!mounted) return;
    setState(() => _step = next);
  }

  void _goBack() {
    final prev = _prevStep(_step);
    if (prev == null) {
      Navigator.of(context).maybePop();
      return;
    }
    setState(() => _step = prev);
  }

  Future<void> _finalize() async {
    if (!mounted) return;
    setState(() => _phase = _Phase.loading);
    final outcome = await WizardService().finalize();
    if (!mounted) return;
    if (!outcome.isSuccess) {
      setState(() {
        _errorCode = outcome.errorCode;
        _phase = _Phase.error;
      });
      return;
    }
    final result = outcome.result!;
    setState(() {
      _finalizeResult = result;
      _phase = _Phase.finished;
    });
  }

  Future<void> _exitFromFinal() async {
    // The draft already shipped — wipe the local anonymous_id so a
    // brand-new visitor on this device starts clean.
    await WizardService().resetLocal();
    if (mounted) Navigator.of(context).maybePop();
  }

  // ---------------------------------------------------------------------------
  // Render.
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    switch (_phase) {
      case _Phase.loading:
        return _LoadingScaffold();
      case _Phase.error:
        return _ErrorScaffold(
          onRetry: _bootstrap,
          errorCode: _errorCode,
        );
      case _Phase.ageGate:
        return WizardAgeGateScreen(
          age: _gateAge,
          onExit: () => Navigator.of(context).maybePop(),
        );
      case _Phase.finished:
        return WizardFinalScreen(
          result: _finalizeResult!,
          onClose: _exitFromFinal,
        );
      case _Phase.active:
        return _activeScreen();
    }
  }

  Widget _activeScreen() {
    switch (_step) {
      case WizardStep.intro:
      case WizardStep.introDone:
        return WizardIntroScreen(onStart: _goNext);
      case WizardStep.stufe1a:
        return WizardStufe1aScreen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe1b:
        return WizardStufe1bScreen(
          initial: _data,
          onBack: _goBack,
          onAdvance: (status) async {
            // Recompute gate age from the just-typed birthdate (the
            // service already saved it before returning the verdict).
            await _refreshData();
            final iso = _data['geburtsdatum'];
            if (iso is String) {
              final birth = DateTime.tryParse(iso);
              if (birth != null) _gateAge = _computeAge(birth);
            }
            if (!mounted) return;
            setState(() => _ageStatus = status);
            if (status == WizardAgeStatus.tooYoung) {
              setState(() => _phase = _Phase.ageGate);
              return;
            }
            // ok / minor — route via _nextStep so the skip stays
            // centralised.
            final next = _nextStep(WizardStep.stufe1b)!;
            setState(() => _step = next);
          },
        );
      case WizardStep.stufe1b1:
        return WizardStufe1b1Screen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe1c:
        return WizardStufe1cScreen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe1d:
        return WizardStufe1dScreen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe1e:
        return WizardStufe1eScreen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe1f:
        return WizardStufe1fScreen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe2:
        return WizardStufe2Screen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe3:
      case WizardStep.stufe3Upload:
        return WizardStufe3Screen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe4:
        return WizardStufe4Screen(
          initial: _data,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe5:
        return WizardStufe5Screen(
          initial: _data,
          isBeitragsfrei: _isBeitragsfrei,
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.stufe6:
      case WizardStep.stufe7:
      case WizardStep.stufe8:
        final spec = _kDocs.firstWhere((d) => d.step == _step);
        // ValueKey per dataKey forces Flutter to instantiate a fresh
        // State for each document. Without it, _confirmed / _opened /
        // _scrolledToBottom leak from one stufe to the next because
        // the orchestrator returns the same widget type at the same
        // tree position — the visitor would arrive at Stufe 7 with
        // the checkbox already ticked and the WebView pointing at
        // the previous URL.
        return WizardDocumentAcceptScreen(
          key: ValueKey(spec.dataKey),
          stepNumber: spec.stepNumber,
          step: spec.step,
          dataKey: spec.dataKey,
          documentName: spec.documentName,
          url: spec.url,
          initialAccepted: _data['${spec.dataKey}'] == 1 ||
              _data['${spec.dataKey}'] == true ||
              _data['${spec.dataKey}'] == '1',
          onNext: _goNext,
          onBack: _goBack,
        );
      case WizardStep.done:
        // Defensive: shouldn't render this directly; finalise drives
        // the finished phase instead.
        return const SizedBox.shrink();
    }
  }
}

// ---------------------------------------------------------------------------
// Loading + error scaffolds.
// ---------------------------------------------------------------------------

class _LoadingScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}

class _ErrorScaffold extends StatelessWidget {
  final VoidCallback onRetry;
  final String? errorCode;
  const _ErrorScaffold({required this.onRetry, this.errorCode});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // `too_many_withdrawals` = finalize.php rejected because the
    // applicant's name+DOB hash matched ≥3 recent withdrawn rows.
    // Retry won't help — they need to talk to a human.
    final isAbuseBlock = errorCode == 'too_many_withdrawals';
    final icon = isAbuseBlock ? Icons.report_outlined : Icons.cloud_off;
    final message = isAbuseBlock
        ? l10n.wizardErrTooManyWithdrawals
        : l10n.wizardErrSaveFailed;
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 56, color: Colors.white70),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.claudiuAnonymousChatRetry),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0d47a1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: Text(
                    l10n.wizardAgeGateBackHome,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
