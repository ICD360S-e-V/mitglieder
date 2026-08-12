/// Führt die vom Server geladene Nachrichtenliste in die bereits angezeigte ein.
///
/// ⚠️ **Warum es diese Funktion gibt.** Die frühere Fassung stand wörtlich so
/// in drei Chat-Dialogen:
///
/// ```dart
/// final existingIds = _messages.map((m) => m['id']).toSet();
/// for (var msg in newMessages) {
///   if (!existingIds.contains(msg['id'])) _messages.add(msg);   // sonst: nichts
/// }
/// ```
///
/// Sie übersprang jede Nachricht, deren `id` schon in der Liste stand — mit der
/// Absicht, Doppelungen zu vermeiden. Die Folge war, dass eine **bestehende**
/// Nachricht sich nie mehr ändern konnte. Eine Reaktion ist aber genau das:
/// eine Änderung an einer Nachricht, die es längst gibt. Neu laden half nicht,
/// weil das Neuladen die Nachricht ja als „schon bekannt" durchwinkte.
///
/// Damit blieb genau ein Weg, auf dem eine Reaktion je ankam: das
/// WebSocket-Ereignis, und zwar nur, wenn die Gegenseite in derselben Sekunde
/// denselben Chat offen und beigetreten hatte. Wer den Takt verpasste — App im
/// Hintergrund, WebSocket getrennt, anderer Chat offen —, sah die Reaktion
/// **nie**, obwohl sie in der Datenbank stand. Das gilt in beide Richtungen und
/// erklärt „Mitglieder reagieren, Vorsitzer sieht nichts, und umgekehrt".
///
/// Nebenbei fror derselbe Fehler auch Lesebestätigung, `read_at`, `expires_at`
/// und `deleted_at` auf dem Stand des ersten Ladens ein.
///
/// **Regeln hier:**
/// - Die Serverliste ist maßgeblich für Bestand und Reihenfolge. Was der Server
///   nicht mehr liefert, ist gelöscht/verfallen und verschwindet — das ist bei
///   diesem Chat mit 5-Minuten-Verfall der gewollte Zustand, kein Datenverlust.
/// - Bekannte Nachrichten werden **an Ort und Stelle** aktualisiert, nicht
///   ersetzt: Der Reaktions-Wähler und der WebSocket-Zuhörer halten eine
///   Referenz auf genau diese `Map` und schreiben optimistisch hinein. Eine
///   frische Map würde diese Schreibvorgänge ins Leere laufen lassen.
/// - `addAll` überschreibt nur Felder, die der Server auch schickt. Rein lokale
///   Felder (`is_urgent`, `channel` aus dem Sende-Pfad) bleiben erhalten.
List<Map<String, dynamic>> chatNachrichtenZusammenfuehren(
  List<Map<String, dynamic>> vorhanden,
  List<Map<String, dynamic>> vomServer,
) {
  if (vorhanden.isEmpty) {
    return List<Map<String, dynamic>>.from(vomServer);
  }

  final nachId = <Object, Map<String, dynamic>>{};
  for (final alt in vorhanden) {
    final id = alt['id'];
    if (id != null) nachId[id] = alt;
  }

  final ergebnis = <Map<String, dynamic>>[];
  for (final neu in vomServer) {
    final id = neu['id'];
    final alt = id == null ? null : nachId[id];
    if (alt == null) {
      ergebnis.add(neu);
    } else {
      alt.addAll(neu);
      ergebnis.add(alt);
    }
  }
  return ergebnis;
}
