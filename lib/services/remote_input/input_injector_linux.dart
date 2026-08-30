import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'input_injector.dart';

// ─── libX11 / libXtst FFI typedefs ──────────────────────────────────────────
typedef _OpenDisplayC = Pointer<Void> Function(Pointer<Utf8>);
typedef _OpenDisplayD = Pointer<Void> Function(Pointer<Utf8>);
typedef _DisplayIntC = Int32 Function(Pointer<Void>, Int32);
typedef _DisplayIntD = int Function(Pointer<Void>, int);
typedef _CloseFlushC = Int32 Function(Pointer<Void>);
typedef _CloseFlushD = int Function(Pointer<Void>);
typedef _KeysymToKeycodeC = Uint32 Function(Pointer<Void>, Uint64);
typedef _KeysymToKeycodeD = int Function(Pointer<Void>, int);
typedef _FakeMotionC = Int32 Function(Pointer<Void>, Int32, Int32, Int32, Uint64);
typedef _FakeMotionD = int Function(Pointer<Void>, int, int, int, int);
typedef _FakeButtonKeyC = Int32 Function(Pointer<Void>, Uint32, Int32, Uint64);
typedef _FakeButtonKeyD = int Function(Pointer<Void>, int, int, int);

/// Linux input injection via XTest (X11). Works under X11 and XWayland; on a
/// PURE Wayland session there is no X display and this reports unsupported
/// ([isSupported] false) so the agent stays view-only. Keys are mapped
/// HID → X keysym → runtime keycode (XKeysymToKeycode) so they follow the
/// member's actual layout, and modifiers compose for shortcuts.
class LinuxInputInjector extends InputInjector {
  Pointer<Void> _display = nullptr;
  bool _ok = false;
  int _screenW = 0;
  int _screenH = 0;

  late final _DisplayIntD _displayWidth;
  late final _DisplayIntD _displayHeight;
  late final _CloseFlushD _flush;
  late final _CloseFlushD _close;
  late final _KeysymToKeycodeD _keysymToKeycode;
  late final _FakeMotionD _fakeMotion;
  late final _FakeButtonKeyD _fakeButton;
  late final _FakeButtonKeyD _fakeKey;

  LinuxInputInjector() {
    try {
      final x11 = DynamicLibrary.open('libX11.so.6');
      final xtst = DynamicLibrary.open('libXtst.so.6');

      final openDisplay = x11.lookupFunction<_OpenDisplayC, _OpenDisplayD>('XOpenDisplay');
      _displayWidth = x11.lookupFunction<_DisplayIntC, _DisplayIntD>('XDisplayWidth');
      _displayHeight = x11.lookupFunction<_DisplayIntC, _DisplayIntD>('XDisplayHeight');
      _flush = x11.lookupFunction<_CloseFlushC, _CloseFlushD>('XFlush');
      _close = x11.lookupFunction<_CloseFlushC, _CloseFlushD>('XCloseDisplay');
      _keysymToKeycode =
          x11.lookupFunction<_KeysymToKeycodeC, _KeysymToKeycodeD>('XKeysymToKeycode');
      _fakeMotion = xtst.lookupFunction<_FakeMotionC, _FakeMotionD>('XTestFakeMotionEvent');
      _fakeButton = xtst.lookupFunction<_FakeButtonKeyC, _FakeButtonKeyD>('XTestFakeButtonEvent');
      _fakeKey = xtst.lookupFunction<_FakeButtonKeyC, _FakeButtonKeyD>('XTestFakeKeyEvent');

      _display = openDisplay(nullptr); // uses $DISPLAY
      if (_display != nullptr) {
        _screenW = _displayWidth(_display, 0);
        _screenH = _displayHeight(_display, 0);
        _ok = _screenW > 0 && _screenH > 0;
      }
    } catch (_) {
      _ok = false;
    }
  }

  @override
  bool get isSupported => _ok;

  @override
  void setScreenSize(int width, int height) {
    // Prefer the real X screen size; only fall back to the caller's hint.
    if (_screenW <= 0 && width > 0) _screenW = width;
    if (_screenH <= 0 && height > 0) _screenH = height;
  }

  @override
  Future<void> mouseMove(double nx, double ny) async {
    if (!_ok) return;
    final x = (nx.clamp(0.0, 1.0) * _screenW).round();
    final y = (ny.clamp(0.0, 1.0) * _screenH).round();
    _fakeMotion(_display, 0, x, y, 0);
    _flush(_display);
  }

  @override
  Future<void> mouseButton(int button, bool down) async {
    if (!_ok) return;
    // X button numbers: 1=left, 2=middle, 3=right.
    final xbtn = button == 2 ? 3 : (button == 1 ? 2 : 1);
    _fakeButton(_display, xbtn, down ? 1 : 0, 0);
    _flush(_display);
  }

