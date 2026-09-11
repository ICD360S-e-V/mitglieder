import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/diagnostic_service.dart';
import '../services/secure_storage_helper.dart';
import '../services/wizard_service.dart';
import '../widgets/claudiu_welcome.dart';
import '../widgets/diagnostic_consent_dialog.dart';
import '../widgets/eastern.dart';
import 'mitglied_dashboard.dart';
import 'webview_screen.dart';
import 'wizard_final_screen.dart';
import 'wizard_screen.dart';
import '../utils/app_theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _apiService = ApiService();
  final _secureStorage = createSecureStorage();
  bool _isLoading = true;
  bool _isAutoLogging = false;
  String _appVersion = '...';

  /// Set when this device has an unfinished (or awaiting-approval)
  /// registration AND the visitor deliberately stepped out of it.
  /// Renders the resume banner instead of pushing them back into the
  /// wizard — the launch-time push used to make the flow impossible
  /// to leave, because popping it only lasted until the next start.
  WizardStatusProbe? _pendingRegistration;

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _appVersion = info.version);
  }

  Future<void> _checkAutoLogin() async {
    debugPrint('[Welcome] _checkAutoLogin called');

    // Show diagnostic consent first
    if (mounted) {
      await checkAndShowDiagnosticConsent(context);
      DiagnosticService().setScreen('welcome');
    }

    // Check for saved mitgliedernummer (passwordless auto-login)
    String? savedMnr;
    try {
      savedMnr = await _secureStorage.read(key: 'approval_mitgliedernummer');
      debugPrint('[Welcome] Saved mitgliedernummer: ${savedMnr != null ? "found" : "none"}');
    } catch (e) {
      debugPrint('[Welcome] SecureStorage read failed: $e');
    }

    if (savedMnr != null && savedMnr.isNotEmpty) {
      debugPrint('[Welcome] AUTO-LOGIN: Attempting passwordless login for $savedMnr');
      if (!mounted) return;
      setState(() => _isAutoLogging = true);
      await _performAutoLogin(savedMnr);
      // If auto-login navigated us away (pushReplacement → dashboard)
      // mounted is false and we skip the wizard probe.
      if (!mounted) return;
    }
    // Visitor finalised the wizard previously and closed the app while
    // waiting on Vorstand validation — resume them on the final/waiting
    // screen instead of dropping them on the welcome buttons. Also
    // handles the mid-wizard resume (status = 'nicht_verifiziert').
    await _resumePendingRegistration();
    if (mounted) {
      setState(() {
        _isLoading = false;
        _isAutoLogging = false;
      });
    }
  }

  /// Decides what to do about a registration this device has already
  /// started: walk the visitor straight back into it, or just offer.
  ///
  /// Straight back in is the default — someone whose app was killed
  /// mid-form wants to land where they left off. But when they left
  /// on purpose (the wizard's "continue later", or the waiting
  /// screen's "back to menu"), forcing them back is what made the
  /// registration inescapable: popping the route only held until the
  /// next launch. In that case we render [_resumeBanner] instead and
  /// let them decide.
  Future<void> _resumePendingRegistration() async {
    final probe = await _probePendingRegistration();
    if (probe == null || !mounted) return;
    if (await WizardService().isAutoResumeSuppressed()) {
      if (mounted) setState(() => _pendingRegistration = probe);
      return;
    }
    if (!mounted) return;
    await _openPendingRegistration(probe);
  }

  /// Returns the probe when this device has a registration worth
  /// resuming, null when there is nothing to go back to (no draft,
  /// active member, or already withdrawn).
  Future<WizardStatusProbe?> _probePendingRegistration() async {
    try {
      final probe = await WizardService().checkUserStatus();
      if (probe == null) return null;
      final status = probe.status;
      if (status == 'neu' || status == 'waiting_for_parent_consent') {
        // Without a user_id there is no application to show.
        return probe.userId == null ? null : probe;
      }
      // status==null happens when wizard_drafts exists but the users
      // stub hasn't been created yet (visitor closed the app at Stufe
      // 1a, before check_age.php ran).
      if (status == 'nicht_verifiziert' || status == null) return probe;
      return null;
    } catch (e) {
      debugPrint('[Welcome] Pending registration probe failed: $e');
      return null;
    }
  }

  /// Pushes the right screen for [probe]: the status/waiting screen
  /// for a submitted application, the wizard itself for a draft that
  /// still has steps left. Re-syncs the banner once it returns.
  Future<void> _openPendingRegistration(WizardStatusProbe probe) async {
    final status = probe.status;
    if (status == 'neu' || status == 'waiting_for_parent_consent') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => WizardFinalScreen(
            result: WizardFinalizeResult(
              mitgliedernummer: probe.mitgliedernummer ?? '',
              userId:           probe.userId!,
              status:           status!,
              isMinor:          probe.isMinor,
              // message is only displayed on the immediate post-
              // finalize render; the polling on the screen rewrites
              // the visible labels from check_status.php so an
              // empty string here is harmless on resume.
              message:          '',
            ),
            // Deliberately no resetLocal: the anonymous_id is this
            // device's only handle on the pending application, and
            // dropping it would strand the visitor with a
            // Mitgliedernummer the app can no longer look up.
            // WizardFinalScreen has already recorded that the visitor
            // wants the welcome screen instead of this one next time.
            onClose: () {
              if (mounted) Navigator.of(context).maybePop();
            },
          ),
        ),
      );
    } else {
      // WizardScreen resumes to whichever current_step is recorded.
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const WizardScreen()),
      );
    }
    if (!mounted) return;
    await _syncResumeBanner();
  }

  /// Re-reads the server state after the visitor comes back out of a
  /// registration screen. Three outcomes: they stepped out again
  /// (banner returns, with a fresh status), they withdrew (resetLocal
  /// dropped the anonymous_id, so the probe finds nothing), or they
  /// finished (login takes over from here).
  Future<void> _syncResumeBanner() async {
    final suppressed = await WizardService().isAutoResumeSuppressed();
    final probe = suppressed ? await _probePendingRegistration() : null;
    if (!mounted) return;
    setState(() => _pendingRegistration = probe);
  }

  Future<void> _resumeFromBanner() async {
    final probe = _pendingRegistration;
    if (probe == null) return;
    // From here on the automatic launch-time resume is welcome again.
    await WizardService().clearAutoResumeSuppression();
    if (!mounted) return;
    setState(() => _pendingRegistration = null);
    await _openPendingRegistration(probe);
  }

  Future<void> _performAutoLogin(String mitgliedernummer) async {
    try {
      // Use passwordless login (server auto-approves known devices)
      final result = await _apiService.requestLoginApproval(mitgliedernummer);

      if (result['success'] == true && mounted) {
        final data = result['data'] ?? result;

        if (data['auto_approved'] == true) {
          final user = data['user'];
          await _apiService.saveTokens(
            data['token'], data['refresh_token'] ?? '',
            mitgliedernummer: mitgliedernummer,
          );
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MitgliedDashboard(
                userName: user['name'],
                mitgliedernummer: user['mitgliedernummer'],
                email: user['email'] ?? '',
                status: user['status'] ?? 'active',
              ),
            ),
          );
          return;
        }
      }
    } catch (e) {
      debugPrint('[Welcome] Auto-login failed: $e');
    }
    // Loading flags are cleared by _checkAutoLogin after the wizard
    // resume probe completes — keeps the spinner up across both
    // probes so the welcome buttons don't flash mid-redirect.
  }

  // Helper function for responsive font size
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    // For small screens (< 360px), scale down to 85%
    // For medium screens (360-400px), scale to 95%
    // For large screens (> 400px), use base size
    if (width < 360) {
      return baseSize * 0.85;
    } else if (width < 400) {
      return baseSize * 0.95;
    }
    return baseSize;
  }

  // Helper function for responsive spacing
  double _getResponsiveSpacing(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) {
      return baseSize * 0.5;
    } else if (width < 400) {
      return baseSize * 0.75;
    }
    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _isAutoLogging) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: context.colors.heroGradient,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.groups, size: 56, color: context.colors.brand),
                ),
                SizedBox(height: _getResponsiveSpacing(context, 24)),
                Text(
                  'ICD360S e.V',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: _getResponsiveSpacing(context, 8)),
                Builder(
                  builder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return Text(
                      _isAutoLogging ? l10n.welcomeAutoLogin : l10n.welcomeLoading,
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 14),
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    );
                  },
                ),
                SizedBox(height: _getResponsiveSpacing(context, 24)),
                CircularProgressIndicator(color: context.colors.brand),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SeasonalBackground(
        child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: context.colors.heroGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: _getResponsiveSpacing(context, 32)),
                  child: Column(
                    children: [
                      SizedBox(height: _getResponsiveSpacing(context, 80)),
                      // Title
                      Text(
                        'ICD360S e.V',
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 38),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: _getResponsiveSpacing(context, 16)),
                      // Slogan with colored words
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            'INTEGRATION',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 11),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4FC3F7), // Light blue
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '•',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 11),
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                          Text(
                            'CHANCEN',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 11),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFFB74D), // Orange
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '•',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 11),
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                          Text(
                            'DIVERSITY',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 11),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF81C784), // Green
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: _getResponsiveSpacing(context, 4)),
                      Text(
                        '360° SUPPORT',
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 12),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4FC3F7), // Light blue
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: _getResponsiveSpacing(context, 32)),
                      if (_pendingRegistration != null) ...[
                        _resumeBanner(_pendingRegistration!),
                        SizedBox(height: _getResponsiveSpacing(context, 20)),
                      ],
                      // Claudiu — conversational welcome. Replaces the old
                      // Anmelden / Mitglied werden / email / phone / SOS
                      // button stack; every action a visitor previously
                      // reached through those buttons now lives inside his
                      // option list, framed as a question.
                      ClaudiuWelcome(
                        scale: _getResponsiveFontSize(context, 14) / 14.0,
                      ),
                      SizedBox(height: _getResponsiveSpacing(context, 32)),
                    ],
                  ),
                ),
              ),
              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
      ),
    );
  }

  /// The gentle half of the fix for the inescapable wizard: the
  /// registration is still there and one tap away, but it no longer
  /// takes the screen hostage on every launch.
  ///
  /// Two shapes, because the two states need different words — a
  /// half-filled form invites "carry on", a submitted application
  /// only invites "check on it".
  Widget _resumeBanner(WizardStatusProbe probe) {
    final l10n = AppLocalizations.of(context)!;
    final isSubmitted = probe.status == 'neu' ||
        probe.status == 'waiting_for_parent_consent';
    final title = isSubmitted
        ? l10n.wizardResumeBannerPendingTitle
        : l10n.wizardResumeBannerTitle;
    final body = isSubmitted
        ? l10n.wizardResumeBannerPendingBody
        : l10n.wizardResumeBannerBody;
    final action = isSubmitted
        ? l10n.wizardResumeBannerPendingAction
        : l10n.wizardResumeBannerAction;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isSubmitted ? Icons.hourglass_top : Icons.edit_note,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          if (probe.mitgliedernummer != null &&
              probe.mitgliedernummer!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              probe.mitgliedernummer!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                letterSpacing: 0.9,
              ),
            ),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _resumeFromBanner,
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: Text(action),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.card,
                foregroundColor: context.colors.brandStrong,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(vertical: _getResponsiveSpacing(context, 16), horizontal: _getResponsiveSpacing(context, 20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: _getResponsiveSpacing(context, 8),
            runSpacing: _getResponsiveSpacing(context, 4),
            children: [
              _buildFooterLink(l10n.imprint, 'https://icd360s.de/impressum'),
              _buildFooterDivider(),
              _buildFooterLink(l10n.privacy, 'https://icd360s.de/datenschutz'),
              _buildFooterDivider(),
              _buildFooterLink(l10n.statutes, 'https://icd360s.de/satzung360s/'),
            ],
          ),
          SizedBox(height: _getResponsiveSpacing(context, 12)),
          Text(
            'v$_appVersion',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: _getResponsiveFontSize(context, 11),
            ),
          ),
          SizedBox(height: _getResponsiveSpacing(context, 4)),
          Text(
            '© 2025-${DateTime.now().year} ICD360S e.V.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: _getResponsiveFontSize(context, 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, String url) {
    return InkWell(
      onTap: () {
        WebViewScreen.openUrl(context, text, url);
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: _getResponsiveFontSize(context, 12),
            decoration: TextDecoration.underline,
            decorationColor: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterDivider() {
    return Text(
      '|',
      style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12),
    );
  }

}
