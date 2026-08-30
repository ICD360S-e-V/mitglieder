import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'api_service.dart';
import 'chat_service.dart';
import 'logger_service.dart';
import 'secure_screen.dart';
import 'remote_input/input_injector.dart';

final _log = LoggerService();

/// Lifecycle of a Fernwartung session on the AGENT (member) side.
enum RemoteAgentState { idle, connecting, active }

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
        final stun = uris.where((u) => u.startsWith('stun:')).toList();
        final turn = uris.where((u) => u.startsWith('turn:') || u.startsWith('turns:')).toList();
        final servers = <Map<String, dynamic>>[
          if (stun.isNotEmpty) {'urls': stun},
          if (turn.isNotEmpty) {'urls': turn, 'username': username, 'credential': password},
        ];
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
      // app (otherwise the shared screen is black). Restored on cleanup.
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

      // Android 14+: the mediaProjection foreground service MUST be running
      // before getDisplayMedia, or MediaProjection throws (crash) and the capture
      // dies when the app backgrounds.
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
          await _pc!.addTrack(track, _mikroStream!);
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
      );

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
    // ⚠️ Der Systemdialog von Android ist NICHT zu umgehen und auch nicht
    // vorauszuwaehlen: er IST die Einwilligung, die das Betriebssystem
    // verlangt. „Ganzen Bildschirm" ohne Rueckfrage ginge nur mit
    // MediaProjectionConfig.createConfigForDefaultDisplay() (API 34+), und
    // flutter_webrtc 1.6.0 reicht das nicht durch. Ohne Angabe steht der
    // Dialog auf dem ganzen Bildschirm — mehr ist von hier aus nicht zu holen.
    if (!Platform.isAndroid) {
      try {
        final sources = await desktopCapturer.getSources(types: [SourceType.Screen]);
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
    final injector = _injector;
    if (injector == null || !injector.isSupported) return; // view-only: ignore
    try {
      final m = jsonDecode(text) as Map<String, dynamic>;
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
