// Haelt fest, dass die Berechtigung „Ueber anderen Apps anzeigen" erfragt wird
// UND dass jeder Text davon uebersetzt ist.
//
// 🔴 Der gemeldete Fall: das Mitglied wechselt waehrend eines Gespraechs in den
// Browser, und das Fenster verschwindet. Die Vorsitzer-App hat das Fenster seit
// PR #702; hier fehlte es ganz. `SYSTEM_ALERT_WINDOW` ist eine BESONDERE
// Berechtigung: kein Laufzeit-Dialog, nur die Systemeinstellungen. Ohne sie
// wirft `WindowManager.addView` eine `BadTokenException`, die native Seite
// faengt sie ab, der Anruf laeuft weiter — kein Absturz, keine Meldung, kein
// Fenster.
//
// Ein laufendes Gespraech mit Wechsel in eine fremde App ist von einem Test aus
// nicht herstellbar, deshalb wird der Quelltext geprueft. Jede Zusicherung ist
// gegengeprobt: nimmt man die Reparatur zurueck, wird sie rot.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/anruf_guete.dart';

/// Kommentare weg — sonst bestaetigt der Test die Erklaerung ueber dem Code
/// statt den Code. Die Laenge bleibt gleich, damit Fundstellen stimmen.
String ohneKommentare(String q) => q
    .replaceAllMapped(RegExp(r'/\*.*?\*/', dotAll: true),
        (m) => m[0]!.replaceAll(RegExp(r'[^\n]'), ' '))
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i);
    })
    .join('\n');

/// Schneidet ab dem Kopf bis zur ausgeglichenen schliessenden Klammer.
///
/// ⚠️ Erst die runden Klammern des Kopfes ausgleichen, dann die geschweiften:
/// bei `foo({int a}) {` ist die erste `{` die PARAMETERLISTE, und ein Test, der
/// dort zu schneiden beginnt, prueft einen anderen Bereich als er sagt.
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
  expect(i, lessThan(quelle.length), reason: 'kein Rumpfanfang: $kopf');
  var tiefe = 0;
  final ab = i;
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

/// Schneidet den Bereich einer Kotlin-Funktion aus.
///
/// ⚠️ Eine Zusicherung braucht Anfang UND Ende. `resolveActivity` steht in
/// `MainActivity.kt` an einer anderen, richtigen Stelle — eine Suche ueber die
/// ganze Datei pruefte etwas anderes, als sie sagt. Genau dieser Fehler ist in
/// der Vorsitzer-App erst der Gegenprobe aufgefallen.
String nurEinstellweg(String kotlin) {
  const kopf = 'private fun overlayEinstellungOeffnen()';
  final a = kotlin.indexOf(kopf);
  expect(a, greaterThan(0), reason: 'die Kette fehlt ganz');
  final rest = kotlin.substring(a + kopf.length);
  final e = rest.indexOf('\n    private fun ');
  final block = e < 0 ? rest : rest.substring(0, e);
  return block
      .split('\n')
      .where((z) => !z.trimLeft().startsWith('//'))
      .join('\n');
}

/// Die elf Schluessel dieser Funktion.
const kSchluessel = [
  'anruffensterTitel',
  'anruffensterZweck',
  'anruffensterAndroidHinweis',
  'anruffensterOhneErlaubnis',
  'anruffensterErteilt',
  'anruffensterNichtErteilt',
  'anruffensterVonHand',
  'anruffensterNurAndroid',
  'anrufLaeuft',
  'videoanrufLaeuft',
  'anruffensterBildWechseln',
];

/// Schneidet den Rumpf von `bauen()` aus — Anfang UND Ende.
///
/// ⚠️ Ohne Grenze prueft eine Zusicherung irgendwann etwas anderes, als sie
/// sagt: `setColorFilter(Color.WHITE)` steht in der Datei mehrfach, und
/// `GradientDrawable` auch (die Karte selbst hat eines).
String nurBauen(String kotlin) {
  const kopf = 'private fun bauen(';
  final a = kotlin.indexOf(kopf);
  expect(a, greaterThan(0), reason: 'bauen() fehlt ganz');
  final rest = kotlin.substring(a + kopf.length);
  final e = rest.indexOf('\n    private fun ');
  final block = e < 0 ? rest : rest.substring(0, e);
  return block
      .split('\n')
      .where((z) => !z.trimLeft().startsWith('//'))
      .join('\n');
}

/// Nur den Auflegen-Knopf, ab seinem Zeichen bis zum Ende seines Blocks.
///
/// ⚠️ Die rote Flaeche und der eigene Zuhoerer muessen an DIESEM Knopf haengen.
/// Ueber ganz `bauen()` gesucht, waere die Zusicherung auch dann gruen, wenn
/// das Rot an der Karte klebte und der Knopf blass blieb.
String nurAuflegenKnopf(String kotlin) {
  final b = nurBauen(kotlin);
  final a = b.indexOf('R.drawable.ic_anruf_auflegen');
  expect(a, greaterThan(0), reason: 'der Auflegen-Knopf fehlt');
  final e = b.indexOf('\n        })', a);
  expect(e, greaterThan(a), reason: 'Knopfblock nicht geschlossen');
  return b.substring(a, e);
}

/// Schneidet einen Kotlin-Block ab seinem Kopf bis zur passenden Klammer.
String nurBlock(String kotlin, String kopf) {
  final a = kotlin.indexOf(kopf);
  expect(a, greaterThan(0), reason: 'Kopf nicht gefunden: $kopf');
  var i = a;
  var rund = 0;
  while (i < kotlin.length) {
    final c = kotlin[i];
    if (c == '(') rund++;
    if (c == ')') rund--;
    if (c == '{' && rund == 0) break;
    i++;
  }
  var tiefe = 0;
  final ab = i;
  while (i < kotlin.length) {
    if (kotlin[i] == '{') tiefe++;
    if (kotlin[i] == '}') {
      tiefe--;
      if (tiefe == 0) return kotlin.substring(ab, i + 1);
    }
    i++;
  }
  fail('Block nicht geschlossen: $kopf');
}

