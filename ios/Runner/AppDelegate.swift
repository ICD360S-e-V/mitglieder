import Flutter
import ImageIO
import Photos
import PhotosUI
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
    if let registrar = self.registrar(forPlugin: "FotoQuelle") {
      FotoQuelle.anbinden(registrar)
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
    // „Foto bearbeiten": derselbe geöffnete Ordner erlaubt auch Lesen und
    // Löschen darin — Apple: „Use a security-scoped URL to enumerate the
    // content of the directory …, or to add, remove, or modify any files."
    case "auflisten":
      auflisten(argumente["ordner"] as? String ?? "", antwort)
    case "lesen", "vorschau", "loeschen":
      guard let datei = dateiImOrdner(argumente) else {
        antwort(FlutterError(code: aufruf.method, message: "Datei nicht im Ordner", details: nil))
        return
      }
      switch aufruf.method {
      case "lesen": lesen(datei, antwort)
      case "vorschau": vorschau(datei, argumente["kante"] as? Int ?? 256, antwort)
      default: loeschen(datei, antwort)
      }
    default:
      antwort(FlutterMethodNotImplemented)
    }
  }

  /// Die Datei `datei` im geöffneten Ordner `ordner`. Nur ein Name, kein Pfad:
  /// mit `../` käme man sonst aus dem Ordner heraus.
  private func dateiImOrdner(_ argumente: [String: Any]) -> URL? {
    guard let schluessel = argumente["ordner"] as? String, let url = ordner[schluessel],
      let name = argumente["datei"] as? String, !name.isEmpty, !name.hasPrefix("."),
      name == (name as NSString).lastPathComponent
    else { return nil }
    return url.appendingPathComponent(name)
  }

  /// Die Fotos direkt im Ordner, ohne Unterordner. Schlüssel ist der Name.
  private func auflisten(_ schluessel: String, _ antwort: @escaping FlutterResult) {
    guard let url = ordner[schluessel] else {
      antwort(FlutterError(code: "auflisten", message: "Ordner nicht offen", details: nil))
      return
    }
    DispatchQueue.global(qos: .userInitiated).async {
      var liste: [[String: Any]] = []
      var koordinatorFehler: NSError?
      var lesefehler: Error?
      NSFileCoordinator().coordinate(readingItemAt: url, options: [], error: &koordinatorFehler) {
        gelesen in
        let felder: [URLResourceKey] = [
          .isRegularFileKey, .fileSizeKey, .contentModificationDateKey,
        ]
        do {
          let inhalt = try FileManager.default.contentsOfDirectory(
            at: gelesen, includingPropertiesForKeys: felder, options: [.skipsHiddenFiles])
          for datei in inhalt where FotoDateien.istFoto(datei) {
            let werte = try? datei.resourceValues(forKeys: Set(felder))
            guard werte?.isRegularFile == true else { continue }
            var eintrag: [String: Any] = [
              "schluessel": datei.lastPathComponent, "name": datei.lastPathComponent,
            ]
            if let groesse = werte?.fileSize { eintrag["groesse"] = groesse }
            if let datum = werte?.contentModificationDate {
              eintrag["geaendert"] = Int(datum.timeIntervalSince1970 * 1000)
            }
            liste.append(eintrag)
          }
        } catch {
          lesefehler = error
        }
      }
      let fehler: Error? = koordinatorFehler ?? lesefehler
      DispatchQueue.main.async {
        if let fehler = fehler {
          antwort(
            FlutterError(code: "auflisten", message: fehler.localizedDescription, details: nil))
        } else {
          antwort(liste)
        }
      }
    }
  }

  /// Die Bytes; HEIC als aufrechtes JPG.
  private func lesen(_ datei: URL, _ antwort: @escaping FlutterResult) {
    DispatchQueue.global(qos: .userInitiated).async {
      var daten: Data?
      var lesefehler: Error?
      var koordinatorFehler: NSError?
      NSFileCoordinator().coordinate(readingItemAt: datei, options: [], error: &koordinatorFehler) {
        gelesen in
        do {
          daten = try Data(contentsOf: gelesen)
        } catch {
          lesefehler = error
        }
      }
      if let roh = daten, FotoDateien.istHeic(datei) {
        daten = FotoDateien.alsJpg(roh) ?? roh
      }
      let fehler: Error? = koordinatorFehler ?? lesefehler
      DispatchQueue.main.async {
        if let daten = daten, fehler == nil {
          antwort(FlutterStandardTypedData(bytes: daten))
        } else {
          antwort(
            FlutterError(code: "lesen", message: fehler?.localizedDescription, details: nil))
        }
      }
    }
  }

  private func vorschau(_ datei: URL, _ kante: Int, _ antwort: @escaping FlutterResult) {
    DispatchQueue.global(qos: .utility).async {
      var bild: Data?
      var koordinatorFehler: NSError?
      NSFileCoordinator().coordinate(readingItemAt: datei, options: [], error: &koordinatorFehler) {
        gelesen in
        bild = FotoDateien.vorschau(gelesen, kante: kante)
      }
      DispatchQueue.main.async {
        antwort(bild.map { FlutterStandardTypedData(bytes: $0) })
      }
    }
  }

  /// Über den Koordinator, wie beim Schreiben: in iCloud Drive und bei
  /// anderen Anbietern erfährt so auch der Anbieter davon.
  private func loeschen(_ datei: URL, _ antwort: @escaping FlutterResult) {
    DispatchQueue.global(qos: .userInitiated).async {
      var koordinatorFehler: NSError?
      var loeschfehler: Error?
      NSFileCoordinator().coordinate(
        writingItemAt: datei, options: .forDeleting, error: &koordinatorFehler
      ) { ziel in
        do {
          try FileManager.default.removeItem(at: ziel)
        } catch {
          loeschfehler = error
        }
      }
      let geloescht = koordinatorFehler == nil && loeschfehler == nil
      DispatchQueue.main.async { antwort(geloescht) }
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

  private func obersterController() -> UIViewController? {
    obersterViewController(registrar)
  }
}

/// Der Bildschirm, über dem eine Auswahl aufgeht — wie in file_picker.
private func obersterViewController(_ registrar: FlutterPluginRegistrar?) -> UIViewController? {
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

/// Lesen und Vorschau von Fotos für „Foto bearbeiten" — für den Ordner
/// ([OrdnerAblage]) und das einzelne Foto ([FotoQuelle]).
enum FotoDateien {
  /// Dieselbe Liste wie `fotoEndungen` in lib/utils/foto_bearbeiten.dart.
  static let endungen: Set<String> = ["jpg", "jpeg", "png", "webp", "heic", "heif", "bmp", "gif"]

  static func istFoto(_ url: URL) -> Bool { endungen.contains(url.pathExtension.lowercased()) }

  static func istHeic(_ url: URL) -> Bool {
    ["heic", "heif"].contains(url.pathExtension.lowercased())
  }

  /// Ein Bild, das ImageIO lesen kann (HEIC vor allem), als JPG — aufrecht
  /// gedreht, damit es nicht auf eine EXIF-Angabe ankommt, die beim
  /// Bearbeiten verloren ginge.
  static func alsJpg(_ daten: Data, qualitaet: CGFloat = 0.95) -> Data? {
    guard let quelle = CGImageSourceCreateWithData(daten as CFData, nil),
      let eigenschaften = CGImageSourceCopyPropertiesAtIndex(quelle, 0, nil) as? [CFString: Any]
    else { return nil }
    let breite = eigenschaften[kCGImagePropertyPixelWidth] as? Int ?? 0
    let hoehe = eigenschaften[kCGImagePropertyPixelHeight] as? Int ?? 0
    let optionen: [CFString: Any] = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: max(breite, hoehe, 1),
    ]
    guard let bild = CGImageSourceCreateThumbnailAtIndex(quelle, 0, optionen as CFDictionary)
    else { return nil }
    let ziel = NSMutableData()
    guard
      let schreiber = CGImageDestinationCreateWithData(
        ziel, UTType.jpeg.identifier as CFString, 1, nil)
    else { return nil }
    CGImageDestinationAddImage(
      schreiber, bild, [kCGImageDestinationLossyCompressionQuality: qualitaet] as CFDictionary)
    return CGImageDestinationFinalize(schreiber) ? ziel as Data : nil
  }

  /// Ein kleines, aufrechtes JPG für die Übersicht.
  static func vorschau(_ url: URL, kante: Int) -> Data? {
    guard let quelle = CGImageSourceCreateWithURL(url as CFURL, nil) else { return nil }
    let optionen: [CFString: Any] = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: kante,
    ]
    guard let bild = CGImageSourceCreateThumbnailAtIndex(quelle, 0, optionen as CFDictionary)
    else { return nil }
    return UIImage(cgImage: bild).jpegData(compressionQuality: 0.8)
  }
}

