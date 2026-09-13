// Was auf Windows, Linux und macOS an die Stelle des Klingelschirms tritt.
//
// 🔴 ÜBER DEN SPERRBILDSCHIRM VON WINDOWS DARF KEINE APP ZEICHNEN — nur die
// Shell. Ein Klingelschirm wie auf Android ist dort unmöglich, und das ist eine
// Grenze des Systems, keine Entscheidung. Was geht und hier getan wird: das
// Fenster aus dem Infobereich zurückholen, es nach vorne bringen und es
// während des Klingelns ÜBER allen anderen Fenstern halten. Ist der Rechner
// entsperrt, ist das Ergebnis dasselbe — der Anruf steht vor dem Menschen.
//
// ⚠️ KEIN `setFullScreen`. Es nähme dem Mitglied den ganzen Bildschirm, und ein
// Vollbild, das man nicht mehr verlässt, ist schlimmer als ein Anruf, den man
// übersieht.
import 'dart:io';

import 'package:window_manager/window_manager.dart';

import 'logger_service.dart';

class AnrufDesktop {
  AnrufDesktop._();

  static final LoggerService _log = LoggerService();

  static bool get verfuegbar =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  /// ⚠️ Merkt sich, dass WIR es gesetzt haben. Sonst nähme das Ende eines
  /// Anrufs dem Mitglied ein „immer im Vordergrund", das es selbst gewählt hat.
  static bool _vonUnsObenGehalten = false;

  /// Es klingelt: Fenster sichtbar und ÜBER allen anderen halten.
  ///
  /// 🔴 DIE REIHENFOLGE IST DIE SACHE. `setAlwaysOnTop` ist der Teil, der
  /// wirklich trägt, und er kommt ZUERST — stünde er hinter `focus()`, nähme
  /// ein Fehlschlag des unwichtigen Teils den wichtigen mit.
  ///
  /// ⚠️ Und `focus()` ist nur ein Versuch: Windows lässt eine Anwendung den
  /// Vordergrund NICHT an sich reissen, während der Mensch in einem anderen
  /// Fenster arbeitet (`SetForegroundWindow` scheitert dann und Windows lässt
  /// stattdessen den Knopf in der Taskleiste blinken). `setAlwaysOnTop` ist
  /// dagegen eine Fenster-Eigenschaft und keine Vordergrund-Übernahme — das
  /// Fenster wird damit sichtbar, auch ohne den Fokus zu bekommen.
  ///
  /// ⚠️ Das ist auch der Grund, warum das Fenster und nicht die Meldung der
  /// tragende Teil ist: „Nicht stören" (Windows 11) bzw. Focus Assist
  /// (Windows 10) schiebt Meldungen stumm in die Benachrichtigungszentrale,
  /// wenn die App nicht in der Prioritätsliste steht. Ein Fenster berührt das
  /// nicht.
  static Future<void> klingelnAn() async {
    if (!verfuegbar) return;
    // Getrennte Fänge: jeder Schritt soll für sich gelingen dürfen.
    if (!_vonUnsObenGehalten) {
      try {
        await windowManager.setAlwaysOnTop(true);
        _vonUnsObenGehalten = true;
      } catch (e) {
        _log.warning('AnrufDesktop: nicht oben zu halten: $e', tag: 'CALL');
      }
    }
    try {
      await windowManager.show();
    } catch (e) {
      _log.warning('AnrufDesktop: Fenster nicht sichtbar: $e', tag: 'CALL');
    }
    try {
      await windowManager.focus();
    } catch (e) {
      // Erwartbar, wenn der Mensch gerade in einer anderen App arbeitet.
      _log.debug('AnrufDesktop: Fokus verweigert (Windows): $e', tag: 'CALL');
    }
  }

  /// Der Anruf ist entschieden — das Fenster gibt den Vordergrund wieder frei.
  static Future<void> klingelnAus() async {
    if (!verfuegbar) return;
    if (!_vonUnsObenGehalten) return;
    _vonUnsObenGehalten = false;
    try {
      await windowManager.setAlwaysOnTop(false);
    } catch (e) {
      _log.warning('AnrufDesktop: Vordergrund nicht freigegeben: $e', tag: 'CALL');
    }
  }
}
