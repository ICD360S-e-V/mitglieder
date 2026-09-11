import 'package:flutter/foundation.dart';

/// Der Rueckweg in einen laufenden Anruf.
///
/// Der Anrufschirm ist eine GESCHOBENE Route. Wer sie wegwischt, hat den Anruf
/// weiterhin am Laufen — der Dienst besitzt ihn —, sieht ihn aber nirgends
/// mehr und kann ihn nicht beenden. Genau dieser unsichtbare Anruf ist es, der
/// jeden naechsten mit „busy" abweist. [AnrufLeiste] macht ihn wieder sichtbar
/// und beendbar.
class AnrufRueckweg {
  AnrufRueckweg._();

  /// Steht der Anrufschirm gerade auf dem Schirm? Dann blendet die Leiste sich
  /// aus — zwei Anrufanzeigen uebereinander waeren verwirrend.
  static final ValueNotifier<bool> schirmSichtbar = ValueNotifier<bool>(false);

  /// Wie man den Anrufschirm wieder oeffnet. Registriert vom Dashboard, das
  /// ihn ohnehin schiebt; die Leiste kennt den Weg nicht selbst.
  static void Function()? oeffner;

  static void zurueck() => oeffner?.call();
}