void main() {
  late String karte;
  late String dashboard;
  late String widgetQ;
  late String konto;
  late String vordergrund;
  late String mainActivity;
  late String manifest;
  late String gemeinsam;
  late String klingelQ;

  setUpAll(() {
    karte = ohneKommentare(
        File('lib/services/anruf_systemkarte.dart').readAsStringSync());
    dashboard = ohneKommentare(
        File('lib/screens/mitglied_dashboard.dart').readAsStringSync());
    widgetQ = ohneKommentare(
        File('lib/widgets/anruffenster_erlaubnis.dart').readAsStringSync());
    konto = ohneKommentare(
        File('lib/widgets/mitglied_profile_dialog.dart').readAsStringSync());
    vordergrund = ohneKommentare(
        File('lib/services/anruf_vordergrund.dart').readAsStringSync());
    mainActivity = File(
            'android/app/src/main/kotlin/de/icd360s/mitglieder/MainActivity.kt')
        .readAsStringSync();
    manifest =
        File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    // ⚠️ Seit dem 13.09.2026 steht der ABLAUF in [Sonderberechtigung] und nur
    // noch die TEXTE in anruffenster_erlaubnis.dart — es gibt eine zweite
    // solche Berechtigung (Vollbild-Benachrichtigungen fuer den
    // Klingelschirm), und zwei Kopien desselben Ablaufs liefen auseinander,
    // ohne dass etwas fehlschlaegt.
    gemeinsam = ohneKommentare(
        File('lib/widgets/sonderberechtigung.dart').readAsStringSync());
    klingelQ = ohneKommentare(
        File('lib/widgets/klingel_erlaubnis.dart').readAsStringSync());
  });

  group('Es wird ueberhaupt gefragt', () {
    test('die Dienstfunktionen haben einen Aufrufer in lib/', () {
      // 🔴 In der Vorsitzer-App war genau DAS der ganze Defekt: beide
      // Funktionen gab es, niemand rief sie. Ein Zaehler ueber lib/ ist die
      // einzige Stelle, an der das Wiederabkoppeln auffaellt.
      var pruefen = 0;
      var oeffnen = 0;
      for (final f in Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
        if (f.path.endsWith('anruf_vordergrund.dart')) continue; // Definition
        final q = ohneKommentare(f.readAsStringSync());
        if (q.contains('systemfensterErlaubt()')) pruefen++;
        if (q.contains('systemfensterEinstellung')) oeffnen++;
      }
      expect(pruefen, greaterThanOrEqualTo(1),
          reason: 'niemand fragt die Berechtigung ab — das Fenster bleibt '
              'schweigend aus');
      expect(oeffnen, greaterThanOrEqualTo(1),
          reason: 'kein Weg in die Systemeinstellungen');
    });

    test('der Melder ist ein ValueNotifier am Dienst, kein BuildContext', () {
      expect(karte, contains('ValueNotifier<bool> erlaubnisFehlt'));
      // ⚠️ Der Dienst darf keinen Kontext halten: sonst haengt die Regel, wann
      // gefragt wird, an einem Bildschirm, der geschlossen werden kann.
      expect(karte, isNot(contains('BuildContext')));
    });

    test('gefragt wird nur, solange die App IM BLICK ist', () {
      final p = rumpf(karte, 'void _pruefen()');
      expect(p, contains('_erlaubnisPruefen()'));
      final stelle = p.indexOf('_erlaubnisPruefen()');
      final zeile = p.lastIndexOf('\n', stelle);
      expect(p.substring(zeile, stelle), contains('_imVordergrund'),
          reason: 'ein Hinweis im Hintergrund wird nie gesehen');
    });

    test('hoechstens EINMAL je App-Lauf', () {
      final e = rumpf(karte, 'Future<void> _erlaubnisPruefen()');
      expect(e, contains('if (_schonGefragt) return;'));
      expect(e.indexOf('_schonGefragt = true'),
          lessThan(e.indexOf('await AnrufVordergrund.systemfensterErlaubt()')),
          reason: 'sonst laufen zwei Abfragen parallel');
      expect(e, contains('if (erlaubt) return;'));
    });

    test('abbauen() setzt Sperre und Melder zurueck', () {
      final a = rumpf(karte, 'void abbauen()');
      expect(a, contains('_schonGefragt = false'));
      expect(a, contains('erlaubnisFehlt.value = false'));
    });
  });

  group('Der Titel des nativen Fensters kommt UEBERSETZT aus Dart', () {
    test('der Dienst nimmt ihn von der Oberflaeche', () {
      expect(karte, contains('void texte('));
      final p = rumpf(karte, 'void _pruefen()');
      expect(p, contains('titel:'),
          reason: 'ohne Titel zeichnet das Fenster eine leere Zeile');
      // ⚠️ Ohne gesetzten Text wird das Fenster NICHT gezeigt: eine leere
      // Zeile sieht kaputt aus, und dann ist ohnehin etwas anderes falsch.
      expect(p, contains('_titelAnruf.isNotEmpty'));
    });

    test('das Dashboard setzt sie in didChangeDependencies, nicht initState',
        () {
      // 🔴 `initState` laeuft nur einmal — nach einem Sprachwechsel stuende
      // die alte Sprache im Fenster. `didChangeDependencies` laeuft wieder.
      final d = rumpf(dashboard, 'void didChangeDependencies()');
      expect(d, contains('AnrufSystemkarte().texte('));
      expect(d, contains('anrufLaeuft'));
      expect(d, contains('videoanrufLaeuft'));
      final i = rumpf(dashboard, 'void initState()');
      expect(i, isNot(contains('.texte(')),
          reason: 'in initState gesetzt, verpasst es jeden Sprachwechsel');
    });

    test('die native Seite nimmt den Titel als Parameter', () {
      final kt = File('android/app/src/main/kotlin/de/icd360s/mitglieder/'
              'AnrufSystemfenster.kt')
          .readAsStringSync();
      expect(kt, contains('titel: String'));
      // ⚠️ KEINE String-Ressource: das waere eine zweite Uebersetzungsquelle
      // neben den 28 ARB-Dateien, und beide liefen auseinander.
      expect(kt, isNot(contains('R.string')));
      expect(kt, isNot(contains('getString(')));
    });
  });

  group('Dashboard hoert zu — und haengt sich wieder ab', () {
    test('Melder angemeldet', () {
      expect(dashboard,
          contains('erlaubnisFehlt.addListener(_anruffensterErlaubnisFragen)'));
    });

    test('mounted-Wache und der Wert werden geprueft', () {
      final f = rumpf(dashboard, 'void _anruffensterErlaubnisFragen()');
      expect(f, contains('erlaubnisFehlt.value'));
      expect(f, contains('if (!mounted) return;'));
      expect(f, contains('anruffensterHinweisZeigen(context)'));
    });

    test('dispose haengt ihn ab', () {
      final d = rumpf(dashboard, 'void dispose()');
      expect(d, contains('removeListener(_anruffensterErlaubnisFragen)'),
          reason: 'ein Zuhoerer auf einem Singleton ueberlebt den Bildschirm');
    });
  });

  group('Der dauerhafte Weg im Konto', () {
    test('die Zeile steht im Profil-Dialog', () {
      expect(konto, contains('const AnruffensterErlaubnis()'),
          reason: 'ohne sie ist die Berechtigung nach einem „Spaeter" fuer '
              'immer unerreichbar');
    });
  });

  group('Das Widget selbst', () {
    test('liest nach der Rueckkehr aus den Systemeinstellungen neu', () {
      final l = rumpf(gemeinsam, 'void didChangeAppLifecycleState(');
      expect(l, contains('AppLifecycleState.resumed'));
      expect(l, contains('_lesen()'));
    });

    test('der Knopf bleibt auch bei erteilter Berechtigung', () {
      final b = rumpf(gemeinsam, 'Widget build(BuildContext context)');
      expect(b, contains('onPressed: _oeffnen'));
      final knopf = b.substring(b.indexOf('TextButton('));
      expect(knopf.substring(0, knopf.indexOf('child:')),
          isNot(contains('erlaubt')),
          reason: 'der Knopf selbst darf nicht am Zustand haengen');
      final o = rumpf(gemeinsam, 'Future<void> _oeffnen()');
      expect(o, contains('berechtigung.oeffnen()'));
      expect(o, contains('vonHandText'));
      // ⚠️ Und die TEXTE muessen weiter von HIER kommen. Ohne das waere der
      // gemeinsame Aufbau da und niemand fuettert ihn — die Zeile im Konto
      // stuende leer, und kein Test haette es gesehen.
      expect(widgetQ,
          contains('oeffnen: AnrufVordergrund.systemfensterEinstellung'));
      expect(widgetQ, contains('vonHandText: l.anruffensterVonHand'));
    });

    test('drei Zustaende, und „wird geladen" ist keiner von beiden', () {
      final b = rumpf(gemeinsam, 'Widget build(BuildContext context)');
      expect(b, contains('erlaubt == null'),
          reason: 'null heisst „noch nicht gelesen", nicht „nicht erteilt"');
      expect(b, contains('erteiltText'));
      expect(b, contains('nichtErteiltText'));
      expect(widgetQ, contains('erteiltText: l.anruffensterErteilt'));
      expect(widgetQ, contains('nichtErteiltText: l.anruffensterNichtErteilt'));
    });

    test('die Einstellung wird nur auf Wunsch geoeffnet', () {
      final h = rumpf(gemeinsam, 'Future<void> sonderberechtigungHinweis(');
      // ⚠️ BEIDE Stellen muessen vorkommen, sonst ist der Positionsvergleich
      // wertlos: `indexOf` gibt bei fehlender Stelle -1 zurueck, und -1 ist
      // kleiner als jeder Fund.
      expect(h, contains('if (erlauben != true) return;'));
      expect(h, contains('await b.oeffnen()'));
      expect(h.indexOf('if (erlauben != true) return;'),
          lessThan(h.indexOf('await b.oeffnen()')),
          reason: 'die Wache muss VOR dem Sprung stehen');
    });

    test('🔴 KEIN deutscher Satz im Quelltext des Widgets', () {
      // Die Vorsitzer-App ist deutsch; diese App hat 28 Sprachen. Ein
      // deutscher Satz vor einem Mitglied, das die App auf Arabisch bedient,
      // ist kein Hinweis, sondern ein Raetsel.
      // ⚠️ ALLE DREI Dateien: der Aufbau steht im gemeinsamen Widget, die
      // Texte in den zwei Konfigurationen. Nur eine zu pruefen liesse einen
      // deutschen Satz in den anderen zwei durch.
      for (final q in <String>[widgetQ, gemeinsam, klingelQ]) {
        final texte = RegExp(r"""Text\(\s*'([^']{12,})'""")
            .allMatches(q)
            .map((m) => m[1]!)
            .toList();
        expect(texte, isEmpty,
            reason: 'diese Zeichenketten muessen ueber AppLocalizations '
                'laufen: $texte');
      }
      expect(widgetQ, contains('AppLocalizations.of(context)'));
      expect(klingelQ, contains('AppLocalizations.of(context)'));
      expect(gemeinsam, contains('AppLocalizations.of(context)'));
    });
  });

  group('Alle 28 Sprachen', () {
    test('jede ARB-Datei hat alle elf Schluessel', () {
      final dateien = Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb'))
          .toList();
      expect(dateien.length, 28, reason: 'es sind 28 Sprachen');
      for (final f in dateien) {
        final d = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in kSchluessel) {
          expect(d.containsKey(k), isTrue,
              reason: '${f.path} fehlt $k — der Platz faellt dann auf Deutsch '
                  'zurueck, und das Mitglied liest eine fremde Sprache');
          expect((d[k] as String).trim(), isNotEmpty,
              reason: '${f.path}/$k ist leer');
        }
      }
    });

    test('🔴 keine Sprache hat den DEUTSCHEN Text stehen gelassen', () {
      final de = jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync())
          as Map<String, dynamic>;
      final befunde = <String>[];
      for (final f in Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb') && !f.path.endsWith('_de.arb'))) {
        final d = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in kSchluessel) {
          if (d[k] == de[k]) befunde.add('${f.path}: $k');
        }
      }
      // ⚠️ Das ist der Wächter gegen „28 Dateien angefasst, 21 nur kopiert".
      expect(befunde, isEmpty, reason: 'unuebersetzt geblieben: $befunde');
    });

    test('die generierten Klassen kennen die Schluessel', () {
      // Die Dateien unter lib/l10n/app_localizations*.dart sind COMMITTET.
      // Ohne `flutter gen-l10n` kompiliert das Widget nicht — und der Fehler
      // erschiene erst im Build, nicht hier.
      final basis = File('lib/l10n/app_localizations.dart').readAsStringSync();
      for (final k in kSchluessel) {
        expect(basis, contains('get $k'), reason: '$k nicht generiert');
      }
    });
  });

  group('Android 10 bis 17 — der Weg in die Einstellung', () {
    test('drei Wege, nicht einer', () {
      final kette = nurEinstellweg(mainActivity);
      expect(kette, contains('ACTION_MANAGE_OVERLAY_PERMISSION'));
      expect(kette, contains('ACTION_APPLICATION_DETAILS_SETTINGS'));
      expect('Intent('.allMatches(kette.substring(0, kette.indexOf('for (weg')))
          .length,
          greaterThanOrEqualTo(3),
          reason: 'die Kette braucht drei Versuche');
      expect(kette, contains('catch'));
    });

    test('KEIN resolveActivity davor', () {
      // 🔴 Seit Android 11 filtert die Paket-Sichtbarkeit `resolveActivity`;
      // es kann `null` liefern, obwohl der Start gelingen wuerde — dann
      // haetten wir es gar nicht erst versucht.
      final kette = nurEinstellweg(mainActivity);
      expect(kette, isNot(contains('resolveActivity')));
      expect(kette, isNot(contains('queryIntentActivities')));
    });

    test('das Ergebnis wird nach Dart gemeldet und dort ausgewertet', () {
      expect(vordergrund, contains('Future<bool> systemfensterEinstellung()'));
      // Beide Ausgaenge — der einmalige Hinweis und die dauerhafte Zeile —
      // muessen den Fehlschlag sagen; sie liegen jetzt im gemeinsamen Widget.
      expect('vonHandText'.allMatches(gemeinsam).length,
          greaterThanOrEqualTo(3),
          reason: 'Feld + beide Ausgaenge');
      expect(widgetQ, contains('l.anruffensterVonHand'),
          reason: 'der Text muss von hier kommen');
    });
  });

  group('Manifest', () {
    test('SYSTEM_ALERT_WINDOW ist deklariert', () {
      expect(manifest, contains('android.permission.SYSTEM_ALERT_WINDOW'));
    });

    test('🔴 der googleplay-Flavor entfernt sie NICHT', () {
      // Google Play verlangt fuer sie KEIN Declaration Form und verbietet sie
      // nicht: die Richtlinie nennt sie ausdruecklich als Beispiel fuer eine
      // special permission, die ueber die Systemeinstellungen erteilt wird —
      // genau der Weg dieser App. Anders als REQUEST_INSTALL_PACKAGES, das
      // dort mit tools:node="remove" herausgenommen wird.
      final gp = File('android/app/src/googleplay/AndroidManifest.xml')
          .readAsStringSync();
      expect(gp, isNot(contains('SYSTEM_ALERT_WINDOW')),
          reason: 'im Play-Flavor entfernt, waere das Fenster fuer die '
              'meisten Mitglieder wirkungslos');
      expect(gp, contains('REQUEST_INSTALL_PACKAGES'),
          reason: 'die vorhandene Ausnahme muss stehen bleiben');
    });
  });

  group('Die Optik der Karte — eigene Zeichen statt Framework-Bitmaps', () {
    late String kt;
    late String laeuftSvg;
    late String auflegenSvg;

    setUpAll(() {
      kt = File('android/app/src/main/kotlin/de/icd360s/mitglieder/'
              'AnrufSystemfenster.kt')
          .readAsStringSync();
      laeuftSvg =
          File('android/app/src/main/res/drawable/ic_anruf_laeuft.xml')
              .readAsStringSync();
      auflegenSvg =
          File('android/app/src/main/res/drawable/ic_anruf_auflegen.xml')
              .readAsStringSync();
    });

    test('🔴 das Zeichen fuer VERPASSTEN Anruf ist weg', () {
      // `sym_call_missed` ist ein Pfeil und bedeutet „verpasster Anruf" —
      // auf einem Knopf, der ein LAUFENDES Gespraech beendet, stand also das
      // Zeichen fuer etwas voellig anderes. Das war nicht haesslich, es war
      // falsch.
      expect(kt, isNot(contains('sym_call_missed')));
    });

    test('die Framework-Bitmap ic_menu_call ist weg', () {
      // Eine Ressource aus der Gingerbread-Zeit, als Bitmap ausgeliefert und
      // mit eingebackenem Rand.
      expect(kt, isNot(contains('android.R.drawable.ic_menu_call')));
    });

    test('bauen() nimmt die beiden eigenen Vektoren', () {
      final b = nurBauen(kt);
      expect(b, contains('R.drawable.ic_anruf_laeuft'));
      expect(b, contains('R.drawable.ic_anruf_auflegen'));
      expect(b, isNot(contains('android.R.drawable')),
          reason: 'kein Framework-Zeichen mehr in der Karte');
    });

    test('🔴 der Auflegen-Knopf ist eine ROTE gefuellte Flaeche', () {
      final k = nurAuflegenKnopf(kt);
      expect(k, contains('GradientDrawable.OVAL'),
          reason: 'ohne Flaeche ist es Zierrat, kein Knopf');
      expect(k, contains('#E53935'), reason: 'Material Red 600');
      expect(k, contains('setColorFilter(Color.WHITE)'),
          reason: 'weisses Zeichen auf Rot; ein blasses Rosa auf Rot '
              'verschwindet');
      expect(k, isNot(contains('#FFB4AB')),
          reason: 'die blasse Umriss-Fassung ist weg');
    });

    test('der Knopf hat seinen EIGENEN Zuhoerer', () {
      // Sonst landet der Tipp beim Zieh-Zuhoerer der Reihe: es legt jeder
      // Tipp auf die Karte auf, oder gar keiner.
      expect(nurAuflegenKnopf(kt),
          contains('setOnClickListener { AnrufDienstBruecke.auflegen(app) }'));
    });

    test('der Knopf traegt ein Wort fuer den Bildschirmleser', () {
      expect(nurAuflegenKnopf(kt), contains('contentDescription = auflegen'));
    });

    test('🔴 das Wort kommt UEBERSETZT aus Dart, nicht aus dem Kotlin', () {
      // Diese App gibt es in 28 Sprachen. Ein Literal hier waere eine zweite
      // Uebersetzungsquelle neben den ARB — und deutsch fuer alle.
      expect(kt, isNot(contains('"Auflegen"')));
      expect(nurBauen(kt), isNot(contains('"Hang up"')));
      expect(kt, contains('auflegen: String'),
          reason: 'als Parameter durchgereicht');
    });

    test('die Kette reicht `auflegen` von Dart bis in die Karte', () {
      final karte = File('lib/services/anruf_systemkarte.dart').readAsStringSync();
      final vg = File('lib/services/anruf_vordergrund.dart').readAsStringSync();
      final ma = File('android/app/src/main/kotlin/de/icd360s/mitglieder/'
              'MainActivity.kt')
          .readAsStringSync();
      final dash =
          File('lib/screens/mitglied_dashboard.dart').readAsStringSync();

      expect(dash, contains('auflegen: lFenster.hangUp'),
          reason: 'das Dashboard nimmt den vorhandenen, in allen 28 Sprachen '
              'uebersetzten Schluessel');
      expect(karte, contains('required String auflegen'));
      expect(karte, contains('auflegen: _titelAuflegen'));
      expect(vg, contains('required String auflegen'));
      expect(vg, contains("'auflegen': auflegen"));
      expect(ma, contains('call.argument<String>("auflegen")'));
      expect(nurBauen(kt), contains('contentDescription = auflegen'));
    });

    test('KEINE neue l10n-Schluessel erfunden', () {
      // `hangUp` gibt es laengst und ist in allen 28 Sprachen uebersetzt —
      // ein neuer Schluessel waere 28 handgeschriebene Saetze fuer nichts.
      final de = jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync())
          as Map<String, dynamic>;
      expect(de.containsKey('hangUp'), isTrue);
      expect(de.containsKey('anruffensterAuflegen'), isFalse,
          reason: 'kein Ersatz fuer einen vorhandenen Schluessel');
    });

    test('hangUp ist in allen 28 Sprachen da und nirgends englisch geblieben',
        () {
      final dateien = Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.contains('app_') && f.path.endsWith('.arb'))
          .toList();
      expect(dateien.length, 28);
      final en = (jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync())
          as Map<String, dynamic>)['hangUp'] as String;
      for (final f in dateien) {
        final code = f.path.split('app_').last.replaceAll('.arb', '');
        final wert =
            (jsonDecode(f.readAsStringSync()) as Map<String, dynamic>)['hangUp'];
        expect(wert, isNotNull, reason: '$code hat kein hangUp');
        if (code != 'en') {
          expect(wert, isNot(en), reason: '$code ist englisch geblieben');
        }
      }
    });

    test('die Karte ist deckend genug fuer eine FREMDE App darunter', () {
      final b = nurBauen(kt);
      // Die Karte liegt ueber einer beliebigen App. Bei 90 % Deckung stand
      // weisser Text auf einer hellen Webseite und war nicht zu lesen.
      expect(b, contains('#F2142C17'));
      expect(b, isNot(contains('#E6142C17')));
      expect(b, contains('elevation'),
          reason: 'ohne Schatten wirkt sie wie ein Teil der fremden App');
    });

    test('der Titel bleibt einzeilig', () {
      // Ein langer Titel (28 Sprachen, teils deutlich laenger als das
      // Deutsche) darf die Karte nicht zu einem Block wachsen lassen.
      final b = nurBauen(kt);
      expect(b, contains('maxLines = 1'));
      expect(b, contains('TruncateAt.END'));
    });

    test('die beiden Vektoren sind gueltig und tragen die amtliche Geometrie',
        () {
      // ⚠️ Die XML-Kommentare werden weggeraeumt, BEVOR gesucht wird. Der
      // Kommentar der Datei erklaert, warum dort kein `android:tint` steht —
      // und liess die Zusicherung darunter fehlschlagen, obwohl die Datei
      // richtig war. Dieselbe Falle wie bei den Zeilenkommentaren im Kotlin.
      String ohneXmlKommentare(String q) =>
          q.replaceAll(RegExp(r'<!--.*?-->', dotAll: true), '');
      for (final roh in [laeuftSvg, auflegenSvg]) {
        final svg = ohneXmlKommentare(roh);
        // Material Symbols zeichnen in 960x960 — eine andere Groesse hiesse,
        // die Pfaddaten waeren von Hand veraendert worden.
        expect(svg, contains('android:viewportWidth="960"'));
        expect(svg, contains('android:viewportHeight="960"'));
        expect(svg, contains('android:pathData="M'));
        expect(svg, contains('android:fillColor="#FFFFFFFF"'),
            reason: 'weiss, damit setColorFilter des Aufrufers greift');
        // ⚠️ Kein `android:tint`: die Farbe setzt der Aufrufer, damit dieselbe
        // Datei auch woanders benutzbar bleibt.
        expect(svg, isNot(contains('android:tint')));
      }
      expect(ohneXmlKommentare(laeuftSvg).length, greaterThan(400));
      expect(ohneXmlKommentare(auflegenSvg).length, greaterThan(400));
    });
  });

  group('Dauer und Guete auf der Karte', () {
    late String kt;
    late String karte;
    late String vg;
    late String dienst;

    setUpAll(() {
      kt = File('android/app/src/main/kotlin/de/icd360s/mitglieder/'
              'AnrufSystemfenster.kt')
          .readAsStringSync();
      karte = File('lib/services/anruf_systemkarte.dart').readAsStringSync();
      vg = File('lib/services/anruf_vordergrund.dart').readAsStringSync();
      dienst = File('lib/services/voice_call_service.dart').readAsStringSync();
    });

    test('die Guete kommt aus dem UNTERSCHIED zweier Abfragen', () {
      // Kumulativ genommen zoege eine schlechte erste Minute die Anzeige bis
      // zum Auflegen herunter.
      final b = rumpf(dienst, 'void _gueteFortschreiben(');
      expect(b, contains('empfangen - _letztEmpfangen'));
      expect(b, contains('verloren - _letztVerloren'));
    });

    test('🔴 die ERSTE Abfrage urteilt nicht — sie ist der Nullpunkt', () {
      final b = rumpf(dienst, 'void _gueteFortschreiben(');
      expect(b, contains('if (!_gueteBasisDa)'));
      expect(b.indexOf('_gueteBasisDa = true'),
          lessThan(b.indexOf('anrufGueteStufe(')));
    });

    test('nur die TONSPUR wird bewertet', () {
      // Ein Videoanruf hat zwei inbound-rtp; die Videospur hat ganz andere
      // Paketzahlen als das, was ein Mensch als schlechte Leitung erlebt.
      expect(ohneKommentare(dienst),
          contains("== 'audio'"));
      expect(rumpf(dienst, 'void _startStatsLogging()'),
          contains('_gueteFortschreiben(v)'));
    });

    test('🔴 beim Aufraeumen wird die Guete zurueckgesetzt', () {
      // Sonst truege die Karte des NAECHSTEN Anrufs von der ersten Sekunde an
      // das Urteil des vorigen.
      final b = rumpf(dienst, 'void _stopStatsLogging()');
      expect(b, contains('anrufGuete.value = kGueteUnbekannt'));
      expect(b, contains('_gespraechBeginn = null'));
      expect(b, contains('_gueteBasisDa = false'));
    });

    test('die Startzeit haengt an der EINEN Stelle, die inCall erreichen darf',
        () {
      final o = ohneKommentare(dienst);
      expect('_gespraechBeginn = DateTime.now()'.allMatches(o).length, 1);
      expect(
          o.indexOf('_gespraechBeginn = DateTime.now()'),
          lessThan(o.indexOf('_setCallState(CallState.inCall)')));
    });

    test('🔴 eine schon sichtbare Karte wird nachgefuehrt', () {
      // Wer die App waehrend des Klingelns verlaesst, saehe sonst nie eine
      // Dauer: beim Uebergang zu inCall bleibt `soll` true.
      final b = rumpf(karte, 'void _pruefen()');
      expect(b, contains('_standSenden()'));
      expect(karte, contains('systemfensterStand('));
      expect(vg, contains("invokeMethod('overlayStand'"));
    });

    test('der Kanal spricht nur bei einer Aenderung', () {
      final b = rumpf(karte, 'void _standSenden()');
      expect(b, contains('s == _standStartzeit'));
      expect(b, contains('g == _standGuete'));
    });

    // 🔴 Die Spurkennungen MUESSEN im Vergleich stehen. Bei einem Videoanruf
    // trifft die Spur der Gegenstelle regelmaessig erst ein, nachdem die Karte
    // schon steht (ICE braucht Sekunden) — Dauer und Guete aendern sich dabei
    // nicht zwingend im selben Takt. Fehlen sie hier, bleibt die Videokachel
    // fuer immer leer, und zwar ohne jede Fehlermeldung.
    test('🔴 die Spurkennungen gehoeren MIT in den Aenderungsvergleich', () {
      final b = rumpf(karte, 'void _standSenden()');
      expect(b, contains('f == _standFern'));
      expect(b, contains('e == _standEigen'));
      expect(b, contains('fernSpur: f'));
      expect(b, contains('eigeneSpur: e'));
    });

    test('der Melder wird an- und wieder abgemeldet', () {
      expect(rumpf(karte, 'void aktivieren()'),
          contains('anrufGuete.addListener(_standSenden)'));
      expect(rumpf(karte, 'void abbauen()'),
          contains('anrufGuete.removeListener(_standSenden)'));
    });

    test('der Sekundentakt laeuft im Kotlin, nicht ueber den Kanal', () {
      expect(kt, contains('takt.postDelayed(this, 1000L)'));
      expect(rumpf(karte, 'void _standSenden()'),
          isNot(contains('Timer')));
    });

    test('🔴 der Takt wird beim Verbergen gestoppt', () {
      final b = nurBlock(kt, 'fun verbergen()');
      expect(b, contains('taktStoppen()'));
      expect(b, contains('dauerSicht = null'));
    });

    test('der Name der App kommt vom SYSTEM, nicht aus den ARB', () {
      expect(nurBauen(kt), contains('applicationInfo.loadLabel'));
      final de = jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync())
          as Map<String, dynamic>;
      expect(de.containsKey('anruffensterAppName'), isFalse,
          reason: 'kein 29. Uebersetzungsstring fuer etwas, das Android weiss');
    });

    test('🔴 der Titel hat eine feste Hoechstbreite', () {
      // WRAP_CONTENT + FLAG_LAYOUT_NO_LIMITS heisst: das Fenster darf ueber den
      // Schirmrand hinauswachsen. Ohne maxWidth greift die Ellipse nie, und ein
      // langer Titel schiebt den Auflegen-Knopf aus dem Bild.
      final b = nurBauen(kt);
      expect(b, contains('val breite = dp(app, 190)'));
      expect('maxWidth = breite'.allMatches(b).length, 2);
      expect(kt, contains('FLAG_LAYOUT_NO_LIMITS'));
    });

    test('ohne stehendes Gespraech steht dort KEINE Dauer', () {
      // „00:00", waehrend es noch klingelt, waere eine Aussage ueber ein
      // Gespraech, das noch nicht laeuft.
      final b = nurBlock(kt, 'private fun dauerText(');
      expect(b, contains('if (start <= 0L) return ""'));
    });

    test('🔴 Stufe 0 blendet die Balken GANZ aus', () {
      // „noch nichts gemessen" darf nie aussehen wie „schlecht".
      final b = nurBlock(kt, 'private fun balkenSetzen()');
      expect(b, contains('if (gueteStufe <= 0) { b.visibility = View.GONE; return }'));
    });

    test('MainActivity reicht beide Werte durch', () {
      final ma = File('android/app/src/main/kotlin/de/icd360s/mitglieder/'
              'MainActivity.kt')
          .readAsStringSync();
      expect(ma, contains('"overlayStand"'));
      expect('call.argument<Number>("startzeit")'.allMatches(ma).length, 2);
      expect('call.argument<Number>("guete")'.allMatches(ma).length, 2);
    });
  });

  group('anrufGueteStufe — die Regel selbst', () {
    test('saubere Leitung ist gut', () {
      expect(anrufGueteStufe(dEmpfangen: 150, dVerloren: 0, jitterMs: 5),
          kGueteGut);
    });

    test('2 % Verlust ist mittel, 8 % ist schlecht', () {
      expect(anrufGueteStufe(dEmpfangen: 147, dVerloren: 3, jitterMs: 5),
          kGueteMittel);
      expect(anrufGueteStufe(dEmpfangen: 138, dVerloren: 12, jitterMs: 5),
          kGueteSchlecht);
    });

    test('hoher Jitter allein reicht fuer schlecht', () {
      expect(anrufGueteStufe(dEmpfangen: 150, dVerloren: 0, jitterMs: 80),
          kGueteSchlecht);
    });

    test('🔴 ein leeres Fenster ist UNBEKANNT, nicht schlecht', () {
      expect(anrufGueteStufe(dEmpfangen: 0, dVerloren: 0, jitterMs: 0),
          kGueteUnbekannt);
      expect(anrufGueteStufe(dEmpfangen: 5, dVerloren: 0, jitterMs: 0),
          kGueteUnbekannt);
    });

    test('🔴 eine grosse Nachverrechnung macht ein gutes Fenster nicht blind',
        () {
      // RFC 3550 verrechnet verspaetet eingetroffene Pakete nachtraeglich,
      // `packetsLost` DARF also sinken.
      //
      // ⚠️ Die erste Fassung dieser Zusicherung nahm -4 und war damit WERTLOS:
      // ungeklemmt ergibt das -4/146 = -2,7 %, und das ist ebenfalls „gut".
      // Der Fall, in dem das Klemmen wirklich etwas traegt, ist eine grosse
      // Korrektur: ohne sie schrumpft die Summe unter die Mindestzahl, und
      // ein Fenster mit 100 sauber angekommenen Paketen saehe aus wie
      // „nichts gemessen" — die Balken verschwaenden mitten im Gespraech.
      expect(anrufGueteStufe(dEmpfangen: 100, dVerloren: -95, jitterMs: 5),
          kGueteGut);
    });

    test('ein Fenster NUR aus Verlusten ist schlecht, nicht unbekannt', () {
      expect(anrufGueteStufe(dEmpfangen: 0, dVerloren: 60, jitterMs: 0),
          kGueteSchlecht);
    });
  });

  // ---------------------------------------------------------------------
  // Die Videokachel im Systemfenster.
  //
  // 🔴 Auftrag: „cand sunt cu video si ies din aplicatie ar trebui sa se vada
  // camera" — gewaehlt wurde die Kamera DER GEGENSTELLE, dazu ein Knopf, der
  // zwischen ihr und der eigenen umschaltet.
  //
  // Ein laufender Videoanruf mit Wechsel in eine fremde App ist von einem Test
  // aus nicht herstellbar; geprueft wird deshalb der Quelltext, und jede
  // Zusicherung ist gegengeprobt.
  group('Videokachel und Umschaltknopf', () {
    late String kt;
    late String ma;
    late String karte;
    late String vg;
    late String dienst;
    late String dash;

    // ⚠️ Im `setUpAll`, nicht im Rumpf von `group`: die Helfer benutzen
    // `expect`, und das wirft dort `OutsideTestException`.
    setUpAll(() {
      kt = ohneKommentare(File(
              'android/app/src/main/kotlin/de/icd360s/mitglieder/'
              'AnrufSystemfenster.kt')
          .readAsStringSync());
      ma = ohneKommentare(File(
              'android/app/src/main/kotlin/de/icd360s/mitglieder/'
              'MainActivity.kt')
          .readAsStringSync());
      karte = ohneKommentare(
          File('lib/services/anruf_systemkarte.dart').readAsStringSync());
      vg = ohneKommentare(
          File('lib/services/anruf_vordergrund.dart').readAsStringSync());
      dienst = ohneKommentare(
          File('lib/services/voice_call_service.dart').readAsStringSync());
      dash = ohneKommentare(
          File('lib/screens/mitglied_dashboard.dart').readAsStringSync());
    });

    test('🔴 NUR die Spurkennung geht ueber den Kanal, nie die Spur', () {
      // Eine `MediaStreamTrack` laesst sich nicht durch einen Method-Channel
      // schicken; die native Seite holt sie beim WebRTC-Plugin.
      final b = rumpf(vg, 'static Future<void> systemfensterZeigen({');
      expect(b, contains("'fernSpur': fernSpur"));
      expect(b, contains("'eigeneSpur': eigeneSpur"));
      expect(b, isNot(contains('MediaStreamTrack')));
    });

    test('die Kennungen kommen aus dem Anrufdienst', () {
      // ⚠️ Mit der schliessenden Klammer: `fernVideoSpurXX` enthaelt
      // `fernVideoSpur`, eine Umbenennung waere sonst unbemerkt durchgegangen.
      expect(dienst, contains('String get fernVideoSpur {'));
      expect(dienst, contains('String get eigeneVideoSpur {'));
      expect(rumpf(dienst, 'String get fernVideoSpur'),
          contains('_remoteStream?.getVideoTracks()'));
      expect(rumpf(dienst, 'String get eigeneVideoSpur'),
          contains('_localStream?.getVideoTracks()'));
    });

    // 🔴 Bei abgeschalteter Kamera gibt es die Spur noch, sie liefert aber kein
    // Bild. Ein Umschaltknopf, der auf eine schwarze Flaeche fuehrt, sieht aus
    // wie ein Fehler — deshalb ist die eigene Kennung dann LEER, und der Knopf
    // verschwindet von selbst.
    test('🔴 abgeschaltete Kamera liefert eine LEERE eigene Kennung', () {
      final b = rumpf(dienst, 'String get eigeneVideoSpur');
      final i = b.indexOf('_isCameraOff');
      final j = b.indexOf('_localStream');
      expect(i, greaterThanOrEqualTo(0), reason: 'die Pruefung fehlt ganz');
      expect(j, greaterThan(i),
          reason: 'die Pruefung muss VOR dem Lesen der Spur stehen');
    });

    test('MainActivity reicht beide Kennungen durch', () {
      final z = nurBlock(ma, '"overlayZeigen" ->');
      expect(z, contains('call.argument<String>("fernSpur")'));
      expect(z, contains('call.argument<String>("eigeneSpur")'));
      final s = nurBlock(ma, '"overlayStand" ->');
      expect(s, contains('call.argument<String>("fernSpur")'));
      expect(s, contains('call.argument<String>("eigeneSpur")'));
    });

    // 🔴 Die wichtigste Zusicherung der Gruppe. Die Spur der Gegenstelle trifft
    // regelmaessig erst ein, NACHDEM die Karte schon steht (ICE braucht
    // Sekunden). Nimmt `stand()` sie nicht mit, bleibt die Kachel fuer immer
    // leer — und nichts schlaegt fehl.
    test('🔴 stand() nimmt die Kennungen mit und bindet neu', () {
      expect(
          kt,
          contains('fun stand(startzeit: Long, guete: Int, '
              'fernSpur: String, eigeneSpur: String)'));
      final b = nurBlock(kt, 'fun stand(startzeit: Long');
      expect(b, contains('fernSpurId = fernSpur'));
      expect(b, contains('eigeneSpurId = eigeneSpur'));
      expect(b, contains('spurAuffrischen()'));
    });

    // ⚠️ Zwei verschiedene Wege: die eigene Spur kennt das Plugin als
    // `LocalTrack` (Huelle mit dem oeffentlichen Feld `track`), die der
    // Gegenstelle als `MediaStreamTrack`. Wer beide gleich behandelt, bekommt
    // fuer eine von ihnen immer null — und die Kachel bliebe leer.
    test('🔴 eigene Spur ueber getLocalTrack().track, fremde ueber getRemoteTrack',
        () {
      final b = nurBlock(kt, 'private fun spurHolen(');
      expect(b, contains('getLocalTrack(id)?.track'));
      expect(b, contains('getRemoteTrack(id)'));
      expect(b, contains('as? VideoTrack'),
          reason: 'eine Tonspur darf nicht in den Renderer wandern');
    });

    // 🔴 `sharedSingleton` wird von JEDER neuen Plugin-Instanz ueberschrieben,
    // und diese App hat mehrere Flutter-Engines. Loest sich eine, ist ihr
    // `methodCallHandler` null — der Zeiger aber nicht, `?.` hilft also nicht.
    // In der Vorsitzer-App war das am 31.08.2026 ein NullPointer im Gespraech.
    test('🔴 gemerkte Plugin-Instanz zuerst, sharedSingleton nur als Rueckfall',
        () {
      final b = nurBlock(kt, 'private fun spurHolen(');
      expect(b, contains('webrtcPlugin ?: FlutterWebRTCPlugin.sharedSingleton'));
      expect(b, contains('catch'),
          reason: 'ein NullPointer AUS dem Plugin darf nichts umbringen');
      expect(
          ma,
          contains('AnrufSystemfenster.webrtcPlugin = '
              'FlutterWebRTCPlugin.sharedSingleton'));
    });

    // 🔴 Drei Zustaende, nicht zwei: „zeigt die Gegenstelle", „zeigt die eigene
    // Kamera" und „hat gar kein Bild". Der dritte ist am Anfang eines
    // Gespraechs der Normalfall und muss UNSICHTBAR bleiben — ein schwarzes
    // Rechteck ueber einer fremden App sieht wie ein Defekt aus.
    test('🔴 ohne gebundene Spur bleibt die Kachel unsichtbar, nicht schwarz',
        () {
      final b = nurBlock(kt, 'private fun spurAuffrischen()');
      // ⚠️ GEZAEHLT, nicht `contains`: es gibt DREI Ausgaenge ohne Bild —
      // keine Kennung, Spur noch nicht bei uns, `addSink` gescheitert. Ein
      // blosses `contains` blieb gruen, wenn zwei davon die Kachel stehen
      // liessen, weil der dritte sie versteckt.
      expect(RegExp(r'kachel\.visibility = View\.GONE').allMatches(b).length, 3,
          reason: 'jeder Ausgang ohne Bild muss die Kachel verstecken');
      expect(b, contains('kachel.visibility = View.VISIBLE'));
      // ⚠️ Auf die KACHEL eingegrenzt: der Umschaltknopf in derselben
      // Funktion hat ebenfalls ein `visibility = View.GONE`, und darueber war
      // die Zusicherung gruen, obwohl die Kachel sichtbar startete.
      expect(nurBlock(kt, 'val kachel = FrameLayout(app).apply'),
          contains('visibility = View.GONE'),
          reason: 'sie startet unsichtbar');
    });

    test('🔴 der Umschaltknopf erscheint nur, wenn es ZWEI Bilder gibt', () {
      final b = nurBlock(kt, 'private fun spurAuffrischen()');
      expect(
          b,
          contains('if (fernSpurId.isNotEmpty() && '
              'eigeneSpurId.isNotEmpty()) View.VISIBLE'));
    });

    // Faellt die gewaehlte Seite weg (Kamera aus, Gegenstelle stellt Video ab),
    // wird auf die andere gewechselt statt schwarz zu bleiben.
    test('🔴 faellt die gezeigte Seite weg, wird die andere genommen', () {
      final b = nurBlock(kt, 'private fun spurAuffrischen()');
      expect(b, contains('if (eigene && eigeneSpurId.isEmpty()) eigene = false'));
      expect(
          b,
          contains('if (!eigene && fernSpurId.isEmpty() && '
              'eigeneSpurId.isNotEmpty()) eigene = true'));
    });

    test('die Gegenstelle ist die Vorgabe, nicht die eigene Kamera', () {
      expect(nurBlock(kt, 'fun zeigen('), contains('zeigtEigene = false'));
    });

    // ⚠️ Eigener Zuhoerer, sonst landet der Tipp beim Zieh-Zuhoerer der Karte —
    // dasselbe wie beim Auflegen-Knopf.
    test('der Umschaltknopf hat seinen EIGENEN Zuhoerer', () {
      final b = nurBlock(kt, 'private fun kachelBauen(');
      final a = b.indexOf('R.drawable.ic_anruf_kamera_wechseln');
      expect(a, greaterThan(0), reason: 'der Knopf fehlt ganz');
      final e = b.indexOf('\n        }', a);
      final knopf = b.substring(a, e > a ? e : b.length);
      expect(knopf, contains('setOnClickListener { umschalten() }'));
      expect(knopf, contains('contentDescription = wechselText'),
          reason: 'sonst liest der Bildschirmleser '
              '„nicht benannte Schaltflaeche"');
    });

    // Auf eine Seite umzuschalten, die es nicht gibt, hiesse ein schwarzes Bild
    // zu zeigen.
    test('🔴 umschalten() tut nichts, wenn die andere Seite fehlt', () {
      expect(nurBlock(kt, 'private fun umschalten()'),
          contains('if (id.isEmpty()) return'));
    });

    // ⚠️ Die Beschriftung kommt aus Dart. Eine `values-xx/strings.xml` waere
    // eine ZWEITE Uebersetzungsquelle neben den 28 ARB-Dateien, und beide
    // liefen beim ersten geaenderten Wort auseinander.
    test('🔴 die Beschriftung des Knopfes kommt uebersetzt aus Dart', () {
      expect(karte, contains('required String wechseln'));
      expect(karte, contains('_titelWechseln = wechseln'));
      expect(karte, contains('wechseln: _titelWechseln'));
      expect(vg, contains("'wechseln': wechseln"));
      expect(dash, contains('wechseln: lFenster.anruffensterBildWechseln'));
      // ⚠️ NICHT „es gibt keine values-xx/" — die gibt es, und zwar
      // berechtigt: die Beschreibung des Fernwartungs-Dienstes MUSS eine
      // Android-Ressource sein, weil das System sie selbst anzeigt. Geprueft
      // wird deshalb, dass dort nichts vom Anruffenster steht.
      final ressourcen = Directory('android/app/src/main/res')
          .listSync()
          .whereType<Directory>()
          // ⚠️ `$` als Anker, nicht `\$`: letzteres verlangte ein echtes
          // Dollarzeichen im Pfad, und `values/` (die deutsche Vorgabe) faellt
          // dann stillschweigend aus der Pruefung.
          .where((d) => d.path.contains(RegExp(r'/values(-|$)')))
          .expand((d) => d.listSync().whereType<File>())
          .where((f) => f.path.endsWith('.xml'));
      for (final f in ressourcen) {
        final x = f.readAsStringSync().toLowerCase();
        expect(x, isNot(contains('anruffenster')),
            reason: '${f.path} ist eine zweite Uebersetzungsquelle');
        expect(x, isNot(contains('wechseln')),
            reason: '${f.path} ist eine zweite Uebersetzungsquelle');
      }
    });

    test('der Wechseltext steht VOR dem Bauen der Kachel', () {
      final b = nurBlock(kt, 'fun zeigen(');
      final i = b.indexOf('wechselText = wechseln');
      final j = b.indexOf('bauen(app, video');
      expect(i, greaterThanOrEqualTo(0), reason: 'nie gesetzt');
      expect(j, greaterThan(i),
          reason: 'sonst traegt der Knopf eine leere Beschreibung');
    });

    // ⚠️ `release()` wartet auf den Zeichen-Thread. Stuende die Ansicht dann
    // noch im Fenster, zeichnete sie in eine Oberflaeche, die es nicht mehr
    // gibt.
    test('🔴 Verbergen: erst Spur loesen, dann Fenster ab, dann Renderer frei',
        () {
      final b = nurBlock(kt, 'fun verbergen()');
      final a = b.indexOf('spurLoesen()');
      final c = b.indexOf('removeView');
      final d = b.indexOf('kachelAufraeumen()');
      expect(a, greaterThanOrEqualTo(0), reason: 'die Spur bleibt haengen');
      expect(c, greaterThan(a), reason: 'Spur zuerst abhaengen');
      expect(d, greaterThan(c), reason: 'Renderer erst nach removeView');
    });

    // Schlug `addView` fehl, gibt es eine Kachel ohne Fenster — und die haelt
    // einen EGL-Kontext bis zum Prozessende.
    test('🔴 ein abgelehntes Fenster laesst keinen Renderer liegen', () {
      final b = nurBlock(kt, 'fun zeigen(');
      final i = b.indexOf('addView abgelehnt');
      expect(i, greaterThan(0), reason: 'der Fang fehlt');
      // ⚠️ Bis zum Ende des Fang-Blocks, nicht „die naechsten 400 Zeichen":
      // ein festes Fenster haengt an der Laenge des Textes davor und trifft
      // beim naechsten Umbau daneben.
      final e = b.indexOf('\n        }', i);
      expect(e, greaterThan(i), reason: 'Fang-Block nicht geschlossen');
      expect(b.substring(i, e), contains('kachelAufraeumen()'));
    });

    // ⚠️ Mit `setZOrderOnTop(true)` liegt die Oberflaeche UEBER dem Fenster,
    // und der Umschaltknopf darueber waere unsichtbar. In der Vorgabe liegt sie
    // darunter und das Fenster stanzt ein Loch.
    test('🔴 KEIN setZOrderOnTop', () {
      expect(kt, isNot(contains('setZOrderOnTop')));
    });

    test('SCALE_ASPECT_FIT, nicht FILL', () {
      final b = nurBlock(kt, 'private fun kachelBauen(');
      expect(b, contains('SCALE_ASPECT_FIT'));
      expect(b, isNot(contains('SCALE_ASPECT_FILL')),
          reason: 'ein zugeschnittenes Gesicht ist schlimmer als ein Rand');
    });

    // Die eigene Kamera wird gespiegelt wie auf jedem Selfie-Schirm, das Bild
    // der Gegenstelle NICHT — sie soll so aussehen, wie sie aussieht.
    test('nur das eigene Bild wird gespiegelt', () {
      expect(nurBlock(kt, 'private fun spurAuffrischen()'),
          contains('r.setMirror(eigene)'));
    });

    test('die Kachel entsteht nur bei einem VIDEO-Anruf', () {
      expect(nurBauen(kt), contains('if (video) kachelBauen(app) else null'));
    });

    // Ohne Kachel bleibt die Karte genau die Pille von PR #399/#401 — mit
    // Kachel traegt die Wurzel den Hintergrund, sonst lagen zwei uebereinander.
    test('🔴 der Hintergrund haengt daran, ob eine Kachel darueber sitzt', () {
      final b = nurBauen(kt);
      expect(b,
          contains('background = if (kachel != null) null else GradientDrawable()'));
      expect(b, contains('if (kachel == null) return reihe'));
    });
  });

  group('Die WebRTC-Fassung', () {
    // ⚠️ Das App-Modul bindet die AAR `compileOnly` ein, geladen wird zur
    // Laufzeit die von `flutter_webrtc`. Laufen die beiden auseinander, faellt
    // es beim Bauen NICHT auf — es erscheint erst auf dem Geraet als
    // `NoSuchMethodError` mitten im Gespraech.
    test('🔴 App-Modul und flutter_webrtc uebersetzen gegen dieselbe AAR', () {
      final app = File('android/app/build.gradle.kts').readAsStringSync();
      final meine = RegExp(r'io\.github\.webrtc-sdk:android:([0-9.]+)')
          .firstMatch(app)
          ?.group(1);
      expect(meine, isNotNull, reason: 'compileOnly-Zeile fehlt im App-Modul');

      // Den Pfad aus der Sperrdatei holen, damit eine Aktualisierung von
      // flutter_webrtc auffaellt statt an einer festen Zahl vorbeizulaufen.
      final lock = File('pubspec.lock').readAsStringSync();
      // `[^"]+`, nicht nur Ziffern: flutter_webrtc heisst auch mal
      // `1.6.2+hotfix.2` — daran lief dieser Test ab #426 ins Leere.
      final v = RegExp(r'flutter_webrtc:[\s\S]{0,400}?version: "([^"]+)"')
          .firstMatch(lock)
          ?.group(1);
      expect(v, isNotNull, reason: 'flutter_webrtc steht nicht in pubspec.lock');

      final heim = Platform.environment['PUB_CACHE'] ??
          '${Platform.environment['HOME']}/.pub-cache';
      final gradle =
          File('$heim/hosted/pub.dev/flutter_webrtc-$v/android/build.gradle');
      if (!gradle.existsSync()) {
        // Auf einem Rechner ohne warmen Paketspeicher gibt es die Datei nicht.
        // Kein Grund fuer rot — aber sagen muss man es.
        markTestSkipped('flutter_webrtc-$v nicht im Paketspeicher');
        return;
      }
      final seine = RegExp(r'io\.github\.webrtc-sdk:android:([0-9.]+)')
          .firstMatch(gradle.readAsStringSync())
          ?.group(1);
      expect(meine, seine,
          reason: 'App-Modul uebersetzt gegen $meine, geladen wird $seine');
    });
  });
}
