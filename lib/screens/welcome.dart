import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/diagnostic_service.dart';
import '../services/secure_storage_helper.dart';
import '../widgets/diagnostic_consent_dialog.dart';
import '../widgets/eastern.dart';
import 'login.dart';
import 'register.dart';
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

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    debugPrint('[Welcome] _checkAutoLogin called');
    final prefs = await SharedPreferences.getInstance();
    final autoLogin = prefs.getBool('auto_login') ?? false;
    final rememberMe = prefs.getBool('remember_me') ?? false;
    debugPrint('[Welcome] SharedPreferences - auto_login=$autoLogin, remember_me=$rememberMe');
    String? savedMitgliedernummer;
    String? savedPassword;
    try {
      savedMitgliedernummer = await _secureStorage.read(key: 'mitgliedernummer');
      savedPassword = await _secureStorage.read(key: 'password');
      // Security: No password metadata in logs
      debugPrint('[Welcome] Credentials loaded from SecureStorage');
    } catch (e, stackTrace) {
      debugPrint('[Welcome] SecureStorage read FAILED: $e');
      debugPrint('[Welcome] StackTrace: $stackTrace');
    }

    // Show diagnostic consent first
    if (mounted) {
      await checkAndShowDiagnosticConsent(context);
      DiagnosticService().setScreen('welcome');
    }

    if (autoLogin &&
        savedMitgliedernummer != null &&
        savedMitgliedernummer.isNotEmpty &&
        savedPassword != null &&
        savedPassword.isNotEmpty) {
      debugPrint('[Welcome] AUTO-LOGIN: All conditions met, performing auto-login');
      // Auto-login
      if (!mounted) return;
      setState(() => _isAutoLogging = true);
      await _performAutoLogin(savedMitgliedernummer, savedPassword);
    } else {
      debugPrint('[Welcome] NO AUTO-LOGIN: autoLogin=$autoLogin, mnr=${savedMitgliedernummer != null && savedMitgliedernummer.isNotEmpty}, pwd=${savedPassword != null && savedPassword.isNotEmpty}');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _performAutoLogin(String mitgliedernummer, String password) async {
    try {
      final result = await _apiService.login(mitgliedernummer, password);
      if (result['success'] == true && mounted) {
        final user = result['user'];
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
    } catch (e) {
      // Auto-login failed, show welcome screen
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
                      SizedBox(height: _getResponsiveSpacing(context, 40)),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: Builder(
                          builder: (context) {
                            final l10n = AppLocalizations.of(context)!;
                            return OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.login, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    l10n.login,
                                    style: TextStyle(fontSize: _getResponsiveFontSize(context, 18), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: _getResponsiveSpacing(context, 20)),
                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: Builder(
                          builder: (context) {
                            final l10n = AppLocalizations.of(context)!;
                            return OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.person_add, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    l10n.becomeMember,
                                    style: TextStyle(fontSize: _getResponsiveFontSize(context, 18), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: _getResponsiveSpacing(context, 40)),
                      // Contact buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Email button
                          _buildContactButton(
                            icon: Icons.alternate_email,
                            onTap: () => _launchEmail(),
                          ),
                          const SizedBox(width: 24),
                          // Phone button
                          _buildContactButton(
                            icon: Icons.phone,
                            onTap: () => _launchPhone(),
                          ),
                          const SizedBox(width: 24),
                          // SOS button
                          _buildContactButton(
                            icon: Icons.sos,
                            onTap: () => _showSosDialog(),
                          ),
                        ],
                      ),
                      SizedBox(height: _getResponsiveSpacing(context, 40)),
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
            'v1.1.14',
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

  Widget _buildContactButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  Future<void> _launchEmail() async {
    final l10n = AppLocalizations.of(context)!;
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mitglied@icd360s.de',
      queryParameters: {
        'subject': l10n.emailSubject,
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+4916094482053',
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _showSosDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.sos, color: Colors.red, size: 28),
            const SizedBox(width: 12),
            Text(l10n.needHelp),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.helpQuestion,
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(height: _getResponsiveSpacing(context, 16)),
            Text(
              l10n.helpDescription,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _launchWhatsApp();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            icon: const Icon(Icons.chat, size: 20),
            label: Text(l10n.whatsapp),
          ),
        ],
      ),
    );
  }

  Future<void> _launchWhatsApp() async {
    final l10n = AppLocalizations.of(context)!;
    const phoneNumber = '4916094482053';
    final message = l10n.whatsappMessage;
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }
}
