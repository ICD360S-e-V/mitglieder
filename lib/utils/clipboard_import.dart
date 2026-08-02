import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pasteboard/pasteboard.dart';

import '../services/logger_service.dart';

/// Holt Anhänge aus der Systemzwischenablage.
///
/// Flutters eigenes [Clipboard] kennt nur Text (flutter#46418), deshalb
/// `pasteboard`: unter Linux liest das per `gtk_clipboard_request_image()`
/// und liefert PNG-Bytes, unter Windows/macOS das jeweilige Pendant.
///
/// Zwei Fälle, in dieser Reihenfolge:
///  1. rohe Bilddaten — Screenshot, „Bild kopieren" im Browser
///  2. im Dateimanager kopierte Dateien
class ClipboardImport {
  ClipboardImport._();

  static final _log = LoggerService();

  /// Was chat/upload.php serverseitig akzeptiert. Alles andere wäre eine
  /// Fehlermeldung erst nach dem Hochladen — also hier schon aussortieren.
  static const Set<String> allowedExtensions = {'png', 'jpg', 'jpeg', 'pdf', 'txt'};

  /// Serverseitiges Limit aus chat/upload.php.
  static const int maxTotalBytes = 50 * 1024 * 1024;
  static const int maxFiles = 10;

  /// Liest die Zwischenablage. Leere Liste heißt schlicht „nichts Brauchbares
  /// drin" — dann soll der normale Text-Paste ungestört weiterlaufen.
  static Future<List<File>> read() async {
    final image = await _readImage();
    if (image != null) return [image];
    return _readFiles();
  }

  static Future<File?> _readImage() async {
    try {
      final bytes = await Pasteboard.image;
      if (bytes == null || bytes.isEmpty) return null;
      return writeTemp(bytes);
    } catch (e) {
      // Wayland/X11 ohne Bild in der Ablage wirft je nach Toolkit statt
      // null zu liefern — kein Grund, den Paste abzubrechen.
      _log.debug('ClipboardImport: kein Bild in der Ablage ($e)', tag: 'CHAT');
      return null;
    }
  }

  static Future<List<File>> _readFiles() async {
    try {
      final paths = await Pasteboard.files();
      final files = <File>[];
      for (final p in paths) {
        if (files.length >= maxFiles) break;
        final ext = p.split('.').last.toLowerCase();
        if (!allowedExtensions.contains(ext)) continue;
        final f = File(p);
        if (await f.exists()) files.add(f);
      }
      return files;
    } catch (e) {
      _log.debug('ClipboardImport: keine Dateien in der Ablage ($e)', tag: 'CHAT');
      return [];
    }
  }

  /// Was die Tastatur einfügen darf. Deckungsgleich mit `$allowedMimeTypes`
  /// in chat/upload.php — GIF steht dort NICHT drin. Würde man es hier
  /// anbieten, käme die Absage erst nach dem Hochladen; so sagt Gboard
  /// gleich, dass das Feld GIFs nicht nimmt.
  static const List<String> keyboardMimeTypes = ['image/png', 'image/jpeg'];

  /// Legt Bytes als Datei ab, damit der bestehende Upload-Weg sie nehmen kann.
  /// `pasteboard` liefert immer PNG; bei der Tastatur entscheidet der MIME-Typ.
  static Future<File?> writeTemp(Uint8List bytes, [String? mimeType]) async {
    try {
      final dir = await getTemporaryDirectory();
      final ext = mimeType == 'image/jpeg' ? 'jpg' : 'png';
      final name = 'einfuegen_${DateTime.now().millisecondsSinceEpoch}.$ext';
      final file = File('${dir.path}/$name');
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      _log.error('ClipboardImport: Zwischendatei fehlgeschlagen: $e', tag: 'CHAT');
      return null;
    }
  }

  /// Prüft Anzahl und Gesamtgröße. Gibt `null` zurück, wenn alles passt,
  /// sonst den Text für die Fehlermeldung.
  static Future<String?> validate(List<File> files) async {
    if (files.length > maxFiles) return 'Maximal $maxFiles Dateien';
    var total = 0;
    for (final f in files) {
      total += await f.length();
    }
    if (total > maxTotalBytes) {
      return 'Maximale Gesamtgröße: ${maxTotalBytes ~/ (1024 * 1024)} MB';
    }
    return null;
  }
}
