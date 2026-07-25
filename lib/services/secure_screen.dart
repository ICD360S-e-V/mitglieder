import 'dart:io';
import 'package:flutter/services.dart';

/// Toggles Android's FLAG_SECURE. The app sets FLAG_SECURE on launch to block
/// screenshots/recording, but that also makes MediaProjection capture the app as
/// a black frame — so during a consented Fernwartung session we must clear it,
/// then restore it when the session ends. No-op off Android.
class SecureScreen {
  static const MethodChannel _ch = MethodChannel('de.icd360sev.mitglied/secure_screen');

  /// [secure] false = allow capture (during a remote session); true = restore
  /// the screenshot/recording block.
  static Future<void> setSecure(bool secure) async {
    if (!Platform.isAndroid) return;
    try {
      await _ch.invokeMethod('setSecure', {'secure': secure});
    } catch (_) {
      // Channel missing on some embeddings — ignore, capture just stays blocked.
    }
  }
}
