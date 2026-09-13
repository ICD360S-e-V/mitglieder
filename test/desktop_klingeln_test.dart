// Klingeln und Erreichbarkeit auf Windows, Linux und macOS.
//
// 🔴 AUF DEM RECHNER HOERTE DER ANGERUFENE NICHTS. `_updateRingSound` rief bei
// `ringing` auf JEDER Plattform `FlutterRingtonePlayer().playRingtone(...)` —
// aber jenes Paket erklaert in seiner pubspec nur `android` und `ios`. Auf dem
// Desktop warf der Aufruf eine `MissingPluginException`, der Fang darunter
// verschluckte sie, und es klingelte einfach nicht. Der ANRUFER hoerte sein
// Freizeichen, weil das ueber just_audio laeuft (in main.dart fuer Windows und
// Linux durch media_kit geleitet); wer gerufen wurde, sass in der Stille.
//
// ⚠️ Ueber den Sperrbildschirm von Windows darf keine App zeichnen — nur
// Meldungen erscheinen dort. Der tragende Teil ist deshalb das Fenster: es wird
// UEBER alle anderen gehoben. Windows laesst den Vordergrund nicht an sich
// reissen, solange der Mensch in einem anderen Fenster arbeitet, aber
// `setAlwaysOnTop` ist eine Fenster-Eigenschaft und keine Uebernahme.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String ohneKommentare(String q) => q
    .replaceAllMapped(RegExp(r'/\*.*?\*/', dotAll: true),
        (m) => m[0]!.replaceAll(RegExp(r'[^\n]'), ' '))
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i) + ' ' * (z.length - i);
    })
    .join('\n');

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
  var t = 0;
  while (i < quelle.length) {
    if (quelle[i] == '{') t++;
    if (quelle[i] == '}') {
      t--;
      if (t == 0) return quelle.substring(ab, i + 1);
    }
    i++;
  }
  fail('Rumpf nicht geschlossen: $kopf');
}

void vorher(String q, String erst, String dann, {String? reason}) {
  expect(q, contains(erst), reason: 'fehlt ganz: $erst');
  expect(q, contains(dann), reason: 'fehlt ganz: $dann');
  expect(q.indexOf(erst), lessThan(q.indexOf(dann)), reason: reason);
}

const _kAutostart = <String>[
  'autostartTitel',
  'autostartZweck',
  'autostartAn',
  'autostartAus',
  'autostartFehlgeschlagen',
  'autostartFlatpak',
];

