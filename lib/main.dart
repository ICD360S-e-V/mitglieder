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
import 'services/platform/platform_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global error handling to prevent unhandled crashes
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
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

  // Initialize services with error handling
  try {
    await LoggerService().init();
    await ApiService().initialize();

    if (PlatformFactory.isMobile) {
      await NotificationService().initialize();
      await TicketNotificationService().initialize();
      await BackgroundService.initializeService();
    } else {
      await PlatformFactory.instance.initialize();
    }
  } catch (e) {
    debugPrint('[INIT] Service initialization error (non-fatal): $e');
  }

  // Credentials will be sent to background service after login (in saveTokens)
  // Diagnostic service will be started from LoginScreen after user consent

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
      home: const WelcomeScreen(),
    );
  }
}
