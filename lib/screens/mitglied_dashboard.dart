import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/logger_service.dart';
import '../services/chat_service.dart';
import '../services/heartbeat_service.dart';
import '../services/voice_call_service.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' show RTCIceConnectionState;
import '../widgets/video_call_screen.dart';
import '../widgets/legal_footer.dart';
import '../widgets/live_chat_dialog.dart';
import '../widgets/benachrichtigung_consent_dialog.dart';
import '../widgets/benachrichtigungen_dialog.dart';
import '../widgets/update_dialog.dart';
import '../widgets/ticket_dialogs.dart';
import '../services/ticket_service.dart';
import '../services/ticket_notification_service.dart';
import '../services/ntfy_service.dart';
import '../services/diagnostic_service.dart';
import '../services/device_key_service.dart';
import '../services/battery_usage_service.dart';
import '../services/security_event_reporter.dart';
import '../widgets/mitglied_profile_dialog.dart';
import '../widgets/personal_data_dialog.dart';
// Sidebar removed for mobile - using BottomNavigationBar instead
import '../widgets/mitglied_appbar.dart';
import '../widgets/mitglied_banners.dart';
import '../widgets/mitglied_cards.dart';
import '../widgets/member_calendar_view.dart';
import '../widgets/eastern.dart';
import '../widgets/native_call_screen.dart';
import '../services/notification_service.dart';
import '../services/remote_agent_service.dart';
import '../widgets/remote_consent_dialog.dart';
import '../widgets/remote_sharing_banner.dart';
import '../services/termin_service.dart';
import '../widgets/signatur_card.dart';
import 'signatur_screen.dart';
import '../utils/app_theme.dart';

final _log = LoggerService();

class MitgliedDashboard extends StatefulWidget {
  final String userName;
  final String mitgliedernummer;
  final String email;
  final String status;

  const MitgliedDashboard({
    super.key,
    required this.userName,
    required this.mitgliedernummer,
    required this.email,
    required this.status,
  });

  @override
  State<MitgliedDashboard> createState() => _MitgliedDashboardState();
}

