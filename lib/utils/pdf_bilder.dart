/// „PDF in Bilder": aus jeder Seite eines PDF wird eine Bilddatei.
///
/// Hier steht der Teil ohne Oberfläche und ohne pdfium — Dateinamen,
/// Umwandlung der Pixel, die Schleife über die Seiten. Gerendert wird im
/// Bildschirm (`pdf_bilder_screen.dart`), geschrieben über [ZielOrdner].
/// So lässt sich alles, was hier falsch sein kann, ohne Gerät prüfen.
library;

import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import 'datei_ablage.dart';
import 'ordner_ablage.dart';

/// Die drei Formate zur Auswahl.
///
/// ⚠️ JPG und JPEG sind DASSELBE Bild, Byte für Byte. Beide stehen trotzdem
/// zur Wahl, weil manche Portale nur eine der beiden Endungen annehmen — das
/// Mitglied soll die Datei nicht umbenennen müssen.
enum BildFormat {
  jpg('jpg', 'image/jpeg', 'JPG'),
  jpeg('jpeg', 'image/jpeg', 'JPEG'),
  png('png', 'image/png', 'PNG');

  const BildFormat(this.endung, this.mime, this.anzeige);

  final String endung;
  final String mime;
  final String anzeige;
}

/// Auflösung der Bilder: 200 dpi, wie „PDF exportieren" im PDF-Manager der
/// Vorsitzer-App. Eine A4-Seite wird damit 1654 × 2339 Pixel — scharf genug
/// zum Lesen und Drucken, klein genug für die Portale, in die solche Bilder
/// meistens gehen.
const int pdfBilderDpi = 200;

/// Längste Kante in Pixeln. Ein Plakat in A0 hätte bei 200 dpi 62 Millionen
/// Pixel, rund 250 MB im Speicher — auf einem älteren Telefon das Ende der App.
/// Darüber wird die Seite verkleinert.
const int pdfBilderMaxKante = 4096;

/// JPG-Qualität wie überall in den Apps des Vereins, wo Seiten zu Bildern
/// werden.
const int pdfBilderJpgQualitaet = 90;

/// Breite und Höhe in Pixeln für eine Seite von [breitePt] × [hoehePt] Punkten.
({int breite, int hoehe}) seitenPixel(double breitePt, double hoehePt) {
  var breite = breitePt * pdfBilderDpi / 72;
  var hoehe = hoehePt * pdfBilderDpi / 72;
  final laengste = breite > hoehe ? breite : hoehe;
  if (laengste > pdfBilderMaxKante) {
    final faktor = pdfBilderMaxKante / laengste;
    breite *= faktor;
    hoehe *= faktor;
  }
  int runden(double v) => v.round() < 1 ? 1 : v.round();
  return (breite: runden(breite), hoehe: runden(hoehe));
}

/// Der Stamm der Bildnamen: der Name des PDF ohne Pfad und ohne `.pdf`.
String bildBasis(String pdfPfad) {
  final name = pdfPfad.split(RegExp(r'[/\\]')).last;
  final ohneEndung = name.toLowerCase().endsWith('.pdf')
      ? name.substring(0, name.length - 4)
      : name;
  return sichererDateiname(ohneEndung);
}

/// `Mietvertrag_1.jpg` … `Mietvertrag_5.jpg`.
///
/// ⚠️ Ab zehn Seiten mit führenden Nullen (`_01` … `_12`). Ohne sie sortiert
/// jeder Dateimanager `_10` vor `_2`, und wer die Bilder der Reihe nach in ein
/// Portal lädt, lädt sie in der falschen Reihenfolge hoch.
String bildDateiname(String basis, int seite, int gesamt, BildFormat format) {
  final stellen = gesamt >= 10 ? '$gesamt'.length : 1;
  return '${basis}_${'$seite'.padLeft(stellen, '0')}.${format.endung}';
}

/// Die Pixel einer Seite, so wie pdfium sie liefert.
typedef SeitenPixel = ({Uint8List bgra, int breite, int hoehe});

/// Macht aus den Pixeln einer Seite die Bilddatei — in einem eigenen Isolat,
/// damit die Fortschrittsanzeige nicht stehen bleibt.
Future<Uint8List> bildKodieren(SeitenPixel seite, BildFormat format) =>
    Isolate.run(() => bildKodierenSofort(seite, format));

/// [bildKodieren] ohne Isolat.
///
/// ⚠️ **BGRA, nicht RGBA.** pdfium legt die Kanäle in dieser Reihenfolge ab
/// (pdfrx' eigenes `createImageNF` liest sie ebenso). Wer RGBA annimmt,
/// vertauscht Rot und Blau: ein blauer Stempel käme rot heraus, und auf einer
/// schwarz-weißen Seite fiele es nie auf.
Uint8List bildKodierenSofort(SeitenPixel seite, BildFormat format) {
  final bild = img.Image.fromBytes(
    width: seite.breite,
    height: seite.hoehe,
    bytes: seite.bgra.buffer,
    bytesOffset: seite.bgra.offsetInBytes,
    numChannels: 4,
    order: img.ChannelOrder.bgra,
  );
  return switch (format) {
    // Ohne Alphakanal: die Seite ist auf Weiß gerendert, der Kanal wäre
    // überall 255 und machte die Datei nur ein Viertel größer.
    BildFormat.png => img.encodePng(bild.convert(numChannels: 3)),
    BildFormat.jpg ||
    BildFormat.jpeg =>
      img.encodeJpg(bild, quality: pdfBilderJpgQualitaet),
  };
}

/// Wie weit „PDF in Bilder" gekommen ist.
typedef BilderErgebnis = ({int geschrieben, bool angehalten});

/// Rendert Seite für Seite, wandelt um und legt ab.
///
/// Immer nur EINE Seite im Speicher: gerendert, umgewandelt, geschrieben,
/// dann die nächste. [rendern] bekommt den Index ab 0, [fortschritt] die
/// Seitenzahl ab 1, bevor die Seite beginnt. [angehalten] wird vor jeder
/// Seite gefragt; was schon im Ordner liegt, bleibt dort.
///
/// Fehler beim Rendern oder Schreiben gehen nach oben — mitsamt allem, was
/// bis dahin geschrieben wurde. Der Ordner wird hier NICHT geschlossen; das
/// tut der Aufrufer, auch im Fehlerfall.
Future<BilderErgebnis> seitenAblegen({
  required int gesamt,
  required Future<SeitenPixel> Function(int index) rendern,
  required ZielOrdner ziel,
  required String basis,
  required BildFormat format,
  void Function(int seite)? fortschritt,
  bool Function()? angehalten,
}) async {
  var geschrieben = 0;
  for (var i = 0; i < gesamt; i++) {
    if (angehalten?.call() ?? false) {
      return (geschrieben: geschrieben, angehalten: true);
    }
    fortschritt?.call(i + 1);
    final pixel = await rendern(i);
    final bytes = await bildKodieren(pixel, format);
    await ziel.schreiben(
      bildDateiname(basis, i + 1, gesamt, format),
      bytes,
      mime: format.mime,
    );
    geschrieben++;
  }
  return (geschrieben: geschrieben, angehalten: false);
}
