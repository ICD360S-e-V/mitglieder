import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'notification_service.dart';
import 'logger_service.dart';
import 'api_service.dart';

final _log = LoggerService();

/// ChatService handles WebSocket connection for real-time chat and voice calls
class ChatService {
  static const String wsUrl = 'wss://icd360sev.icd360s.de/wss/';

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  bool _isConnected = false;
  String? _currentMitgliedernummer;

  // ── Wiederverbindung ────────────────────────────────────────────────────
  //
  // Bis heute gab es hier gar keine. Riss die Verbindung — Netzwechsel,
  // Funkloch, Serverneustart —, blieb der Chat stumm, bis jemand die
  // Anwendung neu startete. Der Hintergrunddienst bringt seine eigene mit;
  // der Chat im Vordergrund, der auf demselben Bildschirm „verbunden"
  // anzeigt, hatte keine.
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _shouldReconnect = false;
  static const int _maxReconnectAttempts = 10;
  static const Duration _initialReconnectDelay = Duration(seconds: 2);
  static const Duration _maxReconnectDelay = Duration(seconds: 60);

  /// Der naechste Anlauf soll sich zuerst ein frisches Token holen.
  /// Wird allein von `auth_error` gesetzt und beim Verbrauch geloescht.
  bool _tokenErneuern = false;

  /// Nur fuer Tests: die Adresse, gegen die der Handschlag laeuft.
  ///
  /// ⚠️ Ohne diese Naht liesse sich der Weg nach einem misslungenen Versuch
  /// nur gegen den Produktivserver pruefen — ein Test, der ohne Leitung rot
  /// wird, sagt am Ende nichts.
  @visibleForTesting
  static String? testWsUrl;

  /// Nur fuer Tests: wartet gerade ein Wiederverbindungsversuch?
  @visibleForTesting
  bool get wiederverbindungWartet => _reconnectTimer?.isActive ?? false;

  /// Nur fuer Tests: wie viele Versuche der Zaehler verbucht hat.
  @visibleForTesting
  int get versucheBisher => _reconnectAttempts;

  // Stream controllers for chat events
  final _messageController = StreamController<ChatMessage>.broadcast();
  final _typingController = StreamController<TypingEvent>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();
  final _errorController = StreamController<String>.broadcast();

  // Stream controllers for call events
  final _callOfferController = StreamController<CallOfferEvent>.broadcast();
  final _callAnswerController = StreamController<CallAnswerEvent>.broadcast();
  final _callRejectedController = StreamController<CallRejectedEvent>.broadcast();
  final _callEndedController = StreamController<CallEndedEvent>.broadcast();
  final _iceCandidateController = StreamController<IceCandidateEvent>.broadcast();
  final _callBusyController = StreamController<int>.broadcast();

  // Stream controllers for remote-control (Fernwartung) events. Separate feature
  // from voice calls — its own frame types so the two never mix. (This app is the
  // AGENT side: it receives remote_offer and shares its screen after consent.)
  final _remoteOfferController = StreamController<RemoteOfferEvent>.broadcast();
  final _remoteAnswerController = StreamController<RemoteAnswerEvent>.broadcast();
  final _remoteRejectedController = StreamController<RemoteRejectedEvent>.broadcast();
  final _remoteEndedController = StreamController<RemoteEndedEvent>.broadcast();
  final _remoteIceController = StreamController<RemoteIceEvent>.broadcast();

  // Stream controller for read receipts
  final _readReceiptController = StreamController<ReadReceiptEvent>.broadcast();

  // Stream controller for message expiry (5-min TTL after read; server NULLed body)
  final _messageExpiredController = StreamController<MessageExpiredEvent>.broadcast();

  // Stream controller for WhatsApp-style reaction updates (add/change/remove)
  final _reactionUpdateController = StreamController<ReactionUpdateEvent>.broadcast();

  // Stream controller for new device login notifications
  final _newDeviceLoginController = StreamController<NewDeviceLoginEvent>.broadcast();

  // Stream controller for ticket notifications
  final _ticketNotificationController = StreamController<TicketNotificationEvent>.broadcast();

  // Public streams - Chat
  Stream<ChatMessage> get messageStream => _messageController.stream;
  Stream<TypingEvent> get typingStream => _typingController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  Stream<String> get errorStream => _errorController.stream;

  // Public streams - Voice Call
  Stream<CallOfferEvent> get callOfferStream => _callOfferController.stream;
  Stream<CallAnswerEvent> get callAnswerStream => _callAnswerController.stream;
  Stream<CallRejectedEvent> get callRejectedStream => _callRejectedController.stream;
  Stream<CallEndedEvent> get callEndedStream => _callEndedController.stream;
  Stream<IceCandidateEvent> get iceCandidateStream => _iceCandidateController.stream;
  Stream<int> get callBusyStream => _callBusyController.stream;

