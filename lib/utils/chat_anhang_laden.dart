import 'dart:convert';
import 'dart:typed_data';

/// Name und Inhalt eines Chat-Anhangs aus der Antwort von
/// `chat/download.php`.
///
/// Bis 5 MB steht der Inhalt als Base64 in der Antwort, darüber nur eine
/// `download_url` auf `chat/stream.php`, von der [streamLaden] die rohen
/// Bytes holt. Die App kannte bis hierher nur den ersten Weg: ein größerer
/// Anhang — etwa ein mehrseitiger Scan vom Vorstand — ließ sich weder öffnen
/// noch speichern („Datei konnte nicht geladen werden").
///
/// `null`, wenn die Antwort keinen Namen oder weder Inhalt noch Adresse
/// trägt, oder wenn [streamLaden] nichts liefert.
Future<({Uint8List bytes, String dateiname})?> chatAnhangAusAntwort(
  Map<String, dynamic> antwort, {
  required Future<Uint8List?> Function(String url) streamLaden,
}) async {
  // Der Server mischt die Felder per array_merge auf die oberste Ebene;
  // `data` bleibt als älteres Format. Ein leeres PHP-Array kommt dort als
  // Liste an, nicht als Map.
  final data = antwort['data'] is Map ? antwort['data'] as Map : const {};
  final name = antwort['filename'] ?? data['filename'];
  final inhalt = antwort['content'] ?? data['content'] ?? data['file_data'];
  final url = antwort['download_url'] ?? data['download_url'];
  if (name == null) return null;

  final Uint8List? bytes;
  if (inhalt != null) {
    bytes = base64Decode(inhalt.toString());
  } else if (url != null) {
    bytes = await streamLaden(url.toString());
  } else {
    bytes = null;
  }
  return bytes == null ? null : (bytes: bytes, dateiname: name.toString());
}
