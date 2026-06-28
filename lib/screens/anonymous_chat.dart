import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../l10n/app_localizations.dart';
import '../services/anonymous_chat_service.dart';
import '../services/chat_service.dart';
import '../widgets/icd360s_header.dart';

/// Live anonymous chat surface — visitor side. Hits
/// /api/public/anonymous_chat/init.php for a ghost user + JWT, then
/// connects through the existing [ChatService] WebSocket. The auth
/// path, the translator, read receipts and the 5-minute TTL on read
/// messages all keep working because, on the server, the ghost user
/// is a row in the `users` table with is_anonymous = 1.
class AnonymousChatScreen extends StatefulWidget {
  const AnonymousChatScreen({super.key});

  @override
  State<AnonymousChatScreen> createState() => _AnonymousChatScreenState();
}

class _AnonymousChatScreenState extends State<AnonymousChatScreen> {
  final _chatService = ChatService();
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  AnonymousChatSession? _session;
  final List<ChatMessage> _messages = [];

  /// Highest chat_messages.id we have locally — used to ask the polling
  /// endpoint only for newer rows.
  int _lastMessageId = 0;

  bool _connecting = true;
  bool _failed = false;
  bool _wsConnected = false;
  bool _adminTyping = false;
  bool _sending = false;

  StreamSubscription<ChatMessage>? _messageSub;
  StreamSubscription<bool>? _connectionSub;
  StreamSubscription<TypingEvent>? _typingSub;
  Timer? _typingResetTimer;
  Timer? _pollTimer;


