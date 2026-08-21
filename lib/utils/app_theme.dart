import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

/// Every colour the app paints with, named for what it *means* rather than
/// what it looks like.
///
/// Before this existed the UI carried ~1200 hard-coded literals — `Colors.white`
/// for a card, `Colors.grey.shade600` for a caption, `Color(0xFF4a90d9)` for the
/// brand blue — which made a dark theme impossible: flipping `ThemeData` would
/// have darkened the AppBar while the cards underneath stayed white, leaving
/// white-on-white text. Screens now ask for `context.colors.card` and get the
/// right value for whichever theme is live.
///
/// Two brand tokens, not one, because the same blue cannot do both jobs on a
/// dark background: [brand] is the accent (icons, links, spinners) and has to
/// stay legible *against* dark, so it lightens; [brandFill] is the surface of
/// filled buttons and the AppBar and carries white text *on* it, so it deepens.
/// [brandStrong] is the deep navy the app writes headings in when they sit on a
/// white card — it has to lighten in dark mode for the same reason [brand] does,
/// but it starts darker so the light theme keeps the weight it had.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  // Brand
  final Color brand;
  final Color brandStrong;
  final Color brandFill;
  final Color onBrandFill;

  /// The three stops of the hero gradient behind welcome, login, register and
  /// the whole onboarding wizard. Dark mode keeps the navy identity but drops
  /// it several steps darker so those screens stop glowing at night.
  final List<Color> heroGradient;

  /// The same gradient over two stops instead of three. Used by the smaller
  /// surfaces — the Claudiu speech bubble, the approval dialog header — where
  /// the middle stop has no room to read.
  List<Color> get heroGradientShort => heroGradient.sublist(0, 2);

  // Surfaces
  final Color scaffoldBg;
  final Color card;
  final Color cardSubtle;
  final Color inputFill;
  final Color divider;
  final Color dividerSubtle;
  final Color shadow;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;

  // Status — each is a foreground, a soft fill and a border, so a badge or a
  // banner is three tokens from the same family instead of three guesses.
  final Color successFg;
  final Color successBg;
  final Color successBorder;
  final Color warningFg;
  final Color warningBg;
  final Color warningBorder;
  final Color dangerFg;
  final Color dangerBg;
  final Color dangerBorder;
  final Color infoFg;
  final Color infoBg;
  final Color infoBorder;

  // Saturated status fills. The *Fg tokens above lighten in dark mode so they
  // stay legible ON a dark card; that makes them useless AS a fill, because the
  // white text a badge or a SnackBar puts on top drops to about 2:1 against
  // them. These stay saturated in both themes and are the only status colours
  // that may sit under [onSolid].
  final Color successSolid;
  final Color dangerSolid;
  final Color warningSolid;
  final Color infoSolid;
  final Color onSolid;

  // Termine, die einem Kind des Mitglieds gehören, tragen eine eigene Farbe —
  // sie sollen sich auf einen Blick von den eigenen unterscheiden. Rosa ist
  // keine Statusaussage, deshalb eine eigene Familie und nicht `info`.
  final Color kindFg;
  final Color kindBg;
  final Color kindBorder;

  // Vordergrundfarben für Flächen, die in BEIDEN Themes dunkel sind: der
  // Hero-Verlauf hinter Anmeldung, Registrierung und dem ganzen Assistenten,
  // und die Anrufoberfläche. Dort darf die Schrift nicht mit dem Theme
  // umschlagen — sie liegt immer auf Dunkel und bleibt deshalb immer hell.
  //
  // Diese Stellen trugen vorher `Colors.red.shade200` und Verwandte. Nach der
  // Helligkeit sehen die aus wie Füllfarben, sind hier aber Schrift; wer sie
  // auf ein Bg-/Border-Token abbildet, bekommt im dunklen Modus dunkelrote
  // Schrift auf dunkelblauem Grund. Die Werte sind unverändert die der hellen
  // Palette, damit dort nichts anders aussieht als vorher.
  final Color onDarkSuccess;
  final Color onDarkDanger;
  final Color onDarkWarning;

  const AppColors({
    required this.brand,
    required this.brandStrong,
    required this.brandFill,
    required this.onBrandFill,
    required this.heroGradient,
    required this.scaffoldBg,
    required this.card,
    required this.cardSubtle,
    required this.inputFill,
    required this.divider,
    required this.dividerSubtle,
    required this.shadow,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.successFg,
    required this.successBg,
    required this.successBorder,
    required this.warningFg,
    required this.warningBg,
    required this.warningBorder,
    required this.dangerFg,
    required this.dangerBg,
    required this.dangerBorder,
    required this.infoFg,
    required this.infoBg,
    required this.infoBorder,
    required this.successSolid,
    required this.dangerSolid,
    required this.warningSolid,
    required this.infoSolid,
    required this.onSolid,
    required this.kindFg,
    required this.kindBg,
    required this.kindBorder,
    required this.onDarkSuccess,
    required this.onDarkDanger,
    required this.onDarkWarning,
  });

  /// The palette the app shipped with, kept literal so the light build looks
  /// exactly as it did before the dark theme landed.
  static const AppColors light = AppColors(
    brand: Color(0xFF4a90d9),
    brandStrong: Color(0xFF0d47a1),
    brandFill: Color(0xFF4a90d9),
    onBrandFill: Colors.white,
    heroGradient: [Color(0xFF0d47a1), Color(0xFF1565c0), Color(0xFF1976d2)],
    scaffoldBg: Color(0xFFF5F5F5),
    card: Colors.white,
    cardSubtle: Color(0xFFF5F5F5),
    inputFill: Colors.white,
    divider: Color(0xFFE0E0E0),
    dividerSubtle: Color(0xFFEEEEEE),
    shadow: Color(0x1A000000),
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF757575),
    textTertiary: Color(0xFF9E9E9E),
    textDisabled: Color(0xFFBDBDBD),
    successFg: Color(0xFF2E7D32),
    successBg: Color(0xFFE8F5E9),
    successBorder: Color(0xFFA5D6A7),
    warningFg: Color(0xFFEF6C00),
    warningBg: Color(0xFFFFF3E0),
    warningBorder: Color(0xFFFFCC80),
    dangerFg: Color(0xFFC62828),
    dangerBg: Color(0xFFFFEBEE),
    dangerBorder: Color(0xFFEF9A9A),
    infoFg: Color(0xFF1565C0),
    infoBg: Color(0xFFE3F2FD),
    infoBorder: Color(0xFF90CAF9),
    successSolid: Color(0xFF2E7D32),
    dangerSolid: Color(0xFFC62828),
    warningSolid: Color(0xFFEF6C00),
    infoSolid: Color(0xFF1565C0),
    onSolid: Colors.white,
    kindFg: Color(0xFFC2185B),
    kindBg: Color(0xFFFCE4EC),
    kindBorder: Color(0xFFF48FB1),
    onDarkSuccess: Color(0xFFA5D6A7),
    onDarkDanger: Color(0xFFEF9A9A),
    onDarkWarning: Color(0xFFFFCC80),
  );

  /// Surfaces sit above pure black rather than on it: Material's dark guidance,
  /// and on OLED it avoids the smearing that solid black causes when a list
  /// scrolls. Status foregrounds move to the 200/300 tints because the 700/800
  /// ones the light theme uses go muddy against a dark fill.
  ///
  /// Two constraints shape the numbers here. Surfaces carry a slight blue cast
  /// so a [card] reads as the same family as the navy [heroGradient] it often
  /// floats on rather than as a neutral grey patch. And that gradient is pitched
  /// well below [card]: the light theme puts white cards on a mid-navy hero, and
  /// a straight translation would have left a #1E1E1E card on a #10386B
  /// background — the card would have been the *darker* of the two and the
  /// layering would have read backwards.
  static const AppColors dark = AppColors(
    brand: Color(0xFF7FB4EA),
    brandStrong: Color(0xFF9CC5F0),
    brandFill: Color(0xFF1B5E9E),
    onBrandFill: Colors.white,
    heroGradient: [Color(0xFF041020), Color(0xFF06182C), Color(0xFF08203A)],
    scaffoldBg: Color(0xFF14171E),
    card: Color(0xFF1E2430),
    cardSubtle: Color(0xFF272E3C),
    inputFill: Color(0xFF272E3C),
    divider: Color(0xFF3A4252),
    dividerSubtle: Color(0xFF2E3542),
    shadow: Color(0x66000000),
    textPrimary: Color(0xFFECECEC),
    textSecondary: Color(0xFFA8A8A8),
    textTertiary: Color(0xFF7C7C7C),
    textDisabled: Color(0xFF5F5F5F),
    successFg: Color(0xFF81C784),
    successBg: Color(0xFF1B3320),
    successBorder: Color(0xFF2E5A34),
    warningFg: Color(0xFFFFB74D),
    warningBg: Color(0xFF3A2A12),
    warningBorder: Color(0xFF6B4A1E),
    dangerFg: Color(0xFFEF9A9A),
    dangerBg: Color(0xFF3A1D1F),
    dangerBorder: Color(0xFF6B2F33),
    infoFg: Color(0xFF90CAF9),
    infoBg: Color(0xFF12263C),
    infoBorder: Color(0xFF1E4A72),
    // Deliberately the same saturation as the light theme rather than the
    // lightened tints above: a badge is a small block of white text, and it
    // needs a fill dark enough to carry it. Orange is the weak one at ~4:1 —
    // that is what the app already shipped in light, not a regression.
    successSolid: Color(0xFF2E7D32),
    dangerSolid: Color(0xFFC62828),
    warningSolid: Color(0xFFE65100),
    infoSolid: Color(0xFF1565C0),
    onSolid: Colors.white,
    kindFg: Color(0xFFF48FB1),
    kindBg: Color(0xFF3A1F2A),
    kindBorder: Color(0xFF6B3448),
    // Bewusst dieselben Werte wie hell: der Grund darunter ist in beiden
    // Themes derselbe dunkle Verlauf.
    onDarkSuccess: Color(0xFFA5D6A7),
    onDarkDanger: Color(0xFFEF9A9A),
    onDarkWarning: Color(0xFFFFCC80),
  );

  @override
  AppColors copyWith({
    Color? brand,
    Color? brandStrong,
    Color? brandFill,
    Color? onBrandFill,
    List<Color>? heroGradient,
    Color? scaffoldBg,
    Color? card,
    Color? cardSubtle,
    Color? inputFill,
    Color? divider,
    Color? dividerSubtle,
    Color? shadow,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? successFg,
    Color? successBg,
    Color? successBorder,
    Color? warningFg,
    Color? warningBg,
    Color? warningBorder,
    Color? dangerFg,
    Color? dangerBg,
    Color? dangerBorder,
    Color? infoFg,
    Color? infoBg,
    Color? infoBorder,
    Color? successSolid,
    Color? dangerSolid,
    Color? warningSolid,
    Color? infoSolid,
    Color? onSolid,
    Color? kindFg,
    Color? kindBg,
    Color? kindBorder,
    Color? onDarkSuccess,
    Color? onDarkDanger,
    Color? onDarkWarning,
  }) {
    return AppColors(
      brand: brand ?? this.brand,
      brandStrong: brandStrong ?? this.brandStrong,
      brandFill: brandFill ?? this.brandFill,
      onBrandFill: onBrandFill ?? this.onBrandFill,
      heroGradient: heroGradient ?? this.heroGradient,
      scaffoldBg: scaffoldBg ?? this.scaffoldBg,
      card: card ?? this.card,
      cardSubtle: cardSubtle ?? this.cardSubtle,
      inputFill: inputFill ?? this.inputFill,
      divider: divider ?? this.divider,
      dividerSubtle: dividerSubtle ?? this.dividerSubtle,
      shadow: shadow ?? this.shadow,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      successFg: successFg ?? this.successFg,
      successBg: successBg ?? this.successBg,
      successBorder: successBorder ?? this.successBorder,
      warningFg: warningFg ?? this.warningFg,
      warningBg: warningBg ?? this.warningBg,
      warningBorder: warningBorder ?? this.warningBorder,
      dangerFg: dangerFg ?? this.dangerFg,
      dangerBg: dangerBg ?? this.dangerBg,
      dangerBorder: dangerBorder ?? this.dangerBorder,
      infoFg: infoFg ?? this.infoFg,
      infoBg: infoBg ?? this.infoBg,
      infoBorder: infoBorder ?? this.infoBorder,
      successSolid: successSolid ?? this.successSolid,
      dangerSolid: dangerSolid ?? this.dangerSolid,
      warningSolid: warningSolid ?? this.warningSolid,
      infoSolid: infoSolid ?? this.infoSolid,
      onSolid: onSolid ?? this.onSolid,
      kindFg: kindFg ?? this.kindFg,
      kindBg: kindBg ?? this.kindBg,
      kindBorder: kindBorder ?? this.kindBorder,
      onDarkSuccess: onDarkSuccess ?? this.onDarkSuccess,
      onDarkDanger: onDarkDanger ?? this.onDarkDanger,
      onDarkWarning: onDarkWarning ?? this.onDarkWarning,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      brand: Color.lerp(brand, other.brand, t)!,
      brandStrong: Color.lerp(brandStrong, other.brandStrong, t)!,
      brandFill: Color.lerp(brandFill, other.brandFill, t)!,
      onBrandFill: Color.lerp(onBrandFill, other.onBrandFill, t)!,
      heroGradient: [
        for (var i = 0; i < heroGradient.length; i++)
          Color.lerp(heroGradient[i], other.heroGradient[i], t)!,
      ],
      scaffoldBg: Color.lerp(scaffoldBg, other.scaffoldBg, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardSubtle: Color.lerp(cardSubtle, other.cardSubtle, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      dividerSubtle: Color.lerp(dividerSubtle, other.dividerSubtle, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      successFg: Color.lerp(successFg, other.successFg, t)!,
      successBg: Color.lerp(successBg, other.successBg, t)!,
      successBorder: Color.lerp(successBorder, other.successBorder, t)!,
      warningFg: Color.lerp(warningFg, other.warningFg, t)!,
      warningBg: Color.lerp(warningBg, other.warningBg, t)!,
      warningBorder: Color.lerp(warningBorder, other.warningBorder, t)!,
      dangerFg: Color.lerp(dangerFg, other.dangerFg, t)!,
      dangerBg: Color.lerp(dangerBg, other.dangerBg, t)!,
      dangerBorder: Color.lerp(dangerBorder, other.dangerBorder, t)!,
      infoFg: Color.lerp(infoFg, other.infoFg, t)!,
      infoBg: Color.lerp(infoBg, other.infoBg, t)!,
      infoBorder: Color.lerp(infoBorder, other.infoBorder, t)!,
      successSolid: Color.lerp(successSolid, other.successSolid, t)!,
      dangerSolid: Color.lerp(dangerSolid, other.dangerSolid, t)!,
      warningSolid: Color.lerp(warningSolid, other.warningSolid, t)!,
      infoSolid: Color.lerp(infoSolid, other.infoSolid, t)!,
      onSolid: Color.lerp(onSolid, other.onSolid, t)!,
      kindFg: Color.lerp(kindFg, other.kindFg, t)!,
      kindBg: Color.lerp(kindBg, other.kindBg, t)!,
      kindBorder: Color.lerp(kindBorder, other.kindBorder, t)!,
      onDarkSuccess: Color.lerp(onDarkSuccess, other.onDarkSuccess, t)!,
      onDarkDanger: Color.lerp(onDarkDanger, other.onDarkDanger, t)!,
      onDarkWarning: Color.lerp(onDarkWarning, other.onDarkWarning, t)!,
    );
  }
}

/// `context.colors.card` instead of
/// `Theme.of(context).extension<AppColors>()!.card` at ~1200 call sites.
///
/// The fallback is not defensive noise: `showDialog` and the call/remote
/// overlays push routes whose context can sit outside the MaterialApp theme
/// during a transition, and a null-assertion there would crash the app rather
/// than draw one frame in the wrong shade.
extension AppColorsX on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light);

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

/// Builds the two [ThemeData]s from [AppColors] so the Material widgets the app
/// does not paint by hand (dialogs, snackbars, switches, the date picker) land
/// on the same palette as the ones it does.
abstract final class AppTheme {
  static const Color _seed = Color(0xFF4a90d9);

  static final ThemeData light = _build(Brightness.light, AppColors.light);
  static final ThemeData dark = _build(Brightness.dark, AppColors.dark);

  /// Status bar and Android navigation bar for a given brightness.
  ///
  /// Read twice: once in `main()` so the very first frame does not flash a
  /// white navigation bar under a dark app, and again from the `AnnotatedRegion`
  /// in the app root whenever the theme changes afterwards.
  static SystemUiOverlayStyle overlayStyleFor(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor:
          isDark ? AppColors.dark.scaffoldBg : Colors.white,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    );
  }

  static ThemeData _build(Brightness brightness, AppColors c) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    ).copyWith(
      surface: c.card,
      error: c.dangerFg,
      outline: c.divider,
    );

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      fontFamily: 'Roboto',
      brightness: brightness,
      scaffoldBackgroundColor: c.scaffoldBg,
      dividerColor: c.divider,
      extensions: <ThemeExtension<dynamic>>[c],
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: c.brandFill,
        foregroundColor: c.onBrandFill,
        // The bar is brand blue in both themes and carries white content, so
        // the status bar above it wants light icons either way.
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      cardTheme: CardThemeData(
        color: c.card,
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.card,
        surfaceTintColor: Colors.transparent,
      ),
      // Bottom sheets and menus tint themselves with the primary colour under
      // Material 3, which reads as a purple cast on our blue surfaces.
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.card,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: c.card,
        surfaceTintColor: Colors.transparent,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF2C2C2C)
            : const Color(0xFF323232),
        contentTextStyle: const TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: c.brand, width: 2),
        ),
      ),
      textTheme: Typography.material2021(platform: TargetPlatform.android)
          .black
          .apply(
            bodyColor: c.textPrimary,
            displayColor: c.textPrimary,
          ),
    );
  }
}
