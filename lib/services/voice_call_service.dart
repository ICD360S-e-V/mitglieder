import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/io_client.dart';
import 'api_service.dart';
import 'logger_service.dart';

final _log = LoggerService();

/// Why a call failed to start. Lets the UI surface an actionable error
/// instead of a generic "unexpected" toast.
enum CallStartFailure {
  /// The OS denied microphone access (Windows Privacy / macOS System Prefs /
  /// Android runtime permission). User can fix this in system settings.
  micPermissionDenied,

  /// No usable microphone exists. Hardware missing, driver broken, or the
  /// device is exclusively held by another app.
  micNotFound,

  /// TURN credentials could not be fetched (offline / 401 / backend down). Our
  /// coturn is the only relay, so no call can be established without them.
  turnUnavailable,

  /// Something else — signaling or internal WebRTC error.
  unknown,
}

/// Voice Call Service using WebRTC for real-time audio communication
class VoiceCallService {
  // No fallback — if our TURN server is unreachable, calls cannot be established.
  // GDPR: we never send user IPs to third-party servers (e.g. Google STUN).
  static const Map<String, dynamic> _emptyIceServers = {
    'iceServers': <Map<String, dynamic>>[]
  };

  // Cached ICE servers from server (fetched at runtime)
  static Map<String, dynamic>? _cachedIceServers;
  static DateTime? _cacheExpiry;

