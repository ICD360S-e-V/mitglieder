// Haelt den Vordergrunddienst fuer laufende Anrufe zusammen.
//
// Ohne ihn endet ein Anruf, sobald die App aus dem Blick geraet: seit Android
// 12 darf eine App im Hintergrund weder Mikrofon noch Kamera halten, und seit
// Android 14 verlangt jeder Vordergrunddienst einen TYP samt passender
// Berechtigung. Das laesst sich hier nur am Quelltext und am Manifest pruefen —
// ein echter Hintergrundwechsel braucht ein Geraet.
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

String ohneKommentare(String q) => q
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i);
    })
    .join('\n');

/// Schneidet ab dem Kopf bis zur ausgeglichenen schliessenden Klammer.
/// Erst runde Klammern des Kopfes ausgleichen, dann geschweifte — sonst
/// beginnt der Schnitt in einer Parameterliste.
String rumpf(String quelle, String kopf) {
  final start = quelle.indexOf(kopf);
  expect(start, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  var i = start, rund = 0;
  while (i < quelle.length) {
    final c = quelle[i];
    if (c == '(') rund++;
    if (c == ')') rund--;
    if (c == '{' && rund == 0) break;
    i++;
  }
  expect(i, lessThan(quelle.length), reason: 'kein Rumpfanfang: $kopf');
  var tiefe = 0;
  final ab = i;
  while (i < quelle.length) {
    if (quelle[i] == '{') tiefe++;
    if (quelle[i] == '}') {
      tiefe--;
      if (tiefe == 0) return quelle.substring(ab, i + 1);
    }
    i++;
  }
  fail('Rumpf nicht geschlossen: $kopf');
}

void main() {
  late String kt;
  late String manifest;
  late String dart;
  late String dienst;

  setUpAll(() {
    kt = ohneKommentare(File('android/app/src/main/kotlin/de/icd360s/mitglieder/AnrufDienst.kt')
        .readAsStringSync());
    manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    dart = ohneKommentare(
        File('lib/services/anruf_vordergrund.dart').readAsStringSync());
    dienst = ohneKommentare(
        File('lib/services/voice_call_service.dart').readAsStringSync());
  });

  group('Vordergrunddienst fuer laufende Anrufe', () {
    test('Manifest erlaubt beide Typen und hat beide Berechtigungen', () {
      expect(manifest, contains('android:name=".AnrufDienst"'));
      expect(manifest, contains('android:foregroundServiceType="microphone|camera"'));
      expect(manifest,
          contains('android.permission.FOREGROUND_SERVICE_MICROPHONE'));
      expect(manifest, contains('android.permission.FOREGROUND_SERVICE_CAMERA'),
          reason: 'ohne sie weist Android 14+ den Dienst eines Videoanrufs ab');
      // Die Typen sind nichts ohne die Rechte an Mikrofon und Kamera selbst.
      expect(manifest, contains('android.permission.RECORD_AUDIO'));
      expect(manifest, contains('android.permission.CAMERA'));
    });

    test('der Typ `camera` wird NUR bei einem Videoanruf angemeldet', () {
      // ⚠️ Die wichtigste Zusicherung hier. Wird `camera` fest angemeldet,
      // verlangt Android 14+ die Berechtigung CAMERA — bei einem reinen
      // Sprachanruf vielleicht nie erteilt. `startForeground()` bricht dann mit
      // einer SecurityException ab, und der Anruf ist schlechter dran als ohne
      // diesen Dienst.
      final start = rumpf(kt, 'override fun onStartCommand(');
      expect(start, contains('FOREGROUND_SERVICE_TYPE_MICROPHONE'));
      final camZeile = start
          .split('\n')
          .where((z) => z.contains('FOREGROUND_SERVICE_TYPE_CAMERA'))
          .toList();
      expect(camZeile, hasLength(1),
          reason: 'genau eine Stelle darf den Kamera-Typ anmelden');
      expect(camZeile.single, contains('if (video)'),
          reason: 'der Kamera-Typ muss an `video` haengen, nicht fest dastehen');
    });

    test('ein verweigerter Dienst kippt den Anruf nicht', () {
      final start = rumpf(kt, 'override fun onStartCommand(');
      expect(start, contains('catch'),
          reason: 'startForeground darf nicht ungefangen werfen');
      expect(start, contains('stopSelf()'));
      // START_NOT_STICKY: eine weggewischte App hat keine Gegenstelle mehr.
      expect(start, contains('START_NOT_STICKY'));
      expect(kt.contains('START_STICKY'), isFalse);
    });

    test('die Benachrichtigung fuehrt in die App zurueck und stoert nicht', () {
      expect(kt, contains('setContentIntent'));
      expect(kt, contains('setOngoing(true)'));
      expect(kt, contains('IMPORTANCE_LOW'),
          reason: 'sie darf waehrend eines Gespraechs nicht klingeln');
    });

    test('die Dart-Seite ist nur auf Android aktiv und wirft nie', () {
      final s = rumpf(dart, 'static Future<void> starten(');
      expect(s, contains('Platform.isAndroid'),
          reason: 'auf Linux/macOS/Windows gibt es den Kanal nicht');
      expect(s, contains('catch'),
          reason: 'ein Anruf darf an dieser Verbesserung nicht scheitern');
      final b = rumpf(dart, 'static Future<void> beenden(');
      expect(b, contains('Platform.isAndroid'));
      expect(b, contains('catch'));
    });

    test('der Dienst wird gestartet, sobald Mikrofon/Kamera offen sind', () {
      // Zweimal: beim eigenen Anruf und beim Annehmen. Fehlt einer, ueberlebt
      // genau die eine Richtung den Hintergrundwechsel nicht.
      final n = 'AnrufVordergrund.starten('.allMatches(dienst).length;
      expect(n, 2,
          reason: 'startCall() UND acceptCall() muessen ihn starten (gefunden: $n)');
      expect(dienst, contains('video: _isVideoCall'),
          reason: 'der Typ muss dem tatsaechlichen Anruf folgen');
    });

    test('und in _cleanup() beendet — auf JEDEM Weg', () {
      final c = rumpf(dienst, 'void _cleanup()');
      expect(c, contains('AnrufVordergrund.beenden()'),
          reason: 'sonst bleibt eine Benachrichtigung ueber ein Gespraech '
              'stehen, das es nicht mehr gibt');
    });
  });
}
