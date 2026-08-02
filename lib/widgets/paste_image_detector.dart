import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Meldet Strg+V / Cmd+V, ohne den normalen Text-Paste anzufassen.
///
/// Bewusst als reiner Mithörer gebaut: [KeyEventResult.ignored] lässt das
/// Ereignis weiter nach oben zu `DefaultTextEditingShortcuts` laufen, das
/// den Text einfügt wie bisher. Liegt nur ein Bild in der Ablage, findet
/// der Text-Paste schlicht nichts und fügt nichts ein — beides kann also
/// gefahrlos nebeneinander laufen.
///
/// `canRequestFocus: false` + `skipTraversal: true`, damit der Knoten dem
/// TextField weder den Fokus noch die Tab-Reihenfolge streitig macht.
class PasteImageDetector extends StatelessWidget {
  const PasteImageDetector({
    super.key,
    required this.onPaste,
    required this.child,
    this.enabled = true,
  });

  final VoidCallback onPaste;
  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onKeyEvent: (node, event) {
        if (event is! KeyDownEvent) return KeyEventResult.ignored;
        if (event.logicalKey != LogicalKeyboardKey.keyV) {
          return KeyEventResult.ignored;
        }
        final keys = HardwareKeyboard.instance;
        // Cmd auf macOS, Strg überall sonst.
        if (!keys.isControlPressed && !keys.isMetaPressed) {
          return KeyEventResult.ignored;
        }
        onPaste();
        return KeyEventResult.ignored;
      },
      child: child,
    );
  }
}
