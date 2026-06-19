import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_client_factory.dart';
import 'language_service.dart';
import 'logger_service.dart';

/// Result of a successful POST to /api/public/anonymous_chat/init.php.
class AnonymousChatSession {
  /// Ghost user's mitgliedernummer ("ANON_<8 hex>"). Same value the
  /// WebSocket auth handler expects in the `auth` frame.
  final String mitgliedernummer;

  /// Display name returned by the server ("Anonim #ABCD"). Used in the
  /// header of the chat screen so the visitor sees the identity the
  /// Vorstand also sees on their end.
  final String name;

  /// JWT — optional on the WS side (the server falls back to
  /// "legacy client" auth), but we pass it through anyway when we
  /// extend ChatService later to thread it on the auth frame.
  final String token;

  /// chat_conversations.id — joined after the WS auth completes so the
  /// message stream knows which thread to listen on.
  final int conversationId;

  const AnonymousChatSession({
    required this.mitgliedernummer,
    required this.name,
    required this.token,
    required this.conversationId,
  });
}

/// Manages the per-install anonymous_id and exchanges it for a chat
/// session via /api/public/anonymous_chat/init.php. Singleton — the id
/// must be stable across screens so a visitor returning to the chat
/// surface gets the same conversation thread.
class AnonymousChatService {
  static const String _initUrl =
      'https://icd360sev.icd360s.de/api/public/anonymous_chat/init.php';
  static const String _sendUrl =
      'https://icd360sev.icd360s.de/api/public/anonymous_chat/send.php';
  static const String _messagesUrl =
      'https://icd360sev.icd360s.de/api/public/anonymous_chat/messages.php';
  static const String _idKey = 'anonymous_chat_id';
  static const String _firstOpenKey = 'anonymous_chat_first_open_at';

  String? _cachedId;
  late http.Client _client;
  final _log = LoggerService();

  static final AnonymousChatService _instance =
      AnonymousChatService._internal();
  factory AnonymousChatService() => _instance;
  AnonymousChatService._internal() {
    // Reuse the pinned HTTP client — TLS interception detection is the
    // same security property we want for every API call, anonymous or
    // not.
    _client = IOClient(HttpClientFactory.createPinnedHttpClient());
  }

  /// Returns the persistent anonymous_id, generating it on first call.
  /// 16 random bytes → 32 hex chars; survives logout but resets on a
  /// fresh install. SharedPreferences key: [_idKey].
  Future<String> ensureId() async {
    if (_cachedId != null) return _cachedId!;
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_idKey);
    if (id == null || id.length < 16) {
      final rng = Random.secure();
      final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
      id = bytes
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join();
      await prefs.setString(_idKey, id);
    }
    _cachedId = id;
    // Also remember "first open" the first time we set up an
    // anonymous_id — useful metadata for the Vorstand to know whether
    // they're talking to a brand-new visitor or a returning one.
    if (!prefs.containsKey(_firstOpenKey)) {
      await prefs.setString(
        _firstOpenKey,
        DateTime.now().toUtc().toIso8601String(),
      );
    }
    return id;
  }

  /// POSTs the init payload and returns the session details. On failure
  /// (network / 5xx / decode error) returns null; the caller should
  /// fall back to "couldn't connect, please write a report or call".
  Future<AnonymousChatSession?> startSession() async {
    try {
      final id = await ensureId();
      final prefs = await SharedPreferences.getInstance();
      final firstOpen = prefs.getString(_firstOpenKey);

      // App version + OS — the server stores these in
      // anonymous_chat_users so the Vorstand can see "Linux v1.20.0"
      // on the visitor card without us having to plumb a separate
      // diagnostic call.
      final info = await PackageInfo.fromPlatform();

      final body = <String, dynamic>{
        'anonymous_id': id,
        'language': LanguageService.instance.currentCode,
        'platform': Platform.operatingSystem,
        'app_version': info.version,
      };
      if (firstOpen != null) body['first_open_at'] = firstOpen;

      final response = await _client
          .post(
            Uri.parse(_initUrl),
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'ICD360S-Mitglied/1.0',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        _log.error(
          'anonymous chat init HTTP ${response.statusCode}',
          tag: 'AnonChat',
        );
        return null;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['success'] != true) {
        _log.error(
          'anonymous chat init failed: ${data['message']}',
          tag: 'AnonChat',
        );
        return null;
      }

      return AnonymousChatSession(
        mitgliedernummer: data['mitgliedernummer'] as String,
        name: data['name'] as String,
        token: data['token'] as String,
        conversationId: data['conversation_id'] as int,
      );
    } catch (e) {
      _log.error('$e', tag: 'AnonChat');
      return null;
    }
  }

  /// Persist a visitor message via the public send endpoint. The HTTP
  /// path is the source of truth — WebSocket gets a realtime push as a
  /// side-effect via WebSocketNotifier — so polling fetchMessages() can
  /// always catch up if the WS dropped.
  Future<int?> sendMessage({
    required int conversationId,
    required String text,
  }) async {
    try {
      final id = await ensureId();
      final response = await _client
          .post(
            Uri.parse(_sendUrl),
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'ICD360S-Mitglied/1.0',
            },
            body: jsonEncode({
              'anonymous_id': id,
              'conversation_id': conversationId,
              'message': text,
            }),
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          return (data['message_id'] as num?)?.toInt();
        }
      }
      _log.error(
        'sendMessage HTTP ${response.statusCode}: ${response.body}',
        tag: 'AnonChat',
      );
    } catch (e) {
      _log.error('sendMessage: $e', tag: 'AnonChat');
    }
    return null;
  }

  /// Poll for new messages newer than [lastMessageId]. Returns the raw
  /// item list verbatim so the caller can decide how to merge with
  /// whatever it already has from the WebSocket stream — typical merge
  /// is keyed off `id` to drop duplicates.
  Future<List<Map<String, dynamic>>> fetchMessages({
    required int conversationId,
    int lastMessageId = 0,
  }) async {
    try {
      final id = await ensureId();
      final response = await _client
          .post(
            Uri.parse(_messagesUrl),
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'ICD360S-Mitglied/1.0',
            },
            body: jsonEncode({
              'anonymous_id': id,
              'conversation_id': conversationId,
              'last_message_id': lastMessageId,
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return const [];
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['success'] != true) return const [];
      final items = data['items'] as List<dynamic>? ?? const [];
      return items
          .whereType<Map<String, dynamic>>()
          .toList(growable: false);
    } catch (e) {
      _log.error('fetchMessages: $e', tag: 'AnonChat');
      return const [];
    }
  }
}
