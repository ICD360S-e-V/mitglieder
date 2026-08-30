import 'package:flutter/services.dart';
import '../logger_service.dart';
import 'input_injector.dart';

final _log = LoggerService();

/// macOS input injection via CGEvent, bridged through a MethodChannel to native
/// Swift (see macos/Runner/MainFlutterWindow.swift). Requires the app to be
/// non-sandboxed (done) and to have the Accessibility permission (System
/// Settings › Privacy & Security › Accessibility) — the constructor prompts for
/// it. It also flips the app window to capturable for the duration of the
/// session so the Vorsitzer can see the member's own app while helping.
class MacosInputInjector extends InputInjector {
  static const MethodChannel _ch = MethodChannel('de.icd360sev.mitglied/remote_input');

  MacosInputInjector() {
    // Prompt for Accessibility (no-op if already granted) and let this app's
    // window into the shared stream while the session is active.
    _ch.invokeMethod('ensureAccessibility').catchError((e) {
      _log.warning('MacosInputInjector: ensureAccessibility failed: $e', tag: 'REMOTE');
      return null;
    });
    _ch.invokeMethod('setCapturable', {'on': true}).catchError((_) => null);
  }

  @override
  bool get isSupported => true;

  @override
  void setScreenSize(int width, int height) {}

  @override
  Future<void> mouseMove(double nx, double ny) async {
    try {
      await _ch.invokeMethod('mouseMove', {'x': nx, 'y': ny});
    } catch (_) {}
  }

  @override
  Future<void> mouseButton(int button, bool down) async {
    try {
      await _ch.invokeMethod('mouseButton', {'b': button, 'down': down});
    } catch (_) {}
  }

  @override
  Future<void> mouseWheel(double dx, double dy) async {
    try {
      await _ch.invokeMethod('mouseWheel', {'dx': dx, 'dy': dy});
    } catch (_) {}
  }

  @override
  Future<void> keyEvent({required int hid, String? character, required bool down}) async {
    try {
      await _ch.invokeMethod('keyEvent', {'hid': hid, 'down': down});
    } catch (_) {}
  }

  @override
  void dispose() {
    // Restore the anti-capture protection when the session ends.
    _ch.invokeMethod('setCapturable', {'on': false}).catchError((_) => null);
  }
}