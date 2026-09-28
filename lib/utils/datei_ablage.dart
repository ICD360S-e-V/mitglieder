import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Der Speichern-Dialog: bekommt Namensvorschlag und Inhalt und liefert
/// `null`, wenn abgebrochen wurde.
typedef SpeicherDialog = Future<String?> Function(
    String dateiname, Uint8List bytes);

/// Legt eine Datei dort ab, wo das Mitglied sie außerhalb der App
/// wiederfindet, und gibt zurück, wohin — oder `null`, wenn es im
/// Speichern-Dialog abgebrochen hat.
///
/// Telefon und Tablet: der Speichern-Dialog des Systems. Einen Ordner, in den
/// die App ohne Rückfrage schreiben darf und den das Mitglied je zu sehen
/// bekäme, gibt es dort nicht — das App-Verzeichnis, in das der Dokumente-Tab
/// schreibt, ist von außen unsichtbar. Zurück kommt der Dateiname; einen
/// Pfad, mit dem sich etwas anfangen ließe, liefert der Dialog nicht.
///
/// Rechner: ohne Rückfrage in den Downloads-Ordner, wie ein Browser, und nie
/// über eine vorhandene Datei ([freierDateiname]). Zurück kommt der volle
/// Pfad.
///
/// [dialog] und [ordner] sind nur für Tests.
Future<String?> dateiAblegen({
  required Uint8List bytes,
  required String dateiname,
  SpeicherDialog? dialog,
  Directory? ordner,
}) async {
  final name = sichererDateiname(dateiname);

  final mitDialog =
      dialog != null || (ordner == null && (Platform.isAndroid || Platform.isIOS));
  if (mitDialog) {
    final gespeichert = await (dialog ?? _systemDialog)(name, bytes);
    return gespeichert == null ? null : name;
  }

  final ziel = ordner ?? await _downloadsOrdner();
  final sep = Platform.pathSeparator;
  final frei = freierDateiname(
    name,
    (n) =>
        FileSystemEntity.typeSync('${ziel.path}$sep$n') !=
        FileSystemEntityType.notFound,
  );
  final pfad = '${ziel.path}$sep$frei';

  // Erst unter einem Zwischennamen schreiben: eine halb geschriebene Datei
  // mit dem richtigen Namen sähe im Dateimanager fertig aus.
  final teil = File('$pfad.teil');
  try {
    await teil.writeAsBytes(bytes, flush: true);
    await teil.rename(pfad);
  } catch (_) {
    try {
      if (await teil.exists()) await teil.delete();
    } catch (_) {}
    rethrow;
  }
  return pfad;
}

/// Ein Name vom Server wird nie zum Pfad. Trenner und alles, was Windows im
/// Namen verbietet (der Dialog würfe dort), werden zu `_`; führende Punkte
/// (versteckte Datei, `..`) und Punkte oder Leerzeichen am Ende fallen weg.
String sichererDateiname(String name) {
  var s = name
      .replaceAll(RegExp(r'[\\/<>:"|?*\x00-\x1f]'), '_')
      .replaceAll(RegExp(r'^[\s.]+|[\s.]+$'), '');

  if (s.length > 120) {
    final punkt = s.lastIndexOf('.');
    final endung =
        (punkt > 0 && s.length - punkt <= 10) ? s.substring(punkt) : '';
    var kopf = s.substring(0, 120 - endung.length);
    // Nicht mitten in einem Emoji (Ersatzpaar) abschneiden.
    if ((kopf.codeUnitAt(kopf.length - 1) & 0xFC00) == 0xD800) {
      kopf = kopf.substring(0, kopf.length - 1);
    }
    s = kopf + endung;
  }
  return s.isEmpty ? 'download' : s;
}

/// `name.pdf`, sonst `name(1).pdf`, `name(2).pdf` … Nie überschreiben: wer
/// dieselbe Datei zweimal holt, will die ältere nicht still verlieren.
String freierDateiname(String name, bool Function(String) existiert) {
  if (!existiert(name)) return name;
  final punkt = name.lastIndexOf('.');
  final basis = punkt > 0 ? name.substring(0, punkt) : name;
  final endung = punkt > 0 ? name.substring(punkt) : '';
  for (var i = 1; i < 10000; i++) {
    final kandidat = '$basis($i)$endung';
    if (!existiert(kandidat)) return kandidat;
  }
  // Praktisch unerreichbar; lieber ein Zeitstempel als eine Endlosschleife.
  return '$basis(${DateTime.now().millisecondsSinceEpoch})$endung';
}

Future<String?> _systemDialog(String dateiname, Uint8List bytes) =>
    FilePicker.platform.saveFile(fileName: dateiname, bytes: bytes);

Future<Directory> _downloadsOrdner() async {
  final dir = await getDownloadsDirectory() ??
      await getApplicationDocumentsDirectory();
  if (!await dir.exists()) await dir.create(recursive: true);
  return dir;
}
