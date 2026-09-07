import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/virenpruefung.dart';

void main() {
  test('gesetzt → Datum, leer → null', () {
    expect(virenpruefungDatum('2026-09-07 21:55:03'), '07.09.2026');
    expect(virengeprueft('2026-09-07 21:55:03'), isTrue);
    for (final v in [null, '', 'nie']) {
      expect(virenpruefungDatum(v), isNull);
      expect(virengeprueft(v), isFalse);
    }
  });
  test('Anhangzeile zeigt das Schild und alle 28 Sprachen haben die Texte', () {
    var b = File('lib/widgets/chat_attachment_item.dart').readAsStringSync();
    b = b.replaceAll(RegExp(r'^\s*//.*$', multiLine: true), '');
    expect(b, contains("virengeprueft(attachment['virengeprueft_am'])"));
    expect(b, contains('.virengeprueftAm('));
    expect(b, contains('.nichtVirengeprueft'));
    final arbs = Directory('lib/l10n').listSync().where((f) => f.path.endsWith('.arb')).toList();
    expect(arbs.length, 28);
    for (final f in arbs) {
      final s = File(f.path).readAsStringSync();
      expect(s, contains('"virengeprueftAm"'), reason: f.path);
      expect(s, contains('{datum}'), reason: f.path);
      expect(s, contains('"nichtVirengeprueft"'), reason: f.path);
    }
  });
}
