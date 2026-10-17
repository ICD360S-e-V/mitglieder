import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/foto_bearbeiten.dart';
import 'package:image/image.dart' as img;

/// „Foto bearbeiten" ohne Oberfläche: Größe, Format, Name der Kopie und die
/// Pixel selbst. Was hier falsch wäre, sähe das Mitglied erst in der Kopie —
/// gedreht, vertauschte Farben, schwarzer Rand, der Aufnahmeort in den
/// Metadaten.
void main() {
  group('zielMasse', () {
    test('Prozent: halbe Kantenlänge', () {
      expect(zielMasse(4000, 3000, const FotoGroesse(prozent: 50)),
          (breite: 2000, hoehe: 1500));
    });

    test('Prozent: nie größer als das Bild, nie kleiner als 1', () {
      expect(zielMasse(400, 300, const FotoGroesse(prozent: 150)),
          (breite: 400, hoehe: 300));
      expect(zielMasse(400, 3, const FotoGroesse(prozent: 1)),
          (breite: 4, hoehe: 1));
    });

    test('Pixel: die Höhe folgt dem Seitenverhältnis', () {
      expect(
          zielMasse(
              4000, 3000, const FotoGroesse(inProzent: false, breite: 1000)),
          (breite: 1000, hoehe: 750));
    });

    test('Pixel: breiter als das Bild geht nicht', () {
      expect(
          zielMasse(
              400, 300, const FotoGroesse(inProzent: false, breite: 9000)),
          (breite: 400, hoehe: 300));
    });

    test('nichts eingestellt heißt unverändert', () {
      expect(const FotoGroesse().unveraendert, isTrue);
      expect(const FotoGroesse(prozent: 50).unveraendert, isFalse);
      expect(const FotoGroesse(format: FotoFormat.png).unveraendert, isFalse);
      expect(const FotoGroesse(inProzent: false, breite: 10).unveraendert,
          isFalse);
    });
  });

  group('Namen und Format', () {
    test('ein PNG bleibt PNG, alles andere wird JPG', () {
      expect(FotoFormat.wieOriginal('a.PNG'), FotoFormat.png);
      for (final n in ['a.jpg', 'a.jpeg', 'a.heic', 'a.webp', 'a.bmp', 'a']) {
        expect(FotoFormat.wieOriginal(n), FotoFormat.jpg, reason: n);
      }
    });

    test('die Kopie heißt wie das Original, mit Zusatz', () {
      expect(kopieName('Urlaub.jpg', 'bearbeitet', FotoFormat.jpg),
          'Urlaub_bearbeitet.jpg');
      expect(kopieName('IMG_20261017_142305.jpg', 'editat', FotoFormat.jpg),
          'IMG_20261017_142305_editat.jpg');
    });

    test('die Endung folgt dem Format der Kopie', () {
      expect(
          kopieName('Foto.heic', 'edited', FotoFormat.jpg), 'Foto_edited.jpg');
      expect(
          kopieName('Scan.jpg', 'edited', FotoFormat.png), 'Scan_edited.png');
      expect(kopieName('ohne', 'edited', FotoFormat.jpg), 'ohne_edited.jpg');
    });

    test('ein Name wird nie zum Pfad', () {
      expect(kopieName('../a/b.jpg', 'x', FotoFormat.jpg), '_a_b_x.jpg');
    });

    test('welche Dateien Fotos sind', () {
      for (final n in [
        'a.jpg',
        'B.JPEG',
        'c.png',
        'd.webp',
        'e.heic',
        'f.HEIF',
        'g.bmp',
        'h.gif'
      ]) {
        expect(istFotoName(n), isTrue, reason: n);
      }
      for (final n in ['a.pdf', 'b.txt', 'jpg', 'c.jpg.teil']) {
        expect(istFotoName(n), isFalse, reason: n);
      }
      expect(istHeicName('x.HEIC'), isTrue);
      expect(istHeicName('x.jpg'), isFalse);
    });

    test('Größe wie bei Chat-Anhängen', () {
      expect(groesseText(512), '512 B');
      expect(groesseText(1536), '1.5 KB');
      // Das 12-Megapixel-Foto aus der Messung für die Skizze.
      expect(groesseText(3201478), '3.1 MB');
      expect(groesseText(1156244), '1.1 MB');
    });
  });

  group('fotoKodierenSofort', () {
    Uint8List rotBlauPng() {
      final bild = img.Image(width: 16, height: 8);
      for (var y = 0; y < 8; y++) {
        for (var x = 0; x < 16; x++) {
          bild.setPixelRgb(x, y, x < 8 ? 255 : 0, 0, x < 8 ? 0 : 255);
        }
      }
      return img.encodePng(bild);
    }

    test('Rot bleibt rot, Blau bleibt blau — JPG', () {
      final aus = fotoKodierenSofort(
          rotBlauPng(), const FotoGroesse(qualitaet: 100), FotoFormat.jpg);
      final bild = img.decodeJpg(aus.bytes)!;
      final links = bild.getPixel(3, 4);
      final rechts = bild.getPixel(12, 4);
      expect(links.r, greaterThan(200));
      expect(links.b, lessThan(60));
      expect(rechts.b, greaterThan(200));
      expect(rechts.r, lessThan(60));
    });

    test('Rot bleibt rot, Blau bleibt blau — PNG, Pixel für Pixel', () {
      final aus =
          fotoKodierenSofort(rotBlauPng(), const FotoGroesse(), FotoFormat.png);
      final bild = img.decodePng(aus.bytes)!;
      expect([bild.getPixel(0, 0).r, bild.getPixel(0, 0).b], [255, 0]);
      expect([bild.getPixel(15, 7).r, bild.getPixel(15, 7).b], [0, 255]);
    });

    test('verkleinert auf die eingestellte Größe', () {
      final quelle = img.encodePng(img.Image(width: 400, height: 300));
      final halb = fotoKodierenSofort(
          quelle, const FotoGroesse(prozent: 50), FotoFormat.jpg);
      expect((halb.breite, halb.hoehe), (200, 150));
      expect(img.decodeJpg(halb.bytes)!.width, 200);

      final pixel = fotoKodierenSofort(quelle,
          const FotoGroesse(inProzent: false, breite: 100), FotoFormat.png);
      expect((pixel.breite, pixel.hoehe), (100, 75));
    });

    test('ein hochkant fotografiertes JPG kommt aufrecht heraus', () {
      // Wie vom Telefon: quer gespeichert, aufrecht nur über EXIF (6 = 90°).
      final quer = img.Image(width: 40, height: 20);
      quer.exif.imageIfd.orientation = 6;
      final jpg = img.encodeJpg(quer);

      expect(fotoMasse(jpg), (breite: 20, hoehe: 40));
      final aus = fotoKodierenSofort(jpg, const FotoGroesse(), FotoFormat.jpg);
      expect((aus.breite, aus.hoehe), (20, 40));
      // Und die Kopie trägt keine Drehung mehr, die ein Betrachter noch
      // einmal anwenden würde.
      expect(img.decodeJpgExif(aus.bytes)?.imageIfd.orientation, isNull);
    });

    test('keine Metadaten in der Kopie — kein Aufnahmeort, kein Gerät', () {
      final quelle = img.Image(width: 8, height: 8);
      quelle.exif.imageIfd['Make'] = img.IfdValueAscii('Testkamera');
      quelle.exif.gpsIfd['GPSLatitudeRef'] = img.IfdValueAscii('N');
      final jpg = img.encodeJpg(quelle);
      expect(_enthaelt(jpg, 'Testkamera'), isTrue,
          reason: 'sonst prüft der Test nichts');

      final aus = fotoKodierenSofort(jpg, const FotoGroesse(), FotoFormat.jpg);
      expect(_enthaelt(aus.bytes, 'Testkamera'), isFalse);
      expect(_enthaelt(aus.bytes, 'Exif'), isFalse);
    });

    test('durchsichtiges PNG als JPG: weiß wie Papier, nicht schwarz', () {
      final durchsichtig = img.Image(width: 8, height: 8, numChannels: 4)
        ..clear(img.ColorRgba8(0, 0, 0, 0));
      final aus = fotoKodierenSofort(
          img.encodePng(durchsichtig), const FotoGroesse(), FotoFormat.jpg);
      final p = img.decodeJpg(aus.bytes)!.getPixel(4, 4);
      expect([p.r, p.g, p.b].every((k) => k > 245), isTrue,
          reason: 'war ${[p.r, p.g, p.b]}');
    });

    test('ein PNG behält seine Durchsichtigkeit', () {
      final durchsichtig = img.Image(width: 4, height: 4, numChannels: 4)
        ..clear(img.ColorRgba8(10, 20, 30, 0));
      final aus = fotoKodierenSofort(
          img.encodePng(durchsichtig), const FotoGroesse(), FotoFormat.png);
      expect(img.decodePng(aus.bytes)!.getPixel(1, 1).a, 0);
    });

    test('kein Bild: eine klare Ausnahme statt eines kaputten Fotos', () {
      expect(
        () => fotoKodierenSofort(
            Uint8List.fromList([1, 2, 3]), const FotoGroesse(), FotoFormat.jpg),
        throwsFormatException,
      );
    });
  });
}

bool _enthaelt(Uint8List bytes, String text) {
  final muster = text.codeUnits;
  outer:
  for (var i = 0; i + muster.length <= bytes.length; i++) {
    for (var j = 0; j < muster.length; j++) {
      if (bytes[i + j] != muster[j]) continue outer;
    }
    return true;
  }
  return false;
}