  // Public streams - Remote Control (Fernwartung)
  Stream<RemoteOfferEvent> get remoteOfferStream => _remoteOfferController.stream;
  Stream<RemoteAnswerEvent> get remoteAnswerStream => _remoteAnswerController.stream;
  Stream<RemoteRejectedEvent> get remoteRejectedStream => _remoteRejectedController.stream;
  Stream<RemoteEndedEvent> get remoteEndedStream => _remoteEndedController.stream;
  Stream<RemoteIceEvent> get remoteIceStream => _remoteIceController.stream;

  // Public stream - Read Receipts
  Stream<ReadReceiptEvent> get readReceiptStream => _readReceiptController.stream;

  // Public stream - Message Expired (delete-on-read tombstones from server)
  Stream<MessageExpiredEvent> get messageExpiredStream => _messageExpiredController.stream;

  // Public stream - Reaction Updates
  Stream<ReactionUpdateEvent> get reactionUpdateStream => _reactionUpdateController.stream;

  // Public stream - New Device Login
  Stream<NewDeviceLoginEvent> get newDeviceLoginStream => _newDeviceLoginController.stream;

  // Public stream - Ticket Notifications
  Stream<TicketNotificationEvent> get ticketNotificationStream => _ticketNotificationController.stream;

  bool get isConnected => _isConnected;

