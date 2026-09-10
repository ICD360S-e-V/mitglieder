import 'dart:io';

import 'package:flutter/services.dart';

import 'logger_service.dart';

/// Haelt Ton und Kamera am Leben, wenn die App waehrend eines Anrufs aus dem
/// Blick geraet.
///
/// Seit Android 12 darf eine App, die nicht im Vordergrund ist, weder Mikrofon
/// noch Kamera halten; ohne einen Vordergrunddienst mit passendem TYP endet ein
/// Anruf also, sobald der Mensch die App verlaesst. Die native Seite ist
/// `AnrufDienst.kt`.
///
/// ⚠️ Nur Android. Auf Linux, macOS und Windows gibt es den Kanal nicht, und
/// ein Aufruf dort wuerde eine MissingPluginException werfen — mitten im
/// Anrufaufbau. Deshalb erst die Plattform pruefen und dann trotzdem alles
/// abfangen: ein Anruf darf an dieser Verbesserung nicht scheitern.
class AnrufVordergrund {
  AnrufVordergrund._();

  static const MethodChannel _kanal = MethodChannel('de.icd360sev.mitglied/anruf_dienst');

  static final LoggerService _log = LoggerService();

  static bool _laeuft = false;

  /// Laeuft der Dienst gerade? Nur zur Diagnose.
  static bool get laeuft => _laeuft;

  /// ⚠️ Es wird BEWUSST kein Name des Gegenuebers uebergeben. Die
  /// Benachrichtigung steht auf dem Sperrbildschirm, und wer mit wem
  /// telefoniert ist dort eine Angabe ueber einen Menschen, die fuer den
  /// Rueckweg niemand braucht — dieselbe Zurueckhaltung wie bei den
  /// Chat-Benachrichtigungen. Den Namen traegt der Anrufschirm, hinter der
  /// Entsperrung. Die native Seite kann einen Namen anzeigen, falls das je
  /// anders entschieden wird.
  ///
  /// [video] entscheidet ueber den angemeldeten Dienst-TYP. Bei einem reinen
  /// Sprachanruf darf `camera` NICHT angemeldet werden: Android 14+ verlangt
  /// dafuer die Berechtigung CAMERA, die dort vielleicht nie erteilt wurde,
  /// und wuerde den Dienst sonst abweisen.
  static Future<void> starten({required bool video, String? name}) async {
    if (!Platform.isAndroid) return;
    try {
      final ok = await _kanal.invokeMethod<bool>('start', {
        'video': video,
        'name': name,
      });
      _laeuft = ok ?? false;
      _log.info(
        'AnrufVordergrund: Dienst ${_laeuft ? "laeuft" : "NICHT gestartet"} (video: $video)',
        tag: 'CALL',
      );
    } catch (e) {
      _laeuft = false;
      _log.warning('AnrufVordergrund: Start fehlgeschlagen: $e', tag: 'CALL');
    }
  }

  /// Beendet den Dienst. Wird aus `_cleanup()` gerufen, also auf JEDEM Weg,
  /// auf dem ein Anruf endet — sonst bliebe eine Benachrichtigung ueber ein
  /// Gespraech stehen, das es nicht mehr gibt.
  static Future<void> beenden() async {
    if (!Platform.isAndroid) return;
    if (!_laeuft) return;
    _laeuft = false;
    try {
      await _kanal.invokeMethod('stop');
      _log.info('AnrufVordergrund: Dienst beendet', tag: 'CALL');
    } catch (e) {
      _log.warning('AnrufVordergrund: Stopp fehlgeschlagen: $e', tag: 'CALL');
    }
  }
}
