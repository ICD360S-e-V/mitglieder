/// Was ins Protokoll darf, wenn eigentlich eine Person gemeint ist.
///
/// `LoggerService` lädt jede Zeile auf den Server (`logs/mitglieder_{android,windows}/`).
/// Namen, Rufnummern, genaue Standorte, IP-Adressen und Pfade, in denen unter
/// Windows der Benutzername steht, gehören dort nicht hin (18.10.2026). Diese
/// Funktionen geben stattdessen die FORM zurück — genug, um einen Fehler zu
/// finden, zu wenig, um eine Person zu erkennen.
///
/// ⚠️ Namen haben hier KEINE Funktion: ein Name wird nicht umgeformt, sondern
/// weggelassen. Wer einen Vorgang wiederfinden muss, nimmt die Nummer der
/// Unterhaltung oder des Anrufs — die steht in den Zeilen schon daneben.
library;

/// Eine Rufnummer: nur, ob es eine gab und wie viele Ziffern sie hat.
String protokollNummer(String? nummer) {
  final roh = (nummer ?? '').trim();
  final ziffern = roh.replaceAll(RegExp(r'[^0-9]'), '');
  if (ziffern.isEmpty) {
    return roh.isEmpty || roh.toLowerCase().contains('anonym') ? 'anonym' : 'ohne Ziffern';
  }
  return 'Rufnummer (${ziffern.length} Ziffern)';
}

/// Ein Standort, auf eine Nachkommastelle gerundet (rund 11 km) — genug für
/// „welche Gegend, welcher Verkehrsverbund", nicht für eine Adresse.
String protokollPosition(double? lat, double? lon) {
  if (lat == null || lon == null) return 'ohne Position';
  return '≈${lat.toStringAsFixed(1)}/${lon.toStringAsFixed(1)}';
}

/// Ein Pfad zu einer Datei DER APP SELBST (Update-Paket, Sprachmodell): nur
/// der Dateiname. Unter Windows steht davor `C:\Users\<Name>\…`.
///
/// ⚠️ Nicht für Dokumente von Mitgliedern — dort ist schon der Dateiname
/// ein Personendatum; dafür gibt es [protokollEndung].
String protokollDatei(String? pfad) {
  if (pfad == null || pfad.isEmpty) return '-';
  return pfad.split(RegExp(r'[\\/]')).last;
}

/// Eine Datei eines Mitglieds: nur Endung und Länge des Namens.
String protokollEndung(String? name) {
  final n = (name ?? '').trim();
  if (n.isEmpty) return '-';
  final punkt = n.lastIndexOf('.');
  final endung = punkt > 0 && punkt < n.length - 1 ? n.substring(punkt + 1).toLowerCase() : '?';
  return '.$endung (${n.length} Zeichen)';
}
