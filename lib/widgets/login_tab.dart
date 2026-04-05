import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class LoginTab extends StatefulWidget {
  final TextEditingController mitgliedernummerController;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onLogin;

  const LoginTab({
    super.key,
    required this.mitgliedernummerController,
    required this.isLoading,
    this.errorMessage,
    required this.onLogin,
  });

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final _formKey = GlobalKey<FormState>();

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
      prefixIcon: Icon(prefixIcon, color: Colors.white.withValues(alpha: 0.7)),
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
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: _buildInputDecoration(
                labelText: l10n.memberNumber,
                prefixIcon: Icons.badge,
              ),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.memberNumberHint;
                }
                if (value.length > 20) {
                  return l10n.memberNumberTooLong;
                }
                if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
                  return l10n.onlyUppercaseAndNumbers;
                }
                return null;
              },
              onFieldSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: 24),

            // Login button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
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
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Anmelden',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Info text
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white.withValues(alpha: 0.5), size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Bekanntes Gerät: sofortige Anmeldung.\nNeues Gerät: Genehmigung vom Vorstand.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
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
          color: isError ? Colors.red.shade300 : Colors.green.shade300,
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
