import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'datei_ablage.dart';
import 'foto_bearbeiten.dart';
import 'ordner_ablage.dart';

/// Ein Foto in einer [FotoQuelle].
class FotoEintrag {
  const FotoEintrag({
    required this.schluessel,
    required this.name,
    this.pfad,
    this.groesse,
    this.geaendert,
  });

  /// Woran die Quelle das Foto wiederfindet: Android die Adresse des
  /// Dokuments, iPhone der Name im Ordner oder die Kennung in „Fotos",
  /// Rechner der Pfad.
  final String schluessel;

  final String name;

  /// Nur am Rechner: der Pfad, damit die Vorschau direkt von der Platte kommt.
  final String? pfad;

  final int? groesse;
  final DateTime? geaendert;
}

/// Woher die Fotos kommen und wohin die bearbeitete Kopie geht: ein Ordner
/// oder ein einzelnes Foto.
///
/// ⚠️ Das Original wird NIE überschrieben. Die Kopie kommt daneben (Ordner),
/// über den Speichern-Dialog (einzelnes Foto) oder in „Fotos" (iPhone); erst
/// danach fragt die App, ob das Original weg soll.
abstract class FotoQuelle {
  /// Wie der Ordner heißt. Beim einzelnen Foto leer.
  String get name;

  bool get istOrdner;

  /// iPhone: das Original liegt in „Fotos". Gelöscht wandert es dort nach
  /// „Zuletzt gelöscht" und lässt sich zurückholen — überall sonst ist es weg.
  bool get inFotosApp => false;

  /// Alle Fotos — beim einzelnen Foto genau eins. Neueste zuerst, wie in
  /// einer Galerie: wer ein Foto bearbeiten will, hat es meist gerade gemacht.
  Future<List<FotoEintrag>> auflisten();

  /// Die Bytes zum Bearbeiten. HEIC kommt als JPG, wo das System es umwandeln
  /// kann (Telefon, Mac); am Windows- und Linux-Rechner gibt es
  /// [HeicNichtMoeglich].
  Future<Uint8List> lesen(FotoEintrag eintrag);

  /// Ein kleines JPG für die Übersicht. `null`: keine Vorschau — am Rechner
  /// liest die Übersicht dann selbst von [FotoEintrag.pfad].
  Future<Uint8List?> vorschau(FotoEintrag eintrag, int kante);

  /// Legt die bearbeitete Kopie ab und gibt zurück, unter welchem Namen.
  /// `null`: im Speichern-Dialog abgebrochen.
  Future<String?> kopieSpeichern(
    FotoEintrag original, {
    required String dateiname,
    required Uint8List bytes,
    required String mime,
  });

  /// `true`: das Original ist weg.
  Future<bool> originalLoeschen(FotoEintrag eintrag);

  /// Gibt einen geöffneten Ordner wieder frei.
  Future<void> schliessen();
}

/// Ein HEIC-Foto an einem Rechner ohne Decoder dafür (Windows, Linux).
class HeicNichtMoeglich implements Exception {
  const HeicNichtMoeglich();
}

/// Öffnet die Ordnerauswahl. `null`: abgebrochen.
Future<FotoQuelle?> fotoOrdnerWaehlen({String? titel}) async {
  if (Platform.isAndroid || Platform.isIOS) {
    final ordner = await KanalOrdner.waehlen();
    return ordner == null ? null : KanalFotoOrdner(ordner);
  }
  final pfad = await FilePicker.getDirectoryPath(dialogTitle: titel);
  if (pfad == null || pfad.isEmpty) return null;
  return RechnerFotoOrdner(Directory(pfad));
}

/// Öffnet die Auswahl für EIN Foto. `null`: abgebrochen.
///
/// Android: die Dateiauswahl des Systems, nicht die Fotoauswahl — nur über
/// sie darf die App das Original später löschen (siehe `FotoQuelle.kt`).
/// iPhone: „Fotos". Rechner: das Dateifenster.
Future<(FotoQuelle, FotoEintrag)?> einzelFotoWaehlen() async {
  if (Platform.isAndroid || Platform.isIOS) return KanalEinzelFoto.waehlen();
  final datei = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: fotoEndungen.toList(),
  );
  final pfad = datei?.path;
  if (pfad == null) return null;
  final quelle = RechnerEinzelFoto(File(pfad));
  return (quelle, quelle.eintrag);
}

// ── Rechner: Windows, Linux, macOS ──

/// Liest ein Foto von der Platte; HEIC nur am Mac (über ImageIO).
Future<Uint8List> _rechnerLesen(String pfad) async {
  final bytes = await File(pfad).readAsBytes();
  if (!istHeicName(pfad)) return bytes;
  if (!Platform.isMacOS) throw const HeicNichtMoeglich();
  final jpg =
      await fotoUmwandelnKanal.invokeMethod<Uint8List>('heicZuJpg', bytes);
  if (jpg == null) throw const HeicNichtMoeglich();
  return jpg;
}

/// macOS: HEIC → JPG über ImageIO (`MainFlutterWindow.swift`).
@visibleForTesting
const fotoUmwandelnKanal =
    MethodChannel('de.icd360sev.mitglied/foto_umwandeln');

