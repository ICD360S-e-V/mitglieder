import 'dart:io';
import '../logger_service.dart';
import 'input_injector_windows.dart';
import 'input_injector_linux.dart';
import 'input_injector_macos.dart';

final _log = LoggerService();

/// Injects mouse/keyboard input into the local OS on behalf of a remote
/// controller (the Vorsitzer). This is the AGENT side of Fernwartung.
///
/// Platform reality:
///  - Windows: full control via Win32 SendInput (see input_injector_windows.dart)
///  - Linux (X11/XWayland): full control via XTest (input_injector_linux.dart)
///  - macOS: full control via CGEvent (input_injector_macos.dart) — needs the
///    app OUT of the sandbox + Accessibility permission
///  - Android/iOS: NOT supported — mobile is view-only. Returns [NoopInputInjector].
///
/// Coordinates are normalized 0..1 over the shared screen so the protocol is
/// resolution-independent; each backend denormalizes using [setScreenSize]
/// (Windows uses its own 0..65535 absolute mapping and ignores the pixel size).
abstract class InputInjector {
  /// Whether this backend can actually inject on the current OS. When false the
  /// agent must stay view-only (mobile) or surface a setup error (macOS TCC).
  bool get isSupported;

  /// Pixel size of the screen being shared. Used by backends that need absolute
  /// pixel coordinates (Linux/macOS). Safe to call again if the screen changes.
  void setScreenSize(int width, int height);

  /// Move the cursor to a normalized position (0..1, top-left origin).
  Future<void> mouseMove(double nx, double ny);

  /// Press (down=true) or release a mouse button. 0=left, 1=middle, 2=right.
  Future<void> mouseButton(int button, bool down);

  /// Wheel scroll. Positive dy scrolls down, positive dx scrolls right
  /// (matching the controller's pointer-scroll deltas).
  Future<void> mouseWheel(double dx, double dy);

  /// Key event. [hid] is the USB HID usage code (Flutter
  /// PhysicalKeyboardKey.usbHidUsage) — stable across layouts. [character] is
  /// the produced text for printable keys (used for robust Unicode injection),
  /// null for control keys. [down] false = key release.
  Future<void> keyEvent({required int hid, String? character, required bool down});

  /// Release the injector's native resources (X display, etc.).
  void dispose() {}
}

/// View-only fallback: swallows every event. Used on mobile (Android/iOS) and
/// anywhere native injection is unavailable, so the agent can still SHARE the
/// screen while ignoring control attempts.
class NoopInputInjector implements InputInjector {
  final String reason;
  NoopInputInjector([this.reason = 'view-only']);

  @override
  bool get isSupported => false;

  @override
  void setScreenSize(int width, int height) {}

  @override
  Future<void> mouseMove(double nx, double ny) async {}

  @override
  Future<void> mouseButton(int button, bool down) async {}

  @override
  Future<void> mouseWheel(double dx, double dy) async {}

  @override
  Future<void> keyEvent({required int hid, String? character, required bool down}) async {}

  @override
  void dispose() {}
}

/// Build the right injector for the current platform. Desktop backends are wired
/// in a later step; until then desktop also returns a Noop so the agent can be
/// tested in view-only mode first (screen shows on the Vorsitzer side, control
/// is a no-op).
InputInjector createInputInjector() {
  try {
    if (Platform.isWindows) {
      return WindowsInputInjector();
    }
    if (Platform.isLinux) {
      final linux = LinuxInputInjector();
      if (linux.isSupported) return linux;
      // Pure Wayland (no X display) → no XTest → stay view-only.
      linux.dispose();
      _log.info('InputInjector: no X11 display (Wayland?) — view-only', tag: 'REMOTE');
      return NoopInputInjector('wayland-no-xtest');
    }
    if (Platform.isMacOS) {
      // App Sandbox removed + CGEvent bridge in place; the injector prompts for
      // the Accessibility grant at runtime and flips the window to capturable.
      return MacosInputInjector();
    }
  } catch (_) {
    // Platform may throw on unusual embeddings — fall through to Noop.
  }
  return NoopInputInjector('mobile-view-only');
}
