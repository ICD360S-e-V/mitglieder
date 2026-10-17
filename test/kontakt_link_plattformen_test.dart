// Der Link in der Mail mit dem Bestätigungscode öffnet die App — und jede
// Plattform meldet ihn anders an: Android im Manifest, iOS und macOS in der
// Info.plist, Windows in der Registry (Installer) und in main.cpp, Linux in
// my_application.cc und den .desktop-Dateien. Diese Zusicherungen halten alle
// Stellen mit lib/services/kontakt_link.dart zusammen: ändern sich dort
// Adresse oder Schema, muss es überall mit — sonst öffnet der Link auf einer
// Plattform still den Browser statt der App.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:icd360sev_mitglied/services/kontakt_link.dart';

/// ⚠️ Kommentare werden LAENGENTREU geleert: sonst findet eine Zusicherung
/// ihren eigenen Erklaerkommentar, und Positionsvergleiche verrutschen.
/// Nur fuer C++ — in Dart stuende `//` auch in Adressen.
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

/// XML ohne <!-- … -->.
String ohneXmlKommentare(String q) => q.replaceAll(RegExp(r'<!--.*?-->', dotAll: true), '');

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
  const schema = KontaktLink.schema;

  test('Adresse und Schema sind die der Mail', () {
    expect(KontaktLink.host, 'icd360sev.icd360s.de');
    expect(KontaktLink.pfad, '/code/');
    expect(schema, 'icd360s-mitglied');
  });

  test('Android: App Link mit autoVerify, eigenes Schema, Flutters Deeplinks aus', () {
    final manifest = ohneXmlKommentare(File('android/app/src/main/AndroidManifest.xml').readAsStringSync());
    final start = manifest.indexOf('android:name=".MainActivity"');
    expect(start, greaterThanOrEqualTo(0));
    final aktivitaet = manifest.substring(start, manifest.indexOf('</activity>', start));

    expect(aktivitaet,
        contains('<meta-data android:name="flutter_deeplinking_enabled" android:value="false" />'));

    final verifiziert = aktivitaet.indexOf('<intent-filter android:autoVerify="true">');
    expect(verifiziert, greaterThanOrEqualTo(0));
    final applink = aktivitaet.substring(verifiziert, aktivitaet.indexOf('</intent-filter>', verifiziert));
    expect(applink, contains('<action android:name="android.intent.action.VIEW" />'));
    expect(applink, contains('<category android:name="android.intent.category.DEFAULT" />'));
    expect(applink, contains('<category android:name="android.intent.category.BROWSABLE" />'));
    expect(applink,
        contains('<data android:scheme="https" android:host="${KontaktLink.host}" android:path="${KontaktLink.pfad}" />'));
    expect(applink, contains('<data android:path="/code" />'));

    final eigenes = aktivitaet.indexOf('<data android:scheme="$schema" android:host="code" />');
    expect(eigenes, greaterThanOrEqualTo(0));
    final filter = aktivitaet.substring(aktivitaet.lastIndexOf('<intent-filter', eigenes), eigenes);
    expect(filter, contains('android.intent.category.BROWSABLE'),
        reason: 'Ohne BROWSABLE darf der Browser (Knopf der Seite /code/) die App nicht öffnen.');
  });

  test('iOS und macOS: das Schema steht in der Info.plist', () {
    for (final pfad in ['ios/Runner/Info.plist', 'macos/Runner/Info.plist']) {
      final plist = ohneXmlKommentare(File(pfad).readAsStringSync());
      expect(
          plist,
          matches(RegExp(
              '<key>CFBundleURLTypes</key>\\s*<array>\\s*<dict>.*?'
              '<key>CFBundleURLSchemes</key>\\s*<array>\\s*<string>${RegExp.escape(schema)}</string>',
              dotAll: true)),
          reason: pfad);
    }
    expect(ohneXmlKommentare(File('ios/Runner/Info.plist').readAsStringSync()),
        matches(RegExp(r'<key>FlutterDeepLinkingEnabled</key>\s*<false/>')));
  });

  test('Windows: der Installer meldet das Schema an, „%1“ ist der Link', () {
    final iss = File('windows/installer.iss').readAsStringSync();
    final zeilen = iss.split('\n').where((z) => z.startsWith('Root: HKA; Subkey: "Software\\Classes\\$schema')).toList();
    expect(zeilen, hasLength(4));
    expect(zeilen.first, contains('Flags: uninsdeletekey'));
    expect(zeilen, contains(contains('ValueName: "URL Protocol"; ValueData: ""')));
    expect(
        zeilen,
        contains(allOf(contains(r'\shell\open\command"'),
            contains(r'ValueData: """{app}\{#MyAppExeName}"" ""%1"""'))));
    // HKA ist nur bei einer Installation je Benutzer HKCU.
    expect(iss, contains('PrivilegesRequired=lowest'));
  });

  test('Windows: ein zweiter Start reicht den Link an die laufende App', () {
    final quelle = ohneKommentare(File('windows/runner/main.cpp').readAsStringSync());
    expect(quelle, contains('#include "app_links/app_links_plugin_c_api.h"'));
    final sperre = rumpf(quelle, 'bool EinzigeInstanz()');
    final gefunden = sperre.indexOf('LaufendesFenster()');
    final link = sperre.indexOf('SendAppLink(fenster);');
    expect(link, greaterThan(gefunden));
    expect(link, lessThan(sperre.indexOf('NachVorneHolen(fenster);')));
    // Das Fenster sucht main.cpp selbst, an seiner Marke — nicht app_links an
    // der Klasse, die jede Flutter-App hat.
    expect(quelle, isNot(contains('SendAppLinkToInstance')));
  });

  test('Linux: die Kommandozeile mit dem Link geht an die laufende App', () {
    final quelle = ohneKommentare(File('linux/runner/my_application.cc').readAsStringSync());
    expect(quelle, contains('G_APPLICATION_HANDLES_COMMAND_LINE | G_APPLICATION_HANDLES_OPEN'));
    final neu = rumpf(quelle, 'MyApplication* my_application_new()');
    final release = neu.substring(neu.indexOf('#ifdef NDEBUG'), neu.indexOf('#else'));
    final debug = neu.substring(neu.indexOf('#else'), neu.indexOf('#endif'));
    expect(release, contains('"flags",'));
    expect(release, contains('kLinkFlags'));
    expect(debug, contains('G_APPLICATION_NON_UNIQUE | kLinkFlags'));

    // Am Ende FALSE: erst dann reicht GApplication die Kommandozeile als
    // "command-line" weiter, wo app_links_linux den Link liest.
    final zeile = rumpf(quelle, 'static gboolean my_application_local_command_line(');
    final letztes = zeile.lastIndexOf('return ');
    expect(zeile.substring(letztes), startsWith('return FALSE;'));
  });

  test('Linux: die .desktop-Dateien melden das Schema an und reichen den Link durch', () {
    for (final pfad in ['linux/icd360sev_mitglied.desktop', 'flatpak/de.icd360s.Mitglieder.desktop']) {
      final zeilen = File(pfad).readAsLinesSync();
      expect(zeilen, contains('Exec=icd360sev_mitglied %u'), reason: pfad);
      expect(zeilen, contains('MimeType=x-scheme-handler/$schema;'), reason: pfad);
    }
  });

  test('die App hört ab dem Start zu, das Dashboard zeigt den Code', () {
    final haupt = ohneKommentarzeilen(File('lib/main.dart').readAsStringSync());
    final starten = haupt.indexOf('KontaktLink.instance.starten();');
    expect(starten, greaterThanOrEqualTo(0));
    expect(starten, lessThan(haupt.indexOf('runApp(')));

    final dashboard = ohneKommentarzeilen(File('lib/screens/mitglied_dashboard.dart').readAsStringSync());
    final init = rumpf(dashboard, 'void initState()');
    expect(init, contains('KontaktLink.instance.offen.addListener(_codeAusLinkZeigen);'));
    // Kam der Link vor der Anmeldung, wartet er schon: gleich nach dem ersten Bild.
    final bild = init.indexOf('addPostFrameCallback(');
    expect(init.indexOf('_codeAusLinkZeigen();', bild), greaterThan(bild));
    expect(rumpf(dashboard, 'void dispose()'),
        contains('KontaktLink.instance.offen.removeListener(_codeAusLinkZeigen);'));
    // Der Code landet dort, wo man ihn auch von Hand eingibt: im Profil,
    // Reiter „Verifizierung“, Stufe 1 (verifizierung_stufe1_offen_test.dart).
    final zeigen = rumpf(dashboard, 'void _codeAusLinkZeigen()');
    expect(zeigen, contains('KontaktLink.instance.abholen()'));
    expect(zeigen, contains('_showProfileDialog(codeAusLink: code);'));
    expect(rumpf(dashboard, 'void _showProfileDialog('), contains('codeAusLink: codeAusLink,'));
  });
}
