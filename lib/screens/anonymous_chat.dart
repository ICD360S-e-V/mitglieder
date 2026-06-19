import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../services/anonymous_chat_service.dart';
import '../services/chat_service.dart';
import '../services/language_service.dart';
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
  // Per-language strings (5 priority locales + English fallback).
  // ---------------------------------------------------------------------------

  static const Map<String, _Strings> _strings = {
    'ro': _Strings(
      title: 'Chat anonim',
      greeting: 'Salut!',
      welcome:
          'Te ascult. Scrie-mi orice — nu am nevoie de numele tău. Răspund de îndată ce sunt aici.',
      hint: 'Scrie un mesaj…',
      waitingOperator: 'Așteptăm ca un operator să răspundă…',
      connecting: 'Mă conectez…',
      connectionFailed: 'Nu am putut deschide chat-ul. Încearcă din nou sau sună-ne.',
      retry: 'Încearcă din nou',
      online: 'Conectat',
      offline: 'Reconectare…',
      adminTyping: 'Operatorul scrie…',
    ),
    'de': _Strings(
      title: 'Anonymer Chat',
      greeting: 'Hallo!',
      welcome:
          'Ich höre dir zu. Schreib alles, was dich bewegt — ich brauche keinen Namen. Ich antworte, sobald ich da bin.',
      hint: 'Nachricht schreiben…',
      waitingOperator: 'Wir warten, bis ein Mitarbeiter antwortet…',
      connecting: 'Verbinde…',
      connectionFailed: 'Chat konnte nicht geöffnet werden. Versuch erneut oder ruf an.',
      retry: 'Erneut versuchen',
      online: 'Verbunden',
      offline: 'Wiederverbindung…',
      adminTyping: 'Mitarbeiter schreibt…',
    ),
    'en': _Strings(
      title: 'Anonymous chat',
      greeting: 'Hi!',
      welcome:
          "I'm listening. Write anything you'd like — no name needed. I'll reply as soon as I'm in.",
      hint: 'Write a message…',
      waitingOperator: 'Waiting for an operator to reply…',
      connecting: 'Connecting…',
      connectionFailed: "Couldn't open the chat. Try again or call us.",
      retry: 'Try again',
      online: 'Connected',
      offline: 'Reconnecting…',
      adminTyping: 'Operator is typing…',
    ),
    'ru': _Strings(
      title: 'Анонимный чат',
      greeting: 'Привет!',
      welcome:
          'Я слушаю. Пиши что угодно — имя не нужно. Отвечу, как только буду на связи.',
      hint: 'Написать сообщение…',
      waitingOperator: 'Ждём ответа оператора…',
      connecting: 'Подключаюсь…',
      connectionFailed: 'Не удалось открыть чат. Попробуй ещё раз или позвони.',
      retry: 'Попробовать снова',
      online: 'Подключено',
      offline: 'Переподключение…',
      adminTyping: 'Оператор печатает…',
    ),
    'uk': _Strings(
      title: 'Анонімний чат',
      greeting: 'Привіт!',
      welcome:
          'Я слухаю. Пиши що завгодно — імʼя не потрібне. Відповім, щойно буду на звʼязку.',
      hint: 'Написати повідомлення…',
      waitingOperator: 'Чекаємо на відповідь оператора…',
      connecting: 'Підключаюсь…',
      connectionFailed: 'Не вдалося відкрити чат. Спробуй ще раз або зателефонуй.',
      retry: 'Спробувати ще раз',
      online: 'Підключено',
      offline: 'Перепідключення…',
      adminTyping: 'Оператор пише…',
    ),
  };

  static _Strings _stringsFor(String code) =>
      _strings[code] ?? _strings['en']!;

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
    final s = _stringsFor(LanguageService.instance.currentCode);
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
              _header(s),
              if (_failed)
                Expanded(child: _errorView(s))
              else if (_connecting)
                Expanded(child: _loadingView(s))
              else
                Expanded(child: _chatView(s)),
              if (!_failed && !_connecting) _inputBar(s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(_Strings s) {
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
                  s.title,
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
                      _wsConnected ? s.online : s.offline,
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

  Widget _loadingView(_Strings s) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 16),
          Text(
            s.connecting,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorView(_Strings s) {
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
            s.connectionFailed,
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
            label: Text(s.retry),
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

  Widget _chatView(_Strings s) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            children: [
              _claudiuWelcome(s),
              if (_messages.isEmpty) ...[
                const SizedBox(height: 24),
                _waitingNote(s),
              ] else ...[
                const SizedBox(height: 18),
                for (final m in _messages) _messageBubble(m),
              ],
              if (_adminTyping) ...[
                const SizedBox(height: 8),
                _typingIndicator(s),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _claudiuWelcome(_Strings s) {
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.greeting,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0d47a1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s.welcome,
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

  Widget _waitingNote(_Strings s) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              s.waitingOperator,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _typingIndicator(_Strings s) {
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
            s.adminTyping,
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

  Widget _inputBar(_Strings s) {
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
                hintText: s.hint,
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

class _Strings {
  final String title;
  final String greeting;
  final String welcome;
  final String hint;
  final String waitingOperator;
  final String connecting;
  final String connectionFailed;
  final String retry;
  final String online;
  final String offline;
  final String adminTyping;

  const _Strings({
    required this.title,
    required this.greeting,
    required this.welcome,
    required this.hint,
    required this.waitingOperator,
    required this.connecting,
    required this.connectionFailed,
    required this.retry,
    required this.online,
    required this.offline,
    required this.adminTyping,
  });
}
