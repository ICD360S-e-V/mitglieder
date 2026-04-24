import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import '../l10n/app_localizations.dart';
import 'eastern.dart';
import '../services/api_service.dart';
import '../services/chat_service.dart';
import '../services/network_info_service.dart';
import '../services/voice_call_service.dart';
import '../services/logger_service.dart';
import 'file_viewer.dart';
import 'incoming_call_dialog.dart';
import '../utils/error_helpers.dart';

final _log = LoggerService();

/// Live Chat Dialog for members to chat with support
class LiveChatDialog extends StatefulWidget {
  final String mitgliedernummer;
  final String userName;
  final CallOfferEvent? pendingCall;

  const LiveChatDialog({
    super.key,
    required this.mitgliedernummer,
    required this.userName,
    this.pendingCall,
  });

  @override
  State<LiveChatDialog> createState() => _LiveChatDialogState();
}

class _LiveChatDialogState extends State<LiveChatDialog> {
  final _apiService = ApiService();
  final _chatService = ChatService();
  final _voiceCallService = VoiceCallService();
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  List<Map<String, dynamic>> _messages = [];
  int? _conversationId;
  bool _isLoading = true;
  bool _isConnected = false;
  bool _isSending = false;
  String? _typingUser;
  Timer? _typingTimer;

  // Support online status
  bool _supportOnline = false;
  int? _supportLastSeenSeconds;
  String _supportName = 'Support';
  Timer? _supportStatusTimer;

  // Network status
  String _connectionType = 'unknown';
  int _latencyMs = -1;
  String _networkQuality = 'offline';
  Timer? _networkTimer;

  // Voice call state - most WebRTC state now managed by VoiceCallService
  Timer? _callDurationTimer;
  Duration _callDuration = Duration.zero;
  String _remoteName = 'Support';

  // Incoming call state (when admin calls member)
  String? _pendingSdp;
  String? _pendingSdpType;
  int? _incomingCallConvId;

  // File upload state
  List<File> _selectedFiles = [];
  bool _isUploading = false;

  // Stream subscriptions
  StreamSubscription? _messageSubscription;
  StreamSubscription? _typingSubscription;
  StreamSubscription? _connectionSubscription;
  StreamSubscription? _errorSubscription;
  StreamSubscription? _callAnswerSubscription;
  StreamSubscription? _callRejectedSubscription;
  StreamSubscription? _callEndedSubscription;
  StreamSubscription? _iceCandidateSubscription;
  StreamSubscription? _callBusySubscription;
  StreamSubscription? _readReceiptSubscription;
  StreamSubscription? _callOfferSubscription;
  StreamSubscription? _callStateSubscription;

  /// Format name to show initials + last name
  /// Example: "Ionut-Claudiu Duinea" → "I.C. Duinea"
  String _formatNameWithInitials(String fullName) {
    final parts = fullName.trim().split(' ');
    if (parts.length < 2) return fullName; // Not enough parts

    // Last part is the surname (keep full)
    final surname = parts.last;

    // Everything before last part is the first name(s)
    final firstNames = parts.sublist(0, parts.length - 1).join(' ');

    // Split first names by space or hyphen to get initials
    final nameWords = firstNames.split(RegExp(r'[\s-]+'));

    // Get up to 2 initials
    final initials = nameWords
        .take(2)
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}.' : '')
        .join('');

