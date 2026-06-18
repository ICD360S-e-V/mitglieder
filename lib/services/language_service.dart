import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One entry per language the app actually ships translations for.
/// `code` matches the .arb suffix and what the server expects in `device_locale`.
/// The flag SVG is at `assets/flags/<code>.svg` — the country shown is the most
/// common visual identifier for the language (e.g. `en` → Union Jack).
class AppLanguage {
  final String code;
  final String nativeName;

  const AppLanguage(this.code, this.nativeName);

  String get flagAsset => 'assets/flags/$code.svg';
}

/// Holds the user-chosen UI language. We deliberately do NOT read
/// `Platform.localeName` — the language must come from an explicit pick on
/// first launch, so the device locale can't leak a member's nationality to
/// anyone watching network traffic or to local logs.
class LanguageService {
  LanguageService._();
  static final LanguageService instance = LanguageService._();

  static const _prefsKey = 'app_locale_v1';
  static const String fallbackCode = 'de';

  /// Locales the app has .arb translations for. Order = visual order in the
  /// selection grid. Keep alphabetic-by-native-name so it stays predictable.
  static const List<AppLanguage> supported = [
    AppLanguage('ar', 'العربية'),
    AppLanguage('bg', 'Български'),
    AppLanguage('cs', 'Čeština'),
    AppLanguage('da', 'Dansk'),
    AppLanguage('de', 'Deutsch'),
    AppLanguage('et', 'Eesti'),
    AppLanguage('en', 'English'),
    AppLanguage('es', 'Español'),
    AppLanguage('fr', 'Français'),
    AppLanguage('hr', 'Hrvatski'),
    AppLanguage('it', 'Italiano'),
    AppLanguage('lv', 'Latviešu'),
    AppLanguage('lt', 'Lietuvių'),
    AppLanguage('hu', 'Magyar'),
    AppLanguage('nl', 'Nederlands'),
    AppLanguage('nb', 'Norsk'),
    AppLanguage('pl', 'Polski'),
    AppLanguage('pt', 'Português'),
    AppLanguage('ro', 'Română'),
    AppLanguage('sk', 'Slovenčina'),
    AppLanguage('sl', 'Slovenščina'),
    AppLanguage('sr', 'Srpski'),
    AppLanguage('fi', 'Suomi'),
    AppLanguage('sv', 'Svenska'),
    AppLanguage('tr', 'Türkçe'),
    AppLanguage('el', 'Ελληνικά'),
    AppLanguage('ru', 'Русский'),
    AppLanguage('uk', 'Українська'),
  ];

  /// `null` until [load] has run, then either the saved code or `null` if the
  /// user has never picked. We use this null vs. set distinction in main.dart
  /// to decide whether to show the selector.
  String? _savedCode;
  bool _loaded = false;

  /// Notifies MaterialApp so changing language re-renders the UI immediately.
  final ValueNotifier<Locale> localeNotifier =
      ValueNotifier<Locale>(const Locale(fallbackCode));

  /// True if the user has explicitly picked a language in a previous launch.
  bool get hasUserChoice => _savedCode != null;

  /// Locale code currently used by the UI (always non-null — falls back to `de`).
  String get currentCode => localeNotifier.value.languageCode;

  /// Read from disk. Idempotent; safe to call multiple times.
  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefsKey);
      if (code != null && _isSupported(code)) {
        _savedCode = code;
        localeNotifier.value = Locale(code);
      }
    } catch (e) {
      debugPrint('[LanguageService] load failed: $e');
    }
  }

  /// Persist the user's pick and update the live locale.
  Future<void> setLanguage(String code) async {
    final resolved = _isSupported(code) ? code : fallbackCode;
    _savedCode = resolved;
    localeNotifier.value = Locale(resolved);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, resolved);
    } catch (e) {
      debugPrint('[LanguageService] save failed: $e');
    }
  }

  bool _isSupported(String code) =>
      supported.any((l) => l.code == code.toLowerCase());
}
