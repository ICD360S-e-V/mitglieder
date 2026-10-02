import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Die Zwischenablage der App — abgesichert: was die App hineinlegt, ist nach
/// [frist] wieder weg, und das Fenster sagt es.
///
/// Festlegung des Vorsitzenden (02.10.2026, Idee 4): dieselbe Absicherung wie
/// in der Vorsitzer-App (#1045, #1049).
///
///  * **Android:** über den nativen Kanal ([kanal], Zwischenablage.kt) als
///    `EXTRA_IS_SENSITIVE` markiert — Tastatur und System-Vorschau zeigen
///    Punkte statt des Werts — und nach [frist] gelöscht. Der Zeitgeber lebt
///    dort, im Prozess.
///  * **Ohne den Kanal** (Windows, Linux, macOS, iOS): Flutters
///    [Clipboard.setData] und ein Dart-Timer, der danach leert
///    ([ohneKanalGelegt]).
///  * Jedes [Clipboard.setData] — auch „Kopieren" im Kontextmenü jedes
///    Textfelds — kommt hier an: `SicherClipboardBindung` fängt es ab
///    (sicher_clipboard_bindung.dart).
///  * Gelöscht → `ZwischenablageMelder` zeigt es.
class SicherClipboard {
  SicherClipboard._();

  static const MethodChannel kanal =
      MethodChannel('de.icd360sev.mitglied/zwischenablage');

  /// Länger bleibt nichts aus der App in der Zwischenablage.
  static const Duration frist = Duration(seconds: 30);

  /// Über den nativen Kanal (nur Android): true, wenn [text] darin liegt —
  /// bei leerem Text: wenn geleert ist.
  static Future<bool> nativ(String text) async {
    if (!Platform.isAndroid) return false;
    try {
      final ok = await kanal.invokeMethod<bool>(
          'kopieren', {'text': text, 'frist': frist.inMilliseconds});
      return ok == true;
    } catch (_) {
      return false;
    }
  }

  static Timer? _loeschTimer;

  /// Liegt noch etwas OHNE den Kanal von der App in der Zwischenablage?
  static bool _ohneKanalFaellig = false;

  /// Die App hat etwas ohne den Kanal in die Zwischenablage gelegt: nach
  /// [frist] wieder leeren.
  static void ohneKanalGelegt() {
    _ohneKanalFaellig = true;
    _loeschTimer?.cancel();
    _loeschTimer = Timer(frist, leeren);
  }

  /// Leert die Zwischenablage sofort — nur, wenn noch etwas aus der App
  /// darin liegt.
  static Future<void> leeren() async {
    _loeschTimer?.cancel();
    _loeschTimer = null;
    if (Platform.isAndroid) {
      try {
        await kanal.invokeMethod<void>('leeren');
      } catch (_) {}
    }
    if (!_ohneKanalFaellig) return;
    _ohneKanalFaellig = false;
    try {
      await Clipboard.setData(const ClipboardData(text: ''));
    } catch (_) {}
    _zeigen(DateTime.now(), spaet: false);
  }

  static void Function(DateTime zeit, {required bool spaet})? _melder;

  /// Wer zeigt, dass gelöscht wurde: `ZwischenablageMelder`.
  static void melderSetzen(
      void Function(DateTime zeit, {required bool spaet}) melder) {
    _melder = melder;
    kanal.setMethodCallHandler(_vonAndroid);
  }

  /// Nimmt [melder] wieder ab — nur, wenn er noch der aktuelle ist.
  static void melderLoesen(
      void Function(DateTime zeit, {required bool spaet}) melder) {
    if (_melder != melder) return;
    _melder = null;
    kanal.setMethodCallHandler(null);
  }

  /// Android meldet: gelöscht — `spaet`, wenn es geschah, während die App im
  /// Hintergrund war.
  static Future<void> _vonAndroid(MethodCall call) async {
    if (call.method != 'geloescht') return;
    final a = call.arguments;
    final ms = a is Map ? a['zeit'] : null;
    _zeigen(
      ms is int ? DateTime.fromMillisecondsSinceEpoch(ms) : DateTime.now(),
      spaet: a is Map && a['spaet'] == true,
    );
  }

  static void _zeigen(DateTime zeit, {required bool spaet}) =>
      _melder?.call(zeit, spaet: spaet);
}
