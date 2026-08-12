import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/chat_message_merge.dart';
import 'package:icd360sev_mitglied/utils/message_emotion.dart';

/// Die Schlüssel, die `api/chat/react.php` in `$allowed` führt.
///
/// ⚠️ Das PHP liegt nur auf dem Server, nicht im Repository — dieser Test ist
/// deshalb die einzige Stelle, an der die Kopplung überhaupt auffallen kann.
/// Ein Schlüssel, den der Server nicht kennt, ergibt HTTP 400; der Client nimmt
/// die Reaktion optimistisch zurück, und für den Nutzer passiert schlicht
/// nichts. Wer hier eine Reaktion ergänzt, ergänzt sie auch dort.
const _serverWhitelist = <String>{
  'thumbsUp', 'love', 'laugh', 'wow', 'sad', 'thanks',
  'done', 'question', 'clap', 'happy', 'thumbsDown', 'angry',
};

void main() {
  group('MessageEmotion', () {
    test('Schlüssel decken sich zeichengleich mit der Server-Whitelist', () {
      final imClient = MessageEmotion.values.map((e) => e.storageKey).toSet();
      expect(imClient, _serverWhitelist);
    });

    test('jeder Schlüssel passt in varchar(16)', () {
      for (final e in MessageEmotion.values) {
        expect(e.storageKey.length, lessThanOrEqualTo(16),
            reason: '${e.name} ist zu lang für die Spalte reaction');
      }
    });

    test('Schlüssel sind eindeutig und werden verlustfrei zurückgelesen', () {
      final keys = MessageEmotion.values.map((e) => e.storageKey).toList();
      expect(keys.toSet().length, keys.length);
      for (final e in MessageEmotion.values) {
        expect(emotionFromKey(e.storageKey), e);
      }
    });

    test('unbekannter oder leerer Schlüssel ergibt null, nicht Notfall-Emoji', () {
      // Eine ältere App bekommt eine neue Reaktion geschickt: sie soll nichts
      // zeigen, nicht das Falsche.
      expect(emotionFromKey('sparkles'), isNull);
      expect(emotionFromKey(''), isNull);
      expect(emotionFromKey(null), isNull);
    });

    test('jede Reaktion hat Emoji, Beschriftung und Tönung', () {
      for (final e in MessageEmotion.values) {
        expect(e.emoji, isNotEmpty);
        expect(e.label, isNotEmpty);
        expect(e.tint, isNotNull);
      }
    });

    test('Beschriftungen sind eindeutig — sie sind auch der Vorlesetext', () {
      final labels = MessageEmotion.values.map((e) => e.label).toList();
      expect(labels.toSet().length, labels.length);
    });

    test('das Auswahlband zeigt alle Reaktionen', () {
      expect(kPickableEmotions.length, MessageEmotion.values.length);
      expect(kPickableEmotions.toSet(), MessageEmotion.values.toSet());
    });
  });

  group('unbekannte Reaktion aus einer neueren App', () {
    test('wird als unbekannt erkannt, nicht als „keine Reaktion"', () {
      // Solange nur eine der beiden Apps ausgeliefert ist, ist das der
      // Regelfall — und ohne diese Unterscheidung sieht er aus wie „nichts
      // gesetzt". Genau das war die Meldung „die Reaktion kommt nicht an".
      expect(istUnbekannteReaktion('sparkles'), isTrue);
      expect(hatReaktion('sparkles'), isTrue);
    });

    test('leer und null zählen NICHT als unbekannte Reaktion', () {
      // react.php löscht mit '' und liefert dann `reaction: null`. Beides ist
      // „keine Reaktion" — würde es als unbekannt gelten, hinge an jeder
      // Nachricht ohne Reaktion ein Ersatzzeichen.
      for (final leer in [null, '']) {
        expect(istUnbekannteReaktion(leer), isFalse, reason: 'für $leer');
        expect(hatReaktion(leer), isFalse, reason: 'für $leer');
      }
    });

    test('eine bekannte Reaktion ist nicht unbekannt', () {
      for (final e in MessageEmotion.values) {
        expect(istUnbekannteReaktion(e.storageKey), isFalse);
        expect(hatReaktion(e.storageKey), isTrue);
      }
    });

    testWidgets('die Plakette zeigt ein Ersatzzeichen statt gar nichts',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: ReaktionsPlakette(schluessel: 'sparkles')),
      ));
      expect(find.byType(UnbekannteReaktionBadge), findsOneWidget);
      expect(find.byType(EmotionBadge), findsNothing);
    });

    testWidgets('eine bekannte Reaktion zeigt ihr Emoji', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: ReaktionsPlakette(schluessel: 'thumbsUp')),
      ));
      expect(find.byType(EmotionBadge), findsOneWidget);
      expect(find.byType(UnbekannteReaktionBadge), findsNothing);
      expect(find.text(MessageEmotion.thumbsUp.emoji), findsOneWidget);
    });
  });

  group('chatNachrichtenZusammenfuehren', () {
    test('REGRESSION: die Reaktion auf einer bekannten Nachricht kommt an', () {
      // Genau der Fehler, der gemeldet wurde: die alte Fassung übersprang
      // jede Nachricht, deren id schon in der Liste stand, und ließ die
      // Reaktion damit für immer unsichtbar.
      final vorhanden = [
        <String, dynamic>{'id': 1, 'message': 'Hallo'},
      ];
      final vomServer = [
        <String, dynamic>{'id': 1, 'message': 'Hallo', 'reaction': 'thumbsUp'},
      ];

      final ergebnis = chatNachrichtenZusammenfuehren(vorhanden, vomServer);

      expect(ergebnis.length, 1);
      expect(ergebnis.first['reaction'], 'thumbsUp');
    });

    test('eine zurückgenommene Reaktion verschwindet wieder', () {
      final vorhanden = [
        <String, dynamic>{'id': 1, 'message': 'Hallo', 'reaction': 'love'},
      ];
      final vomServer = [
        <String, dynamic>{'id': 1, 'message': 'Hallo', 'reaction': null},
      ];

      final ergebnis = chatNachrichtenZusammenfuehren(vorhanden, vomServer);

      expect(emotionFromKey(ergebnis.first['reaction']), isNull);
    });

    test('die vorhandene Map wird an Ort und Stelle aktualisiert', () {
      // Der Reaktions-Wähler und der WebSocket-Zuhörer halten eine Referenz
      // auf genau diese Map. Wird sie ersetzt, laufen deren optimistische
      // Schreibvorgänge ins Leere.
      final alt = <String, dynamic>{'id': 7, 'message': 'A'};
      final ergebnis = chatNachrichtenZusammenfuehren(
        [alt],
        [
          <String, dynamic>{'id': 7, 'message': 'A', 'reaction': 'done'}
        ],
      );

      expect(identical(ergebnis.first, alt), isTrue);
      expect(alt['reaction'], 'done');
    });

    test('rein lokale Felder überleben das Zusammenführen', () {
      // is_urgent und channel setzt nur der Sende-Pfad; messages.php liefert
      // sie nicht zurück. addAll darf sie deshalb nicht wegräumen.
      final vorhanden = [
        <String, dynamic>{
          'id': 3,
          'message': 'Dringend',
          'is_urgent': true,
          'channel': 'sms',
        },
      ];
      final vomServer = [
        <String, dynamic>{'id': 3, 'message': 'Dringend', 'reaction': 'wow'},
      ];

      final ergebnis = chatNachrichtenZusammenfuehren(vorhanden, vomServer);

      expect(ergebnis.first['is_urgent'], true);
      expect(ergebnis.first['channel'], 'sms');
      expect(ergebnis.first['reaction'], 'wow');
    });

    test('neue Nachrichten kommen dazu, Reihenfolge folgt dem Server', () {
      final vorhanden = [
        <String, dynamic>{'id': 1, 'message': 'eins'},
      ];
      final vomServer = [
        <String, dynamic>{'id': 1, 'message': 'eins'},
        <String, dynamic>{'id': 2, 'message': 'zwei'},
        <String, dynamic>{'id': 3, 'message': 'drei'},
      ];

      final ergebnis = chatNachrichtenZusammenfuehren(vorhanden, vomServer);

      expect(ergebnis.map((m) => m['id']).toList(), [1, 2, 3]);
    });

    test('keine Doppelungen — der ursprüngliche Zweck bleibt erfüllt', () {
      final vorhanden = [
        <String, dynamic>{'id': 1, 'message': 'eins'},
        <String, dynamic>{'id': 2, 'message': 'zwei'},
      ];
      final vomServer = [
        <String, dynamic>{'id': 1, 'message': 'eins'},
        <String, dynamic>{'id': 2, 'message': 'zwei'},
      ];

      final ergebnis = chatNachrichtenZusammenfuehren(vorhanden, vomServer);

      expect(ergebnis.length, 2);
      expect(ergebnis.map((m) => m['id']).toList(), [1, 2]);
    });

    test('was der Server nicht mehr liefert, ist verfallen und verschwindet', () {
      // 5-Minuten-Verfall: purge_expired_chat.php räumt die Zeile weg. Sie
      // darf dann nicht als Karteileiche in der Liste stehen bleiben.
      final vorhanden = [
        <String, dynamic>{'id': 1, 'message': 'alt'},
        <String, dynamic>{'id': 2, 'message': 'neu'},
      ];
      final vomServer = [
        <String, dynamic>{'id': 2, 'message': 'neu'},
      ];

      final ergebnis = chatNachrichtenZusammenfuehren(vorhanden, vomServer);

      expect(ergebnis.map((m) => m['id']).toList(), [2]);
    });

    test('leere Ausgangsliste übernimmt die Serverliste unverändert', () {
      final vomServer = [
        <String, dynamic>{'id': 1, 'message': 'eins'},
      ];
      final ergebnis = chatNachrichtenZusammenfuehren([], vomServer);
      expect(ergebnis.length, 1);
      expect(ergebnis.first['id'], 1);
    });
  });

  group('EmotionBadge in der Sprechblase', () {
    /// Baut die Blase so nach, wie die drei Chat-Dialoge sie bauen: Plakette
    /// unten überhängend, Überhang über den unteren Rand des Blasen-Containers.
    Widget blase({required VoidCallback beiTipp}) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Der Überhang-Rand sitzt außen, die gemalte Fläche innen.
                // `getRect` auf einem Container mit Rand liefert die
                // Layout-Box *einschließlich* Rand — für „überlappt sichtbar"
                // brauchen wir aber die gemalte Kante.
                Container(
                  margin: const EdgeInsets.only(bottom: kReaktionUeberhang),
                  child: Container(
                    key: const ValueKey('blase'),
                    padding: const EdgeInsets.all(12),
                    width: 200,
                    height: 60,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: beiTipp,
                    child: const EmotionBadge(emotion: MessageEmotion.thumbsUp),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    testWidgets('die Plakette bleibt innerhalb des Stack und ist antippbar',
        (tester) async {
      // ⚠️ Der Grund für den Überhang-Rand: Flutter wertet Treffer nur
      // innerhalb der Elterngrenzen aus. Läge die Plakette per negativem
      // Offset außerhalb, wäre sie sichtbar, aber tot.
      var getippt = false;
      await tester.pumpWidget(blase(beiTipp: () => getippt = true));

      final stack = tester.getRect(find.byType(Stack).first);
      final plakette = tester.getRect(find.byType(EmotionBadge));

      expect(plakette.bottom, lessThanOrEqualTo(stack.bottom + 0.01),
          reason: 'ragt unten aus dem Stack heraus und wäre nicht antippbar');
      expect(plakette.top, greaterThanOrEqualTo(stack.top - 0.01));

      await tester.tap(find.byType(EmotionBadge));
      expect(getippt, isTrue);
    });

    testWidgets('die Plakette überlappt die Blase sichtbar', (tester) async {
      // Der WhatsApp-Effekt: sie hängt an der Unterkante, statt darüber oder
      // sauber darunter zu schweben.
      await tester.pumpWidget(blase(beiTipp: () {}));

      // Nicht `find.byType(Container).first` — MaterialApp und Scaffold
      // bringen eigene Container mit, und der erste ist keiner von unseren.
      final blasenRect = tester.getRect(find.byKey(const ValueKey('blase')));
      final plakette = tester.getRect(find.byType(EmotionBadge));

      expect(plakette.top, lessThan(blasenRect.bottom));
      expect(plakette.bottom, greaterThan(blasenRect.bottom));
    });

    testWidgets('REGRESSION: die Plakette ist deutlich größer als die alten 12 dp',
        (tester) async {
      // Vorher: 12 dp Emoji in 2,5 dp Polster, oben rechts *in* der Blase über
      // dem Text. Genau das haben Mitglieder als „sehe ich nicht" gemeldet.
      await tester.pumpWidget(blase(beiTipp: () {}));

      final plakette = tester.getRect(find.byType(EmotionBadge));
      expect(plakette.height, greaterThanOrEqualTo(24),
          reason: 'zu klein, um im Chat aufzufallen');
      expect(plakette.width, greaterThanOrEqualTo(24));
    });
  });
}
