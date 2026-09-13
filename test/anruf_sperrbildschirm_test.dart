// Der Anruf auf dem Sperrbildschirm.
//
// 🔴 WAS HIER SCHIEFGING. Ein Anruf, der eintraf, waehrend das Tablet gesperrt
// ruhte, war NICHT annehmbar. Es gab eine Benachrichtigung — aber das Angebot
// des Anrufers (SDP) lebte allein im Isolat des Hintergrunddienstes, und beim
// Oeffnen der App verband sich das Isolat der Oberflaeche neu; der Anrufer
// wiederholt sein Angebot nicht. Dazu hatte MainActivity weder
// `showWhenLocked` noch `turnScreenOn`, der Vollbild-Intent startete also eine
// Activity HINTER dem Sperrbildschirm, und der Bildschirm ging nicht an.
//
// Diese Zusicherungen halten die fuenf Teile der Reparatur zusammen.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd_klingel/icd_klingel.dart';

/// ⚠️ Kommentare werden LAENGENTREU geleert, nicht entfernt: sonst verschieben
/// sich alle Positionen, und ein Positionsvergleich prueft etwas anderes als
/// er sagt. Und ohne das Leeren findet eine Zusicherung ihren eigenen
/// Warnkommentar — das ist in diesem Projekt mehrfach passiert.
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
/// ⚠️ Erst die RUNDEN Klammern des Kopfes ausgleichen, dann die geschweiften:
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

