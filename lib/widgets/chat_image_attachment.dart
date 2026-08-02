import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../services/api_service.dart';
import '../services/logger_service.dart';

/// Bild-Anhänge als Vorschau statt als Dateizeile.
///
/// Vorher endete jeder Anhang als Icon plus Dateiname — auch ein Foto, das
/// man in einer Sekunde hätte erkennen können. Tippen öffnet das Bild groß.
///
/// Die Bytes kommen über denselben authentifizierten `chat/download.php`
/// wie der Speichern-Knopf; die Dateien liegen nicht offen im Webroot.
class ChatImageAttachment extends StatefulWidget {
  const ChatImageAttachment({
    super.key,
    required this.attachment,
    required this.mitgliedernummer,
    this.maxWidth = 220,
    this.maxHeight = 220,
  });

  final Map<String, dynamic> attachment;
  final String mitgliedernummer;
  final double maxWidth;
  final double maxHeight;

  static const Set<String> imageExtensions = {'png', 'jpg', 'jpeg'};

  static bool isImage(Map<String, dynamic> attachment) {
    final ext = (attachment['extension'] ?? '').toString().toLowerCase();
    return imageExtensions.contains(ext);
  }

  @override
  State<ChatImageAttachment> createState() => _ChatImageAttachmentState();
}

class _ChatImageAttachmentState extends State<ChatImageAttachment> {
  static final _log = LoggerService();
  static final _api = ApiService();

  /// Ein Chatverlauf wird beim Scrollen ständig neu gebaut. Ohne Cache
  /// lädt jedes Bild bei jedem Rebuild erneut vom Server.
  static final Map<int, Uint8List> _cache = {};
  static final Map<int, Future<Uint8List?>> _inFlight = {};
  static const int _cacheLimit = 40;

  Uint8List? _bytes;
  bool _failed = false;

  int? get _id {
    final raw = widget.attachment['id'];
    if (raw is int) return raw;
    return int.tryParse(raw?.toString() ?? '');
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = _id;
    if (id == null) {
      setState(() => _failed = true);
      return;
    }

    final cached = _cache[id];
    if (cached != null) {
      setState(() => _bytes = cached);
      return;
    }

    final bytes = await (_inFlight[id] ??= _fetch(id));
    if (!mounted) return;
    setState(() {
      _bytes = bytes;
      _failed = bytes == null;
    });
  }

  Future<Uint8List?> _fetch(int id) async {
    try {
      final result = await _api.downloadChatAttachment(
        attachmentId: id,
        mitgliedernummer: widget.mitgliedernummer,
      );
      if (result['success'] != true) return null;

      final data = result['data']?['file_data'] ?? result['content'];
      if (data == null) return null;

      final bytes = base64Decode(data.toString());
      if (_cache.length >= _cacheLimit) {
        _cache.remove(_cache.keys.first);
      }
      _cache[id] = bytes;
      return bytes;
    } catch (e) {
      _log.warning('ChatImage: Vorschau fehlgeschlagen ($id): $e', tag: 'CHAT');
      return null;
    } finally {
      _inFlight.remove(id);
    }
  }

  void _openFullscreen() {
    final bytes = _bytes;
    if (bytes == null) return;
    final name = (widget.attachment['filename'] ?? 'Bild').toString();
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _FullscreenImage(bytes: bytes, title: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      // Kein Ersatz-Icon erfinden — der Aufrufer zeigt dann die Dateizeile.
      return const SizedBox.shrink();
    }

    final bytes = _bytes;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: bytes == null
            ? Container(
                width: widget.maxWidth,
                height: 120,
                color: Colors.black12,
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : GestureDetector(
                onTap: _openFullscreen,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: widget.maxWidth,
                    maxHeight: widget.maxHeight,
                  ),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
      ),
    );
  }
}

class _FullscreenImage extends StatelessWidget {
  const _FullscreenImage({required this.bytes, required this.title});

  final Uint8List bytes;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title, style: const TextStyle(fontSize: 15)),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 5,
          child: Image.memory(bytes),
        ),
      ),
    );
  }
}
