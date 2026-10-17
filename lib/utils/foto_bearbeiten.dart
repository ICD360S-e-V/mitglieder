/// „Foto bearbeiten": der Teil ohne Oberfläche — Größe, Format, Name der
/// Kopie, Umwandeln der Pixel.
///
/// Bearbeitet wird im Editor (`pro_image_editor`, siehe
/// `foto_bearbeiten_screen.dart`), gelesen und geschrieben über [FotoQuelle].
/// Was hier steht, lässt sich ohne Gerät prüfen.
library;

import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import 'datei_ablage.dart';

/// Das Format der bearbeiteten Kopie.
enum FotoFormat {
  jpg('jpg', 'image/jpeg', 'JPG'),
  png('png', 'image/png', 'PNG');

  const FotoFormat(this.endung, this.mime, this.anzeige);

  final String endung;
  final String mime;
  final String anzeige;

  /// Wie das Original: ein PNG bleibt PNG (es kann durchsichtig sein), alles
  /// andere wird JPG — auch HEIC, WebP und BMP, die die App nicht schreibt.
  static FotoFormat wieOriginal(String name) =>
      endungVon(name) == 'png' ? FotoFormat.png : FotoFormat.jpg;
}

/// JPG-Qualität, mit der „Größe" startet. Gemessen an einem echten Foto mit
/// 12 Megapixel: halbe Kantenlänge wird bei 85 rund 1,1 MB statt 3,1 MB.
const int fotoJpgQualitaet = 85;

/// Größte Kantenlänge, die der Editor erzeugt.
///
/// ⚠️ pro_image_editor verkleinert von sich aus auf 2000 × 2000 — ein Foto mit
/// 4000 × 3000 käme still mit 2000 × 1500 zurück. Die Größe soll sich aber nur
/// ändern, wenn das Mitglied es unter „Größe" so einstellt. 8192 schafft
/// jede Grafikeinheit der letzten Jahre und deckt ein Foto mit 50 Megapixel ab.
const int fotoMaxKante = 8192;

/// Was das Mitglied unter „Größe" einstellt.
class FotoGroesse {
  const FotoGroesse({
    this.inProzent = true,
    this.prozent = 100,
    this.breite,
    this.format,
    this.qualitaet = fotoJpgQualitaet,
  });

  /// `true`: [prozent] gilt. `false`: [breite] in Pixeln gilt, die Höhe folgt
  /// dem Seitenverhältnis — wie in Microsofts „Fotos" lässt es sich nicht
  /// aufheben; wer ein anderes Verhältnis will, schneidet zu.
  final bool inProzent;
  final int prozent;
  final int? breite;

  /// `null`: wie das Original ([FotoFormat.wieOriginal]).
  final FotoFormat? format;

  /// Nur für JPG.
  final int qualitaet;

  /// Nichts eingestellt: gleiche Pixel, Format wie das Original.
  bool get unveraendert =>
      format == null && (inProzent ? prozent >= 100 : breite == null);

  FotoGroesse kopie({
    bool? inProzent,
    int? prozent,
    int? breite,
    FotoFormat? format,
    int? qualitaet,
  }) =>
      FotoGroesse(
        inProzent: inProzent ?? this.inProzent,
        prozent: prozent ?? this.prozent,
        breite: breite ?? this.breite,
        format: format ?? this.format,
        qualitaet: qualitaet ?? this.qualitaet,
      );
}

/// Breite und Höhe der Kopie für ein Bild von [breite] × [hoehe].
///
/// Nie größer als das Bild: Vergrößern erfindet keine Schärfe, es macht nur
/// die Datei größer.
({int breite, int hoehe}) zielMasse(int breite, int hoehe, FotoGroesse g) {
  int mindestens1(num v) => v.round() < 1 ? 1 : v.round();
  if (g.inProzent) {
    final p = g.prozent.clamp(1, 100);
    return (
      breite: mindestens1(breite * p / 100),
      hoehe: mindestens1(hoehe * p / 100)
    );
  }
  final b = (g.breite ?? breite).clamp(1, breite);
  return (breite: b, hoehe: mindestens1(b * hoehe / breite));
}

/// Kleingeschriebene Endung ohne Punkt, `''` ohne Endung.
String endungVon(String name) {
  final punkt = name.lastIndexOf('.');
  return punkt > 0 ? name.substring(punkt + 1).toLowerCase() : '';
}

/// Bilder, die „Foto bearbeiten" öffnet. GIF nur mit dem ersten Bild.
const fotoEndungen = {
  'jpg',
  'jpeg',
  'png',
  'webp',
  'heic',
  'heif',
  'bmp',
  'gif'
};

bool istFotoName(String name) => fotoEndungen.contains(endungVon(name));

/// HEIC/HEIF — das Format der iPhone-Kamera. Windows und Linux haben dafür
/// keinen Decoder, der sicher da ist; Telefon und Mac wandeln es um.
bool istHeicName(String name) =>
    const {'heic', 'heif'}.contains(endungVon(name));

