import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';
import 'input_injector.dart';

// Win32 SendInput flag constants (declared locally as raw values so the file
// never depends on which of these win32 re-exports by name).
const int _inputMouse = 0;
const int _inputKeyboard = 1;

const int _mouseMove = 0x0001;
const int _mouseAbsolute = 0x8000;
const int _mouseLeftDown = 0x0002;
const int _mouseLeftUp = 0x0004;
const int _mouseRightDown = 0x0008;
const int _mouseRightUp = 0x0010;
const int _mouseMiddleDown = 0x0020;
const int _mouseMiddleUp = 0x0040;
const int _mouseWheel = 0x0800;
const int _mouseHWheel = 0x1000;

const int _keyKeyUp = 0x0002;
const int _keyUnicode = 0x0004;

/// Windows input injection via Win32 SendInput. Absolute mouse positioning uses
/// the 0..65535 normalized coordinate space so it is resolution-independent.
/// Keys use Virtual-Key codes (so shortcuts like Ctrl+C compose correctly), with
/// a Unicode fallback for printable keys that have no VK mapping.
class WindowsInputInjector extends InputInjector {
  @override
  bool get isSupported => true;

  @override
  void setScreenSize(int width, int height) {
    // Not needed: absolute mouse events use the normalized 0..65535 space.
  }

  void _sendMouse(int flags, {int dx = 0, int dy = 0, int mouseData = 0}) {
    final input = calloc<INPUT>();
    input.ref.type = _inputMouse;
    input.ref.mi.dx = dx;
    input.ref.mi.dy = dy;
    input.ref.mi.mouseData = mouseData;
    input.ref.mi.dwFlags = flags;
    SendInput(1, input, sizeOf<INPUT>());
    calloc.free(input);
  }

  void _sendKey({int vk = 0, int scan = 0, int flags = 0}) {
    final input = calloc<INPUT>();
    input.ref.type = _inputKeyboard;
    input.ref.ki.wVk = vk;
    input.ref.ki.wScan = scan;
    input.ref.ki.dwFlags = flags;
    SendInput(1, input, sizeOf<INPUT>());
    calloc.free(input);
  }

  @override
  Future<void> mouseMove(double nx, double ny) async {
    final ax = (nx.clamp(0.0, 1.0) * 65535).round();
    final ay = (ny.clamp(0.0, 1.0) * 65535).round();
    _sendMouse(_mouseMove | _mouseAbsolute, dx: ax, dy: ay);
  }

  @override
  Future<void> mouseButton(int button, bool down) async {
    int flags;
    switch (button) {
      case 2:
        flags = down ? _mouseRightDown : _mouseRightUp;
        break;
      case 1:
        flags = down ? _mouseMiddleDown : _mouseMiddleUp;
        break;
      default:
        flags = down ? _mouseLeftDown : _mouseLeftUp;
    }
    _sendMouse(flags);
  }

  @override
  Future<void> mouseWheel(double dx, double dy) async {
    // Controller sends pixel-ish deltas; Windows wheel uses multiples of 120,
    // positive = away from the user (up). Controller positive dy = down.
    if (dy != 0) {
      _sendMouse(_mouseWheel, mouseData: (-dy * 3).round().clamp(-32760, 32760));
    }
    if (dx != 0) {
      _sendMouse(_mouseHWheel, mouseData: (dx * 3).round().clamp(-32760, 32760));
    }
  }

  @override
  Future<void> keyEvent({required int hid, String? character, required bool down}) async {
    final page = (hid >> 16) & 0xFFFF;
    final usage = hid & 0xFFFF;
    final vk = (page == 0x07 || page == 0x00) ? _hidToVk[usage] : null;
    if (vk != null) {
      _sendKey(vk: vk, flags: down ? 0 : _keyKeyUp);
      return;
    }
    // No VK mapping — type the character directly as Unicode.
    if (character != null && character.isNotEmpty) {
      final unit = character.codeUnitAt(0);
      _sendKey(scan: unit, flags: _keyUnicode | (down ? 0 : _keyKeyUp));
    }
  }

  @override
  void dispose() {}
}

/// USB HID Keyboard usage (page 0x07) → Windows Virtual-Key code. Covers the
/// keys needed for real control: letters, digits, punctuation, navigation,
/// function keys, numpad and modifiers. Printable keys not listed fall back to
/// Unicode injection using the character the controller sent.
final Map<int, int> _hidToVk = {
  // a-z (0x04..0x1D) → 'A'..'Z' (0x41..0x5A)
  for (int i = 0; i < 26; i++) 0x04 + i: 0x41 + i,
  // 1-9 (0x1E..0x26) → '1'..'9', 0 (0x27) → '0'
  0x1E: 0x31, 0x1F: 0x32, 0x20: 0x33, 0x21: 0x34, 0x22: 0x35,
  0x23: 0x36, 0x24: 0x37, 0x25: 0x38, 0x26: 0x39, 0x27: 0x30,
  0x28: 0x0D, // Enter
  0x29: 0x1B, // Esc
  0x2A: 0x08, // Backspace
  0x2B: 0x09, // Tab
  0x2C: 0x20, // Space
  0x2D: 0xBD, // -
  0x2E: 0xBB, // =
  0x2F: 0xDB, // [
  0x30: 0xDD, // ]
  0x31: 0xDC, // backslash
  0x33: 0xBA, // ;
  0x34: 0xDE, // '
  0x35: 0xC0, // `
  0x36: 0xBC, // ,
  0x37: 0xBE, // .
  0x38: 0xBF, // /
  0x39: 0x14, // CapsLock
  // F1-F12 (0x3A..0x45) → 0x70..0x7B
  for (int i = 0; i < 12; i++) 0x3A + i: 0x70 + i,
  0x46: 0x2C, // PrintScreen
  0x47: 0x91, // ScrollLock
  0x48: 0x13, // Pause
  0x49: 0x2D, // Insert
  0x4A: 0x24, // Home
  0x4B: 0x21, // PageUp
  0x4C: 0x2E, // Delete
  0x4D: 0x23, // End
  0x4E: 0x22, // PageDown
  0x4F: 0x27, // Right
  0x50: 0x25, // Left
  0x51: 0x28, // Down
  0x52: 0x26, // Up
  0x53: 0x90, // NumLock
  0x54: 0x6F, // Numpad /
  0x55: 0x6A, // Numpad *
  0x56: 0x6D, // Numpad -
  0x57: 0x6B, // Numpad +
  0x58: 0x0D, // Numpad Enter
  0x59: 0x61, 0x5A: 0x62, 0x5B: 0x63, 0x5C: 0x64, 0x5D: 0x65,
  0x5E: 0x66, 0x5F: 0x67, 0x60: 0x68, 0x61: 0x69, 0x62: 0x60, // Numpad 1-9,0
  0x63: 0x6E, // Numpad .
  0xE0: 0xA2, // LeftControl
  0xE1: 0xA0, // LeftShift
  0xE2: 0xA4, // LeftAlt
  0xE3: 0x5B, // LeftGUI (Win)
  0xE4: 0xA3, // RightControl
  0xE5: 0xA1, // RightShift
  0xE6: 0xA5, // RightAlt
  0xE7: 0x5C, // RightGUI (Win)
};
