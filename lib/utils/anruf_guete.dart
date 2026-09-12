/// Wie gut die Gegenstelle gerade ankommt — aus den WebRTC-Statistiken.
///
/// ⚠️ Die Zahlen von `getStats()` sind KUMULATIV ueber das ganze Gespraech.
/// Direkt verwendet, zoege eine schlechte erste Minute die Anzeige bis zum
/// Auflegen herunter, und eine Besserung waere nie zu sehen. Gerechnet wird
/// deshalb immer aus dem UNTERSCHIED zweier Abfragen. (Dieselbe Lehre wie bei
/// der Gespraechsguete der Vorsitzer-App, 30.08.2026.)
///
/// ⚠️ Die Schwellen sind uebliche VoIP-Praxis, KEINE Norm — sie sind gewaehlt,
/// nicht gemessen. Was hier wirklich zaehlt, ist die vierte Stufe:
/// „noch nichts gemessen" ist etwas anderes als „schlecht", und beide duerfen
/// auf dem Schirm nie gleich aussehen.
library;

/// 0 = noch nichts gemessen · 1 = schlecht · 2 = mittel · 3 = gut
const int kGueteUnbekannt = 0;
const int kGueteSchlecht = 1;
const int kGueteMittel = 2;
const int kGueteGut = 3;

/// Unter so vielen Paketen im Fenster wird NICHT geurteilt.
///
/// Opus mit 20-ms-Rahmen sind ~50 Pakete/s, in einem 3-Sekunden-Fenster also
/// rund 150. Zehn ist damit kein knapper Fall, sondern der Beleg, dass in
/// diesem Fenster ueberhaupt nichts ankam — und dann ist die ehrliche Antwort
/// „unbekannt", nicht „schlecht": genau so sieht auch der erste Takt nach dem
/// Verbinden aus.
const int kGueteMindestPakete = 10;

/// Ein Urteil aus EINEM Messfenster.
///
/// [dEmpfangen] und [dVerloren] sind die Zuwaechse seit der letzten Abfrage,
/// [jitterMs] der aktuelle Jitter in Millisekunden.
int anrufGueteStufe({
  required int dEmpfangen,
  required int dVerloren,
  required double jitterMs,
}) {
  // ⚠️ `packetsLost` DARF sinken: RFC 3550 verrechnet verspaetet eingetroffene
  // Pakete nachtraeglich. Ungeklemmt kaeme negativer Verlust heraus.
  final verloren = dVerloren < 0 ? 0 : dVerloren;
  final empfangen = dEmpfangen < 0 ? 0 : dEmpfangen;
  final gesamt = empfangen + verloren;
  if (gesamt < kGueteMindestPakete) return kGueteUnbekannt;

  final verlust = verloren / gesamt;
  final jitter = jitterMs.isFinite && jitterMs > 0 ? jitterMs : 0.0;

  if (verlust < 0.01 && jitter < 30) return kGueteGut;
  if (verlust < 0.05 && jitter < 50) return kGueteMittel;
  return kGueteSchlecht;
}
