import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'api_service.dart';
import 'chat_service.dart';
import 'voice_call_service.dart' show iceServerEintraege;
import 'logger_service.dart';
import 'secure_screen.dart';
import 'remote_input/input_injector.dart';

final _log = LoggerService();

/// Lifecycle of a Fernwartung session on the AGENT (member) side.
enum RemoteAgentState { idle, connecting, active }

/// Wie der Bildstrom eingestellt wird.
///
/// ⚠️ Die Zahlen sind nicht geraten, sondern folgen den eigenen Messungen des
/// Vereins (Speedtest-Reihe): der Telekom-Uplink schafft im Median rund
/// 18 Mbit/s, bricht aber in 34 % der Messungen unter 7,5 Mbit/s ein — und vor
/// allem zeigt er **schweren Bufferbloat**: Latenz unter Last bis 7402 ms, in
/// 32 % der Läufe mehr als das Zehnfache des Ruhewerts.
///
/// Genau daher kommt die Verzögerung von ein bis zwei Sekunden: WebRTC dreht
/// die Bitrate hoch, bis der Puffer des Funkmodems voll ist, und ab da läuft
/// das Bild hinterher. Ein Deckel WEIT unter der Leitung ist deshalb nicht
/// Sparsamkeit, sondern die eigentliche Reparatur — man muss die Leitung
/// bewusst nicht ausreizen.
class Bildguete {
  final String name;
  final int kbit;
  final int fps;
  final double verkleinern;

  /// Was aufgegeben wird, wenn die Bandbreite knapp wird.
  ///
  /// ⚠️ Das ist die eigentliche Entscheidung „flüssig oder scharf", nicht die
  /// Bitrate. W3C bildet dafür `contentHint` ab — `motion` → maintain-framerate,
  /// `detail`/`text` → maintain-resolution. flutter_webrtc reicht `contentHint`
  /// nicht durch (nachgesehen: kein Treffer in Dart noch nativ), also wird
  /// direkt die Präferenz gesetzt, die intern ohnehin daraus entsteht.
  final RTCDegradationPreference nachgeben;

  const Bildguete(
      this.name, this.kbit, this.fps, this.verkleinern, this.nachgeben);

  /// Voreinstellung: regelt sich selbst (siehe [_regelTakt]).
  ///
  /// ⚠️ Der Deckel ist bewusst HOCH. Er ist keine Sparmassnahme — die Leitung
  /// schafft im Median rund 18 Mbit/s, und ein fester Deckel von 2,5 Mbit/s
  /// hätte sie künstlich gedrosselt. Was die Verzögerung verhindert, ist nicht
  /// ein niedriger Deckel, sondern die Regelung auf Umlaufzeit: sie merkt, wenn
  /// sich eine Warteschlange bildet, und geht VORHER zurück.
  static const automatik = Bildguete(
      'automatik', 2500, 30, 1.0, RTCDegradationPreference.MAINTAIN_RESOLUTION);

  /// „Flüssig": Bewegung zählt mehr als Schärfe.
  /// Bei Enge fällt die Auflösung, die Bildrate bleibt.
  static const fluessig = Bildguete(
      'fluessig', 2000, 30, 1.0, RTCDegradationPreference.MAINTAIN_FRAMERATE);

  /// „Scharf": Schrift zählt mehr als Bewegung.
  /// Bei Enge fallen Bilder aus, die Auflösung bleibt.
  static const scharf = Bildguete(
      'scharf', 4000, 15, 1.0, RTCDegradationPreference.MAINTAIN_RESOLUTION);

  static const alle = [automatik, fluessig, scharf];

  static Bildguete vonName(String? n) =>
      alle.firstWhere((g) => g.name == n, orElse: () => automatik);
}

/// RemoteAgentService — the member side of Fernwartung (RustDesk-style remote
/// support). It is completely separate from voice calls and from the
/// RDP/Guacamole office remote desktop.
///
/// Flow: the member accepts a consent prompt → this service captures the screen
/// (getDisplayMedia), answers the Vorsitzer's WebRTC offer, and pipes the
/// incoming input DataChannel into the native [InputInjector]. NOTHING starts
/// before consent, and the member can [stop] at any time.
///
/// WebRTC roles: the Vorsitzer is the offerer (it creates the offer + the input
/// data channel); this side is the answerer that adds the screen track and
/// receives the data channel.
class RemoteAgentService {
  static final RemoteAgentService _instance = RemoteAgentService._internal();
  factory RemoteAgentService() => _instance;
  RemoteAgentService._internal();

  final ChatService _chat = ChatService();

  RTCPeerConnection? _pc;
  MediaStream? _screenStream;
  MediaStream? _mikroStream;
  RTCDataChannel? _inputChannel;
  InputInjector? _injector;

  int? _conversationId;
  String? _controllerName;
  bool _remoteDescriptionSet = false;
  final List<RTCIceCandidate> _queuedIce = [];

  StreamSubscription<RemoteIceEvent>? _iceSub;
  StreamSubscription<RemoteEndedEvent>? _endedSub;
  Timer? _vormerkUhr;

  final _stateController = StreamController<RemoteAgentState>.broadcast();
  RemoteAgentState _state = RemoteAgentState.idle;

  Stream<RemoteAgentState> get stateStream => _stateController.stream;
  RemoteAgentState get state => _state;
  String? get controllerName => _controllerName;

  /// Wie viele Kandidaten warten gerade — fuer den Test, der belegt, dass die
  /// Vormerkung greift. Ohne sie ist der Fehler von aussen unsichtbar: alles
  /// sieht normal aus, nur die Verbindung kommt nie zustande.
  int get vorgemerkteKandidaten => _queuedIce.length;

  /// True while a session is being set up or is live — drives the "screen is
  /// being shared" banner on the member UI.
  bool get isSharing => _state != RemoteAgentState.idle;

