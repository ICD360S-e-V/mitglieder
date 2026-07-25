import Cocoa
import FlutterMacOS
import ApplicationServices

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    // Security: Prevent screenshots and screen recording (like Netflix).
    // Toggled to .readOnly only during a consented Fernwartung session so the
    // Vorsitzer can also see the member's own app window while helping.
    if #available(macOS 12.0, *) {
      self.sharingType = .none
    }

    // Fernwartung (remote support) native input injection via CGEvent.
    let channel = FlutterMethodChannel(
      name: "de.icd360sev.mitglied/remote_input",
      binaryMessenger: flutterViewController.engine.binaryMessenger)
    channel.setMethodCallHandler { [weak self] call, result in
      let args = call.arguments as? [String: Any]
      switch call.method {
      case "isTrusted":
        result(AXIsProcessTrusted())
      case "ensureAccessibility":
        // Prompts the user to grant Accessibility if not yet trusted.
        let opts = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
        result(AXIsProcessTrustedWithOptions(opts))
      case "mouseMove":
        RemoteInput.shared.mouseMove(
          nx: args?["x"] as? Double ?? 0, ny: args?["y"] as? Double ?? 0)
        result(nil)
      case "mouseButton":
        RemoteInput.shared.mouseButton(
          button: args?["b"] as? Int ?? 0, down: args?["down"] as? Bool ?? false)
        result(nil)
      case "mouseWheel":
        RemoteInput.shared.mouseWheel(
          dx: args?["dx"] as? Double ?? 0, dy: args?["dy"] as? Double ?? 0)
        result(nil)
      case "keyEvent":
        RemoteInput.shared.keyEvent(
          hid: args?["hid"] as? Int ?? 0, down: args?["down"] as? Bool ?? false)
        result(nil)
      case "setCapturable":
        // Allow this app's own window into the shared stream during a session.
        if #available(macOS 12.0, *) {
          let on = args?["on"] as? Bool ?? false
          self?.sharingType = on ? .readOnly : .none
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    super.awakeFromNib()
  }
}

/// CGEvent-based input injection. Requires the app to be non-sandboxed and to
/// have the Accessibility permission (System Settings › Privacy › Accessibility).
final class RemoteInput {
  static let shared = RemoteInput()
  private let source = CGEventSource(stateID: .hidSystemState)
  private var lastX: CGFloat = 0
  private var lastY: CGFloat = 0
  private var leftDown = false
  private var rightDown = false
  private var otherDown = false

  private func mainSize() -> CGSize {
    let b = CGDisplayBounds(CGMainDisplayID())
    return CGSize(width: b.width, height: b.height)
  }

  func mouseMove(nx: Double, ny: Double) {
    let s = mainSize()
    lastX = CGFloat(min(max(nx, 0), 1)) * s.width
    lastY = CGFloat(min(max(ny, 0), 1)) * s.height
    let type: CGEventType = leftDown ? .leftMouseDragged
      : (rightDown ? .rightMouseDragged : (otherDown ? .otherMouseDragged : .mouseMoved))
    let btn: CGMouseButton = rightDown ? .right : (otherDown ? .center : .left)
    post(type: type, button: btn)
  }

  func mouseButton(button: Int, down: Bool) {
    let type: CGEventType
    let btn: CGMouseButton
    switch button {
    case 2:
      rightDown = down; btn = .right; type = down ? .rightMouseDown : .rightMouseUp
    case 1:
      otherDown = down; btn = .center; type = down ? .otherMouseDown : .otherMouseUp
    default:
      leftDown = down; btn = .left; type = down ? .leftMouseDown : .leftMouseUp
    }
    post(type: type, button: btn)
  }

  private func post(type: CGEventType, button: CGMouseButton) {
    let e = CGEvent(mouseEventSource: source, mouseType: type,
                    mouseCursorPosition: CGPoint(x: lastX, y: lastY), mouseButton: button)
    e?.post(tap: .cghidEventTap)
  }

  func mouseWheel(dx: Double, dy: Double) {
    // Controller dy>0 = scroll down; CGEvent positive = up. Invert.
    let e = CGEvent(scrollWheelEvent2Source: source, units: .pixel, wheelCount: 2,
                    wheel1: Int32(-dy), wheel2: Int32(-dx), wheel3: 0)
    e?.post(tap: .cghidEventTap)
  }

