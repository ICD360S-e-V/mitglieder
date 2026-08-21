import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The four choices a member has. They are mutually exclusive on purpose:
/// an earlier design layered a "night schedule" switch on top of "follow the
/// phone", which meant the app could contradict the phone at 20:00 and agree
/// with it again at 06:00 — indistinguishable from a bug to the person holding
/// it. One setting, one answer.
enum AppThemeMode {
  /// Always light, whatever the phone or the clock say.
  light,

  /// Always dark.
  dark,

  /// Mirror the phone's own light/dark setting. Android 10+ and iOS 13+ both
  /// have a night schedule of their own, so a member who already set one there
  /// gets it honoured here for free.
  system,

  /// Dark from [ThemeService.darkStartHour] to [ThemeService.darkEndHour],
  /// light in between — regardless of the phone setting.
  schedule,
}

/// Holds the member's theme choice and resolves it to the [ThemeMode] that
/// MaterialApp consumes.
///
/// Modelled on `LanguageService`: a singleton loaded once in `main()` before
/// the first frame, exposing a [ValueNotifier] the app root listens to, so a
/// change repaints everything without a state-management dependency.
class ThemeService {
  ThemeService._();
  static final ThemeService instance = ThemeService._();

  static const _prefsKey = 'app_theme_mode_v1';

  /// Dark runs from 20:00 up to (not including) 06:00.
  static const int darkStartHour = 20;
  static const int darkEndHour = 6;

  AppThemeMode _mode = AppThemeMode.system;
  bool _loaded = false;
  Timer? _boundaryTimer;
  AppLifecycleListener? _lifecycle;

  /// The member's stored choice — what the settings UI ticks.
  AppThemeMode get mode => _mode;

  /// What MaterialApp should render right now. For [AppThemeMode.system] this
  /// stays [ThemeMode.system] and Flutter does the resolving; for
  /// [AppThemeMode.schedule] we resolve it ourselves against the clock.
  final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  /// True when the wall clock is inside the night window. Exposed so the
  /// settings UI can tell the member what "Automatic" is doing at this moment
  /// instead of leaving them to work it out from the hours.
  static bool isNightNow([DateTime? now]) {
    final hour = (now ?? DateTime.now()).hour;
    return hour >= darkStartHour || hour < darkEndHour;
  }

  /// Read the saved choice from disk. Idempotent; safe to call more than once.
  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_prefsKey);
      if (saved != null) {
        _mode = AppThemeMode.values.firstWhere(
          (m) => m.name == saved,
          orElse: () => AppThemeMode.system,
        );
      }
    } catch (e) {
      debugPrint('[ThemeService] load failed: $e');
    }
    _apply();
    _startLifecycleWatch();
  }

  /// Persist the member's pick and repaint immediately.
  Future<void> setMode(AppThemeMode mode) async {
    _mode = mode;
    _apply();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, mode.name);
    } catch (e) {
      debugPrint('[ThemeService] save failed: $e');
    }
  }

  /// Resolve [_mode] against the clock and arm the next boundary.
  void _apply() {
    _boundaryTimer?.cancel();
    _boundaryTimer = null;

    switch (_mode) {
      case AppThemeMode.light:
        themeMode.value = ThemeMode.light;
      case AppThemeMode.dark:
        themeMode.value = ThemeMode.dark;
      case AppThemeMode.system:
        themeMode.value = ThemeMode.system;
      case AppThemeMode.schedule:
        themeMode.value = isNightNow() ? ThemeMode.dark : ThemeMode.light;
        _armBoundaryTimer();
    }
  }

  /// Sleep until the next 20:00 or 06:00 and re-resolve there.
  ///
  /// One timer to the next edge, not a minute-by-minute poll: the app spends
  /// most of its life in one state or the other, and waking the isolate 1440
  /// times a day to learn nothing changed is exactly the battery cost dark mode
  /// is supposed to save. [_apply] recomputes from scratch when it fires, so a
  /// timezone change or a DST jump corrects itself at the next edge rather than
  /// accumulating drift.
  void _armBoundaryTimer() {
    final now = DateTime.now();
    final nextHour = isNightNow(now) ? darkEndHour : darkStartHour;

    var next = DateTime(now.year, now.month, now.day, nextHour);
    if (!next.isAfter(now)) {
      next = next.add(const Duration(days: 1));
    }

    // A second past the hour, so a timer that fires a hair early does not land
    // on 19:59:59 and re-arm itself for the same edge 24 hours later.
    final delay = next.difference(now) + const Duration(seconds: 1);
    _boundaryTimer = Timer(delay, _apply);
  }

  /// Re-resolve whenever the app comes back to the foreground.
  ///
  /// Timers do not survive a suspended process on either mobile platform: a
  /// phone locked at 19:00 and unlocked at 22:00 never fired the 20:00 timer,
  /// and without this the member would be staring at the light theme in bed —
  /// the one case the schedule exists for.
  void _startLifecycleWatch() {
    _lifecycle?.dispose();
    _lifecycle = AppLifecycleListener(
      onResume: () {
        if (_mode == AppThemeMode.schedule) _apply();
      },
    );
  }
}
