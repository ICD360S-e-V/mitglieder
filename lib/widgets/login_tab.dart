import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import 'forgot_password_dialog.dart';

class LoginTab extends StatefulWidget {
  final ApiService apiService;
  final TextEditingController mitgliedernummerController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool autoLogin;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<bool> onRememberMeChanged;
  final ValueChanged<bool> onAutoLoginChanged;
  final VoidCallback onLogin;
  final Function(List activeSessions, String mitgliedernummer, String password) onMaxDevices;

  const LoginTab({
    super.key,
    required this.apiService,
    required this.mitgliedernummerController,
    required this.passwordController,
    required this.rememberMe,
    required this.autoLogin,
    required this.isLoading,
    this.errorMessage,
    required this.onRememberMeChanged,
    required this.onAutoLoginChanged,
    required this.onLogin,
    required this.onMaxDevices,
  });

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
      prefixIcon: Icon(prefixIcon, color: Colors.white.withValues(alpha: 0.7)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      errorStyle: TextStyle(color: Colors.red.shade200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error message
            if (widget.errorMessage != null)
              _buildMessageBox(widget.errorMessage!, isError: true),

            // Mitgliedernummer field
            TextFormField(
              controller: widget.mitgliedernummerController,
              style: const TextStyle(color: Colors.white),
              decoration: _buildInputDecoration(
                labelText: l10n.memberNumber,
                prefixIcon: Icons.badge,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.memberNumberHint;
                }
                // Security: Input validation - prevent injection attacks
                if (value.length > 20) {
                  return l10n.memberNumberTooLong;
                }
                if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
                  return l10n.onlyUppercaseAndNumbers;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password field
            TextFormField(
              controller: widget.passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: _obscurePassword,
              decoration: _buildInputDecoration(
                labelText: l10n.password,
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.passwordHint;
                }
                // Security: Password validation
                if (value.length < 6) {
                  return l10n.passwordMinLength;
                }
                if (value.length > 100) {
                  return l10n.passwordTooLong;
                }
                return null;
              },
              onFieldSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: 12),

            // Remember Me checkbox
            Row(
              children: [
                Checkbox(
                  value: widget.rememberMe,
                  onChanged: (value) {
                    widget.onRememberMeChanged(value ?? false);
                  },
                  activeColor: Colors.white,
                  checkColor: const Color(0xFF0d47a1),
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 2),
                ),
                Flexible(
                  child: Text(
                    l10n.saveCredentials,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
                  ),
                ),
              ],
            ),

            // Auto Login checkbox
            Row(
              children: [
                Checkbox(
                  value: widget.autoLogin,
                  onChanged: widget.rememberMe
                      ? (value) {
                          widget.onAutoLoginChanged(value ?? false);
                        }
                      : null,
                  activeColor: Colors.white,
                  checkColor: const Color(0xFF0d47a1),
                  side: BorderSide(
                    color: widget.rememberMe
                        ? Colors.white.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                Flexible(
                  child: Text(
                    l10n.autoLogin,
                    style: TextStyle(
                      color: widget.rememberMe
                          ? Colors.white.withValues(alpha: 0.9)
                          : Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Login button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: widget.isLoading ? null : _handleLogin,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.login, size: 24),
                          const SizedBox(width: 12),
                          Text(
                            l10n.login,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Forgot Password link
            TextButton(
              onPressed: _showForgotPasswordDialog,
              child: Text(
                l10n.forgotPassword,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }
    widget.onLogin();
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => ForgotPasswordDialog(apiService: widget.apiService),
    );
  }

  Widget _buildMessageBox(String message, {required bool isError}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isError
            ? Colors.red.withValues(alpha: 0.2)
            : Colors.green.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isError
              ? Colors.red.shade300
              : Colors.green.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: isError ? Colors.red.shade200 : Colors.green.shade200,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isError ? Colors.red.shade100 : Colors.green.shade100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
