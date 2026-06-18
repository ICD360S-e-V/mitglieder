import 'package:flutter/material.dart';

import '../services/language_service.dart';

/// First-launch language picker. Shown by main.dart when
/// [LanguageService.hasUserChoice] is false. Replaces the device-locale
/// detection that previously inferred language from `Platform.localeName`.
///
/// When the user taps a card we persist the choice and either pop (when
/// pushed from a settings screen) or invoke [onSelected] (when used as a
/// root gate before the Welcome screen).
class LanguageSelectionScreen extends StatelessWidget {
  /// Called after a language is persisted. Use this when the screen sits
  /// before the Welcome screen — main.dart needs to swap to WelcomeScreen.
  /// If null, the screen pops itself (useful for settings entry).
  final VoidCallback? onSelected;

  /// When true, shows a back button. Defaults to false for the first-launch
  /// gate so the user can't skip the pick.
  final bool allowBack;

  const LanguageSelectionScreen({
    super.key,
    this.onSelected,
    this.allowBack = false,
  });

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
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildGrid(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        children: [
          if (allowBack)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'ICD360S e.V',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                // Trilingual header: anyone opening the app on first launch
                // should recognise at least one of these. No localisation
                // here on purpose — there's no AppLocalizations yet because
                // the locale isn't decided.
                Text(
                  'Sprache wählen / Choose language / Selectează limba',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          // Symmetric spacer when there's no back button so the title stays centred.
          if (allowBack) const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final languages = LanguageService.supported;
    final currentCode = LanguageService.instance.currentCode;
    final hasChoice = LanguageService.instance.hasUserChoice;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final lang = languages[index];
        // Only highlight if the user has actually chosen — on first launch
        // every card should look equal, otherwise `de` would be visually
        // pre-selected just because it's the fallback.
        final isSelected = hasChoice && lang.code == currentCode;
        return _buildCard(context, lang, isSelected);
      },
    );
  }

  Widget _buildCard(BuildContext context, AppLanguage lang, bool selected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _select(context, lang.code),
        child: Container(
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.3),
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lang.flag,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  lang.nativeName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                lang.code.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.2,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _select(BuildContext context, String code) async {
    await LanguageService.instance.setLanguage(code);
    if (!context.mounted) return;
    if (onSelected != null) {
      onSelected!();
    } else {
      Navigator.of(context).pop();
    }
  }
}
