import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/language_selection.dart';
import 'screens/welcome.dart';
import 'services/api_service.dart';
import 'services/language_service.dart';
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
import 'widgets/remote_touch_overlay.dart';

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
  // Load the user-chosen UI language before anything renders. Device locale
  // is intentionally NOT consulted — first-launch users will see the
  // selector below, returning users get their saved pick.
  await StartupDiagnostics.stepWithTimeout('LanguageService.load', const Duration(seconds: 3),
      () => LanguageService.instance.load());
  await StartupDiagnostics.stepWithTimeout('LoggerService.init', const Duration(seconds: 5),
      () => LoggerService().init());
  await StartupDiagnostics.stepWithTimeout('UpdateService.initVersion', const Duration(seconds: 5),
      () => UpdateService.initVersion());
  await StartupDiagnostics.stepWithTimeout('ApiService.initialize', const Duration(seconds: 15),
      () => ApiService().initialize());

  // Network resilience: circuit breaker + retry on top of every API call.
  // Security telemetry: queues TLS interception reports for push when the
  // network recovers. Mitgliedernummer is added after login.
  await StartupDiagnostics.stepWithTimeout('NetworkResilience.start', const Duration(seconds: 15),
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

  // Fire-and-forget upload of the startup transcript so failures from a
  // user's device land in the central log bucket — no need for the user
  // to `cat` and paste. Scheduled with a small delay so it never delays
  // the first frame; defaults to 'unknown' for any identifier whose
  // upstream service didn't initialise.
  Future<void>.delayed(const Duration(seconds: 3), () async {
    await StartupDiagnostics.uploadToServer(
      appVersion: UpdateService.currentVersion,
      deviceId: LoggerService().deviceId,
    );
  });
}

class MitgliedApp extends StatefulWidget {
  const MitgliedApp({super.key});

  @override
  State<MitgliedApp> createState() => _MitgliedAppState();
}

class _MitgliedAppState extends State<MitgliedApp> {
  // Flipped to true once the first-launch user picks a language. Returning
  // users skip the picker because LanguageService.hasUserChoice is already
  // true after LanguageService.load() in main().
  bool _languagePicked = LanguageService.instance.hasUserChoice;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LanguageService.instance.localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          title: 'ICD360S e.V - Mitgliederportal',
          debugShowCheckedModeBanner: false,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4a90d9),
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            fontFamily: 'Roboto',
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
          ),
          builder: (context, child) => RemoteTouchOverlay(
            // During a Fernwartung session, marks where the member taps so the
            // Vorsitzer sees it in the shared screen.
            child: NetworkSecurityBanner(
              child: child ?? const SizedBox.shrink(),
            ),
          ),
          home: _languagePicked
              ? const WelcomeScreen()
              : LanguageSelectionScreen(
                  onSelected: () => setState(() => _languagePicked = true),
                ),
        );
      },
    );
  }
}
