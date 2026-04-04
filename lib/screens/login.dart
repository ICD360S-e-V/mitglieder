import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/secure_storage_helper.dart';
import '../widgets/login_tab.dart';
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
  final _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _autoLogin = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.prefillMitgliedernummer != null) {
      _mitgliedernummerController.text = widget.prefillMitgliedernummer!;
    }
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    debugPrint('[Login] _loadSavedCredentials called');
    final prefs = await SharedPreferences.getInstance();
    String? savedMitgliedernummer;
    String? savedPassword;
    try {
      savedMitgliedernummer = await _secureStorage.read(key: 'mitgliedernummer');
      savedPassword = await _secureStorage.read(key: 'password');
      // Security: Password metadata removed from logging
      debugPrint('[Login] Credentials loaded from SecureStorage');
    } catch (e, stackTrace) {
      debugPrint('[Login] SecureStorage read FAILED: $e');
      debugPrint('[Login] StackTrace: $stackTrace');
    }
    final rememberMe = prefs.getBool('remember_me') ?? false;
    final autoLogin = prefs.getBool('auto_login') ?? false;
    debugPrint('[Login] SharedPreferences - remember_me=$rememberMe, auto_login=$autoLogin');

    if (mounted) {
      setState(() {
        _rememberMe = rememberMe;
        _autoLogin = autoLogin;
        if (rememberMe && savedMitgliedernummer != null && widget.prefillMitgliedernummer == null) {
          _mitgliedernummerController.text = savedMitgliedernummer;
          if (savedPassword != null) {
            _passwordController.text = savedPassword;
          }
          debugPrint('[Login] Credentials loaded into fields');
        } else {
          debugPrint('[Login] NOT loading credentials - rememberMe=$rememberMe, mnr=${savedMitgliedernummer != null}, prefill=${widget.prefillMitgliedernummer}');
        }
      });
    }
  }

  Future<void> _saveCredentials() async {
    debugPrint('[Login] _saveCredentials called - rememberMe=$_rememberMe, autoLogin=$_autoLogin');
    final prefs = await SharedPreferences.getInstance();
    try {
      if (_rememberMe) {
        final mnr = _mitgliedernummerController.text.trim();
        final pwd = _passwordController.text;
        // Security: Password metadata removed from logging
        debugPrint('[Login] Saving credentials to SecureStorage');
        await _secureStorage.write(key: 'mitgliedernummer', value: mnr);
        await _secureStorage.write(key: 'password', value: pwd);
        debugPrint('[Login] Credentials saved successfully');
        await prefs.setBool('remember_me', true);
        await prefs.setBool('auto_login', _autoLogin);
        debugPrint('[Login] SharedPreferences saved - remember_me=true, auto_login=$_autoLogin');

        // Verify immediately after save
        final verifyMnr = await _secureStorage.read(key: 'mitgliedernummer');
        final verifyPwd = await _secureStorage.read(key: 'password');
        // Security: Verification without sensitive metadata
        debugPrint('[Login] Credentials verified: ${verifyMnr != null && verifyPwd != null ? "OK" : "FAILED"}');
      } else {
        debugPrint('[Login] rememberMe is FALSE - deleting credentials');
        await _secureStorage.delete(key: 'mitgliedernummer');
        await _secureStorage.delete(key: 'password');
        await prefs.setBool('remember_me', false);
        await prefs.setBool('auto_login', false);
      }
    } catch (e, stackTrace) {
      debugPrint('[Login] SecureStorage write FAILED: $e');
      debugPrint('[Login] StackTrace: $stackTrace');
    }
  }

  @override
  void dispose() {
    _mitgliedernummerController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final l10n = AppLocalizations.of(context)!;
    final mitgliedernummer = _mitgliedernummerController.text.trim();
    final password = _passwordController.text;

    if (mitgliedernummer.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = l10n.enterCredentials;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _apiService.login(mitgliedernummer, password);

      if (result['success'] == true) {
        final user = result['user'];
        await _saveCredentials();

        if (mounted) {
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
      } else {
        final errorCode = result['error_code'];
        if (errorCode == 'MAX_DEVICES' && result['active_sessions'] != null) {
          if (mounted) {
            _showDeviceSelectionDialog(
              result['active_sessions'] as List,
              mitgliedernummer,
              password,
            );
          }
        } else {
          setState(() {
            _errorMessage = result['message'] ?? l10n.loginFailed;
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = l10n.connectionError(e.toString());
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showDeviceSelectionDialog(List activeSessions, String mitgliedernummer, String password) async {
    final l10n = AppLocalizations.of(context)!;
    final selectedSession = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.devices, color: Colors.orange),
            const SizedBox(width: 8),
            Text(l10n.tooManyDevices),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.maxDevicesMessage,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...activeSessions.map((session) {
                final deviceInfo = session['device_info'] != null
                    ? jsonDecode(session['device_info'])
                    : null;
                final deviceName = deviceInfo?['device_name'] ?? l10n.unknownDevice;
                final platform = deviceInfo?['platform'] ?? l10n.unknown;
                final ipAddress = session['ip_address'] ?? l10n.unknown;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.phone_android, color: Colors.blue),
                    title: Text(deviceName),
                    subtitle: Text('$platform • IP: $ipAddress'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () => Navigator.pop(ctx, session),
                  ),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );

    if (selectedSession != null) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final logoutResult = await _apiService.logoutDevice(
          mitgliedernummer,
          password,
          selectedSession['id'],
        );

        if (logoutResult['success'] == true) {
          await _login();
        } else {
          setState(() {
            _errorMessage = logoutResult['message'] ?? l10n.logoutError;
            _isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = l10n.error(e.toString());
          _isLoading = false;
        });
      }
    }
  }

  // Helper function for responsive font size
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
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
                      // Form - direct without white container
                      LoginTab(
                        apiService: _apiService,
                        mitgliedernummerController: _mitgliedernummerController,
                        passwordController: _passwordController,
                        rememberMe: _rememberMe,
                        autoLogin: _autoLogin,
                        isLoading: _isLoading,
                        errorMessage: _errorMessage,
                        onRememberMeChanged: (value) {
                          setState(() {
                            _rememberMe = value;
                            if (!_rememberMe) _autoLogin = false;
                          });
                        },
                        onAutoLoginChanged: (value) {
                          setState(() => _autoLogin = value);
                        },
                        onLogin: _login,
                        onMaxDevices: _showDeviceSelectionDialog,
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

    // Hide footer when keyboard is open
    if (keyboardVisible) {
      return const SizedBox.shrink();
    }

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
            'v1.1.13',
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
      style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: _getResponsiveFontSize(context, 12)),
    );
  }
}
