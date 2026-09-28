import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  // Klick auf das Dock-Symbol oder erneutes Oeffnen aus Finder/Launchpad,
  // waehrend die App laeuft: macOS startet sie nicht ein zweites Mal, sondern
  // meldet sich hier ("reopen"). Dasselbe schickt eine zweite Kopie der App,
  // bevor sie sich beendet (MainFlutterWindow.laufendeKopieNachVorne).
  //
  // Das Kreuz versteckt das Fenster nur (Infobereich, window_manager). Ohne
  // diese Methode kam es auf diesem Weg nie zurueck - die App schien nicht zu
  // reagieren.
  override func applicationShouldHandleReopen(
    _ sender: NSApplication, hasVisibleWindows flag: Bool
  ) -> Bool {
    guard let fenster = mainFlutterWindow, !fenster.isVisible else {
      return true
    }
    if fenster.isMiniaturized {
      fenster.deminiaturize(nil)
    } else {
      fenster.makeKeyAndOrderFront(nil)
    }
    return false
  }
}
