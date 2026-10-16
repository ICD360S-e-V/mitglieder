import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../utils/fehler_text.dart';
import 'logger_service.dart';
import 'update_service.dart';

/// Fängt jeden Fehler, den niemand gefangen hat — in DIESER Engine — und
/// schreibt ihn als Zeile mit der Marke `FEHLER` ins Protokoll, das die App
/// ohnehin hochlädt (`api/logs/mitglieder_<plattform>.php`). Der Server trägt
/// ihn ins Fenster „App-Fehler“ der Vorsitzer-App ein, Herkunft „Mitglieder“.
///
/// Kopie des FehlerWaechter der Vorsitzer-App (dort seit dem 14.10.2026) —
/// Wunsch des Vorsitzenden, 16.10.2026: „continua cu etapa 2“. Bis dahin
/// zeigte `FlutterError.onError` hier einen Fehler nur an und schrieb ihn ins
/// Startprotokoll auf dem Gerät; was ohne Flutter auf dem Stapel durchfiel
/// (Future, Timer, Stream ohne onError) druckte die Engine nur in die
/// Konsole. Und aus den Engines im Hintergrund kam gar nichts an.
///
/// Anders als in der Vorsitzer-App:
/// - kein Ausgang auf der Platte (dort das Plugin icd_protokoll): die Zeile
///   geht in die Warteschlange des [LoggerService];
/// - die Engines im Hintergrund (WorkManager, Vordergrunddienst) laden sonst
///   nichts hoch — mit `hochladen: true` schickt ihr LoggerService jede
///   Fehlerzeile selbst los ([LoggerService.nurFehlerHochladen]);
/// - kein „gefangen“: die Zeilen von `LoggerService.error` liest der Server
///   schon selbst (Stufe error, seit dem 16.10.2026).
///
/// 🔴 WARUM IN JEDER ENGINE: Fehlerhandler sind Felder des Isolates
/// (`FlutterError.onError`, `PlatformDispatcher.instance.onError`), und jede
/// Engine hat ihr eigenes. Deshalb ruft JEDER Einstieg
/// (`@pragma('vm:entry-point')`) [einrichten] auf; fehler_waechter_test hält
/// die Liste vollständig.
///
/// Zwei Wege, beide nötig (docs.flutter.dev/testing/errors):
/// - `FlutterError.onError`: was das Framework fängt (Bauen, Layout, Malen,
///   Gesten). Der bisherige Handler läuft danach weiter (Konsole,
///   Startprotokoll).
/// - `PlatformDispatcher.onError`: was ohne Flutter auf dem Stapel durchfällt
///   (Future, Timer, Stream ohne onError, `invokeMethod` in `onPressed`).
///   Antwortet `false` wie bisher — die Engine schreibt es dann ins Logcat.
///
/// ⚠️ Ein Handler darf nie werfen und nie warten. Alles hier ist in
/// try/catch, und abgelegt wird ohne `await`.
class FehlerWaechter {
  FehlerWaechter._();

  /// Die Engine, in der dieses Isolate läuft: `haupt`, `dienst`
  /// (Vordergrunddienst), `hintergrund` (WorkManager).
  static String get engine => _engine;
  static String _engine = '?';
  static bool _eingerichtet = false;

  /// Wie oft jedes Merkmal schon kam — siehe [_durchlassen].
  static final Map<String, int> _gesehen = <String, int>{};

  /// Höchstens so viele Meldungen je Minute und Engine. Ein Fehler beim
  /// Bauen kommt sonst mit jedem Bild, 60-mal in der Sekunde.
  static const int hoechstensJeMinute = 60;
  static int _minute = -1;
  static int _inDieserMinute = 0;

  /// Die Uhr — im Test fest, damit eine Minutengrenze nichts verfälscht.
  @visibleForTesting
  static DateTime Function() uhr = DateTime.now;

