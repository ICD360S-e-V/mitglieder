// Der Gerätename im Beweisbündel einer Unterschrift — eine der Säulen der
// eindeutigen Zuordnung (Art. 26 eIDAS). Bis 10/2026 stand er nur unter
// Android und iOS drin; auf dem Rechner blieb das Feld leer.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/screens/signatur_screen.dart';

void main() {
  group('geraetUndSystem', () {
    test('Gerät und System, durch einen Mittelpunkt getrennt', () {
      expect(geraetUndSystem('samsung SM-X236B', 'Android 14'),
          'samsung SM-X236B · Android 14');
    });

    test('fehlt eines, steht das andere allein', () {
      expect(geraetUndSystem('  ', 'Ubuntu 24.04.1 LTS'), 'Ubuntu 24.04.1 LTS');
      expect(geraetUndSystem('DESKTOP-1A2B3C', ''), 'DESKTOP-1A2B3C');
    });

    test('fehlt beides: null statt eines leeren Textes', () {
      expect(geraetUndSystem('', ' '), isNull);
    });

    test('nie länger als die Spalte device_hostname (120 Zeichen)', () {
      final lang = geraetUndSystem('R' * 100, 'Windows 11 Pro 23H2 ' * 3)!;
      expect(lang.length, 120);
      expect(lang, startsWith('${'R' * 100} · '));
    });
  });

  test('🔴 alle fünf Plattformen liefern einen Namen', () {
    final q = File('lib/screens/signatur_screen.dart').readAsStringSync();
    final start = q.indexOf('Future<String?> _geraetename()');
    expect(start, isNot(-1));
    final rumpf = q.substring(start, q.indexOf('\n  }\n', start));
    for (final p in ['isAndroid', 'isIOS', 'isMacOS', 'isWindows', 'isLinux']) {
      expect(rumpf, contains('Platform.$p'),
          reason: 'ohne $p bleibt das Feld dort leer');
    }
  });
}
