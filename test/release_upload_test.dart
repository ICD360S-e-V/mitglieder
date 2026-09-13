// Der Upload der Release-Dateien.
//
// 🔴 Am 13.09.2026 (v1.100.0) gab uploads.github.com fuer die 148 MB grosse
// .dmg ein HTTP 500. Der Schritt war EIN Aufruf fuer `release/*`, brach deshalb
// ab, und im Release fehlte die .dmg — waehrend
// `version_mitglieder_macos.json` sehr wohl dort stand und den Geraeten eine
// Fassung versprach, die eine 404 ergibt.
//
// Zwei Regeln halten das: je Datei mit Wiederholung, und die Manifeste ZULETZT.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

/// ⚠️ Shell-Kommentare LAENGENTREU leeren. Ohne das fand die Zusicherung auf
/// `--clobber` ihren EIGENEN Warnkommentar und blieb gruen, nachdem der
/// Schalter aus dem Befehl entfernt war — von der Gegenprobe gefunden.
String ohneKommentare(String q) => q
    .split('\n')
    .map((z) {
      final i = z.indexOf('#');
      return i < 0 ? z : z.substring(0, i) + ' ' * (z.length - i);
    })
    .join('\n');

void main() {
  late String upload;
  late String pruefen;

  setUpAll(() {
    final y = loadYaml(
      File('.github/workflows/build-extras-platforms.yml').readAsStringSync(),
    ) as YamlMap;
    final schritte =
        (y['jobs']['release-upload-extras']['steps'] as YamlList).toList();
    String rumpfVon(String name) {
      final s = schritte.firstWhere((e) => (e as YamlMap)['name'] == name,
          orElse: () => fail('Schritt fehlt: $name')) as YamlMap;
      return s['run'] as String;
    }

    upload = ohneKommentare(rumpfVon('Upload extras to release'));
    pruefen = ohneKommentare(rumpfVon('Verify uploaded assets'));
  });

  test('je Datei einzeln, nicht ein Aufruf fuer release/*', () {
    // Ein Sammelaufruf bricht beim ersten Fehlschlag ab und laesst den Rest
    // liegen — genau der Verlust vom 13.09.2026.
    expect(upload, isNot(contains('gh release upload "\$TAG" release/*')));
    expect(upload, contains('hochladen() {'));
    expect(upload, contains('for f in release/*'));
  });

  test('mit Wiederholung und Wartezeit', () {
    // ⚠️ Die ANZAHL pruefen, nicht die Anwesenheit der Schleife: `for versuch
    // in 1; do` erfuellt ein `contains('for versuch in')` und wiederholt
    // nichts. Von der Gegenprobe gefunden.
    final m = RegExp(r'for versuch in ([\d ]+); do').firstMatch(upload);
    expect(m, isNotNull, reason: 'keine Wiederholungsschleife');
    final versuche = m!.group(1)!.trim().split(RegExp(r'\s+'));
    expect(versuche.length, greaterThanOrEqualTo(3),
        reason: 'ein einziger Versuch ist keine Wiederholung');
    expect(upload, contains('sleep'));
    expect(upload, contains('--clobber'),
        reason: 'ohne das ist ein zweiter Versuch kein Versuch, sondern ein '
            'Fehler „asset already exists"');
  });

  test('🔴 die Manifeste ZULETZT, und nur bei vollstaendigen Binaerdateien', () {
    // Ein Manifest sagt den Geraeten, welche Fassung es zu holen gibt. Steht es
    // im Release, waehrend die Binaerdatei fehlt, greift jeder Client auf eine
    // 404 zu. Fehlt umgekehrt nur das Manifest, sieht niemand ein Update — der
    // harmlose der beiden Faelle.
    final ueberspringen = upload.indexOf('version_mitglieder_*.json) continue');
    final manifeste = upload.indexOf('for f in release/version_mitglieder_*.json');
    final wache = upload.indexOf('if [ "\$fehler" -ne 0 ]');
    expect(ueberspringen, greaterThanOrEqualTo(0),
        reason: 'der erste Durchgang muss die Manifeste auslassen');
    expect(wache, greaterThanOrEqualTo(0), reason: 'die Wache fehlt ganz');
    expect(manifeste, greaterThanOrEqualTo(0),
        reason: 'die Manifeste muessen einen eigenen Durchgang haben');
    expect(wache, lessThan(manifeste),
        reason: 'die Wache MUSS vor dem Manifest-Durchgang stehen');
    expect(ueberspringen, lessThan(wache));
  });

  test('nachgezaehlt wird am Release, nicht am Rueckgabewert', () {
    // Ein Upload kann 0 melden und die Datei trotzdem nicht im Release liegen.
    expect(pruefen, contains('gh release view'));
    expect(pruefen, contains('--json assets'));
    expect(pruefen, contains('for f in release/*'));
    expect(pruefen, contains('::error::'));
  });
}