    return '$initials $surname';
  }

  @override
  void initState() {
    super.initState();

    // Configure VoiceCallService signaling via ChatService
    _voiceCallService.onSignalingMessage = (message) {
      final type = message['type'] as String;
      final convId = message['conversation_id'] as int;

      switch (type) {
        case 'call_offer':
          _chatService.sendCallOffer(convId, message['sdp'] as String, message['sdp_type'] as String);
          break;
        case 'call_answer':
          _chatService.sendCallAnswer(convId, message['sdp'] as String, message['sdp_type'] as String);
          break;
        case 'call_reject':
          _chatService.sendCallReject(convId, message['reason'] as String);
          break;
        case 'call_end':
          _chatService.sendCallEnd(convId);
          break;
        case 'ice_candidate':
          _chatService.sendIceCandidate(
            convId,
            message['candidate'] as String,
            message['sdp_mid'] as String,
            message['sdp_mline_index'] as int,
          );
          break;
      }
    };

    // Listen to VoiceCallService state changes to update UI
    _callStateSubscription = _voiceCallService.callStateStream.listen((state) {
      _log.info('LiveChat: VoiceCallService state changed to: $state', tag: 'CALL');
      if (mounted) {
        setState(() {}); // Trigger UI rebuild
      }
    });

    _initChat();

    // Start support status polling (every 30 seconds - battery optimized)
    _loadSupportStatus();
    _supportStatusTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) _loadSupportStatus();
    });

    // Start network status polling (every 15 seconds)
    _updateNetworkStatus();
    _networkTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) _updateNetworkStatus();
    });

    // Handle pending call if passed from dashboard
    if (widget.pendingCall != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handlePendingCall(widget.pendingCall!);
      });
    }
  }

  void _handlePendingCall(CallOfferEvent event) async {
    _log.info('LiveChat: _handlePendingCall() from ${event.callerName} (conv: ${event.conversationId})', tag: 'CALL');
    // Wait a bit for WebSocket to connect
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) {
      _log.warning('LiveChat: _handlePendingCall() - not mounted, aborting', tag: 'CALL');
      return;
    }

    _incomingCallConvId = event.conversationId;
    _pendingSdp = event.sdp;
    _pendingSdpType = event.sdpType;
    _remoteName = event.callerName;
    _log.debug('LiveChat: Pending call data set - SDP type: ${event.sdpType}', tag: 'CALL');

    // CRITICAL FIX: Inform VoiceCallService about incoming call BEFORE accepting
    // This sets the call state to ringing, which is required for acceptCall() to work
    _log.info('LiveChat: Informing VoiceCallService about incoming call...', tag: 'CALL');
    _voiceCallService.handleIncomingCall(
      event.conversationId,
      event.callerId,
      event.callerName,
      event.sdp,
      event.sdpType,
    );

    // Wait a tiny bit for state to update
    await Future.delayed(const Duration(milliseconds: 100));

    // Auto-accept the call (user already accepted in the dialog)
    if (mounted) {
      _log.info('LiveChat: Auto-accepting pending call', tag: 'CALL');
      _acceptCall();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _typingTimer?.cancel();
    _callDurationTimer?.cancel();
    _supportStatusTimer?.cancel();
    _networkTimer?.cancel();
    _messageSubscription?.cancel();
    _typingSubscription?.cancel();
    _connectionSubscription?.cancel();
    _errorSubscription?.cancel();
    _callAnswerSubscription?.cancel();
    _callRejectedSubscription?.cancel();
    _callEndedSubscription?.cancel();
    _iceCandidateSubscription?.cancel();
    _callBusySubscription?.cancel();
    _readReceiptSubscription?.cancel();
    _callOfferSubscription?.cancel();
    _callStateSubscription?.cancel();
    // Don't call _endCallCleanup() in dispose - widget is already defunct
    // Just cancel the timer and clear pending data without setState
    _callDurationTimer?.cancel();
    _pendingSdp = null;
    _pendingSdpType = null;
    // Don't leave conversation - dashboard maintains the subscription for background notifications
    super.dispose();
  }

  Future<void> _initChat() async {
    _log.info('LiveChat: _initChat() starting for ${widget.mitgliedernummer}', tag: 'CHAT');
    try {
      // Start or get existing conversation via REST API
      _log.debug('LiveChat: Calling startChat API...', tag: 'CHAT');
      final result = await _apiService.startChat(widget.mitgliedernummer);

      if (result['success'] == true) {
        // Parse conversation_id as int (API may return string)
        final convId = result['conversation_id'];
        _conversationId = convId is int ? convId : int.tryParse(convId.toString());
        _log.info('LiveChat: Got conversation_id=$_conversationId', tag: 'CHAT');

        // Load existing messages
        await _loadMessages();

        // Connect to WebSocket for real-time updates
        await _connectWebSocket();
      } else {
        _log.error('LiveChat: startChat failed: ${result['message']}', tag: 'CHAT');
        if (mounted) _showError(result['message'] ?? AppLocalizations.of(context)!.errorStartingChat);
      }
    } catch (e) {
      _log.error('LiveChat: _initChat exception: $e', tag: 'CHAT');
      if (mounted) _showError(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'CHAT'));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadSupportStatus() async {
    try {
      final result = await _apiService.getSupportStatus();

      if (result['success'] == true && mounted) {
        // API returns data directly at root level (jsonResponse uses array_merge)
        final anyOnline = result['any_online'] == true;

        setState(() {
          _supportOnline = anyOnline;

          if (anyOnline) {
            // At least one admin is online
            final onlineAdmins = result['online_admins'] as List?;
            if (onlineAdmins != null && onlineAdmins.isNotEmpty) {
              final fullName = onlineAdmins[0]['name'] ?? 'Support';
              _supportName = _formatNameWithInitials(fullName);
            }
            _supportLastSeenSeconds = null;
          } else {
            // Nobody online, get most recent admin
            final mostRecent = result['most_recent_admin'];
            if (mostRecent != null) {
              final fullName = mostRecent['name'] ?? 'Support';
              _supportName = _formatNameWithInitials(fullName);
              _supportLastSeenSeconds = mostRecent['seconds_since_active'];
            }
          }
        });

        _log.debug('LiveChat: Support status loaded - online: $anyOnline, name: $_supportName, seconds: $_supportLastSeenSeconds', tag: 'CHAT');
      }
    } catch (e) {
      _log.error('LiveChat: _loadSupportStatus error: $e', tag: 'CHAT');
      // Don't show error to user - this is background polling
    }
  }

  Future<void> _updateNetworkStatus() async {
    try {
      final info = await NetworkInfoService().getNetworkInfo(
        '${ApiService.baseUrl}/auth/heartbeat_app.php',
      );
      if (mounted) {
        setState(() {
          _connectionType = info['connection_type'] ?? 'unknown';
          _latencyMs = info['latency_ms'] ?? -1;
          _networkQuality = info['quality'] ?? 'offline';
        });
      }
    } catch (e) {
      _log.error('LiveChat: _updateNetworkStatus error: $e', tag: 'CHAT');
    }
  }

  Widget _buildNetworkStatusBar() {
    IconData icon;
    Color color;
    String label;
    String qualityText;

    switch (_connectionType) {
      case 'wifi':
        icon = Icons.wifi;
        label = 'WiFi';
        break;
      case 'mobile':
        icon = Icons.signal_cellular_alt;
        label = 'Mobile';
        break;
      case 'ethernet':
        icon = Icons.lan;
        label = 'Ethernet';
        break;
      case 'none':
        icon = Icons.signal_cellular_off;
        label = 'Offline';
        break;
      default:
        icon = Icons.signal_cellular_nodata;
        label = _connectionType;
    }

    switch (_networkQuality) {
      case 'good':
        color = Colors.green;
        qualityText = '✅';
        break;
      case 'medium':
        color = Colors.orange;
        qualityText = '⚠️';
        break;
      case 'poor':
        color = Colors.red;
        qualityText = '❌';
        break;
      default:
        color = Colors.grey;
        qualityText = '❌';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
          ),
          if (_latencyMs >= 0) ...[
            const SizedBox(width: 8),
            Text(
              '${_latencyMs}ms',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
          const SizedBox(width: 6),
          Text(qualityText, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Future<void> _loadMessages() async {
    if (_conversationId == null) return;
    _log.debug('LiveChat: _loadMessages() for conversation $_conversationId', tag: 'CHAT');

    try {
      final result = await _apiService.getChatMessages(
        _conversationId!,
        widget.mitgliedernummer,
      );

      if (result['success'] == true && mounted) {
        final newMessages = List<Map<String, dynamic>>.from(result['messages'] ?? []);
        final msgCount = newMessages.length;
        _log.info('LiveChat: Loaded $msgCount messages', tag: 'CHAT');

        setState(() {
          // Get existing message IDs to prevent duplicates
          final existingIds = _messages.map((m) => m['id']).toSet();

          // Only add messages that don't already exist
          for (var msg in newMessages) {
            if (!existingIds.contains(msg['id'])) {
              _messages.add(msg);
            }
          }

          // If no existing messages, just use the new list
          if (existingIds.isEmpty) {
            _messages = newMessages;
          }
        });
        _scrollToBottom();
      } else {
        _log.warning('LiveChat: _loadMessages failed: ${result['message']}', tag: 'CHAT');
      }
    } catch (e) {
      _log.error('LiveChat: _loadMessages exception: $e', tag: 'CHAT');
    }
  }

  Future<void> _connectWebSocket() async {
    _log.info('LiveChat: _connectWebSocket() starting...', tag: 'CHAT');
    // Set up chat listeners
    _messageSubscription = _chatService.messageStream.listen((message) {
      if (!mounted) return;
      if (message.conversationId != _conversationId) return;

      // Skip own messages - already added locally via HTTP POST response
      final isOwn = message.senderName == widget.userName;
      if (isOwn) {
        _log.debug('LiveChat: Skipping own WebSocket echo (id: ${message.id})', tag: 'CHAT');
        return;
      }

      // Dedup by message ID (for messages from others)
      if (_messages.any((m) => m['id'] == message.id)) {
        _log.debug('LiveChat: Skipping duplicate message (id: ${message.id})', tag: 'CHAT');
        return;
      }

      setState(() {
        _messages.add({
          'id': message.id,
          'message': message.message,
          'sender_id': message.senderId,
          'sender_name': message.senderName,
          'sender_role': message.senderRole,
          'is_own': false,
          'created_at': message.createdAt.toIso8601String(),
        });
      });
      _scrollToBottom();
    });

    _typingSubscription = _chatService.typingStream.listen((event) {
      if (!mounted) return;
      setState(() => _typingUser = event.userName);
      _typingTimer?.cancel();
      _typingTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) setState(() => _typingUser = null);
      });
    });

    _connectionSubscription = _chatService.connectionStream.listen((connected) {
      if (!mounted) return;
      setState(() => _isConnected = connected);
    });

    _errorSubscription = _chatService.errorStream.listen((error) {
      debugPrint('Chat error: $error');
    });

    // Set up voice call listeners
    _callAnswerSubscription = _chatService.callAnswerStream.listen((event) {
      _log.info('LiveChat: [WS] Received call_answer from ${event.answererName} (conv: ${event.conversationId})', tag: 'CALL');
      if (!mounted) return;
      if (event.conversationId == _conversationId) {
        _handleCallAnswer(event.sdp, event.sdpType, event.answererName);
      } else {
        _log.warning('LiveChat: call_answer ignored - conversationId mismatch (expected: $_conversationId)', tag: 'CALL');
      }
    });

    _callRejectedSubscription = _chatService.callRejectedStream.listen((event) {
      _log.info('LiveChat: [WS] Received call_rejected (conv: ${event.conversationId}, reason: ${event.reason})', tag: 'CALL');
      if (!mounted) return;
      if (event.conversationId == _conversationId) {
        _handleCallRejected(event.reason);
      }
    });

    _callEndedSubscription = _chatService.callEndedStream.listen((event) {
      _log.info('LiveChat: [WS] Received call_ended (conv: ${event.conversationId})', tag: 'CALL');
      if (!mounted) return;
      if (event.conversationId == _conversationId) {
        _handleCallEnded();
      }
    });

    _iceCandidateSubscription = _chatService.iceCandidateStream.listen((event) {
      _log.debug('LiveChat: [WS] Received ice_candidate (conv: ${event.conversationId})', tag: 'CALL');
      if (!mounted) return;
      if (event.conversationId == _conversationId) {
        _handleIceCandidate(event.candidate, event.sdpMid, event.sdpMLineIndex);
      }
    });

    _callBusySubscription = _chatService.callBusyStream.listen((convId) {
      _log.info('LiveChat: [WS] Received call_busy (conv: $convId)', tag: 'CALL');
      if (!mounted) return;
      if (convId == _conversationId) {
        _showError(AppLocalizations.of(context)!.callSupportBusy);
        _endCallCleanup();
      }
    });

    // DISABLED: Call handling moved to Dashboard with NativeCallScreen
    // Incoming calls are now handled centrally in mitglied_dashboard.dart
    /*
    _callOfferSubscription = _chatService.callOfferStream.listen((event) {
      _log.info('LiveChat: [WS] Received call_offer from ${event.callerName} (conv: ${event.conversationId})', tag: 'CALL');
      if (!mounted) return;
      if (event.conversationId == _conversationId) {
        _handleIncomingCall(event);
      }
    });
    */

    // Read receipt listener
    _readReceiptSubscription = _chatService.readReceiptStream.listen((event) {
      if (!mounted) return;
      if (event.conversationId != _conversationId) return;

      setState(() {
        for (var msg in _messages) {
          if (event.messageIds.contains(msg['id'])) {
            msg['status'] = event.status;
            if (event.status == 'read') {
              msg['is_read'] = true;
            }
          }
        }
      });
    });

    // Connect and authenticate
    _log.info('LiveChat: Calling chatService.connect(${widget.mitgliedernummer})', tag: 'CHAT');
    final connected = await _chatService.connect(widget.mitgliedernummer);
    _log.info('LiveChat: connect() returned: $connected', tag: 'CHAT');

    if (connected && _conversationId != null) {
      _log.info('LiveChat: Joining conversation $_conversationId', tag: 'CHAT');
      _chatService.joinConversation(_conversationId!);
      if (mounted) {
        setState(() => _isConnected = true);
        _log.info('LiveChat: Connected and joined successfully!', tag: 'CHAT');
      }
    } else {
      _log.warning('LiveChat: Failed to connect or conversationId is null (connected=$connected, convId=$_conversationId)', tag: 'CHAT');
    }
  }

  // ==================== Voice Call Methods ====================

  /// Start call to support - REFACTORED to use VoiceCallService
  Future<void> _startCall() async {
    _log.info('LiveChat: _startCall() initiated by member (using VoiceCallService)', tag: 'CALL');
    if (_conversationId == null || _voiceCallService.callState != CallState.idle) {
      _log.warning('LiveChat: _startCall() aborted - convId: $_conversationId, status: ${_voiceCallService.callState}', tag: 'CALL');
      return;
    }
    if (!mounted) return;

    try {
      // Use VoiceCallService to start the call
      // For member calling support, we use "support" as targetUserId
      final success = await _voiceCallService.startCall(_conversationId!, 'support', 'Support');

      if (!success) {
        throw Exception('Failed to start call via VoiceCallService');
      }

      _log.info('LiveChat: Call to support started successfully via VoiceCallService', tag: 'CALL');

      if (mounted) {
        _startCallDurationTimer();
      }

    } catch (e) {
      _log.error('LiveChat: _startCall() error: $e', tag: 'CALL');
      if (mounted) {
        if (e.toString().contains('NO_MICROPHONE')) {
          _showError(AppLocalizations.of(context)!.errorStartingCall);
        } else {
          _showError(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'CHAT'));
        }
      }
      await _voiceCallService.endCall();
      if (mounted) {
        _endCallCleanup();
      }
    }
  }

  /// Handle answer from support - REFACTORED to use VoiceCallService
  Future<void> _handleCallAnswer(String sdp, String sdpType, String answererName) async {
    _log.info('LiveChat: _handleCallAnswer() from $answererName, sdpType: $sdpType (using VoiceCallService)', tag: 'CALL');
    if (!mounted) return;

    try {
      _remoteName = answererName;
      await _voiceCallService.handleCallAnswer(sdp, sdpType);
      _log.info('LiveChat: Call answer handled successfully via VoiceCallService', tag: 'CALL');
      if (mounted) {
        _startCallDurationTimer();
      }
    } catch (e) {
      _log.error('LiveChat: _handleCallAnswer() error: $e', tag: 'CALL');
      if (mounted) {
        _showError(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'CHAT'));
        _endCallCleanup();
      }
    }
  }

  /// Handle call rejection - REFACTORED to use VoiceCallService
  void _handleCallRejected(String reason) {
    _log.info('LiveChat: _handleCallRejected() reason: $reason (using VoiceCallService)', tag: 'CALL');
    if (!mounted) return;

    String message;
    switch (reason) {
      case 'busy':
        message = AppLocalizations.of(context)!.callBusy;
        break;
      case 'rejected':
        message = AppLocalizations.of(context)!.callRejected;
        break;
      default:
        message = AppLocalizations.of(context)!.callFailed;
    }
    _showError(message);
    _voiceCallService.handleCallRejected(reason);
    _endCallCleanup();
  }

  /// Handle call ended by remote peer - REFACTORED to use VoiceCallService
  void _handleCallEnded() {
    _log.info('LiveChat: _handleCallEnded() received (using VoiceCallService)', tag: 'CALL');
    if (!mounted) return;

    final wasInCall = _voiceCallService.callState != CallState.idle;
    _voiceCallService.handleCallEnded();
    _endCallCleanup();
    if (wasInCall && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.callEnded),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  /// Handle ICE candidate - REFACTORED to use VoiceCallService
  Future<void> _handleIceCandidate(String candidate, String sdpMid, int sdpMLineIndex) async {
    if (!mounted) return;
    _log.debug('LiveChat: Handling ICE candidate via VoiceCallService', tag: 'CALL');
    await _voiceCallService.handleIceCandidate(candidate, sdpMid, sdpMLineIndex);
  }

  /// End call - REFACTORED to use VoiceCallService
  void _endCall() {
    _log.info('LiveChat: _endCall() (using VoiceCallService)', tag: 'CALL');
    _voiceCallService.endCall();
    _endCallCleanup();
  }

  /// Cleanup local UI state - WebRTC cleanup now handled by VoiceCallService
  void _endCallCleanup() {
    _log.info('LiveChat: _endCallCleanup() - cleaning up UI state', tag: 'CALL');
    _callDurationTimer?.cancel();
    _pendingSdp = null;
    _pendingSdpType = null;
    if (mounted) {
      setState(() {
        _callDuration = Duration.zero;
      });
    }
    _log.debug('LiveChat: Call cleanup completed', tag: 'CALL');
  }

  /// Accept an incoming call from admin - REFACTORED to use VoiceCallService
  Future<void> _acceptCall() async {
    _log.info('LiveChat: _acceptCall() - convId: $_incomingCallConvId, hasSdp: ${_pendingSdp != null} (using VoiceCallService)', tag: 'CALL');
    if (_pendingSdp == null || _incomingCallConvId == null || !mounted) {
      _log.warning('LiveChat: _acceptCall() aborted - missing data or not mounted', tag: 'CALL');
      return;
    }

    try {
      // Use VoiceCallService to accept the call
      final success = await _voiceCallService.acceptCall(_pendingSdp!, _pendingSdpType!);

      if (!success) {
        throw Exception('Failed to accept call via VoiceCallService');
      }

      _log.info('LiveChat: Call accepted successfully via VoiceCallService', tag: 'CALL');

      if (mounted) {
        _startCallDurationTimer();
      }

    } catch (e) {
      _log.error('LiveChat: _acceptCall() error: $e', tag: 'CALL');
      if (mounted) {
        if (e.toString().contains('NO_MICROPHONE')) {
          _showError(AppLocalizations.of(context)!.noMicrophoneError);
        } else {
          _showError(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'CHAT'));
        }
      }
      await _voiceCallService.endCall();
      if (mounted) {
        _endCallCleanup();
      }
    }
  }

  /// Toggle mute - REFACTORED to use VoiceCallService
  void _toggleMute() {
    if (!mounted) return;
    _voiceCallService.toggleMute();
    if (mounted) {
      setState(() {}); // Trigger UI update
    }
  }

  void _startCallDurationTimer() {
    _callDurationTimer?.cancel();
    _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _callDuration += const Duration(seconds: 1));
      }
    });
  }

  // ==================== Chat Methods ====================

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || _conversationId == null || _isSending) return;
    _log.info('LiveChat: _sendMessage() - sending to conversation $_conversationId', tag: 'CHAT');

    final errorSendingText = AppLocalizations.of(context)!.errorSending;
    setState(() => _isSending = true);
    _messageController.clear();

    try {
      final result = await _apiService.sendChatMessage(
        _conversationId!,
        widget.mitgliedernummer,
        message,
      );
      _log.debug('LiveChat: sendChatMessage API result: ${result['success']}', tag: 'CHAT');

      if (result['success'] == true && mounted) {
        setState(() {
          _messages.add({
            'id': result['message_id'] ?? result['data']?['message_id'],
            'message': message,
            'sender_name': widget.userName,
            'sender_role': 'mitglied',
            'is_own': true,
            'created_at': result['created_at'] ?? result['data']?['created_at'] ?? DateTime.now().toIso8601String(),
          });
        });
        _scrollToBottom();

        // DON'T send via WebSocket - API already saved it and server will broadcast
        // Sending via WebSocket causes duplicates when we receive our own message back
        _log.debug('LiveChat: Message sent via API, server will broadcast to others', tag: 'CHAT');
      } else {
        _log.error('LiveChat: sendChatMessage failed: ${result['message']}', tag: 'CHAT');
        _showError(result['message'] ?? errorSendingText);
        _messageController.text = message;
      }
    } catch (e) {
      _log.error('LiveChat: _sendMessage exception: $e', tag: 'CHAT');
      _showError(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'CHAT'));
      _messageController.text = message;
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  void _onTyping() {
    if (_isConnected && _conversationId != null) {
      _chatService.sendTyping(_conversationId!);
    }
  }

  void _scrollToBottom() {
    // With `reverse: true` the bottom of the visible list is offset 0, so
    // jumping to 0 always lands on the newest message regardless of whether
    // the ListView has finished laying out items. On initial load the list
    // already opens at offset 0 — this call is a no-op then, and becomes the
    // animate-to-newest action when a new message arrives while the user is
    // at the bottom.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ==================== File Upload Methods ====================

  /// Show attachment options bottom sheet
  /// Camera/Gallery only available on mobile (image_picker doesn't support Windows/Linux)
  Future<void> _showAttachmentOptions() async {
    final isMobile = Platform.isAndroid || Platform.isIOS;
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMobile) ...[
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF667eea)),
                title: Text(AppLocalizations.of(context)!.camera),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF667eea)),
                title: Text(AppLocalizations.of(context)!.gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery();
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.attach_file, color: Color(0xFF667eea)),
              title: Text(AppLocalizations.of(context)!.documents),
              onTap: () {
                Navigator.pop(context);
                _pickFiles();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Pick image from camera, then offer crop before upload
  Future<void> _pickFromCamera() async {
    final errorText = AppLocalizations.of(context)!.errorTakingPhoto;
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null && mounted) {
        final imageBytes = await File(image.path).readAsBytes();
        final croppedBytes = await _showCropDialog(imageBytes);
        if (croppedBytes != null && mounted) {
          final dir = await getTemporaryDirectory();
          final croppedFile = File('${dir.path}/crop_${DateTime.now().millisecondsSinceEpoch}.jpg');
          await croppedFile.writeAsBytes(croppedBytes);
          setState(() => _selectedFiles = [croppedFile]);
          await _uploadFiles();
        }
      }
    } catch (e) {
      _log.error('LiveChat: Camera picker error: $e', tag: 'CHAT');
      _showError(errorText);
    }
  }

  Future<Uint8List?> _showCropDialog(Uint8List imageBytes) async {
    final controller = CropController();
    Uint8List? result;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Dokument zuschneiden',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Crop(
                image: imageBytes,
                controller: controller,
                onCropped: (cropped) {
                  result = cropped;
                  Navigator.of(ctx).pop();
                },
                interactive: true,
                fixArea: false,
                baseColor: Colors.black87,
                maskColor: Colors.black54,
                cornerDotBuilder: (size, edgeAlignment) => DotControl(
                  color: const Color(0xFF667eea),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text('Abbrechen'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => controller.crop(),
                    icon: const Icon(Icons.crop),
                    label: Text('Zuschneiden'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667eea),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return result;
  }

  /// Pick image from gallery
  Future<void> _pickFromGallery() async {
    final errorText = AppLocalizations.of(context)!.errorPickingPhotos;
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty) {
        final files = images.take(10).map((xfile) => File(xfile.path)).toList();

        // Check total size
        int totalSize = 0;
        for (var file in files) {
          totalSize += await file.length();
        }

        if (totalSize > 50 * 1024 * 1024) {
          _showError('Max: 50 MB');
          return;
        }

        setState(() => _selectedFiles = files);
        await _uploadFiles();
      }
    } catch (e) {
      _log.error('LiveChat: Gallery picker error: $e', tag: 'CHAT');
      _showError(errorText);
    }
  }

  Future<void> _pickFiles() async {
    final errorText = AppLocalizations.of(context)!.errorPickingFiles;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'txt'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final files = result.files
            .where((f) => f.path != null)
            .take(10)
            .map((f) => File(f.path!))
            .toList();

        // Check total size (max 50MB)
        int totalSize = 0;
        for (var file in files) {
          totalSize += await file.length();
        }

        if (totalSize > 50 * 1024 * 1024) {
          _showError('Max: 50 MB');
          return;
        }

        setState(() => _selectedFiles = files);
        await _uploadFiles();
      }
    } catch (e) {
      _log.error('LiveChat: File picker error: $e', tag: 'CHAT');
      _showError(errorText);
    }
  }

  Future<void> _uploadFiles() async {
    if (_selectedFiles.isEmpty || _conversationId == null || _isUploading) return;

    final errorUploadText = AppLocalizations.of(context)!.errorUploading;
    setState(() => _isUploading = true);

    try {
      final result = await _apiService.uploadChatAttachments(
        conversationId: _conversationId!,
        mitgliedernummer: widget.mitgliedernummer,
        files: _selectedFiles,
        message: _messageController.text.trim().isNotEmpty ? _messageController.text.trim() : null,
      );

      if (result['success'] == true && mounted) {
        _messageController.clear();
        setState(() => _selectedFiles = []);

        // Add message to local list
        // Note: jsonResponse uses array_merge, so fields are at root level (not under 'data')
        final msgData = result['data'] ?? result;
        if (msgData != null) {
          setState(() {
            _messages.add({
              'id': msgData['message_id'],
              'message': msgData['message'] ?? '',
              'sender_name': widget.userName,
              'sender_role': 'mitglied',
              'is_own': true,
              'status': 'sent',
              'created_at': msgData['created_at'] ?? DateTime.now().toIso8601String(),
              'attachments': msgData['attachments'] ?? [],
            });
          });
          _scrollToBottom();

          // Broadcast via WebSocket
          if (_isConnected) {
            _chatService.sendMessage(_conversationId!, msgData['message'] ?? '[Dateien]');
          }
        }
      } else {
        _showError(result['message'] ?? errorUploadText);
      }
    } catch (e) {
      _log.error('LiveChat: Upload error: $e', tag: 'CHAT');
      _showError(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'CHAT'));
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _downloadAttachment(Map<String, dynamic> attachment) async {
    final l = AppLocalizations.of(context)!;
    final errorDownloadText = l.errorDownloading;
    final fileNotLoadedText = l.fileNotLoaded;
    final attachIdMissingText = l.attachmentIdMissing;
    try {
      final attachId = attachment['id'];
      if (attachId == null) {
        _showError(attachIdMissingText);
        _log.error('LiveChat: Download failed - attachment has no id: $attachment', tag: 'CHAT');
        return;
      }
      final int parsedId = attachId is int ? attachId : int.parse(attachId.toString());

      final result = await _apiService.downloadChatAttachment(
        attachmentId: parsedId,
        mitgliedernummer: widget.mitgliedernummer,
      );

      if (result['success'] == true && mounted) {
        // Server uses array_merge, so fields are at root level (not under 'data')
        final base64Data = result['content'] ?? result['data']?['content'] ?? result['data']?['file_data'];
        final filename = result['filename'] ?? result['data']?['filename'];

        if (base64Data == null || filename == null) {
          _showError(fileNotLoadedText);
          return;
        }

        // Decode and save file
        final bytes = base64Decode(base64Data);
        final tempDir = await getTemporaryDirectory();
        final safeName = filename.split(RegExp(r'[/\\]')).last.replaceAll('..', '');
        final file = File('${tempDir.path}/$safeName');
        await file.writeAsBytes(bytes);

        // Open file internally (PDF, images) or externally (other types)
        if (mounted) {
          await FileViewer.open(context, file, filename);
        }
      } else {
        _showError(result['message'] ?? errorDownloadText);
      }
    } catch (e) {
      _log.error('LiveChat: Download error: $e', tag: 'CHAT');
      _showError(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'CHAT'));
    }
  }

  /// Mark all unread messages as read when user focuses on input
  Future<void> _markMessagesAsRead() async {
    if (_conversationId == null) return;

    // Find unread messages from others
    final unreadIds = _messages
        .where((m) => m['is_own'] != true && m['status'] != 'read')
        .map((m) => int.tryParse(m['id']?.toString() ?? ''))
        .whereType<int>()
        .toList();

    if (unreadIds.isEmpty) return;

    try {
      final result = await _apiService.markMessagesRead(
        conversationId: _conversationId!,
        mitgliedernummer: widget.mitgliedernummer,
        status: 'read',
        messageIds: unreadIds,
      );

      if (result['success'] == true && mounted) {
        // Update local state
        setState(() {
          for (var msg in _messages) {
            if (unreadIds.contains(msg['id'])) {
              msg['status'] = 'read';
              msg['is_read'] = true;
            }
          }
        });

        // Broadcast via WebSocket
        if (_isConnected) {
          _chatService.sendReadReceipt(_conversationId!, unreadIds, 'read');
        }
      }
    } catch (e) {
      _log.error('LiveChat: Mark read error: $e', tag: 'CHAT');
    }
  }

  void _showError(String message) {
    if (!mounted) return;

    // For critical errors (NO_MICROPHONE), show persistent SnackBar
    final isCritical = message.contains('NO_MICROPHONE') || message.contains('Mikrofon') || message.contains('Microphone') || message.contains('mikrofon') || message.contains('microphone');
    final duration = isCritical ? const Duration(seconds: 15) : const Duration(seconds: 4);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isCritical ? Icons.mic_off : Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        action: isCritical
            ? SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            // Modern Header
            _buildModernHeader(),

            // Messages area
            Expanded(
              child: Container(
                color: const Color(0xFFF5F5F5),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildModernMessagesList(),
              ),
            ),

            // Typing indicator
            if (_typingUser != null)
              Container(
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _buildTypingIndicator(),
                    const SizedBox(width: 8),
                    Text(
                      '$_typingUser tippt...',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

            // Call overlay
            if (_voiceCallService.callState != CallState.idle) _buildCallOverlay(),

            // Modern Input area
            _buildModernInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 600 + (index * 200)),
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar with online indicator
          Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(Icons.support_agent, color: Colors.white, size: 28),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: _supportOnline ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Name and status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _supportOnline ? _supportName : 'Support',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a1a2e),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _supportOnline ? AppLocalizations.of(context)!.online : _formatLastSeen(),
                  style: TextStyle(
                    fontSize: 13,
                    color: _supportOnline ? Colors.green : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Voice call button
          if (_voiceCallService.callState == CallState.idle)
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: _isConnected ? _startCall : null,
                tooltip: AppLocalizations.of(context)!.callSupport,
              ),
            ),
          const SizedBox(width: 8),
          // Close button
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                if (_voiceCallService.callState != CallState.idle) {
                  _endCall();
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernMessagesList() {
    if (_messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey.shade400),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.startConversation,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.staffWillReply,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.grey.shade100,
        child: SeasonalBackground(
          paintBehind: true,
          child: ListView.builder(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final msg = _messages[_messages.length - 1 - index];
            final isOwn = msg['is_own'] == true;
            return _buildModernMessageBubble(msg, isOwn);
          },
        ),
      ),
      ),
    );
  }

  static final _urlPattern = RegExp(r"""https?://[^\s<>"')\]]+""", caseSensitive: false);

  Widget _buildLinkedText(String text, bool isOwn) {
    final matches = _urlPattern.allMatches(text).toList();
    if (matches.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          color: isOwn ? Colors.white : const Color(0xFF1a1a2e),
          fontSize: 15,
          height: 1.4,
        ),
      );
    }

    final spans = <TextSpan>[];
    var lastEnd = 0;
    for (final m in matches) {
      if (m.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, m.start)));
      }
      final url = m.group(0)!;
      spans.add(TextSpan(
        text: url,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: isOwn ? Colors.white : const Color(0xFF667eea),
          fontWeight: FontWeight.w500,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      ));
      lastEnd = m.end;
    }
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return Text.rich(
      TextSpan(
        style: TextStyle(
          color: isOwn ? Colors.white : const Color(0xFF1a1a2e),
          fontSize: 15,
          height: 1.4,
        ),
        children: spans,
      ),
    );
  }

  Widget _buildModernMessageBubble(Map<String, dynamic> msg, bool isOwn) {
    final senderRole = msg['sender_role'] ?? 'mitglied';
    final isSupport = senderRole != 'mitglied';
    final attachments = msg['attachments'] as List? ?? [];
    final messageText = msg['message'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for support messages
          if (!isOwn) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.support_agent, color: Colors.white, size: 18),
              ),
            ),
            const SizedBox(width: 8),
          ],
          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isOwn
                    ? const LinearGradient(
                        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isOwn ? null : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isOwn ? 20 : 4),
                  bottomRight: Radius.circular(isOwn ? 4 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name for support
                  if (!isOwn && isSupport)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        msg['sender_name'] ?? 'Support',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.purple.shade700,
                        ),
                      ),
                    ),
                  // Message text (URLs are tappable and open in external browser)
                  if (messageText.isNotEmpty)
                    _buildLinkedText(messageText, isOwn),
                  // Attachments
                  if (attachments.isNotEmpty) ...[
                    if (messageText.isNotEmpty) const SizedBox(height: 8),
                    ...attachments.map((att) => _buildModernAttachment(att, isOwn)),
                  ],
                  // Time and read receipt
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(msg['created_at']),
                        style: TextStyle(
                          fontSize: 11,
                          color: isOwn ? Colors.white70 : Colors.grey.shade500,
                        ),
                      ),
                      if (isOwn) ...[
                        const SizedBox(width: 4),
                        _buildReadReceipt(msg),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernAttachment(Map<String, dynamic> attachment, bool isOwn) {
    final filename = attachment['filename'] ?? AppLocalizations.of(context)!.file;
    final size = attachment['size'] ?? 0;
    final extension = (attachment['extension'] ?? '').toString().toLowerCase();

    IconData icon;
    switch (extension) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        break;
      case 'png':
      case 'jpg':
      case 'jpeg':
        icon = Icons.image;
        break;
      default:
        icon = Icons.attach_file;
    }

    return InkWell(
      onTap: () => _downloadAttachment(attachment),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isOwn ? Colors.white.withValues(alpha: 0.2) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isOwn ? Colors.white.withValues(alpha: 0.3) : const Color(0xFF667eea).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: isOwn ? Colors.white : const Color(0xFF667eea)),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filename,
                    style: TextStyle(
                      fontSize: 13,
                      color: isOwn ? Colors.white : const Color(0xFF1a1a2e),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _formatFileSize(size),
                    style: TextStyle(
                      fontSize: 11,
                      color: isOwn ? Colors.white70 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Selected files preview
          if (_selectedFiles.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _selectedFiles.map((file) {
                    final name = file.path.split(Platform.pathSeparator).last;
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF667eea).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.attach_file, size: 16, color: Color(0xFF667eea)),
                          const SizedBox(width: 6),
                          Text(
                            name.length > 15 ? '${name.substring(0, 15)}...' : name,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF667eea)),
                          ),
                          const SizedBox(width: 6),
                          InkWell(
                            onTap: () => setState(() { _selectedFiles = List.from(_selectedFiles)..remove(file); }),
                            child: const Icon(Icons.close, size: 16, color: Color(0xFF667eea)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          // Network status bar
          _buildNetworkStatusBar(),
          // Input row
          Row(
            children: [
              // Attachment button
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: _isUploading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF667eea)),
                        )
                      : const Icon(Icons.add, color: Color(0xFF667eea)),
                  onPressed: _isUploading || _isLoading ? null : _showAttachmentOptions,
                ),
              ),
              const SizedBox(width: 12),
              // Text input
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _messageController,
                    onChanged: (_) => _onTyping(),
                    onSubmitted: (_) => _sendMessage(),
                    onTap: _markMessagesAsRead,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.typeMessage,
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    enabled: !_isLoading,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Send button
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: _isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Icon(Icons.send_rounded, color: Colors.white),
                  onPressed: _isSending ? null : _sendMessage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallOverlay() {
    if (_voiceCallService.callState == CallState.calling) {
      return CallingOverlay(
        targetName: 'Support',
        onCancel: _endCall,
      );
    } else if (_voiceCallService.callState == CallState.inCall) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: InCallOverlay(
          remoteName: _remoteName,
          callDuration: _callDuration,
          isMuted: _voiceCallService.isMuted,
          onToggleMute: _toggleMute,
          onEndCall: _endCall,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildReadReceipt(Map<String, dynamic> msg) {
    final status = msg['status'] ?? 'sent';
    final isRead = msg['is_read'] == true;

    if (isRead || status == 'read') {
      // Double blue checkmarks - read
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.done_all, size: 14, color: Colors.lightBlueAccent),
        ],
      );
    } else if (status == 'delivered') {
      // Double gray checkmarks - delivered
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.done_all, size: 14, color: Colors.white.withValues(alpha: 0.7)),
        ],
      );
    } else {
      // Single checkmark - sent
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.done, size: 14, color: Colors.white.withValues(alpha: 0.7)),
        ],
      );
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatTime(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final messageDate = DateTime(date.year, date.month, date.day);

      if (messageDate == today) {
        return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      } else {
        return '${date.day}.${date.month}. ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      }
    } catch (e) {
      return '';
    }
  }

  String _formatLastSeen() {
    final l = AppLocalizations.of(context)!;
    if (_supportLastSeenSeconds == null) {
      return l.supportOffline;
    }

    final seconds = _supportLastSeenSeconds!;

    if (seconds < 60) {
      return l.lastSeenSeconds;
    } else if (seconds < 3600) {
      final minutes = (seconds / 60).floor();
      return l.lastSeenMinutes(minutes);
    } else if (seconds < 86400) {
      final hours = (seconds / 3600).floor();
      return l.lastSeenHours(hours);
    } else {
      final days = (seconds / 86400).floor();
      return l.lastSeenDays(days);
    }
  }
}
