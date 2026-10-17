import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:icd360sev_mitglied/utils/ordner_ablage.dart';
import 'package:icd360sev_mitglied/utils/pdf_bilder.dart';

/// „PDF in Bilder" ohne Gerät und ohne pdfium: Namen, Größen, Farben und die
/// Schleife über die Seiten. Die Seiten kommen hier aus [_seite] statt aus
/// einem PDF — genau in der Form, in der pdfrx sie liefert (BGRA).

/// Eine einfarbige Seite in BGRA, wie pdfrx sie liefert.
SeitenPixel _seite(int r, int g, int b, {int breite = 4, int hoehe = 6}) {
  final px = Uint8List(breite * hoehe * 4);
  for (var i = 0; i < px.length; i += 4) {
    px[i] = b;
    px[i + 1] = g;
    px[i + 2] = r;
    px[i + 3] = 255;
  }
  return (bgra: px, breite: breite, hoehe: hoehe);
}

/// Die Farbe in der Mitte eines fertigen Bildes.
({int r, int g, int b}) _mitte(Uint8List datei) {
  final bild = img.decodeImage(datei)!;
  final p = bild.getPixel(bild.width ~/ 2, bild.height ~/ 2);
  return (r: p.r.toInt(), g: p.g.toInt(), b: p.b.toInt());
}

