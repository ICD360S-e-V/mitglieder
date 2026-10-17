import 'dart:convert';
import 'dart:io';

/// Was die App ins Protokoll schreibt, wenn das Hochladen von Chat-Anhängen
/// scheitert — OHNE Dateinamen.
///
/// WARUM: App-Fehler #136 (17.10.2026, 22:43–22:51) — fünfmal HTTP 400 auf
/// `chat/upload.php`, und die App schrieb NICHTS dazu. Der Grund liess sich
/// nur aus der Länge der Antwort im nginx-Protokoll erraten (103 Byte passten
/// allein zu „Upload error for file: …“). Mit dieser Zeile steht er da.
///
/// ⚠️ KEIN DATEINAME, KEIN INHALT. Einige Meldungen von `chat/upload.php`
/// nennen den Namen der Datei („Upload error for file: Bescheid_….pdf“), und
/// ein Dateiname ist oft selbst ein Personendatum. Er wird deshalb ersetzt —
/// zweimal: über die bekannten Meldungsformen von upload.php UND über die
/// Namen der gesendeten Dateien, falls der Server einmal anders formuliert.
/// Die Endung bleibt („File type not allowed: heic …“): sie verrät nichts
/// über die Person und ist genau das, was man zum Verstehen braucht.

/// Steht im Protokoll, wo ein Dateiname oder Pfad stand.
const String kDateiPlatzhalter = '«Datei»';

/// Meldungsformen in `api/chat/upload.php`, HINTER denen der Dateiname steht
/// (der Server hängt ihn jeweils ans Ende).
const List<String> kUploadMeldungenMitNamen = [
  'Upload error for file: ',
  'Failed to save file: ',
  'Failed to store file securely: ',
  'Virus/Malware erkannt in ',
];

const int _meldungHoechstens = 200;
const int _ausnahmeHoechstens = 300;

/// Der Name einer Datei aus ihrem Pfad — `/` wie `\` (die App läuft auch
/// unter Windows).
String chatUploadDateiname(String pfad) {
  final i = pfad.lastIndexOf(RegExp(r'[/\\]'));
  return i < 0 ? pfad : pfad.substring(i + 1);
}

/// Die Endung (klein, ohne Punkt) oder `''`.
String _endung(String dateiname) {
  final i = dateiname.lastIndexOf('.');
  return i <= 0 || i == dateiname.length - 1
      ? ''
      : dateiname.substring(i + 1).toLowerCase();
}

String _kuerzen(String s, int hoechstens) =>
    s.length <= hoechstens ? s : '${s.substring(0, hoechstens)}…';

/// Ersetzt jedes Vorkommen der [teile] (längste zuerst, damit kein Rest
/// eines längeren Namens stehen bleibt).
String _ersetzen(String text, Iterable<String> teile) {
  final sortiert = teile.where((t) => t.length >= 3).toSet().toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  var t = text;
  for (final teil in sortiert) {
    t = t.replaceAll(teil, kDateiPlatzhalter);
  }
  return t;
}

/// Die Meldung des Servers ohne Dateinamen, höchstens 200 Zeichen.
String chatUploadMeldungOhneNamen(String meldung, Iterable<String> dateinamen) {
  var m = meldung;
  for (final vor in kUploadMeldungenMitNamen) {
    final i = m.indexOf(vor);
    if (i >= 0) {
      m = '${m.substring(0, i + vor.length)}$kDateiPlatzhalter';
    }
  }
  return _kuerzen(_ersetzen(m, dateinamen), _meldungHoechstens);
}

/// Der Grund aus der Antwort von `chat/upload.php`, ohne Dateinamen.
///
/// ⚠️ Eine Antwort, die kein JSON ist (nginx-Fehlerseite bei 413 oder 502),
/// geht NIE roh ins Protokoll — nur ihre Länge.
String chatUploadGrundAusAntwort(String antwort, Iterable<String> dateinamen) {
  final Object? j;
  try {
    j = jsonDecode(antwort);
  } on FormatException {
    return 'Antwort ohne JSON (${antwort.length} Zeichen)';
  }
  if (j is Map) {
    final meldung = j['message'] ?? j['error'];
    if (meldung != null) {
      return chatUploadMeldungOhneNamen(meldung.toString(), dateinamen);
    }
  }
  return 'Antwort ohne Meldung';
}

/// Pfade unter den Speicherorten, aus denen Anhänge kommen (Android, Windows,
/// Linux, macOS) — in `/home/<name>/` steckt auch der Name der Person.
final RegExp _pfad = RegExp(
  r'''(?:/(?:data|storage|sdcard|mnt|tmp|var|home|Users)/|[A-Za-z]:\\)[^'"\s)]*''',
);

/// Dateinamen mit einer Endung, die `chat/upload.php` annimmt.
final RegExp _dateiname = RegExp(
  r'''[^\s'"/\\:]+\.(?:pdf|png|jpe?g|txt)\b''',
  caseSensitive: false,
);

/// Der Text einer Ausnahme beim Hochladen ohne Pfade und Dateinamen,
/// höchstens 300 Zeichen. `PathNotFoundException` nennt den vollen Pfad.
String chatUploadAusnahmeOhneNamen(Object fehler, Iterable<String> pfade) {
  final namen = [for (final p in pfade) chatUploadDateiname(p)];
  var t = _ersetzen(fehler.toString(), [...pfade, ...namen]);
  t = t
      .replaceAll(_pfad, kDateiPlatzhalter)
      .replaceAll(_dateiname, kDateiPlatzhalter);
  return _kuerzen(t, _ausnahmeHoechstens);
}

/// Die Gesamtgröße der Dateien in Byte, `-1`, wenn eine nicht lesbar ist.
int chatUploadGroesse(Iterable<File> dateien) {
  var summe = 0;
  for (final d in dateien) {
    try {
      summe += d.lengthSync();
    } on FileSystemException {
      return -1;
    }
  }
  return summe;
}

/// Die eine Zeile fürs Protokoll, z. B. mit `was: 'abgelehnt, HTTP 400'`:
/// `Chat-Upload abgelehnt, HTTP 400 · „Upload error for file: «Datei»“ · 1 Datei(en), 2.4 MB · pdf`.
String chatUploadProtokollZeile({
  required String was,
  required String grund,
  required int anzahl,
  required int bytes,
  required Iterable<String> dateinamen,
}) {
  final endungen = {for (final n in dateinamen) _endung(n)}..remove('');
  final groesse =
      bytes < 0 ? '? MB' : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  final liste = endungen.isEmpty ? '–' : (endungen.toList()..sort()).join(', ');
  return 'Chat-Upload $was · „$grund“ · $anzahl Datei(en), $groesse · $liste';
}