  /// Fetch ephemeral TURN credentials from our backend and assemble the ICE
  /// server list. The server uses coturn's short-lived credentials (use-auth-
  /// secret / TURN REST API): it returns a time-limited username/password plus
  /// the URI list, and we build the iceServers here. GDPR: only our own coturn,
  /// never a third-party STUN. Cached until ~90% of the TTL so a new call never
  /// receives an already-expired credential.
  static Future<Map<String, dynamic>> _getIceServers() async {
    if (_cachedIceServers != null && _cacheExpiry != null && DateTime.now().isBefore(_cacheExpiry!)) {
      return _cachedIceServers!;
    }

    try {
      final apiService = ApiService();
      final token = apiService.token;
      if (token == null) {
        debugPrint('[VoiceCall] No token — call will fail (no ICE servers)');
        return _emptyIceServers;
      }

      final httpClient = HttpClient()..connectionTimeout = const Duration(seconds: 10);
      final client = IOClient(httpClient);
      try {
        final response = await client.get(
          Uri.parse('${ApiService.baseUrl}/auth/turn_credentials.php'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          // Ephemeral contract: { username, password, ttl, uris:[...] }. There
          // is no 'success' field — presence of uris + username + password is
          // the validity signal. The credential applies to every turn(s): URI.
          final uris = (data['uris'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
          final username = data['username']?.toString();
          final password = data['password']?.toString();

          if (uris.isNotEmpty && username != null && password != null) {
            final stunUris = uris.where((u) => u.startsWith('stun:')).toList();
            final turnUris = uris.where((u) => u.startsWith('turn:') || u.startsWith('turns:')).toList();

            final servers = <Map<String, dynamic>>[];
            if (stunUris.isNotEmpty) {
              servers.add({'urls': stunUris});
            }
            if (turnUris.isNotEmpty) {
              servers.add({
                'urls': turnUris,
                'username': username,
                'credential': password,
              });
            }

            if (servers.isNotEmpty) {
              _cachedIceServers = {'iceServers': servers};
              final ttl = (data['ttl'] as num?)?.toInt() ?? 86400;
              // Refresh before the credential actually expires (90% of TTL).
              final safeTtl = ttl > 60 ? (ttl * 9 ~/ 10) : ttl;
              _cacheExpiry = DateTime.now().add(Duration(seconds: safeTtl));
              debugPrint('[VoiceCall] Ephemeral TURN fetched (${servers.length} ICE entries), cached ${safeTtl}s of ${ttl}s TTL');
              return _cachedIceServers!;
            }
          }
          debugPrint('[VoiceCall] turn_credentials response missing uris/username/password — call will fail');
          return _emptyIceServers;
        }
        debugPrint('[VoiceCall] TURN fetch failed (${response.statusCode}) — call will fail (no ICE servers)');
        return _emptyIceServers;
      } finally {
        client.close();
      }
    } catch (e) {
      debugPrint('[VoiceCall] TURN fetch error: $e — call will fail (no ICE servers)');
      return _emptyIceServers;
    }
  }

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  // ICE Candidate Queuing (Fix 1)
  final List<RTCIceCandidate> _queuedIceCandidates = [];
  bool _remoteDescriptionSet = false;

  // Call state
  CallState _callState = CallState.idle;
  int? _currentConversationId;
  bool _isMuted = false;
  bool _isSpeakerOn = false; // audio calls start on the earpiece; video → speaker
  bool _isVideoCall = false; // this call negotiated video (camera)
  bool _isCameraOff = false; // user toggled the local camera off
  Timer? _statsTimer; // periodic getStats logging for ICE diagnostics
  AudioPlayer? _ringbackPlayer; // looping "ring-ring" for the caller
  AudioPlayer? _sfxPlayer; // one-shot busy/rejected tone

  /// Set when [startCall] returns false. Reset to null at the start of every
  /// [startCall]. Callers read this to show a specific user-facing message.
  CallStartFailure? _lastStartFailure;
  CallStartFailure? get lastStartFailure => _lastStartFailure;

  // Stream controllers for UI updates
  final _callStateController = StreamController<CallState>.broadcast();
  final _remoteStreamController = StreamController<MediaStream?>.broadcast();
  final _incomingCallController = StreamController<IncomingCall>.broadcast();
  // Real ICE connection state for the network-quality indicator (#6a).
  // Mirrors the vorsitzer app's VoiceCallService (shared contract) so the two
  // ends stay convergent.
  final _iceConnectionStateController = StreamController<RTCIceConnectionState?>.broadcast();

  // Public streams
  Stream<CallState> get callStateStream => _callStateController.stream;
  Stream<MediaStream?> get remoteStreamStream => _remoteStreamController.stream;
  Stream<IncomingCall> get incomingCallStream => _incomingCallController.stream;
  Stream<RTCIceConnectionState?> get iceConnectionStateStream => _iceConnectionStateController.stream;

  // Getters
  CallState get callState => _callState;
  bool get isMuted => _isMuted;
  bool get isSpeakerOn => _isSpeakerOn;
  bool get isVideoCall => _isVideoCall;

  /// Whether an incoming offer SDP is a real (sending) video call — lets the
  /// incoming-call UI show the video badge before the call is accepted.
  bool offerSendsVideo(String? sdp) => _offerSendsVideo(sdp);
  bool get isCameraOff => _isCameraOff;
  MediaStream? get localStream => _localStream;
  MediaStream? get remoteStream => _remoteStream;
  int? get currentConversationId => _currentConversationId;

  // Callback for sending signaling messages via WebSocket
  Function(Map<String, dynamic>)? onSignalingMessage;

  // Singleton
  static final VoiceCallService _instance = VoiceCallService._internal();
  factory VoiceCallService() => _instance;
  VoiceCallService._internal();

  /// Initialize a call (caller side).
  ///
  /// On failure returns false; the caller can read [lastStartFailure] for
  /// the reason and map it to a localised user-facing message.
  Future<bool> startCall(int conversationId, String targetUserId, String targetUserName, {bool video = false}) async {
    _log.info('VoiceCallService: startCall() - conv: $conversationId, target: $targetUserName', tag: 'CALL');
    _lastStartFailure = null;
    if (_callState != CallState.idle) {
      _log.warning('VoiceCallService: startCall() aborted - already in state: $_callState', tag: 'CALL');
      return false;
    }

    try {
      _currentConversationId = conversationId;
      _isVideoCall = video;
      // Audio call → earpiece (held to the ear); video call → loudspeaker
      // (looking at the screen). The OS auto-routes to Bluetooth when a BT
      // device is connected and speakerphone is off.
      _isSpeakerOn = video;
      _setCallState(CallState.calling);

      // Get local audio (+ camera, for a video call) stream
      _log.debug('VoiceCallService: Getting local ${video ? "audio+video" : "audio"} stream...', tag: 'CALL');
      _localStream = await _getLocalStream(video: video);
      if (_localStream == null) {
        _log.error('VoiceCallService: Failed to get local stream', tag: 'CALL');
        _lastStartFailure ??= CallStartFailure.unknown;
        _setCallState(CallState.idle);
        return false;
      }
      _log.info('VoiceCallService: Local stream acquired', tag: 'CALL');
      _applyAudioRoute(); // route to speaker now that the audio session is live

      // Create peer connection
      _log.debug('VoiceCallService: Creating peer connection...', tag: 'CALL');
      await _createPeerConnection();

      // Add local stream tracks
      _log.info('VoiceCallService: 📤 Adding ${_localStream!.getTracks().length} local tracks to peer connection', tag: 'CALL');
      int trackIndex = 0;
      _localStream!.getTracks().forEach((track) {
        _peerConnection!.addTrack(track, _localStream!);
        _log.info('VoiceCallService: 📤 Track $trackIndex added: kind=${track.kind}, enabled=${track.enabled}, id=${track.id}', tag: 'CALL');
        trackIndex++;
      });
      _log.info('VoiceCallService: ✅ All local tracks added to peer connection', tag: 'CALL');

      // Cap the outgoing bitrates (video ~8 Mbps @60fps + audio 64k) to match
      // the vorsitzer app.
      if (video) await _applyBitrateCaps();

      // Create offer
      _log.debug('VoiceCallService: Creating SDP offer...', tag: 'CALL');
      // No legacy offerToReceive* constraints: under unified-plan they can
      // degrade the m=video line (encoder stops emitting RTP). The audio+video
      // transceivers already come from addTrack above, so the offer carries
      // both m=audio and m=video as sendrecv.
      final offer = await _peerConnection!.createOffer();
      // Tune Opus for voice (64 kbps, mono, in-band FEC + DTX). Send the same
      // tuned SDP we set locally so both ends agree on the codec params.
      final localOffer = RTCSessionDescription(_tuneOpus(offer.sdp), offer.type);
      await _peerConnection!.setLocalDescription(localOffer);
      _log.info('VoiceCallService: SDP offer created and set as local description', tag: 'CALL');
      _logSdpSummary('caller-local-offer', localOffer.sdp);

      // Send offer via WebSocket
      _log.info('VoiceCallService: Sending call_offer via signaling', tag: 'CALL');
      onSignalingMessage?.call({
        'type': 'call_offer',
        'conversation_id': conversationId,
        'target_user_id': targetUserId,
        'sdp': localOffer.sdp,
        'sdp_type': localOffer.type,
      });

      return true;
    } catch (e) {
      _log.error('VoiceCallService: startCall() error: $e', tag: 'CALL');
      // _getLocalStream classifies mic failures into _lastStartFailure.
      // A missing TURN relay gets its own reason; anything else is unknown.
      if (e.toString().contains('TURN_UNAVAILABLE')) {
        _lastStartFailure = CallStartFailure.turnUnavailable;
      }
      _lastStartFailure ??= CallStartFailure.unknown;
      await endCall();
      return false;
    }
  }

  /// Handle incoming call offer (callee side)
  Future<void> handleIncomingCall(int conversationId, String callerId, String callerName, String sdp, String sdpType) async {
    _log.info('VoiceCallService: handleIncomingCall() - from: $callerName (conv: $conversationId), current state: $_callState', tag: 'CALL');
    if (_callState != CallState.idle) {
      // Already in a call, reject
      _log.warning('VoiceCallService: Already in call ($_callState), auto-rejecting with busy', tag: 'CALL');
      onSignalingMessage?.call({
        'type': 'call_reject',
        'conversation_id': conversationId,
        'reason': 'busy',
      });
      return;
    }

    _currentConversationId = conversationId;
    _setCallState(CallState.ringing);

    // Notify UI about incoming call
    _log.info('VoiceCallService: Notifying UI about incoming call via incomingCallController', tag: 'CALL');
    _incomingCallController.add(IncomingCall(
      conversationId: conversationId,
      callerId: callerId,
      callerName: callerName,
      sdp: sdp,
      sdpType: sdpType,
    ));
  }

  /// Whether the caller's offer actually SENDS video — i.e. this is a real
  /// video call, not a voice call that merely carries a passive video m-line.
  ///
  /// `sdp.contains('m=video')` was too loose: an *audio* call can still include
  /// a `recvonly`/`inactive` video m-line (e.g. a recvonly transceiver kept open
  /// so the call could later be upgraded). Treating that as a video call made
  /// this side open its own camera on a plain voice call. We count it as video
  /// only when the m=video section is not rejected (port ≠ 0) and its direction
  /// lets the caller send (sendrecv / sendonly).
  bool _offerSendsVideo(String? sdp) {
    if (sdp == null || sdp.isEmpty) return false;
    final lines = sdp.split(RegExp(r'\r\n|\r|\n'));
    var inVideo = false;
    var videoActive = false; // m=video port != 0 (not a rejected m-line)
    String? direction;
    for (final line in lines) {
      if (line.startsWith('m=')) {
        if (inVideo) break; // reached the next m-section → video section done
        if (line.startsWith('m=video')) {
          inVideo = true;
          // "m=video <port> ..." — port 0 means the m-line is rejected/disabled.
          final parts = line.split(' ');
          videoActive = parts.length > 1 && parts[1] != '0';
        }
        continue;
      }
      if (inVideo &&
          (line == 'a=sendrecv' ||
              line == 'a=sendonly' ||
              line == 'a=recvonly' ||
              line == 'a=inactive')) {
        direction = line.substring(2);
      }
    }
    if (!inVideo || !videoActive) return false;
    final dir = direction ?? 'sendrecv'; // SDP default when unspecified
    return dir == 'sendrecv' || dir == 'sendonly';
  }

  /// Accept incoming call
  Future<bool> acceptCall(String sdp, String sdpType) async {
    _log.info('VoiceCallService: acceptCall() - current state: $_callState', tag: 'CALL');
    if (_callState != CallState.ringing) {
      _log.warning('VoiceCallService: acceptCall() aborted - wrong state: $_callState', tag: 'CALL');
      return false;
    }

    try {
      _setCallState(CallState.connecting);

      // A video call is signalled by the caller ACTUALLY SENDING video in the
      // offer — not merely a video m-line being present. A voice call can carry
      // a passive (recvonly/inactive) video m-line, which must not turn our
      // camera on. Mirror real video so we send our camera too. See
      // _offerSendsVideo().
      final wantsVideo = _offerSendsVideo(sdp);
      _isVideoCall = wantsVideo;
      _isSpeakerOn = wantsVideo; // audio → earpiece, video → loudspeaker

      // Get local audio (+ camera, if this is a video call) stream
      _log.debug('VoiceCallService: Getting local ${wantsVideo ? "audio+video" : "audio"} stream for accept...', tag: 'CALL');
      _localStream = await _getLocalStream(video: wantsVideo);
      if (_localStream == null) {
        _log.error('VoiceCallService: Failed to get local stream for accept', tag: 'CALL');
        await endCall();
        return false;
      }
      _log.info('VoiceCallService: Local stream acquired for accept', tag: 'CALL');
      _applyAudioRoute(); // route to speaker now that the audio session is live

      // Create peer connection
      _log.debug('VoiceCallService: Creating peer connection for accept...', tag: 'CALL');
      await _createPeerConnection();

      // Add local stream tracks
      _log.info('VoiceCallService: 📤 Adding ${_localStream!.getTracks().length} local tracks for ACCEPT', tag: 'CALL');
      int trackIndex = 0;
      _localStream!.getTracks().forEach((track) {
        _peerConnection!.addTrack(track, _localStream!);
        _log.info('VoiceCallService: 📤 ACCEPT Track $trackIndex: kind=${track.kind}, enabled=${track.enabled}, id=${track.id}', tag: 'CALL');
        trackIndex++;
      });
      _log.info('VoiceCallService: ✅ All local tracks added for ACCEPT', tag: 'CALL');

      // Cap outgoing bitrates (video ~8 Mbps @60fps + audio 64k) to match the
      // vorsitzer app.
      if (_isVideoCall) await _applyBitrateCaps();

      // Set remote description (the offer)
      _log.debug('VoiceCallService: Setting remote description (offer)...', tag: 'CALL');
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(sdp, sdpType),
      );
      _remoteDescriptionSet = true;
      _log.info('VoiceCallService: Remote description set successfully', tag: 'CALL');
      _logSdpSummary('callee-remote-offer', sdp);

      // Process queued ICE candidates (Fix 1)
      await _processQueuedIceCandidates();

      // Create answer
      _log.debug('VoiceCallService: Creating SDP answer...', tag: 'CALL');
      final answer = await _peerConnection!.createAnswer();
      // Tune Opus for voice (64 kbps, mono, FEC + DTX); send the tuned SDP.
      final localAnswer = RTCSessionDescription(_tuneOpus(answer.sdp), answer.type);
      await _peerConnection!.setLocalDescription(localAnswer);
      _log.info('VoiceCallService: SDP answer created and set as local description', tag: 'CALL');
      _logSdpSummary('callee-local-answer', localAnswer.sdp);

      // Send answer via WebSocket
      _log.info('VoiceCallService: Sending call_answer via signaling', tag: 'CALL');
      onSignalingMessage?.call({
        'type': 'call_answer',
        'conversation_id': _currentConversationId,
        'sdp': localAnswer.sdp,
        'sdp_type': localAnswer.type,
      });

      return true;
    } catch (e) {
      _log.error('VoiceCallService: acceptCall() error: $e', tag: 'CALL');
      await endCall();
      return false;
    }
  }

  /// Reject incoming call
  void rejectCall() {
    _log.info('VoiceCallService: rejectCall() - current state: $_callState', tag: 'CALL');
    if (_callState != CallState.ringing) {
      _log.warning('VoiceCallService: rejectCall() aborted - wrong state: $_callState', tag: 'CALL');
      return;
    }

    _log.info('VoiceCallService: Sending call_reject via signaling', tag: 'CALL');
    onSignalingMessage?.call({
      'type': 'call_reject',
      'conversation_id': _currentConversationId,
      'reason': 'rejected',
    });

    _cleanup();
  }

  /// Handle call answer (caller side)
  Future<void> handleCallAnswer(String sdp, String sdpType) async {
    _log.info('VoiceCallService: handleCallAnswer() - current state: $_callState, sdpType: $sdpType', tag: 'CALL');
    if (_callState != CallState.calling) {
      _log.warning('VoiceCallService: handleCallAnswer() aborted - wrong state: $_callState', tag: 'CALL');
      return;
    }

    try {
      _log.debug('VoiceCallService: Setting remote description (answer from callee)...', tag: 'CALL');
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(sdp, sdpType),
      );
      _remoteDescriptionSet = true;
      _log.info('VoiceCallService: Remote description (answer) set successfully', tag: 'CALL');
      _logSdpSummary('caller-remote-answer', sdp);

      // Process queued ICE candidates (Fix 1)
      await _processQueuedIceCandidates();

      _log.info('VoiceCallService: Waiting for WebRTC connection to establish...', tag: 'CALL');
      // Note: State will change to inCall via onConnectionState callback when connected
    } catch (e) {
      _log.error('VoiceCallService: handleCallAnswer() error: $e', tag: 'CALL');
      await endCall();
    }
  }

  /// Handle call rejection
  void handleCallRejected(String reason) {
    _log.info('VoiceCallService: handleCallRejected() - reason: $reason, current state: $_callState', tag: 'CALL');
    if (_callState == CallState.calling) {
      _playRejectedSound(); // busy tone before teardown (separate player survives _cleanup)
      _cleanup();
    } else {
      _log.debug('VoiceCallService: handleCallRejected() - not in calling state, ignoring', tag: 'CALL');
    }
  }

  /// Handle ICE candidate from remote peer (with queuing - Fix 1)
  Future<void> handleIceCandidate(String candidate, String sdpMid, int sdpMLineIndex) async {
    final iceCandidate = RTCIceCandidate(candidate, sdpMid, sdpMLineIndex);

    if (_peerConnection == null) {
      _log.warning('VoiceCallService: ⚠️ handleIceCandidate() - NO PEER CONNECTION YET! Queuing candidate...', tag: 'CALL');
      _queuedIceCandidates.add(iceCandidate);
      _log.info('VoiceCallService: 📦 ICE candidate queued (total: ${_queuedIceCandidates.length})', tag: 'CALL');
      return;
    }

    // If remote description not set yet, queue the candidate
    if (!_remoteDescriptionSet) {
      _log.info('VoiceCallService: ⏳ Remote description not set yet, queuing ICE candidate (mid: $sdpMid)', tag: 'CALL');
      _queuedIceCandidates.add(iceCandidate);
      _log.info('VoiceCallService: 📦 ICE candidate queued (total: ${_queuedIceCandidates.length})', tag: 'CALL');
      return;
    }

    // Remote description is set, add candidate immediately
    try {
      _log.debug('VoiceCallService: ✓ Adding ICE candidate from remote peer (mid: $sdpMid)', tag: 'CALL');
      await _peerConnection!.addCandidate(iceCandidate);
      _log.info('VoiceCallService: ✓ ICE candidate added successfully', tag: 'CALL');
    } catch (e) {
      _log.error('VoiceCallService: ❌ ICE candidate error: $e', tag: 'CALL');
    }
  }

  /// Process queued ICE candidates after remote description is set (Fix 1)
  Future<void> _processQueuedIceCandidates() async {
    if (_queuedIceCandidates.isEmpty) {
      _log.debug('VoiceCallService: No queued ICE candidates to process', tag: 'CALL');
      return;
    }

    _log.info('VoiceCallService: ⚡ Processing ${_queuedIceCandidates.length} queued ICE candidates', tag: 'CALL');

    for (final candidate in _queuedIceCandidates) {
      try {
        await _peerConnection!.addCandidate(candidate);
        _log.debug('VoiceCallService: ✓ Queued candidate added (mid: ${candidate.sdpMid})', tag: 'CALL');
      } catch (e) {
        _log.error('VoiceCallService: ❌ Error adding queued candidate: $e', tag: 'CALL');
      }
    }

    _log.info('VoiceCallService: ✅ All queued ICE candidates processed', tag: 'CALL');
    _queuedIceCandidates.clear();
  }

  /// End the current call
  Future<void> endCall() async {
    _log.info('🛑🛑🛑 endCall() CALLED - current state: $_callState', tag: 'CALL');
    _log.info('🛑 Call was in conversation: $_currentConversationId', tag: 'CALL');
    _log.info('🛑 Stack trace:', tag: 'CALL');
    _log.info('${StackTrace.current}', tag: 'CALL');

    if (_callState == CallState.idle) {
      _log.debug('VoiceCallService: endCall() - already idle, nothing to do', tag: 'CALL');
      return;
    }

    // Notify remote peer
    _log.info('VoiceCallService: 📤 Sending call_end via signaling to conversation $_currentConversationId', tag: 'CALL');
    onSignalingMessage?.call({
      'type': 'call_end',
      'conversation_id': _currentConversationId,
    });

    _log.info('VoiceCallService: 🧹 Starting cleanup...', tag: 'CALL');
    _cleanup();
    _log.info('VoiceCallService: ✅ endCall() complete', tag: 'CALL');
  }

  /// Handle call ended by remote peer
  void handleCallEnded() {
    _log.info('VoiceCallService: handleCallEnded() - cleaning up', tag: 'CALL');
    _cleanup();
  }

  /// Toggle microphone mute
  void toggleMute() {
    if (_localStream == null) {
      _log.warning('VoiceCallService: toggleMute() - no local stream', tag: 'CALL');
      return;
    }

    _isMuted = !_isMuted;
    _log.info('VoiceCallService: Microphone muted: $_isMuted', tag: 'CALL');
    _localStream!.getAudioTracks().forEach((track) {
      track.enabled = !_isMuted;
    });
  }

  /// Toggle speaker (for mobile, on desktop this is usually not needed)
  void toggleSpeaker() {
    _isSpeakerOn = !_isSpeakerOn;
    // On Windows/Linux/macOS the speaker is handled by the system audio stack.
    // On Android/iOS we must route explicitly, otherwise the speaker button in
    // NativeCallScreen is a no-op and audio stays on the earpiece.
    _applyAudioRoute();
  }

  /// Route call audio to loudspeaker/earpiece on mobile. No-op on desktop.
  /// Must run while the audio session is active (after getUserMedia), else the
  /// AudioManager mode is not yet MODE_IN_COMMUNICATION and the call is ignored.
  void _applyAudioRoute() {
    try {
      if (Platform.isAndroid) {
        // Prefer a connected Bluetooth / wired headset over the loudspeaker.
        // setSpeakerphoneOn(true) would FORCE the speaker and bypass BT — the bug.
        if (_isSpeakerOn) {
          Helper.setSpeakerphoneOnButPreferBluetooth();
        } else {
          Helper.setSpeakerphoneOn(false); // earpiece / headset
        }
      } else if (Platform.isIOS) {
        // iOS routes Bluetooth through the audio session automatically.
        Helper.setSpeakerphoneOn(_isSpeakerOn);
      } else {
        return; // desktop: handled by the system audio stack
      }
      _log.info('VoiceCallService: 🔊 Audio route applied (speaker=$_isSpeakerOn, prefer-BT on Android)', tag: 'CALL');
    } catch (e) {
      _log.warning('VoiceCallService: _applyAudioRoute failed: $e', tag: 'CALL');
    }
  }

  /// Auto-switch the audio route mid-call when a Bluetooth / wired device is
  /// (dis)connected — no user action needed. Set after the peer connection is
  /// created; cleared in _cleanup.
  void _setupAudioDeviceListener() {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    navigator.mediaDevices.ondevicechange = (_) {
      // Small delay so the OS has finished (dis)connecting the device before we
      // re-assert the route.
      Future.delayed(const Duration(milliseconds: 800), () {
        if (_callState != CallState.idle) _applyAudioRoute();
      });
    };
  }

  /// Toggle the local camera on/off during a video call (audio keeps flowing).
  void toggleCamera() {
    final videoTracks = _localStream?.getVideoTracks() ?? const [];
    if (videoTracks.isEmpty) {
      _log.warning('VoiceCallService: toggleCamera() - no local video track', tag: 'CALL');
      return;
    }
    _isCameraOff = !_isCameraOff;
    _log.info('VoiceCallService: Camera off: $_isCameraOff', tag: 'CALL');
    for (final t in videoTracks) {
      t.enabled = !_isCameraOff;
    }
  }

  /// Switch between front and back camera during a video call.
  Future<void> switchCamera() async {
    final videoTracks = _localStream?.getVideoTracks() ?? const [];
    if (videoTracks.isEmpty) {
      _log.warning('VoiceCallService: switchCamera() - no local video track', tag: 'CALL');
      return;
    }
    try {
      await Helper.switchCamera(videoTracks.first);
      _log.info('VoiceCallService: 🔄 Camera switched', tag: 'CALL');
    } catch (e) {
      _log.warning('VoiceCallService: switchCamera failed: $e', tag: 'CALL');
    }
  }

  /// Cap the outgoing RTP bitrates, kept identical to the vorsitzer app so both
  /// ends match: video ~8 Mbps @60fps (1080p), audio 64 kbps. Modifies existing
  /// encodings in place where possible — replacing the list wholesale throws on
  /// some platforms.
  Future<void> _applyBitrateCaps() async {
    if (_peerConnection == null) return;
    try {
      final senders = await _peerConnection!.getSenders();
      for (final sender in senders) {
        final kind = sender.track?.kind;
        if (kind != 'video' && kind != 'audio') continue;
        final isVideo = kind == 'video';
        final maxBitrate = isVideo ? 8000000 : 64000;
        final int? maxFramerate = isVideo ? 60 : null;
        final params = sender.parameters;
        final existing = params.encodings;
        if (existing != null && existing.isNotEmpty) {
          for (final enc in existing) {
            enc.maxBitrate = maxBitrate;
            if (maxFramerate != null) enc.maxFramerate = maxFramerate;
          }
        } else {
          params.encodings = [
            RTCRtpEncoding(maxBitrate: maxBitrate, maxFramerate: maxFramerate),
          ];
        }
        await sender.setParameters(params);
        _log.info('VoiceCallService: 🎚️ ${isVideo ? "Video ~8 Mbps @60fps" : "Audio 64 kbps"} bitrate cap applied', tag: 'CALL');
      }
    } catch (e) {
      _log.warning('VoiceCallService: _applyBitrateCaps failed: $e', tag: 'CALL');
    }
  }

  /// Tune the Opus codec in a local SDP for voice: 64 kbps max, mono, in-band
  /// FEC (packet-loss resilience) + DTX. Applied to the offer/answer before
  /// setLocalDescription. Kept identical to the vorsitzer app.
  String _tuneOpus(String? sdp) {
    if (sdp == null || sdp.isEmpty) return sdp ?? '';
    final rtpmap = RegExp(r'a=rtpmap:(\d+) opus/48000/2', caseSensitive: false).firstMatch(sdp);
    if (rtpmap == null) return sdp;
    final pt = rtpmap.group(1)!;
    const wanted = {'maxaveragebitrate': '64000', 'stereo': '0', 'useinbandfec': '1', 'usedtx': '1'};
    final fmtp = RegExp('a=fmtp:$pt ([^\\r\\n]*)').firstMatch(sdp);
    if (fmtp != null) {
      final current = fmtp.group(1)!;
      final keys = current.split(';').map((kv) => kv.split('=').first.trim()).toSet();
      final adds = wanted.entries.where((e) => !keys.contains(e.key)).map((e) => '${e.key}=${e.value}');
      if (adds.isEmpty) return sdp;
      return sdp.replaceFirst(fmtp.group(0)!, 'a=fmtp:$pt $current;${adds.join(';')}');
    }
    return sdp.replaceFirst(rtpmap.group(0)!,
        '${rtpmap.group(0)!}\r\na=fmtp:$pt ${wanted.entries.map((e) => "${e.key}=${e.value}").join(";")}');
  }

  /// Log a compact per-m-line summary of an SDP (media kind, direction,
  /// codecs) after each set*Description. Confirms `m=video` is `sendrecv` on
  /// BOTH the offer and the answer — the decisive signal that video was
  /// negotiated. Tag 'SDP' and format kept IDENTICAL to the vorsitzer app so
  /// the two ends' logs correlate line-for-line. Labels used:
  /// caller-local-offer, callee-remote-offer, callee-local-answer,
  /// caller-remote-answer.
  void _logSdpSummary(String label, String? sdp) {
    if (sdp == null || sdp.isEmpty) {
      _log.info('SDP[$label]: <empty>', tag: 'SDP');
      return;
    }
    String? mLine;
    String dir = '?';
    final codecs = <String>[];
    void flush() {
      if (mLine != null) {
        _log.info('SDP[$label] $mLine dir=$dir codecs=[${codecs.join(",")}]', tag: 'SDP');
      }
    }
    for (final raw in sdp.split(RegExp(r'\r?\n'))) {
      final l = raw.trim();
      if (l.startsWith('m=')) {
        flush();
        mLine = l;
        dir = '?';
        codecs.clear();
      } else if (l == 'a=sendrecv' || l == 'a=sendonly' || l == 'a=recvonly' || l == 'a=inactive') {
        dir = l.substring(2);
      } else if (l.startsWith('a=rtpmap:')) {
        final pp = l.split(' ');
        if (pp.length > 1) codecs.add(pp[1]);
      }
    }
    flush();
  }

  /// Create WebRTC peer connection
  Future<void> _createPeerConnection() async {
    _log.debug('VoiceCallService: Creating RTCPeerConnection...', tag: 'CALL');
    final iceServers = await _getIceServers();
    // No TURN, no call: our coturn is the only relay (GDPR: no third-party
    // STUN), so a member on strict/mobile NAT cannot connect without it. Fail
    // fast with a clear reason instead of gathering only unusable candidates.
    if ((iceServers['iceServers'] as List).isEmpty) {
      throw StateError('TURN_UNAVAILABLE');
    }
    // Force relay-only ICE. On mobile IPv6-only / 464XLAT (CLAT) networks the
    // host/srflx candidates never converge (the client offers a bogus 192.0.0.4
    // CLAT address, cross-family), so media never flows and the call drops at
    // ~15s on ICE consent timeout. Our coturn relay is proven (relay-to-relay,
    // 0% loss), so route all media through it and skip the dead-end candidates.
    // Force a SINGLE bundled transport for audio+video. With the default
    // 'balanced' bundle policy the video m-line gets its own ICE transport,
    // which — on iceTransportPolicy:'relay' — needs a SECOND coturn allocation
    // (same ephemeral username). coturn's use-auth-secret user-quota can reject
    // that second allocation, so it never nominates: audio flows on the first
    // relay (~100 KB) while video's transport stalls and drags the whole
    // PeerConnection to ICE-consent FAILED at ~15s (the "remote black on both
    // sides + call drops at 15s" bug). max-bundle marks video bundle-only →
    // one transport, one allocation, video rides the proven audio relay path.
    // rtcpMuxPolicy:'require' (also the default) keeps RTP+RTCP on that one port.
    _peerConnection = await createPeerConnection({
      ...iceServers,
      // Explicit unified-plan. Under unified-plan the legacy
      // offerToReceiveAudio/Video constraints can corrupt the m=video line so
      // the encoder emits no RTP (local preview still works) — we drop them
      // from createOffer and let addTrack drive the transceivers instead.
      'sdpSemantics': 'unified-plan',
      'iceTransportPolicy': 'relay',
      'bundlePolicy': 'max-bundle',
      'rtcpMuxPolicy': 'require',
    });
    _log.info('VoiceCallService: RTCPeerConnection created successfully', tag: 'CALL');

    // Handle ICE candidates (our local candidates to send to remote peer)
    _peerConnection!.onIceCandidate = (candidate) {
      if (candidate.candidate != null) {
        _log.info('VoiceCallService: ➤ Generated local ICE candidate (mid: ${candidate.sdpMid}, index: ${candidate.sdpMLineIndex})', tag: 'CALL');
        _log.debug('VoiceCallService: ➤ Candidate: ${candidate.candidate}', tag: 'CALL');
        _log.info('VoiceCallService: ➤ Sending ICE candidate to remote peer via signaling', tag: 'CALL');
        onSignalingMessage?.call({
          'type': 'ice_candidate',
          'conversation_id': _currentConversationId,
          'candidate': candidate.candidate,
          'sdp_mid': candidate.sdpMid,
          'sdp_mline_index': candidate.sdpMLineIndex,
        });
      } else {
        _log.debug('VoiceCallService: onIceCandidate with null candidate (gathering complete)', tag: 'CALL');
      }
    };

    // Handle ICE gathering state
    _peerConnection!.onIceGatheringState = (state) {
      _log.info('VoiceCallService: ✓ ICE Gathering State: $state', tag: 'CALL');
    };

    // Handle ICE connection state
    _peerConnection!.onIceConnectionState = (state) {
      _log.info('VoiceCallService: ✓ ICE Connection State: $state', tag: 'CALL');
      // Feed the network-quality indicator (#6a).
      _iceConnectionStateController.add(state);
    };

    // Handle signaling state
    _peerConnection!.onSignalingState = (state) {
      _log.info('VoiceCallService: ✓ Signaling State: $state', tag: 'CALL');
    };

    // Handle connection state changes (CRITICAL for moving to inCall)
    _peerConnection!.onConnectionState = (state) {
      _log.info('VoiceCallService: ✓✓✓ RTCPeerConnection State: $state ✓✓✓', tag: 'CALL');

      if (state == RTCPeerConnectionState.RTCPeerConnectionStateNew) {
        _log.debug('VoiceCallService: Connection state: NEW', tag: 'CALL');
      } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnecting) {
        _log.info('VoiceCallService: Connection state: CONNECTING (ICE negotiation in progress)', tag: 'CALL');
      } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        _log.info('VoiceCallService: ★★★ WebRTC connection ESTABLISHED! Changing to inCall state ★★★', tag: 'CALL');
        _setCallState(CallState.inCall);
        _applyAudioRoute(); // re-assert speaker route once media is flowing
      } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected) {
        _log.warning('🚨🚨🚨 Connection state: DISCONNECTED - AUTO-ENDING CALL!', tag: 'CALL');
        _log.warning('🚨 Previous state was: $_callState', tag: 'CALL');
        _log.warning('🚨 Conversation ID: $_currentConversationId', tag: 'CALL');
        _log.warning('🚨 Local stream exists: ${_localStream != null}', tag: 'CALL');
        _log.warning('🚨 Remote stream exists: ${_remoteStream != null}', tag: 'CALL');
        // Send call_end notification to remote peer before cleanup
        if (_currentConversationId != null) {
          _log.info('VoiceCallService: 📤 Sending call_end due to DISCONNECTED state', tag: 'CALL');
          onSignalingMessage?.call({
            'type': 'call_end',
            'conversation_id': _currentConversationId,
          });
        }
        _cleanup();
      } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
        _log.error('❌❌❌ Connection state: FAILED - AUTO-ENDING CALL!', tag: 'CALL');
        _log.error('❌ Previous state was: $_callState', tag: 'CALL');
        _log.error('❌ Conversation ID: $_currentConversationId', tag: 'CALL');
        _log.error('❌ Local stream exists: ${_localStream != null}', tag: 'CALL');
        _log.error('❌ Remote stream exists: ${_remoteStream != null}', tag: 'CALL');
        _log.error('❌ This usually means ICE connection could not be established!', tag: 'CALL');
        // Send call_end notification to remote peer before cleanup
        if (_currentConversationId != null) {
          _log.info('VoiceCallService: 📤 Sending call_end due to FAILED state', tag: 'CALL');
          onSignalingMessage?.call({
            'type': 'call_end',
            'conversation_id': _currentConversationId,
          });
        }
        _cleanup();
      } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
        _log.debug('VoiceCallService: Connection state: CLOSED', tag: 'CALL');
      } else {
        _log.warning('VoiceCallService: Connection state: UNKNOWN ($state)', tag: 'CALL');
      }
    };

    // Handle remote track
    _peerConnection!.onTrack = (event) {
      _log.info('VoiceCallService: ★★★ onTrack EVENT FIRED ★★★', tag: 'CALL');
      _log.info('VoiceCallService: 📥 Track received: kind=${event.track.kind}, enabled=${event.track.enabled}, id=${event.track.id}', tag: 'CALL');
      _log.info('VoiceCallService: 📥 Track muted: ${event.track.muted}', tag: 'CALL');
      _log.info('VoiceCallService: 📥 Streams in event: ${event.streams.length}', tag: 'CALL');

      if (event.streams.isNotEmpty) {
        final remoteStream = event.streams[0];
        _log.info('VoiceCallService: 📥 Remote stream ID: ${remoteStream.id}', tag: 'CALL');
        _log.info('VoiceCallService: 📥 Remote stream tracks count: ${remoteStream.getTracks().length}', tag: 'CALL');

        for (var i = 0; i < remoteStream.getTracks().length; i++) {
          final track = remoteStream.getTracks()[i];
          _log.info('VoiceCallService: 📥 Remote track $i: kind=${track.kind}, enabled=${track.enabled}, muted=${track.muted}', tag: 'CALL');
        }

        _remoteStream = remoteStream;
        _remoteStreamController.add(_remoteStream);
        _log.info('VoiceCallService: ✅✅✅ Remote stream added to controller - UI should receive it!', tag: 'CALL');

        // WORKAROUND for flutter_webrtc bug #1668 on Windows:
        // onConnectionState callback doesn't fire, so we use onTrack as indicator
        // If we receive remote stream, connection IS established!
        if (_callState == CallState.connecting || _callState == CallState.calling) {
          _log.info('VoiceCallService: ★★★ WORKAROUND: Remote stream received → assuming connection established!', tag: 'CALL');
          _log.info('VoiceCallService: ★★★ Changing to inCall state (onConnectionState bug workaround)', tag: 'CALL');
          _setCallState(CallState.inCall);
          _applyAudioRoute(); // re-assert speaker route once media is flowing
        }
      } else {
        _log.warning('VoiceCallService: ⚠️⚠️⚠️ onTrack event but NO STREAMS! This is abnormal!', tag: 'CALL');
      }
    };

    // ICE diagnostics: log candidate-pairs + candidate types every 3s while the
    // connection is establishing and during the call, so a failed mobile call
    // shows whether relay candidates appear on BOTH ends and whether a
    // relay↔relay pair gets nominated with bytes flowing both ways. Stopped in
    // _cleanup.
    _startStatsLogging();
    _setupAudioDeviceListener();
  }

  /// Get local audio stream.
  ///
  /// On Windows (libwebrtc native), the Web spec's privacy-preserving
  /// behaviour hides audio inputs in `enumerateDevices()` until
  /// `getUserMedia({audio: true})` has been granted permission. That made
  /// our previous "enumerate first, then getUserMedia with deviceId"
  /// pattern fail with NO_MICROPHONE for users who had a perfectly fine
  /// headset connected (see flutter-webrtc#808, #1136, #1628).
  ///
  /// The correct order is: getUserMedia FIRST (this triggers the OS
  /// permission prompt and unlocks the device list). Enumerate afterwards
  /// only for diagnostic logging — we already have the stream we need.
  ///
  /// On failure, classifies the error into [_lastStartFailure] so the
  /// caller can show an actionable message ("enable mic in Windows
  /// Privacy" vs "no microphone connected" vs generic).
  Future<MediaStream?> _getLocalStream({bool video = false}) async {
    _log.info('VoiceCallService: 🎤 Requesting ${video ? "camera + microphone" : "microphone"} access...', tag: 'CALL');

    const audioConstraints = {
      'echoCancellation': true,
      'noiseSuppression': true,
      'autoGainControl': true,
    };
    // 1080p @60fps front camera; the send bitrate is capped separately on the
    // RTP sender (see _applyBitrateCaps).
    final Map<String, dynamic> constraints = {
      'audio': audioConstraints,
      'video': video
          ? {
              'facingMode': 'user',
              'width': {'ideal': 1920},
              'height': {'ideal': 1080},
              'frameRate': {'ideal': 60},
            }
          : false,
    };

    final MediaStream stream;
    try {
      stream = await navigator.mediaDevices.getUserMedia(constraints);
    } catch (e) {
      // A video call that can't open the camera should still connect as
      // audio-only rather than fail outright.
      if (video) {
        _log.warning('VoiceCallService: getUserMedia(audio+video) failed, falling back to audio-only: $e', tag: 'CALL');
        try {
          return await navigator.mediaDevices.getUserMedia({'audio': audioConstraints, 'video': false});
        } catch (e2) {
          _lastStartFailure = _classifyMediaError(e2);
          _log.error('VoiceCallService: ❌ audio-only fallback also failed [${_lastStartFailure!.name}]: $e2', tag: 'CALL');
          rethrow;
        }
      }
      _lastStartFailure = _classifyMediaError(e);
      _log.error(
        'VoiceCallService: ❌ getUserMedia(audio) failed [${_lastStartFailure!.name}]: $e',
        tag: 'CALL',
      );
      rethrow;
    }

    _log.info('VoiceCallService: ✓✓✓ Audio stream acquired', tag: 'CALL');
    _log.info('VoiceCallService: Stream tracks: ${stream.getTracks().length}', tag: 'CALL');
    for (var track in stream.getTracks()) {
      _log.info(
        'VoiceCallService: Track: kind=${track.kind}, label="${track.label}", enabled=${track.enabled}, muted=${track.muted}',
        tag: 'CALL',
      );
    }

    // Diagnostic enumeration AFTER permission grant — labels and audio
    // inputs are now visible. Failures here are non-fatal.
    try {
      final devices = await navigator.mediaDevices.enumerateDevices();
      final audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
      final audioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();
      final videoInputs = devices.where((d) => d.kind == 'videoinput').toList();
      _log.info(
        'VoiceCallService: Devices after permission — audio in: ${audioInputs.length}, audio out: ${audioOutputs.length}, video in: ${videoInputs.length}',
        tag: 'CALL',
      );
      for (var i = 0; i < devices.length; i++) {
        final d = devices[i];
        _log.debug(
          'VoiceCallService: Device $i: kind=${d.kind}, label="${d.label}", deviceId=${d.deviceId}',
          tag: 'CALL',
        );
      }
    } catch (e) {
      _log.debug('VoiceCallService: enumerateDevices (post-permission) failed: $e (non-fatal)', tag: 'CALL');
    }

    return stream;
  }

  /// Map a getUserMedia error to a [CallStartFailure] category. flutter_webrtc
  /// surfaces native errors as strings containing the DOMException name; we
  /// match the standard names (NotAllowedError, NotFoundError, etc.) plus
  /// some legacy aliases.
  CallStartFailure _classifyMediaError(Object error) {
    final msg = error.toString();
    if (msg.contains('NotAllowedError') ||
        msg.contains('PermissionDeniedError') ||
        msg.contains('SecurityError') ||
        msg.contains('PERMISSION_DENIED')) {
      return CallStartFailure.micPermissionDenied;
    }
    if (msg.contains('NotFoundError') ||
        msg.contains('DevicesNotFoundError') ||
        msg.contains('NotReadableError') ||
        msg.contains('TrackStartError') ||
        msg.contains('OverconstrainedError') ||
        msg.contains('ConstraintNotSatisfiedError')) {
      return CallStartFailure.micNotFound;
    }
    return CallStartFailure.unknown;
  }

  /// Set call state and notify listeners
  void _setCallState(CallState state) {
    _log.info('VoiceCallService: STATE CHANGE: $_callState → $state (notifying listeners)', tag: 'CALL');
    _callState = state;
    _updateRingSound(state);
    _callStateController.add(state);
  }

  /// Ringtone (callee, incoming) / ringback (caller, outgoing) while the call is
  /// ringing; stopped as soon as it connects or ends (via _cleanup →
  /// _setCallState(idle)). Uses the system ringtone — no bundled audio asset.
  void _updateRingSound(CallState state) {
    try {
      if (state == CallState.ringing) {
        // Callee: the full system ringtone.
        FlutterRingtonePlayer().playRingtone(looping: true, asAlarm: false);
        _stopRingback();
      } else if (state == CallState.calling) {
        // Caller: a quiet "ring-ring" ringback, NOT the full system ringtone.
        FlutterRingtonePlayer().stop();
        _playRingback();
      } else {
        // connecting / inCall / idle: silence.
        FlutterRingtonePlayer().stop();
        _stopRingback();
      }
    } catch (e) {
      _log.warning('VoiceCallService: ring sound error: $e', tag: 'CALL');
    }
  }

  Future<void> _playRingback() async {
    try {
      _ringbackPlayer ??= AudioPlayer();
      if (_ringbackPlayer!.playing) return;
      await _ringbackPlayer!.setAsset('assets/sounds/ringback.wav');
      await _ringbackPlayer!.setLoopMode(LoopMode.one);
      await _ringbackPlayer!.play();
    } catch (e) {
      _log.warning('VoiceCallService: ringback error: $e', tag: 'CALL');
    }
  }

  Future<void> _stopRingback() async {
    try {
      await _ringbackPlayer?.stop();
    } catch (_) {}
  }

  /// Busy/rejected tone (~3s) for the caller when the callee rejects or is busy.
  /// A separate player so _cleanup() (which stops the ringback) doesn't cut it.
  Future<void> _playRejectedSound() async {
    try {
      _sfxPlayer ??= AudioPlayer();
      await _sfxPlayer!.stop();
      await _sfxPlayer!.setAsset('assets/sounds/rejected.wav');
      await _sfxPlayer!.setLoopMode(LoopMode.off);
      await _sfxPlayer!.play();
    } catch (e) {
      _log.warning('VoiceCallService: rejected tone error: $e', tag: 'CALL');
    }
  }

  /// Cleanup resources
  /// Periodic getStats logging for ICE diagnostics (candidate-pairs + candidate
  /// types), uploaded via LoggerService. A failed mobile call then shows the
  /// decisive data: do `relay` candidates appear on both ends, and does a
  /// relay↔relay pair reach state=succeeded/nominated with bytesSent>0 AND
  /// bytesReceived>0 (vs strictly one-way → the "media 1 direction + 15s" bug).
  void _startStatsLogging() {
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final pc = _peerConnection;
      if (pc == null) return;
      try {
        final reports = await pc.getStats();
        for (final r in reports) {
          final v = r.values;
          if (r.type == 'candidate-pair') {
            _log.info('[PAIR] state=${v['state']} nominated=${v['nominated']} sent=${v['bytesSent']} recv=${v['bytesReceived']} L=${v['localCandidateId']} R=${v['remoteCandidateId']}', tag: 'ICESTAT');
          } else if (r.type == 'local-candidate' || r.type == 'remote-candidate') {
            _log.info('[CAND] ${r.type} ${v['candidateType']} ${v['protocol']} ${v['ip'] ?? v['address']}:${v['port']}', tag: 'ICESTAT');
          } else if (r.type == 'outbound-rtp') {
            // Decisive video-flow check: a working video call must show an
            // outbound-rtp with kind=video whose framesEncoded/bytesSent grow.
            // Format kept IDENTICAL to the vorsitzer app so both logs correlate.
            _log.info('[OUT-RTP] kind=${v['kind'] ?? v['mediaType']} bytesSent=${v['bytesSent']} framesEncoded=${v['framesEncoded']} ${v['frameWidth']}x${v['frameHeight']}', tag: 'ICESTAT');
          } else if (r.type == 'inbound-rtp') {
            _log.info('[IN-RTP] kind=${v['kind'] ?? v['mediaType']} bytesRecv=${v['bytesReceived']} framesDecoded=${v['framesDecoded']}', tag: 'ICESTAT');
          }
        }
      } catch (e) {
        _log.warning('VoiceCallService: getStats logging error: $e', tag: 'ICESTAT');
      }
    });
  }

  void _stopStatsLogging() {
    _statsTimer?.cancel();
    _statsTimer = null;
  }

  void _cleanup() {
    _log.info('VoiceCallService: _cleanup() - releasing WebRTC resources', tag: 'CALL');
    _stopStatsLogging();
    if (Platform.isAndroid || Platform.isIOS) {
      navigator.mediaDevices.ondevicechange = null;
    }
    _localStream?.getTracks().forEach((track) => track.stop());
    _localStream?.dispose();
    _localStream = null;

    _remoteStream?.dispose();
    _remoteStream = null;
    _remoteStreamController.add(null);

    _peerConnection?.close();
    _peerConnection = null;

    // Reset ICE candidate queue (Fix 1)
    _queuedIceCandidates.clear();
    _remoteDescriptionSet = false;

    _currentConversationId = null;
    _isMuted = false;
    _isSpeakerOn = false;
    _isVideoCall = false;
    _isCameraOff = false;

    _setCallState(CallState.idle);
    _log.debug('VoiceCallService: Cleanup completed, state reset to idle', tag: 'CALL');
  }

  /// Dispose service
  void dispose() {
    _cleanup();
    _ringbackPlayer?.dispose();
    _sfxPlayer?.dispose();
    _callStateController.close();
    _remoteStreamController.close();
    _incomingCallController.close();
    _iceConnectionStateController.close();
  }
}

/// Call states
enum CallState {
  idle,       // No active call
  calling,    // Initiating a call (waiting for answer)
  ringing,    // Receiving an incoming call
  connecting, // Call accepted, establishing connection
  inCall,     // Active call in progress
}

/// Incoming call data
class IncomingCall {
  final int conversationId;
  final String callerId;
  final String callerName;
  final String sdp;
  final String sdpType;

  IncomingCall({
    required this.conversationId,
    required this.callerId,
    required this.callerName,
    required this.sdp,
    required this.sdpType,
  });
}
