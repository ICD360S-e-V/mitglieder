import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/diagnostic_service.dart';
import '../services/secure_storage_helper.dart';
import '../widgets/claudiu_welcome.dart';
import '../widgets/diagnostic_consent_dialog.dart';
import '../widgets/eastern.dart';
import 'mitglied_dashboard.dart';
import 'webview_screen.dart';

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
    } else {
      debugPrint('[Welcome] NO AUTO-LOGIN: No saved mitgliedernummer');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
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
    if (mounted) {
      setState(() {
        _isLoading = false;
        _isAutoLogging = false;
      });
    }
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
                  child: const Icon(Icons.groups, size: 56, color: Color(0xFF4a90d9)),
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
                const CircularProgressIndicator(color: Color(0xFF4a90d9)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SeasonalBackground(
        child: Container(
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
