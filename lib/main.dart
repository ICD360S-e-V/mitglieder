import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/welcome.dart';
import 'services/api_service.dart';
import 'services/notification_service.dart';
import 'services/ticket_notification_service.dart';
import 'services/logger_service.dart';
import 'services/background_service.dart';
import 'services/network_resilience.dart';
import 'services/security_event_reporter.dart';
import 'services/startup_diagnostics.dart';
import 'services/update_service.dart';
import 'services/platform/platform_factory.dart';
import 'widgets/network_security_banner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Record every startup step to a plain-text log file from the very first
  // moment. A startup that never reaches runApp() (gray frame, no UI) is
  // still debuggable: the user can `cat` the file and see exactly which
  // service hung, threw, or timed out. See StartupDiagnostics.logPath for
  // the resolved location (XDG_CACHE_HOME → $HOME/.cache → /tmp fallback).
  StartupDiagnostics.init();

  // Global error handling to prevent unhandled crashes
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    StartupDiagnostics.log('FlutterError: ${details.exception}');
    debugPrint('[CRASH] Flutter error: ${details.exception}');
  };

  // Platform-specific initialization
  if (PlatformFactory.isMobile) {
    // Mobile: Set preferred orientations (portrait only)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Mobile: Set system UI overlay style (status bar & navigation bar)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
  // Desktop: Window management is handled in DesktopPlatformService.initialize()

  // Security: Screenshots blocked via FLAG_SECURE in Android MainActivity.kt
  // Windows: anti-debug + DLL injection protection in main.cpp
  // macOS: NSWindow.sharingType = .none in MainFlutterWindow.swift

  // Each await below is wrapped with StartupDiagnostics so failures and
  // timeouts are observable in the on-disk log even if the GUI never
  // renders. Any single step throwing is non-fatal — we still call
  // runApp() at the bottom so the user gets a UI to read the error from.
  await StartupDiagnostics.stepWithTimeout('LoggerService.init', const Duration(seconds: 5),
      () => LoggerService().init());
  await StartupDiagnostics.stepWithTimeout('UpdateService.initVersion', const Duration(seconds: 5),
      () => UpdateService.initVersion());
  await StartupDiagnostics.stepWithTimeout('ApiService.initialize', const Duration(seconds: 5),
      () => ApiService().initialize());

  // Network resilience: circuit breaker + retry on top of every API call.
  // Security telemetry: queues TLS interception reports for push when the
  // network recovers. Mitgliedernummer is added after login.
  await StartupDiagnostics.stepWithTimeout('NetworkResilience.start', const Duration(seconds: 5),
      () => NetworkResilience.instance.start());
  await StartupDiagnostics.stepWithTimeout('SecurityEventReporter.start', const Duration(seconds: 5),
      () => SecurityEventReporter.instance.start(
            deviceId: LoggerService().deviceId,
            appVersion: UpdateService.currentVersion,
            platform: Platform.operatingSystem,
            osVersion: Platform.operatingSystemVersion,
          ));

  if (PlatformFactory.isMobile) {
    await StartupDiagnostics.stepWithTimeout('NotificationService.initialize', const Duration(seconds: 5),
        () => NotificationService().initialize());
    await StartupDiagnostics.stepWithTimeout('TicketNotificationService.initialize', const Duration(seconds: 5),
        () => TicketNotificationService().initialize());
    await StartupDiagnostics.stepWithTimeout('BackgroundService.initializeService', const Duration(seconds: 5),
        () => BackgroundService.initializeService());
  } else {
    // Desktop init (notifications + windowManager.show + tray_manager) is
    // the prime suspect for gray-screen-no-UI in a Proxmox/QEMU VM
    // without GPU passthrough — _initializeTray() awaits a D-Bus reply
    // from a StatusNotifierWatcher that doesn't exist in the sandbox,
    // and the chain stalls forever. The 8s budget lets runApp() fire so
    // members see the welcome screen either way; the log shows exactly
    // which sub-step timed out so the underlying fix can be targeted.
    await StartupDiagnostics.stepWithTimeout('PlatformFactory.desktop.initialize', const Duration(seconds: 8),
        () => PlatformFactory.instance.initialize());
  }

  // Credentials will be sent to background service after login (in saveTokens)
  // Diagnostic service will be started from LoginScreen after user consent

  StartupDiagnostics.log('→ runApp()');
  runApp(const MitgliedApp());
}

class MitgliedApp extends StatelessWidget {
  const MitgliedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICD360S e.V - Mitgliederportal',
      debugShowCheckedModeBanner: false,
      // Localization configuration
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Auto-detect device language, fallback to German
      localeResolutionCallback: (locale, supportedLocales) {
        debugPrint('[L10N] Device locale: ${locale?.languageCode ?? 'null'} (${locale?.countryCode ?? 'no country'})');
        debugPrint('[L10N] Supported locales: ${supportedLocales.map((l) => l.languageCode).join(', ')}');

        if (locale != null) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              debugPrint('[L10N] ✓ Matched locale: ${supportedLocale.languageCode}');
              return supportedLocale;
            }
          }
        }
        debugPrint('[L10N] ✗ No match found, using fallback: de (German)');
        return const Locale('de'); // Default to German
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4a90d9),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Default Android font
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      // Wrap every screen with the global network-security banner so TLS
      // interceptions, DNS failures and slow-network conditions surface on
      // any route without per-screen integration.
      builder: (context, child) => NetworkSecurityBanner(
        child: child ?? const SizedBox.shrink(),
      ),
      home: const WelcomeScreen(),
    );
  }
}