class _MitgliedDashboardState extends State<MitgliedDashboard>
    with WidgetsBindingObserver {
  final _apiService = ApiService();

  /// Anzahl der Dokumente, die auf die Unterschrift dieses Mitglieds warten.
  int _offeneSignaturen = 0;
  final _chatService = ChatService();
  final _voiceCallService = VoiceCallService();
  late final _heartbeatService = HeartbeatService(_apiService);
  late String _currentEmail;
  int _selectedIndex = 0;

  // Call duration tracking
  Duration _callDuration = Duration.zero;
  Timer? _callDurationTimer;

  // Beitrag status from API
  bool _beitragBezahlt = false;
  int _beitragJahr = DateTime.now().year;
  bool _isLoadingBeitrag = true;

  // Account trial status (for 'neu' accounts)
  int _daysRemaining = 30;
  // Exact end of the trial (users.trial_ends_at); null on older servers.
  DateTime? _trialEndsAt;

  // Unread chat messages counter
  int _unreadChatCount = 0;
  // Unread ticket notifications counter
  int _unreadTicketCount = 0;
  StreamSubscription<ChatMessage>? _messageSubscription;
  StreamSubscription<CallOfferEvent>? _callOfferSubscription;
  StreamSubscription<int>? _ticketNotificationSubscription;
  // Fernwartung (remote support) — receives remote_offer, shows consent prompt.
  StreamSubscription<RemoteOfferEvent>? _remoteOfferSubscription;
  final RemoteAgentService _remoteAgent = RemoteAgentService();

  // Background conversation ID for receiving messages
  int? _backgroundConversationId;

  // Payment reminder
  int? _zahlungstag;
  String? _zahlungsmethodeLabel;
  bool _paymentReminderShownToday = false;
  Timer? _paymentReminderTimer;
  Timer? _updateCheckTimer;

  // Pending termine count for badge
  int _pendingTerminCount = 0;
  Timer? _terminPollTimer;
  Timer? _deviceDataTimer;
  String? _lastTomorrowReminderDate; // "yyyy-MM-dd" of last tomorrow reminder
  String? _lastTodayReminderDate;    // "yyyy-MM-dd" of last 07:00 reminder

  // Tickets page state
  final _ticketService = TicketService();
  final _ticketNotificationService = TicketNotificationService();
  List<Ticket> _tickets = [];
  bool _isLoadingTickets = true;
  bool _ticketsLoadStarted = false;

  /// Ungelesene Benachrichtigungen — steuert den Punkt auf der Glocke.
  int _ungeleseneBenachrichtigungen = 0;
  String _ticketFilter = 'all'; // all, open, in_progress, done
  Timer? _ticketRefreshTimer;

  bool _notifTextsUpdated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_notifTextsUpdated) {
      _notifTextsUpdated = true;
      final l = AppLocalizations.of(context);
      if (l != null) {
        NotificationService().updateTexts(
          newMessageFrom: l.notifNewMessageFrom,
          urgentPrefix: l.notifUrgentPrefix,
          urgentMessage: l.notifUrgentMessage,
          incomingCall: l.notifIncomingCall,
          callingYou: l.notifCallingYou,
          updateAvailable: l.notifUpdateAvailable,
          versionAvailable: l.notifVersionAvailable,
          connected: l.notifConnected,
          disconnected: l.notifDisconnected,
          connectedBody: l.notifConnectedBody,
          disconnectedBody: l.notifDisconnectedBody,
          error: l.notifError,
          newLoginDetected: l.newLoginDetected,
        );
        // Save translations for background service (no BuildContext there)
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('l10n_notifNewMessageFrom', l.notifNewMessageFrom);
          prefs.setString('l10n_notifUrgentPrefix', l.notifUrgentPrefix);
          prefs.setString('l10n_notifIncomingCall', l.notifIncomingCall);
          prefs.setString('l10n_notifCallingYou', l.notifCallingYou);
          prefs.setString('l10n_notifConnected', l.notifConnected);
          prefs.setString('l10n_notifReconnecting', l.errorConnecting);
          prefs.setString('l10n_notifWaitingLogin', l.welcomeLoading);
          prefs.setString('l10n_unknown', l.unknown);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _log.info('Dashboard: Loaded for ${widget.mitgliedernummer} (${widget.userName})', tag: 'DASH');
    _currentEmail = widget.email;
    _loadBeitragStatus();
    _loadAccountStatus();
    _loadOffeneSignaturen();
    _checkForUpdates();
    _connectWebSocket();
    _setupMessageListener();

    // Set diagnostic user so battery_level/state is saved per member
    DiagnosticService().setUser(widget.mitgliedernummer, 'mitglied');

    // Start heartbeat to update last_seen in real-time
    _heartbeatService.start(widget.mitgliedernummer);

    // Start ticket notification polling (10s foreground + 15min background)
    _ticketNotificationService.start(widget.mitgliedernummer);

    // Start ntfy push notifications (server-sent via NDJSON stream)
    NtfyService().start(widget.mitgliedernummer);

    // Einmal fragen, ob SMS-Erinnerungen erwünscht sind. Ob überhaupt gefragt
    // wird, entscheidet der Server (nur bei hinterlegter Mobilnummer, nur wenn
    // noch offen, frühestens 14 Tage nach dem letzten Mal, höchstens dreimal)
    // — der Client soll das nicht selbst festlegen können.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      BenachrichtigungConsentDialog.zeigenFallsNoetig(context, _apiService);
      _ladeUngelesene();
    });

    // Start log upload to server (every 30s) with app version
    // Get version dynamically from pubspec.yaml
    PackageInfo.fromPlatform().then((info) {
      _log.startUpload(widget.mitgliedernummer, info.version);
      // Tell the security reporter who the current member is so future
      // TLS-failure reports include the mitgliedernummer.
      SecurityEventReporter.instance.start(
        deviceId: _log.deviceId,
        mitgliedernummer: widget.mitgliedernummer,
        appVersion: info.version,
      );
    });

    // Die Akkumessung läuft seit main() und wird hier bewusst NICHT auf das
    // Mitglied umgeschlüsselt: sie meldet nur unter der anonymen Gerätekennung
    // — siehe BatteryUsageService.start.

    // Update battery/device data on server every 5 minutes
    DeviceKeyService().updateExtendedData();
    _startDeviceDataTimer();

    // Poll pending termine count (every 60s - battery optimized)
    _loadPendingTerminCount();
    _terminPollTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      _loadPendingTerminCount();
    });

    // Hourly payment reminder check
    _paymentReminderTimer = Timer.periodic(const Duration(hours: 1), (_) {
      _checkPaymentReminder();
    });

    // Re-check for updates every 6h. The startup check above is enough for
    // phones, which get killed and relaunched constantly, but a desktop
    // install commonly stays open for days and would otherwise never notice a
    // release. With automatic updates enabled this is what actually applies
    // them unattended.
    _updateCheckTimer = Timer.periodic(const Duration(hours: 6), (_) {
      _checkForUpdates();
    });

    // Setup voice call signaling callback
    _voiceCallService.onSignalingMessage = (message) {
      final type = message['type'] as String;
      final conversationId = message['conversation_id'] as int;

      _log.info('VoiceCall: Sending signaling message: $type for conversation $conversationId', tag: 'CALL');

      switch (type) {
        case 'call_offer':
          _chatService.sendCallOffer(
            conversationId,
            message['sdp'] as String,
            message['sdp_type'] as String,
          );
          break;
        case 'call_answer':
          _chatService.sendCallAnswer(
            conversationId,
            message['sdp'] as String,
            message['sdp_type'] as String,
          );
          break;
        case 'call_reject':
          // Emitted by VoiceCallService when auto-rejecting a second, concurrent
          // incoming call as busy. This handler is the sole owner of signaling,
          // so it must cover call_reject too (#3).
          _chatService.sendCallReject(
            conversationId,
            message['reason'] as String,
          );
          break;
        case 'call_end':
          _chatService.sendCallEnd(conversationId);
          break;
        case 'ice_candidate':
          _chatService.sendIceCandidate(
            conversationId,
            message['candidate'] as String,
            message['sdp_mid'] as String,
            message['sdp_mline_index'] as int,
          );
          break;
      }
    };
  }

  /// Startet die 5-Minuten-Uhr für Geräte- und Akkudaten, sofern sie nicht
  /// schon läuft.
  ///
  /// Eine einzige Stelle, weil genau die Verdopplung der Grund für den Fehler
  /// war, den das hier ablöst: der Timer wurde in `initState` aufgesetzt und
  /// in `paused` abgeräumt, aber im `resumed`-Zweig stand nur die Kopie für
  /// `_terminPollTimer`. Nach dem ersten Wechsel in den Hintergrund erreichten
  /// Geräte- und Akkudaten den Server dauerhaft nicht mehr — bis zum nächsten
  /// App-Start. Wer den Timer künftig woanders braucht, ruft diese Methode auf
  /// und kann das Intervall nicht mehr auseinanderlaufen lassen.
  void _startDeviceDataTimer() {
    if (_deviceDataTimer != null) return;
    _deviceDataTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      DeviceKeyService().updateExtendedData();
      // Huckepack: der Messdienst hält bewusst keinen eigenen Netz-Timer.
      // Fertige Messfenster gehen mit, wenn ohnehin gesendet wird, statt das
      // Funkmodem ein weiteres Mal zu wecken.
      BatteryUsageService.instance.flush();
    });
  }

  /// Gegenstück zu [_startDeviceDataTimer]. Setzt bewusst auf null: ein bloss
  /// abgebrochener Timer bleibt non-null, und [_startDeviceDataTimer] hielte
  /// ihn dann für eine noch laufende Uhr.
  void _stopDeviceDataTimer() {
    _deviceDataTimer?.cancel();
    _deviceDataTimer = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App goes to background: pause UI-only timers (saves battery)
      // WebSocket + ntfy + background service continue running (notifications still work!)
      _terminPollTimer?.cancel();
      _stopDeviceDataTimer();
      _ticketRefreshTimer?.cancel();
      _paymentReminderTimer?.cancel();
      debugPrint('[Dashboard] App paused - UI timers stopped (notifications still active)');
    } else if (state == AppLifecycleState.resumed) {
      // App comes to foreground: restart UI timers + refresh data
      _loadPendingTerminCount();
      _terminPollTimer = Timer.periodic(const Duration(seconds: 60), (_) {
        _loadPendingTerminCount();
      });
      _startDeviceDataTimer();
      if (_selectedIndex == 3) {
        _loadTickets();
      }
      debugPrint('[Dashboard] App resumed - UI timers restarted');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageSubscription?.cancel();
    _callOfferSubscription?.cancel();
    _remoteOfferSubscription?.cancel();
    _ticketNotificationSubscription?.cancel();
    _callDurationTimer?.cancel();
    _ticketRefreshTimer?.cancel();
    _paymentReminderTimer?.cancel();
    _terminPollTimer?.cancel();
    _stopDeviceDataTimer();
    _updateCheckTimer?.cancel();
    _heartbeatService.stop();
    _ticketNotificationService.stop();
    NtfyService().stop();
    _log.stopUpload();
    super.dispose();
  }

  void _setupMessageListener() {
    _messageSubscription = _chatService.messageStream.listen((message) {
      if (mounted) {
        setState(() => _unreadChatCount++);
        _log.info('New message received, unread count: $_unreadChatCount', tag: 'DASH');
      }
    });

    _callOfferSubscription = _chatService.callOfferStream.listen((event) {
      if (mounted) {
        _handleIncomingCall(event);
      }
    });

    // Fernwartung: a Vorsitzer requests remote access → show the consent prompt.
    _remoteOfferSubscription = _chatService.remoteOfferStream.listen((event) {
      if (mounted) _handleRemoteOffer(event);
    });

    // Listen for ticket notifications - also reload ticket list
    _ticketNotificationSubscription = _ticketNotificationService.notificationStream.listen((count) {
      if (mounted) {
        setState(() => _unreadTicketCount += count);
        _log.info('New ticket notifications: $count, total unread: $_unreadTicketCount', tag: 'DASH');
        // Auto-reload ticket list when new notifications arrive
        _loadTickets();
      }
    });
  }

  /// Fernwartung request: show the consent prompt. Nothing is shared unless the
  /// member taps "Erlauben". A session already running auto-declines new requests.
  void _handleRemoteOffer(RemoteOfferEvent event) {
    _log.info('MitgliedDash: Fernwartung request from ${event.controllerName} (conv: ${event.conversationId})', tag: 'REMOTE');
    if (_remoteAgent.isSharing) {
      _chatService.sendRemoteReject(event.conversationId, 'busy');
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => RemoteConsentDialog(
        controllerName: event.controllerName,
        onAccept: () {
          Navigator.of(ctx).pop();
          _remoteAgent.accept(event);
        },
        onDecline: () {
          Navigator.of(ctx).pop();
          _remoteAgent.decline(event);
        },
      ),
    );
  }

  void _handleIncomingCall(CallOfferEvent event) {
    _log.info('MitgliedDash: Incoming call from ${event.callerName} (conv: ${event.conversationId})', tag: 'CALL');

    // Inform VoiceCallService about incoming call (sets state to RINGING)
    _voiceCallService.handleIncomingCall(
      event.conversationId,
      event.callerId,
      event.callerName,
      event.sdp,
      event.sdpType,
    );
    _log.info('MitgliedDash: VoiceCallService.handleIncomingCall() called - state should be RINGING now', tag: 'CALL');

    // Navigate to full-screen native call screen
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => NativeCallScreen(
          remoteName: event.callerName,
          isIncoming: true,
          isVideo: _voiceCallService.offerSendsVideo(event.sdp),
          isActive: false,
          isMuted: false,
          isSpeakerOn: true,
          onAccept: () {
            _log.info('🟢🟢🟢 ACCEPT BUTTON PRESSED!', tag: 'CALL');
            _log.info('🟢 Event: ${event.callerName} from conv ${event.conversationId}', tag: 'CALL');
            _log.info('🟢 SDP Type: ${event.sdpType}', tag: 'CALL');
            _log.info('🟢 SDP Length: ${event.sdp.length} chars', tag: 'CALL');
            _log.info('🟢 Calling _acceptCall()...', tag: 'CALL');
            _acceptCall(event);
            _log.info('🟢 _acceptCall() returned', tag: 'CALL');
          },
          onReject: () {
            _log.info('MitgliedDash: Call rejected', tag: 'CALL');
            Navigator.of(ctx).pop();
            _chatService.sendCallReject(event.conversationId, 'rejected');
          },
          onToggleMute: () {
            // Will be implemented in active call
          },
          onToggleSpeaker: () {
            // Will be implemented in active call
          },
          onEndCall: () {
            Navigator.of(ctx).pop();
          },
        ),
      ),
    );
  }

  void _acceptCall(CallOfferEvent event) async {
    _log.info('🎯🎯🎯 _acceptCall() STARTED for ${event.callerName}', tag: 'CALL');
    _log.info('🎯 Conversation ID: ${event.conversationId}', tag: 'CALL');

    try {
      // Accept the call through voice call service (auto-sends answer via signaling)
      _log.info('🎯 Calling VoiceCallService.acceptCall()...', tag: 'CALL');
      final accepted = await _voiceCallService.acceptCall(event.sdp, event.sdpType);
      _log.info('🎯 VoiceCallService.acceptCall() returned: $accepted', tag: 'CALL');

      if (!accepted) {
        _log.error('❌ Call was NOT accepted by VoiceCallService!', tag: 'CALL');
        return;
      }

      if (!mounted) {
        _log.warning('⚠️ Widget not mounted after acceptCall', tag: 'CALL');
        return;
      }

      _log.info('🎯 Call accepted! Starting duration timer...', tag: 'CALL');
      // Start call duration timer
      _callDuration = Duration.zero;
      _callDurationTimer?.cancel();
      _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _callDuration = Duration(seconds: _callDuration.inSeconds + 1);
          });
        }
      });

      // Navigate to active call screen (replace incoming screen)
      _log.info('🎯 Navigating to active call screen...', tag: 'CALL');
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (ctx) => _voiceCallService.isVideoCall
              ? VideoCallScreen(remoteName: event.callerName)
              : _buildActiveCallScreen(event.callerName, event.conversationId),
        ),
      );
      _log.info('🎯 Navigation to active call screen complete', tag: 'CALL');
    } catch (e, stackTrace) {
      _log.error('❌❌❌ _acceptCall() ERROR: $e', tag: 'CALL');
      _log.error('❌ Stack trace: $stackTrace', tag: 'CALL');
      _log.error('❌ Event: ${event.callerName}, Conv: ${event.conversationId}', tag: 'CALL');
    }
  }

  Widget _buildActiveCallScreen(String remoteName, int conversationId) {
    // StatefulBuilder gives this pushed route a LOCAL rebuild. Mute/speaker
    // toggles flip a bool in VoiceCallService but emit nothing on callStateStream,
    // so a parent setState wouldn't refresh this route and the icons would freeze
    // (#1). setLocalState re-reads isMuted/isSpeakerOn each toggle.
    return StatefulBuilder(
      builder: (context, setLocalState) {
        return StreamBuilder<CallState>(
          stream: _voiceCallService.callStateStream,
          initialData: _voiceCallService.callState,
          builder: (context, stateSnapshot) {
            final callState = stateSnapshot.data ?? CallState.idle;

            // If call ended, pop the screen
            if (callState == CallState.idle) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              });
            }

            return StreamBuilder<RTCIceConnectionState?>(
              stream: _voiceCallService.iceConnectionStateStream,
              builder: (context, iceSnapshot) {
                return NativeCallScreen(
                  remoteName: remoteName,
                  isIncoming: false,
                  isVideo: _voiceCallService.isVideoCall,
                  isActive: true,
                  callDuration: _callDuration,
                  isMuted: _voiceCallService.isMuted,
                  isSpeakerOn: _voiceCallService.isSpeakerOn,
                  onToggleMute: () {
                    _voiceCallService.toggleMute();
                    setLocalState(() {});
                  },
                  onToggleSpeaker: () {
                    _voiceCallService.toggleSpeaker();
                    setLocalState(() {});
                  },
                  onEndCall: () async {
                    final navigator = Navigator.of(context);
                    // endCall() already emits the call_end frame via
                    // onSignalingMessage — don't send it a second time (#4).
                    await _voiceCallService.endCall();
                    if (mounted && navigator.canPop()) {
                      navigator.pop();
                    }
                  },
                  connectionQuality: _mapIceQuality(iceSnapshot.data),
                );
              },
            );
          },
        );
      },
    );
  }

  /// Map the real ICE connection state to the NativeCallScreen quality buckets,
  /// replacing the old hardcoded 'good' (#6a). Fed by iceConnectionStateStream.
  String _mapIceQuality(RTCIceConnectionState? s) {
    switch (s) {
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
      case RTCIceConnectionState.RTCIceConnectionStateCompleted:
        return 'good';
      case RTCIceConnectionState.RTCIceConnectionStateChecking:
      case RTCIceConnectionState.RTCIceConnectionStateNew:
        return 'poor';
      case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
      case RTCIceConnectionState.RTCIceConnectionStateFailed:
      case RTCIceConnectionState.RTCIceConnectionStateClosed:
        return 'disconnected';
      default:
        return 'good';
    }
  }

  Future<void> _connectWebSocket() async {
    final connected = await _chatService.connect(widget.mitgliedernummer);
    _log.info('WebSocket connected at login: $connected', tag: 'DASH');

    if (connected) {
      await _joinBackgroundConversation();
    }
  }

  Future<void> _joinBackgroundConversation() async {
    try {
      final result = await _apiService.startChat(widget.mitgliedernummer);
      if (result['success'] == true) {
        final convId = result['conversation_id'];
        _backgroundConversationId = convId is int ? convId : int.tryParse(convId.toString());
        if (_backgroundConversationId != null) {
          _chatService.joinConversation(_backgroundConversationId!);
          _log.info('Background joined conversation $_backgroundConversationId', tag: 'DASH');
        }
      }
    } catch (e) {
      _log.error('Failed to join background conversation: $e', tag: 'DASH');
    }
  }

  Future<void> _checkForUpdates() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await checkAndShowUpdateDialog(context);
    }
    _log.pushToServer(widget.mitgliedernummer);
  }

  Future<void> _loadBeitragStatus() async {
    try {
      final result = await _apiService.getProfile(widget.mitgliedernummer);
      if (result['success'] == true && mounted) {
        final zt = result['zahlungstag'];
        final zm = result['zahlungsmethode'];
        setState(() {
          _beitragBezahlt = result['beitrag_bezahlt'] ?? false;
          _beitragJahr = result['beitrag_jahr'] ?? DateTime.now().year;
          _isLoadingBeitrag = false;
          _zahlungstag = zt != null ? int.tryParse(zt.toString()) : null;
          if (zm != null) {
            final l = AppLocalizations.of(context)!;
            switch (zm.toString()) {
              case 'ueberweisung':
                _zahlungsmethodeLabel = l.payMethod_ueberweisung;
                break;
              case 'sepa':
                _zahlungsmethodeLabel = 'SEPA-Lastschrift';
                break;
              case 'dauerauftrag':
                _zahlungsmethodeLabel = l.payMethod_dauerauftrag;
                break;
              default:
                _zahlungsmethodeLabel = zm.toString();
            }
          }
        });
        _checkPaymentReminder();
      } else {
        if (mounted) setState(() => _isLoadingBeitrag = false);
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingBeitrag = false);
    }
  }

  void _checkPaymentReminder() {
    if (_zahlungstag == null || _paymentReminderShownToday) return;

    final now = DateTime.now();
    if (now.day == _zahlungstag) {
      _paymentReminderShownToday = true;
      final methode = _zahlungsmethodeLabel ?? AppLocalizations.of(context)!.payment;
      final localizations = AppLocalizations.of(context)!;
      NotificationService().show(
        title: localizations.paymentReminder,
        body: localizations.paymentReminderMessage(_zahlungstag ?? 1, methode),
        payload: 'payment_reminder',
        id: 7,
      );
      _log.info('Payment reminder shown: day $_zahlungstag, method $methode', tag: 'DASH');
    }
  }

  Future<void> _loadAccountStatus() async {
    if (widget.status != 'neu') return;

    try {
      final result = await _apiService.getAccountStatus(widget.mitgliedernummer);
      if (result['success'] == true && mounted) {
        setState(() {
          _daysRemaining = result['days_remaining'] ?? 0;
          _trialEndsAt = DateTime.tryParse(result['trial_ends_at']?.toString() ?? '');
        });
      }
    } catch (e) {
      _log.error('Failed to load account status: $e', tag: 'DASH');
    }
  }

  Future<void> _loadPendingTerminCount() async {
    try {
      final result = await TerminService().getMyTermine();
      if (mounted) {
        final pendingCount = result['pending_count'];
        final newCount = pendingCount is int
            ? pendingCount
            : int.tryParse(pendingCount?.toString() ?? '0') ?? 0;

        // Show notification if count increased
        if (newCount > _pendingTerminCount && _pendingTerminCount >= 0) {
          final diff = newCount - _pendingTerminCount;
          if (_pendingTerminCount > 0) {
            // Only notify after first load (not on app start)
            final localizations = AppLocalizations.of(context)!;
            NotificationService().show(
              title: localizations.newAppointmentsTitle,
              body: diff == 1
                  ? localizations.youHaveNewAppointment
                  : localizations.youHaveNewAppointments(diff),
              payload: 'termine',
              id: 8,
            );
          }
        }

        setState(() => _pendingTerminCount = newCount);

        // Check date-based reminders from termine list
        final termineList = result['termine'] as List? ?? [];
        _checkTerminReminders(termineList);
      }
    } catch (e) {
      _log.error('Failed to load pending termin count: $e', tag: 'DASH');
    }
  }

  void _checkTerminReminders(List<dynamic> termineList) {
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final tomorrow = now.add(const Duration(days: 1));
    final tomorrowStr = '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';

    final tomorrowTermine = <Map<String, dynamic>>[];
    final todayTermine = <Map<String, dynamic>>[];

    for (final t in termineList) {
      if (t is! Map<String, dynamic>) continue;
      final dateStr = t['termin_date']?.toString() ?? '';
      if (dateStr.isEmpty) continue;
      try {
        final terminDate = DateTime.parse(dateStr);
        final terminDayStr = '${terminDate.year}-${terminDate.month.toString().padLeft(2, '0')}-${terminDate.day.toString().padLeft(2, '0')}';
        if (terminDayStr == tomorrowStr) {
          tomorrowTermine.add(t);
        }
        if (terminDayStr == todayStr) {
          todayTermine.add(t);
        }
      } catch (_) {}
    }

    // Reminder: one day before (show once per day)
    if (tomorrowTermine.isNotEmpty && _lastTomorrowReminderDate != todayStr) {
      _lastTomorrowReminderDate = todayStr;
      final count = tomorrowTermine.length;
      final firstTitle = tomorrowTermine.first['title'] ?? 'Termin';
      final localizations = AppLocalizations.of(context)!;
      NotificationService().show(
        title: localizations.appointmentReminderTomorrow,
        body: count == 1
            ? localizations.tomorrowAppointment(firstTitle)
            : localizations.youHaveTomorrowAppointments(count),
        payload: 'termine_reminder_tomorrow',
        id: 9,
      );
      _log.info('Termin reminder: $count termine tomorrow', tag: 'DASH');
    }

    // Reminder: today at 07:00 (show once per day, between 07:00-07:59)
    if (todayTermine.isNotEmpty &&
        now.hour == 7 &&
        _lastTodayReminderDate != todayStr) {
      _lastTodayReminderDate = todayStr;
      final count = todayTermine.length;
      final firstTitle = todayTermine.first['title'] ?? 'Termin';
      final localizations = AppLocalizations.of(context)!;
      NotificationService().show(
        title: localizations.appointmentsToday,
        body: count == 1
            ? localizations.todayAppointment(firstTitle)
            : localizations.youHaveTodayAppointments(count),
        payload: 'termine_reminder_today',
        id: 10,
      );
      _log.info('Termin reminder: $count termine today', tag: 'DASH');
    }
  }

  String _getGreeting(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 11) {
      return l10n.goodMorning;
    } else if (hour >= 11 && hour < 18) {
      return l10n.goodDay;
    } else if (hour >= 18 && hour < 22) {
      return l10n.goodEvening;
    } else {
      return l10n.goodNight;
    }
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => MitgliedProfileDialog(
        userName: widget.userName,
        mitgliedernummer: widget.mitgliedernummer,
        email: _currentEmail,
        status: widget.status,
        apiService: _apiService,
        onEmailChanged: (newEmail) {
          setState(() => _currentEmail = newEmail);
        },
      ),
    );
  }

  Future<void> _ladeUngelesene() async {
    final res = await _apiService.getBenachrichtigungen();
    if (!mounted || res['success'] != true) return;
    setState(() => _ungeleseneBenachrichtigungen =
        res['ungelesen'] is int ? res['ungelesen'] : 0);
  }

  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) => BenachrichtigungenDialog(
        apiService: _apiService,
        onUngelesen: (n) {
          if (mounted) setState(() => _ungeleseneBenachrichtigungen = n);
        },
      ),
    );
  }

  void _showLiveChatDialog() {
    _log.info('Dashboard: Opening Live Chat for ${widget.mitgliedernummer}', tag: 'DASH');
    setState(() => _unreadChatCount = 0);

    showDialog(
      context: context,
      builder: (context) => LiveChatDialog(
        mitgliedernummer: widget.mitgliedernummer,
        userName: widget.userName,
      ),
    ).then((_) {
      if (_backgroundConversationId != null) {
        _chatService.joinConversation(_backgroundConversationId!);
        _log.info('Re-joined conversation $_backgroundConversationId after dialog close', tag: 'DASH');
      }
    });
  }

  void _showPersonalDataDialog() {
    showDialog(
      context: context,
      builder: (context) => PersonalDataDialog(
        userName: widget.userName,
        mitgliedernummer: widget.mitgliedernummer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: MitgliedAppBar(
        mitgliedernummer: widget.mitgliedernummer,
        status: widget.status,
        unreadChatCount: _unreadChatCount,
        unreadTicketCount: _unreadTicketCount,
        pendingTerminCount: _pendingTerminCount,
        onHome: () {
          _ticketRefreshTimer?.cancel();
          setState(() => _selectedIndex = 0);
        },
        onTermine: () {
          _ticketRefreshTimer?.cancel();
          setState(() => _selectedIndex = 2);
        },
        onTickets: () {
          setState(() {
            _selectedIndex = 3;
            _unreadTicketCount = 0; // Reset counter when opening tickets
          });
          _loadTickets(); // Always reload when switching to tickets
          // Start periodic refresh while on tickets tab
          _ticketRefreshTimer?.cancel();
          _ticketRefreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
            if (_selectedIndex == 3 && mounted) {
              _loadTickets();
            }
          });
        },
        onLiveChat: _showLiveChatDialog,
        onNotifications: _showNotificationsDialog,
        ungeleseneBenachrichtigungen: _ungeleseneBenachrichtigungen,
        onProfile: _showProfileDialog,
      ),
      body: SeasonalBackground(
        child: Column(
          children: [
            // Always-on-top: shows only while a Fernwartung session is active,
            // with a one-tap Stop. Renders nothing otherwise.
            const RemoteSharingBanner(),
            if (widget.status == 'neu')
              TrialWarningBanner(
                daysRemaining: _daysRemaining,
                trialEndsAt: _trialEndsAt,
              ),
            Expanded(child: _buildMainContent()),
          ],
        ),
      ),
      bottomNavigationBar: const LegalFooter(),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 1:
        return _buildMitgliederVerwaltung();
      case 2:
        return _buildMeineTermine();
      case 3:
        return _buildTicketsPage();
      case 0:
      default:
        return _buildOverviewContent();
    }
  }

  Widget _buildMeineTermine() {
    return MemberCalendarView(mitgliedernummer: widget.mitgliedernummer);
  }

  Future<void> _loadTickets() async {
    if (!mounted) return;
    setState(() => _isLoadingTickets = true);
    try {
      final response = await _ticketService.getMyTickets(
        mitgliedernummer: widget.mitgliedernummer,
      );
      if (mounted) {
        setState(() {
          _tickets = response?.tickets ?? [];
          _isLoadingTickets = false;
        });
      }
    } catch (e) {
      debugPrint('[Dashboard] Error loading tickets: $e');
      if (mounted) {
        setState(() => _isLoadingTickets = false);
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return context.colors.warningFg;
      case 'in_progress':
        return Colors.purple;
      case 'waiting_member':
        return context.colors.infoFg;
      case 'waiting_staff':
        return Colors.teal;
      case 'waiting_authority':
        return Colors.indigo;
      case 'done':
        return context.colors.successFg;
      default:
        return context.colors.textSecondary;
    }
  }

  String _getTicketStatusLabel(String status) {
    final l = AppLocalizations.of(context)!;
    switch (status) {
      case 'open': return l.ticketStatusOpen;
      case 'in_progress': return l.ticketStatusInProgress;
      case 'waiting_member': return l.ticketStatusWaitingMember;
      case 'waiting_staff': return l.ticketStatusWaitingStaff;
      case 'waiting_authority': return l.ticketStatusWaitingAuthority;
      case 'done': return l.ticketStatusDone;
      default: return status;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return context.colors.dangerFg;
      case 'medium':
        return context.colors.warningFg;
      case 'low':
        return context.colors.successFg;
      default:
        return context.colors.textSecondary;
    }
  }

  String _formatTicketDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Future<void> _showTicketDetails(Ticket ticket) async {
    await showTicketDetailsDialog(
      context,
      ticket,
      widget.mitgliedernummer,
    );

    // Always reload tickets after viewing details (status may have changed)
    _loadTickets();
  }

  List<Ticket> get _filteredTickets {
    if (_ticketFilter == 'all') return _tickets;
    if (_ticketFilter == 'active') {
      return _tickets.where((t) => t.status != 'done').toList();
    }
    return _tickets.where((t) => t.status == _ticketFilter).toList();
  }

  int _countByStatus(String status) {
    if (status == 'all') return _tickets.length;
    if (status == 'active') return _tickets.where((t) => t.status != 'done').toList().length;
    return _tickets.where((t) => t.status == status).length;
  }

  Widget _buildTicketsPage() {
    final l10n = AppLocalizations.of(context)!;
    // Load tickets when page is shown for the first time
    if (_isLoadingTickets && _tickets.isEmpty && !_ticketsLoadStarted) {
      _ticketsLoadStarted = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadTickets());
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_activity_outlined, size: 32, color: context.colors.infoFg),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.reportProblems,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.weRespondIn24Hours,
            style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 12),

          // Status filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('all', 'Alle', Icons.list, Colors.blueGrey),
                const SizedBox(width: 8),
                _buildFilterChip('open', 'Offen', Icons.fiber_new, context.colors.warningFg),
                const SizedBox(width: 8),
                _buildFilterChip('in_progress', 'In Bearbeitung', Icons.autorenew, Colors.purple),
                const SizedBox(width: 8),
                _buildFilterChip('waiting_member', 'Warten auf mich', Icons.person, context.colors.infoFg),
                const SizedBox(width: 8),
                _buildFilterChip('done', 'Erledigt', Icons.check_circle, context.colors.successFg),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: _isLoadingTickets && _tickets.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _filteredTickets.isEmpty
                    ? _buildTicketsEmptyState()
                    : _buildTicketsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label, IconData icon, Color color) {
    final isSelected = _ticketFilter == filter;
    final count = _countByStatus(filter);
    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: isSelected ? Colors.white : color),
          const SizedBox(width: 4),
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withAlpha(50) : color.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : color,
                ),
              ),
            ),
          ],
        ],
      ),
      selectedColor: color,
      backgroundColor: color.withAlpha(15),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : color,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        fontSize: 13,
      ),
      side: BorderSide(color: isSelected ? color : color.withAlpha(60)),
      showCheckmark: false,
      onSelected: (_) {
        setState(() => _ticketFilter = filter);
      },
    );
  }

  Widget _buildTicketsEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 64, color: context.colors.successFg),
          const SizedBox(height: 16),
          Text(
            l10n.everythingOk,
            style: TextStyle(
              color: context.colors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.haveProblemWeHelp,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colors.textTertiary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsList() {
    final tickets = _filteredTickets;
    return RefreshIndicator(
      onRefresh: _loadTickets,
      child: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ticket.subject,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (ticket.subjectIsTranslated)
                    Tooltip(
                      message: ticket.originalSubject ?? '',
                      child: const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(Icons.translate, size: 14, color: Colors.blueGrey),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(ticket.status).withAlpha(30),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _getStatusColor(ticket.status)),
                    ),
                    child: Text(
                      _getTicketStatusLabel(ticket.status),
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(ticket.status),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    ticket.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: context.colors.textTertiary),
                      const SizedBox(width: 4),
                      Text(
                        _formatTicketDate(ticket.createdAt),
                        style: TextStyle(
                          color: context.colors.textTertiary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(ticket.priority).withAlpha(30),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          ticket.priorityDisplay,
                          style: TextStyle(
                            fontSize: 11,
                            color: _getPriorityColor(ticket.priority),
                          ),
                        ),
                      ),
                      if (ticket.adminName != null) ...[
                        const SizedBox(width: 16),
                        Icon(Icons.person, size: 14, color: context.colors.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          ticket.adminName!,
                          style: TextStyle(
                            color: context.colors.textTertiary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              onTap: () => _showTicketDetails(ticket),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeCard(
            userName: widget.userName,
            greeting: _getGreeting(context),
          ),
          const SizedBox(height: 16),
          SignaturCard(
            offen: _offeneSignaturen,
            onOeffnen: _openSignaturen,
          ),
        ],
      ),
    );
  }

  /// Wie viele Dokumente auf die Unterschrift dieses Mitglieds warten.
  ///
  /// Fehler bleiben hier still: die Zahl ist ein Hinweis auf der Übersicht,
  /// und ein Netzproblem beim Start soll dem Mitglied keine Fehlermeldung auf
  /// den Startbildschirm legen. Beim Öffnen des Bildschirms wird ohnehin neu
  /// geladen, und dort ist ein Fehler sichtbar.
  Future<void> _loadOffeneSignaturen() async {
    try {
      final antwort = await _apiService.getSignaturen();
      if (!mounted || antwort['success'] != true) return;

      final liste = (antwort['signaturen'] as List?) ?? const [];
      final offen = liste
          .whereType<Map>()
          .where((e) => (e['status'] ?? '').toString() == 'offen')
          .length;

      setState(() => _offeneSignaturen = offen);
    } catch (e) {
      _log.error('Offene Signaturen: $e', tag: 'DASH');
    }
  }

  Future<void> _openSignaturen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignaturScreen(apiService: _apiService),
      ),
    );
    await _loadOffeneSignaturen();
  }

  Widget _buildMitgliederVerwaltung() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.myMembership,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.managePersonalDataAndFee,
            style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 24),
          PersonalDataCard(onUpdate: _showPersonalDataDialog),
          const SizedBox(height: 16),
          BeitragCard(
            isLoading: _isLoadingBeitrag,
            beitragBezahlt: _beitragBezahlt,
            beitragJahr: _beitragJahr,
          ),
        ],
      ),
    );
  }
}
