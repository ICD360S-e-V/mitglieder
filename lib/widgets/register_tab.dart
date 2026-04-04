import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/logger_service.dart';
import '../screens/webview_screen.dart';

final _log = LoggerService();

class RegisterTab extends StatefulWidget {
  final ApiService apiService;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final Function(String mitgliedernummer) onRegisterSuccess;
  final ValueChanged<bool> onLoadingChanged;
  final ValueChanged<String?> onErrorChanged;
  final ValueChanged<String?> onSuccessChanged;

  const RegisterTab({
    super.key,
    required this.apiService,
    required this.isLoading,
    this.errorMessage,
    this.successMessage,
    required this.onRegisterSuccess,
    required this.onLoadingChanged,
    required this.onErrorChanged,
    required this.onSuccessChanged,
  });

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _recoveryCodeController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _datenschutzAccepted = false;
  bool _satzungAccepted = false;
  bool _widerrufsbelehrungAccepted = false;
  bool _datenschutzViewed = false;
  bool _satzungViewed = false;
  bool _widerrufsbelehrungViewed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _recoveryCodeController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      widget.onErrorChanged(l10n.passwordsNotMatch);
      return;
    }
    _log.info('Register: Attempting registration for ${_emailController.text.trim()}', tag: 'AUTH');

    widget.onLoadingChanged(true);
    widget.onErrorChanged(null);
    widget.onSuccessChanged(null);

    try {
      final result = await widget.apiService.register(
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
        _recoveryCodeController.text.trim(),
        datenschutzAccepted: _datenschutzAccepted,
        satzungAccepted: _satzungAccepted,
        widerrufsbelehrungAccepted: _widerrufsbelehrungAccepted,
      );
      _log.debug('Register: API response success=${result['success']}', tag: 'AUTH');

      if (result['success'] == true) {
        final user = result['user'];
        final mitgliedernummer = user['mitgliedernummer'];
        _log.info('Register: Success! Mitgliedernummer=$mitgliedernummer', tag: 'AUTH');

        // Call success callback IMMEDIATELY - let parent handle the delay
        _log.info('RegisterTab: Calling onRegisterSuccess with $mitgliedernummer', tag: 'AUTH');
        widget.onSuccessChanged(l10n.registrationSuccess(mitgliedernummer));

        // Call the callback immediately - parent will handle redirect timing
        widget.onRegisterSuccess(mitgliedernummer);

        // Clear form after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _log.debug('RegisterTab: Clearing registration form', tag: 'AUTH');
            _nameController.clear();
            _emailController.clear();
            _passwordController.clear();
            _confirmPasswordController.clear();
            _recoveryCodeController.clear();
          }
        });
      } else {
        // Backend poate returna fie 'message' fie 'error' în funcție de endpoint
        final errorMsg = result['message'] ?? result['error'] ?? l10n.registrationFailed;
        _log.warning('Register: Failed - $errorMsg', tag: 'AUTH');
        widget.onErrorChanged(errorMsg);
      }
    } catch (e) {
      _log.error('Register: Exception - $e', tag: 'AUTH');
      widget.onErrorChanged(l10n.connectionError(e.toString()));
    } finally {
      widget.onLoadingChanged(false);
    }
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    String? helperText,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
      helperText: helperText,
      helperStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
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
      counterStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
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
            // Error/Success message
            if (widget.errorMessage != null)
              _buildMessageBox(widget.errorMessage!, isError: true),
            if (widget.successMessage != null)
              _buildMessageBox(widget.successMessage!, isError: false),

            // Name field
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZäöüÄÖÜßăâîșțĂÂÎȘȚéèêëàùûôîïçÿœæÉÈÊËÀÙÛÔÎÏÇŸŒÆ\s\-]')),
              ],
              decoration: _buildInputDecoration(
                labelText: l10n.firstName,
                prefixIcon: Icons.person,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.firstNameHint;
                }
                // Security: Length validation prevents buffer overflow
                if (value.length < 2) {
                  return l10n.nameMinLength;
                }
                if (value.length > 100) {
                  return l10n.nameTooLong;
                }
                if (!RegExp(r'^[a-zA-ZäöüÄÖÜßăâîșțĂÂÎȘȚéèêëàùûôîïçÿœæÉÈÊËÀÙÛÔÎÏÇŸŒÆ\s\-]+$').hasMatch(value)) {
                  return l10n.nameOnlyLetters;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email field
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(
                labelText: l10n.email,
                prefixIcon: Icons.email,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.emailHint;
                }
                // Security: Proper email validation
                if (value.length > 255) {
                  return l10n.emailTooLong;
                }
                final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                if (!emailRegex.hasMatch(value)) {
                  return l10n.emailInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password field
            TextFormField(
              controller: _passwordController,
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
                // Security: Password strength validation
                if (value.length < 6) {
                  return l10n.passwordMinLength;
                }
                if (value.length > 100) {
                  return l10n.passwordTooLong;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Confirm Password field
            TextFormField(
              controller: _confirmPasswordController,
              style: const TextStyle(color: Colors.white),
              obscureText: _obscureConfirmPassword,
              decoration: _buildInputDecoration(
                labelText: l10n.confirmPassword,
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.confirmPasswordHint;
                }
                if (value != _passwordController.text) {
                  return l10n.passwordsNotMatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Recovery Code field
            TextFormField(
              controller: _recoveryCodeController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _buildInputDecoration(
                labelText: l10n.recoveryCode,
                prefixIcon: Icons.security,
                helperText: l10n.recoveryCodeHelper,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.recoveryCodeHint;
                }
                if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                  return l10n.recoveryCodeInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Datenschutzerklärung checkbox
            _buildLegalCheckbox(
              value: _datenschutzAccepted,
              viewed: _datenschutzViewed,
              onChanged: (v) => setState(() => _datenschutzAccepted = v ?? false),
              onViewed: () => setState(() => _datenschutzViewed = true),
              linkText: l10n.privacy,
              linkUrl: 'https://icd360s.de/datenschutz',
              label: l10n.legalAcknowledgePrefix,
              labelSuffix: l10n.legalAcknowledgeSuffix,
            ),
            const SizedBox(height: 8),

            // Satzung checkbox
            _buildLegalCheckbox(
              value: _satzungAccepted,
              viewed: _satzungViewed,
              onChanged: (v) => setState(() => _satzungAccepted = v ?? false),
              onViewed: () => setState(() => _satzungViewed = true),
              linkText: l10n.statutes,
              linkUrl: 'https://icd360s.de/satzung360s/',
              label: l10n.legalAcknowledgePrefix,
              labelSuffix: l10n.legalStatutesSuffix,
            ),
            const SizedBox(height: 8),

            // Widerrufsbelehrung checkbox
            _buildLegalCheckbox(
              value: _widerrufsbelehrungAccepted,
              viewed: _widerrufsbelehrungViewed,
              onChanged: (v) => setState(() => _widerrufsbelehrungAccepted = v ?? false),
              onViewed: () => setState(() => _widerrufsbelehrungViewed = true),
              linkText: l10n.revocation,
              linkUrl: 'https://icd360s.de/widerrufsrecht',
              label: l10n.legalAcknowledgePrefix,
              labelSuffix: l10n.legalAcknowledgeSuffix,
            ),
            const SizedBox(height: 24),

            // Register button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: widget.isLoading || !_datenschutzAccepted || !_satzungAccepted || !_widerrufsbelehrungAccepted
                    ? null
                    : _register,
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
                          const Icon(Icons.person_add, size: 24),
                          const SizedBox(width: 12),
                          Text(
                            l10n.register,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalCheckbox({
    required bool value,
    required bool viewed,
    required ValueChanged<bool?> onChanged,
    required VoidCallback onViewed,
    required String linkText,
    required String linkUrl,
    required String label,
    required String labelSuffix,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: viewed ? onChanged : null,
            side: BorderSide(
              color: viewed
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.2),
            ),
            checkColor: Colors.white,
            activeColor: Colors.green.shade600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: viewed ? () => onChanged(!value) : null,
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: viewed
                      ? Colors.white.withValues(alpha: 0.8)
                      : Colors.white.withValues(alpha: 0.4),
                  fontSize: 13,
                ),
                children: [
                  TextSpan(text: label),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () async {
                        if (WebViewScreen.isWebViewSupported) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewScreen(
                                title: linkText,
                                url: linkUrl,
                              ),
                            ),
                          );
                        } else {
                          await launchUrl(Uri.parse(linkUrl), mode: LaunchMode.externalApplication);
                        }
                        onViewed();
                      },
                      child: Text(
                        linkText,
                        style: TextStyle(
                          color: Colors.lightBlue.shade200,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.lightBlue.shade200,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: labelSuffix),
                  if (!viewed)
                    TextSpan(
                      text: ' ${AppLocalizations.of(context)!.legalPleaseReadFirst}',
                      style: TextStyle(
                        color: Colors.amber.shade200,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
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
