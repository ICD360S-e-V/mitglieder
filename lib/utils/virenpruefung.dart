/// Virenprüfung an Chat-Anhängen: `virengeprueft_am` kommt aus
/// chat/messages.php als MySQL-Datetime (Berliner Ortszeit), gesetzt, wenn
/// clamd die Datei beim Hochladen als sauber gemeldet hat. NULL = nicht
/// geprüft. Keine Zeitzonen-Umrechnung — es wird nur das Datum gezeigt.

bool virengeprueft(dynamic am) => virenpruefungDatum(am) != null;

/// „07.09.2026" oder null.
String? virenpruefungDatum(dynamic am) {
  final s = am?.toString().trim();
  if (s == null || s.isEmpty) return null;
  final t = DateTime.tryParse(s);
  if (t == null) return null;
  return '${t.day.toString().padLeft(2, '0')}.${t.month.toString().padLeft(2, '0')}.${t.year}';
}
