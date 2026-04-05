import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/secure_storage_helper.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/logger_service.dart';
import '../services/chat_service.dart';
import '../services/heartbeat_service.dart';
import '../services/background_service.dart';
import '../services/voice_call_service.dart';
import '../widgets/legal_footer.dart';
import '../widgets/live_chat_dialog.dart';
import '../widgets/update_dialog.dart';
import '../widgets/ticket_dialogs.dart';
import '../services/ticket_service.dart';
import '../services/ticket_notification_service.dart';
import '../services/ntfy_service.dart';
import '../services/diagnostic_service.dart';
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
import '../services/termin_service.dart';
import 'welcome.dart';

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

  // Unread chat messages counter
  int _unreadChatCount = 0;
  // Unread ticket notifications counter
  int _unreadTicketCount = 0;
  StreamSubscription<ChatMessage>? _messageSubscription;
  StreamSubscription<CallOfferEvent>? _callOfferSubscription;
  StreamSubscription<int>? _ticketNotificationSubscription;

  // Background conversation ID for receiving messages
  int? _backgroundConversationId;

  // Payment reminder
  int? _zahlungstag;
  String? _zahlungsmethodeLabel;
  bool _paymentReminderShownToday = false;
  Timer? _paymentReminderTimer;

  // Pending termine count for badge
  int _pendingTerminCount = 0;
  Timer? _terminPollTimer;
  String? _lastTomorrowReminderDate; // "yyyy-MM-dd" of last tomorrow reminder
  String? _lastTodayReminderDate;    // "yyyy-MM-dd" of last 07:00 reminder

  // Tickets page state
  final _ticketService = TicketService();
  final _ticketNotificationService = TicketNotificationService();
  List<Ticket> _tickets = [];
  bool _isLoadingTickets = true;
  bool _ticketsLoadStarted = false;
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

    // Start log upload to server (every 30s) with app version
    _log.startUpload(widget.mitgliedernummer, '1.1.20');

    // Poll pending termine count (every 60s - battery optimized)
    _loadPendingTerminCount();
    _terminPollTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      _loadPendingTerminCount();
    });

    // Hourly payment reminder check
    _paymentReminderTimer = Timer.periodic(const Duration(hours: 1), (_) {
      _checkPaymentReminder();
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

  @override
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App goes to background: pause UI-only timers (saves battery)
      // WebSocket + ntfy + background service continue running (notifications still work!)
      _terminPollTimer?.cancel();
      _ticketRefreshTimer?.cancel();
      _paymentReminderTimer?.cancel();
      debugPrint('[Dashboard] App paused - UI timers stopped (notifications still active)');
    } else if (state == AppLifecycleState.resumed) {
      // App comes to foreground: restart UI timers + refresh data
      _loadPendingTerminCount();
      _terminPollTimer = Timer.periodic(const Duration(seconds: 60), (_) {
        _loadPendingTerminCount();
      });
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
    _ticketNotificationSubscription?.cancel();
    _callDurationTimer?.cancel();
    _ticketRefreshTimer?.cancel();
    _paymentReminderTimer?.cancel();
    _terminPollTimer?.cancel();
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
          builder: (ctx) => _buildActiveCallScreen(event.callerName, event.conversationId),
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

        return NativeCallScreen(
          remoteName: remoteName,
          isIncoming: false,
          isActive: true,
          callDuration: _callDuration,
          isMuted: _voiceCallService.isMuted,
          isSpeakerOn: _voiceCallService.isSpeakerOn,
          onToggleMute: () {
            _voiceCallService.toggleMute();
            setState(() {});
          },
          onToggleSpeaker: () {
            _voiceCallService.toggleSpeaker();
            setState(() {});
          },
          onEndCall: () async {
            final navigator = Navigator.of(context);
            await _voiceCallService.endCall();
            _chatService.sendCallEnd(conversationId);
            if (mounted && navigator.canPop()) {
              navigator.pop();
            }
          },
          connectionQuality: 'good', // Based on ICE connection state
        );
      },
    );
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
        setState(() => _daysRemaining = result['days_remaining'] ?? 0);
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

  Future<void> _logout() async {
    _log.info('Dashboard: Logout initiated for ${widget.mitgliedernummer}', tag: 'DASH');
    await _apiService.logout();

    // Stop background service
    await BackgroundService.stopService();

    final prefs = await SharedPreferences.getInstance();

    // ALWAYS disable auto-login on logout
    await prefs.setBool('auto_login', false);
    await prefs.setBool('remember_me', false);

    // Clear saved credentials
    try {
      final secureStorage = createSecureStorage();
      await secureStorage.delete(key: 'mitgliedernummer');
      await secureStorage.delete(key: 'password');
    } catch (e) {
      debugPrint('[Dashboard] SecureStorage delete failed: $e');
    }
    _log.info('Dashboard: Credentials and flags cleared, redirecting to welcome', tag: 'DASH');

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false,
      );
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

  void _showNotificationsDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.notifications, color: Color(0xFF4a90d9)),
            const SizedBox(width: 12),
            Text(l10n.notifications),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.info, color: Colors.blue.shade700),
                ),
                title: Text(l10n.welcomeToICD),
                subtitle: Text(l10n.accountCreatedSuccessfully),
                trailing: Text(
                  l10n.today,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade100,
                  child: Icon(Icons.euro, color: Colors.orange.shade700),
                ),
                title: Text(l10n.membershipFeeDue),
                subtitle: Text(l10n.pleaseTransferAnnualFee),
                trailing: Text(
                  l10n.newBadge,
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.close),
          ),
        ],
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
      backgroundColor: const Color(0xFFF5F5F5),
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
        onProfile: _showProfileDialog,
        onLogout: _logout,
      ),
      body: SeasonalBackground(
        child: Column(
          children: [
            if (widget.status == 'neu')
              TrialWarningBanner(daysRemaining: _daysRemaining),
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
        return Colors.orange;
      case 'in_progress':
        return Colors.purple;
      case 'waiting_member':
        return Colors.blue;
      case 'waiting_staff':
        return Colors.teal;
      case 'waiting_authority':
        return Colors.indigo;
      case 'done':
        return Colors.green;
      default:
        return Colors.grey;
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
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
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
              Icon(Icons.local_activity_outlined, size: 32, color: Colors.blue.shade700),
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
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 12),

          // Status filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('all', 'Alle', Icons.list, Colors.blueGrey),
                const SizedBox(width: 8),
                _buildFilterChip('open', 'Offen', Icons.fiber_new, Colors.orange),
                const SizedBox(width: 8),
                _buildFilterChip('in_progress', 'In Bearbeitung', Icons.autorenew, Colors.purple),
                const SizedBox(width: 8),
                _buildFilterChip('waiting_member', 'Warten auf mich', Icons.person, Colors.blue),
                const SizedBox(width: 8),
                _buildFilterChip('done', 'Erledigt', Icons.check_circle, Colors.green),
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
          Icon(Icons.check_circle_outline, size: 64, color: Colors.green.shade400),
          const SizedBox(height: 16),
          Text(
            l10n.everythingOk,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.haveProblemWeHelp,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
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
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        _formatTicketDate(ticket.createdAt),
                        style: TextStyle(
                          color: Colors.grey.shade500,
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
                        Icon(Icons.person, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          ticket.adminName!,
                          style: TextStyle(
                            color: Colors.grey.shade500,
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
        ],
      ),
    );
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
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
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
