import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/foto_quelle.dart';
import 'package:icd360sev_mitglied/utils/ordner_ablage.dart';

/// Woher „Foto bearbeiten" die Fotos holt und wohin Kopie und Löschen gehen.
/// Am Rechner echte Dateien in einem Temp-Ordner; auf Android und dem iPhone
/// wird der Kanal beantwortet, wie `OrdnerAblage.kt`, `FotoQuelle.kt` und
/// `AppDelegate.swift` ihn beantworten — nichts davon erreicht ein Gerät.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final bote =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  group('Rechner: Ordner', () {
    late Directory ordner;

    setUp(() => ordner = Directory.systemTemp.createTempSync('foto_quelle_'));
    tearDown(() => ordner.deleteSync(recursive: true));

    File datei(String name, List<int> bytes, DateTime geaendert) =>
        File('${ordner.path}/$name')
          ..writeAsBytesSync(bytes)
          ..setLastModifiedSync(geaendert);

    test('nur Fotos, keine versteckten, keine Unterordner — neueste zuerst',
        () async {
      datei('alt.jpg', [1], DateTime(2026, 1, 1));
      datei('neu.png', [2], DateTime(2026, 10, 17));
      datei('mitte.HEIC', [3], DateTime(2026, 5, 5));
      datei('notiz.txt', [4], DateTime(2026, 10, 18));
      datei('.versteckt.jpg', [5], DateTime(2026, 10, 18));
      Directory('${ordner.path}/unter').createSync();
      File('${ordner.path}/unter/drin.jpg').writeAsBytesSync([6]);

      final liste = await RechnerFotoOrdner(ordner).auflisten();
      expect(liste.map((e) => e.name), ['neu.png', 'mitte.HEIC', 'alt.jpg']);
      expect(liste.first.pfad, '${ordner.path}/neu.png');
      expect(liste.first.groesse, 1);
    });

    test('liest die Bytes', () async {
      datei('a.jpg', [7, 8, 9], DateTime(2026));
      final q = RechnerFotoOrdner(ordner);
      final e = (await q.auflisten()).single;
      expect(await q.lesen(e), [7, 8, 9]);
    });

    test(
        'HEIC an Windows und Linux: eine klare Meldung statt eines schwarzen Bilds',
        () async {
      datei('iphone.heic', [1, 2], DateTime(2026));
      final q = RechnerFotoOrdner(ordner);
      final e = (await q.auflisten()).single;
      if (Platform.isMacOS) return; // dort wandelt ImageIO um
      await expectLater(q.lesen(e), throwsA(isA<HeicNichtMoeglich>()));
    });

    test('die Kopie kommt daneben und überschreibt nie', () async {
      datei('a.jpg', [1], DateTime(2026));
      final q = RechnerFotoOrdner(ordner);
      final e = (await q.auflisten()).single;
      final erste = await q.kopieSpeichern(e,
          dateiname: 'a_bearbeitet.jpg',
          bytes: Uint8List.fromList([2]),
          mime: 'image/jpeg');
      final zweite = await q.kopieSpeichern(e,
          dateiname: 'a_bearbeitet.jpg',
          bytes: Uint8List.fromList([3]),
          mime: 'image/jpeg');
      expect([erste, zweite], ['a_bearbeitet.jpg', 'a_bearbeitet(1).jpg']);
      expect(File('${ordner.path}/a.jpg').readAsBytesSync(), [1],
          reason: 'das Original bleibt, wie es war');
    });

    test('das Original löschen — und ein zweites Mal ehrlich „nicht gelöscht"',
        () async {
      datei('a.jpg', [1], DateTime(2026));
      final q = RechnerFotoOrdner(ordner);
      final e = (await q.auflisten()).single;
      expect(await q.originalLoeschen(e), isTrue);
      expect(File('${ordner.path}/a.jpg').existsSync(), isFalse);
      expect(await q.originalLoeschen(e), isFalse);
    });
  });

  test('gleich alt: nach Namen, damit die Reihenfolge fest ist', () {
    final t = DateTime(2026);
    final liste = sortieren([
      FotoEintrag(schluessel: '2', name: 'b.jpg', geaendert: t),
      FotoEintrag(schluessel: '1', name: 'A.jpg', geaendert: t),
      const FotoEintrag(schluessel: '3', name: 'c.jpg'),
    ]);
    expect(liste.map((e) => e.name), ['A.jpg', 'b.jpg', 'c.jpg']);
  });

  group('Telefon: Ordner über den Kanal', () {
    final aufrufe = <MethodCall>[];
    late Future<Object?> Function(MethodCall) antwort;

    setUp(() {
      aufrufe.clear();
      bote.setMockMethodCallHandler(KanalOrdner.kanal, (call) async {
        aufrufe.add(call);
        return antwort(call);
      });
    });
    tearDown(() => bote.setMockMethodCallHandler(KanalOrdner.kanal, null));

    Future<KanalFotoOrdner> oeffnen() async {
      antwort =
          (call) async => {'ordner': 'content://baum/Camera', 'name': 'Camera'};
      return KanalFotoOrdner((await KanalOrdner.waehlen())!);
    }

    test('auflisten: Schlüssel, Name, Größe, Datum — neueste zuerst', () async {
      final q = await oeffnen();
      antwort = (call) async => [
            {
              'schluessel': 'content://doc/1',
              'name': 'IMG_1.jpg',
              'groesse': 10,
              'geaendert': 1000
            },
            {
              'schluessel': 'content://doc/2',
              'name': 'IMG_2.jpg',
              'groesse': null,
              'geaendert': 2000
            },
          ];
      final liste = await q.auflisten();
      expect(aufrufe.last.method, 'auflisten');
      expect(aufrufe.last.arguments, {'ordner': 'content://baum/Camera'});
      expect(liste.map((e) => e.schluessel),
          ['content://doc/2', 'content://doc/1']);
      expect(liste.last.groesse, 10);
      expect(liste.first.pfad, isNull,
          reason: 'die Vorschau kommt über den Kanal');
      expect(q.name, 'Camera');
      expect(q.istOrdner, isTrue);
    });

    test('lesen, Vorschau und löschen nennen Ordner und Datei', () async {
      final q = await oeffnen();
      const e = FotoEintrag(schluessel: 'content://doc/1', name: 'IMG_1.jpg');

      antwort = (call) async => Uint8List.fromList([1, 2]);
      expect(await q.lesen(e), [1, 2]);
      expect(aufrufe.last.arguments,
          {'ordner': 'content://baum/Camera', 'datei': 'content://doc/1'});

      expect(await q.vorschau(e, 300), [1, 2]);
      expect((aufrufe.last.arguments as Map)['kante'], 300);

      antwort = (call) async => true;
      expect(await q.originalLoeschen(e), isTrue);
      expect(aufrufe.last.method, 'loeschen');
      expect(aufrufe.last.arguments,
          {'ordner': 'content://baum/Camera', 'datei': 'content://doc/1'});
    });

    test('keine Vorschau ist kein Fehler', () async {
      final q = await oeffnen();
      antwort = (call) async => throw PlatformException(code: 'vorschau');
      expect(
          await q.vorschau(
              const FotoEintrag(schluessel: 'x', name: 'x.jpg'), 100),
          isNull);
    });

    test('die Kopie geht über „schreiben" in denselben Ordner', () async {
      final q = await oeffnen();
      antwort = (call) async => 'IMG_1_editat(1).jpg';
      final name = await q.kopieSpeichern(
        const FotoEintrag(schluessel: 'content://doc/1', name: 'IMG_1.jpg'),
        dateiname: 'IMG_1_editat.jpg',
        bytes: Uint8List.fromList([9]),
        mime: 'image/jpeg',
      );
      expect(name, 'IMG_1_editat(1).jpg');
      expect(aufrufe.last.method, 'schreiben');
      expect(
          (aufrufe.last.arguments as Map)['ordner'], 'content://baum/Camera');
    });
  });

  group('Telefon: einzelnes Foto', () {
    final aufrufe = <MethodCall>[];
    late Future<Object?> Function(MethodCall) antwort;

    setUp(() {
      aufrufe.clear();
      bote.setMockMethodCallHandler(KanalEinzelFoto.kanal, (call) async {
        aufrufe.add(call);
        return antwort(call);
      });
    });
    tearDown(() {
      bote.setMockMethodCallHandler(KanalEinzelFoto.kanal, null);
      KanalEinzelFoto.loeschenWartezeit = const Duration(minutes: 2);
    });

    test('abgebrochen: null', () async {
      antwort = (call) async => null;
      expect(await KanalEinzelFoto.waehlen(), isNull);
    });

    test('Android: liest einmal über den Kanal und merkt sich die Bytes',
        () async {
      antwort = (call) async => {
            'schluessel': 'content://media/doc/9',
            'name': '20261017_142305.jpg',
            'groesse': 3201478,
            'fotosApp': false,
          };
      final (q, e) = (await KanalEinzelFoto.waehlen())!;
      expect(e.name, '20261017_142305.jpg');
      expect(e.groesse, 3201478);
      expect(q.inFotosApp, isFalse);
      expect(q.istOrdner, isFalse);

      antwort = (call) async => Uint8List.fromList([5]);
      expect(await q.lesen(e), [5]);
      expect(await q.lesen(e), [5]);
      expect(aufrufe.where((c) => c.method == 'lesen'), hasLength(1));
      expect(aufrufe.last.arguments, {'datei': 'content://media/doc/9'});
    });

    test(
        'iPhone: die Bytes kommen mit der Auswahl, die Kopie geht nach „Fotos"',
        () async {
      antwort = (call) async => {
            'schluessel': 'ABC-123/L0/001',
            'name': 'IMG_0042.jpg',
            'bytes': Uint8List.fromList([1, 2, 3]),
            'fotosApp': true,
          };
      final (q, e) = (await KanalEinzelFoto.waehlen())!;
      expect(q.inFotosApp, isTrue);
      expect(await q.lesen(e), [1, 2, 3]);
      expect(aufrufe.where((c) => c.method == 'lesen'), isEmpty);

      antwort = (call) async => true;
      final name = await q.kopieSpeichern(e,
          dateiname: 'IMG_0042_edited.jpg',
          bytes: Uint8List.fromList([4]),
          mime: 'image/jpeg');
      expect(name, 'IMG_0042_edited.jpg');
      expect(aufrufe.last.method, 'inFotosSpeichern');
      expect((aufrufe.last.arguments as Map)['bytes'], [4]);
    });

    test('löschen: Antwort des Systems; ohne Antwort nicht ewig warten',
        () async {
      antwort = (call) async =>
          {'schluessel': 'k', 'name': 'a.jpg', 'fotosApp': true};
      final (q, e) = (await KanalEinzelFoto.waehlen())!;

      antwort = (call) async => true;
      expect(await q.originalLoeschen(e), isTrue);
      expect(aufrufe.last.arguments, {'datei': 'k'});

      // iOS 26: die eigene Rückfrage kam bei manchen nie.
      KanalEinzelFoto.loeschenWartezeit = const Duration(milliseconds: 50);
      antwort = (call) => Completer<Object?>().future;
      expect(await q.originalLoeschen(e), isFalse);
    });
  });
}
