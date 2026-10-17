import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/anonymous_chat_service.dart';

/// App-Fehler #137 (17.10.2026): dreimal 400 „Invalid anonymous_id“ von
/// public/anonymous_chat/init.php. Die App behielt jede gespeicherte ID ab 16
/// Zeichen — auch eine, die die Regel des Servers verletzt; der Chat ohne
/// Anmeldung öffnete sich auf diesem Telefon dann nie.
void main() {
  test('die Regel des Servers: 16–64 Zeichen aus A–Z, a–z, 0–9, „_“, „-“ (nach dem Trimmen)', () {
    expect(anonymeIdGueltig('0123456789abcdef0123456789abcdef'), isTrue);   // wie die App sie macht
    expect(anonymeIdGueltig('0123456789abcdef'), isTrue);                   // 16
    expect(anonymeIdGueltig('6f1c2e1a-8b9d-4c3e-9f20-1a2b3c4d5e6f'), isTrue); // UUID
    expect(anonymeIdGueltig('  0123456789abcdef0123  '), isTrue);           // trimmt wie der Server
    expect(anonymeIdGueltig('0123456789abcde'), isFalse);                   // 15
    expect(anonymeIdGueltig('a' * 65), isFalse);
    expect(anonymeIdGueltig('2026-10-17T23:02:17.123Z'), isFalse);          // „:“ und „.“
    expect(anonymeIdGueltig('ünïcödé-ünïcödé-ünïcödé'), isFalse);
    expect(anonymeIdGueltig(null), isFalse);
  });

  test('eine gültige gespeicherte ID bleibt — derselbe Gesprächsfaden', () {
    const alt = '0123456789abcdef0123456789abcdef';
    expect(anonymeIdWaehlen(alt, Random(1)), alt);
  });

  test('eine ungültige wird ersetzt — durch eine, die der Server annimmt', () {
    for (final kaputt in [null, '', 'kurz', '2026-10-17T23:02:17.123Z-handy', 'x' * 80]) {
      final neu = anonymeIdWaehlen(kaputt, Random(7));
      expect(anonymeIdGueltig(neu), isTrue, reason: '$kaputt → $neu');
      expect(neu, matches(RegExp(r'^[0-9a-f]{32}$')));
    }
  });

  test('ensureId wählt über anonymeIdWaehlen und speichert die neue', () {
    final q = File('lib/services/anonymous_chat_service.dart').readAsStringSync();
    final i = q.indexOf('Future<String> ensureId()');
    final rumpf = q.substring(i, q.indexOf('\n  }\n', i));
    expect(rumpf, contains('anonymeIdWaehlen(gespeichert'));
    expect(rumpf, contains('await prefs.setString(_idKey, id);'));
    expect(rumpf, isNot(contains('id.length < 16')), reason: 'die alte Prüfung ließ ungültige IDs durch');
  });
}