/// Schneidet einen AUSDRUCKS-Rumpf aus: `fun x(...): T = ...` bis zum Ende.
///
/// 🔴 [rumpf] taugt dafuer NICHT: es sucht die erste `{` auf runder Tiefe 0 —
/// bei einem Ausdrucks-Rumpf ist das der Rumpf der NAECHSTEN Funktion, und die
/// Zusicherung prueft dann fremden Code. Genau dieser Fehler hat diesen Test
/// bei seinem ersten Lauf rot gemacht, obwohl der Code stimmte.
String ausdruck(String quelle, String kopf) {
  final a = quelle.indexOf(kopf);
  expect(a, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  final gleich = quelle.indexOf('=', a + kopf.length);
  expect(gleich, greaterThanOrEqualTo(0), reason: 'kein `=` nach: $kopf');
  // Bis zur naechsten Leerzeile oder zum naechsten `fun` — ein Kotlin-
  // Ausdrucks-Rumpf endet nicht an einem Semikolon.
  final naechste = quelle.indexOf('\n\n', gleich);
  final ende = naechste < 0 ? quelle.length : naechste;
  return quelle.substring(a, ende);
}

/// Verlangt, dass [erst] VOR [dann] steht — und dass es beide gibt.
///
/// 🔴 Ohne die Anwesenheitspruefung ist so ein Vergleich WERTLOS: `indexOf`
/// gibt bei fehlender Stelle -1 zurueck, und -1 ist kleiner als jeder Fund.
/// Die Zusicherung bleibt dann gruen, wenn [erst] ganz VERSCHWINDET — genau
/// das ist der Gegenprobe dieses Tests zweimal durchgerutscht.
void vorher(String quelle, String erst, String dann, {String? reason}) {
  expect(quelle, contains(erst), reason: 'fehlt ganz: $erst');
  expect(quelle, contains(dann), reason: 'fehlt ganz: $dann');
  expect(quelle.indexOf(erst), lessThan(quelle.indexOf(dann)), reason: reason);
}

/// Schneidet einen DART-Ausdrucksrumpf aus: `... => ...;`
String ausdruckDart(String quelle, String kopf) {
  final a = quelle.indexOf(kopf);
  expect(a, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  final ende = quelle.indexOf(';', a);
  expect(ende, greaterThanOrEqualTo(0), reason: 'kein `;` nach: $kopf');
  return quelle.substring(a, ende + 1);
}

const _kKlingelSchluessel = <String>[
  'klingelTitel',
  'klingelZweck',
  'klingelAndroidHinweis',
  'klingelOhneErlaubnis',
  'klingelErteilt',
  'klingelNichtErteilt',
  'klingelVonHand',
  'klingelNurAndroid',
];

void main() {
  late String klingelKt;
  late String schirmKt;
  late String empfaengerKt;
  late String pluginKt;
  late String pluginDart;
  late String dienstDart;
  late String hintergrund;
  late String dashboard;
  late String pluginManifest;
  late String appManifest;
  late String gemeinsam;
  late String klingelWidget;
  late String fensterWidget;

  setUpAll(() {
    const k = 'packages/icd_klingel/android/src/main/kotlin/de/icd360s/icd_klingel';
    klingelKt = File('$k/Klingel.kt').readAsStringSync();
    schirmKt = File('$k/KlingelActivity.kt').readAsStringSync();
    empfaengerKt = File('$k/KlingelEmpfaenger.kt').readAsStringSync();
    pluginKt = File('$k/IcdKlingelPlugin.kt').readAsStringSync();
    pluginDart = ohneKommentare(
        File('packages/icd_klingel/lib/icd_klingel.dart').readAsStringSync());
    dienstDart = ohneKommentare(
        File('lib/services/anruf_klingel.dart').readAsStringSync());
    hintergrund = ohneKommentare(
        File('lib/services/background_service.dart').readAsStringSync());
    dashboard = ohneKommentare(
        File('lib/screens/mitglied_dashboard.dart').readAsStringSync());
    pluginManifest = File(
            'packages/icd_klingel/android/src/main/AndroidManifest.xml')
        .readAsStringSync();
    appManifest =
        File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    gemeinsam = ohneKommentare(
        File('lib/widgets/sonderberechtigung.dart').readAsStringSync());
    klingelWidget = ohneKommentare(
        File('lib/widgets/klingel_erlaubnis.dart').readAsStringSync());
    fensterWidget = ohneKommentare(
        File('lib/widgets/anruffenster_erlaubnis.dart').readAsStringSync());
  });

  // ------------------------------------------------------------------------
  group('1 — Der Klingelschirm ist eine EIGENE Activity', () {
    test('mit showWhenLocked und turnScreenOn IM MANIFEST', () {
      // ⚠️ Im Manifest und nicht zur Laufzeit: zur Laufzeit gibt es ein
      // Wettrennen zwischen onCreate und der ersten Zeichnung des Fensters,
      // und auf strengen Hersteller-Oberflaechen bleibt der Schirm dann hinter
      // dem Sperrbildschirm.
      expect(pluginManifest, contains('android:name=".KlingelActivity"'));
      expect(pluginManifest, contains('android:showWhenLocked="true"'));
      expect(pluginManifest, contains('android:turnScreenOn="true"'));
    });

    test('🔴 MainActivity bekommt showWhenLocked NICHT', () {
      // Stuende es dort, liesse sich die ganze App vom Sperrbildschirm aus
      // oeffnen, indem man irgendeine Benachrichtigung antippt — mit den
      // Gesundheitsdaten des Mitglieds darin. Genau deshalb gibt es den
      // eigenen Schirm.
      final block = appManifest.substring(
        appManifest.indexOf('<activity'),
        appManifest.indexOf('</activity>'),
      );
      expect(block, contains('.MainActivity'));
      expect(block, isNot(contains('showWhenLocked')));
      expect(block, isNot(contains('turnScreenOn')));
    });

    test('eigene Aufgabe, nicht in der Uebersicht, nicht von aussen startbar',
        () {
      expect(pluginManifest, contains('android:taskAffinity=""'),
          reason: 'in der Aufgabe von MainActivity naehme ihr Beenden die App '
              'mit');
      expect(pluginManifest, contains('android:excludeFromRecents="true"'));
      // ⚠️ Auf den Block EINGEGRENZT: `exported="false"` steht in dieser
      // Datei dreimal (Kommentar, Activity, Empfaenger). Die Zusicherung ueber
      // die ganze Datei blieb gruen, als die Activity auf `true` gedreht wurde
      // — von der Gegenprobe gefunden.
      final schirmBlock = pluginManifest.substring(
        pluginManifest.indexOf('<activity'),
        pluginManifest.indexOf('/>', pluginManifest.indexOf('<activity')),
      );
      expect(schirmBlock, contains('.KlingelActivity'));
      expect(schirmBlock, contains('android:exported="false"'),
          reason: 'niemand von aussen darf einen Anruf vortaeuschen');
    });

    test('der Empfaenger ist ebenfalls nicht exportiert', () {
      final empf = pluginManifest.substring(pluginManifest.indexOf('<receiver'));
      expect(empf, contains('.KlingelEmpfaenger'));
      expect(empf, contains('android:exported="false"'));
    });

    test('startet KEIN Flutter', () {
      // Er muss in Millisekunden stehen; ein Flutter-Kaltstart auf einem
      // ruhenden Tablet dauert Sekunden.
      expect(schirmKt, isNot(contains('FlutterActivity')));
      expect(schirmKt, isNot(contains('FlutterEngine')));
      expect(schirmKt, contains(': Activity()'));
    });

    test('die Zuruecktaste entscheidet NICHT', () {
      // Sonst verschwaende der Schirm und es klingelte weiter, ohne dass etwas
      // sichtbar waere.
      final z = rumpf(schirmKt, 'override fun onBackPressed()');
      expect(z, isNot(contains('ablehnen')));
      expect(z, isNot(contains('finish')));
    });
  });

  // ------------------------------------------------------------------------
  group('2 — Zwei Wege, weil der Vollbild-Intent fehlen kann', () {
    test('Vollbild-Intent auf den eigenen Schirm', () {
      expect(klingelKt, contains('setFullScreenIntent(vollbild, true)'));
      expect(klingelKt, contains('Intent(ctx, KlingelActivity::class.java)'));
    });

    test('CallStyle mit Annehmen und Ablehnen', () {
      // NotificationCompat, damit EIN Weg Android 11 bis 17 deckt: die
      // Framework-Klasse Notification.CallStyle gibt es erst ab API 31.
      expect(klingelKt,
          contains('NotificationCompat.CallStyle.forIncomingCall(wer, ablehnen, annehmen)'));
      expect(klingelKt, contains('setColorized(true)'),
          reason: 'unter API 31 gibt CallStyle keinen hohen Rang; setColorized '
              'ist der von Android genannte Ersatz');
    });

    test('🔴 Annehmen ueber eine Activity, Ablehnen ueber einen Broadcast', () {
      // Ein BroadcastReceiver darf seit Android 10 keine Activity aus dem
      // Hintergrund starten. Fuehrte „Annehmen" ueber ihn, waere der Start
      // stumm verworfen — ein Knopf, der nichts tut.
      final a = rumpf(klingelKt, 'fun zeigen(');
      final annehmenStelle = a.indexOf('val annehmen = PendingIntent.getActivity(');
      final ablehnenStelle = a.indexOf('val ablehnen = PendingIntent.getBroadcast(');
      expect(annehmenStelle, greaterThanOrEqualTo(0),
          reason: 'Annehmen MUSS getActivity sein');
      expect(ablehnenStelle, greaterThanOrEqualTo(0),
          reason: 'Ablehnen darf ein Broadcast sein');
    });

    test('🔴 der Empfaenger startet KEINE Activity', () {
      expect(empfaengerKt, isNot(contains('startActivity')));
      expect(empfaengerKt, isNot(contains('appStarten')));
    });

    test('eine liegengebliebene Klingelmeldung verschwindet von selbst', () {
      expect(klingelKt, contains('setTimeoutAfter('),
          reason: 'der Anrufer gibt nach ~45 s auf; ohne Grenze stuende '
              '„Eingehender Anruf" morgen noch da');
    });
  });

  // ------------------------------------------------------------------------
  group('3 — Es klingelt wirklich', () {
    test('🔴 NEUE Kanalkennung, nicht die alte voice_calls', () {
      // Die Einstellungen eines Kanals sind nach dem Anlegen unveraenderlich:
      // `voice_calls` steht auf dem gewoehnlichen Meldungston und liesse sich
      // nicht mehr auf Klingeln umstellen.
      expect(klingelKt, contains('const val KANAL_ID = "anruf_eingehend_v2"'));
      expect(klingelKt, isNot(contains('"voice_calls"')));
    });

    test('der Ton laeuft in Schleife und haengt an der Klingel-Lautstaerke',
        () {
      expect(klingelKt, contains('isLooping = true'),
          reason: 'ein Kanalton spielt genau EINMAL; ein Anruf muss klingeln, '
              'bis jemand abnimmt');
      expect(klingelKt, contains('USAGE_NOTIFICATION_RINGTONE'));
      final kanal = rumpf(klingelKt, 'private fun kanalAnlegen(');
      expect(kanal, contains('setSound(null, null)'),
          reason: 'sonst laeutet es zweimal');
      expect(kanal, contains('IMPORTANCE_HIGH'));
    });

    test('🔴 der Klingelmodus des Geraets wird respektiert', () {
      // Auf „lautlos" zu klingeln ist kein Dienst am Mitglied, sondern ein
      // Fehler — es hat den Schalter aus einem Grund umgelegt.
      final t = rumpf(klingelKt, 'private fun tonStarten(');
      expect(t, contains('RINGER_MODE_SILENT'));
      expect(t, contains('RINGER_MODE_NORMAL'));
    });
  });

  // ------------------------------------------------------------------------
  group('4 — Die Berechtigung wird erfragt', () {
    test('canUseFullScreenIntent erst ab Android 14 — davor „ja"', () {
      final e = rumpf(klingelKt, 'fun erlaubt(ctx: Context): Boolean');
      expect(e, contains('SDK_INT < 34'));
      expect(e, contains('return true'),
          reason: 'vor Android 14 ist es eine gewoehnliche Berechtigung, die '
              'bei der Installation erteilt wird — „nein" waere dort falsch');
      expect(e, contains('canUseFullScreenIntent()'));
    });

    test('drei Wege in die Einstellung, und KEIN resolveActivity davor', () {
      final k = rumpf(klingelKt, 'fun einstellungOeffnen(ctx: Context): Boolean');
      expect(k, contains('ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT'));
      expect(k, contains('package:'),
          reason: 'die Seite DIESER App, nicht nur die Liste');
      expect(k, contains('ACTION_APPLICATION_DETAILS_SETTINGS'));
      expect('Intent('.allMatches(k).length, greaterThanOrEqualTo(3));
      // 🔴 Seit Android 11 filtert die Paket-Sichtbarkeit diese Abfragen; sie
      // koennen `null` liefern, obwohl der Start gelingen wuerde.
      expect(k, isNot(contains('resolveActivity')));
      expect(k, isNot(contains('queryIntentActivities')));
    });

    test('Dart wertet das Ergebnis aus und sagt den Fehlschlag', () {
      expect(pluginDart, contains('Future<bool> einstellungOeffnen()'));
      expect('vonHandText'.allMatches(gemeinsam).length,
          greaterThanOrEqualTo(3));
      expect(klingelWidget, contains('vonHandText: l.klingelVonHand'));
    });

    test('gefragt wird EINMAL je App-Lauf und nie ueber einem Anruf', () {
      final f = rumpf(dashboard, 'Future<void> _klingelErlaubnisFragen()');
      expect(f, contains('if (_klingelErlaubnisGefragt) return;'));
      // ⚠️ Die Sperre VOR dem Zeigen: sonst fragt ein zweiter Durchlauf
      // (etwa nach einem Sprachwechsel) noch einmal.
      vorher(f, '_klingelErlaubnisGefragt = true;',
          'klingelHinweisZeigen(context)',
          reason: 'sonst fragt ein zweiter Durchlauf noch einmal');
      expect(dashboard, contains('if (_voiceCallService.callState != CallState.idle) return;'),
          reason: 'die Frage darf einen laufenden Anruf nicht verdecken');
    });

    test('USE_FULL_SCREEN_INTENT steht im App-Manifest', () {
      expect(appManifest,
          contains('android.permission.USE_FULL_SCREEN_INTENT'));
    });

    test('🔴 der googleplay-Flavor entfernt sie NICHT', () {
      // Google Play verlangt fuer sie kein Declaration Form: die Richtlinie
      // nennt sie als Beispiel fuer eine special permission, die ueber die
      // Systemeinstellungen erteilt wird. Entfernt waere der Klingelschirm
      // fuer die meisten Mitglieder wirkungslos.
      final gp = File('android/app/src/googleplay/AndroidManifest.xml');
      if (!gp.existsSync()) return;
      final q = gp.readAsStringSync();
      final i = q.indexOf('USE_FULL_SCREEN_INTENT');
      if (i < 0) return;
      expect(q.substring(i, (i + 200).clamp(0, q.length)),
          isNot(contains('tools:node="remove"')));
    });
  });

  // ------------------------------------------------------------------------
  group('5 — Das Angebot ueberlebt den Neustart der App', () {
    test('🔴 zuerst festhalten, dann klingeln', () {
      // Klingelte es zuerst, koennte das Mitglied „Annehmen" tippen, bevor das
      // Angebot festgehalten ist — die App kaeme nach vorne und faende nichts.
      final a = rumpf(dienstDart, 'static Future<bool> anbieten(');
      vorher(a, 'await merken(', 'IcdKlingel.zeigen(',
          reason: 'klingelte es zuerst, koennte „Annehmen" getippt werden, '
              'bevor das Angebot festgehalten ist');
    });

    test('die Zeit wird ZULETZT geschrieben', () {
      // Bricht der Schreibvorgang ab, ist das Angebot ohne Zeitstempel — und
      // [lesen] verwirft es, statt eine halbe Zeile fuer gueltig zu halten.
      final m = rumpf(dienstDart, 'static Future<void> merken(');
      vorher(m, 'setString(_kSdp', 'setInt(_kZeit');
      expect(m.trimRight().endsWith('}'), isTrue);
      final letzte = m.trimRight();
      expect(letzte.lastIndexOf('_kZeit'),
          greaterThan(letzte.lastIndexOf('_kAnruferId')));
    });

    test('🔴 reload() beim Lesen — geschrieben hat das ANDERE Isolat', () {
      final l = rumpf(dienstDart, 'static Future<WartendesAngebot?> lesen()');
      expect(l, contains('await p.reload();'),
          reason: 'ohne Nachladen liefert der Zwischenspeicher dieses Isolats '
              'den Stand von seinem eigenen Start');
      expect(l, contains('hoechstalter'));
      expect(l, contains('alter.isNegative'),
          reason: 'ein Angebot aus der Zukunft (gestelltes Systemdatum) waere '
              'sonst ewig frisch');
    });

    test('der kalte Weg wartet auf die Verbindung', () {
      final k = rumpf(dashboard, 'Future<void> _kaltAnnehmen(WartendesAngebot a)');
      expect(k, contains('_chatService.isConnected'));
      expect(k, contains('connectionStream'));
      // idle → ringing, VOR dem Annehmen: `acceptCall` weist jeden anderen
      // Zustand ab — genau daran scheiterte es am 11.09.2026 stumm.
      vorher(k, 'handleIncomingCall(', '_acceptCall(',
          reason: 'acceptCall weist jeden Zustand ausser ringing ab — genau '
              'daran scheiterte es am 11.09.2026 stumm');
    });

    test('🔴 ersetzen richtet sich nach dem Schirm, nie blind true', () {
      // `pushReplacement` nimmt die OBERSTE Route. Gibt es keinen
      // Klingelschirm, ist das das DASHBOARD — und nach dem Auflegen stuende
      // die App vor einem leeren Stapel.
      final k = rumpf(dashboard, 'Future<void> _kaltAnnehmen(WartendesAngebot a)');
      expect(k, contains('final ersetzen = _klingelschirmOffen;'));
      expect(k, contains('ersetzen: ersetzen'));
      expect(k, isNot(contains('ersetzen: true')));
      expect(dashboard, contains('bool _klingelschirmOffen = false;'),
          reason: 'ohne Klingelschirm muss der Merker falsch sein');
      expect(dashboard,
          contains('{VoidCallback? beiFehlschlag, bool ersetzen = true}'));
    });

    test('🔴 handleIncomingCall NICHT zweimal — das waere ein busy-Reject', () {
      // Liegt die App im Speicher, steht der Dienst schon auf `ringing`. Ein
      // zweiter Aufruf faellt in die Besetzt-Wache, schickt dem Anrufer
      // `call_reject` mit „busy" — und danach wuerde derselbe Anruf trotzdem
      // angenommen.
      final k = rumpf(dashboard, 'Future<void> _kaltAnnehmen(WartendesAngebot a)');
      final i = k.indexOf('handleIncomingCall(');
      expect(i, greaterThanOrEqualTo(0));
      vorher(k, 'if (_voiceCallService.callState != CallState.ringing) {',
          'handleIncomingCall(',
          reason: 'der Aufruf MUSS hinter der Zustandswache liegen');
    });

    test('ein verfallenes Angebot wird GESAGT, nicht verschwiegen', () {
      final p = rumpf(dashboard, 'Future<void> _wartendenAnrufPruefen()');
      expect(p, contains('_anrufWeggemeldet()'),
          reason: 'ein Tipp auf „Annehmen", nach dem nichts geschieht, sieht '
              'wie eine kaputte App aus');
    });

    test('auch bei resumed wird geprueft', () {
      // Nimmt das Mitglied vom Sperrbildschirm an, waehrend die App noch im
      // Speicher liegt, wird sie nur nach vorne geholt — `initState` laeuft
      // dann nicht.
      expect('_wartendenAnrufPruefen()'.allMatches(dashboard).length,
          greaterThanOrEqualTo(4),
          reason: 'Definition + Abo + Start + resumed');
    });
  });

  // ------------------------------------------------------------------------
  group('Die Entscheidung wird keinem Isolat gestohlen', () {
    test('Ansehen loescht nicht, Quittieren loescht', () {
      final a =
          ausdruck(klingelKt, 'fun entscheidungAnsehen(ctx: Context): String?');
      expect(a, contains('getString(SCHLUESSEL_ENTSCHEIDUNG, null)'));
      expect(a, isNot(contains('remove(')),
          reason: 'ein Lesen, das loescht, stiehlt dem anderen Isolat die '
              'Entscheidung');
      expect(a, isNot(contains('.edit()')));
      final q = rumpf(klingelKt, 'fun entscheidungQuittieren(ctx: Context)');
      expect(q, contains('remove(SCHLUESSEL_ENTSCHEIDUNG)'));
    });

    test('die Entscheidung wird FESTGEHALTEN, nicht nur gemeldet', () {
      // Tippt jemand „Ablehnen", waehrend kein Isolat laeuft, erreicht der
      // Ereigniskanal niemanden.
      final e = rumpf(klingelKt, 'fun entscheidungSetzen(');
      expect(e, contains('putString(SCHLUESSEL_ENTSCHEIDUNG'));
      expect(e, contains('IcdKlingelPlugin.anklopfen()'));
    });

    test('das Anklopfen traegt die Entscheidung NICHT mit sich', () {
      // Zwei Isolate bekaemen sonst beide eine Kopie und handelten beide.
      final a = rumpf(pluginKt, 'fun anklopfen()');
      expect(a, contains('"entscheidung"'));
      expect(a, isNot(contains('gespraech')));
    });

    test('der Plugin-Melder schreibt an ALLE Engines', () {
      // Eine Instanz je Engine: Oberflaeche und Hintergrunddienst. Wer nur die
      // letzte behaelt, klemmt beim Oeffnen der App den Dienst ab — also genau
      // das Isolat, das eine Absage hinausschicken kann.
      expect(pluginKt, contains('private val senken = mutableListOf<EventChannel.EventSink>()'));
      final a = rumpf(pluginKt, 'fun anklopfen()');
      expect(a, contains('for (s in jetzt)'));
    });

    test('🔴 der Hintergrunddienst nimmt NUR Ablehnen', () {
      expect(hintergrund, contains('IcdKlingel.anklopfen.listen'));
      final ab = hintergrund.substring(
          hintergrund.indexOf('IcdKlingel.anklopfen.listen'));
      final block = ab.substring(0, ab.indexOf('});') + 3);
      expect(block, contains('!e.istAblehnen) return'),
          reason: 'Annehmen gehoert in die Oberflaeche (WebRTC); nimmt der '
              'Dienst es weg, findet die Oberflaeche nichts vor');
      expect(block, contains("'type': 'call_reject'"));
      expect(block, contains('entscheidungQuittieren'));
    });

    test('🔴 die Oberflaeche quittiert Ablehnen nur, wenn SIE es sendet', () {
      final p = rumpf(dashboard, 'Future<void> _wartendenAnrufPruefen()');
      final i = p.indexOf('istAblehnen');
      expect(i, greaterThanOrEqualTo(0));
      final zweig = p.substring(i, p.indexOf('return;', i));
      expect(zweig, contains('CallState.ringing'),
          reason: 'blind quittiert faende der Dienst nichts vor und der '
              'Anrufer klingelte 45 s ins Leere');
    });
  });

  // ------------------------------------------------------------------------
  group('Der Schirm verschwindet mit dem Anruf', () {
    test('verbergen nimmt die Activity mit', () {
      final v = rumpf(klingelKt, 'fun verbergen(ctx: Context)');
      expect(v, contains('KlingelActivity.schliessen()'),
          reason: 'sonst klebte „Eingehender Anruf" auf dem Sperrbildschirm '
              'und ein spaeteres Annehmen fuehrte ins Leere');
      expect(v, contains('tonStoppen()'));
    });

    test('ein aufgelegter Anruf raeumt im Hintergrunddienst ab', () {
      expect(hintergrund, contains("case 'call_ended':"));
      expect(hintergrund, contains("case 'call_rejected':"));
      expect(hintergrund, contains("case 'call_busy':"));
      expect(hintergrund, contains('AnrufKlingel.abraeumen()'));
    });

    test('🔴 der In-App-Schirm stoppt das Klingeln, behaelt aber das Angebot',
        () {
      final z = rumpf(dashboard, 'void _klingelschirmZeigen(CallOfferEvent event)');
      expect(z, contains('IcdKlingel.verbergen();'),
          reason: 'sonst laeutet es zweimal — der Hintergrunddienst hat '
              'denselben Anruf ueber seine eigene Verbindung bekommen');
      // ⚠️ NICHT abraeumen: wird die App waehrend des Klingelns weggewischt,
      // ist das gemerkte Angebot der einzige Weg zurueck.
      //
      // ⚠️ Der Bereich endet VOR `schliessen()` — dort darf `abraeumen` sehr
      // wohl stehen, denn dann ist der Anruf entschieden.
      final vorspann = z.substring(
          0, z.indexOf('StreamSubscription<CallEndedEvent>? endeAbo;'));
      expect(vorspann, isNot(contains('AnrufKlingel.abraeumen()')));
      final schliessen = rumpf(z, 'void schliessen(BuildContext ctx)');
      expect(schliessen, contains('AnrufKlingel.abraeumen()'));
    });
  });

  // ------------------------------------------------------------------------
  group('🔴 Der native Schirm behaelt den Anruf, wenn die App nicht im Blick ist',
      () {
    // Gemeldet am 13.09.2026 vom Tablet: „pe android dupa ce e deblocat atunci
    // apare" — der Schirm erschien erst NACH dem Entsperren. Ursache war eine
    // Zusicherung im Kommentar statt im Code: `_handleIncomingCall` raeumte das
    // native Klingeln mit der Begruendung „die App ist im Blick" ab, und
    // niemand hatte das geprueft.
    test('🔴 _handleIncomingCall raeumt das Klingeln NICHT ab', () {
      final h = rumpf(dashboard, 'void _handleIncomingCall(CallOfferEvent event)');
      expect(h, isNot(contains('IcdKlingel.verbergen()')),
          reason: 'das haette dem Mitglied genau den Schirm weggenommen, um '
              'den es geht');
      expect(h, isNot(contains('AnrufKlingel.abraeumen()')));
    });

    test('es wird auf den LEBENSZYKLUS geprueft, nicht auf mounted', () {
      // ⚠️ `mounted` bleibt im Hintergrund wahr, und diese App bleibt dort im
      // Speicher, weil der Vordergrunddienst laeuft.
      final b = ausdruckDart(dashboard, 'bool get _imBlick');
      expect(b, contains('WidgetsBinding.instance.lifecycleState'));
      expect(b, contains('AppLifecycleState.resumed'));
      expect(b, isNot(contains('mounted')));
    });

    test('ohne Blick wird das Angebot gemerkt und zurueckgekehrt', () {
      final h = rumpf(dashboard, 'void _handleIncomingCall(CallOfferEvent event)');
      final i = h.indexOf('if (!_imBlick) {');
      expect(i, greaterThanOrEqualTo(0), reason: 'die Wache fehlt ganz');
      final zweig = h.substring(i, h.indexOf('}', h.indexOf('return;', i)));
      expect(zweig, contains('_klingelndesAngebot = event;'));
      expect(zweig, contains('return;'));
      // Der Dienst MUSS den Anruf trotzdem kennen, sonst laesst sich spaeter
      // nichts annehmen.
      vorher(h, 'handleIncomingCall(', 'if (!_imBlick) {',
          reason: 'der Zustand muss VOR der Wache gesetzt werden');
    });

    test('bei der Rueckkehr wird der Schirm nachgeholt', () {
      expect(dashboard, contains('_wartendenAnrufPruefen().then('),
          reason: 'erst die Entscheidung, dann der Schirm — sonst ginge ueber '
              'einem schon angenommenen Anruf noch ein Klingelschirm auf');
      final i = dashboard.indexOf('_wartendenAnrufPruefen().then(');
      final block = dashboard.substring(i, dashboard.indexOf('});', i) + 3);
      expect(block, contains('_klingelndesAngebot'));
      expect(block, contains('CallState.ringing'),
          reason: 'ein aufgelegter Anruf darf keinen Schirm mehr oeffnen');
      expect(block, contains('_klingelschirmZeigen('));
    });

    test('der Merker wird an JEDEM Ausgang losgelassen', () {
      // Bliebe er stehen, ersetzte ein spaeterer kalter Weg eine Route, die es
      // nicht mehr gibt — und das naehme das Dashboard.
      //
      // ⚠️ JE STELLE geprueft, nicht global gezaehlt: eine Zaehlung „mindestens
      // drei" bleibt gruen, wenn man eine der vier Stellen entfernt. Von der
      // Gegenprobe gefunden.
      final z = rumpf(dashboard, 'void _klingelschirmZeigen(CallOfferEvent event)');
      expect(rumpf(z, 'void schliessen(BuildContext ctx)'),
          contains('_klingelschirmOffen = false;'),
          reason: 'entschiedener Anruf');
      final thenBlock = z.substring(z.indexOf(').then((_) {'));
      expect(thenBlock, contains('_klingelschirmOffen = false;'),
          reason: 'die Route kann auch anders verschwinden');
      final k = rumpf(dashboard, 'Future<void> _kaltAnnehmen(WartendesAngebot a)');
      expect(k, contains('_klingelschirmOffen = false;'),
          reason: 'nach dem Ersetzen steht kein Klingelschirm mehr');
      expect(z, contains('_klingelndesAngebot = null;'));
    });
  });

  // ------------------------------------------------------------------------
  group('Keine zweite Uebersetzungsquelle', () {
    test('das Plugin hat KEINE res/values-Dateien', () {
      // Ein `values-xx/strings.xml` waere eine zweite Uebersetzungsquelle
      // neben den 28 ARB-Dateien; die beiden liefen beim ersten geaenderten
      // Wort auseinander.
      final res = Directory('packages/icd_klingel/android/src/main/res');
      expect(res.existsSync(), isFalse);
    });

    test('die Texte kommen durch den Kanal', () {
      expect(klingelKt, contains('titel: String'));
      expect(klingelKt, contains('annehmenText: String'));
      expect(klingelKt, contains('ablehnenText: String'));
      final t = rumpf(dienstDart, 'static Future<({String titel, String annehmen, String ablehnen})>');
      expect(t, contains("l10n_notifIncomingCall"));
      expect(t, contains("l10n_acceptCall"));
      expect(t, contains("l10n_rejectCall"));
    });

    test('die Oberflaeche hinterlegt sie fuer das andere Isolat', () {
      expect(dashboard, contains("prefs.setString('l10n_acceptCall', l.acceptCall)"));
      expect(dashboard, contains("prefs.setString('l10n_rejectCall', l.rejectCall)"));
    });

    test('der Name der App kommt vom SYSTEM', () {
      expect(schirmKt, contains('applicationInfo.loadLabel(packageManager)'),
          reason: 'stimmt damit in allen fuenf Varianten von selbst und '
              'kostet keine 29. Uebersetzung');
    });
  });

  // ------------------------------------------------------------------------
  group('Alle 28 Sprachen', () {
    test('jede ARB-Datei hat die acht Schluessel', () {
      final dateien = Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb'))
          .toList();
      expect(dateien.length, 28);
      for (final f in dateien) {
        final d = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in _kKlingelSchluessel) {
          expect(d[k], isA<String>(), reason: '${f.path}: $k fehlt');
          expect((d[k] as String).trim(), isNotEmpty,
              reason: '${f.path}: $k ist leer');
        }
      }
    });

    test('🔴 keine Sprache hat den deutschen Text stehen gelassen', () {
      // Der Waechter gegen „28 Dateien angefasst, 21 nur kopiert".
      final de = jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync())
          as Map<String, dynamic>;
      for (final f in Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb') && !f.path.endsWith('_de.arb'))) {
        final d = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in _kKlingelSchluessel) {
          expect(d[k], isNot(de[k]), reason: '${f.path}: $k ist noch deutsch');
        }
      }
    });

    test('die Getter stehen in der generierten Klasse', () {
      // ⚠️ Die generierten Dateien sind eingecheckt. Ohne `flutter gen-l10n`
      // uebersetzt das Widget nicht, und der Fehler erschiene erst im Build.
      final basis = File('lib/l10n/app_localizations.dart').readAsStringSync();
      for (final k in _kKlingelSchluessel) {
        expect(basis, contains('String get $k'), reason: '$k nicht generiert');
      }
    });
  });

  // ------------------------------------------------------------------------
  group('Kopplung: EIN Aufbau fuer beide Berechtigungen', () {
    test('beide gehen durch dasselbe Widget', () {
      for (final q in <String>[fensterWidget, klingelWidget]) {
        expect(q, contains('SonderberechtigungZeile(berechtigung: b)'));
        expect(q, contains('sonderberechtigungHinweis(context, b)'));
      }
    });

    test('🔴 keine zweite Kopie des Ablaufs', () {
      // Zwei Kopien liefen auseinander, und eine abweichende Kopie faellt
      // niemandem auf — sie fragt nur nicht mehr.
      for (final q in <String>[fensterWidget, klingelWidget]) {
        expect(q, isNot(contains('didChangeAppLifecycleState')));
        expect(q, isNot(contains('showDialog')));
      }
    });

    test('das Konto zeigt beide Zeilen', () {
      final konto = ohneKommentare(
          File('lib/widgets/mitglied_profile_dialog.dart').readAsStringSync());
      expect(konto, contains('const AnruffensterErlaubnis()'));
      expect(konto, contains('const KlingelErlaubnis()'));
    });
  });

  // ------------------------------------------------------------------------
  group('Nebenbefund: der Anrufer hiess immer „Unknown"', () {
    test('caller_name statt from_name', () {
      // Der Server schickt `caller_name`/`caller_id` (siehe ChatService); die
      // Felder `from_name`/`from` gab es nie. Bis heute stand in der Meldung
      // des Hintergrunddienstes deshalb IMMER der Rueckfalltext.
      final m = rumpf(hintergrund, 'static Future<void> _showCallNotification(');
      expect(m, contains("message['caller_name']"));
      expect(m, isNot(contains("message['from_name']")));
    });
  });

  // ------------------------------------------------------------------------
  group('Die Entscheidung lesen — reine Regel', () {
    final jetzt = DateTime(2026, 9, 13, 12, 0, 0);
    String roh(String art, int id, DateTime z) =>
        '$art:$id:${z.millisecondsSinceEpoch}';

    test('eine frische Entscheidung wird gelesen', () {
      final e = IcdKlingel.entscheidungLesen(
          roh('annehmen', 42, jetzt.subtract(const Duration(seconds: 5))),
          jetzt: jetzt);
      expect(e, isNotNull);
      expect(e!.istAnnehmen, isTrue);
      expect(e.istAblehnen, isFalse);
      expect(e.gespraechId, 42);
    });

    test('ablehnen ebenso', () {
      final e = IcdKlingel.entscheidungLesen(
          roh('ablehnen', 7, jetzt), jetzt: jetzt);
      expect(e!.istAblehnen, isTrue);
      expect(e.gespraechId, 7);
    });

    test('🔴 eine zu alte Entscheidung wird VERWORFEN', () {
      // Sonst beantwortete ein Tipp von vor einer Stunde den Anruf von jetzt.
      final e = IcdKlingel.entscheidungLesen(
          roh('annehmen', 1, jetzt.subtract(const Duration(minutes: 3))),
          jetzt: jetzt);
      expect(e, isNull);
    });

    test('knapp innerhalb der Grenze wird gelesen', () {
      final e = IcdKlingel.entscheidungLesen(
          roh('annehmen', 1,
              jetzt.subtract(IcdKlingel.hoechstalter - const Duration(seconds: 1))),
          jetzt: jetzt);
      expect(e, isNotNull);
    });

    test('🔴 eine Entscheidung aus der ZUKUNFT wird verworfen', () {
      // Nach einer Zeitumstellung oder einem gestellten Systemdatum waere sie
      // sonst ewig „frisch" und beantwortete jeden kuenftigen Anruf.
      final e = IcdKlingel.entscheidungLesen(
          roh('annehmen', 1, jetzt.add(const Duration(minutes: 5))),
          jetzt: jetzt);
      expect(e, isNull);
    });

    test('eine unbekannte Art wird verworfen', () {
      expect(
          IcdKlingel.entscheidungLesen(roh('irgendwas', 1, jetzt), jetzt: jetzt),
          isNull);
    });

    test('kaputte Formen werden verworfen, nicht geraten', () {
      for (final r in <String?>[
        null,
        '',
        'annehmen',
        'annehmen:1',
        'annehmen:x:123',
        'annehmen:1:x',
        'annehmen:1:123:456',
      ]) {
        expect(IcdKlingel.entscheidungLesen(r, jetzt: jetzt), isNull,
            reason: 'nicht verworfen: $r');
      }
    });
  });
}
