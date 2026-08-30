import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Toggles Android's FLAG_SECURE. The app sets FLAG_SECURE on launch to block
/// screenshots/recording, but that also makes MediaProjection capture the app as
/// a black frame — so during a consented Fernwartung session we must clear it,
/// then restore it when the session ends. No-op off Android.
class SecureScreen {
  static const MethodChannel _ch = MethodChannel('de.icd360sev.mitglied/secure_screen');

  /// [secure] false = allow capture (during a remote session); true = restore
  /// the screenshot/recording block.
  /// Gibt zurueck, ob die Sperre danach TATSAECHLICH aus ist.
  ///
  /// ⚠️ Vorher wurde das Ergebnis verworfen und jeder Fehler stillschweigend
  /// verschluckt. Bleibt FLAG_SECURE stehen, ueberträgt die Aufnahme ein
  /// schwarzes Bild — und genau das sah dann aus wie ein Netzproblem. Der
  /// Rueckgabewert ist der GEMESSENE Zustand aus dem UI-Thread, nicht der
  /// gewuenschte.
  static Future<bool> setSecure(bool secure) async {
    if (!Platform.isAndroid) return !secure;
    try {
      final jetztGesperrt = await _ch.invokeMethod<bool>('setSecure', {'secure': secure});
      // Alte Fassungen des Kanals antworten mit null — dann glauben wir ihnen,
      // statt eine Warnung zu erfinden.
      if (jetztGesperrt == null) return !secure;
      return !jetztGesperrt;
    } catch (e) {
      debugPrint('[SecureScreen] FLAG_SECURE nicht umschaltbar: $e');
      return false;
    }
  }
}

/// Android-only: the mediaProjection foreground service that must be running for
/// screen capture on Android 14+ (and to keep the capture alive when the app is
/// backgrounded on Android 10+). flutter_webrtc 1.5.2 does not run one, so we
/// start it around a Fernwartung session. No-op off Android.
class ScreenCaptureFgService {
  static const MethodChannel _ch = MethodChannel('de.icd360sev.mitglied/screen_capture');

  /// Start BEFORE calling getDisplayMedia so MediaProjection is allowed to start.
  static Future<void> start() async {
    if (!Platform.isAndroid) return;
    try {
      await _ch.invokeMethod('start');
    } catch (_) {}
  }

  static Future<void> stop() async {
    if (!Platform.isAndroid) return;
    try {
      await _ch.invokeMethod('stop');
    } catch (_) {}
  }
}
