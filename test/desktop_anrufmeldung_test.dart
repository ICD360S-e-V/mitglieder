// Die Anrufmeldung auf Windows, Linux und macOS.
//
// 🔴 ZWEI VERSEHEN DERSELBEN KLASSE. Der Verteiler las `message['from_name']`
// und `message['call_id']`; der Server schickt `caller_name` und
// `conversation_id` (siehe ChatService). In der Meldung stand deshalb IMMER der
// Rueckfalltext, und die Nutzlast war IMMER null — ein Tipp auf die Meldung
// fuehrte nirgendwohin. Dasselbe Versehen lag im Isolat des
// Hintergrunddienstes und wurde dort am 13.09.2026 behoben; auf dem Desktop
// blieb es stehen.
//
// ⚠️ Ueber den Sperrbildschirm von Windows darf KEINE App zeichnen — nur die
// Shell. Ein Klingelschirm wie auf Android ist dort unmoeglich. Die Antwort des
// Desktops ist `restoreFromTray()`: das Fenster holt sich nach vorne, und der
// Klingelschirm der App ist zu sehen.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String ohneKommentare(String q) => q
    .replaceAllMapped(RegExp(r'/\*.*?\*/', dotAll: true),
        (m) => m[0]!.replaceAll(RegExp(r'[^\n]'), ' '))
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i) + ' ' * (z.length - i);
    })
    .join('\n');

String rumpf(String quelle, String kopf) {
  final start = quelle.indexOf(kopf);
  expect(start, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  var i = start;
  var rund = 0;
  while (i < quelle.length) {
    final c = quelle[i];
    if (c == '(') rund++;
    if (c == ')') rund--;
    if (c == '{' && rund == 0) break;
    i++;
  }
  final ab = i;
  var t = 0;
  while (i < quelle.length) {
    if (quelle[i] == '{') t++;
    if (quelle[i] == '}') {
      t--;
      if (t == 0) return quelle.substring(ab, i + 1);
    }
    i++;
  }
  fail('Rumpf nicht geschlossen: $kopf');
}

void main() {
  late String q;
  late String verteiler;
  late String meldung;

  setUpAll(() {
    q = ohneKommentare(File('lib/services/platform/desktop_platform_service.dart')
        .readAsStringSync());
    // Der Zweig, der `call_offer` verteilt.
    final i = q.indexOf("case 'call_offer':");
    expect(i, greaterThanOrEqualTo(0), reason: 'kein call_offer-Zweig');
    verteiler = q.substring(i, q.indexOf('break;', i) + 6);
    meldung = rumpf(q, 'Future<void> showCallNotification(');
  });

  test('🔴 caller_name, nicht from_name', () {
    expect(verteiler, contains("message['caller_name']"));
    expect(verteiler, isNot(contains("message['from_name']")),
        reason: 'diesen Schluessel schickt der Server nicht — die Meldung nannte '
            'deshalb IMMER den Rueckfalltext');
  });

  test('🔴 conversation_id, nicht call_id', () {
    expect(verteiler, contains("message['conversation_id']"));
    expect(verteiler, isNot(contains("message['call_id']")),
        reason: 'ohne Nutzlast fuehrt ein Tipp auf die Meldung nirgendwohin');
  });

  test('kein await im Verteiler — der ist nicht async', () {
    expect(verteiler, isNot(contains('await')),
        reason: 'der Verteiler ist nicht `async`; ein `await` dort ist ein '
            'Uebersetzungsfehler');
  });

  test('🔴 kein deutscher Satz als Titel — die App hat 28 Sprachen', () {
    // ⚠️ Der deutsche Satz DARF als Rueckfall in `_text(...)` stehen — er ist
    // dort die letzte Zuflucht, wenn die Oberflaeche noch nichts hinterlegt
    // hat. Verboten ist er als LITERAL an `title:`/`body:`. Die erste Fassung
    // dieser Zusicherung verbot ihn ueberall und widersprach damit ihrem
    // eigenen Begruendungstext — sie war rot, obwohl der Code stimmte, und
    // machte die ganze Gegenprobe wertlos.
    expect(meldung, contains("_text('l10n_notifIncomingCall'"));
    expect(meldung, contains("_text('l10n_notifCallingYou'"));
    expect(meldung, contains('title: titel'),
        reason: 'der Titel muss die uebersetzte Fassung sein');
    expect(RegExp(r"title: '").hasMatch(meldung), isFalse,
        reason: 'kein Literal als Titel');
    final chat = rumpf(q, 'Future<void> showChatNotification(');
    expect(chat, contains("_text('l10n_notifNewMessageFrom'"));
    expect(RegExp(r"title: 'Neue Nachricht").hasMatch(chat), isFalse);
  });

  test('EIN Ort fuer den Rueckfall beim Namen', () {
    // Sonst stuende im Verteiler ein deutsches „Unbekannt" und in der Meldung
    // ein uebersetztes — zwei Wahrheiten fuer denselben Fall.
    expect(meldung, contains("_text('l10n_unknown'"));
    expect(verteiler, isNot(contains('l10n_unknown')));
  });

  test('die l10n-Bruecke laedt nach', () {
    // ⚠️ Geschrieben hat das Dashboard, moeglicherweise erst nach dem Start
    // dieses Dienstes.
    final t = rumpf(q, 'Future<String> _text(String schluessel, String rueckfall)');
    expect(t, contains('await p.reload();'));
    expect(t, contains('catch'), reason: 'eine Meldung darf nicht an den '
        'Einstellungen scheitern');
  });

  test('⚠️ die Windows-Antwort: das Fenster holt sich nach vorne', () {
    // Ueber den Sperrbildschirm von Windows darf keine App zeichnen. Was geht,
    // ist das Fenster aus dem Infobereich zurueckzuholen.
    expect(meldung, contains('restoreFromTray()'));
  });
}
