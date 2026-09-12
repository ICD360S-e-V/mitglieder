import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' show PlatformDispatcher, FlutterView;

import 'package:flutter/material.dart';

/// Responsive utilities for cross-platform UI adaptations
/// Helps create layouts that work well on mobile and desktop
class Responsive {
  /// Device type detection
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
  static bool get isDesktop => Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  /// Platform name for display
  static String get platformName {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  /// Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // ---------------------------------------------------------------------------
  // Geräteskalierung
  //
  // Fast alle Größen in dieser App sind fest verdrahtet (fontSize: 16,
  // EdgeInsets.all(20), Icons mit size: 30 …). Gezeichnet wurden sie für ein
  // Telefon der Pixel-7-Klasse: rund 390 dp breit, 800 dp hoch. Auf einem
  // kleineren Gerät — oder bei einer hochgedrehten System-Schriftgröße — wirkt
  // dieselbe Oberfläche schlicht zu groß und läuft über.
  //
  // Statt jeden dieser Werte einzeln anzufassen, gibt es hier einen einzigen,
  // stufenlosen Faktor. [textScaler] hängt ihn an die globale Textskalierung
  // in main.dart, womit jede Schriftgröße der App mitzieht; [scaled] und
  // [space] decken alles ab, was kein Text ist (Icons, Abstände, Kacheln).
  // ---------------------------------------------------------------------------

  /// Referenzgerät, für das die festen Größen dieser App gezeichnet wurden.
  static const double baselineWidth = 390;
  static const double baselineHeight = 800;

  /// Untergrenze: darunter wird die Oberfläche unlesbar bzw. untippbar
  /// (Material verlangt 48 dp Trefferfläche).
  static const double minScale = 0.80;

  /// Obergrenze: auf Tablets und großen Desktop-Fenstern darf die Oberfläche
  /// etwas wachsen, aber nicht ins Plakative kippen.
  static const double maxScale = 1.15;

  /// Grenzen für die effektive Textskalierung.
  ///
  /// Die Obergrenze deckt ab, was Android in den Bedienungshilfen hergibt
  /// (200 %) — der Bereich, in dem sehbehinderte Mitglieder die App
  /// tatsächlich benutzen. Sie ist bewusst kein Schutz vor Überlauf mehr:
  /// die Oberfläche muss bei 200 % umbrechen statt zu schrumpfen. iOS reicht
  /// mit den größten Bedienungshilfe-Graden noch darüber hinaus; jenseits von
  /// 200 % ist auf einem 320 dp breiten Gerät aber keine Form von Umbruch
  /// mehr lesbar, deshalb endet es hier.
  static const double minTextScale = 0.85;
  static const double maxTextScale = 2.0;

  /// Stufenloser Skalierungsfaktor für das aktuelle Gerät.
  ///
  /// Die Breite gibt den Ton an (mobil ist die App auf Hochformat festgelegt).
  /// Die Höhe darf nur nach unten korrigieren: ein besonders hohes Display ist
  /// kein Grund, alles aufzublasen, ein flaches (kleines Telefon, geteilter
  /// Bildschirm, Desktop-Fenster) aber sehr wohl, kleiner zu werden.
  static double uiScale(BuildContext context) {
    return _scaleFor(MediaQuery.sizeOf(context));
  }

  /// Wie [uiScale], nur ohne [BuildContext] — für `preferredSize` und andere
  /// Stellen, an denen Flutter die Größe vor dem Build wissen will. Fällt auf
  /// die implizite View zurück; die App ist einfenstrig.
  static double uiScaleOfView() {
    final FlutterView? view = PlatformDispatcher.instance.implicitView;
    if (view == null) return 1.0;
    final size = view.physicalSize / view.devicePixelRatio;
    if (size.isEmpty) return 1.0;
    return _scaleFor(size);
  }

  static double _scaleFor(Size size) {
    double scale = size.width / baselineWidth;
    if (size.height < baselineHeight) {
      // Halbes Gewicht: ein flaches Display soll bremsen, nicht die Breite
      // überstimmen. Voll gewichtet landete schon ein gewöhnliches 360×640er
      // Telefon am unteren Anschlag, obwohl die Breite dafür reicht.
      final heightFactor = (1 + size.height / baselineHeight) / 2;
      scale = math.min(scale, heightFactor);
    }
    return scale.clamp(minScale, maxScale);
  }

  /// Effektive Textskalierung. Wird in main.dart einmal global über die App
  /// gelegt, damit alle fest gesetzten `fontSize:`-Werte mitwandern.
  ///
  /// Zwei Fälle, bewusst unterschiedlich behandelt: hochgestellte Schrift ist
  /// eine Ansage des Nutzers und wird unverändert durchgereicht (nur bei
  /// [maxTextScale] gekappt); unterhalb von 100 % greift der Gerätefaktor,
  /// damit die Oberfläche auf kleinen Geräten kompakter wird.
  ///
  /// Deshalb gilt in Widgets: Schriftgrößen niemals selbst mit [uiScale]
  /// multiplizieren — das skalierte sonst doppelt.
  static TextScaler textScaler(BuildContext context) {
    // scale(1) statt des entfernten textScaleFactor: liefert den Faktor, den
    // der Nutzer im System eingestellt hat.
    final userScale = MediaQuery.textScalerOf(context).scale(1);

    // Wer die Schrift hochgestellt hat, hat das nicht aus Versehen getan.
    // Der Gerätefaktor darf diesen Wunsch nicht wieder einkassieren — auf
    // einem schmalen Telefon hätte er aus 200 % sonst 164 % gemacht, und
    // genau dort sitzt die Person, die es am nötigsten hat.
    if (userScale > 1.0) {
      return TextScaler.linear(userScale.clamp(1.0, maxTextScale));
    }

    // Darunter bleibt es beim Gerätefaktor: kleine Geräte bekommen die
    // Oberfläche etwas kompakter, größer als vorgesehen wird sie nie.
    return TextScaler.linear(
      (userScale * uiScale(context)).clamp(minTextScale, 1.0),
    );
  }

  /// Skaliert eine feste Nicht-Text-Größe (Icon, Avatar, Kachelhöhe).
  static double scaled(BuildContext context, double base) {
    return base * uiScale(context);
  }

  /// Skaliert einen Abstand oder ein Padding.
  ///
  /// Etwas beherzter als [scaled]: auf einem engen Display ist der Leerraum
  /// das Erste, was man opfern kann, damit der Inhalt Platz behält. Quadriert
  /// wird nur nach unten (0,82 → 0,67), nach oben bleibt es linear.
  static double space(BuildContext context, double base) {
    final scale = uiScale(context);
    return base * (scale < 1 ? scale * scale : scale);
  }

  /// Feste Höhe für eine Kachel, deren Inhalt Text ist.
  ///
  /// Wächst mit der effektiven Textskalierung mit — sonst schneidet die
  /// Kachel bei großgestellter Systemschrift die letzte Zeile ab, ohne dass
  /// überhaupt eine Überlaufwarnung erscheint (Text in `Expanded` wird
  /// stillschweigend beschnitten).
  static double textBoxHeight(BuildContext context, double base) {
    return MediaQuery.textScalerOf(context).scale(base);
  }

  /// Feste Dialoggröße, die nie größer wird als das Fenster hergibt.
  ///
  /// Ein `SizedBox(width: 550, height: 720)` im Dialog ist auf dem Desktop
  /// genau richtig und auf einem 640 dp hohen Telefon ein Überlauf. Hier
  /// kommen die Wunschmaße rein, raus kommt, was tatsächlich passt —
  /// abzüglich `insetPadding` und Tastatur.
  static Size dialogSize(
    BuildContext context, {
    required double width,
    required double height,
    EdgeInsets inset = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
  }) {
    final mq = MediaQuery.of(context);
    final available = Size(
      mq.size.width - inset.horizontal,
      mq.size.height - inset.vertical - mq.viewInsets.vertical,
    );
    return Size(
      math.min(width, math.max(available.width, 0)),
      math.min(height, math.max(available.height, 0)),
    );
  }

  /// Check screen size category
  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTabletScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  /// Get screen width category
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) return ScreenSize.mobile;
    if (width < tabletBreakpoint) return ScreenSize.tablet;
    if (width < desktopBreakpoint) return ScreenSize.desktop;
    return ScreenSize.largeDesktop;
  }

  /// Get responsive value based on screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final screenSize = getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.mobile:
        return mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.desktop:
      case ScreenSize.largeDesktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  /// Get dialog constraints for current platform
  static BoxConstraints dialogConstraints(BuildContext context) {
    if (isDesktop || isTabletScreen(context)) {
      return const BoxConstraints(
        maxWidth: 800,
        maxHeight: 700,
      );
    }
    // Mobile: full width with padding
    return BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width - 48,
      maxHeight: MediaQuery.of(context).size.height - 100,
    );
  }

  /// Get sidebar width for dashboard layouts
  static double sidebarWidth(BuildContext context) {
    if (isDesktopScreen(context)) return 280;
    if (isTabletScreen(context)) return 240;
    return 0; // Mobile uses bottom navigation instead
  }

  /// Check if sidebar should be shown
  static bool showSidebar(BuildContext context) {
    return isDesktop || !isMobileScreen(context);
  }

  /// Check if bottom navigation should be shown
  static bool showBottomNavigation(BuildContext context) {
    return isMobile && isMobileScreen(context);
  }

  /// Get content padding based on screen size
  static EdgeInsets contentPadding(BuildContext context) {
    return value(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      desktop: const EdgeInsets.all(32),
    );
  }

  /// Get card width for grid layouts
  static double cardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.mobile:
        return width - 32; // Full width with padding
      case ScreenSize.tablet:
        return (width - 72) / 2; // 2 columns
      case ScreenSize.desktop:
        return (width - 128) / 3; // 3 columns
      case ScreenSize.largeDesktop:
        return (width - 160) / 4; // 4 columns
    }
  }

  /// Get number of grid columns
  static int gridColumns(BuildContext context) {
    return value(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
  }

  /// Get responsive font size
  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return value(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive icon size
  static double iconSize(BuildContext context) {
    return value(
      context,
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
    );
  }

  /// Get app bar height
  static double appBarHeight(BuildContext context) {
    return value(
      context,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
    );
  }
}

/// Legt die Geräteskalierung über einen Teilbaum.
///
/// main.dart hängt das an `MaterialApp.builder`, womit es unter jedem Screen
/// und jedem Dialog liegt. Als eigene Klasse, damit Tests denselben Aufbau
/// benutzen können und nicht versehentlich eine andere Skalierung prüfen als
/// die App tatsächlich verwendet.
class ResponsiveScaling extends StatelessWidget {
  final Widget child;

  const ResponsiveScaling({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return MediaQuery(
      data: media.copyWith(textScaler: Responsive.textScaler(context)),
      child: child,
    );
  }
}

/// Screen size categories
enum ScreenSize {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Responsive builder widget
/// Builds different widgets based on screen size
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = Responsive.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.mobile:
        return mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.desktop:
      case ScreenSize.largeDesktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}

/// Responsive layout that shows sidebar on desktop and bottom nav on mobile
class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final Widget? sidebar;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final int currentIndex;
  final ValueChanged<int>? onNavigationChanged;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    this.sidebar,
    this.bottomNavigationBar,
    this.appBar,
    this.currentIndex = 0,
    this.onNavigationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final showSidebar = Responsive.showSidebar(context) && sidebar != null;
    final showBottomNav = Responsive.showBottomNavigation(context) && bottomNavigationBar != null;

    if (showSidebar) {
      // Desktop/Tablet layout with sidebar
      return Scaffold(
        appBar: appBar,
        body: Row(
          children: [
            SizedBox(
              width: Responsive.sidebarWidth(context),
              child: sidebar,
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    } else {
      // Mobile layout with bottom navigation
      return Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: showBottomNav ? bottomNavigationBar : null,
      );
    }
  }
}

/// Extension for responsive dialog showing
extension ResponsiveDialog on BuildContext {
  /// Show a dialog with responsive sizing
  Future<T?> showResponsiveDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: Responsive.dialogConstraints(context),
          child: child,
        ),
      ),
    );
  }

  /// Show a bottom sheet on mobile, dialog on desktop
  Future<T?> showAdaptiveSheet<T>({
    required Widget child,
    bool isDismissible = true,
  }) {
    if (Responsive.isMobile && Responsive.isMobileScreen(this)) {
      return showModalBottomSheet<T>(
        context: this,
        isScrollControlled: true,
        isDismissible: isDismissible,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => child,
        ),
      );
    } else {
      return showResponsiveDialog<T>(
        child: child,
        barrierDismissible: isDismissible,
      );
    }
  }
}
