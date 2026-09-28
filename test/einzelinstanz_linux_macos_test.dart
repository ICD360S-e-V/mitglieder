// Die App laeuft auch auf Linux und macOS nur EINMAL.
//
// 🔴 WAS HIER SCHIEFGING. Linux: `my_application.cc` startete mit
// `G_APPLICATION_NON_UNIQUE` — jeder Start war ein eigener Prozess mit eigener
// WebSocket-Verbindung, und das In-App-Update startete das neue AppImage
// NEBEN der alten Fassung. macOS: eine zweite Kopie an anderem Ort (etwa
// direkt aus dem Update-DMG) lief ebenfalls parallel, und ein Klick auf das
// Dock-Symbol holte das im Infobereich versteckte Fenster nie zurueck.
// Der Server stellt eine Fernwartungsanfrage jeder Verbindung zu.
//
// Das Gegenstueck fuer Windows steht in test/einzelinstanz_test.dart.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ⚠️ Kommentare werden LAENGENTREU geleert: sonst findet eine Zusicherung
/// ihren eigenen Erklaerkommentar, und Positionsvergleiche verrutschen.
/// Nur fuer C++ und Swift — in Dart stuende `//` auch in Adressen.
String ohneKommentare(String q) => q
    .replaceAllMapped(RegExp(r'/\*.*?\*/', dotAll: true),
        (m) => m[0]!.replaceAll(RegExp(r'[^\n]'), ' '))
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i) + ' ' * (z.length - i);
    })
    .join('\n');

/// Fuer Dart: nur ganze Kommentarzeilen leeren.
String ohneKommentarzeilen(String q) => q
    .split('\n')
    .map((z) => z.trimLeft().startsWith('//') ? '' : z)
    .join('\n');