FotoEintrag _rechnerEintrag(File datei, [FileStat? stat]) => FotoEintrag(
      schluessel: datei.path,
      name: datei.uri.pathSegments.isEmpty
          ? datei.path
          : datei.uri.pathSegments.last,
      pfad: datei.path,
      groesse: stat?.size,
      geaendert: stat?.modified,
    );

/// Ein Ordner auf der Platte. Gelöscht wird mit `File.delete`: die App läuft
/// am Mac ohne Sandbox, und Windows und Linux kennen keine — die Flatpak-Fassung
/// bekommt im persönlichen Ordner vom Portal den echten Pfad.
class RechnerFotoOrdner implements FotoQuelle {
  RechnerFotoOrdner(this.ordner) : _ziel = PfadOrdner(ordner);

  final Directory ordner;
  final PfadOrdner _ziel;

  @override
  String get name => _ziel.name;

  @override
  bool get istOrdner => true;

  @override
  bool get inFotosApp => false;

  @override
  Future<List<FotoEintrag>> auflisten() async {
    final liste = <FotoEintrag>[];
    await for (final e in ordner.list(followLinks: false)) {
      if (e is! File || !istFotoName(e.path)) continue;
      // Versteckte Dateien (`.Foto.jpg`, Vorschauen von macOS) gehören nicht
      // in die Übersicht.
      final name = e.uri.pathSegments.last;
      if (name.startsWith('.')) continue;
      liste.add(_rechnerEintrag(e, await e.stat()));
    }
    return sortieren(liste);
  }

  @override
  Future<Uint8List> lesen(FotoEintrag eintrag) =>
      _rechnerLesen(eintrag.schluessel);

  @override
  Future<Uint8List?> vorschau(FotoEintrag eintrag, int kante) async => null;

  @override
  Future<String?> kopieSpeichern(
    FotoEintrag original, {
    required String dateiname,
    required Uint8List bytes,
    required String mime,
  }) =>
      _ziel.schreiben(dateiname, bytes, mime: mime);

  @override
  Future<bool> originalLoeschen(FotoEintrag eintrag) =>
      _rechnerLoeschen(eintrag);

  @override
  Future<void> schliessen() async {}
}

/// Ein einzelnes Foto auf der Platte. Die Kopie geht über den
/// Speichern-Dialog — wie beim unterschriebenen PDF.
class RechnerEinzelFoto implements FotoQuelle {
  RechnerEinzelFoto(File datei) : eintrag = _rechnerEintrag(datei);

  final FotoEintrag eintrag;

  @override
  String get name => '';

  @override
  bool get istOrdner => false;

  @override
  bool get inFotosApp => false;

  @override
  Future<List<FotoEintrag>> auflisten() async => [eintrag];

  @override
  Future<Uint8List> lesen(FotoEintrag eintrag) =>
      _rechnerLesen(eintrag.schluessel);

  @override
  Future<Uint8List?> vorschau(FotoEintrag eintrag, int kante) async => null;

  @override
  Future<String?> kopieSpeichern(
    FotoEintrag original, {
    required String dateiname,
    required Uint8List bytes,
    required String mime,
  }) =>
      dateiAblegen(bytes: bytes, dateiname: dateiname, immerDialog: true);

  @override
  Future<bool> originalLoeschen(FotoEintrag eintrag) =>
      _rechnerLoeschen(eintrag);

  @override
  Future<void> schliessen() async {}
}

Future<bool> _rechnerLoeschen(FotoEintrag eintrag) async {
  try {
    await File(eintrag.schluessel).delete();
    return true;
  } on FileSystemException {
    // Schreibgeschützt, gerade woanders geöffnet (Windows) oder ein
    // USB-Stick, den Flatpak nur über das Portal freigibt.
    return false;
  }
}

/// Neueste zuerst; gleich alt nach Namen, damit die Reihenfolge fest ist.
@visibleForTesting
List<FotoEintrag> sortieren(List<FotoEintrag> liste) => liste
  ..sort((a, b) {
    final za = a.geaendert, zb = b.geaendert;
    if (za != null && zb != null && za != zb) return zb.compareTo(za);
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  });

// ── Telefon: Android und iPhone ──

List<FotoEintrag> _ausKanal(List<Object?>? roh) => sortieren([
      for (final m in (roh ?? const []).whereType<Map<Object?, Object?>>())
        FotoEintrag(
          schluessel: m['schluessel'] as String,
          name: (m['name'] as String?) ?? '',
          groesse: (m['groesse'] as num?)?.toInt(),
          geaendert: (m['geaendert'] as num?) == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(
                  (m['geaendert'] as num).toInt()),
        ),
    ]);

/// Ein Ordner, den die native Seite geöffnet hat — derselbe Kanal wie
/// „PDF in Bilder" ([KanalOrdner]): auswählen, hineinschreiben, freigeben,
/// und jetzt auch auflisten, lesen, Vorschau und löschen.
class KanalFotoOrdner implements FotoQuelle {
  KanalFotoOrdner(this._ordner);

