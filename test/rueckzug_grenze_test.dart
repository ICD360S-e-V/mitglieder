// Die Zahl im Dialog muss die Zahl im Server sein.
//
// Anlass ist ein echter Fehler, und zwar ein dreifacher: der Abbruch-Dialog
// versprach dem Besucher drei Versuche, check_age.php sperrte aber schon beim
// ERSTEN Rueckzug im 90-Tage-Fenster, und finalize.php erst beim dritten.
// Keine der drei Zahlen stimmte mit einer anderen. Gemerkt haette man das erst
// an jemandem, der nach einem einzigen Abbruch nicht mehr hineinkam — und der
// haette dem Text geglaubt, nicht dem Code.
//
// Seit RueckzugFenster gibt es serverseitig nur noch eine Zahl. Dieser Test
// liest sie aus dem PHP und haelt daneben, was die App in allen 28 Sprachen
// verspricht. Er kann kein PHP ausfuehren — er braucht es auch nicht: es geht
// einzig darum, dass niemand die Grenze verschiebt und die Beschriftung
// stehen laesst.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Liest eine `public const NAME = <zahl>;` aus der PHP-Klasse.
int _phpKonstante(String quelle, String name) {
  final treffer =
      RegExp('public const $name\\s*=\\s*(\\d+)\\s*;').firstMatch(quelle);
  expect(
    treffer,
    isNotNull,
    reason: 'RueckzugFenster::$name nicht gefunden. Wurde die Konstante '
        'umbenannt? Dann muss dieser Test mitziehen — und die Texte auch.',
  );
  return int.parse(treffer!.group(1)!);
}

void main() {
  final php = File('server/api/lib/RueckzugFenster.php');
  final arbs = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  test('die PHP-Klasse und die Sprachdateien liegen ueberhaupt vor', () {
    expect(php.existsSync(), isTrue,
        reason: 'server/api/lib/RueckzugFenster.php fehlt — ohne sie hat der '
            'Test nichts, woran er die Texte messen koennte.');
    expect(arbs.length, greaterThanOrEqualTo(28));
  });

  test('jeder Abbruch-Dialog nennt Grenze und Fenster aus dem Server', () {
    final quelle = php.readAsStringSync();
    final grenze = _phpKonstante(quelle, 'GRENZE');
    final fenster = _phpKonstante(quelle, 'FENSTER_TAGE');

    final fehlen = <String>[];
    for (final arb in arbs) {
      final daten =
          jsonDecode(arb.readAsStringSync()) as Map<String, dynamic>;
      final text = daten['wizardAbandonDialogBody'] as String?;
      if (text == null) {
        fehlen.add('${arb.uri.pathSegments.last}: Schluessel fehlt');
        continue;
      }
      if (!text.contains('$grenze')) {
        fehlen.add('${arb.uri.pathSegments.last}: nennt $grenze nicht');
      }
      if (!text.contains('$fenster')) {
        fehlen.add('${arb.uri.pathSegments.last}: nennt $fenster nicht');
      }
    }

    expect(
      fehlen,
      isEmpty,
      reason: 'Der Server laesst $grenze Rueckzuege in $fenster Tagen zu, '
          'diese Texte versprechen etwas anderes:\n${fehlen.join('\n')}\n\n'
          'Beides gehoert zusammen — tools/'
          'update_wizard_withdrawal_limit_strings.py zieht die Texte nach.',
    );
  });
}
