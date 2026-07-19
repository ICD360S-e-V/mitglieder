import 'package:flutter/material.dart';

/// WhatsApp-style reaction for a chat message.
enum MessageEmotion { love, laugh, happy, thanks, sad, angry }

extension MessageEmotionX on MessageEmotion {
  String get emoji {
    switch (this) {
      case MessageEmotion.love:   return '❤️';
      case MessageEmotion.laugh:  return '\u{1F602}'; // 😂
      case MessageEmotion.happy:  return '\u{1F642}'; // 🙂
      case MessageEmotion.thanks: return '\u{1F64F}'; // 🙏
      case MessageEmotion.sad:    return '\u{1F622}'; // 😢
      case MessageEmotion.angry:  return '\u{1F620}'; // 😠
    }
  }

  String get label {
    switch (this) {
      case MessageEmotion.love:   return 'Herz';
      case MessageEmotion.laugh:  return 'Lustig';
      case MessageEmotion.happy:  return 'Freude';
      case MessageEmotion.thanks: return 'Danke';
      case MessageEmotion.sad:    return 'Traurig';
      case MessageEmotion.angry:  return 'Ärgerlich';
    }
  }

  Color get tint {
    switch (this) {
      case MessageEmotion.love:   return const Color(0xFFFFE1E7);
      case MessageEmotion.laugh:  return const Color(0xFFFFF3D6);
      case MessageEmotion.happy:  return const Color(0xFFFFF6D6);
      case MessageEmotion.thanks: return const Color(0xFFE7EEFF);
      case MessageEmotion.sad:    return const Color(0xFFE3EDF7);
      case MessageEmotion.angry:  return const Color(0xFFFFE0DC);
    }
  }

  /// Stable string used to store the reaction in the message map / server.
  String get storageKey => name;
}

const List<MessageEmotion> kPickableEmotions = MessageEmotion.values;

MessageEmotion? emotionFromKey(Object? key) {
  if (key == null) return null;
  final s = key.toString();
  for (final e in MessageEmotion.values) {
    if (e.name == s) return e;
  }
  return null;
}

class EmotionPick {
  final MessageEmotion? emotion; // null => remove reaction
  const EmotionPick(this.emotion);
}

/// Compact horizontal emoji bar anchored at [globalPos].
Future<EmotionPick?> showEmotionPicker(
  BuildContext context,
  Offset globalPos, {
  MessageEmotion? current,
}) {
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final position = RelativeRect.fromRect(
    Rect.fromLTWH(globalPos.dx, globalPos.dy, 0, 0),
    Offset.zero & overlay.size,
  );
  return showMenu<EmotionPick>(
    context: context,
    position: position,
    color: Colors.white,
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    items: [
      PopupMenuItem<EmotionPick>(
        enabled: false,
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final e in kPickableEmotions)
                _PickButton(
                  emotion: e,
                  selected: e == current,
                  onTap: () => Navigator.pop(context, EmotionPick(e)),
                ),
              if (current != null)
                InkWell(
                  onTap: () => Navigator.pop(context, const EmotionPick(null)),
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.close, size: 20, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _PickButton extends StatelessWidget {
  final MessageEmotion emotion;
  final bool selected;
  final VoidCallback onTap;
  const _PickButton({required this.emotion, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: emotion.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selected ? emotion.tint : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Text(emotion.emoji, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }
}

/// Chosen reaction rendered as a small sticker in a bubble corner.
class EmotionBadge extends StatelessWidget {
  final MessageEmotion emotion;
  const EmotionBadge({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: emotion.label,
      child: Container(
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: emotion.tint,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 3, offset: const Offset(0, 1)),
          ],
        ),
        child: Text(emotion.emoji, style: const TextStyle(fontSize: 12, height: 1.0)),
      ),
    );
  }
}

/// Smiling-face trigger shown on the other party's messages.
class AddReactionButton extends StatelessWidget {
  const AddReactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Stimmung wählen',
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.amber.shade300, width: 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 2, offset: const Offset(0, 1)),
          ],
        ),
        child: Icon(Icons.mood, size: 16, color: Colors.amber.shade700),
      ),
    );
  }
}
