import 'dart:io';
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
