import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// 🔴 Kein Wortlaut ins Protokoll — kein Chattext, kein Benachrichtigungstext,
/// keine rohe Server-Antwort.
///
/// WAS PASSIERT IST, am 17.10.2026 auf dem Server gezählt: `LoggerService`
/// lädt die Protokollzeilen zum Server (`logs/mitglieder_android/`,
/// `logs/mitglieder_windows/`, über `pushLogs` auch `logs/client/`). Darin
/// lagen u. a. **über 170.000** Zeilen `WS received: <die ersten 100 Zeichen
/// jedes WebSocket-Rahmens>` — bei einer Chat-Nachricht Absender und Anfang
/// des Textes, also die Gespräche der Mitglieder mit dem Vorstand — und
/// 7.105 Titel von Benachrichtigungen („Neue Nachricht von …“).
///
/// Dieselbe Regel gilt in der Vorsitzer- und der Schatzmeister-App
/// (`test/kein_inhalt_im_protokoll_test.dart` dort, vorsitzer#516 / #1300,
/// schatzmeister#28). Diese Datei ist die Kopie davon.
///
/// ⚠️ OHNE AUSNAHMELISTE: eine Regel mit Ausnahmen wird erweitert, eine ohne
/// nicht. Erlaubt bleibt, was über den Inhalt nur die FORM verrät:
/// `.length`, `.id`, `…Id`, `.isEmpty`.
void main() {
  /// Der Anfang jedes Log-Aufrufs, in allen Schreibweisen dieser App.
  final logAnfang = RegExp(
    r'(?<![\w.])(?:_log|_logger|log|LoggerService\(\))\.(?:info|debug|warning|error)\(',
  );

  /// Wie in der Vorsitzer-App: `$message` ist Inhalt, `${message.id}` nicht.
  final wortlaut = RegExp(
    r'\$\{?(title|body|message|senderName|nachricht|betreff|subject|content)'
    // `${message.conversationId}` ist eine Nummer — jede Eigenschaft auf …Id
    r'\b(?!\w)(?!\.(length|id|isEmpty|isNotEmpty|\w*Id\b))',
  );

  /// Wortlaut, der unter einem anderen Namen kommt.
  final nutzdaten = RegExp(
    // ${response.body}, ${r.body.substring(…)} — die Länge darf bleiben
    r'\$\{[\w.]*\bbody\b(?!\.(length|isEmpty|isNotEmpty))'
    // ${jsonEncode(anfrage)}
    r'|\$\{\s*jsonEncode\('
    // ${request.headers}, ${request.fields}
    r'|\$\{[\w.]*\.(headers|fields)\b'
    // ${ticketEvent.title}, ${json['title']} — aber ${data['comment']['id']}
    // ist eine Nummer, kein Inhalt
    r'|\$\{[\w.]+\.(title|preview|comment|subject)\b(?!\.(length|isEmpty|isNotEmpty))'
    r"""|\$\{[\w.]+\[['"](title|body|text|content|comment|subject|preview)['"]\]"""
    r"""(?!\[['"]id['"]\]|\.(length|isEmpty|isNotEmpty))""",
  );

  /// Alle Log-Aufrufe in lib/ — jeweils der ganze Aufruf bis zur schließenden
  /// Klammer, über Zeilen hinweg, ohne `//`-Kommentare darin.
  List<({String ort, String aufruf})> logAufrufe() {
    final dateien = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .toList();
    expect(dateien.length, greaterThan(50), reason: 'zu wenige Dateien — Test blind');
    final ergebnis = <({String ort, String aufruf})>[];
    for (final f in dateien) {
      final q = f.readAsStringSync();
      for (final m in logAnfang.allMatches(q)) {
        final aufruf = StringBuffer();
        var i = m.start;
        var tiefe = 0;
        String? zeichen;
        while (i < q.length) {
          final c = q[i];
          if (zeichen != null) {
            if (c == r'\') {
              aufruf.write(q.substring(i, (i + 2).clamp(0, q.length)));
              i += 2;
              continue;
            }
            if (c == zeichen) zeichen = null;
          } else if (c == '/' && i + 1 < q.length && q[i + 1] == '/') {
            final ende = q.indexOf('\n', i);
            i = ende < 0 ? q.length : ende;
            continue;
          } else if (c == "'" || c == '"') {
            zeichen = c;
          } else if (c == '(') {
            tiefe++;
          } else if (c == ')') {
            tiefe--;
            if (tiefe == 0) {
              aufruf.write(c);
              break;
            }
          }
          aufruf.write(c);
          i++;
        }
        final zeile = '\n'.allMatches(q.substring(0, m.start)).length + 1;
        ergebnis.add((ort: '${f.path}:$zeile', aufruf: aufruf.toString()));
      }
    }
    expect(ergebnis.length, greaterThan(450), reason: 'zu wenige Log-Aufrufe — Test blind');
    return ergebnis;
  }

  test('kein Log-Aufruf in lib/ trägt Wortlaut oder Namen', () {
    final befunde = [
      for (final a in logAufrufe())
        if (wortlaut.firstMatch(a.aufruf) case final t?) '${a.ort}  ${t.group(0)}',
    ];
    expect(befunde, isEmpty, reason: 'Wortlaut im Protokoll:\n${befunde.join('\n')}');
  });

  test('kein Log-Aufruf trägt rohe Antworten, Anfragen, Kopfzeilen oder Betreffe', () {
    final befunde = [
      for (final a in logAufrufe())
        if (nutzdaten.firstMatch(a.aufruf) case final t?) '${a.ort}  ${t.group(0)}',
    ];
    expect(befunde, isEmpty, reason: 'Nutzdaten im Protokoll:\n${befunde.join('\n')}');
  });

  test('der Wächter sieht auch den zweiten Teil eines geteilten Textes', () {
    // Die Vorlage las nur das erste Zeichenkettenstück — so ein Aufruf wäre
    // durchgerutscht.
    const geteilt = "_log.info('Gesendet: '\n        '\$message', tag: 'X');";
    final m = logAnfang.firstMatch(geteilt)!;
    expect(wortlaut.hasMatch(geteilt.substring(m.start)), isTrue);
    expect(nutzdaten.hasMatch(r"_log.info('x ${response.body}')"), isTrue);
    expect(nutzdaten.hasMatch(r"_log.info('x ${response.body.length} Byte')"), isFalse);
    expect(nutzdaten.hasMatch(r"_log.info('x ${ticketEvent.title}')"), isTrue);
    expect(nutzdaten.hasMatch(r"_log.info('x ${json['title']}')"), isTrue);
    expect(nutzdaten.hasMatch(r"_log.info('id=${data['comment']['id']}')"), isFalse);
    expect(wortlaut.hasMatch(r"'Neue Nachricht (conv ${message.conversationId})'"), isFalse);
    expect(logAnfang.hasMatch("LoggerService().info('x')"), isTrue);
    expect(logAnfang.hasMatch("dialog.info('x')"), isFalse);
    expect(nutzdaten.hasMatch(r"_log.info('x ${data['comment']}')"), isTrue);
    expect(nutzdaten.hasMatch(r"_log.info('x ${jsonEncode(rumpf)}')"), isTrue);
    expect(nutzdaten.hasMatch(r"_log.info('x ${request.headers}')"), isTrue);
  });

  test('die Länge zu protokollieren bleibt erlaubt und wird genutzt', () {
    // ⚠️ Sonst liesse sich der Wächter erfüllen, indem man gar nichts mehr
    // protokolliert — und verlöre die Auskunft „kam die Benachrichtigung an?",
    // um derentwillen die Zeile existiert.
    final ntfy = File('lib/services/ntfy_service.dart').readAsStringSync();
    expect(ntfy, contains(r'${title.length}'));
    expect(ntfy, contains(r'${body.length}'));
    final chat = File('lib/services/chat_service.dart').readAsStringSync();
    expect(chat, contains(r"'WS received: ${data.toString().length} Z.'"));
  });
}
