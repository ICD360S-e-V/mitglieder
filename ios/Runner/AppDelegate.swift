import Flutter
import UIKit
import UniformTypeIdentifiers

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if let registrar = self.registrar(forPlugin: "OrdnerAblage") {
      OrdnerAblage.anbinden(registrar)
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

/// Mehrere Dateien in einen Ordner, den das Mitglied wählt — für
/// „PDF in Bilder" (lib/utils/ordner_ablage.dart).
///
/// ⚠️ Warum nicht file_picker: dessen Ordnerauswahl liefert nur den Pfad und
/// öffnet den Ordner nicht. Ein gewählter Ordner bleibt auf dem iPhone
/// gesperrt, bis die App `startAccessingSecurityScopedResource()` ruft —
/// jedes Schreiben außerhalb des App-Bereichs (iCloud Drive, „Auf meinem
/// iPhone", andere Anbieter) scheiterte damit.
///
/// Hier im AppDelegate und nicht in einer eigenen Datei: eine neue Swift-Datei
/// müsste auch ins Xcode-Projekt eingetragen werden, und das ist von Hand
/// fehleranfällig.
///
/// ⚠️ Im Protokoll stehen nie Datei- oder Ordnernamen: es sind private
/// Dokumente der Mitglieder.
final class OrdnerAblage: NSObject, UIDocumentPickerDelegate,
  UIAdaptivePresentationControllerDelegate
{
  static let kanal = "de.icd360sev.mitglied/ordner_ablage"

  /// Hält die Instanz am Leben — der Kanal hält nur den Block.
  private static var instanz: OrdnerAblage?

  private var registrar: FlutterPluginRegistrar?

  /// Die Antwort auf die offene Auswahl, bis das System zurückkommt.
  private var offen: FlutterResult?

  /// Geöffnete Ordner, nach der Kennung, die Dart bekommen hat.
  private var ordner: [String: URL] = [:]

  static func anbinden(_ registrar: FlutterPluginRegistrar) {
    let ablage = OrdnerAblage()
    ablage.registrar = registrar
    instanz = ablage
    let k = FlutterMethodChannel(name: kanal, binaryMessenger: registrar.messenger())
    k.setMethodCallHandler { aufruf, antwort in
      ablage.behandeln(aufruf, antwort)
    }
  }

  private func behandeln(_ aufruf: FlutterMethodCall, _ antwort: @escaping FlutterResult) {
    let argumente = aufruf.arguments as? [String: Any] ?? [:]
    switch aufruf.method {
    case "waehlen":
      waehlen(antwort)
    case "schreiben":
      schreiben(
        argumente["ordner"] as? String ?? "",
        argumente["name"] as? String ?? "",
        (argumente["bytes"] as? FlutterStandardTypedData)?.data ?? Data(),
        antwort)
    case "schliessen":
      if let schluessel = argumente["ordner"] as? String,
        let url = ordner.removeValue(forKey: schluessel)
      {
        url.stopAccessingSecurityScopedResource()
      }
      antwort(nil)
    default:
      antwort(FlutterMethodNotImplemented)
    }
  }

  private func waehlen(_ antwort: @escaping FlutterResult) {
    // Eine zweite Auswahl, solange die erste offen ist, beendet die erste
    // mit „abgebrochen" — sonst wartete Dart dort ewig.
    offen?(nil)
    guard let oben = obersterController() else {
      offen = nil
      antwort(FlutterError(code: "keine_auswahl", message: "kein Fenster", details: nil))
      return
    }
    offen = antwort
    let auswahl = UIDocumentPickerViewController(
      forOpeningContentTypes: [.folder], asCopy: false)
    auswahl.delegate = self
    auswahl.presentationController?.delegate = self
    auswahl.allowsMultipleSelection = false
    oben.present(auswahl, animated: true)
  }

  func documentPicker(
    _ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]
  ) {
    guard let antwort = offen else { return }
    offen = nil
    guard let url = urls.first else {
      antwort(nil)
      return
    }
    // Ohne diesen Aufruf bleibt der Ordner gesperrt. Ein `false` heißt nur,
    // dass er gar nicht gesperrt war (z. B. im eigenen Bereich der App).
    _ = url.startAccessingSecurityScopedResource()
    let schluessel = UUID().uuidString
    ordner[schluessel] = url
    antwort(["ordner": schluessel, "name": url.lastPathComponent])
  }

  func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    offen?(nil)
    offen = nil
  }

  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    offen?(nil)
    offen = nil
  }

  private func schreiben(
    _ schluessel: String, _ name: String, _ daten: Data,
    _ antwort: @escaping FlutterResult
  ) {
    guard let url = ordner[schluessel] else {
      antwort(FlutterError(code: "schreiben", message: "Ordner nicht offen", details: nil))
      return
    }
    DispatchQueue.global(qos: .userInitiated).async {
      let frei = OrdnerAblage.freierName(name, in: url)
      let ziel = url.appendingPathComponent(frei)
      // Über den Koordinator: in iCloud Drive und bei anderen Anbietern
      // erfährt so auch der Anbieter, dass hier geschrieben wird.
      var koordinatorFehler: NSError?
      var schreibFehler: Error?
      NSFileCoordinator().coordinate(
        writingItemAt: ziel, options: .forReplacing, error: &koordinatorFehler
      ) { neu in
        do {
          try daten.write(to: neu, options: .atomic)
        } catch {
          schreibFehler = error
        }
      }
      let fehler: Error? = koordinatorFehler ?? schreibFehler
      DispatchQueue.main.async {
        if let fehler = fehler {
          antwort(
            FlutterError(
              code: "schreiben", message: fehler.localizedDescription, details: nil))
        } else {
          antwort(frei)
        }
      }
    }
  }

  /// `name.jpg`, sonst `name(1).jpg`, `name(2).jpg` … — dieselbe Regel wie
  /// `freierDateiname` in Dart. Nie überschreiben.
  static func freierName(_ name: String, in ordner: URL) -> String {
    let dateien = FileManager.default
    func belegt(_ n: String) -> Bool {
      dateien.fileExists(atPath: ordner.appendingPathComponent(n).path)
    }
    if !belegt(name) { return name }
    let ns = name as NSString
    let basis = ns.deletingPathExtension
    let endung = ns.pathExtension.isEmpty ? "" : "." + ns.pathExtension
    for i in 1..<10000 {
      let kandidat = "\(basis)(\(i))\(endung)"
      if !belegt(kandidat) { return kandidat }
    }
    return "\(basis)(\(Int(Date().timeIntervalSince1970 * 1000)))\(endung)"
  }

  /// Der Bildschirm, über dem die Auswahl aufgeht — wie in file_picker.
  private func obersterController() -> UIViewController? {
    var oben =
      registrar?.viewController?.view.window?.windowScene?.keyWindow?.rootViewController
      ?? UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }?.rootViewController
    while let darueber = oben?.presentedViewController {
      oben = darueber
    }
    return oben
  }
}
