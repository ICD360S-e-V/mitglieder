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

  /// Wird gerufen, wenn im Fenster ueber anderen Apps auf Auflegen getippt
  /// wird. Gesetzt von [VoiceCallService]; nativ laesst sich ein WebRTC-Anruf
  /// nicht beenden.
  static void Function()? beimAuflegenAusDemFenster;

  static bool _handlerSteht = false;

  static void _handlerStellen() {
    if (_handlerSteht) return;
    _handlerSteht = true;
    _kanal.setMethodCallHandler((ruf) async {
      if (ruf.method == 'auflegen') beimAuflegenAusDemFenster?.call();
      return null;
    });
  }

  /// Zeigt das Fenster ueber anderen Apps. Ohne die Berechtigung „Ueber
  /// anderen Apps anzeigen" passiert nichts — der Anruf laeuft weiter, es
  /// fehlt nur dieses Fenster.
  ///
  /// ⚠️ [titel] kommt von der OBERFLAECHE, schon uebersetzt. Diese App gibt es
  /// in 28 Sprachen; eine String-Ressource auf der nativen Seite waere eine
  /// zweite Uebersetzungsquelle neben den ARB-Dateien, und beide liefen beim
  /// ersten geaenderten Wort auseinander.
  static Future<void> systemfensterZeigen({
    required bool video,
    required String titel,
    required String auflegen,
    required int startzeit,
    required int guete,
  }) async {
    if (!Platform.isAndroid) return;
    _handlerStellen();
    try {
      await _kanal.invokeMethod('overlayZeigen', {
        'video': video,
        'titel': titel,
        'auflegen': auflegen,
        'startzeit': startzeit,
        'guete': guete,
      });
    } catch (e) {
      _log.warning('AnrufVordergrund: Systemfenster nicht moeglich: $e',
          tag: 'CALL');
    }
  }

  /// Dauer und Guete an eine BEREITS sichtbare Karte nachreichen.
  ///
  /// ⚠️ `overlayZeigen` ist absichtlich idempotent (steht die Karte, tut es
  /// nichts) — ein zweiter Aufruf koennte sie also nicht auffrischen. Wer die
  /// App waehrend des Klingelns verlaesst, bekaeme sonst nie eine Dauer zu
  /// sehen.
  static Future<void> systemfensterStand({
    required int startzeit,
    required int guete,
  }) async {
    if (!Platform.isAndroid) return;
    try {
      await _kanal.invokeMethod('overlayStand', {
        'startzeit': startzeit,
        'guete': guete,
      });
    } catch (e) {
      _log.warning('AnrufVordergrund: Systemfenster-Stand: $e', tag: 'CALL');
    }
  }

  static Future<void> systemfensterVerbergen() async {
    if (!Platform.isAndroid) return;
    try {
      await _kanal.invokeMethod('overlayVerbergen');
    } catch (e) {
      _log.warning('AnrufVordergrund: Systemfenster-Stopp: $e', tag: 'CALL');
    }
  }

  /// Ist „Ueber anderen Apps anzeigen" erteilt? Fuer den Hinweis und die
  /// Zeile im Konto — nie als Bedingung fuer einen Anruf.
  static Future<bool> systemfensterErlaubt() async {
    if (!Platform.isAndroid) return false;
    try {
      return await _kanal.invokeMethod<bool>('overlayErlaubt') ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Fuehrt in die Systemeinstellung. Die Berechtigung gibt nur der Mensch.
  ///
  /// Gibt zurueck, ob sich ueberhaupt ein Bildschirm geoeffnet hat — die
  /// native Seite probiert drei Wege.
  ///
  /// ⚠️ `false` MUSS die Oberflaeche zeigen. Sonst tippt der Mensch auf einen
  /// Knopf, es passiert nichts, und er hat keine Ahnung, dass er die
  /// Berechtigung von Hand suchen muss.
  static Future<bool> systemfensterEinstellung() async {
    if (!Platform.isAndroid) return false;
    try {
      return await _kanal.invokeMethod<bool>('overlayEinstellung') ?? false;
    } catch (e) {
      _log.warning('AnrufVordergrund: Einstellung nicht erreichbar: $e',
          tag: 'CALL');
      return false;
    }
  }

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