  // Singleton
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  /// Connect to WebSocket server and authenticate
  ///
  /// [erneuterVersuch] setzt allein die Wiederverbindung. Ein Aufruf von
  /// aussen — Anmeldung, geoeffneter Chat — heisst „jemand will JETZT
  /// verbunden sein" und stellt den Zaehler zurueck.
  Future<bool> connect(String mitgliedernummer,
      {bool erneuterVersuch = false}) async {
    _log.info('WebSocket connect($mitgliedernummer) called', tag: 'WS');
    _currentMitgliedernummer = mitgliedernummer;
    _shouldReconnect = true;
    if (!erneuterVersuch) _reconnectAttempts = 0;

    if (_isConnected) {
      _log.info('Already connected, returning true', tag: 'WS');
      return true;
    }

    try {
      _log.info('Connecting to ${testWsUrl ?? wsUrl}...', tag: 'WS');

      // Security: Proper SSL certificate validation for WebSocket
      // Let Android/iOS trust store validate the certificate chain
      final webSocket = await WebSocket.connect(testWsUrl ?? wsUrl);
      // Keepalive: ping every 20s. The signaling channel goes completely idle
      // once a call's ICE negotiation finishes, and an idle TCP connection gets
      // reaped by mobile-carrier / CGNAT boxes after ~60s. When that happens the
      // server's onClose fires and broadcasts call_ended (reason 'disconnected')
      // to the peer — i.e. calls dropped at ~1 min. These ping frames keep the
      // NAT mapping warm (the server auto-replies pong); pingInterval also gives
      // faster dead-connection detection → quicker reconnect.
      webSocket.pingInterval = const Duration(seconds: 20);
      _channel = IOWebSocketChannel(webSocket);

      final completer = Completer<bool>();

      _subscription = _channel!.stream.listen(
        (data) {
          _log.debug('WS received: ${data.toString().substring(0, data.toString().length > 100 ? 100 : data.toString().length)}...', tag: 'WS');
          _handleMessage(data, completer);
        },
        onError: (error) {
          _log.error('WS error: $error', tag: 'WS');
          _isConnected = false;
          _connectionController.add(false);
          _errorController.add('Connection error: $error');
          if (!completer.isCompleted) {
            completer.complete(false);
          }
          _scheduleReconnect();
        },
        onDone: () {
          _log.warning('WS connection closed', tag: 'WS');
          _isConnected = false;
          _connectionController.add(false);
          if (!completer.isCompleted) {
            completer.complete(false);
          }
          _scheduleReconnect();
        },
      );

      // Send authentication message. Include the JWT so the server can verify the
      // connection and bind it to the token's user, matching what the background
      // service already sends. In the body (not the URL) so it never hits logs.
      final token = ApiService().token;
      _log.info('Sending auth for $mitgliedernummer (token: ${token != null ? 'present' : 'MISSING'})', tag: 'WS');
      _send({
        'type': 'auth',
        'mitgliedernummer': mitgliedernummer,
        if (token != null) 'token': token,
      });

      // Wait for auth response with timeout
      final result = await completer.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          _log.error('Connection timeout after 10s', tag: 'WS');
          _errorController.add('Connection timeout');
          return false;
        },
      );
      _log.info('Connect result: $result', tag: 'WS');
      // ⚠️ `false` heisst hier: der Draht steht, die Anmeldung darauf nicht —
      // `auth_error` oder die zehn Sekunden Wartezeit. Weder `onDone` noch
      // `onError` melden sich dabei, denn niemand hat geschlossen.
      if (!result) {
        _verbindungAufraeumen();
        _scheduleReconnect();
      }
      return result;
    } catch (e) {
      _log.error('Connect failed: $e', tag: 'WS');
      _errorController.add('Failed to connect: $e');
      _verbindungAufraeumen();
      _scheduleReconnect();
      return false;
    }
  }

  /// Raeumt einen misslungenen Versuch weg, ohne die Wiederverbindung abzusagen.
  ///
  /// ⚠️ Erst abbestellen, dann schliessen — sonst liefe `onDone` noch durch
  /// und verbrauchte einen zweiten der zehn Versuche fuer dieselbe Stoerung.
  void _verbindungAufraeumen() {
    _subscription?.cancel();
    _subscription = null;
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
  }

  /// Plant einen neuen Versuch mit wachsendem Abstand: 2, 4, 8 … 60 Sekunden.
  void _scheduleReconnect() {
    // ⚠️ Ein gerissener Socket meldet sich ZWEIMAL: erst `onError`, dann
    // `onDone`. Wartet schon einer, ist alles Noetige getan.
    if (_reconnectTimer?.isActive ?? false) return;
    if (!_shouldReconnect || _currentMitgliedernummer == null) return;

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _log.error('Max reconnect attempts reached, giving up', tag: 'WS-RECONNECT');
      _shouldReconnect = false;
      return;
    }

    final sekunden = (_initialReconnectDelay.inSeconds * (1 << _reconnectAttempts))
        .clamp(0, _maxReconnectDelay.inSeconds);
    _reconnectAttempts++;
    _log.info('Scheduling reconnect attempt $_reconnectAttempts in ${sekunden}s',
        tag: 'WS-RECONNECT');
    _reconnectTimer = Timer(Duration(seconds: sekunden), _reconnect);
  }

  Future<void> _reconnect() async {
    if (!_shouldReconnect || _currentMitgliedernummer == null) return;
    _log.info('Attempting reconnect (attempt $_reconnectAttempts)...', tag: 'WS-RECONNECT');
    _verbindungAufraeumen();

    // Nur nach einer abgelehnten Anmeldung, nicht bei jedem Netzhaenger: ein
    // Abruf ueber dieselbe gestoerte Leitung kostet sonst bloss Zeit.
    if (_tokenErneuern) {
      _tokenErneuern = false;
      try {
        final frisch = await ApiService().refreshAccessToken();
        _log.info('Token vor Wiederverbindung erneuert: $frisch', tag: 'WS-RECONNECT');
      } catch (e) {
        _log.warning('Token-Erneuerung fehlgeschlagen: $e', tag: 'WS-RECONNECT');
      }
    }

    final erfolg = await connect(_currentMitgliedernummer!, erneuterVersuch: true);
    if (erfolg) {
      _log.info('Reconnection successful!', tag: 'WS-RECONNECT');
      _reconnectAttempts = 0;
    }
  }

  /// Disconnect from WebSocket server
  void disconnect() {
    // Hier will der Mensch weg — im Gegensatz zu `_verbindungAufraeumen`,
    // das nur einen misslungenen Versuch wegraeumt. Ein liegengebliebener
    // Zeitgeber weckt sonst eine Anwendung, die geschlossen wurde.
    _shouldReconnect = false;
    // Der Mensch geht; die gemerkten Raeume sollen eine spaetere, neue
    // Anmeldung nicht mehr belasten.
    _raeume.clear();
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _subscription?.cancel();
    _subscription = null;
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _connectionController.add(false);
  }

  /// Raeume, in denen diese App sein WILL.
  ///
  /// ⚠️ Der Beitritt haengt am SOCKET, nicht am Konto: nach einer
  /// Wiederverbindung ist die Verbindung auf dem Server eine neue und in
  /// keinem Raum mehr. Die Wiederverbindung gibt es seit laengerem, den
  /// erneuten Beitritt gab es nicht — das Mitglied fiel also nach jedem
  /// Netzwechsel stumm aus seiner eigenen Unterhaltung, bis die App neu
  /// gestartet oder der Chat von Hand geoeffnet wurde. Sichtbar wurde das
  /// nie, weil Benachrichtigungen ueber den Hintergrunddienst weiterliefen.
  final Set<int> _raeume = <int>{};

  /// Join a conversation room
  void joinConversation(int conversationId) {
    _log.info('Joining conversation $conversationId', tag: 'WS');
    _raeume.add(conversationId);
    _send({
      'type': 'join',
      'conversation_id': conversationId,
    });
  }

  /// Leave a conversation room
  void leaveConversation(int conversationId) {
    _raeume.remove(conversationId);
    _send({
      'type': 'leave',
      'conversation_id': conversationId,
    });
  }

  /// Nach erfolgreicher Anmeldung alle gemerkten Raeume erneut betreten.
  void _raeumeWiederbetreten() {
    if (_raeume.isEmpty) return;
    _log.info('Wiederbetrete ${_raeume.length} Raum/Raeume nach Anmeldung', tag: 'WS');
    for (final id in _raeume) {
      _send({'type': 'join', 'conversation_id': id});
    }
  }

  /// Send a chat message
  void sendMessage(int conversationId, String message) {
    _send({
      'type': 'message',
      'conversation_id': conversationId,
      'message': message,
    });
  }

  /// Send typing indicator
  void sendTyping(int conversationId) {
    _send({
      'type': 'typing',
      'conversation_id': conversationId,
    });
  }

  // ==================== Voice Call Methods ====================

  /// Send call offer (initiate call)
  void sendCallOffer(int conversationId, String sdp, String sdpType) {
    _send({
      'type': 'call_offer',
      'conversation_id': conversationId,
      'sdp': sdp,
      'sdp_type': sdpType,
    });
  }

  /// Send call answer (accept call)
  void sendCallAnswer(int conversationId, String sdp, String sdpType) {
    _send({
      'type': 'call_answer',
      'conversation_id': conversationId,
      'sdp': sdp,
      'sdp_type': sdpType,
    });
  }

  /// Send call rejection
  void sendCallReject(int conversationId, String reason) {
    _send({
      'type': 'call_reject',
      'conversation_id': conversationId,
      'reason': reason,
    });
  }

  /// Send call end
  void sendCallEnd(int conversationId) {
    _send({
      'type': 'call_end',
      'conversation_id': conversationId,
    });
  }

  /// Send ICE candidate
  void sendIceCandidate(int conversationId, String candidate, String sdpMid, int sdpMLineIndex) {
    _send({
      'type': 'ice_candidate',
      'conversation_id': conversationId,
      'candidate': candidate,
      'sdp_mid': sdpMid,
      'sdp_mline_index': sdpMLineIndex,
    });
  }

  // ==================== Remote Control (Fernwartung) Methods ====================
  // Separate signaling from voice calls; own frame types so the two never mix.

  /// Vorsitzer → member: request a remote-control session (carries the WebRTC offer).
  void sendRemoteOffer(int conversationId, String targetUserId, String sdp, String sdpType,
      {String? controllerName}) {
    _send({
      'type': 'remote_offer',
      'conversation_id': conversationId,
      'target_user_id': targetUserId,
      'sdp': sdp,
      'sdp_type': sdpType,
      if (controllerName != null) 'controller_name': controllerName,
    });
  }

  /// Member → Vorsitzer: accept and answer the session (carries the WebRTC answer).
  void sendRemoteAnswer(
    int conversationId,
    String sdp,
    String sdpType, {
    String? plattform,
    bool? steuerung,
  }) {
    _send({
      'type': 'remote_answer',
      'conversation_id': conversationId,
      'sdp': sdp,
      'sdp_type': sdpType,
      if (plattform != null) 'plattform': plattform,
      if (steuerung != null) 'steuerung': steuerung,
    });
  }

  /// Member → Vorsitzer: decline the remote-control request.
  void sendRemoteReject(int conversationId, String reason) {
    _send({
      'type': 'remote_reject',
      'conversation_id': conversationId,
      'reason': reason,
    });
  }

  /// Either side: tear the remote-control session down.
  void sendRemoteEnd(int conversationId) {
    _send({
      'type': 'remote_end',
      'conversation_id': conversationId,
    });
  }

  /// ICE candidate for the remote-control peer connection. Own frame type so it
  /// is never mixed with the voice-call ice_candidate stream.
  void sendRemoteIce(int conversationId, String candidate, String sdpMid, int sdpMLineIndex) {
    _send({
      'type': 'remote_ice',
      'conversation_id': conversationId,
      'candidate': candidate,
      'sdp_mid': sdpMid,
      'sdp_mline_index': sdpMLineIndex,
    });
  }

  /// Send read receipt (mark messages as delivered or read)
  void sendReadReceipt(int conversationId, List<int> messageIds, String status) {
    _send({
      'type': 'read_receipt',
      'conversation_id': conversationId,
      'message_ids': messageIds,
      'status': status, // 'delivered' or 'read'
    });
  }

  /// Broadcast a reaction change so the other party updates in place.
  /// reaction = enum key or '' to remove. Server excludes the sender from the
  /// broadcast, so there is no echo back to us.
  void sendReactionUpdate(int conversationId, int messageId, String reaction) {
    _send({
      'type': 'reaction_update',
      'conversation_id': conversationId,
      'message_id': messageId,
      'reaction': reaction, // '' pentru ștergere
    });
  }

  void _send(Map<String, dynamic> data) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode(data));
    }
  }

  void _handleMessage(dynamic data, [Completer<bool>? authCompleter]) {
    try {
      final json = jsonDecode(data);
      final type = json['type'];

      switch (type) {
        case 'auth_success':
          _isConnected = true;
          _reconnectAttempts = 0;
          _connectionController.add(true);
          // ⚠️ Erst hier, nicht schon beim Oeffnen des Sockets: vor der
          // Anmeldung weist der Server jedes `join` mit „Not authenticated" ab.
          _raeumeWiederbetreten();
          authCompleter?.complete(true);
          break;

        case 'auth_error':
          _isConnected = false;
          // Der Server nimmt die Identitaet aus dem Token, und das laeuft nach
          // einer Stunde ab. Die haeufigste Ablehnung ist ein zu altes Token —
          // mit demselben noch zehnmal anzuklopfen kann nur wieder scheitern.
          _tokenErneuern = true;
          _errorController.add(json['error'] ?? 'Authentication failed');
          authCompleter?.complete(false);
          break;

        case 'joined':
          // Successfully joined conversation
          break;

        case 'new_message':
          // For own messages, ignore translated_message (show original)
          final senderMnr = json['sender_mitgliedernummer']?.toString() ?? '';
          final sId = json['sender_id']?.toString() ?? '';
          final isOwn = (_currentMitgliedernummer != null &&
              (senderMnr == _currentMitgliedernummer || sId == _currentMitgliedernummer));
          if (isOwn) {
            json.remove('translated_message');
          }
          final chatMsg = ChatMessage.fromJson(json);
          _messageController.add(chatMsg);

          // Skip notification for own messages
          final senderMitgliedernummer = json['sender_mitgliedernummer']?.toString() ?? '';
          final senderId = json['sender_id']?.toString() ?? '';
          final isOwnMessage = (_currentMitgliedernummer != null &&
              (senderMitgliedernummer == _currentMitgliedernummer ||
               senderId == _currentMitgliedernummer));

          if (isOwnMessage) {
            _log.debug('ChatService: Skipping notification for own message', tag: 'CHAT');
            break;
          }

          // Check if message is urgent (admin or explicit flag)
          final isUrgent = json['urgent'] == true || json['urgent'] == 1;
          final senderRole = json['sender_role']?.toString().toLowerCase() ?? '';
          final isFromAdmin = senderRole.contains('vorsitzer') ||
                              senderRole.contains('schatzmeister') ||
                              senderRole.contains('kassierer') ||
                              senderRole.contains('mitgliedergrunder');

          // Show urgent or normal notification
          if (isUrgent || isFromAdmin) {
            NotificationService().showUrgentMessage(
              title: chatMsg.senderName,
              message: chatMsg.message,
              senderName: chatMsg.senderName,
              conversationId: chatMsg.conversationId,
            );
            _log.info('🚨 URGENT message notification shown', tag: 'CHAT');
          } else {
            NotificationService().showChatMessage(
              senderName: chatMsg.senderName,
              message: chatMsg.message,
              conversationId: chatMsg.conversationId,
            );
          }
          break;

        case 'typing':
          _typingController.add(TypingEvent(
            userName: json['user_name'] ?? '',
            isAdmin: json['is_admin'] ?? false,
          ));
          break;

        case 'new_device_login':
          final newDeviceEvent = NewDeviceLoginEvent.fromJson(json);
          _newDeviceLoginController.add(newDeviceEvent);
          // Show native notification
          NotificationService().show(
            title: NotificationService().notifNewLoginDetected,
            body: '${newDeviceEvent.deviceName} • ${newDeviceEvent.ipAddress}',
          );
          break;

        case 'ticket_notification':
          final ticketEvent = TicketNotificationEvent.fromJson(json);
          _ticketNotificationController.add(ticketEvent);
          // Show native notification
          NotificationService().showTicketUpdate(
            title: ticketEvent.title,
            message: ticketEvent.message,
            ticketId: ticketEvent.ticketId,
          );
          break;

        case 'user_joined':
        case 'user_left':
        case 'user_disconnected':
          // Handle user presence events if needed
          break;

        // Voice call events
        case 'call_offer':
          _log.info('📞📞📞 WebSocket: CALL_OFFER received!', tag: 'CHAT');
          _log.info('📞 From: ${json['caller_name']} (${json['caller_id']})', tag: 'CHAT');
          _log.info('📞 Conversation: ${json['conversation_id']}', tag: 'CHAT');
          _log.info('📞 SDP Type: ${json['sdp_type']}', tag: 'CHAT');
          _log.info('📞 SDP Length: ${(json['sdp'] as String?)?.length ?? 0} characters', tag: 'CHAT');

          final callEvent = CallOfferEvent(
            conversationId: json['conversation_id'] ?? 0,
            callerId: json['caller_id']?.toString() ?? '',
            callerName: json['caller_name'] ?? '',
            sdp: json['sdp'] ?? '',
            sdpType: json['sdp_type'] ?? 'offer',
          );
          _callOfferController.add(callEvent);
          _log.info('📞 CallOfferEvent added to stream', tag: 'CHAT');

          // Show notification for incoming call
          NotificationService().showIncomingCall(
            callerName: callEvent.callerName,
            conversationId: callEvent.conversationId,
          );
          _log.info('📞 Incoming call notification shown', tag: 'CHAT');
          break;

        case 'call_answer':
          _log.info('✅✅✅ WebSocket: CALL_ANSWER received!', tag: 'CHAT');
          _log.info('✅ From: ${json['answerer_name']} (${json['answerer_id']})', tag: 'CHAT');
          _log.info('✅ Conversation: ${json['conversation_id']}', tag: 'CHAT');
          _log.info('✅ SDP Type: ${json['sdp_type']}', tag: 'CHAT');
          _log.info('✅ SDP Length: ${(json['sdp'] as String?)?.length ?? 0} characters', tag: 'CHAT');

          _callAnswerController.add(CallAnswerEvent(
            conversationId: json['conversation_id'] ?? 0,
            answererId: json['answerer_id']?.toString() ?? '',
            answererName: json['answerer_name'] ?? '',
            sdp: json['sdp'] ?? '',
            sdpType: json['sdp_type'] ?? 'answer',
          ));
          _log.info('✅ CallAnswerEvent added to stream', tag: 'CHAT');
          break;

        case 'call_rejected':
          _callRejectedController.add(CallRejectedEvent(
            conversationId: json['conversation_id'] ?? 0,
            rejectedBy: json['rejected_by'] ?? '',
            reason: json['reason'] ?? 'rejected',
          ));
          break;

        case 'call_ended':
          _log.info('🛑🛑🛑 WebSocket: CALL_ENDED received!', tag: 'CHAT');
          _log.info('🛑 Ended by: ${json['ended_by']}', tag: 'CHAT');
          _log.info('🛑 Conversation: ${json['conversation_id']}', tag: 'CHAT');
          _log.info('🛑 Reason: ${json['reason'] ?? 'no reason specified'}', tag: 'CHAT');

          _callEndedController.add(CallEndedEvent(
            conversationId: json['conversation_id'] ?? 0,
            endedBy: json['ended_by'] ?? '',
            reason: json['reason'],
          ));
          _log.info('🛑 CallEndedEvent added to stream', tag: 'CHAT');
          break;

        case 'ice_candidate':
          _log.info('🧊 WebSocket: ICE_CANDIDATE received', tag: 'CHAT');
          _log.info('🧊 Conversation: ${json['conversation_id']}', tag: 'CHAT');
          _log.info('🧊 SDP Mid: ${json['sdp_mid']}', tag: 'CHAT');
          _log.info('🧊 SDP MLine Index: ${json['sdp_mline_index']}', tag: 'CHAT');
          _log.info('🧊 Candidate: ${json['candidate']}', tag: 'CHAT');

          _iceCandidateController.add(IceCandidateEvent(
            conversationId: json['conversation_id'] ?? 0,
            candidate: json['candidate'] ?? '',
            sdpMid: json['sdp_mid'] ?? '',
            sdpMLineIndex: json['sdp_mline_index'] ?? 0,
          ));
          _log.info('🧊 IceCandidateEvent added to stream', tag: 'CHAT');
          break;

        case 'call_busy':
          _callBusyController.add(json['conversation_id'] ?? 0);
          break;

        // Remote-control (Fernwartung) events. This app is the AGENT: it acts on
        // remote_offer (consent prompt), remote_ice and remote_ended.
        case 'remote_offer':
          _log.info('🖥️ WebSocket: REMOTE_OFFER received from ${json['controller_name'] ?? json['caller_name']}', tag: 'REMOTE');
          _remoteOfferController.add(RemoteOfferEvent(
            conversationId: json['conversation_id'] ?? 0,
            controllerId: json['controller_id']?.toString() ?? json['caller_id']?.toString() ?? '',
            controllerName: json['controller_name'] ?? json['caller_name'] ?? '',
            sdp: json['sdp'] ?? '',
            sdpType: json['sdp_type'] ?? 'offer',
          ));
          break;

        case 'remote_answer':
          _remoteAnswerController.add(RemoteAnswerEvent(
            conversationId: json['conversation_id'] ?? 0,
            answererId: json['answerer_id']?.toString() ?? '',
            sdp: json['sdp'] ?? '',
            sdpType: json['sdp_type'] ?? 'answer',
          ));
          break;

        case 'remote_rejected':
          _remoteRejectedController.add(RemoteRejectedEvent(
            conversationId: json['conversation_id'] ?? 0,
            rejectedBy: json['rejected_by'] ?? '',
            reason: json['reason'] ?? 'rejected',
          ));
          break;

        case 'remote_ended':
          _remoteEndedController.add(RemoteEndedEvent(
            conversationId: json['conversation_id'] ?? 0,
            endedBy: json['ended_by'] ?? '',
            reason: json['reason'],
          ));
          break;

        case 'remote_ice':
          _remoteIceController.add(RemoteIceEvent(
            conversationId: json['conversation_id'] ?? 0,
            candidate: json['candidate'] ?? '',
            sdpMid: json['sdp_mid'] ?? '',
            sdpMLineIndex: json['sdp_mline_index'] ?? 0,
          ));
          break;

        case 'read_receipt':
          _readReceiptController.add(ReadReceiptEvent.fromJson(json));
          break;

        case 'message_expired':
          _messageExpiredController.add(MessageExpiredEvent.fromJson(json));
          break;

        case 'reaction_update':
          _reactionUpdateController.add(ReactionUpdateEvent.fromJson(json));
          break;

        case 'error':
          _errorController.add(json['error'] ?? 'Unknown error');
          break;
      }
    } catch (e) {
      _errorController.add('Failed to parse message: $e');
    }
  }

  /// Clean up resources
  void dispose() {
    disconnect();
    _messageController.close();
    _typingController.close();
    _connectionController.close();
    _errorController.close();
    _callOfferController.close();
    _callAnswerController.close();
    _callRejectedController.close();
    _callEndedController.close();
    _iceCandidateController.close();
    _callBusyController.close();
    _readReceiptController.close();
    _messageExpiredController.close();
    _reactionUpdateController.close();
    _newDeviceLoginController.close();
    _ticketNotificationController.close();
    _remoteOfferController.close();
    _remoteAnswerController.close();
    _remoteRejectedController.close();
    _remoteEndedController.close();
    _remoteIceController.close();
  }
}