void main() {
  group('bildDateiname', () {
    test('5 Seiten werden _1 bis _5', () {
      expect(bildDateiname('Mietvertrag', 1, 5, BildFormat.jpg), 'Mietvertrag_1.jpg');
      expect(bildDateiname('Mietvertrag', 5, 5, BildFormat.jpg), 'Mietvertrag_5.jpg');
    });

    test('ab 10 Seiten mit führenden Nullen — sonst sortiert _10 vor _2', () {
      expect(bildDateiname('a', 1, 12, BildFormat.png), 'a_01.png');
      expect(bildDateiname('a', 12, 12, BildFormat.png), 'a_12.png');
      expect(bildDateiname('a', 7, 120, BildFormat.png), 'a_007.png');
      final namen = [for (var s = 1; s <= 12; s++) bildDateiname('a', s, 12, BildFormat.png)];
      expect([...namen]..sort(), namen);
    });

    test('jedes Format hat seine Endung', () {
      expect(bildDateiname('a', 1, 1, BildFormat.jpg), 'a_1.jpg');
      expect(bildDateiname('a', 1, 1, BildFormat.jpeg), 'a_1.jpeg');
      expect(bildDateiname('a', 1, 1, BildFormat.png), 'a_1.png');
    });
  });

  group('bildBasis', () {
    test('Pfad und .pdf fallen weg, gleich wie geschrieben', () {
      expect(bildBasis('/storage/emulated/0/Download/Mietvertrag.pdf'), 'Mietvertrag');
      expect(bildBasis('/tmp/Bescheid.PDF'), 'Bescheid');
      expect(bildBasis(r'C:\Users\x\Kündigung März.pdf'), 'Kündigung März');
      expect(bildBasis('/tmp/ohne_endung'), 'ohne_endung');
    });

    test('was ein Dateisystem verbietet, wird zu _', () {
      expect(bildBasis('/tmp/Rechnung:09?.pdf'), 'Rechnung_09_');
    });
  });

  group('seitenPixel', () {
    test('A4 bei 200 dpi: 1654 × 2339', () {
      final m = seitenPixel(595.28, 841.89);
      expect(m.breite, 1654);
      expect(m.hoehe, 2339);
    });

    test('ein Plakat wird verkleinert, das Seitenverhältnis bleibt', () {
      // A0: 2384 × 3370 pt — bei 200 dpi wären es 6622 × 9361 Pixel.
      final m = seitenPixel(2384, 3370);
      expect(m.hoehe, pdfBilderMaxKante);
      expect(m.breite / m.hoehe, closeTo(2384 / 3370, 0.001));
    });
  });

  group('bildKodierenSofort', () {
    // ⚠️ Der Grund für diese Gruppe: pdfium liefert BGRA. Wer RGBA liest,
    // macht aus Rot Blau — auf einer schwarz-weißen Seite sähe man es nie.
    for (final format in BildFormat.values) {
      test('${format.anzeige}: Rot bleibt Rot, Blau bleibt Blau', () {
        final rot = _mitte(bildKodierenSofort(_seite(255, 0, 0), format));
        expect(rot.r, greaterThan(200));
        expect(rot.b, lessThan(60));

        final blau = _mitte(bildKodierenSofort(_seite(0, 0, 255), format));
        expect(blau.b, greaterThan(200));
        expect(blau.r, lessThan(60));
      });
    }

    test('JPG und JPEG sind Byte für Byte dasselbe Bild', () {
      final s = _seite(10, 120, 200);
      expect(bildKodierenSofort(s, BildFormat.jpg),
          bildKodierenSofort(s, BildFormat.jpeg));
    });

    test('PNG trägt keinen Alphakanal und die Farbe genau', () {
      final bild = img.decodePng(bildKodierenSofort(_seite(12, 34, 56), BildFormat.png))!;
      expect(bild.numChannels, 3);
      final p = bild.getPixel(0, 0);
      expect([p.r, p.g, p.b], [12, 34, 56]);
    });

    test('JPG ist ein JPG, PNG ein PNG', () {
      final jpg = bildKodierenSofort(_seite(1, 2, 3), BildFormat.jpg);
      final png = bildKodierenSofort(_seite(1, 2, 3), BildFormat.png);
      expect(jpg.sublist(0, 3), [0xFF, 0xD8, 0xFF]);
      expect(png.sublist(0, 4), [0x89, 0x50, 0x4E, 0x47]);
    });
  });

  group('seitenAblegen', () {
    late Directory ordner;

    setUp(() => ordner = Directory.systemTemp.createTempSync('pdf_bilder_'));
    tearDown(() => ordner.deleteSync(recursive: true));

    List<String> namen() =>
        (ordner.listSync().map((e) => e.path.split(Platform.pathSeparator).last).toList()
          ..sort());

    final farben = [(255, 0, 0), (0, 255, 0), (0, 0, 255)];
    Future<SeitenPixel> rendern(int i) async =>
        _seite(farben[i].$1, farben[i].$2, farben[i].$3);

    test('3 Seiten → 3 Bilder, jede Seite in ihrer Datei', () async {
      final seiten = <int>[];
      final e = await seitenAblegen(
        gesamt: 3,
        rendern: rendern,
        ziel: PfadOrdner(ordner),
        basis: 'Vertrag',
        format: BildFormat.png,
        fortschritt: seiten.add,
      );
      expect(e.geschrieben, 3);
      expect(e.angehalten, isFalse);
      expect(seiten, [1, 2, 3]);
      expect(namen(), ['Vertrag_1.png', 'Vertrag_2.png', 'Vertrag_3.png']);

      final dritte = _mitte(File('${ordner.path}/Vertrag_3.png').readAsBytesSync());
      expect(dritte.b, greaterThan(200), reason: 'Seite 3 ist blau');
      final erste = _mitte(File('${ordner.path}/Vertrag_1.png').readAsBytesSync());
      expect(erste.r, greaterThan(200), reason: 'Seite 1 ist rot');
    });

    test('nichts wird überschrieben — vorhandene Dateien bleiben, wie sie sind', () async {
      File('${ordner.path}/Vertrag_1.jpg').writeAsStringSync('alt');
      await seitenAblegen(
        gesamt: 1,
        rendern: rendern,
        ziel: PfadOrdner(ordner),
        basis: 'Vertrag',
        format: BildFormat.jpg,
      );
      expect(namen(), ['Vertrag_1(1).jpg', 'Vertrag_1.jpg']);
      expect(File('${ordner.path}/Vertrag_1.jpg').readAsStringSync(), 'alt');
    });

    test('Anhalten: was schon im Ordner liegt, bleibt dort', () async {
      var aufgerufen = 0;
      final e = await seitenAblegen(
        gesamt: 3,
        rendern: rendern,
        ziel: PfadOrdner(ordner),
        basis: 'v',
        format: BildFormat.jpeg,
        // Vor Seite 1 und 2 weiter, vor Seite 3 halt.
        angehalten: () => ++aufgerufen > 2,
      );
      expect(e.geschrieben, 2);
      expect(e.angehalten, isTrue);
      expect(namen(), ['v_1.jpeg', 'v_2.jpeg']);
    });

    test('ein Fehler mittendrin geht nach oben, die Seiten davor bleiben', () async {
      await expectLater(
        seitenAblegen(
          gesamt: 3,
          rendern: (i) async =>
              i == 1 ? throw StateError('kaputt') : rendern(i),
          ziel: PfadOrdner(ordner),
          basis: 'v',
          format: BildFormat.png,
        ),
        throwsStateError,
      );
      expect(namen(), ['v_1.png']);
    });

    test('kein .teil bleibt zurück', () async {
      await seitenAblegen(
        gesamt: 3,
        rendern: rendern,
        ziel: PfadOrdner(ordner),
        basis: 'v',
        format: BildFormat.jpg,
      );
      expect(namen().where((n) => n.endsWith('.teil')), isEmpty);
    });
  });
}
