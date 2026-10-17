import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

/// Bilder für den Chat so, wie chat/upload.php sie annimmt: JPG oder PNG,
/// mit der Endung, die zum Inhalt passt.
///
/// App-Fehler #136 (17.10.2026): ein Mitglied schickte fünfmal ein Foto aus
/// der Galerie und las jedes Mal „File type not allowed: heic“. Der Server
/// nimmt nur pdf, png, jpg, jpeg und txt — er prüft zuerst die Endung.
///
/// ⚠️ Der Inhalt war dabei meist schon JPG: image_picker rechnet ein Foto mit
/// `imageQuality` < 100 neu (BitmapFactory liest HEIC ab Android 9) und
/// schreibt es als JPG — aber unter dem alten Namen „scaled_….heic“. Darum
/// entscheidet hier der INHALT (die ersten Bytes), nicht die Endung:
///  * JPG oder PNG: dieselben Bytes, nur unter der passenden Endung;
///  * alles andere (HEIC auf älteren Geräten, WEBP, GIF, BMP …): auf dem
///    Telefon in ein JPG umgerechnet. Der Server bleibt bei seinen Regeln.
/// Lässt sich ein Bild nicht lesen, bleibt die Datei, wie sie ist — der Server
/// lehnt sie dann ab wie bisher.

/// „jpg“ oder „png“ nach den ersten Bytes — sonst null.
String? bildArtAusBytes(List<int> b) {
  if (b.length >= 3 && b[0] == 0xFF && b[1] == 0xD8 && b[2] == 0xFF) return 'jpg';
  const png = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
  if (b.length >= png.length) {
    for (var i = 0; i < png.length; i++) {
      if (b[i] != png[i]) return null;
    }
    return 'png';
  }
  return null;
}

/// Der Dateiname aus [pfad] mit der Endung [endung] („scaled_IMG_1.heic“ →
/// „scaled_IMG_1.jpg“).
String zielName(String pfad, String endung) {
  final name = pfad.split(RegExp(r'[/\\]')).last;
  final punkt = name.lastIndexOf('.');
  final stamm = punkt > 0 ? name.substring(0, punkt) : name;
  return '$stamm.$endung';
}

/// Eine Datei, die der Chat-Server annimmt — siehe oben. [ordner] nur im Test;
/// sonst der temporäre Ordner der App.
Future<File> chatBildFuerServer(
  File datei, {
  Directory? ordner,
  int langeSeite = 2500,
  int qualitaet = 92,
}) async {
  final bytes = await datei.readAsBytes();
  final art = bildArtAusBytes(bytes);
  if (art != null) {
    final endung = datei.path.toLowerCase().split('.').last;
    final passt = art == 'jpg' ? (endung == 'jpg' || endung == 'jpeg') : endung == 'png';
    if (passt) return datei;
    return _schreiben(ordner, zielName(datei.path, art), bytes);
  }
  final jpg = await _alsJpg(bytes, langeSeite, qualitaet);
  if (jpg == null) return datei;
  return _schreiben(ordner, zielName(datei.path, 'jpg'), jpg);
}

Future<File> _schreiben(Directory? ordner, String name, List<int> bytes) async {
  final o = ordner ?? await getTemporaryDirectory();
  // Eigener Unterordner je Aufruf: zwei Fotos mit gleichem Namen aus
  // verschiedenen Alben überschreiben sich nicht.
  final unter = await Directory('${o.path}/chat_bild_${DateTime.now().microsecondsSinceEpoch}').create(recursive: true);
  return File('${unter.path}/$name').writeAsBytes(bytes, flush: true);
}

/// Liest das Bild mit den Decodern der Engine (WEBP, GIF, BMP überall; HEIC
/// auf Android ab 9 über den Decoder des Systems), begrenzt die lange Seite
/// und rechnet es als JPG. null, wenn es sich nicht lesen lässt.
Future<Uint8List?> _alsJpg(Uint8List bytes, int langeSeite, int qualitaet) async {
  try {
    final puffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final codec = await ui.instantiateImageCodecWithSize(puffer, getTargetSize: (b, h) {
      final lang = b > h ? b : h;
      if (lang <= langeSeite) return ui.TargetImageSize(width: b, height: h);
      final f = langeSeite / lang;
      return ui.TargetImageSize(width: (b * f).round(), height: (h * f).round());
    });
    final bild = (await codec.getNextFrame()).image;
    final rgba = await bild.toByteData(format: ui.ImageByteFormat.rawRgba);
    final breite = bild.width, hoehe = bild.height;
    bild.dispose();
    codec.dispose();
    if (rgba == null) return null;
    final roh = Uint8List.fromList(rgba.buffer.asUint8List(rgba.offsetInBytes, rgba.lengthInBytes));
    // Das Rechnen des JPG dauert bei 2500 px gut eine Sekunde — nicht im
    // UI-Isolat.
    return await Isolate.run(() => Uint8List.fromList(img.encodeJpg(
          img.Image.fromBytes(width: breite, height: hoehe, bytes: roh.buffer, numChannels: 4),
          quality: qualitaet,
        )));
  } catch (_) {
    return null;
  }
}
