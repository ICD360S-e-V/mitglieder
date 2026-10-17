import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:icd360sev_mitglied/utils/chat_bild_jpg.dart';

/// App-Fehler #136 (17.10.2026): fünfmal „File type not allowed: heic“ beim
/// Senden eines Fotos aus der Galerie. chat/upload.php nimmt nur JPG/PNG (und
/// pdf/txt) und prüft zuerst die Endung; image_picker lieferte JPG-Inhalt
/// unter „scaled_….heic“. Ein echtes HEIC rechnet erst das Telefon (der
/// Test-Engine fehlt der HEIC-Decoder des Systems) — hier stehen GIF und BMP
/// für „ein Format, das der Server nicht nimmt“.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory ordner;

  setUp(() async => ordner = await Directory.systemTemp.createTemp('chat_bild_'));
  tearDown(() async => ordner.delete(recursive: true));

  img.Image bild(int b, int h) => img.Image(width: b, height: h)..clear(img.ColorRgb8(200, 120, 40));
  Uint8List jpg() => Uint8List.fromList(img.encodeJpg(bild(8, 6), quality: 90));
  Uint8List png() => Uint8List.fromList(img.encodePng(bild(8, 6)));
  Uint8List gif() => Uint8List.fromList(img.encodeGif(bild(8, 6)));
  Uint8List bmp(int b, int h) => Uint8List.fromList(img.encodeBmp(bild(b, h)));
  // Nur der Kopf einer HEIC-Datei („ftypheic“) — unlesbar wie ein HEIC auf
  // einem Gerät ohne Decoder.
  final heicKopf = Uint8List.fromList([0, 0, 0, 0x18, 0x66, 0x74, 0x79, 0x70, 0x68, 0x65, 0x69, 0x63, 0, 0, 0, 0,
      0x6D, 0x69, 0x66, 0x31, 0x68, 0x65, 0x69, 0x63]);

  Future<File> datei(String name, List<int> bytes) => File('${ordner.path}/$name').writeAsBytes(bytes);

  test('JPG und PNG werden am Inhalt erkannt, nicht an der Endung', () {
    expect(bildArtAusBytes(jpg()), 'jpg');
    expect(bildArtAusBytes(png()), 'png');
    expect(bildArtAusBytes(heicKopf), isNull);
    expect(bildArtAusBytes(gif()), isNull);
    expect(bildArtAusBytes(const <int>[]), isNull);
  });

  test('der Name bekommt die Endung, die zum Inhalt passt', () {
    expect(zielName('/data/user/0/cache/scaled_IMG_20261017.heic', 'jpg'), 'scaled_IMG_20261017.jpg');
    expect(zielName('/a/b.c/foto.HEIF', 'jpg'), 'foto.jpg');
    expect(zielName('foto', 'png'), 'foto.png');
  });

  test('„scaled_….heic“ mit JPG-Inhalt (so liefert image_picker): dieselben Bytes als .jpg', () async {
    final roh = jpg();
    final f = await chatBildFuerServer(await datei('scaled_IMG_1.heic', roh), ordner: ordner);
    expect(f.path, endsWith('/scaled_IMG_1.jpg'));
    expect(await f.readAsBytes(), roh, reason: 'nicht neu gerechnet — nur umbenannt');
  });

  test('PNG-Inhalt unter .webp: dieselben Bytes als .png', () async {
    final roh = png();
    final f = await chatBildFuerServer(await datei('scaled_sticker.webp', roh), ordner: ordner);
    expect(f.path, endsWith('/scaled_sticker.png'));
    expect(await f.readAsBytes(), roh);
  });

  test('JPG als .jpg/.jpeg und PNG als .png bleiben, wie sie sind', () async {
    for (final (name, roh) in [('IMG_2.jpg', jpg()), ('IMG_3.JPEG', jpg()), ('bild.png', png())]) {
      final orig = await datei(name, roh);
      expect((await chatBildFuerServer(orig, ordner: ordner)).path, orig.path, reason: name);
    }
  });

  test('GIF und BMP werden auf dem Telefon zu JPG', () async {
    for (final (name, roh) in [('animation.gif', gif()), ('scan.bmp', bmp(8, 6))]) {
      final f = await chatBildFuerServer(await datei(name, roh), ordner: ordner);
      expect(f.path, endsWith('.jpg'), reason: name);
      expect(bildArtAusBytes(await f.readAsBytes()), 'jpg', reason: name);
    }
  });

  test('beim Umrechnen wird die lange Seite begrenzt', () async {
    final f = await chatBildFuerServer(await datei('breit.bmp', bmp(40, 20)), ordner: ordner, langeSeite: 10);
    final j = img.decodeJpg(await f.readAsBytes())!;
    expect((j.width, j.height), (10, 5));
  });

  test('unlesbar: die Datei bleibt unverändert (der Server lehnt sie ab wie bisher)', () async {
    final orig = await datei('IMG_4.heic', heicKopf);
    expect((await chatBildFuerServer(orig, ordner: ordner)).path, orig.path);
  });

  test('die Galerie im Live-Chat schickt jedes Foto durch chatBildFuerServer', () {
    final q = File('lib/widgets/live_chat_dialog.dart').readAsStringSync();
    final i = q.indexOf('Future<void> _pickFromGallery()');
    expect(i, isNonNegative);
    final rumpf = q.substring(i, q.indexOf('\n  }\n', i));
    expect(rumpf, contains('chatBildFuerServer('));
    expect(rumpf, isNot(contains('.map((xfile) => File(xfile.path)).toList()')),
        reason: 'so gingen die Dateien unverändert hinaus');
  });
}