  func keyEvent(hid: Int, down: Bool) {
    let page = (hid >> 16) & 0xFFFF
    let usage = hid & 0xFFFF
    guard page == 0x07 || page == 0x00, let vk = RemoteInput.hidToKeycode[usage] else { return }
    let e = CGEvent(keyboardEventSource: source, virtualKey: CGKeyCode(vk), keyDown: down)
    e?.post(tap: .cghidEventTap)
  }

  /// USB HID Keyboard usage (page 0x07) → macOS virtual keycode (kVK_*).
  static let hidToKeycode: [Int: Int] = [
    // letters a-z
    0x04: 0x00, 0x05: 0x0B, 0x06: 0x08, 0x07: 0x02, 0x08: 0x0E, 0x09: 0x03,
    0x0A: 0x05, 0x0B: 0x04, 0x0C: 0x22, 0x0D: 0x26, 0x0E: 0x28, 0x0F: 0x25,
    0x10: 0x2E, 0x11: 0x2D, 0x12: 0x1F, 0x13: 0x23, 0x14: 0x0C, 0x15: 0x0F,
    0x16: 0x01, 0x17: 0x11, 0x18: 0x20, 0x19: 0x09, 0x1A: 0x0D, 0x1B: 0x07,
    0x1C: 0x10, 0x1D: 0x06,
    // digits 1-9 0
    0x1E: 0x12, 0x1F: 0x13, 0x20: 0x14, 0x21: 0x15, 0x22: 0x17, 0x23: 0x16,
    0x24: 0x1A, 0x25: 0x1C, 0x26: 0x19, 0x27: 0x1D,
    0x28: 0x24, // Return
    0x29: 0x35, // Escape
    0x2A: 0x33, // Delete (Backspace)
    0x2B: 0x30, // Tab
    0x2C: 0x31, // Space
    0x2D: 0x1B, // -
    0x2E: 0x18, // =
    0x2F: 0x21, // [
    0x30: 0x1E, // ]
    0x31: 0x2A, // backslash
    0x33: 0x29, // ;
    0x34: 0x27, // '
    0x35: 0x32, // `
    0x36: 0x2B, // ,
    0x37: 0x2F, // .
    0x38: 0x2C, // /
    0x39: 0x39, // CapsLock
    // F1-F12
    0x3A: 0x7A, 0x3B: 0x78, 0x3C: 0x63, 0x3D: 0x76, 0x3E: 0x60, 0x3F: 0x61,
    0x40: 0x62, 0x41: 0x64, 0x42: 0x65, 0x43: 0x6D, 0x44: 0x67, 0x45: 0x6F,
    0x49: 0x72, // Insert → Help
    0x4A: 0x73, // Home
    0x4B: 0x74, // PageUp
    0x4C: 0x75, // Forward Delete
    0x4D: 0x77, // End
    0x4E: 0x79, // PageDown
    0x4F: 0x7C, // Right
    0x50: 0x7B, // Left
    0x51: 0x7D, // Down
    0x52: 0x7E, // Up
    0x53: 0x47, // NumLock (Clear)
    0x54: 0x4B, // KP /
    0x55: 0x43, // KP *
    0x56: 0x4E, // KP -
    0x57: 0x45, // KP +
    0x58: 0x4C, // KP Enter
    0x59: 0x53, 0x5A: 0x54, 0x5B: 0x55, 0x5C: 0x56, 0x5D: 0x57,
    0x5E: 0x58, 0x5F: 0x59, 0x60: 0x5B, 0x61: 0x5C, 0x62: 0x52, // KP 1-9,0
    0x63: 0x41, // KP .
    0xE0: 0x3B, // LeftControl
    0xE1: 0x38, // LeftShift
    0xE2: 0x3A, // LeftOption
    0xE3: 0x37, // LeftCommand
    0xE4: 0x3E, // RightControl
    0xE5: 0x3C, // RightShift
    0xE6: 0x3D, // RightOption
    0xE7: 0x36, // RightCommand
  ]
}