  final KanalOrdner _ordner;

  static const _kanal = KanalOrdner.kanal;

  @override
  String get name => _ordner.name;

  @override
  bool get istOrdner => true;

  @override
  bool get inFotosApp => false;

  Map<String, Object?> _argumente(FotoEintrag e) =>
      {'ordner': _ordner.schluessel, 'datei': e.schluessel};

  @override
  Future<List<FotoEintrag>> auflisten() async => _ausKanal(await _kanal
      .invokeListMethod<Object?>('auflisten', {'ordner': _ordner.schluessel}));

  @override
  Future<Uint8List> lesen(FotoEintrag eintrag) async {
    final bytes =
        await _kanal.invokeMethod<Uint8List>('lesen', _argumente(eintrag));
    if (bytes == null) throw const FormatException('leer');
    return bytes;
  }

  @override
  Future<Uint8List?> vorschau(FotoEintrag eintrag, int kante) async {
    try {
      return await _kanal.invokeMethod<Uint8List>(
          'vorschau', {..._argumente(eintrag), 'kante': kante});
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<String?> kopieSpeichern(
    FotoEintrag original, {
    required String dateiname,
    required Uint8List bytes,
    required String mime,
  }) =>
      _ordner.schreiben(dateiname, bytes, mime: mime);

  @override
  Future<bool> originalLoeschen(FotoEintrag eintrag) async =>
      await _kanal.invokeMethod<bool>('loeschen', _argumente(eintrag)) ?? false;

  @override
  Future<void> schliessen() => _ordner.schliessen();
}

/// Ein einzelnes Foto über die native Seite.
///
/// Android: Dateiauswahl des Systems (`ACTION_OPEN_DOCUMENT`); die Kopie geht
/// über den Speichern-Dialog, gelöscht wird über den Anbieter oder — wo der
/// es nicht kann — mit der Rückfrage von Android.
///
/// iPhone: „Fotos". Die Bytes kommen gleich mit (HEIC schon als JPG), die
/// Kopie geht zurück nach „Fotos", gelöscht wird über die Mediathek — iOS
/// fragt dabei selbst nach.
class KanalEinzelFoto implements FotoQuelle {
  KanalEinzelFoto._(this.eintrag, this._bytes, {required this.inFotosApp});

  @visibleForTesting
  static const kanal = MethodChannel('de.icd360sev.mitglied/foto_quelle');

  /// iOS wartet beim Löschen auf die eigene Rückfrage. Kommt die nie (auf
  /// iOS 26 berichtet), soll die App nicht ewig drehen.
  @visibleForTesting
  static Duration loeschenWartezeit = const Duration(minutes: 2);

  final FotoEintrag eintrag;
  Uint8List? _bytes;

  @override
  final bool inFotosApp;

  /// `null`: abgebrochen.
  static Future<(FotoQuelle, FotoEintrag)?> waehlen() async {
    final m = await kanal.invokeMapMethod<String, Object?>('waehlen');
    final schluessel = m?['schluessel'] as String?;
    if (m == null || schluessel == null) return null;
    final eintrag = FotoEintrag(
      schluessel: schluessel,
      name: (m['name'] as String?) ?? '',
      groesse: (m['groesse'] as num?)?.toInt(),
    );
    final quelle = KanalEinzelFoto._(
      eintrag,
      m['bytes'] as Uint8List?,
      inFotosApp: m['fotosApp'] == true,
    );
    return (quelle, eintrag);
  }

  @override
  String get name => '';

  @override
  bool get istOrdner => false;

  @override
  Future<List<FotoEintrag>> auflisten() async => [eintrag];

  @override
  Future<Uint8List> lesen(FotoEintrag eintrag) async {
    final schon = _bytes;
    if (schon != null) return schon;
    final bytes = await kanal
        .invokeMethod<Uint8List>('lesen', {'datei': eintrag.schluessel});
    if (bytes == null) throw const FormatException('leer');
    return _bytes = bytes;
  }

  @override
  Future<Uint8List?> vorschau(FotoEintrag eintrag, int kante) async => null;

  @override
  Future<String?> kopieSpeichern(
    FotoEintrag original, {
    required String dateiname,
    required Uint8List bytes,
    required String mime,
  }) async {
    if (inFotosApp) {
      final ok = await kanal.invokeMethod<bool>(
              'inFotosSpeichern', {'bytes': bytes, 'name': dateiname}) ??
          false;
      if (ok) return dateiname;
      // Kein Zugriff auf „Fotos" erlaubt: dann wenigstens in „Dateien" —
      // die Arbeit des Mitglieds soll nicht verloren gehen.
    }
    return dateiAblegen(bytes: bytes, dateiname: dateiname, immerDialog: true);
  }

  @override
  Future<bool> originalLoeschen(FotoEintrag eintrag) async {
    try {
      return await kanal.invokeMethod<bool>('loeschen',
              {'datei': eintrag.schluessel}).timeout(loeschenWartezeit) ??
          false;
    } on TimeoutException {
      return false;
    }
  }

  @override
  Future<void> schliessen() async {}
}
