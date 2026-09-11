/// Der Rückweg in einen laufenden Anruf.
///
/// Der Anrufschirm ist eine GESCHOBENE Route. Wer sie wegwischt, hat den Anruf
/// weiterhin am Laufen — der Dienst besitzt ihn —, sähe ihn aber nirgends mehr
/// und könnte ihn nicht beenden. Ein solcher unsichtbarer Anruf weist jeden
/// nächsten mit „busy" ab; am 11.09.2026 im Betrieb beobachtet.
///
/// ⚠️ Ob die Karte zu sehen ist, entscheidet [AnrufOverlay] selbst
/// (`unterdruecken`). Diese Klasse trägt nur den WEG zurück, den das Overlay
/// nicht kennt und auch nicht kennen soll.
class AnrufRueckweg {
  AnrufRueckweg._();

  /// Wie man den Anrufschirm wieder öffnet. Registriert vom Dashboard, das ihn
  /// ohnehin schiebt.
  static void Function()? oeffner;

  static void zurueck() => oeffner?.call();
}
