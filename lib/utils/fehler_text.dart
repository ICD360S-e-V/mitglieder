/// Säubert den Text eines Fehlers, bevor er zum Server geht — Kopie aus der
/// Vorsitzer-App (lib/utils/fehler_text.dart dort), dazu Pfade von Windows.
///
/// 🔴 WARUM: Den Wortlaut eines Fehlers schreibt nicht der Entwickler, sondern
/// die Stelle, die ihn wirft — und die nimmt mit, was sie gerade in der Hand
/// hat. `FileSystemException` nennt den Pfad (unter Windows steht darin der
/// Name des Benutzers, `C:\Users\Max Muster\…`), `FormatException` zitiert
/// die Eingabe, eine `HttpException` die ganze Adresse samt Abfrage. Kein
/// Wortlaut, kein Name ins Protokoll — und weil das kein Test an der Quelle
/// prüfen kann, wird an der Mündung gesäubert.
///
/// Was bleibt: Art des Fehlers, Meldung ohne die Daten, Endung einer Datei.
/// Was ersetzt wird:
/// - Dateipfade (`/data/…`, `/storage/…`, `C:\…`) → `<Datei>.pdf` (nur die
///   Endung);
/// - E-Mail-Adressen (auch `sip:…@…`) → `<E-Mail>`;
/// - die Abfrage einer Adresse (`?…`) → `?…`, Pfad und Host bleiben;
/// - lange Ziffernfolgen (Rufnummer, IBAN, Kartennummer) → `<Nummer>`, nur
///   wenn [nummern] (im Stapel stehen Zeilennummern, keine Daten).
///
/// ⚠️ Namen im Fließtext („Mitglied Max Muster nicht gefunden“) erkennt das
/// nicht. Solche Meldungen gehören gar nicht erst in ein `throw`.
String fehlerSaeubern(String text, {int hoechstens = 2000, bool nummern = true}) {
  var s = text
      .replaceAll(_email, '<E-Mail>')
      .replaceAllMapped(_abfrage, (m) => '${m[1]}?…')
      .replaceAllMapped(
          _pfadInZeichen, (m) => '${m[1]}<Datei>${_endung(m[2]!)}${m[1]}')
      .replaceAllMapped(_pfad, (m) => '<Datei>${_endung(m[0]!.trimRight())}')
      .replaceAllMapped(_windowsInZeichen,
          (m) => '${m[1]}<Datei>${_endung(m[2]!)}${m[1]}')
      .replaceAllMapped(
          _windows, (m) => '<Datei>${_endung(m[0]!.trimRight())}');
  if (nummern) s = s.replaceAll(_nummer, '<Nummer>');
  if (s.length > hoechstens) s = '${s.substring(0, hoechstens)} …';
  return s;
}

final RegExp _email = RegExp(r'[\w.+-]+@[\w-]+(?:\.[\w-]+)+');

/// Schema://Host/Pfad, dann `?` und alles bis zum nächsten Leerraum.
final RegExp _abfrage =
    RegExp(r'''([a-zA-Z][a-zA-Z0-9+.-]*://[^\s?#"'<>]+)\?[^\s"'<>]*''');

const String _wurzeln = 'data|storage|sdcard|mnt|tmp|home|var|cache|proc';

/// Ein Pfad in Anführungszeichen, wie ihn `FileSystemException` schreibt
/// (`path = '/storage/…/Max Muster.pdf'`) — bis zum schließenden Zeichen,
/// Leerzeichen im Namen eingeschlossen.
final RegExp _pfadInZeichen = RegExp('''(['"])(/(?:$_wurzeln)/[^'"\n]*)\\1''');

/// Ein absoluter Pfad des Dateisystems ohne Anführungszeichen, wie ihn Java
/// schreibt (`/storage/…/Max Muster.pdf: open failed`) — bis zum Doppelpunkt,
/// Leerzeichen eingeschlossen. Nicht der Pfad einer Adresse: davor steht kein
/// Wortzeichen (bei `https://host/data/…` stünde dort der Host).
final RegExp _pfad = RegExp('''(?<![\\w.-])/(?:$_wurzeln)/[^"'<>:,;)\\]\n]*''');

/// Dasselbe unter Windows: `'C:\Users\Max Muster\Documents\Brief.pdf'` in
/// Anführungszeichen bis zum schließenden Zeichen, ohne sie bis zum ersten
/// Zeichen, das in keinem Pfad steht.
final RegExp _windowsInZeichen = RegExp(r'''(['"])([A-Za-z]:\\[^'"\n]*)\1''');
final RegExp _windows = RegExp(r'''(?<!\w)[A-Za-z]:\\[^"'<>:,;)\]\n]*''');

/// Acht und mehr Ziffern, auch mit Leerzeichen oder `+` davor (`+49 151 …`,
/// `DE89 3704 0044 …`) — keine Zeilennummer, keine Uhrzeit.
final RegExp _nummer = RegExp(r'(?<![\w.])\+?\d(?:[ \d]{6,}\d)(?![\w.])');

String _endung(String pfad) {
  final name = pfad.substring(pfad.lastIndexOf(RegExp(r'[/\\]')) + 1);
  final e = RegExp(r'\.[A-Za-z0-9]{1,5}$').firstMatch(name);
  return e?.group(0) ?? '';
}
