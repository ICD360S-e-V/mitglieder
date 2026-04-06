import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/secure_storage_helper.dart';
import '../widgets/login_tab.dart';
import '../widgets/approval_waiting_dialog.dart';
import '../utils/error_helpers.dart';
import 'mitglied_dashboard.dart';
import 'webview_screen.dart';

class LoginPage extends StatefulWidget {
  final String? prefillMitgliedernummer;

  const LoginPage({super.key, this.prefillMitgliedernummer});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _apiService = ApiService();
  final _secureStorage = createSecureStorage();
  final _mitgliedernummerController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.prefillMitgliedernummer != null) {
      _mitgliedernummerController.text = widget.prefillMitgliedernummer!;
    }
    _tryAutoLogin();
  }

  /// Check for saved approval token → auto-login on known device
  Future<void> _tryAutoLogin() async {
    try {
      final savedMnr = await _secureStorage.read(key: 'approval_mitgliedernummer');
      if (savedMnr != null && widget.prefillMitgliedernummer == null) {
        _mitgliedernummerController.text = savedMnr;
        // Try auto-login via login_request (server checks if device is known)
        await _login();
      }
    } catch (e) {
      debugPrint('[Login] Auto-login check failed: $e');
    }
  }

  Future<void> _login() async {
    final mitgliedernummer = _mitgliedernummerController.text.trim();
    if (mitgliedernummer.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _apiService.requestLoginApproval(mitgliedernummer);

      if (!mounted) return;

      if (result['success'] == true) {
        final data = result['data'] ?? result;

        // AUTO-APPROVED: Known device → instant login
        if (data['auto_approved'] == true) {
          await _handleAutoApproved(data, mitgliedernummer);
          return;
        }

        // NEW DEVICE: Show waiting dialog
        setState(() => _isLoading = false);

        final requestToken = data['request_token'] as String;
        final memberName = data['member_name'] as String? ?? mitgliedernummer;
        final expiresAt = data['expires_at'] as String? ?? '';

        if (!mounted) return;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ApprovalWaitingDialog(
            requestToken: requestToken,
            memberName: memberName,
            expiresAt: expiresAt,
            onApproved: (approvedData) {
              Navigator.pop(ctx);
              _handleApprovalSuccess(approvedData, mitgliedernummer);
            },
            onDenied: () {
              Navigator.pop(ctx);
              if (mounted) {
                setState(() => _errorMessage = 'Login-Anfrage wurde abgelehnt.');
              }
            },
            onExpired: () {
              Navigator.pop(ctx);
              if (mounted) {
                setState(() => _errorMessage = 'Anfrage abgelaufen. Bitte erneut versuchen.');
              }
            },
          ),
        );
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Anmeldung fehlgeschlagen';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'LOGIN');
          _isLoading = false;
        });
      }
    }
  }

  /// Handle auto-approved login (known device)
  Future<void> _handleAutoApproved(Map<String, dynamic> data, String mitgliedernummer) async {
    final user = data['user'];
    if (user == null) {
      setState(() {
        _errorMessage = 'Login-Fehler';
        _isLoading = false;
      });
      return;
    }

    await _apiService.saveTokens(
      data['token'], data['refresh_token'] ?? '',
      mitgliedernummer: mitgliedernummer,
    );

    // Save mitgliedernummer for next auto-login
    await _secureStorage.write(key: 'approval_mitgliedernummer', value: mitgliedernummer);

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MitgliedDashboard(
          userName: user['name'],
          mitgliedernummer: user['mitgliedernummer'],
          email: user['email'] ?? '',
          status: user['status'] ?? 'active',
        ),
      ),
      (route) => false,
    );
  }

  /// Handle admin-approved login (new device)
  Future<void> _handleApprovalSuccess(Map<String, dynamic> data, String mitgliedernummer) async {
    final user = data['user'];
    if (user == null) return;

    // Save approval token for future auto-login
    final approvalToken = data['approval_token'];
    if (approvalToken != null) {
      await _secureStorage.write(key: 'approval_token', value: approvalToken);
    }
    await _secureStorage.write(key: 'approval_mitgliedernummer', value: mitgliedernummer);

    await _apiService.saveTokens(
      data['token'], data['refresh_token'] ?? '',
      mitgliedernummer: mitgliedernummer,
    );

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MitgliedDashboard(
          userName: user['name'],
          mitgliedernummer: user['mitgliedernummer'],
          email: user['email'] ?? '',
          status: user['status'] ?? 'active',
        ),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _mitgliedernummerController.dispose();
    super.dispose();
  }

  // Helper function for responsive font size
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.85;
    if (width < 400) return baseSize * 0.95;
    return baseSize;
  }

  double _getResponsiveSpacing(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.5;
    if (width < 400) return baseSize * 0.75;
    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Expanded(
                      child: Text(
                        l10n.login,
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Logo
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.login, size: 48, color: Color(0xFF4a90d9)),
                      ),
                      const SizedBox(height: 16),
                      // Form
                      LoginTab(
                        mitgliedernummerController: _mitgliedernummerController,
                        isLoading: _isLoading,
                        errorMessage: _errorMessage,
                        onLogin: _login,
                      ),
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
    );
  }

  Widget _buildFooter() {
    final l10n = AppLocalizations.of(context)!;
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    if (keyboardVisible) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _getResponsiveSpacing(context, 16),
        horizontal: _getResponsiveSpacing(context, 20),
      ),
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
            'v1.1.26',
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
      onTap: () => WebViewScreen.openUrl(context, text, url),
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
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.4),
        fontSize: _getResponsiveFontSize(context, 12),
      ),
    );
  }
}