  // ---------------------------------------------------------------------------
  // Lifecycle.
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() {
      _connecting = true;
      _failed = false;
    });

    final session = await AnonymousChatService().startSession();
    if (!mounted) return;
    if (session == null) {
      setState(() {
        _connecting = false;
        _failed = true;
      });
      return;
    }
    setState(() => _session = session);

    // Subscribe to the WebSocket streams. Realtime is the happy path
    // but the screen is wired so HTTP send + polling stay authoritative
    // even if the socket drops mid-conversation.
    _messageSub = _chatService.messageStream.listen((msg) {
      if (msg.conversationId != session.conversationId) return;
      _mergeMessage(msg);
    });

    _connectionSub = _chatService.connectionStream.listen((connected) {
      if (!mounted) return;
      setState(() => _wsConnected = connected);
    });

    _typingSub = _chatService.typingStream.listen((event) {
      if (!mounted || !event.isAdmin) return;
      setState(() => _adminTyping = true);
      _typingResetTimer?.cancel();
      _typingResetTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) setState(() => _adminTyping = false);
      });
    });

    // Load conversation history before attempting WS — if the visitor
    // is returning, they see prior messages immediately even if the
    // socket takes time (or fails).
    await _pollOnce();

    // Background polling — 3 s cadence is fine for an interactive chat
    // and keeps the visitor up-to-date when the WS isn't delivering.
    _pollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _pollOnce(),
    );

    if (!mounted) return;
    setState(() {
      _connecting = false;
    });

    // Fire-and-forget the WS connection. Failure here only disables the
    // pretty "Online" indicator — HTTP polling above keeps the chat
    // working.
    final ok = await _chatService.connect(session.mitgliedernummer);
    if (!mounted) return;
    if (ok) {
      _chatService.joinConversation(session.conversationId);
      setState(() => _wsConnected = true);
    }
  }

  /// Poll once and merge any new messages into the local list.
  Future<void> _pollOnce() async {
    final session = _session;
    if (session == null) return;
    final items = await AnonymousChatService().fetchMessages(
      conversationId: session.conversationId,
      lastMessageId: _lastMessageId,
    );
    if (!mounted || items.isEmpty) return;
    for (final item in items) {
      _mergeMessage(ChatMessage(
        id: (item['id'] as num).toInt(),
        conversationId: session.conversationId,
        senderId: (item['sender_id'] as num).toInt(),
        senderName: (item['sender_name'] as String?) ?? '',
        senderRole: (item['sender_role'] as String?) ?? '',
        isAdmin: item['is_admin'] == true,
        message: (item['message'] as String?) ?? '',
        createdAt: DateTime.tryParse((item['created_at'] as String?) ?? '') ??
            DateTime.now(),
      ));
    }
  }

  /// Append a message and keep the local id watermark up to date.
  /// Duplicates are dropped — the WS and the poll can both deliver the
  /// same row and we want it to appear once.
  void _mergeMessage(ChatMessage msg) {
    if (msg.id != 0 && _messages.any((m) => m.id == msg.id)) return;
    setState(() {
      _messages.add(msg);
      if (msg.id > _lastMessageId) _lastMessageId = msg.id;
      if (msg.isAdmin) _adminTyping = false;
    });
    _scrollToBottom();
  }

  Future<void> _send() async {
    final text = _inputController.text.trim();
    final session = _session;
    if (text.isEmpty || session == null || _sending) return;

    // Clear the input optimistically — feels snappy even on slow links.
    _inputController.clear();
    setState(() => _sending = true);

    final messageId = await AnonymousChatService().sendMessage(
      conversationId: session.conversationId,
      text: text,
    );

    if (!mounted) return;
    if (messageId == null) {
      // Stuff the text back so the visitor can retry without retyping.
      _inputController.text = text;
      setState(() => _sending = false);
      return;
    }

    // Pull the freshly-saved row down so it shows up immediately —
    // saves us from waiting on the WS push when the socket is slow or
    // hasn't reconnected yet.
    await _pollOnce();
    if (!mounted) return;
    setState(() => _sending = false);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _typingResetTimer?.cancel();
    _pollTimer?.cancel();
    _messageSub?.cancel();
    _connectionSub?.cancel();
    _typingSub?.cancel();
    if (_session != null) {
      _chatService.leaveConversation(_session!.conversationId);
    }
    _chatService.disconnect();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Build.
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0d47a1),
              Color(0xFF1565c0),
              Color(0xFF1976d2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _header(l10n),
              if (_failed)
                Expanded(child: _errorView(l10n))
              else if (_connecting)
                Expanded(child: _loadingView(l10n))
              else
                Expanded(child: _chatView(l10n)),
              if (!_failed && !_connecting) _inputBar(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.claudiuAnonymousChatTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _wsConnected
                            ? const Color(0xFF81C784)
                            : const Color(0xFFFFB74D),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _wsConnected
                          ? l10n.claudiuAnonymousChatOnline
                          : l10n.claudiuAnonymousChatOffline,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 11.5,
                      ),
                    ),
                    if (_session != null) ...[
                      const SizedBox(width: 10),
                      Text(
                        _session!.name,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 11.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _loadingView(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 16),
          Text(
            l10n.claudiuAnonymousChatConnecting,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorView(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icd360sHeader(compact: true),
          const SizedBox(height: 20),
          Icon(Icons.cloud_off, color: Colors.amber.shade200, size: 56),
          const SizedBox(height: 16),
          Text(
            l10n.claudiuAnonymousChatConnectionFailed,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _bootstrap,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.claudiuAnonymousChatRetry),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.18),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(
                color: Colors.white.withValues(alpha: 0.45),
                width: 1.5,
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatView(AppLocalizations l10n) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            children: [
              _claudiuWelcome(l10n),
              if (_messages.isEmpty) ...[
                const SizedBox(height: 12),
                _vorsitzerConnectedGreeting(l10n),
                const SizedBox(height: 14),
                _quickReplyChips(l10n),
              ] else ...[
                const SizedBox(height: 18),
                for (final m in _messages) _messageBubble(m),
              ],
              if (_adminTyping) ...[
                const SizedBox(height: 8),
                _typingIndicator(l10n),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _claudiuWelcome(AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.accessible_forward,
            size: 32,
            color: Colors.white,
          ),
        ).animate().slideX(begin: -0.5, end: 0, duration: 500.ms).fadeIn(),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(4),
                topEnd: Radius.circular(12),
                bottomStart: Radius.circular(12),
                bottomEnd: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.claudiuAnonymousChatGreeting,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0d47a1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.claudiuAnonymousChatWelcome,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '— Claudiu',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
        ),
      ],
    );
  }

  /// Second welcome bubble shown right after Claudiu's hello. Frames
  /// the visitor as "already connected with a Vorsitzer" so they
  /// don't feel parked in a queue. Renders identically to an admin
  /// message bubble for visual continuity with replies that follow.
  Widget _vorsitzerConnectedGreeting(AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.45),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.support_agent,
            size: 30,
            color: Colors.white,
          ),
        )
            .animate(delay: 600.ms)
            .slideX(begin: -0.5, end: 0, duration: 500.ms)
            .fadeIn(),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(4),
                topEnd: Radius.circular(12),
                bottomStart: Radius.circular(12),
                bottomEnd: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.claudiuVorsitzerConnectedTitle,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0d47a1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.claudiuVorsitzerConnectedBody,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[800],
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '— ${l10n.claudiuVorsitzerConnectedSender}',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ).animate(delay: 750.ms).fadeIn(duration: 400.ms),
        ),
      ],
    );
  }

  /// Tappable suggestion chips for the most common opening questions.
  /// Tapping a chip auto-sends the matching message, so the visitor
  /// goes from "blank chat" to "first message sent" in one tap.
  Widget _quickReplyChips(AppLocalizations l10n) {
    final suggestions = <String>[
      l10n.claudiuQuickReplyValidationTime,
      l10n.claudiuQuickReplyDocuments,
      l10n.claudiuQuickReplyStepProblem,
      l10n.claudiuQuickReplyHuman,
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 66),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (var i = 0; i < suggestions.length; i++)
            _quickReplyChip(suggestions[i], delay: 950 + i * 120),
        ],
      ),
    );
  }

  Widget _quickReplyChip(String label, {required int delay}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _sending ? null : () => _sendQuickReply(label),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      )
          .animate(delay: delay.ms)
          .slideY(begin: 0.3, end: 0, duration: 350.ms)
          .fadeIn(),
    );
  }

  /// Send a prefab message in one tap. Reuses the same path as the
  /// text field so the WS push, optimistic update and scroll-to-bottom
  /// behave identically to a typed message.
  Future<void> _sendQuickReply(String text) async {
    if (_sending) return;
    _inputController.text = text;
    await _send();
  }

  Widget _messageBubble(ChatMessage m) {
    final mine = !m.isAdmin;
    final align = mine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bg = mine ? const Color(0xFF1565c0) : Colors.white;
    final fg = mine ? Colors.white : const Color(0xFF0d47a1);
    final borderColor = mine
        ? Colors.white.withValues(alpha: 0.35)
        : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: align,
        children: [
          if (!mine && m.senderName.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 2),
              child: Text(
                m.senderName,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: Radius.circular(mine ? 14 : 4),
                  bottomRight: Radius.circular(mine ? 4 : 14),
                ),
                border: Border.all(color: borderColor),
              ),
              child: Text(
                m.message,
                style: TextStyle(color: fg, fontSize: 14, height: 1.35),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 6, right: 6),
            child: Text(
              _formatTime(m.createdAt),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typingIndicator(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: EdgeInsets.only(right: i < 2 ? 4 : 0),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1565c0),
                        shape: BoxShape.circle,
                      ),
                    ).animate(
                          onPlay: (c) => c.repeat(reverse: true),
                          delay: (200 * i).ms,
                        ).fadeIn(duration: 500.ms).fadeOut(duration: 500.ms),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            l10n.claudiuAnonymousChatAdminTyping,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputBar(AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12 + MediaQuery.of(context).viewInsets.bottom * 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              minLines: 1,
              maxLines: 4,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: l10n.claudiuAnonymousChatHint,
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
              ),
              enabled: !_sending,
              onChanged: (_) {
                // Best-effort typing indicator. Quietly skipped if the
                // socket isn't up — HTTP send still works.
                if (_session != null && _wsConnected) {
                  _chatService.sendTyping(_session!.conversationId);
                }
              },
              onSubmitted: (_) => _send(),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.white.withValues(alpha: 0.16),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: _sending ? null : _send,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _sending
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.4,
                        ),
                      )
                    : const Icon(Icons.send, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