void main() {
  late String dienst;
  late String desktop;
  late String autostart;
  late String zeile;

  setUpAll(() {
    dienst = ohneKommentare(
        File('lib/services/voice_call_service.dart').readAsStringSync());
    desktop = ohneKommentare(
        File('lib/services/anruf_desktop.dart').readAsStringSync());
    autostart = ohneKommentare(
        File('lib/services/autostart_desktop.dart').readAsStringSync());
    zeile = ohneKommentare(
        File('lib/widgets/autostart_zeile.dart').readAsStringSync());
  });

  group('🔴 Es klingelt jetzt auch auf dem Rechner', () {
    test('der Systemklingelton wird dort NICHT mehr versucht', () {
      final r = rumpf(dienst, 'void _updateRingSound(CallState state)');
      final i = r.indexOf('if (state == CallState.ringing)');
      final zweig = r.substring(i, r.indexOf('} else if', i));
      expect(zweig, contains('if (AnrufDesktop.verfuegbar) {'),
          reason: 'ohne die Wache laeuft der Aufruf weiter ins Leere');
      // Der Systemklingelton darf nur im ANDEREN Zweig stehen.
      vorher(zweig, 'AnrufDesktop.verfuegbar', 'FlutterRingtonePlayer()',
          reason: 'der Systemklingelton gehoert in den else-Zweig');
      expect(zweig, contains('_klingelSpielen()'));
    });

    test('der Ton laeuft IN SCHLEIFE und voll aufgedreht', () {
      final k = rumpf(dienst, 'Future<void> _klingelSpielen()');
      expect(k, contains('LoopMode.one'),
          reason: 'ein Anruf muss klingeln, bis jemand abnimmt');
      expect(k, contains('setVolume(1.0)'),
          reason: 'das ist der Ton fuer den GERUFENEN, nicht das leise '
              'Freizeichen des Anrufers');
      expect(k, contains("setAsset('assets/sounds/ringback.wav')"));
    });

    test('der mitgelieferte Ton liegt wirklich da und ist verwendbar', () {
      final f = File('assets/sounds/ringback.wav');
      expect(f.existsSync(), isTrue);
      expect(f.lengthSync(), greaterThan(1000));
      // ⚠️ Assets werden ueber den Ordner `assets/sounds/` eingebunden — ohne
      // den Eintrag in der pubspec findet `setAsset` nichts, und zwar zur
      // LAUFZEIT.
      expect(File('pubspec.yaml').readAsStringSync(),
          contains('- assets/sounds/'));
    });

    test('eigener Spieler, und er wird freigegeben', () {
      // Ein gemeinsamer Spieler mit dem Freizeichen hiesse, dass ein
      // Aufraeumen des einen den anderen mitnimmt.
      expect(dienst, contains('AudioPlayer? _klingelPlayer;'));
      expect(dienst, contains('_klingelPlayer?.dispose();'),
          reason: 'sonst bleibt ein Spieler bis zum Prozessende liegen');
    });

    test('jeder andere Zustand stoppt den Ton und gibt das Fenster frei', () {
      final r = rumpf(dienst, 'void _updateRingSound(CallState state)');
      expect('_klingelStoppen()'.allMatches(r).length, greaterThanOrEqualTo(2),
          reason: 'calling UND der else-Zweig');
      expect('AnrufDesktop.klingelnAus()'.allMatches(r).length,
          greaterThanOrEqualTo(2));
    });
  });

  group('Das Fenster ist der tragende Teil, nicht die Meldung', () {
    test('🔴 setAlwaysOnTop steht VOR focus, in eigenem Fang', () {
      // Stuende es dahinter, nähme ein Fehlschlag des unwichtigen Teils
      // (Windows verweigert den Fokus regelmaessig) den wichtigen mit.
      final an = rumpf(desktop, 'static Future<void> klingelnAn()');
      vorher(an, 'setAlwaysOnTop(true)', 'windowManager.focus()',
          reason: 'die Reihenfolge ist die Sache');
      expect('try {'.allMatches(an).length, greaterThanOrEqualTo(3),
          reason: 'getrennte Faenge: jeder Schritt darf fuer sich gelingen');
    });

    test('⚠️ KEIN Vollbild', () {
      // Es naehme dem Mitglied den ganzen Bildschirm, und ein Vollbild, das man
      // nicht mehr verlaesst, ist schlimmer als ein uebersehener Anruf.
      expect(desktop, isNot(contains('setFullScreen')));
    });

    test('gibt nur frei, was wir selbst gesetzt haben', () {
      // Sonst nähme das Ende eines Anrufs dem Mitglied ein „immer im
      // Vordergrund", das es selbst gewaehlt hat.
      final aus = rumpf(desktop, 'static Future<void> klingelnAus()');
      expect(aus, contains('if (!_vonUnsObenGehalten) return;'));
      expect(aus, contains('setAlwaysOnTop(false)'));
    });

    test('nur auf dem Rechner', () {
      expect(desktop, contains('Platform.isWindows'));
      expect(desktop, contains('Platform.isLinux'));
      expect(desktop, contains('Platform.isMacOS'));
      final an = rumpf(desktop, 'static Future<void> klingelnAn()');
      expect(an, contains('if (!verfuegbar) return;'));
    });
  });

  group('Beim Anmelden starten', () {
    test('absoluter Pfad, nicht der Startbefehl', () {
      // `Platform.executable` kann relativ sein; in einem Autostart-Eintrag
      // muss ein absoluter Pfad stehen.
      expect(autostart, contains('Platform.resolvedExecutable'));
      expect(autostart, isNot(contains('Platform.executable,')));
    });

    test('🔴 im Flatpak wird der Schalter GAR NICHT angeboten', () {
      // Der Sandkasten hat kein Verzeichnis dafuer, und der Pfad gilt nur
      // innerhalb. Ein Schalter, der dort nichts bewirkt, waere eine Luege.
      expect(autostart, contains("Platform.environment['FLATPAK_ID']"));
      expect(autostart, contains('moeglich => verfuegbar && !imFlatpak'));
      expect(zeile, contains('AutostartDesktop.imFlatpak'));
      expect(zeile, contains('autostartFlatpak'));
    });

    test('🔴 der Zustand wird NACHGELESEN, nicht behauptet', () {
      // Ein Schalter, der umspringt, obwohl im Register nichts stand, ist
      // genau die stille Luege, die dieses Projekt zweimal eingesammelt hat.
      final s = rumpf(autostart, 'static Future<bool?> setzen(bool an)');
      vorher(s, 'launchAtStartup.enable()', 'launchAtStartup.isEnabled()',
          reason: 'erst setzen, dann nachlesen');
      expect(s, contains('return await launchAtStartup.isEnabled();'));
      final u = rumpf(zeile, 'Future<void> _umlegen(bool gewuenscht)');
      expect(u, contains('_an = jetzt'),
          reason: 'der Schalter zeigt, was danach WIRKLICH gilt');
      expect(u, isNot(contains('_an = gewuenscht')));
    });

    test('drei Zustaende — null heisst nicht „aus"', () {
      expect(autostart, contains('Future<bool?> istAn()'));
      expect(zeile, contains('_an == null'));
      expect(zeile, contains('l.welcomeLoading'));
    });

    test('⚠️ nie von selbst eingeschaltet', () {
      // Eine App, die sich ohne Zutun in den Autostart eintraegt, ist eine
      // Zumutung — auch wenn sie es gut meint.
      expect('setzen('.allMatches(zeile).length, 1,
          reason: 'genau EIN Aufrufer: der Schalter');
      final u = rumpf(zeile, 'Future<void> _umlegen(bool gewuenscht)');
      expect(u, contains('AutostartDesktop.setzen(gewuenscht)'));
      // Nirgends sonst im Baum.
      final andere = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => !f.path.endsWith('autostart_zeile.dart'))
          .where((f) => !f.path.endsWith('autostart_desktop.dart'))
          .where((f) => f.readAsStringSync().contains('AutostartDesktop.setzen'))
          .map((f) => f.path)
          .toList();
      expect(andere, isEmpty, reason: 'kein anderer darf ihn umlegen: $andere');
    });

    test('ein Fehlschlag wird GESAGT', () {
      final u = rumpf(zeile, 'Future<void> _umlegen(bool gewuenscht)');
      expect(u, contains('if (jetzt == gewuenscht) return;'));
      expect(u, contains('autostartFehlgeschlagen'));
    });
  });

  group('Alle 28 Sprachen', () {
    test('jede ARB-Datei hat die sechs Schluessel', () {
      final dateien = Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb'))
          .toList();
      expect(dateien.length, 28);
      for (final f in dateien) {
        final d = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in _kAutostart) {
          expect(d[k], isA<String>(), reason: '${f.path}: $k fehlt');
          expect((d[k] as String).trim(), isNotEmpty);
        }
      }
    });

    test('🔴 keine Sprache hat den deutschen Text stehen gelassen', () {
      final de = jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync())
          as Map<String, dynamic>;
      for (final f in Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb') && !f.path.endsWith('_de.arb'))) {
        final d = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in _kAutostart) {
          expect(d[k], isNot(de[k]), reason: '${f.path}: $k ist noch deutsch');
        }
      }
    });

    test('die Getter stehen in der generierten Klasse', () {
      final basis = File('lib/l10n/app_localizations.dart').readAsStringSync();
      for (final k in _kAutostart) {
        expect(basis, contains('String get $k'), reason: '$k nicht generiert');
      }
    });
  });
}
