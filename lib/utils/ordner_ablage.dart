import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'datei_ablage.dart';

/// Ein Ordner, den das Mitglied gewählt hat. Mehrere Dateien gehen
/// nacheinander hinein — anders als [dateiAblegen], das EINE Datei über den
/// Speichern-Dialog ablegt.
///
/// ⚠️ Ein Pfad allein reicht nicht auf jedem System:
///
/// * **Android** ab 11 lässt eine App ohne Sonderrecht nur in einige
///   Systemordner schreiben (Download/, Documents/, Pictures/ …). Ein selbst
///   angelegter Ordner im Wurzelverzeichnis oder die SD-Karte scheitern. Der
///   amtliche Weg ist das Storage Access Framework: der gewählte Ordner ist
///   freigegeben, wo immer er liegt (`OrdnerAblage.kt`).
/// * **iPhone/iPad**: ein gewählter Ordner bleibt gesperrt, bis die App ihn
///   ausdrücklich öffnet. file_picker liefert nur den Pfad, ohne ihn zu
///   öffnen; jedes Schreiben außerhalb des App-Bereichs scheiterte damit
///   (`AppDelegate.swift`).
/// * **Windows, Linux, macOS** schreiben über den Pfad aus dem
///   Auswahlfenster. macOS darf das dank
///   `com.apple.security.files.user-selected.read-write`, die Flatpak-Fassung
///   bekommt den Ordner über das Portal.
abstract class ZielOrdner {
  /// Wie der Ordner heißt — für die Meldung am Ende.
  String get name;

  /// Legt [dateiname] an und gibt zurück, unter welchem Namen die Datei
  /// wirklich liegt. Nie überschreiben: ist der Name vergeben, bekommt die
  /// neue Datei eine Nummer dazu.
  Future<String> schreiben(String dateiname, Uint8List bytes,
      {required String mime});

  /// Gibt den Ordner wieder frei. Danach wird nicht mehr geschrieben.
  Future<void> schliessen();
}

/// Öffnet die Ordnerauswahl des Systems. `null`: abgebrochen.
///
/// [titel] steht dort, wo das System einen Titel zeigt (Windows, Linux,
/// macOS).
Future<ZielOrdner?> ordnerWaehlen({String? titel}) async {
  if (Platform.isAndroid || Platform.isIOS) return KanalOrdner.waehlen();
  final pfad = await FilePicker.getDirectoryPath(dialogTitle: titel);
  if (pfad == null || pfad.isEmpty) return null;
  return PfadOrdner(Directory(pfad));
}

/// Windows, Linux, macOS: ein gewöhnlicher Ordner auf der Platte.
class PfadOrdner implements ZielOrdner {
  PfadOrdner(this.ordner);

  final Directory ordner;

  @override
  String get name {
    final teile = ordner.path
        .split(RegExp(r'[/\\]'))
        .where((t) => t.isNotEmpty)
        .toList();
    return teile.isEmpty ? ordner.path : teile.last;
  }

  @override
  Future<String> schreiben(String dateiname, Uint8List bytes,
      {required String mime}) async {
    final sep = Platform.pathSeparator;
    final frei = freierDateiname(
      sichererDateiname(dateiname),
      (n) =>
          FileSystemEntity.typeSync('${ordner.path}$sep$n') !=
          FileSystemEntityType.notFound,
    );
    final pfad = '${ordner.path}$sep$frei';

    // Erst unter einem Zwischennamen schreiben, wie in [dateiAblegen]: eine
    // halb geschriebene Datei mit dem richtigen Namen sähe fertig aus.
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
    return frei;
  }

  @override
  Future<void> schliessen() async {}
}

/// Android und iPhone: Auswahl und Schreiben auf der nativen Seite.
///
/// Gleicher Kanal, gleiche Aufrufe auf beiden Systemen:
/// `waehlen` → `{ordner, name}` oder `null`; `schreiben` → der Name, unter
/// dem die Datei liegt; `schliessen` → gibt den Ordner frei.
class KanalOrdner implements ZielOrdner {
  KanalOrdner._(this._schluessel, this.name);

  @visibleForTesting
  static const kanal = MethodChannel('de.icd360sev.mitglied/ordner_ablage');

  /// Android: die Adresse des gewählten Ordners. iPhone: eine Kennung, unter
  /// der die native Seite den geöffneten Ordner hält.
  final String _schluessel;

  @override
  final String name;

  /// Öffnet die Auswahl. `null`: abgebrochen.
  static Future<KanalOrdner?> waehlen() async {
    final antwort = await kanal.invokeMapMethod<String, dynamic>('waehlen');
    final schluessel = antwort?['ordner'] as String?;
    if (schluessel == null || schluessel.isEmpty) return null;
    return KanalOrdner._(schluessel, (antwort?['name'] as String?) ?? '');
  }

  @override
  Future<String> schreiben(String dateiname, Uint8List bytes,
      {required String mime}) async {
    final name = await kanal.invokeMethod<String>('schreiben', {
      'ordner': _schluessel,
      'name': sichererDateiname(dateiname),
      'mime': mime,
      'bytes': bytes,
    });
    return name ?? dateiname;
  }

  @override
  Future<void> schliessen() async {
    try {
      await kanal.invokeMethod<void>('schliessen', {'ordner': _schluessel});
    } catch (_) {
      // Freigeben ist Aufräumen: misslingt es, sind die Bilder trotzdem da.
    }
  }
}
