import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/ordner_ablage.dart';

/// Der gewählte Ordner für „PDF in Bilder": auf dem Rechner ein Pfad, auf
/// Android und dem iPhone die native Seite hinter einem Kanal. Der Kanal wird
/// hier beantwortet, wie `OrdnerAblage.kt` und `AppDelegate.swift` ihn
/// beantworten — nichts davon erreicht ein Gerät.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PfadOrdner', () {
    late Directory ordner;

    setUp(() => ordner = Directory.systemTemp.createTempSync('ordner_ablage_'));
    tearDown(() => ordner.deleteSync(recursive: true));

    test('der Name ist der letzte Teil des Pfads', () {
      expect(PfadOrdner(Directory('/home/a/Bilder')).name, 'Bilder');
      expect(PfadOrdner(Directory('/home/a/Bilder/')).name, 'Bilder');
    });

    test('schreibt unter dem gewünschten Namen, ist er frei', () async {
      final o = PfadOrdner(ordner);
      final name = await o.schreiben('a_1.png', Uint8List.fromList([1, 2, 3]),
          mime: 'image/png');
      expect(name, 'a_1.png');
      expect(File('${ordner.path}/a_1.png').readAsBytesSync(), [1, 2, 3]);
    });

    test('nie überschreiben: der zweite bekommt (1)', () async {
      final o = PfadOrdner(ordner);
      await o.schreiben('a.jpg', Uint8List.fromList([1]), mime: 'image/jpeg');
      final zweiter =
          await o.schreiben('a.jpg', Uint8List.fromList([2]), mime: 'image/jpeg');
      expect(zweiter, 'a(1).jpg');
      expect(File('${ordner.path}/a.jpg').readAsBytesSync(), [1]);
    });

    test('ein Name wird nie zum Pfad', () async {
      final name = await PfadOrdner(ordner)
          .schreiben('../weg.png', Uint8List(1), mime: 'image/png');
      expect(name, '_weg.png');
      expect(File('${ordner.path}/_weg.png').existsSync(), isTrue);
    });
  });

  group('KanalOrdner (Android, iPhone)', () {
    final aufrufe = <MethodCall>[];
    Object? Function(MethodCall)? antwort;

    setUp(() {
      aufrufe.clear();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(KanalOrdner.kanal, (call) async {
        aufrufe.add(call);
        return antwort?.call(call);
      });
    });

    tearDown(() {
      antwort = null;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(KanalOrdner.kanal, null);
    });

    test('abgebrochen → null', () async {
      antwort = (_) => null;
      expect(await KanalOrdner.waehlen(), isNull);
      expect(aufrufe.single.method, 'waehlen');
    });

    test('gewählt → Name für die Meldung, Schreiben geht an DIESEN Ordner',
        () async {
      antwort = (call) => switch (call.method) {
            'waehlen' => {'ordner': 'content://baum/Poze', 'name': 'Poze'},
            'schreiben' => 'Vertrag_1 (1).jpg',
            _ => null,
          };
      final o = (await KanalOrdner.waehlen())!;
      expect(o.name, 'Poze');

      final name = await o.schreiben(
          'Vertrag_1.jpg', Uint8List.fromList([7, 8]),
          mime: 'image/jpeg');
      // Was die native Seite meldet, gilt — dort vergibt der Anbieter die
      // Nummer bei gleichem Namen.
      expect(name, 'Vertrag_1 (1).jpg');

      final s = aufrufe.last;
      expect(s.method, 'schreiben');
      expect(s.arguments['ordner'], 'content://baum/Poze');
      expect(s.arguments['name'], 'Vertrag_1.jpg');
      expect(s.arguments['mime'], 'image/jpeg');
      expect(s.arguments['bytes'], [7, 8]);
    });

    test('auch zur nativen Seite geht nie ein Pfad als Name', () async {
      antwort = (call) => switch (call.method) {
            'waehlen' => {'ordner': 'x', 'name': ''},
            _ => 'egal',
          };
      final o = (await KanalOrdner.waehlen())!;
      await o.schreiben('../../a.png', Uint8List(1), mime: 'image/png');
      expect(aufrufe.last.arguments['name'], '_.._a.png');
    });

    test('ein Fehler beim Schreiben geht nach oben', () async {
      antwort = (call) => switch (call.method) {
            'waehlen' => {'ordner': 'x', 'name': 'y'},
            _ => throw PlatformException(code: 'schreiben'),
          };
      final o = (await KanalOrdner.waehlen())!;
      await expectLater(
        o.schreiben('a.png', Uint8List(1), mime: 'image/png'),
        throwsA(isA<PlatformException>()
            .having((e) => e.code, 'code', 'schreiben')),
      );
    });

    test('Freigeben scheitert nie laut — die Bilder sind ja da', () async {
      antwort = (call) => switch (call.method) {
            'waehlen' => {'ordner': 'x', 'name': 'y'},
            _ => throw PlatformException(code: 'weg'),
          };
      final o = (await KanalOrdner.waehlen())!;
      await o.schliessen();
      expect(aufrufe.last.method, 'schliessen');
      expect(aufrufe.last.arguments['ordner'], 'x');
    });
  });
}
