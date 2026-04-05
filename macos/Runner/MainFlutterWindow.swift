import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    // Security: Prevent screenshots and screen recording (like Netflix)
    if #available(macOS 12.0, *) {
      self.sharingType = .none
    }

    super.awakeFromNib()
  }
}