/// Schneidet ab dem Kopf bis zur ausgeglichenen schliessenden Klammer.
String rumpf(String quelle, String kopf) {
  final start = quelle.indexOf(kopf);
  expect(start, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  var i = start;
  var rund = 0;
  while (i < quelle.length) {
    final c = quelle[i];
    if (c == '(') rund++;
    if (c == ')') rund--;
    if (c == '{' && rund == 0) break;
    i++;
  }
  final ab = i;
  var tiefe = 0;
  while (i < quelle.length) {
    if (quelle[i] == '{') tiefe++;
    if (quelle[i] == '}') {
      tiefe--;
      if (tiefe == 0) return quelle.substring(ab, i + 1);
    }
    i++;
  }
  fail('Rumpf nicht geschlossen: $kopf');
}

void main() {
  group('Linux', () {
    late String runner;

    setUpAll(() {
      runner = ohneKommentare(
          File('linux/runner/my_application.cc').readAsStringSync());
    });

    test('der Release-Bau ist einmalig — mit der Flatpak-Kennung im Sandkasten',
        () {
      final neu = rumpf(runner, 'MyApplication* my_application_new()');
      final release = neu.substring(
          neu.indexOf('#ifdef NDEBUG'), neu.indexOf('#else'));
      expect(release, isNot(contains('G_APPLICATION_NON_UNIQUE')));
      // Im Flatpak darf die App nur ihren eigenen Namen auf dem Bus belegen
      // (de.icd360s.Mitglieder), nicht APPLICATION_ID.
      expect(release, contains('g_getenv("FLATPAK_ID")'));
      expect(release, contains('g_application_id_is_valid(flatpak_id)'));
      expect(release, contains('"application-id", kennung'));
    });

    test('ein zweiter Start holt das vorhandene Fenster, statt eins zu bauen',
        () {
      final aktiv =
          rumpf(runner, 'static void my_application_activate(');
      final vorhanden = aktiv.indexOf('gtk_application_get_windows(');
      final zeigen = aktiv.indexOf('gtk_window_present(');
      final neuesFenster = aktiv.indexOf('gtk_application_window_new(');
      expect(vorhanden, greaterThanOrEqualTo(0));
      expect(zeigen, greaterThan(vorhanden));
      expect(neuesFenster, greaterThan(zeigen));
      expect(aktiv.substring(zeigen, neuesFenster), contains('return;'));
    });

    test('verweigert der Bus den Namen, startet die App ohne Sperre', () {
      final zeile =
          rumpf(runner, 'static gboolean my_application_local_command_line(');
      final erst = zeile.indexOf('g_application_register(');
      final rueckfall = zeile.indexOf(
          'g_application_set_flags(application, G_APPLICATION_NON_UNIQUE)');
      final zweit = zeile.indexOf('g_application_register(', erst + 1);
      final abbruch = zeile.indexOf('*exit_status = 1;');
      expect(rueckfall, greaterThan(erst));
      expect(zweit, greaterThan(rueckfall));
      // Aufgegeben wird erst, wenn auch der zweite Versuch scheitert.
      expect(abbruch, greaterThan(zweit));
    });
  });

  group('Linux-Update', () {
    late String dienst;
    late String uebergabe;

    setUpAll(() {
      dienst = ohneKommentarzeilen(
          File('lib/services/update_service.dart').readAsStringSync());
      uebergabe =
          rumpf(dienst, 'Future<bool> _launchLinuxAppImage(String appImagePath)');
    });

    test('das neue AppImage startet erst, wenn die alte Fassung weg ist', () {
      expect(rumpf(dienst, 'Future<bool> launchInstaller('),
          contains('return await _launchLinuxAppImage(installerPath);'));
      expect(uebergabe, contains(r'while kill -0 "$1"'));
      expect(uebergabe, contains(r'exec "$2"'));
      expect(uebergabe, contains("'\$pid'"));
      expect(uebergabe, contains('mode: ProcessStartMode.detached'));
      // Die Shell steht, BEVOR sich die App beendet.
      expect(uebergabe.indexOf('/bin/sh'),
          lessThan(uebergabe.lastIndexOf('exit(0);')));
    });

    test('im Flatpak beendet sich die App dabei nicht', () {
      // Dort laeuft kein AppImage — die App zu beenden, liesse das Mitglied
      // ohne App zurueck.
      final flatpak = uebergabe.indexOf("Platform.environment['FLATPAK_ID']");
      expect(flatpak, greaterThanOrEqualTo(0));
      final zweig = uebergabe.substring(
          flatpak, uebergabe.indexOf('}', flatpak));
      expect(zweig, contains('return true;'));
      expect(zweig, isNot(contains('exit(')));
    });
  });

  group('macOS', () {
    late String delegat;
    late String fenster;

    setUpAll(() {
      delegat = ohneKommentare(
          File('macos/Runner/AppDelegate.swift').readAsStringSync());
      fenster = ohneKommentare(
          File('macos/Runner/MainFlutterWindow.swift').readAsStringSync());
    });

    test('Dock-Symbol holt das versteckte Fenster zurueck', () {
      final reopen =
          rumpf(delegat, 'override func applicationShouldHandleReopen(');
      expect(reopen, contains('mainFlutterWindow'));
      expect(reopen, contains('!fenster.isVisible'));
      expect(reopen, contains('fenster.makeKeyAndOrderFront(nil)'));
      expect(reopen, contains('fenster.deminiaturize(nil)'));
    });

    test('eine zweite Kopie beendet sich, bevor eine Engine entsteht', () {
      final wach = rumpf(fenster, 'override func awakeFromNib()');
      final pruefung = wach.indexOf('MainFlutterWindow.laufendeKopieNachVorne()');
      expect(pruefung, greaterThanOrEqualTo(0));
      expect(pruefung, lessThan(wach.indexOf('FlutterViewController()')));
      expect(
          wach.substring(pruefung, wach.indexOf('FlutterViewController()')),
          contains('exit(0)'));

      final suche =
          rumpf(fenster, 'private static func laufendeKopieNachVorne()');
      expect(suche, contains('runningApplications(withBundleIdentifier:'));
      // Sich selbst findet die Suche immer — der eigene Prozess zaehlt nicht.
      expect(suche, contains(r'$0.processIdentifier != selbst'));
      // Wie ein Klick auf das Dock-Symbol der laufenden Kopie.
      expect(suche, contains('NSWorkspace.shared.openApplication('));
    });
  });
}
