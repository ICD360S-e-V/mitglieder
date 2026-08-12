import 'package:flutter/material.dart';

/// WhatsApp-style reaction for a chat message.
///
/// The user picks the reaction manually (an icon next to the message opens a
/// small emoji bar). Ownership rule is enforced by the caller *and* by the
/// server: you can react to the *other* party's messages, not your own.
///
/// ⚠️ Diese Datei ist in **beiden** Apps (vorsitzer + mitglieder) zeichengleich.
/// Wer hier eine Reaktion hinzufügt, muss sie an drei Stellen nachziehen,
/// sonst verschwindet sie stillschweigend:
///   1. die Kopie im jeweils anderen Repository,
///   2. die Whitelist `$allowed` in `api/chat/react.php` (sonst HTTP 400),
///   3. ein Release **beider** Apps — eine ältere App kennt den neuen
///      Schlüssel nicht, `emotionFromKey` gibt `null` zurück und die Blase
///      bleibt leer. Kein Absturz, aber eben auch keine Reaktion.
///
/// Die Reihenfolge der Aufzählung ist zugleich die Reihenfolge im Auswahlband.
/// Die erste Zeile ist bewusst die von WhatsApp gewohnte — wer das kennt,
/// muss hier nichts Neues lernen.
enum MessageEmotion {
  thumbsUp,
  love,
  laugh,
  wow,
  sad,
  thanks,
  done,
  question,
  clap,
  happy,
  thumbsDown,
  angry,
}

extension MessageEmotionX on MessageEmotion {
  String get emoji {
    switch (this) {
      case MessageEmotion.thumbsUp:
        return '\u{1F44D}'; // 👍
      case MessageEmotion.love:
        return '\u{2764}\u{FE0F}'; // ❤️
      case MessageEmotion.laugh:
        return '\u{1F602}'; // 😂
      case MessageEmotion.wow:
        return '\u{1F62E}'; // 😮
      case MessageEmotion.sad:
        return '\u{1F622}'; // 😢
      case MessageEmotion.thanks:
        return '\u{1F64F}'; // 🙏
      case MessageEmotion.done:
        return '\u{2705}'; // ✅
      case MessageEmotion.question:
        return '\u{2753}'; // ❓
      case MessageEmotion.clap:
        return '\u{1F44F}'; // 👏
      case MessageEmotion.happy:
        return '\u{1F642}'; // 🙂
      case MessageEmotion.thumbsDown:
        return '\u{1F44E}'; // 👎
      case MessageEmotion.angry:
        return '\u{1F620}'; // 😠
    }
  }

  /// German tooltip label. Doubles as the screen-reader text, deshalb eine
  /// Aussage und kein Emoji-Name: „Verstanden" sagt, was gemeint ist,
  /// „Daumen hoch" nur, was zu sehen ist.
  String get label {
    switch (this) {
      case MessageEmotion.thumbsUp:
        return 'Verstanden';
      case MessageEmotion.love:
        return 'Herz';
      case MessageEmotion.laugh:
        return 'Lustig';
      case MessageEmotion.wow:
        return 'Überrascht';
      case MessageEmotion.sad:
        return 'Traurig';
      case MessageEmotion.thanks:
        return 'Danke';
      case MessageEmotion.done:
        return 'Erledigt';
      case MessageEmotion.question:
        return 'Frage dazu';
      case MessageEmotion.clap:
        return 'Bravo';
      case MessageEmotion.happy:
        return 'Freude';
      case MessageEmotion.thumbsDown:
        return 'Nicht einverstanden';
      case MessageEmotion.angry:
        return 'Ärgerlich';
    }
  }

  /// Soft tint behind the emoji (readable on light *and* on the dark/violet
  /// own-message bubbles of both apps).
  Color get tint {
    switch (this) {
      case MessageEmotion.thumbsUp:
        return const Color(0xFFE3F1FF);
      case MessageEmotion.love:
        return const Color(0xFFFFE1E7);
      case MessageEmotion.laugh:
        return const Color(0xFFFFF3D6);
      case MessageEmotion.wow:
        return const Color(0xFFFFEFD6);
      case MessageEmotion.sad:
        return const Color(0xFFE3EDF7);
      case MessageEmotion.thanks:
        return const Color(0xFFE7EEFF);
      case MessageEmotion.done:
        return const Color(0xFFDFF3E3);
      case MessageEmotion.question:
        return const Color(0xFFEDE4FF);
      case MessageEmotion.clap:
        return const Color(0xFFFFF0DA);
      case MessageEmotion.happy:
        return const Color(0xFFFFF6D6);
      case MessageEmotion.thumbsDown:
        return const Color(0xFFECECEC);
      case MessageEmotion.angry:
        return const Color(0xFFFFE0DC);
    }
  }