/// `Urlaub.jpg` → `Urlaub_bearbeitet.jpg`. [zusatz] kommt aus der Sprache des
/// Mitglieds; die Endung folgt dem Format der Kopie, nicht dem Original
/// (`Foto.heic` → `Foto_bearbeitet.jpg`).
String kopieName(String original, String zusatz, FotoFormat format) {
  final punkt = original.lastIndexOf('.');
  final basis = punkt > 0 ? original.substring(0, punkt) : original;
  return sichererDateiname('${basis}_$zusatz.${format.endung}');
}

/// `3.1 MB` — dieselbe Schreibweise wie bei Chat-Anhängen.
String groesseText(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}

typedef FotoErgebnis = ({Uint8List bytes, int breite, int hoehe});

/// Breite und Höhe, ohne das ganze Bild zu dekodieren — für „Jetzt" im
/// Größen-Fenster. `null`: unbekanntes Format.
({int breite, int hoehe})? fotoMasse(Uint8List bytes) {
  final img.DecodeInfo? info;
  try {
    info = img.findDecoderForData(bytes)?.startDecode(bytes);
  } catch (_) {
    // Das Paket wirft bei sehr kurzen oder kaputten Daten aus den Prüfungen
    // einzelner Formate heraus (RangeError) — das heißt nur: kein Bild.
    return null;
  }
  if (info == null) return null;
  // Ein hochkant fotografiertes JPG liegt quer in der Datei und wird erst über
  // die EXIF-Drehung aufrecht. Die Maße müssen die aufrechten sein.
  final gedreht = _drehungTauschtSeiten(bytes);
  return gedreht
      ? (breite: info.height, hoehe: info.width)
      : (breite: info.width, hoehe: info.height);
}

bool _drehungTauschtSeiten(Uint8List bytes) {
  try {
    final o = img.decodeJpgExif(bytes)?.imageIfd.orientation;
    return o != null && o >= 5 && o <= 8;
  } catch (_) {
    return false;
  }
}

/// Macht aus [quelle] die Kopie: aufrecht, in der Größe aus [g], im [format].
/// Läuft in einem eigenen Isolat — bei 12 Megapixel dauert es eine Sekunde und
/// länger, und die Oberfläche soll derweil nicht stehen.
Future<FotoErgebnis> fotoKodieren(
        Uint8List quelle, FotoGroesse g, FotoFormat format) =>
    Isolate.run(() => fotoKodierenSofort(quelle, g, format));

/// Wie [fotoKodieren], im aufrufenden Isolat — für Tests.
FotoErgebnis fotoKodierenSofort(
    Uint8List quelle, FotoGroesse g, FotoFormat format) {
  img.Image? dekodiert;
  try {
    dekodiert = img.decodeImage(quelle);
  } catch (_) {
    // Siehe [fotoMasse]: kaputte Daten werfen sonst einen RangeError.
    dekodiert = null;
  }
  if (dekodiert == null) throw const FormatException('Bild nicht lesbar');

  // ⚠️ Ohne das stünde ein hochkant fotografiertes Bild nach dem Speichern
  // quer: JPGs vom Telefon liegen oft gedreht in der Datei, aufrecht macht sie
  // erst ein EXIF-Eintrag — und den schreibt die Kopie nicht mit.
  var bild = img.bakeOrientation(dekodiert);

  final ziel = zielMasse(bild.width, bild.height, g);
  if (ziel.breite != bild.width || ziel.hoehe != bild.height) {
    // „average" mittelt alle Pixel, die auf einen neuen fallen. Beim
    // Verkleinern flimmern so feine Muster (Schrift, Stoff) nicht.
    bild = img.copyResize(
      bild,
      width: ziel.breite,
      height: ziel.hoehe,
      interpolation: img.Interpolation.average,
    );
  }

  // Keine Metadaten in der Kopie: kein Aufnahmeort, kein Gerät. Was das
  // Mitglied weitergibt, ist das Bild — nicht, wo es entstand.
  bild.exif = img.ExifData();

  final bytes = switch (format) {
    FotoFormat.jpg => img.encodeJpg(_aufWeiss(bild), quality: g.qualitaet),
    FotoFormat.png => img.encodePng(bild),
  };
  return (bytes: bytes, breite: bild.width, hoehe: bild.height);
}

/// JPG kennt keine Durchsichtigkeit; ohne Untergrund würde aus einem
/// durchsichtigen PNG ein schwarzer Rand. Weiß wie Papier.
img.Image _aufWeiss(img.Image bild) {
  if (!bild.hasAlpha) return bild;
  final weiss = img.Image(width: bild.width, height: bild.height)
    ..clear(img.ColorRgb8(255, 255, 255));
  return img.compositeImage(weiss, bild);
}