/// Chat message model
class ChatMessage {
  final int id;
  final int conversationId;
  final int senderId;
  final String senderName;
  final String senderRole;
  final bool isAdmin;
  final String message;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.isAdmin,
    required this.message,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    // Use translated_message if available (real-time translation from server)
    final translatedMsg = json['translated_message'];
    final originalMsg = json['message'] ?? '';
    return ChatMessage(
      id: json['message_id'] ?? 0,
      conversationId: json['conversation_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      senderName: json['sender_name'] ?? '',
      senderRole: json['sender_role'] ?? '',
      isAdmin: json['is_admin'] ?? false,
      message: (translatedMsg != null && translatedMsg.toString().isNotEmpty) ? translatedMsg.toString() : originalMsg,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}

/// Typing event model
class TypingEvent {
  final String userName;
  final bool isAdmin;

  TypingEvent({required this.userName, required this.isAdmin});
}

// ==================== Voice Call Event Models ====================

/// Call offer event (incoming call)
class CallOfferEvent {
  final int conversationId;
  final String callerId;
  final String callerName;
  final String sdp;
  final String sdpType;

  CallOfferEvent({
    required this.conversationId,
    required this.callerId,
    required this.callerName,
    required this.sdp,
    required this.sdpType,
  });
}

/// Call answer event
class CallAnswerEvent {
  final int conversationId;
  final String answererId;
  final String answererName;
  final String sdp;
  final String sdpType;

  CallAnswerEvent({
    required this.conversationId,
    required this.answererId,
    required this.answererName,
    required this.sdp,
    required this.sdpType,
  });
}

/// Call rejected event
class CallRejectedEvent {
  final int conversationId;
  final String rejectedBy;
  final String reason;

  CallRejectedEvent({
    required this.conversationId,
    required this.rejectedBy,
    required this.reason,
  });
}

/// Call ended event
class CallEndedEvent {
  final int conversationId;
  final String endedBy;
  final String? reason;

  CallEndedEvent({
    required this.conversationId,
    required this.endedBy,
    this.reason,
  });
}

/// ICE candidate event
class IceCandidateEvent {
  final int conversationId;
  final String candidate;
  final String sdpMid;
  final int sdpMLineIndex;

  IceCandidateEvent({
    required this.conversationId,
    required this.candidate,
    required this.sdpMid,
    required this.sdpMLineIndex,
  });
}

// ==================== Remote Control (Fernwartung) Event Models ====================

/// Incoming remote-control request — this app shows a consent prompt before any
/// screen is shared.
class RemoteOfferEvent {
  final int conversationId;
  final String controllerId;
  final String controllerName;
  final String sdp;
  final String sdpType;

  RemoteOfferEvent({
    required this.conversationId,
    required this.controllerId,
    required this.controllerName,
    required this.sdp,
    required this.sdpType,
  });
}

/// Remote-control answer (received by the Vorsitzer/controller side).
class RemoteAnswerEvent {
  final int conversationId;
  final String answererId;
  final String sdp;
  final String sdpType;

  RemoteAnswerEvent({
    required this.conversationId,
    required this.answererId,
    required this.sdp,
    required this.sdpType,
  });
}

/// Remote-control request declined by the member.
class RemoteRejectedEvent {
  final int conversationId;
  final String rejectedBy;
  final String reason;

  RemoteRejectedEvent({
    required this.conversationId,
    required this.rejectedBy,
    required this.reason,
  });
}

/// Remote-control session ended by either side.
class RemoteEndedEvent {
  final int conversationId;
  final String endedBy;
  final String? reason;

  RemoteEndedEvent({
    required this.conversationId,
    required this.endedBy,
    this.reason,
  });
}

/// ICE candidate for the remote-control peer connection (separate from the
/// voice-call IceCandidateEvent).
class RemoteIceEvent {
  final int conversationId;
  final String candidate;
  final String sdpMid;
  final int sdpMLineIndex;

  RemoteIceEvent({
    required this.conversationId,
    required this.candidate,
    required this.sdpMid,
    required this.sdpMLineIndex,
  });
}

/// Read receipt event (WhatsApp-style: sent -> delivered -> read)
class ReadReceiptEvent {
  final int conversationId;
  final List<int> messageIds;
  final String status; // 'delivered' or 'read'
  final String? readBy;
  final DateTime timestamp;
  /// Map of message_id (as string) -> expires_at ISO string, for countdown sync.
  /// Server populates this when status='read'; null/empty otherwise.
  final Map<String, String?> expires;

  ReadReceiptEvent({
    required this.conversationId,
    required this.messageIds,
    required this.status,
    this.readBy,
    required this.timestamp,
    this.expires = const {},
  });

  factory ReadReceiptEvent.fromJson(Map<String, dynamic> json) {
    final raw = json['expires'];
    final Map<String, String?> exp = {};
    if (raw is Map) {
      raw.forEach((k, v) {
        exp[k.toString()] = v?.toString();
      });
    }
    return ReadReceiptEvent(
      conversationId: json['conversation_id'] ?? 0,
      messageIds: List<int>.from(json['message_ids'] ?? []),
      status: json['status'] ?? 'delivered',
      readBy: json['read_by'],
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      expires: exp,
    );
  }
}

/// Message-expired event: server has NULLed the content of these messages after
/// the 5-minute read-TTL. Clients should fade them out and render the ghost bubble.
class MessageExpiredEvent {
  final int conversationId;
  final List<int> messageIds;
  final DateTime timestamp;

  MessageExpiredEvent({
    required this.conversationId,
    required this.messageIds,
    required this.timestamp,
  });

  factory MessageExpiredEvent.fromJson(Map<String, dynamic> json) {
    return MessageExpiredEvent(
      conversationId: json['conversation_id'] ?? 0,
      messageIds: List<int>.from(json['message_ids'] ?? []),
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }
}

/// Reaction-update event: another party added, changed, or removed a
/// WhatsApp-style reaction on a message. reaction == null means removed.
class ReactionUpdateEvent {
  final int conversationId;
  final int messageId;
  final String? reaction;

  ReactionUpdateEvent({
    required this.conversationId,
    required this.messageId,
    this.reaction,
  });

  factory ReactionUpdateEvent.fromJson(Map<String, dynamic> json) {
    final r = json['reaction'];
    return ReactionUpdateEvent(
      conversationId: json['conversation_id'] ?? 0,
      messageId: json['message_id'] ?? 0,
      reaction: (r == null || r == '') ? null : r.toString(),
    );
  }
}

class NewDeviceLoginEvent {
  final String deviceName;
  final String ipAddress;
  final String platform;
  final DateTime timestamp;

  NewDeviceLoginEvent({
    required this.deviceName,
    required this.ipAddress,
    required this.platform,
    required this.timestamp,
  });

  factory NewDeviceLoginEvent.fromJson(Map<String, dynamic> json) {
    return NewDeviceLoginEvent(
      deviceName: json['device_name'] ?? 'Unbekanntes Gerät',
      ipAddress: json['ip_address'] ?? 'Unbekannt',
      platform: json['platform'] ?? 'Unbekannt',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }
}

/// Ticket notification event (new comment, status change, etc.)
class TicketNotificationEvent {
  final int ticketId;
  final String title;
  final String message;
  final String type; // 'new_comment', 'status_change', 'new_ticket'
  final DateTime timestamp;

  TicketNotificationEvent({
    required this.ticketId,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
  });

  factory TicketNotificationEvent.fromJson(Map<String, dynamic> json) {
    return TicketNotificationEvent(
      ticketId: json['ticket_id'] ?? 0,
      title: json['title'] ?? 'Ticket Update',
      message: json['message'] ?? '',
      type: json['type'] ?? 'new_comment',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }
}