/// Ein einzelnes Foto aus „Fotos" für „Foto bearbeiten"
/// (lib/utils/foto_quelle.dart).
///
/// Die Auswahl braucht keine Erlaubnis (PHPicker). Erst wenn das Mitglied die
/// Kopie speichert, fragt iOS, ob die App Fotos HINZUFÜGEN darf — und erst
/// wenn es das Original löschen will, nach dem Zugriff auf die Mediathek;
/// beim Löschen fragt iOS danach selbst noch einmal nach, und das Foto kommt
/// in „Zuletzt gelöscht".
///
/// ⚠️ Im Protokoll stehen nie Namen oder Kennungen von Fotos.
final class FotoQuelle: NSObject, PHPickerViewControllerDelegate,
  UIAdaptivePresentationControllerDelegate
{
  static let kanal = "de.icd360sev.mitglied/foto_quelle"

  /// Hält die Instanz am Leben — der Kanal hält nur den Block.
  private static var instanz: FotoQuelle?

  private var registrar: FlutterPluginRegistrar?

  /// Die Antwort auf die offene Auswahl, bis das System zurückkommt.
  private var offen: FlutterResult?

  static func anbinden(_ registrar: FlutterPluginRegistrar) {
    let quelle = FotoQuelle()
    quelle.registrar = registrar
    instanz = quelle
    let k = FlutterMethodChannel(name: kanal, binaryMessenger: registrar.messenger())
    k.setMethodCallHandler { aufruf, antwort in
      quelle.behandeln(aufruf, antwort)
    }
  }

  private func behandeln(_ aufruf: FlutterMethodCall, _ antwort: @escaping FlutterResult) {
    let argumente = aufruf.arguments as? [String: Any] ?? [:]
    switch aufruf.method {
    case "waehlen":
      waehlen(antwort)
    case "inFotosSpeichern":
      inFotosSpeichern(
        (argumente["bytes"] as? FlutterStandardTypedData)?.data ?? Data(), antwort)
    case "loeschen":
      loeschen(argumente["datei"] as? String ?? "", antwort)
    default:
      antwort(FlutterMethodNotImplemented)
    }
  }

  private func waehlen(_ antwort: @escaping FlutterResult) {
    // Eine zweite Auswahl, solange die erste offen ist, beendet die erste
    // mit „abgebrochen" — sonst wartete Dart dort ewig.
    offen?(nil)
    guard let oben = obersterViewController(registrar) else {
      offen = nil
      antwort(FlutterError(code: "keine_auswahl", message: "kein Fenster", details: nil))
      return
    }
    offen = antwort
    // Mit der Mediathek, sonst gibt es keine Kennung — und ohne Kennung
    // ließe sich das Original später nicht löschen.
    var einstellung = PHPickerConfiguration(photoLibrary: .shared())
    einstellung.filter = .images
    einstellung.selectionLimit = 1
    // HEIC kommt so schon als JPG: Flutter und die Größen-Umrechnung lesen es.
    einstellung.preferredAssetRepresentationMode = .compatible
    let auswahl = PHPickerViewController(configuration: einstellung)
    auswahl.delegate = self
    auswahl.presentationController?.delegate = self
    oben.present(auswahl, animated: true)
  }

  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    guard let antwort = offen else { return }
    offen = nil
    guard let ergebnis = results.first else {
      antwort(nil)
      return
    }
    let anbieter = ergebnis.itemProvider
    let typ =
      [UTType.jpeg, UTType.png, UTType.heic, UTType.image]
      .first { anbieter.hasItemConformingToTypeIdentifier($0.identifier) } ?? .image
    anbieter.loadDataRepresentation(forTypeIdentifier: typ.identifier) { daten, fehler in
      var bytes = daten
      // Kam trotzdem kein JPG oder PNG: selbst umwandeln.
      if let roh = daten, typ != .jpeg, typ != .png {
        bytes = FotoDateien.alsJpg(roh) ?? roh
      }
      let endung = typ == .png ? "png" : "jpg"
      let name = (anbieter.suggestedName ?? "Foto") + "." + endung
      DispatchQueue.main.async {
        guard let bytes = bytes else {
          antwort(
            FlutterError(code: "lesen", message: fehler?.localizedDescription, details: nil))
          return
        }
        antwort([
          "schluessel": ergebnis.assetIdentifier ?? "",
          "name": name,
          "groesse": bytes.count,
          "bytes": FlutterStandardTypedData(bytes: bytes),
          "fotosApp": true,
        ])
      }
    }
  }

  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    offen?(nil)
    offen = nil
  }

  /// Die bearbeitete Kopie zurück nach „Fotos". `false`: kein Zugriff —
  /// dann speichert Dart über „Dateien".
  private func inFotosSpeichern(_ daten: Data, _ antwort: @escaping FlutterResult) {
    PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
      guard status == .authorized || status == .limited else {
        DispatchQueue.main.async { antwort(false) }
        return
      }
      PHPhotoLibrary.shared().performChanges({
        PHAssetCreationRequest.forAsset().addResource(with: .photo, data: daten, options: nil)
      }) { ok, _ in
        DispatchQueue.main.async { antwort(ok) }
      }
    }
  }

  /// Löscht das Original aus „Fotos"; iOS fragt dabei selbst nach.
  /// `false`: kein Zugriff, nicht gefunden (bei eingeschränktem Zugriff nicht
  /// freigegeben) oder vom Mitglied abgelehnt.
  private func loeschen(_ kennung: String, _ antwort: @escaping FlutterResult) {
    guard !kennung.isEmpty else {
      antwort(false)
      return
    }
    PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
      guard status == .authorized || status == .limited else {
        DispatchQueue.main.async { antwort(false) }
        return
      }
      let fotos = PHAsset.fetchAssets(withLocalIdentifiers: [kennung], options: nil)
      guard fotos.count > 0 else {
        DispatchQueue.main.async { antwort(false) }
        return
      }
      PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.deleteAssets(fotos)
      }) { ok, _ in
        DispatchQueue.main.async { antwort(ok) }
      }
    }
  }
}