  /// Richtet die beiden Handler ein — als Erstes im Einstieg, vor `runApp`.
  ///
  /// [hochladen]: diese Engine lädt NICHT selbst im Takt hoch (WorkManager,
  /// Vordergrunddienst) — ihr LoggerService schickt dann jede Fehlerzeile
  /// selbst los. Nur die Haupt-Engine hat den Takt (`startUpload`).
  static void einrichten(String engine, {bool hochladen = false}) {
    _engine = engine;
    if (hochladen) LoggerService().nurFehlerHochladen(_fassung());
    if (_eingerichtet) return;
    _eingerichtet = true;

    final vorher = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails d) {
      if (!tastaturVersatz(d)) {
        try {
          melden(d.exception, d.stack, quelle: 'Flutter', leise: d.silent);
        } catch (_) {
          // Nie aus dem Handler heraus werfen.
        }
      }
      if (vorher != null) {
        vorher(d);
      } else {
        FlutterError.presentError(d);
      }
    };

    final vorherPlattform = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (Object fehler, StackTrace stapel) {
      try {
        melden(fehler, stapel, quelle: 'Dart');
      } catch (_) {
        // Nie aus dem Handler heraus werfen.
      }
      return vorherPlattform?.call(fehler, stapel) ?? false;
    };
  }

  /// Die Fassung für eine Engine im Hintergrund — dort hat niemand
  /// `UpdateService.initVersion` gerufen.
  static Future<String> _fassung() async {
    try {
      if (UpdateService.currentVersion == 'unknown') {
        await UpdateService.initVersion();
      }
    } catch (_) {
      // Dann bleibt es „unknown“; der Server nimmt die Fassung der Zeile.
    }
    return UpdateService.currentVersion;
  }

  /// Die Tastatur unter Windows kommt aus dem Tritt (eine Taste „schon
  /// gedrückt“) — kein Fehler der App, nur eine Assertion im Debug-Bau.
  static bool tastaturVersatz(FlutterErrorDetails details) {
    final message = details.exceptionAsString();
    if (!message.contains('KeyDownEvent') &&
        !message.contains('KeyUpEvent') &&
        !message.contains('KeyRepeatEvent')) {
      return false;
    }
    return message.contains('physical key is already pressed') ||
        message.contains('physical key is not pressed') ||
        message.contains('pressed on a different logical key');
  }

  /// Meldet [fehler] — von den Handlern oben, und von Stellen, die einen
  /// Fehler fangen, der trotzdem auffallen soll ([kanal]).
  ///
  /// [leise]: ein Fehler aus der Umgebung (`FlutterErrorDetails.silent`, z. B.
  /// ein Bild, das nicht lädt) — Stufe `warning` statt `error`.
  static void melden(
    Object fehler,
    StackTrace? stapel, {
    required String quelle,
    bool leise = false,
  }) {
    final stapelText = stapelAlsText(stapel, fehler);
    final merkmal = merkmalVon(fehler, stapelText);
    final n = (_gesehen[merkmal] ?? 0) + 1;
    if (_gesehen.length > 1000) _gesehen.clear();
    _gesehen[merkmal] = n;
    if (!_durchlassen(n) || !_imTakt()) return;

    final text = '$quelle-Fehler in „$_engine“: ${fehlerAlsText(fehler)}'
        '${n > 1 ? ' — zum $n. Mal' : ''}';
    LoggerService().fehlerZeile(
      text,
      level: leise ? LogLevel.warning : LogLevel.error,
      felder: <String, Object?>{
        'stack': stapelText,
        'engine': _engine,
        'fingerprint': merkmal,
        'count': n,
        'version':
            '${UpdateService.currentVersion}+${UpdateService.currentBuildNumber}',
      },
    );
  }

  /// Das erste Mal, dann beim 10., 100., 1000. Mal und jedes 10.000. Mal —
  /// mit der Zahl in der Zeile. So bleibt sichtbar, WIE oft, ohne Flut.
  static bool _durchlassen(int n) =>
      n == 1 || n == 10 || n == 100 || n == 1000 || n % 10000 == 0;

  static bool _imTakt() {
    final minute = uhr().millisecondsSinceEpoch ~/ 60000;
    if (minute != _minute) {
      _minute = minute;
      _inDieserMinute = 0;
    }
    return ++_inDieserMinute <= hoechstensJeMinute;
  }

  /// Art und Meldung, gesäubert ([fehlerSaeubern]). `FormatException` ohne
  /// die zitierte Eingabe, `PlatformException` ohne die Details.
  @visibleForTesting
  static String fehlerAlsText(Object fehler) {
    final String t;
    if (fehler is FormatException) {
      t = 'FormatException: ${fehler.message}'
          '${fehler.offset != null ? ' (Stelle ${fehler.offset})' : ''}';
    } else if (fehler is PlatformException) {
      t = 'PlatformException(${fehler.code}): ${fehler.message ?? ''}';
    } else {
      t = fehler.toString();
    }
    return fehlerSaeubern(t, hoechstens: 1000);
  }

  /// Der Stapel: bis zu 40 Rahmen von Dart, bei einer `PlatformException`
  /// dazu der Java-Stapel aus Kotlin (Flutter legt ihn in `stacktrace`).
  @visibleForTesting
  static String stapelAlsText(StackTrace? stapel, Object fehler) {
    final zeilen = <String>[];
    if (stapel != null) {
      for (final z in stapel.toString().split('\n')) {
        final t = z.trimRight();
        if (t.isEmpty) continue;
        if (zeilen.length == 40) {
          zeilen.add('…');
          break;
        }
        zeilen.add(t);
      }
    }
    if (fehler is PlatformException) {
      final details = fehler.details;
      final java = fehler.stacktrace ??
          (details is String && details.contains('\tat ') ? details : null);
      if (java != null) {
        zeilen.add('— Java —');
        zeilen.addAll(java.split('\n').take(30));
      }
    }
    return fehlerSaeubern(zeilen.join('\n'), hoechstens: 8000, nummern: false);
  }

  /// Woran derselbe Fehler wiederzuerkennen ist: die Art und der erste Rahmen
  /// aus dem eigenen Code — OHNE Zeilennummer, sonst wäre er nach jeder
  /// Fassung ein neuer. Ohne Stapel: die Meldung, Ziffern zu 0.
  @visibleForTesting
  static String merkmalVon(Object fehler, String stapelText) {
    final rahmen = stapelText.split('\n');
    final eigener = rahmen.firstWhere(
      (z) => z.contains('package:icd360sev_mitglied/'),
      orElse: () => rahmen.firstWhere(
        (z) => z.startsWith('#') || z.trimLeft().startsWith('at '),
        orElse: () => '',
      ),
    );
    final ort = eigener.isNotEmpty
        ? eigener
            .replaceFirst(RegExp(r'^#\d+\s+'), '')
            .trim()
            .replaceAll(RegExp(r':\d+(:\d+)?\)'), ')')
        : fehlerAlsText(fehler).replaceAll(RegExp(r'\d+'), '0');
    final kurz = ort.length > 200 ? ort.substring(0, 200) : ort;
    return '${fehler.runtimeType}|$kurz';
  }

  /// Umhüllt den Handler eines Kanals, den Kotlin ruft: was dort fliegt, kam
  /// bisher an keinem Handler vorbei — Flutter macht daraus nur eine
  /// Fehlerantwort an Kotlin, und Kotlin wartete meist gar nicht darauf.
  ///
  /// Weiter geworfen wird trotzdem, damit Kotlin seine Fehlerantwort behält.
  /// Nicht gemeldet: `MissingPluginException` (= „kenne ich nicht“) und eine
  /// `PlatformException`, die der Handler selbst als Antwort wirft.
  static Future<dynamic> Function(MethodCall) kanal(
    String name,
    Future<dynamic> Function(MethodCall) handler,
  ) =>
      (MethodCall ruf) async {
        try {
          return await handler(ruf);
        } on MissingPluginException {
          rethrow;
        } on PlatformException {
          rethrow;
        } catch (e, s) {
          try {
            melden(e, s, quelle: 'Kanal $name · ${ruf.method}');
          } catch (_) {
            // Nie aus dem Handler heraus werfen — außer dem Fehler selbst.
          }
          rethrow;
        }
      };

  @visibleForTesting
  static void zuruecksetzen() {
    _engine = '?';
    _eingerichtet = false;
    _gesehen.clear();
    _minute = -1;
    _inDieserMinute = 0;
    uhr = DateTime.now;
  }
}
