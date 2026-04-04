import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/io_client.dart';
import 'api_service.dart';
import 'logger_service.dart';

final _log = LoggerService();

/// Voice Call Service using WebRTC for real-time audio communication
class VoiceCallService {
  // Fallback STUN-only config (used if TURN credentials fetch fails)
  static const Map<String, dynamic> _fallbackIceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
    ]
  };

  // Cached ICE servers from server (fetched at runtime)
  static Map<String, dynamic>? _cachedIceServers;
  static DateTime? _cacheExpiry;

  /// Fetch TURN credentials from server (cached for 24h)
  static Future<Map<String, dynamic>> _getIceServers() async {
    if (_cachedIceServers != null && _cacheExpiry != null && DateTime.now().isBefore(_cacheExpiry!)) {
      return _cachedIceServers!;
    }

    try {
      final apiService = ApiService();
      final token = apiService.token;
      if (token == null) {
        debugPrint('[VoiceCall] No token, using fallback STUN servers');
        return _fallbackIceServers;
      }

      final httpClient = HttpClient()..connectionTimeout = const Duration(seconds: 10);
      final client = IOClient(httpClient);
      try {
        final response = await client.post(
          Uri.parse('${ApiService.baseUrl}/auth/turn_credentials.php'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success'] == true && data['ice_servers'] != null) {
            _cachedIceServers = {
              'iceServers': List<Map<String, dynamic>>.from(
                (data['ice_servers'] as List).map((e) => Map<String, dynamic>.from(e)),
              ),
            };
            final ttl = data['ttl'] as int? ?? 86400;
            _cacheExpiry = DateTime.now().add(Duration(seconds: ttl));
            debugPrint('[VoiceCall] TURN credentials fetched, cached for ${ttl}s');
            return _cachedIceServers!;
          }
        }
        debugPrint('[VoiceCall] TURN fetch failed (${response.statusCode}), using fallback');
        return _fallbackIceServers;
      } finally {
        client.close();
      }
    } catch (e) {
      debugPrint('[VoiceCall] TURN fetch error: $e, using fallback');
      return _fallbackIceServers;
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
  bool _isSpeakerOn = true;

  // Stream controllers for UI updates
  final _callStateController = StreamController<CallState>.broadcast();
  final _remoteStreamController = StreamController<MediaStream?>.broadcast();
  final _incomingCallController = StreamController<IncomingCall>.broadcast();

  // Public streams
  Stream<CallState> get callStateStream => _callStateController.stream;
  Stream<MediaStream?> get remoteStreamStream => _remoteStreamController.stream;
  Stream<IncomingCall> get incomingCallStream => _incomingCallController.stream;

  // Getters
  CallState get callState => _callState;
  bool get isMuted => _isMuted;
  bool get isSpeakerOn => _isSpeakerOn;
  int? get currentConversationId => _currentConversationId;

  // Callback for sending signaling messages via WebSocket
  Function(Map<String, dynamic>)? onSignalingMessage;

  // Singleton
  static final VoiceCallService _instance = VoiceCallService._internal();
  factory VoiceCallService() => _instance;
  VoiceCallService._internal();

  /// Initialize a call (caller side)
  Future<bool> startCall(int conversationId, String targetUserId, String targetUserName) async {
    _log.info('VoiceCallService: startCall() - conv: $conversationId, target: $targetUserName', tag: 'CALL');
    if (_callState != CallState.idle) {
      _log.warning('VoiceCallService: startCall() aborted - already in state: $_callState', tag: 'CALL');
      return false;
    }

    try {
      _currentConversationId = conversationId;
      _setCallState(CallState.calling);

      // Get local audio stream
      _log.debug('VoiceCallService: Getting local audio stream...', tag: 'CALL');
      _localStream = await _getLocalStream();
      if (_localStream == null) {
        _log.error('VoiceCallService: Failed to get local stream', tag: 'CALL');
        _setCallState(CallState.idle);
        return false;
      }
      _log.info('VoiceCallService: Local stream acquired', tag: 'CALL');

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

      // Create offer
      _log.debug('VoiceCallService: Creating SDP offer...', tag: 'CALL');
      final offer = await _peerConnection!.createOffer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': false,
      });
      await _peerConnection!.setLocalDescription(offer);
      _log.info('VoiceCallService: SDP offer created and set as local description', tag: 'CALL');

      // Send offer via WebSocket
      _log.info('VoiceCallService: Sending call_offer via signaling', tag: 'CALL');
      onSignalingMessage?.call({
        'type': 'call_offer',
        'conversation_id': conversationId,
        'target_user_id': targetUserId,
        'sdp': offer.sdp,
        'sdp_type': offer.type,
      });

      return true;
    } catch (e) {
      _log.error('VoiceCallService: startCall() error: $e', tag: 'CALL');
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

  /// Accept incoming call
  Future<bool> acceptCall(String sdp, String sdpType) async {
    _log.info('VoiceCallService: acceptCall() - current state: $_callState', tag: 'CALL');
    if (_callState != CallState.ringing) {
      _log.warning('VoiceCallService: acceptCall() aborted - wrong state: $_callState', tag: 'CALL');
      return false;
    }

    try {
      _setCallState(CallState.connecting);

      // Get local audio stream
      _log.debug('VoiceCallService: Getting local audio stream for accept...', tag: 'CALL');
      _localStream = await _getLocalStream();
      if (_localStream == null) {
        _log.error('VoiceCallService: Failed to get local stream for accept', tag: 'CALL');
        await endCall();
        return false;
      }
      _log.info('VoiceCallService: Local stream acquired for accept', tag: 'CALL');

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

      // Set remote description (the offer)
      _log.debug('VoiceCallService: Setting remote description (offer)...', tag: 'CALL');
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(sdp, sdpType),
      );
      _remoteDescriptionSet = true;
      _log.info('VoiceCallService: Remote description set successfully', tag: 'CALL');

      // Process queued ICE candidates (Fix 1)
      await _processQueuedIceCandidates();

      // Create answer
      _log.debug('VoiceCallService: Creating SDP answer...', tag: 'CALL');
      final answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);
      _log.info('VoiceCallService: SDP answer created and set as local description', tag: 'CALL');

      // Send answer via WebSocket
      _log.info('VoiceCallService: Sending call_answer via signaling', tag: 'CALL');
      onSignalingMessage?.call({
        'type': 'call_answer',
        'conversation_id': _currentConversationId,
        'sdp': answer.sdp,
        'sdp_type': answer.type,
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
    // On Windows, speaker toggle is handled by system audio
  }

  /// Create WebRTC peer connection
  Future<void> _createPeerConnection() async {
    _log.debug('VoiceCallService: Creating RTCPeerConnection...', tag: 'CALL');
    final iceServers = await _getIceServers();
    _peerConnection = await createPeerConnection(iceServers);
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
        }
      } else {
        _log.warning('VoiceCallService: ⚠️⚠️⚠️ onTrack event but NO STREAMS! This is abnormal!', tag: 'CALL');
      }
    };
  }

  /// Get local audio stream with detailed logging
  Future<MediaStream?> _getLocalStream() async {
    try {
      _log.info('VoiceCallService: 🎤 Enumerating audio devices...', tag: 'CALL');

      // Check for audio devices first
      final devices = await navigator.mediaDevices.enumerateDevices();
      _log.info('VoiceCallService: 🎤 Total devices found: ${devices.length}', tag: 'CALL');

      // Log all devices for debugging
      for (var i = 0; i < devices.length; i++) {
        final device = devices[i];
        _log.info('VoiceCallService: 🎤 Device $i: kind=${device.kind}, label="${device.label}", deviceId=${device.deviceId}', tag: 'CALL');
      }

      final audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
      final audioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();
      final videoInputs = devices.where((d) => d.kind == 'videoinput').toList();

      _log.info('VoiceCallService: 🎤 Audio inputs: ${audioInputs.length}', tag: 'CALL');
      _log.info('VoiceCallService: 🔊 Audio outputs: ${audioOutputs.length}', tag: 'CALL');
      _log.info('VoiceCallService: 📹 Video inputs: ${videoInputs.length}', tag: 'CALL');

      if (audioInputs.isEmpty) {
        _log.error('VoiceCallService: ❌ NO MICROPHONE FOUND! Cannot start voice call.', tag: 'CALL');
        _log.error('VoiceCallService: ❌ Machine may not have audio hardware or drivers installed', tag: 'CALL');
        throw Exception('NO_MICROPHONE');
      }

      // Log selected microphone
      final selectedMic = audioInputs[0];
      _log.info('VoiceCallService: ✓ Using microphone: "${selectedMic.label}" (${selectedMic.deviceId})', tag: 'CALL');

      // Fix 2 - Audio Device Selection with explicit deviceId
      final constraints = {
        'audio': {
          'deviceId': selectedMic.deviceId,  // Explicit device selection
          'echoCancellation': true,
          'noiseSuppression': true,
          'autoGainControl': true,
        },
        'video': false,
      };

      _log.debug('VoiceCallService: getUserMedia with deviceId: ${selectedMic.deviceId}', tag: 'CALL');
      final stream = await navigator.mediaDevices.getUserMedia(constraints);
      _log.info('VoiceCallService: ✓✓✓ Audio stream acquired successfully!', tag: 'CALL');
      _log.info('VoiceCallService: Stream tracks: ${stream.getTracks().length}', tag: 'CALL');

      for (var track in stream.getTracks()) {
        _log.info('VoiceCallService: Track: ${track.kind}, enabled: ${track.enabled}, muted: ${track.muted}', tag: 'CALL');
      }

      return stream;
    } catch (e) {
      _log.error('VoiceCallService: ❌ _getLocalStream() failed: $e', tag: 'CALL');
      rethrow;
    }
  }

  /// Set call state and notify listeners
  void _setCallState(CallState state) {
    _log.info('VoiceCallService: STATE CHANGE: $_callState → $state (notifying listeners)', tag: 'CALL');
    _callState = state;
    _callStateController.add(state);
  }

  /// Cleanup resources
  void _cleanup() {
    _log.info('VoiceCallService: _cleanup() - releasing WebRTC resources', tag: 'CALL');
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
    _isSpeakerOn = true;

    _setCallState(CallState.idle);
    _log.debug('VoiceCallService: Cleanup completed, state reset to idle', tag: 'CALL');
  }

  /// Dispose service
  void dispose() {
    _cleanup();
    _callStateController.close();
    _remoteStreamController.close();
    _incomingCallController.close();
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