  @override
  Future<void> mouseWheel(double dx, double dy) async {
    if (!_ok) return;
    // X wheel = button 4 (up) / 5 (down) / 6 (left) / 7 (right), one click each.
    if (dy != 0) {
      final btn = dy > 0 ? 5 : 4; // controller dy>0 = scroll down
      final clicks = (dy.abs() / 40).ceil().clamp(1, 10);
      for (var i = 0; i < clicks; i++) {
        _fakeButton(_display, btn, 1, 0);
        _fakeButton(_display, btn, 0, 0);
      }
    }
    if (dx != 0) {
      final btn = dx > 0 ? 7 : 6;
      final clicks = (dx.abs() / 40).ceil().clamp(1, 10);
      for (var i = 0; i < clicks; i++) {
        _fakeButton(_display, btn, 1, 0);
        _fakeButton(_display, btn, 0, 0);
      }
    }
    _flush(_display);
  }

  @override
  Future<void> keyEvent({required int hid, String? character, required bool down}) async {
    if (!_ok) return;
    final page = (hid >> 16) & 0xFFFF;
    final usage = hid & 0xFFFF;
    final keysym = (page == 0x07 || page == 0x00) ? _hidToKeysym[usage] : null;
    if (keysym == null) return; // no mapping — skip (text fallback not on X11 M1)
    final keycode = _keysymToKeycode(_display, keysym);
    if (keycode == 0) return;
    _fakeKey(_display, keycode, down ? 1 : 0, 0);
    _flush(_display);
  }

  @override
  void dispose() {
    if (_display != nullptr) {
      try {
        _close(_display);
      } catch (_) {}
      _display = nullptr;
    }
    _ok = false;
  }
}

/// USB HID Keyboard usage (page 0x07) → X keysym. Resolved to a runtime keycode
/// via XKeysymToKeycode, so it follows the member's active layout.
final Map<int, int> _hidToKeysym = {
  // a-z (0x04..0x1D) → XK_a..XK_z (0x61..0x7A)
  for (int i = 0; i < 26; i++) 0x04 + i: 0x61 + i,
  // 1-9 (0x1E..0x26) → '1'..'9', 0 (0x27) → '0'
  0x1E: 0x31, 0x1F: 0x32, 0x20: 0x33, 0x21: 0x34, 0x22: 0x35,
  0x23: 0x36, 0x24: 0x37, 0x25: 0x38, 0x26: 0x39, 0x27: 0x30,
  0x28: 0xFF0D, // Return
  0x29: 0xFF1B, // Escape
  0x2A: 0xFF08, // BackSpace
  0x2B: 0xFF09, // Tab
  0x2C: 0x0020, // space
  0x2D: 0x002D, // minus
  0x2E: 0x003D, // equal
  0x2F: 0x005B, // bracketleft
  0x30: 0x005D, // bracketright
  0x31: 0x005C, // backslash
  0x33: 0x003B, // semicolon
  0x34: 0x0027, // apostrophe
  0x35: 0x0060, // grave
  0x36: 0x002C, // comma
  0x37: 0x002E, // period
  0x38: 0x002F, // slash
  0x39: 0xFFE5, // Caps_Lock
  // F1-F12 (0x3A..0x45) → XK_F1..XK_F12 (0xFFBE..0xFFC9)
  for (int i = 0; i < 12; i++) 0x3A + i: 0xFFBE + i,
  0x46: 0xFF61, // Print
  0x47: 0xFF14, // Scroll_Lock
  0x48: 0xFF13, // Pause
  0x49: 0xFF63, // Insert
  0x4A: 0xFF50, // Home
  0x4B: 0xFF55, // Prior (PageUp)
  0x4C: 0xFFFF, // Delete
  0x4D: 0xFF57, // End
  0x4E: 0xFF56, // Next (PageDown)
  0x4F: 0xFF53, // Right
  0x50: 0xFF51, // Left
  0x51: 0xFF54, // Down
  0x52: 0xFF52, // Up
  0x53: 0xFF7F, // Num_Lock
  0x54: 0xFFAF, // KP_Divide
  0x55: 0xFFAA, // KP_Multiply
  0x56: 0xFFAD, // KP_Subtract
  0x57: 0xFFAB, // KP_Add
  0x58: 0xFF8D, // KP_Enter
  0x59: 0xFFB1, 0x5A: 0xFFB2, 0x5B: 0xFFB3, 0x5C: 0xFFB4, 0x5D: 0xFFB5,
  0x5E: 0xFFB6, 0x5F: 0xFFB7, 0x60: 0xFFB8, 0x61: 0xFFB9, 0x62: 0xFFB0, // KP 1-9,0
  0x63: 0xFFAE, // KP_Decimal
  0xE0: 0xFFE3, // Control_L
  0xE1: 0xFFE1, // Shift_L
  0xE2: 0xFFE9, // Alt_L
  0xE3: 0xFFEB, // Super_L
  0xE4: 0xFFE4, // Control_R
  0xE5: 0xFFE2, // Shift_R
  0xE6: 0xFFEA, // Alt_R
  0xE7: 0xFFEC, // Super_R
};
