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

/// Die zehn Schluessel dieser Funktion.
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

void main() {
  late String karte;
  late String dashboard;
  late String widgetQ;
  late String konto;
  late String vordergrund;
  late String mainActivity;
  late String manifest;

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
      final l = rumpf(widgetQ, 'void didChangeAppLifecycleState(');
      expect(l, contains('AppLifecycleState.resumed'));
      expect(l, contains('_lesen()'));
    });

    test('der Knopf bleibt auch bei erteilter Berechtigung', () {
      final b = rumpf(widgetQ, 'Widget build(BuildContext context)');
      expect(b, contains('onPressed: _oeffnen'));
      final knopf = b.substring(b.indexOf('TextButton('));
      expect(knopf.substring(0, knopf.indexOf('child:')),
          isNot(contains('erlaubt')),
          reason: 'der Knopf selbst darf nicht am Zustand haengen');
      final o = rumpf(widgetQ, 'Future<void> _oeffnen()');
      expect(o, contains('systemfensterEinstellung()'));
      expect(o, contains('anruffensterVonHand'));
    });

    test('drei Zustaende, und „wird geladen" ist keiner von beiden', () {
      final b = rumpf(widgetQ, 'Widget build(BuildContext context)');
      expect(b, contains('erlaubt == null'),
          reason: 'null heisst „noch nicht gelesen", nicht „nicht erteilt"');
      expect(b, contains('anruffensterErteilt'));
      expect(b, contains('anruffensterNichtErteilt'));
    });

    test('die Einstellung wird nur auf Wunsch geoeffnet', () {
      final h = rumpf(widgetQ, 'Future<void> anruffensterHinweisZeigen(');
      expect(h, contains('if (erlauben != true) return;'));
      expect(h.indexOf('if (erlauben != true) return;'),
          lessThan(h.indexOf('systemfensterEinstellung()')),
          reason: 'die Wache muss VOR dem Sprung stehen');
    });

    test('🔴 KEIN deutscher Satz im Quelltext des Widgets', () {
      // Die Vorsitzer-App ist deutsch; diese App hat 28 Sprachen. Ein
      // deutscher Satz vor einem Mitglied, das die App auf Arabisch bedient,
      // ist kein Hinweis, sondern ein Raetsel.
      final texte = RegExp(r"""Text\(\s*'([^']{12,})'""")
          .allMatches(widgetQ)
          .map((m) => m[1]!)
          .toList();
      expect(texte, isEmpty,
          reason: 'diese Zeichenketten muessen ueber AppLocalizations laufen: '
              '$texte');
      expect(widgetQ, contains('AppLocalizations.of(context)'));
    });
  });

  group('Alle 28 Sprachen', () {
    test('jede ARB-Datei hat alle zehn Schluessel', () {
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
      expect('anruffensterVonHand'.allMatches(widgetQ).length,
          greaterThanOrEqualTo(2),
          reason: 'beide Ausgaenge muessen den Fehlschlag sagen');
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
}
