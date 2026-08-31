import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:icd360sev_mitglied/services/chat_service.dart';
import 'package:icd360sev_mitglied/services/remote_agent_service.dart';
import 'package:icd360sev_mitglied/services/remote_input/input_injector_android.dart';
import 'package:icd360sev_mitglied/widgets/remote_touch_overlay.dart';

/// Prueft die drei Reparaturen an der Fernwartung auf der Mitgliedsseite:
/// erneuter Raumbeitritt nach einer Wiederverbindung, der Takt der
/// Beruehrungsanzeige, und die Uebersetzung Maus → Geste auf Android.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // ─────────────────────────────────────────────────────────────────────────
  group('Nach einer Wiederverbindung wird der Raum erneut betreten', () {
    late HttpServer server;
    late List<WebSocket> verbindungen;
    late List<Map<String, dynamic>> empfangen;

    setUp(() async {
      verbindungen = [];
      empfangen = [];
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      server.listen((anfrage) async {
        final ws = await WebSocketTransformer.upgrade(anfrage);
        verbindungen.add(ws);
        ws.listen((roh) {
          final data = jsonDecode(roh as String) as Map<String, dynamic>;
          empfangen.add(data);
          if (data['type'] == 'auth') {
            ws.add(jsonEncode({'type': 'auth_success', 'user_id': 13}));
          }
        }, onError: (_) {}, cancelOnError: true);
      });
      ChatService.testWsUrl = 'ws://127.0.0.1:${server.port}/';
    });

    tearDown(() async {
      ChatService().disconnect();
      ChatService.testWsUrl = null;
      for (final ws in verbindungen) {
        await ws.close().catchError((_) => null);
      }
      await server.close(force: true);
    });

    /// 🔴 Der Beitritt haengt am SOCKET. Nach einer Wiederverbindung ist die
    /// Verbindung auf dem Server eine neue und in keinem Raum mehr — der
    /// Vorsitz sendet ICE und Sitzungsende weiterhin an den Raum, und beides
    /// erreicht das Mitglied nicht mehr. Vorher trat niemand erneut bei.
    test('der gemerkte Raum wird nach dem Abriss erneut betreten', () async {
      expect(await ChatService().connect('M68650'), isTrue);
      ChatService().joinConversation(19);

      await Future<void>.delayed(const Duration(milliseconds: 120));
      expect(empfangen.where((m) => m['type'] == 'join').length, 1,
          reason: 'der erste Beitritt');

      // Der Server wirft die Verbindung weg — Netzwechsel, Funkloch, Neustart.
      empfangen.clear();
      await verbindungen.first.close();

      // Der erste Versuch steht nach 2 Sekunden an (2, 4, 8 … Sekunden).
      await Future<void>.delayed(const Duration(seconds: 3));

      expect(ChatService().isConnected, isTrue, reason: 'wieder verbunden');
      final wieder = empfangen.where(
          (m) => m['type'] == 'join' && m['conversation_id'] == 19);
      expect(wieder.length, 1,
          reason: 'ohne erneuten Beitritt bleibt das Mitglied stumm im Nichts');
    }, timeout: const Timeout(Duration(seconds: 30)));

    /// Die Reihenfolge ist kein Schoenheitsfehler: vor der Anmeldung weist der
    /// Server jedes `join` mit „Not authenticated" ab, und zwar lautlos.
    test('der Beitritt kommt NACH der Anmeldung', () async {
      await ChatService().connect('M68650');
      ChatService().joinConversation(19);
      // ⚠️ Erst abwarten, dann leeren: die Rahmen laufen asynchron beim Server
      // ein, und ein zu fruehes Leeren laesst genau die Rahmen stehen, die
      // gerade weggeraeumt werden sollten.
      await Future<void>.delayed(const Duration(milliseconds: 120));
      empfangen.clear();
      await verbindungen.first.close();
      await Future<void>.delayed(const Duration(seconds: 3));

      final reihenfolge =
          empfangen.map((m) => m['type']).where((t) => t == 'auth' || t == 'join').toList();
      expect(reihenfolge.first, 'auth');
      expect(reihenfolge, contains('join'));
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('ein verlassener Raum wird nicht erneut betreten', () async {
      await ChatService().connect('M68650');
      ChatService().joinConversation(19);
      ChatService().leaveConversation(19);
      await Future<void>.delayed(const Duration(milliseconds: 120));
      empfangen.clear();
      await verbindungen.first.close();
      await Future<void>.delayed(const Duration(seconds: 3));

      expect(empfangen.where((m) => m['type'] == 'join'), isEmpty);
    }, timeout: const Timeout(Duration(seconds: 30)));
  });

  // ─────────────────────────────────────────────────────────────────────────
  /// 🔴 Der Ticker der Beruehrungsanzeige lief unbedingt ab `initState` — also
  /// auf JEDEM Mitgliedsgeraet, rund um die Uhr, fuer eine Funktion, die noch
  /// nie benutzt wurde. Ein aktiver Ticker fordert bei jedem vsync einen Frame
  /// an; die App zeichnet dann dauernd, statt in den Leerlauf zu gehen.
  ///
  /// Genau das macht diesen Test moeglich: mit laufendem Ticker kommt
  /// `pumpAndSettle` nie zur Ruhe und laeuft in seinen Zeitablauf.
  testWidgets('ohne Sitzung ruht die Beruehrungsanzeige', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RemoteTouchOverlay(child: Scaffold(body: Text('inhalt'))),
    ));
    await tester.pumpAndSettle();
    expect(find.text('inhalt'), findsOneWidget);
    expect(tester.binding.hasScheduledFrame, isFalse,
        reason: 'ein laufender Ticker haelt das Geraet dauerhaft am Zeichnen');
  });

  // ─────────────────────────────────────────────────────────────────────────
  /// 🔴 Der Befund vom 30.08.2026, gemessen im coturn-Log: der Vorsitz legte
  /// 18 Permissions an und schickte 69 Pruefpakete, das Mitglied **null**. Ein
  /// ICE-Agent ohne Gegenkandidaten faengt gar nicht erst an.
  ///
  /// Ursache: `remoteIceStream` ist ein BROADCAST-Stream. Abonniert wurde erst
  /// nach `sendRemoteAnswer` — die Kandidaten des Vorsitzes treffen aber
  /// waehrend des Zustimmungsdialogs ein und fielen ins Leere.
  group('ICE waehrend des Zustimmungsdialogs geht nicht verloren', () {
    final agent = RemoteAgentService();

    tearDown(agent.vormerkungVerwerfen);

    RemoteOfferEvent angebot() => RemoteOfferEvent(
          conversationId: 42,
          controllerId: '2',
          controllerName: 'Vorsitz',
          sdp: 'v=0',
          sdpType: 'offer',
        );

    test('vorgemerkte Kandidaten landen in der Warteschlange', () {
      agent.angebotVormerken(angebot());
      expect(agent.vorgemerkteKandidaten, 0);

      for (var n = 0; n < 3; n++) {
        agent.handleIce(RemoteIceEvent(
          conversationId: 42,
          candidate: 'candidate:$n 1 udp 1 1.2.3.4 100$n typ relay',
          sdpMid: '0',
          sdpMLineIndex: 0,
        ));
      }
      expect(agent.vorgemerkteKandidaten, 3,
          reason: 'ohne Vormerkung waeren alle drei weg');
    });

    test('Kandidaten einer FREMDEN Unterhaltung werden nicht gesammelt', () {
      agent.angebotVormerken(angebot());
      agent.handleIce(RemoteIceEvent(
        conversationId: 99,
        candidate: 'candidate:0 1 udp 1 1.2.3.4 1000 typ relay',
        sdpMid: '0',
        sdpMLineIndex: 0,
      ));
      expect(agent.vorgemerkteKandidaten, 0);
    });

    test('Ablehnen raeumt die Vormerkung ab', () {
      agent.angebotVormerken(angebot());
      agent.handleIce(RemoteIceEvent(
        conversationId: 42,
        candidate: 'candidate:0 1 udp 1 1.2.3.4 1000 typ relay',
        sdpMid: '0',
        sdpMLineIndex: 0,
      ));
      expect(agent.vorgemerkteKandidaten, 1);
      agent.vormerkungVerwerfen();
      expect(agent.vorgemerkteKandidaten, 0,
          reason: 'sonst traegt die naechste Sitzung fremde Kandidaten mit');
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  /// 🔴 Zustimmungstext und Banner lagen in eigenen Tabellen mit fünf bzw.
  /// sechs Sprachen und deutschem Rückfall — ausgerechnet der Text, den jemand
  /// liest, BEVOR er seinen Bildschirm freigibt.
  group('Fernwartungstexte gibt es in allen 28 Sprachen', () {
    final dateien = Directory('lib/l10n')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.arb'))
        .toList();

    const schluessel = [
      'fernwartungAnfrageTitel',
      'fernwartungAnfrageText',
      'fernwartungAnfrageHinweis',
      'fernwartungErlauben',
      'fernwartungAblehnen',
      'fernwartungVerbindet',
      'fernwartungAktiv',
      'fernwartungStopp',
      'fernwartungMikroAus',
      'fernwartungMikroAn',
    ];

    test('alle 28 Sprachdateien sind da', () {
      expect(dateien.length, 28);
    });

    test('jede Sprache hat jeden Schlüssel', () {
      final luecken = <String>[];
      for (final f in dateien) {
        final daten = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in schluessel) {
          if (!daten.containsKey(k) || (daten[k] as String).trim().isEmpty) {
            luecken.add('${f.path.split('/').last}: $k');
          }
        }
      }
      expect(luecken, isEmpty, reason: 'sonst fällt die Sprache auf Deutsch zurück');
    });

    /// ⚠️ Der schärfste Test: ein Schlüssel kann DA sein und trotzdem den
    /// deutschen Wortlaut tragen — dann sieht die Datei vollständig aus und der
    /// Mensch liest weiter Deutsch.
    test('keine Sprache trägt einfach den deutschen Wortlaut', () {
      final de = jsonDecode(
        File('lib/l10n/app_de.arb').readAsStringSync(),
      ) as Map<String, dynamic>;

      // ⚠️ Echte Zufaelle, keine fehlenden Uebersetzungen. Wer hier etwas
      // eintraegt, muss den Grund danebenschreiben — sonst wird die Liste zur
      // Muellhalde und der Test bestaetigt nur noch sich selbst.
      const zufall = {
        'app_nb.arb: fernwartungStopp', // „Stopp" ist auch auf Norwegisch richtig
      };

      final verdaechtig = <String>[];
      for (final f in dateien) {
        final name = f.path.split('/').last;
        if (name == 'app_de.arb') continue;
        final daten = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        for (final k in schluessel) {
          if (daten[k] == de[k] && !zufall.contains('$name: $k')) {
            verdaechtig.add('$name: $k');
          }
        }
      }
      expect(verdaechtig, isEmpty);
    });

    test('der Platzhalter {name} überlebt jede Übersetzung', () {
      for (final f in dateien) {
        final daten = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
        expect(daten['fernwartungAnfrageText'] as String, contains('{name}'),
            reason: '${f.path}: ohne Platzhalter steht dort kein Name');
      }
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  /// 🔴 Ton und Bild gehen in DIESELBE Spurgruppe.
  ///
  /// Lagen sie in zwei Streams, ueberschrieb beim Vorsitz die Tonspur das Bild
  /// (`onTrack` feuert je Spur, `event.streams[0]` wechselt dann mit) und der
  /// Renderer zeigte Schwarz. Behoben ist das dort (vorsitzer#523) — hier steht
  /// die zweite Haelfte, damit auch ein noch nicht aktualisierter Vorsitzer
  /// etwas sieht.
  ///
  /// ⚠️ Am Quelltext geprueft: der Fehler entsteht erst in einer echten
  /// WebRTC-Verbindung mit zwei Spuren.
  group('Ton und Bild teilen sich die Spurgruppe', () {
    final quelle =
        File('lib/services/remote_agent_service.dart').readAsStringSync();

    test('die Tonspur wird am Bildschirm-Stream angemeldet', () {
      expect(quelle, contains('await _pc!.addTrack(track, _screenStream!);'));
      expect(quelle.contains('addTrack(track, _mikroStream!)'), isFalse,
          reason: 'ein zweiter Stream laesst den Ton das Bild verdraengen');
    });

    test('_mikroStream bleibt bestehen — Stummschalten haengt daran', () {
      expect(quelle, contains('_mikroStream?.getAudioTracks()'));
      expect(quelle, contains('_mikroStream?.getTracks()'));
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  /// Die Verzögerung von ein bis zwei Sekunden kam nicht von der Entfernung,
  /// sondern vom Bufferbloat des Mobilfunk-Uplinks (eigene Speedtest-Reihe:
  /// bis 7402 ms Latenz unter Last). Ein Bitratendeckel WEIT unter der Leitung
  /// ist deshalb die eigentliche Reparatur.
  group('Bildgüte', () {
    test('die Voreinstellung ist die Automatik', () {
      expect(Bildguete.vonName(null), Bildguete.automatik,
          reason: 'niemand soll eine Stufe raten muessen');
      expect(RemoteAgentService().guete, Bildguete.automatik);
    });

    /// ⚠️ Der Deckel darf die Leitung NICHT begrenzen. Sie schafft im Median
    /// rund 18 Mbit/s; ein Deckel von 2,5 Mbit/s hätte sie künstlich
    /// gedrosselt. Gegen die Verzögerung hilft die Regelung auf Umlaufzeit,
    /// nicht ein niedriger Deckel.
    test('der Deckel drosselt eine gute Leitung nicht', () {
      final quelle =
          File('lib/services/remote_agent_service.dart').readAsStringSync();
      final m = RegExp(r'_kbitMax = (\d+)').firstMatch(quelle);
      expect(m, isNotNull);
      expect(int.parse(m!.group(1)!), greaterThanOrEqualTo(6000));
    });

    /// Additiv von 2,5 auf 8 Mbit/s waeren ueber zwei Minuten — die Sitzung
    /// waere vorbei, bevor die Leitung genutzt wird.
    test('weit unter der Schaetzung wird multiplikativ erhoeht', () {
      final quelle =
          File('lib/services/remote_agent_service.dart').readAsStringSync();
      expect(quelle, contains('_kbit * 1.4'));
      expect(quelle, contains('schaetzung * 0.7'));
    });

    /// „Fluessig" und „scharf" unterscheiden sich nicht in der Bitrate,
    /// sondern darin, WAS bei Enge aufgegeben wird. Das ist die eigentliche
    /// Entscheidung.
    test('fluessig gibt Aufloesung auf, scharf gibt Bilder auf', () {
      expect(Bildguete.fluessig.nachgeben,
          RTCDegradationPreference.MAINTAIN_FRAMERATE);
      expect(Bildguete.scharf.nachgeben,
          RTCDegradationPreference.MAINTAIN_RESOLUTION);
      expect(Bildguete.automatik.nachgeben,
          RTCDegradationPreference.MAINTAIN_RESOLUTION);
    });

    /// ⚠️ Die eingebaute Regelung von WebRTC wartet auf Paketverlust. Bei
    /// Bufferbloat kommt der zu spaet — das Modem stellt in die Warteschlange,
    /// statt zu verwerfen. Deshalb wird hier auf VERZOEGERUNG geregelt.
    test('geregelt wird auf Umlaufzeit, nicht auf Verlust', () {
      final quelle =
          File('lib/services/remote_agent_service.dart').readAsStringSync();
      expect(quelle, contains('currentRoundTripTime'));
      expect(quelle, contains('availableOutgoingBitrate'),
          reason: 'die eigene Schaetzung von WebRTC ist die Obergrenze');
      expect(quelle, contains("grenze == 'bandwidth'"));
    });

    /// Schnell runter, langsam hoch: eine Warteschlange baut sich in
    /// Sekundenbruchteilen auf, und das Hochgehen ist genau das, was die
    /// Verzoegerung erzeugt.
    /// Schnell runter, gestaffelt hinauf: eine Warteschlange baut sich in
    /// Sekundenbruchteilen auf. Nach oben wird weit unter der Schaetzung
    /// multiplikativ getastet und in ihrer Naehe additiv — sonst nutzt man
    /// entweder die Leitung nicht oder man ueberfaehrt sie.
    test('runter multiplikativ, hinauf gestaffelt', () {
      final quelle =
          File('lib/services/remote_agent_service.dart').readAsStringSync();
      expect(quelle, contains('_kbit * 0.75'));
      expect(quelle, contains('_kbit * 1.4'));
      expect(quelle, contains('_kbit + 250'));
      expect(quelle, contains('_taktzahlBisHoch'));
    });

    /// Eine feste Stufe ist eine Ansage. Regelte die Automatik weiter, waere
    /// die Auswahl im Fenster wirkungslos — und niemand wuesste, warum.
    test('eine feste Stufe haelt den Regler an', () {
      final quelle =
          File('lib/services/remote_agent_service.dart').readAsStringSync();
      final block = quelle.substring(quelle.indexOf('bildgueteSetzen(Bildguete g)'));
      expect(block.indexOf('_reglerStoppen()'), greaterThan(-1));
      expect(block.indexOf('_reglerStarten()'),
          lessThan(block.indexOf('_reglerStoppen()')));
    });

    test('es gibt genau drei Stufen, Automatik zuerst', () {
      expect(Bildguete.alle.first, Bildguete.automatik);
      expect(Bildguete.alle.length, 3);
    });

    /// ⚠️ Auf einem geteilten Telefonbildschirm wird GELESEN. „Scharf" darf
    /// deshalb nicht verkleinern — sonst ist die Schrift weg, und genau dafür
    /// wählt man die Stufe.
    test('keine Stufe verkleinert — auf einem Telefon wird gelesen', () {
      for (final g in Bildguete.alle) {
        expect(g.verkleinern, 1.0, reason: '${g.name} verkleinert');
      }
    });

    /// Ein unbekannter Name kommt von einer neueren Vorsitzer-App. Dann gilt
    /// die Automatik — nicht die schaerfste Stufe, die die Leitung fluten
    /// wuerde, und nicht die schwaechste, die grundlos Qualitaet kostet.
    test('ein unbekannter Name fällt auf die Automatik zurück', () {
      expect(Bildguete.vonName('gibtsnicht'), Bildguete.automatik);
      expect(Bildguete.vonName(null), Bildguete.automatik);
      expect(Bildguete.vonName('ausgewogen'), Bildguete.automatik,
          reason: 'die Stufe gibt es nicht mehr');
      expect(Bildguete.vonName('scharf'), Bildguete.scharf);
      expect(Bildguete.vonName('fluessig'), Bildguete.fluessig);
    });

    /// 🔴 Die Güte ist KEINE Eingabe. Stünde sie hinter der
    /// Steuerungsprüfung in `_handleInput`, hätte der Vorsitz auf genau den
    /// Geräten keinen Einfluss darauf, auf denen er ohnehin nur zuschauen kann
    /// (iOS, Android ohne freigegebenen Dienst).
    test('der q-Rahmen wird VOR der Steuerungsprüfung behandelt', () {
      final quelle =
          File('lib/services/remote_agent_service.dart').readAsStringSync();
      final rumpf = quelle.substring(quelle.indexOf('void _handleInput('));
      final guete = rumpf.indexOf("m['t'] == 'q'");
      final pruefung = rumpf.indexOf('!injector.isSupported');
      expect(guete, greaterThan(-1));
      expect(guete, lessThan(pruefung),
          reason: 'sonst greift sie auf reinen Ansichts-Geräten nicht');
    });

    test('30 Bilder je Sekunde sind moeglich, nicht auf 15 festgenagelt', () {
      expect(Bildguete.automatik.fps, greaterThanOrEqualTo(30));
      expect(Bildguete.fluessig.fps, greaterThanOrEqualTo(30));
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  /// 🔴 Auf einem Schreibtisch mit zwei Monitoren war die Wahl ein Muenzwurf:
  /// `DesktopCapturerSource` traegt kein Merkmal fuer „der Hauptbildschirm"
  /// (nur id, name, type, Vorschaubild), also wurde immer der erste genommen —
  /// womoeglich der leere. Betrifft die Windows-Mitglieder.
  group('Bildschirmwahl auf dem Schreibtisch', () {
    final quelle =
        File('lib/services/remote_agent_service.dart').readAsStringSync();

    test('die Monitornamen gehen mit der Antwort mit', () {
      expect(quelle, contains('bildschirme: _bildschirme'));
      expect(File('lib/services/chat_service.dart').readAsStringSync(),
          contains("'bildschirme': bildschirme"));
    });

    /// `replaceTrack` statt neu aushandeln: die Verbindung bleibt bestehen,
    /// es gibt kein Ruckeln durch ein zweites Angebot.
    test('gewechselt wird per replaceTrack, ohne Neuverhandlung', () {
      expect(quelle, contains('replaceTrack(neueSpur)'));
      expect(quelle.contains('createOffer'), isFalse,
          reason: 'der Agent antwortet, er verhandelt nicht neu');
    });

    /// ⚠️ Erst tauschen, dann die alte Spur stoppen. Andersherum stuende beim
    /// Vorsitz kurz gar kein Bild.
    test('die alte Spur wird erst NACH dem Tausch gestoppt', () {
      final rumpf = quelle.substring(quelle.indexOf('bildschirmWaehlen(int nr)'));
      expect(rumpf.indexOf('replaceTrack'), lessThan(rumpf.indexOf('t.stop()')));
    });

    test('auf dem Telefon gibt es nichts zu waehlen', () {
      final rumpf = quelle.substring(quelle.indexOf('bildschirmWaehlen(int nr)'));
      expect(rumpf.substring(0, 200), contains('Platform.isAndroid'));
    });

    /// Wie die Guete ist die Bildschirmwahl KEINE Eingabe — sie muss auch dort
    /// greifen, wo gar nicht gesteuert werden kann.
    test('der s-Rahmen wird VOR der Steuerungspruefung behandelt', () {
      final rumpf = quelle.substring(quelle.indexOf('void _handleInput('));
      expect(rumpf.indexOf("m['t'] == 's'"),
          lessThan(rumpf.indexOf('!injector.isSupported')));
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  group('Android: Maus wird zu Gesten', () {
    const kanal = MethodChannel('de.icd360sev.mitglied/fernsteuerung');
    late List<MethodCall> rufe;
    late bool dienstLaeuft;

    setUp(() {
      rufe = [];
      dienstLaeuft = true;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(kanal, (ruf) async {
        rufe.add(ruf);
        if (ruf.method == 'verfuegbar') return dienstLaeuft;
        return true;
      });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(kanal, null);
    });

    Future<AndroidInputInjector> bereit() async {
      final i = AndroidInputInjector();
      await i.vorbereiten();
      rufe.clear();
      return i;
    }

    List<MethodCall> zuege() => rufe.where((r) => r.method == 'zug').toList();

    test('kurz gedrueckt am selben Punkt ergibt einen Tipp', () async {
      final i = await bereit();
      await i.mouseMove(0.4, 0.6);
      await i.mouseButton(0, true);
      await i.mouseButton(0, false);

      expect(zuege().length, 1);
      final a = zuege().single.arguments as Map;
      expect(a['x1'], closeTo(0.4, 1e-9));
      expect(a['x2'], closeTo(0.4, 1e-9), reason: 'ein Tipp bewegt sich nicht');
      expect(a['ms'] as int, lessThan(500), reason: 'kurz, sonst waere es ein langes Tippen');
    });

    test('die rechte Maustaste ergibt ein langes Tippen', () async {
      final i = await bereit();
      await i.mouseMove(0.2, 0.3);
      await i.mouseButton(2, true);
      await i.mouseButton(2, false);

      final a = zuege().single.arguments as Map;
      expect(a['ms'] as int, greaterThanOrEqualTo(500),
          reason: 'Rechtsklick heisst auf dem Touchgeraet Kontextmenue');
    });

    test('gedrueckt ziehen ergibt ein Wischen von A nach B', () async {
      final i = await bereit();
      await i.mouseMove(0.1, 0.8);
      await i.mouseButton(0, true);
      await i.mouseMove(0.1, 0.2);
      await i.mouseButton(0, false);

      final a = zuege().single.arguments as Map;
      expect(a['y1'], closeTo(0.8, 1e-9));
      expect(a['y2'], closeTo(0.2, 1e-9));
    });

    /// ⚠️ Nach unten scrollen heisst: der Inhalt wandert nach oben, der Finger
    /// wischt also nach OBEN. Ein Vorzeichenfehler faellt am Geraet sofort auf,
    /// ist aber genau das Detail, das man beim Nachbauen verdreht.
    test('Rad nach unten wischt nach oben', () async {
      final i = await bereit();
      await i.mouseMove(0.5, 0.5);
      await i.mouseWheel(0, 120);
      await Future<void>.delayed(const Duration(milliseconds: 200));

      final a = zuege().single.arguments as Map;
      expect(a['y2'] as double, lessThan(a['y1'] as double));
    });

    test('ein Schub Radereignisse wird zu EINER Geste zusammengefasst', () async {
      final i = await bereit();
      await i.mouseMove(0.5, 0.5);
      for (var n = 0; n < 8; n++) {
        await i.mouseWheel(0, 40);
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(zuege().length, 1,
          reason: 'eine Geste je Ereignis wuerde die laufende jeweils abbrechen');
    });

    /// Der Dienst laeuft, sobald das Mitglied ihn eingeschaltet hat — auch
    /// ausserhalb einer Sitzung. Ist er nicht eingeschaltet, darf nichts
    /// hinausgehen, statt am Kanal abzuprallen.
    test('ohne eingeschalteten Dienst geht keine Geste hinaus', () async {
      dienstLaeuft = false;
      final i = AndroidInputInjector();
      await i.vorbereiten();
      expect(i.isSupported, isFalse);
      rufe.clear();

      await i.mouseMove(0.5, 0.5);
      await i.mouseButton(0, true);
      await i.mouseButton(0, false);
      await i.mouseWheel(0, 120);
      await i.systemAktion('home');
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(rufe, isEmpty);
    });

    test('das Sitzungsende sperrt die Steuerung wieder zu', () async {
      final i = await bereit();
      i.dispose();
      await Future<void>.delayed(Duration.zero);

      final frei = rufe.where((r) => r.method == 'freigeben').toList();
      expect(frei.single.arguments['frei'], isFalse,
          reason: 'sonst blieben Gesten nach der Sitzung erlaubt');
    });

    test('Escape wird zu Zurueck, andere Tasten fallen weg', () async {
      final i = await bereit();
      await i.keyEvent(hid: 0x29, character: null, down: true); // Escape
      await i.keyEvent(hid: 0x04, character: 'a', down: true);  // Buchstabe a

      final aktionen = rufe.where((r) => r.method == 'aktion').toList();
      expect(aktionen.length, 1);
      expect(aktionen.single.arguments['name'], 'back');
    });
  });
}