  /// Kurzname der Plattform fuers Pruefprotokoll. Bewusst grob — es geht um
  /// „konnte hier ueberhaupt gesteuert werden", nicht um Geraeteerkennung.
  String _plattformName() {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isWindows) return 'windows';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isLinux) return 'linux';
    return 'unbekannt';
  }

  void _setState(RemoteAgentState s) {
    _state = s;
    if (!_stateController.isClosed) _stateController.add(s);
  }

  // ─── TURN credentials (own coturn only; GDPR: no third-party STUN) ──────────
  // Local copy of the voice-service pattern so this feature stays isolated.
  static Map<String, dynamic>? _cachedIceServers;
  static DateTime? _cacheExpiry;

  static Future<Map<String, dynamic>> _getIceServers() async {
    if (_cachedIceServers != null && _cacheExpiry != null && DateTime.now().isBefore(_cacheExpiry!)) {
      return _cachedIceServers!;
    }
    const empty = {'iceServers': <Map<String, dynamic>>[]};
    try {
      final token = ApiService().token;
      if (token == null) return empty;
      final httpClient = HttpClient()..connectionTimeout = const Duration(seconds: 10);
      final client = IOClient(httpClient);
      try {
        final response = await client.get(
          Uri.parse('${ApiService.baseUrl}/auth/turn_credentials.php'),
          headers: {'Authorization': 'Bearer $token'},
        ).timeout(const Duration(seconds: 10));
        if (response.statusCode != 200) return empty;
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final uris = (data['uris'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
        final username = data['username']?.toString();
        final password = data['password']?.toString();
        if (uris.isEmpty || username == null || password == null) return empty;
        // 🔴 EIN EINTRAG JE URI — niemals eine `urls`-LISTE.
        //
        // Hier stand die gruppierte Form, und auf dem Schreibtisch ist sie
        // toedlich: die C++-Bruecke von flutter_webrtc (Windows und Linux
        // teilen sich `common/cpp/src/flutter_webrtc_base.cc`) liest `urls` in
        // `IceServer.uri` — einen EINZELNEN String — und ueberschreibt ihn in
        // jedem Schleifendurchlauf. Von N URIs ueberlebt nur die LETZTE.
        // Android hat seinen eigenen Java-Pfad und behaelt alle; deshalb fiel
        // der Fehler mit Mitgliedern auf Telefonen nie auf.
        //
        // Die letzte URI ist `turns:…:5349` — genau der Transportweg, dessen
        // TLS-Handschlag libwebrtc nicht zustande bringt (der eingebaute
        // Wurzelspeicher `ssl_roots.h` kennt die Let's-Encrypt-Kette nicht).
        // Ergebnis: null Relay-Kandidaten, und mit `iceTransportPolicy: relay`
        // heisst das null Kandidaten ueberhaupt — die Sitzung wird angenommen
        // und traegt nie ein Bild.
        //
        // Im coturn-Log sieht das so aus: `tls connected to 95.90.47.170`,
        // sofort danach `TLS/TCP socket disconnected` und `user <>` — also
        // keine Anmeldung, keine Allokation.
        //
        // Der Anrufdienst hatte denselben Fehler schon einmal und bekam dafuer
        // `iceServerEintraege()`. Die Fernwartung hat ihn nie benutzt.
        final servers = iceServerEintraege(uris, username, password);
        if (servers.isEmpty) return empty;
        _cachedIceServers = {'iceServers': servers};
        final ttl = (data['ttl'] as num?)?.toInt() ?? 86400;
        _cacheExpiry = DateTime.now().add(Duration(seconds: ttl > 60 ? (ttl * 9 ~/ 10) : ttl));
        return _cachedIceServers!;
      } finally {
        client.close();
      }
    } catch (e) {
      debugPrint('[RemoteAgent] TURN fetch error: $e');
      return empty;
    }
  }

  // ─── Public API ─────────────────────────────────────────────────────────────

  /// 🔴 AB HIER die ICE-Kandidaten des Vorsitzes einsammeln — nicht erst nach
  /// dem Antworten.
  ///
  /// `remoteIceStream` ist ein **Broadcast**-Stream: was ankommt, waehrend
  /// niemand zuhoert, ist weg. Abonniert wurde bisher erst in
  /// [_subscribeSession], also NACH `sendRemoteAnswer` — der Vorsitz sammelt
  /// seine Kandidaten aber schon Sekundenbruchteile nach dem Angebot, waehrend
  /// hier noch der Zustimmungsdialog offen steht. Alle drei fielen so ins
  /// Leere.
  ///
  /// Belegt am 30.08.2026 im coturn-Log: der Vorsitz legte 18 Permissions an
  /// und schickte 69 Pruefpakete, das Mitglied **null** — ein ICE-Agent ohne
  /// Gegenkandidaten faengt gar nicht erst an. Der Bildschirm des Mitglieds
  /// stand dabei auf „Verbindung wird aufgebaut", der des Vorsitzes auf
  /// „Warten auf Zustimmung": beide Meldungen zeigten auf den falschen Schritt.
  ///
  /// Wird beim Anzeigen des Zustimmungsdialogs gerufen. Sagt das Mitglied Nein
  /// oder antwortet es gar nicht, raeumt [_vormerkUhr] wieder auf.
  void angebotVormerken(RemoteOfferEvent offer) {
    if (_state != RemoteAgentState.idle) return;
    _vormerkUhr?.cancel();
    _iceSub?.cancel();
    _conversationId = offer.conversationId;
    _queuedIce.clear();
    _iceSub = _chat.remoteIceStream.listen((e) {
      if (e.conversationId == _conversationId) handleIce(e);
    });
    // Etwas mehr als die 60 s, nach denen der Vorsitz aufgibt.
    _vormerkUhr = Timer(const Duration(seconds: 90), () {
      if (_state == RemoteAgentState.idle) vormerkungVerwerfen();
    });
    _log.info('RemoteAgent: sammle ICE ab Angebot (conv ${offer.conversationId})', tag: 'REMOTE');
  }

  /// Zuruecknehmen, wenn nicht zugestimmt wurde.
  void vormerkungVerwerfen() {
    _vormerkUhr?.cancel();
    _vormerkUhr = null;
    _iceSub?.cancel();
    _iceSub = null;
    _queuedIce.clear();
    if (_state == RemoteAgentState.idle) _conversationId = null;
  }

  /// Member accepted the consent prompt: capture the screen and answer the offer.
  /// Returns false if setup failed (surface an error to the member).
  Future<bool> accept(RemoteOfferEvent offer) async {
    if (_state != RemoteAgentState.idle) return false;
    // ⚠️ `_queuedIce` NICHT leeren: darin liegen die Kandidaten, die waehrend
    // des Zustimmungsdialogs eingetroffen sind. Genau die fehlten bisher.
    _vormerkUhr?.cancel();
    _vormerkUhr = null;
    if (_iceSub == null) angebotVormerken(offer);
    _conversationId = offer.conversationId;
    _controllerName = offer.controllerName;
    _setState(RemoteAgentState.connecting);

    try {
      // Join the conversation room so ICE/lifecycle frames from the Vorsitzer
      // reach us (the initial remote_offer arrives via server fan-out, but the
      // rest is room-broadcast). Members are otherwise only in a room when the
      // chat is open.
      _chat.joinConversation(offer.conversationId);
      // Android: drop FLAG_SECURE so MediaProjection can actually capture the
      // app. Restored on cleanup.
      //
      // ⚠️ PRAEZISIERT (nachgelesen, nicht erinnert): FLAG_SECURE schwaerzt in
      // der Aufnahme NUR das markierte Fenster, nicht den ganzen Bildschirm.
      // Ein durchgehend schwarzes Bild — auch in fremden Apps — hat also eine
      // ANDERE Ursache und ist am `BildBefund` des Vorsitzes abzulesen.
      // (Auf einzelnen Hersteller-ROMs schwaerzt es doch die ganze Anzeige;
      // darauf darf man sich aber nicht als Erklaerung stuetzen.)
      //
      // ⚠️ Das Ergebnis wird AUSGEWERTET. Bleibt die Sperre stehen, sieht der
      // Vorsitz ein schwarzes Bild und haelt es fuer ein Netzproblem — die
      // Sitzung laeuft weiter, aber der Grund steht im Protokoll und geht mit
      // der Antwort an die Gegenseite.
      _sperreOffen = await SecureScreen.setSecure(false);
      if (!_sperreOffen) {
        _log.error('RemoteAgent: FLAG_SECURE liess sich NICHT aufheben — '
            'das geteilte Bild bleibt schwarz', tag: 'REMOTE');
      }
      _injector = createInputInjector();
      // ⚠️ Muss VOR dem Antworten passieren: auf Android steht erst danach fest,
      // ob gesteuert werden darf, und genau das wird der Gegenseite gemeldet.
      // Ohne diesen Aufruf bliebe isSupported dort dauerhaft false.
      await _injector!.vorbereiten();
      await _createPeerConnection();

      // 🔴 REIHENFOLGE: Zustimmung → Vordergrunddienst → Aufnahme.
      //
      // Hier stand es genau ANDERSHERUM, mit dem Kommentar „the foreground
      // service MUST be running before getDisplayMedia". Die Android-Doku sagt
      // das Gegenteil, woertlich:
      //
      //   „Call createScreenCaptureIntent() BEFORE starting the foreground
      //    service. Doing so shows a permission notification to the user; the
      //    user must grant the permission BEFORE you can create the service.
      //    After you have created the foreground service, you can call
      //    MediaProjectionManager.getMediaProjection()."
      //   — developer.android.com/develop/background-work/services/fgs/service-types
      //
      // Ein `mediaProjection`-Dienst, der VOR der Zustimmung startet, erfuellt
      // seine Voraussetzung nicht — und ein schwarzes Bild sieht dabei aus wie
      // ein Netzproblem.
      //
      // ⚠️ Es bleibt bei EINEM Systemdialog: `requestCapturePermission` legt
      // das Ergebnis in `mediaProjectionData` ab, und `getDisplayMedia` fragt
      // nur nach, wenn das Feld leer ist (`GetUserMediaImpl.getDisplayMedia`).
      await _bildschirmFreigabeHolen();
      await ScreenCaptureFgService.start();

      // Capture the whole screen and add its track(s) to the connection.
      _screenStream = await _captureScreen();
      for (final track in _screenStream!.getTracks()) {
        await _pc!.addTrack(track, _screenStream!);
      }

      // Sprechen waehrend der Sitzung. ⚠️ Getrennt vom Bildschirm geholt:
      // `getDisplayMedia` mit `audio: true` liefert auf Android den SYSTEMTON,
      // nicht das Mikrofon — man wuerde sich selbst hoeren und das Mitglied
      // trotzdem nicht.
      _mikroStream = await _mikrofonHolen();
      if (_mikroStream != null) {
        for (final track in _mikroStream!.getTracks()) {
          // 🔴 Der Ton geht in DIESELBE Spurgruppe wie der Bildschirm.
          //
          // Vorher hing er an `_mikroStream`, also an einem zweiten Stream.
          // Beim Vorsitz feuert `onTrack` je Spur, und wer dort blind
          // `event.streams[0]` nimmt, ueberschreibt den Bildschirm mit dem Ton,
          // sobald der als zweiter eintrifft — der Renderer haengt dann an
          // einem Stream ohne Videospur und zeigt SCHWARZ
          // (`FlutterRTCVideoRenderer.setStream` nimmt `videoTracks.get(0)`
          // und sonst `null`).
          //
          // Der eigentliche Fehler lag beim Vorsitz und ist dort behoben
          // (vorsitzer#523). Das hier ist die zweite Haelfte: mit EINER
          // Spurgruppe enthaelt `streams[0]` immer auch das Bild, und ein noch
          // nicht aktualisierter Vorsitzer-Client zeigt trotzdem etwas. Waehrend
          // der Auslieferung ist genau das der Unterschied zwischen „geht" und
          // „schwarz".
          //
          // ⚠️ `_mikroStream` bleibt als eigenes Objekt bestehen — daran
          // haengen Stummschalten und das Aufraeumen der Spuren. Geteilt wird
          // nur die Kennung nach aussen.
          await _pc!.addTrack(track, _screenStream!);
        }
        _tonwegSetzen();
      }

      // Answer the Vorsitzer's offer.
      await _pc!.setRemoteDescription(RTCSessionDescription(offer.sdp, offer.sdpType));
      _remoteDescriptionSet = true;
      await _flushQueuedIce();
      final answer = await _pc!.createAnswer();
      await _pc!.setLocalDescription(answer);
      // Plattform und Steuerbarkeit gehen MIT der Antwort zurueck. Der Vorsitz
      // kann beides nicht wissen, wenn er die Anfrage stellt — er traegt sonst
      // „Steuerung erlaubt" ins Pruefprotokoll, wo gar keine moeglich war, und
      // sein Bildschirm verschweigt, dass Klicks ins Leere gehen.
      _chat.sendRemoteAnswer(
        offer.conversationId,
        answer.sdp ?? '',
        answer.type ?? 'answer',
        plattform: _plattformName(),
        steuerung: _injector?.isSupported ?? false,
        bildFrei: _sperreOffen,
        // Bei mehreren Monitoren war die Wahl bisher ein Münzwurf. Der Vorsitz
        // soll wenigstens WISSEN, dass es mehrere gibt, und umschalten können.
        bildschirme: _bildschirme,
      );

      // Erst NACH setLocalDescription: vorher hat der Sender noch keine
      // Encodings, und setParameters liefe ins Leere.
      await bildgueteSetzen(_guete);

      _subscribeSession();
      _log.info('RemoteAgent: answered offer, sharing screen (control=${_injector?.isSupported})', tag: 'REMOTE');
      return true;
    } catch (e) {
      _log.error('RemoteAgent: accept failed: $e', tag: 'REMOTE');
      stop(reason: 'error', notifyPeer: true);
      return false;
    }
  }

  /// Member declined the consent prompt.
  void decline(RemoteOfferEvent offer, {String reason = 'declined'}) {
    vormerkungVerwerfen();
    _chat.sendRemoteReject(offer.conversationId, reason);
    _log.info('RemoteAgent: declined offer from ${offer.controllerName}', tag: 'REMOTE');
  }

  /// Tear the session down. [notifyPeer] sends remote_end to the Vorsitzer
  /// (member pressed STOP); false when reacting to the peer ending it.
  void stop({String reason = 'member_stop', bool notifyPeer = true}) {
    if (_state == RemoteAgentState.idle) return;
    if (notifyPeer && _conversationId != null) {
      _chat.sendRemoteEnd(_conversationId!);
    }
    _log.info('RemoteAgent: stopping session ($reason)', tag: 'REMOTE');
    _cleanup();
    _setState(RemoteAgentState.idle);
  }

  /// Feed an ICE candidate from signaling (queued until the offer is applied).
  Future<void> handleIce(RemoteIceEvent e) async {
    // ⚠️ Die Pruefung gehoert HIERHER, nicht nur in den Zuhoerer: die Methode
    // ist oeffentlich, und ein Kandidat aus einer fremden Unterhaltung waere
    // in der Warteschlange nicht mehr von einem echten zu unterscheiden.
    if (_conversationId == null || e.conversationId != _conversationId) return;
    final cand = RTCIceCandidate(e.candidate, e.sdpMid, e.sdpMLineIndex);
    if (_pc == null || !_remoteDescriptionSet) {
      _queuedIce.add(cand);
      return;
    }
    try {
      await _pc!.addCandidate(cand);
    } catch (err) {
      _log.warning('RemoteAgent: addCandidate failed: $err', tag: 'REMOTE');
    }
  }

  // ─── Internals ────────────────────────────────────────────────────────────

  Future<void> _createPeerConnection() async {
    final iceServers = await _getIceServers();
    if ((iceServers['iceServers'] as List).isEmpty) {
      throw StateError('TURN_UNAVAILABLE');
    }
    // Same config as the proven voice path: relay-only via our coturn,
    // unified-plan, single bundled transport.
    _pc = await createPeerConnection({
      ...iceServers,
      'sdpSemantics': 'unified-plan',
      'iceTransportPolicy': 'relay',
      'bundlePolicy': 'max-bundle',
      'rtcpMuxPolicy': 'require',
    });

    _pc!.onIceCandidate = (c) {
      if (c.candidate != null && _conversationId != null) {
        _chat.sendRemoteIce(_conversationId!, c.candidate!, c.sdpMid ?? '', c.sdpMLineIndex ?? 0);
      }
    };

    _pc!.onConnectionState = (s) {
      _log.info('RemoteAgent: PC state $s', tag: 'REMOTE');
      if (s == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        _setState(RemoteAgentState.active);
      } else if (s == RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
          s == RTCPeerConnectionState.RTCPeerConnectionStateClosed ||
          s == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected) {
        stop(reason: 'disconnect', notifyPeer: false);
      }
    };

    // The Vorsitzer (offerer) creates the input channel; we receive it here.
    _pc!.onDataChannel = (channel) {
      _inputChannel = channel;
      channel.onMessage = (msg) => _handleInput(msg.text);
      _log.info('RemoteAgent: input data channel received (${channel.label})', tag: 'REMOTE');
    };
  }

  /// Holt die Bildschirmfreigabe — festgelegt auf den GANZEN Bildschirm.
  ///
  /// ⚠️ Der Systemdialog ist nicht zu UMGEHEN, er IST die Einwilligung, die
  /// Android verlangt. Aber er laesst sich FESTLEGEN:
  /// `requestCapturePermission(fullScreenOnly: true)` gibt ihm auf API 34+
  /// `MediaProjectionConfig.createConfigForDefaultDisplay()` mit, und die
  /// Auswahl „einzelne App" verschwindet.
  ///
  /// Fuer die Fernwartung ist das wesentlich: eine einzelne freigegebene App
  /// waere nutzlos — geholfen wird meist GERADE beim Wechsel in die
  /// Einstellungen oder eine andere App, und dort bliebe das Bild sonst leer.
  ///
  /// Faellt der Aufruf durch (aeltere Plugin-Fassung, Hersteller-Eigenheit),
  /// uebernimmt `getDisplayMedia` den gewohnten Dialog. Lieber die Auswahl als
  /// gar keine Aufnahme.
  Future<void> _bildschirmFreigabeHolen() async {
    if (!Platform.isAndroid) return;
    try {
      final erlaubt = await Helper.requestCapturePermission(fullScreenOnly: true);
      if (!erlaubt) throw StateError('BILDSCHIRM_ABGELEHNT');
    } on StateError {
      rethrow;
    } catch (e) {
      _log.warning('RemoteAgent: fullScreenOnly nicht moeglich ($e) — '
          'gewohnter Auswahldialog', tag: 'REMOTE');
    }
  }

  /// Namen der verfügbaren Bildschirme. Auf Android immer leer (dort gibt es
  /// nur die eine Anzeige), auf dem Schreibtisch einer je Monitor.
  List<String> get bildschirme => List.unmodifiable(_bildschirme);
  final List<String> _bildschirme = [];

  /// Welcher Monitor gerade geteilt wird — für die Anzeige und damit ein
  /// wiederholter Umschaltbefehl nicht unnötig neu aufnimmt.
  int get bildschirmNr => _bildschirmNr;
  int _bildschirmNr = 0;

  /// Auf einen anderen Monitor umschalten — ohne Neuverhandlung.
  ///
  /// ⚠️ Nötig geworden durch die Windows-Mitglieder: `getSources` liefert die
  /// Monitore in einer Reihenfolge, die KEIN Merkmal für „der Hauptbildschirm"
  /// enthält (nachgesehen: `DesktopCapturerSource` hat nur id, name, type und
  /// ein Vorschaubild). Bei zwei Monitoren war die Wahl damit ein Münzwurf,
  /// und der Vorsitz sah womöglich den leeren.
  ///
  /// `replaceTrack` tauscht die Spur im laufenden Sender aus; die Verbindung
  /// bleibt bestehen, es gibt kein Ruckeln durch ein neues Aushandeln.
  Future<bool> bildschirmWaehlen(int nr) async {
    if (Platform.isAndroid || Platform.isIOS) return false;
    if (nr < 0 || nr >= _bildschirme.length) return false;
    // Schon dort: ein zweiter Klick soll nicht die Aufnahme neu starten und
    // dabei das Bild kurz stehen lassen.
    if (nr == _bildschirmNr) return true;
    final pc = _pc;
    if (pc == null) return false;
    try {
      final quellen = await desktopCapturer.getSources(types: [SourceType.Screen]);
      if (nr >= quellen.length) return false;

      final neu = await navigator.mediaDevices.getDisplayMedia(<String, dynamic>{
        'video': {
          'deviceId': {'exact': quellen[nr].id},
          'mandatory': {'frameRate': 30.0},
        },
        'audio': false,
      });
      final neueSpur = neu.getVideoTracks().first;

      RTCRtpSender? bild;
      for (final sd in await pc.getSenders()) {
        if (sd.track?.kind == 'video') {
          bild = sd;
          break;
        }
      }
      if (bild == null) return false;
      await bild.replaceTrack(neueSpur);

      // Erst NACH dem Tausch aufräumen — sonst steht kurz gar kein Bild an.
      final alt = _screenStream;
      _screenStream = neu;
      _bildschirmNr = nr;
      try {
        for (final t in alt?.getVideoTracks() ?? const <MediaStreamTrack>[]) {
          await t.stop();
        }
      } catch (_) {}

      // Die Encodings hängen am Sender, nicht an der Spur — sie überleben den
      // Tausch. Trotzdem neu setzen: bei einem Monitor anderer Grösse würde
      // sonst eine Einstellung von der alten Auflösung weitergelten.
      await _bitrateSetzen(
          _guete == Bildguete.automatik ? _kbit : _guete.kbit,
          _guete.fps,
          _guete.verkleinern,
          _guete.nachgeben);
      _log.info('RemoteAgent: Bildschirm ${quellen[nr].name}', tag: 'REMOTE');
      return true;
    } catch (e) {
      _log.warning('RemoteAgent: Bildschirmwechsel fehlgeschlagen: $e', tag: 'REMOTE');
      return false;
    }
  }

  /// Capture the primary screen. Picks the first Screen source explicitly so the
  /// OS does not pop its own picker; falls back to a plain constraint.
  Future<MediaStream> _captureScreen() async {
    // iOS: only the ReplayKit broadcast upload extension can capture the WHOLE
    // screen. flutter_webrtc routes to it when video.deviceId starts with
    // 'broadcast' (and auto-presents the system broadcast picker). Without the
    // extension configured (see ios/BROADCAST_SETUP.md) this captures nothing
    // useful, so it is iOS-only and gated on the extension being wired.
    if (Platform.isIOS) {
      return navigator.mediaDevices.getDisplayMedia(<String, dynamic>{
        'video': {'deviceId': 'broadcast'},
        'audio': false,
      });
    }
    // ⚠️ Auf Android GAR NICHT erst ueber desktopCapturer: der Kanal heisst
    // `getDesktopSources` und ist dort nicht umgesetzt, der Aufruf endete also
    // jedes Mal in einer MissingPluginException und einer irrefuehrenden
    // Warnzeile im Protokoll. (Der naheliegende Verdacht, `getSources` liefere
    // auf Android Kameras statt Bildschirme, geht daneben — das ist ein
    // ANDERER Kanal, den desktopCapturer nicht benutzt.)
    //
    if (!Platform.isAndroid) {
      try {
        final sources = await desktopCapturer.getSources(types: [SourceType.Screen]);
        _bildschirme
          ..clear()
          ..addAll(sources.map((q) => q.name));
        if (sources.isNotEmpty) {
          // Der erste Bildschirm ist der ganze Bildschirm — kein Auswahlfenster
          // fuer das Mitglied, das gerade Hilfe braucht.
          final src = sources.first;
          return await navigator.mediaDevices.getDisplayMedia(<String, dynamic>{
            'video': {
              'deviceId': {'exact': src.id},
              'mandatory': {'frameRate': 15.0},
            },
            'audio': false,
          });
        }
      } catch (e) {
        _log.warning('RemoteAgent: desktopCapturer failed ($e), using default getDisplayMedia', tag: 'REMOTE');
      }
    }
    // Die Bildrate gehoert AUCH hierher: ohne Deckel schickt ein Telefon mit
    // hoher Bildwiederholrate ein Vielfaches durch das Relais, und die Strecke
    // ist ohnehin die schmale Stelle.
    return navigator.mediaDevices.getDisplayMedia(<String, dynamic>{
      'video': {'mandatory': {'frameRate': 15.0}},
      'audio': false,
    });
  }

  /// Mikrofon fuer das Gespraech waehrend der Sitzung.
  ///
  /// ⚠️ Gibt bei Ablehnung `null` zurueck und laesst die Sitzung WEITERLAUFEN.
  /// Wer sein Mikrofon nicht freigibt, will trotzdem Hilfe — die Fernwartung
  /// daran scheitern zu lassen, waere die falsche Reihenfolge. Der Vorsitz
  /// sieht dann „ohne Ton" und kann ueber den Chat schreiben.
  ///
  /// ⚠️ Die Berechtigung wurde bisher NUR im Anrufdialog erfragt
  /// (`incoming_call_dialog.dart`). Eine Fernwartung fragte auf keiner
  /// Android-Fassung nach dem Mikrofon — sie benutzte es ja auch nicht.
  Future<MediaStream?> _mikrofonHolen() async {
    try {
      // ⚠️ Kein permission_handler: `getUserMedia` mit Ton fragt RECORD_AUDIO
      // auf Android SELBST ab (GetUserMediaImpl.requestPermissions). Ein
      // zweiter Weg zur selben Berechtigung waere eine zweite Wahrheit —
      // und im Vorsitzer-Projekt gaebe es die Abhaengigkeit gar nicht.
      // Lehnt das Mitglied ab, wirft der Aufruf und wir landen im catch.
      return await navigator.mediaDevices.getUserMedia(<String, dynamic>{
        'audio': {
          'echoCancellation': true,
          'noiseSuppression': true,
          'autoGainControl': true,
        },
        'video': false,
      });
    } catch (e) {
      _log.warning('RemoteAgent: kein Mikrofon ($e) — Sitzung laeuft ohne Ton',
          tag: 'REMOTE');
      return null;
    }
  }

  /// Ton auf eine angeschlossene Kopfhoerergarnitur legen, sonst Lautsprecher.
  ///
  /// ⚠️ `setSpeakerphoneOn(true)` ERZWINGT den Lautsprecher und geht an einer
  /// verbundenen Bluetooth-Garnitur vorbei — genau der Fehler, den der
  /// Anrufdienst schon einmal hatte und mit dieser Funktion behoben hat
  /// (`voice_call_service._applyAudioRoute`). Die Fernwartung benutzte sie gar
  /// nicht: sie hatte bis jetzt keinen Ton.
  ///
  /// ⚠️ Muss NACH `getUserMedia` laufen. Vorher steht der AudioManager noch
  /// nicht auf MODE_IN_COMMUNICATION und die Umleitung wird verworfen.
  ///
  /// Lautsprecher als Rueckfall, nicht Hoermuschel: waehrend einer Fernwartung
  /// schaut man auf den Bildschirm, man haelt das Telefon nicht ans Ohr.
  void _tonwegSetzen() {
    try {
      if (Platform.isAndroid) {
        Helper.setSpeakerphoneOnButPreferBluetooth();
      } else if (Platform.isIOS) {
        Helper.setSpeakerphoneOn(true);
      }
      _log.info('RemoteAgent: Tonweg gesetzt (Kopfhoerer bevorzugt)', tag: 'REMOTE');
    } catch (e) {
      _log.warning('RemoteAgent: Tonweg nicht setzbar: $e', tag: 'REMOTE');
    }
  }

  Bildguete _guete = Bildguete.automatik;

  /// Aktuell eingestellte Bildgüte.
  Bildguete get guete => _guete;

  /// Bitrate, Bildrate und Auflösung des Bildstroms setzen.
  ///
  /// ⚠️ `MAINTAIN_RESOLUTION`, nicht `MAINTAIN_FRAMERATE`: auf einem geteilten
  /// Telefonbildschirm wird GELESEN. Wird es eng, sollen lieber Bilder
  /// ausfallen als die Schrift verschwimmen — bei `MAINTAIN_FRAMERATE` würde
  /// libwebrtc die Auflösung herunterfahren und der Text wäre nicht mehr zu
  /// entziffern.
  ///
  /// ⚠️ Das Plugin ignoriert auf Android die Aufnahme-Constraints und nimmt
  /// immer die volle Anzeige mit `DEFAULT_FPS = 30` auf
  /// (`GetUserMediaImpl.getDisplayMedia`). Begrenzt wird also NICHT die
  /// Aufnahme, sondern der Sender — hier, über die Encodings.
  ///
  /// Wirkt sofort und ohne Neuverhandlung.
  Future<bool> bildgueteSetzen(Bildguete g) async {
    _guete = g;
    if (g == Bildguete.automatik) {
      _reglerStarten();
    } else {
      // Eine feste Stufe ist eine Ansage, kein Vorschlag: der Regler darf sie
      // nicht gleich wieder wegregeln.
      _reglerStoppen();
    }
    return _bitrateSetzen(g.kbit, g.fps, g.verkleinern, g.nachgeben);
  }

  /// Setzt die Encodings des Bildsenders. Wirkt sofort, ohne Neuverhandlung.
  Future<bool> _bitrateSetzen(int kbit, int fps, double verkleinern,
      RTCDegradationPreference nachgeben) async {
    final pc = _pc;
    if (pc == null) return false;
    try {
      RTCRtpSender? bild;
      for (final s in await pc.getSenders()) {
        if (s.track?.kind == 'video') {
          bild = s;
          break;
        }
      }
      if (bild == null) return false;

      final p = bild.parameters;
      final enc = p.encodings;
      if (enc == null || enc.isEmpty) {
        p.encodings = [RTCRtpEncoding()];
      }
      for (final e in p.encodings!) {
        e.maxBitrate = kbit * 1000;
        e.maxFramerate = fps;
        e.scaleResolutionDownBy = verkleinern;
        // Der Bildschirm ist das Wichtigste an dieser Sitzung; bei knapper
        // Bandbreite soll er vor allem anderen bedient werden.
        e.priority = RTCPriorityType.high;
        e.networkPriority = RTCPriorityType.high;
      }
      p.degradationPreference = nachgeben;
      await bild.setParameters(p);
      _log.info('RemoteAgent: $kbit kbit/s, $fps fps, 1/$verkleinern',
          tag: 'REMOTE');
      return true;
    } catch (e) {
      _log.warning('RemoteAgent: Bitrate nicht setzbar: $e', tag: 'REMOTE');
      return false;
    }
  }

  // ─── Selbstregelung ────────────────────────────────────────────────────
  //
  // ⚠️ Warum überhaupt eine eigene Regelung, wo WebRTC doch selbst regelt?
  //
  // Die eingebaute Regelung wartet auf Paketverlust. Bei Bufferbloat kommt der
  // aber ZU SPÄT: das Funkmodem nimmt alles an und stellt es in eine lange
  // Warteschlange, statt zu verwerfen. Aus Sicht des Senders läuft alles
  // bestens — der Durchsatz stimmt, nichts geht verloren — während das Bild
  // beim Vorsitz ein bis zwei Sekunden hinterherhinkt. Die eigene
  // Speedtest-Reihe des Vereins hat genau das gemessen: Latenz unter Last bis
  // 7402 ms bei intakter Verbindung.
  //
  // Deshalb wird hier nicht auf Verlust, sondern auf **Verzögerung** geregelt:
  // steigt die Umlaufzeit über ihren eigenen Ruhewert, füllt sich eine
  // Warteschlange, und die Bitrate geht herunter, BEVOR etwas verloren geht.
  // Dasselbe Prinzip wie bei LEDBAT oder BBR.

  Timer? _reglerUhr;
  int _kbit = 0;
  final List<double> _rttProben = [];
  int _ruhigeTakte = 0;

  /// Untergrenze. Darunter ist ein Bildschirm nicht mehr zu gebrauchen — dann
  /// lieber ruckeln als unlesbar werden.
  static const int _kbitMin = 350;

  /// ⚠️ Hoch angesetzt, mit Absicht. Der Deckel soll die Leitung NICHT
  /// begrenzen — das macht die Regelung auf Umlaufzeit, und die kennt die
  /// wirkliche Grenze besser als jede feste Zahl. Ein niedriger Deckel hätte
  /// nur dafür gesorgt, dass eine gute Leitung ungenutzt bleibt.
  static const int _kbitMax = 8000;

  /// Ab dieser Überschreitung des Ruhewerts gilt die Leitung als verstopft.
  static const double _rttAufschlagMs = 120;

  /// So viele ruhige Takte, bevor wieder erhöht wird. Langsam hoch, schnell
  /// runter — die Verzögerung entsteht beim Hochgehen.
  static const int _taktzahlBisHoch = 3;

  void _reglerStarten() {
    _reglerUhr?.cancel();
    _rttProben.clear();
    _ruhigeTakte = 0;
    _kbit = Bildguete.automatik.kbit;
    _reglerUhr = Timer.periodic(const Duration(seconds: 2), (_) => _regelTakt());
  }

  void _reglerStoppen() {
    _reglerUhr?.cancel();
    _reglerUhr = null;
  }

  Future<void> _regelTakt() async {
    final pc = _pc;
    if (pc == null || _guete != Bildguete.automatik) return;
    try {
      double? rttMs;
      double? verfuegbarBit;
      String? grenze;

      for (final b in await pc.getStats()) {
        final w = b.values;
        if (b.type == 'candidate-pair' && w['nominated'] == true) {
          final rtt = w['currentRoundTripTime'];
          if (rtt is num) rttMs = rtt.toDouble() * 1000;
          final frei = w['availableOutgoingBitrate'];
          if (frei is num) verfuegbarBit = frei.toDouble();
        } else if (b.type == 'outbound-rtp' && w['kind'] == 'video') {
          final g = w['qualityLimitationReason'];
          if (g is String) grenze = g;
        }
      }
      if (rttMs == null) return;

      // Ruhewert = kleinste Umlaufzeit der letzten Minute. Ein gleitendes
      // Fenster, damit ein echter Netzwechsel neu geeicht wird, statt dass ein
      // einmal gemessener Bestwert die Regelung für immer festnagelt.
      _rttProben.add(rttMs);
      if (_rttProben.length > 30) _rttProben.removeAt(0);
      final ruhe = _rttProben.reduce((a, b) => a < b ? a : b);

      final verstopft = rttMs > ruhe + _rttAufschlagMs || grenze == 'bandwidth';
      var neu = _kbit;

      if (verstopft) {
        // Multiplikativ herunter: eine Warteschlange baut sich schnell auf,
        // additives Zurücknehmen käme zu spät.
        neu = (_kbit * 0.75).round();
        _ruhigeTakte = 0;
      } else if (++_ruhigeTakte >= _taktzahlBisHoch) {
        // ⚠️ Solange wir deutlich unter dem liegen, was WebRTC selbst für
        // möglich hält, wird MULTIPLIKATIV erhöht. Additiv wären es von
        // 2,5 auf 8 Mbit/s über zwei Minuten — die Sitzung wäre vorbei, bevor
        // die Leitung genutzt wird. Erst in der Nähe der Schätzung wird
        // vorsichtig getastet.
        final schaetzung = verfuegbarBit != null && verfuegbarBit > 0
            ? verfuegbarBit / 1000
            : null;
        neu = (schaetzung != null && _kbit < schaetzung * 0.7)
            ? (_kbit * 1.4).round()
            : _kbit + 250;
        _ruhigeTakte = 0;
      }

      // Nie über das, was WebRTC selbst für möglich hält — mit Reserve, damit
      // wir die Schätzung nicht selbst wieder aufwärts treiben.
      if (verfuegbarBit != null && verfuegbarBit > 0) {
        final deckel = (verfuegbarBit * 0.9 / 1000).round();
        if (neu > deckel) neu = deckel;
      }
      neu = neu.clamp(_kbitMin, _kbitMax);

      // Nur bei spürbarer Änderung setzen: jedes setParameters kostet einen
      // Sprung in der Kodierung, und ein Zappeln um 2 % sieht man als Ruckeln.
      if ((neu - _kbit).abs() * 100 ~/ _kbit >= 8) {
        _kbit = neu;
        await _bitrateSetzen(_kbit, Bildguete.automatik.fps, 1.0,
            Bildguete.automatik.nachgeben);
        _log.info('RemoteAgent: Automatik → $_kbit kbit/s '
            '(RTT ${rttMs.round()} ms, Ruhe ${ruhe.round()} ms'
            '${grenze != null ? ", Grenze $grenze" : ""})', tag: 'REMOTE');
      }
    } catch (e) {
      _log.warning('RemoteAgent: Regeltakt fehlgeschlagen: $e', tag: 'REMOTE');
    }
  }

  /// Aktuelle Bitrate der Automatik in kbit/s (0 = Automatik läuft nicht).
  int get automatikKbit => _guete == Bildguete.automatik ? _kbit : 0;

  /// Eigenes Mikrofon stummschalten, ohne die Sitzung zu beenden.
  void mikrofonStumm(bool stumm) {
    for (final t in _mikroStream?.getAudioTracks() ?? const <MediaStreamTrack>[]) {
      t.enabled = !stumm;
    }
  }

  /// Liegt ueberhaupt ein Mikrofon an? Fuer die Anzeige im Banner.
  bool get hatMikrofon => _mikroStream != null;

  /// Konnte FLAG_SECURE aufgehoben werden? Bei false ist das geteilte Bild
  /// schwarz, ohne dass die Verbindung etwas dafuer kann.
  bool get sperreOffen => _sperreOffen;
  bool _sperreOffen = true;

  /// Parse one input frame from the controller and drive the native injector.
  void _handleInput(String text) {
    final Map<String, dynamic> m;
    try {
      m = jsonDecode(text) as Map<String, dynamic>;
    } catch (e) {
      _log.warning('RemoteAgent: bad input frame: $e', tag: 'REMOTE');
      return;
    }

    // ⚠️ Die Bildgüte VOR der Steuerungsprüfung. Sie ist keine Eingabe: sie
    // regelt den Bildstrom und muss auch dann greifen, wenn dieses Gerät gar
    // nicht steuerbar ist (iOS, oder Android ohne freigegebenen Dienst). Stünde
    // sie hinter dem frühen Ausstieg, hätte der Vorsitz auf genau den Geräten
    // keinen Einfluss auf die Güte, auf denen er ohnehin nur zuschauen kann.
    if (m['t'] == 'q') {
      bildgueteSetzen(Bildguete.vonName(m['g']?.toString()));
      return;
    }
    // Bildschirmwahl — wie die Güte keine Eingabe, muss also auch auf reinen
    // Ansichts-Geräten greifen.
    if (m['t'] == 's') {
      final nr = m['i'];
      if (nr is num) bildschirmWaehlen(nr.toInt());
      return;
    }

    final injector = _injector;
    if (injector == null || !injector.isSupported) return; // view-only: ignore
    try {
      switch (m['t']) {
        case 'm':
          injector.mouseMove((m['x'] as num).toDouble(), (m['y'] as num).toDouble());
          break;
        case 'b':
          injector.mouseButton((m['b'] as num).toInt(), m['down'] == true);
          break;
        case 'w':
          injector.mouseWheel((m['dx'] as num?)?.toDouble() ?? 0, (m['dy'] as num?)?.toDouble() ?? 0);
          break;
        // Systemtaste ohne Koordinaten (Zurueck/Start/Uebersicht). Aeltere
        // Mitglieds-Apps kennen den Fall nicht und ignorieren ihn stumm — der
        // switch hat kein default, das ist hier die gewollte Vertraeglichkeit.
        case 'g':
          injector.systemAktion((m['a'] ?? '').toString());
          break;
        case 'k':
          injector.keyEvent(
            hid: (m['hid'] as num).toInt(),
            character: m['ch'] as String?,
            down: m['down'] == true,
          );
          break;
      }
    } catch (e) {
      _log.warning('RemoteAgent: bad input frame: $e', tag: 'REMOTE');
    }
  }

  void _subscribeSession() {
    // Laeuft schon seit dem Angebot (siehe [angebotVormerken]) — ein zweites
    // Abo wuerde jeden Kandidaten doppelt einspeisen.
    _iceSub ??= _chat.remoteIceStream.listen((e) {
      if (e.conversationId == _conversationId) handleIce(e);
    });
    _endedSub = _chat.remoteEndedStream.listen((e) {
      if (e.conversationId == _conversationId) stop(reason: 'controller_end', notifyPeer: false);
    });
  }

  Future<void> _flushQueuedIce() async {
    for (final c in _queuedIce) {
      try {
        await _pc!.addCandidate(c);
      } catch (_) {}
    }
    _queuedIce.clear();
  }

  void _cleanup() {
    _reglerStoppen();
    _vormerkUhr?.cancel();
    _vormerkUhr = null;
    // Restore the screenshot/recording block + stop the capture FG service.
    SecureScreen.setSecure(true);
    ScreenCaptureFgService.stop();
    _iceSub?.cancel();
    _endedSub?.cancel();
    _iceSub = null;
    _endedSub = null;
    try {
      _inputChannel?.close();
    } catch (_) {}
    _inputChannel = null;
    try {
      _screenStream?.getTracks().forEach((t) => t.stop());
      _screenStream?.dispose();
    } catch (_) {}
    _screenStream = null;
    _bildschirme.clear();
    _bildschirmNr = 0;
    try {
      _mikroStream?.getTracks().forEach((t) => t.stop());
      _mikroStream?.dispose();
    } catch (_) {}
    _mikroStream = null;
    try {
      _pc?.close();
    } catch (_) {}
    _pc = null;
    _injector?.dispose();
    _injector = null;
    _remoteDescriptionSet = false;
    _queuedIce.clear();
    _conversationId = null;
    _controllerName = null;
  }
}
