import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// Login form with the member-number split into two side-by-side fields:
///
///   ┌──┐  ┌────────────────────┐
///   │ M│  │ 5 cifre            │
///   └──┘  └────────────────────┘
///
/// Box 1 is one uppercase letter (pre-filled with `M` for *Mitglied* — the
/// only prefix in use today; left editable so a future role-specific prefix
/// could be typed in without a UI change). Box 2 is exactly 5 digits, no
/// other characters accepted. On submit the two halves are concatenated
/// into `M12345` and pushed back into the shared
/// [mitgliedernummerController] so the API call site is unchanged.
class LoginTab extends StatefulWidget {
  /// Controller the screen reads after submit. Receives the final string
  /// `M<5 digits>` — internal field controllers are managed here.
  final TextEditingController mitgliedernummerController;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onLogin;

  /// Called each keystroke in the digits box with the live digit count
  /// (0–5). Used by ClaudiuLoginCoach to refresh its speech bubble in
  /// real time without having to wedge a callback into validation.
  final ValueChanged<int>? onDigitsChanged;

  const LoginTab({
    super.key,
    required this.mitgliedernummerController,
    required this.isLoading,
    this.errorMessage,
    required this.onLogin,
    this.onDigitsChanged,
  });

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final _formKey = GlobalKey<FormState>();
  final _prefixController = TextEditingController(text: 'M');
  final _digitsController = TextEditingController();
  final _prefixFocus = FocusNode();
  final _digitsFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // If the screen pre-filled mitgliedernummerController (auto-prefill from
    // secure storage), split it back into prefix + digits so the boxes
    // show the saved value.
    final initial = widget.mitgliedernummerController.text;
    final match = RegExp(r'^([A-Za-z])(\d{1,5})$').firstMatch(initial);
    if (match != null) {
      _prefixController.text = match.group(1)!.toUpperCase();
      _digitsController.text = match.group(2)!;
    }
    _digitsController.addListener(_onDigitsChanged);
  }

  @override
  void dispose() {
    _digitsController.removeListener(_onDigitsChanged);
    _prefixController.dispose();
    _digitsController.dispose();
    _prefixFocus.dispose();
    _digitsFocus.dispose();
    super.dispose();
  }

  void _onDigitsChanged() {
    widget.onDigitsChanged?.call(_digitsController.text.length);
    if (_digitsController.text.length == 5) {
      // Polite UX nudge — submit auto-enables, focus drops the keyboard so
      // the user sees the login button. Don't auto-submit; users on small
      // screens often double-check before pressing.
      _digitsFocus.unfocus();
    }
  }

  void _onPrefixChanged(String value) {
    // Single-letter prefix; once the box is full, jump focus to digits so
    // the keyboard switches to numeric without an extra tap. Empty box
    // (user backspaced past M) keeps focus here.
    if (value.isNotEmpty) {
      _digitsFocus.requestFocus();
    }
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
            if (widget.errorMessage != null)
              _buildMessageBox(widget.errorMessage!, isError: true),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Box 1 — prefix letter (pre-filled "M", editable). No
                // visible label; the typed character itself ("M") is the
                // self-explanatory affordance.
                SizedBox(
                  width: 72,
                  child: TextFormField(
                    controller: _prefixController,
                    focusNode: _prefixFocus,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.characters,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),
                      _UppercaseTextFormatter(),
                    ],
                    decoration: _boxDecoration().copyWith(counterText: ''),
                    onChanged: _onPrefixChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // Box 2 — exactly 5 digits, numeric keyboard.
                Expanded(
                  child: TextFormField(
                    controller: _digitsController,
                    focusNode: _digitsFocus,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    decoration: _boxDecoration(
                      labelText: l10n.memberNumber,
                    ).copyWith(counterText: ''),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleLogin(),
                    validator: (value) {
                      if (value == null || value.length != 5) {
                        return l10n.memberNumberHint;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Login button.
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5),
                    width: 2,
                  ),
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.login, size: 24),
                          const SizedBox(width: 12),
                          Text(
                            l10n.login,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
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

  void _handleLogin() {
    final formOk = _formKey.currentState?.validate() ?? false;
    if (!formOk) return;
    // Concatenate halves into the canonical "M12345" form before handing
    // off to the screen — every API call site downstream still receives a
    // single string.
    widget.mitgliedernummerController.text =
        _prefixController.text.toUpperCase() + _digitsController.text;
    widget.onLogin();
  }

  InputDecoration _boxDecoration({String? labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
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
        borderSide: BorderSide(color: context.colors.dangerBorder),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.dangerBorder, width: 2),
      ),
      errorStyle: TextStyle(color: context.colors.onDarkDanger),
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
          color: isError ? context.colors.dangerBorder : context.colors.successBorder,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: isError ? context.colors.onDarkDanger : context.colors.onDarkSuccess,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isError ? context.colors.onDarkDanger : context.colors.onDarkSuccess,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Forces the typed character to upper case as it's entered, so the prefix
/// `M` looks consistent whether the user typed lowercase or upper.
class _UppercaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