  /// Stable string used to store the reaction in the message map / server.
  /// ⚠️ Muss in `varchar(16)` passen — der längste Schlüssel ist
  /// `thumbsDown` mit 10 Zeichen.
  String get storageKey => name;
}

/// Order shown in the picker bar (= declaration order).
const List<MessageEmotion> kPickableEmotions = MessageEmotion.values;

/// Wie weit die Reaktions-Plakette unten aus der Sprechblase herausragt.
///
/// ⚠️ Der Aufrufer muss der Blase genau so viel **unteren Rand** geben, wenn
/// eine Reaktion anliegt. Grund: Flutter testet Treffer nur innerhalb der
/// Elterngrenzen — eine Plakette, die per negativem Offset über den Rand
/// hinausragt, wäre sichtbar, aber nicht antippbar. Sie hängt deshalb *im*
/// Stack, und der Stack wird durch den Rand der Blase entsprechend höher.
const double kReaktionUeberhang = 16;

/// Rand rechts neben der Blase, in dem der Auslöser (Smiley) sitzt.
///
/// ⚠️ Er lag früher *über* der ersten Textzeile, oben rechts in der Blase.
/// In der Sichtprüfung war „…beim Jobcenter ist bestätigt" an genau der
/// Stelle verdeckt. Er steht deshalb jetzt daneben, im freien Raum rechts
/// der eingehenden Blase — Auslöser gibt es nur dort, eigene Nachrichten
/// darf man nicht bewerten.
const double kAusloeserRand = 30;

/// Resolve a stored reaction key back to an emotion (null / unknown -> null).
///
/// Unbekannte Schlüssel ergeben bewusst `null` statt einer Notfall-Reaktion:
/// eine ältere App soll lieber nichts zeigen als das Falsche.
MessageEmotion? emotionFromKey(Object? key) {
  if (key == null) return null;
  final s = key.toString();
  for (final e in MessageEmotion.values) {
    if (e.name == s) return e;
  }
  return null;
}

/// True, wenn auf der Nachricht eine Reaktion liegt, **diese App sie aber nicht
/// kennt** — der Regelfall, solange nur eine der beiden Apps ausgeliefert ist.
///
/// ⚠️ Ohne diese Unterscheidung sieht „keine Reaktion" und „eine Reaktion, die
/// ich nicht darstellen kann" identisch aus, nämlich leer. Genau das ist der
/// Grund, warum die alte Fassung stillschweigend versagte: der Vorsitzer setzte
/// eine Reaktion, das Mitglied sah eine blanke Blase und meldete „kommt nicht
/// an" — obwohl sie ankam und nur nicht darstellbar war. Ein sichtbares
/// Ersatzzeichen macht daraus eine Aussage: *hier ist etwas, deine App ist zu alt.*
bool istUnbekannteReaktion(Object? key) {
  if (key == null) return false;
  final s = key.toString();
  if (s.isEmpty) return false;
  return emotionFromKey(s) == null;
}

/// True, wenn überhaupt eine Reaktion anliegt — bekannt oder nicht. Der
/// Aufrufer braucht das, um den Überhang-Rand zu reservieren.
bool hatReaktion(Object? key) =>
    emotionFromKey(key) != null || istUnbekannteReaktion(key);

/// Result of the picker: [emotion] == null means "remove reaction".
class EmotionPick {
  final MessageEmotion? emotion;
  const EmotionPick(this.emotion);
}

/// Show a compact emoji bar anchored at [globalPos].
/// Returns the chosen [EmotionPick], or null if dismissed.
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

  // Zwölf Reaktionen passen nicht mehr in eine Zeile. `Wrap` bricht selbst
  // um, statt auf einem schmalen Telefon über den Rand zu laufen; die Breite
  // ist auf den tatsächlich verfügbaren Platz gedeckelt, nicht geraten.
  // 12 Reaktionen sollen 6+6 stehen, nicht 5+5+2.
  //
  // ⚠️ Diese Zahl ist GEMESSEN, nicht gerechnet. Ein Emoji ist deutlich
  // breiter als seine Schriftgröße: bei 26 pt beträgt der Vorschub 34,7 dp,
  // ein Knopf mit 8 dp Polster also 52,7 statt der naheliegenden 44. Sechs
  // davon bräuchten 332 dp — mehr, als ein 360-dp-Telefon hergibt, weshalb
  // zweimal nachgebessert wurde und es zweimal bei 5 pro Zeile blieb.
  // Mit 6 dp Polster misst ein Knopf 48,7 dp, sechs davon 308 dp: es passt,
  // und die Trefferfläche liegt weiter über den 44 dp aus WCAG 2.5.5.
  final maxBreite = MediaQuery.of(context).size.width - 32;

  return showMenu<EmotionPick>(
    context: context,
    position: position,
    color: Colors.white,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    items: [
      PopupMenuItem<EmotionPick>(
        enabled: false,
        padding: EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxBreite < 320 ? maxBreite : 320,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (final e in kPickableEmotions)
                  _PickButton(
                    emotion: e,
                    selected: e == current,
                    onTap: () => Navigator.pop(context, EmotionPick(e)),
                  ),
                if (current != null)
                  Tooltip(
                    message: 'Reaktion entfernen',
                    child: InkWell(
                      onTap: () =>
                          Navigator.pop(context, const EmotionPick(null)),
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        padding: const EdgeInsets.all(9),
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
  const _PickButton({
    required this.emotion,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: emotion.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        // Gemessen 48,7 dp Trefferfläche (34,7 dp Emoji-Vorschub + 2×6 dp
        // Polster + 2×1 dp Rand) — über den 44 dp, die WCAG 2.5.5 für
        // Zeigereingaben nennt. In einem Verein, dessen Mitglieder teils
        // motorisch eingeschränkt sind, ist das keine Feinheit.
        child: Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selected ? emotion.tint : Colors.transparent,
            shape: BoxShape.circle,
            border: selected
                ? Border.all(color: Colors.black26, width: 1)
                : null,
          ),
          child: Text(
            emotion.emoji,
            style: const TextStyle(fontSize: 26, height: 1.0),
          ),
        ),
      ),
    );
  }
}

/// Die gewählte Reaktion als Plakette am **unteren** Rand der Sprechblase —
/// dort, wo WhatsApp sie zeigt und wo das Auge sie sucht.
///
/// ⚠️ Vorher saß sie mit 12 dp Schriftgröße *oben rechts in* der Blase, also
/// über der ersten Textzeile und auf dem violetten Verlauf der eigenen
/// Nachrichten. Mitglieder haben gemeldet, dass sie Reaktionen „nicht sehen" —
/// gesetzt und gespeichert waren sie, nur eben unauffindbar klein am falschen
/// Ort.
class EmotionBadge extends StatelessWidget {
  final MessageEmotion emotion;

  const EmotionBadge({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: emotion.label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: emotion.tint,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          emotion.emoji,
          style: const TextStyle(fontSize: 20, height: 1.0),
        ),
      ),
    );
  }
}

/// Ersatzplakette für eine Reaktion, die diese App nicht kennt.
///
/// Bewusst ein **Material-Icon und kein Emoji**: die Icon-Schrift ist in der
/// App gebündelt und stellt sich überall dar. Ein Emoji als Platzhalter könnte
/// auf demselben Gerät dasselbe Tofu-Kästchen ergeben, das wir gerade
/// vermeiden wollen.
class UnbekannteReaktionBadge extends StatelessWidget {
  const UnbekannteReaktionBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Reaktion erhalten — bitte App aktualisieren',
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFECECEC),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          Icons.emoji_emotions_outlined,
          size: 18,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}

/// Was an der Blase hängt, entschieden aus dem **rohen** Wert von
/// `msg['reaction']`: die bekannte Reaktion, sonst das Ersatzzeichen.
///
/// Die drei Chat-Dialoge sind entkoppelte Kopien; diese eine Stelle hält
/// wenigstens die Entscheidung „bekannt / unbekannt" zusammen.
class ReaktionsPlakette extends StatelessWidget {
  final Object? schluessel;
  const ReaktionsPlakette({super.key, required this.schluessel});

  @override
  Widget build(BuildContext context) {
    final bekannt = emotionFromKey(schluessel);
    if (bekannt != null) return EmotionBadge(emotion: bekannt);
    return const UnbekannteReaktionBadge();
  }
}

/// Smiling-face trigger shown on the other party's messages: tap it to pick
/// the reaction the message deserves.
class AddReactionButton extends StatelessWidget {
  const AddReactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Reaktion wählen',
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.amber.shade400, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          Icons.add_reaction_outlined,
          size: 20,
          color: Colors.amber.shade800,
        ),
      ),
    );
  }
}
