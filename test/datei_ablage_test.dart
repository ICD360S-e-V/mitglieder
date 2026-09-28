import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/datei_ablage.dart';

/// Hintergrund: im Live-Chat ließ sich ein Anhang nur öffnen. Er landete im
/// Zwischenspeicher der App, und das Mitglied kam danach nicht mehr an die
/// Datei heran. Der Herunterladen-Knopf legt sie über [dateiAblegen] ab.
void main() {
  group('sichererDateiname', () {
    test('ein gewöhnlicher Name bleibt, wie er ist', () {
      expect(sichererDateiname('Bescheid Jobcenter.pdf'), 'Bescheid Jobcenter.pdf');
      expect(sichererDateiname('Kündigung – März.pdf'), 'Kündigung – März.pdf');
    });

    test('kein Name vom Server wird zum Pfad', () {
      expect(sichererDateiname('../../etc/passwd'), '_.._etc_passwd');
      expect(sichererDateiname(r'C:\Users\x\a.pdf'), 'C__Users_x_a.pdf');
      expect(sichererDateiname('Rechnung 09/2026.pdf'), 'Rechnung 09_2026.pdf');
    });

    test('was Windows im Namen verbietet, wird zu _', () {
      expect(sichererDateiname('a<b>c:d"e|f?g*h.pdf'), 'a_b_c_d_e_f_g_h.pdf');
      expect(sichererDateiname('zeile\numbruch.txt'), 'zeile_umbruch.txt');
    });

    test('führende Punkte, Punkte und Leerzeichen am Ende fallen weg', () {
      expect(sichererDateiname('.versteckt.pdf'), 'versteckt.pdf');
      expect(sichererDateiname('  brief.pdf. '), 'brief.pdf');
      expect(sichererDateiname('..'), 'download');
      expect(sichererDateiname(''), 'download');
    });

    test('zu lange Namen werden gekürzt, die Endung bleibt', () {
      final lang = '${'a' * 200}.pdf';
      final s = sichererDateiname(lang);
      expect(s.length, 120);
      expect(s, endsWith('.pdf'));
    });

    test('ein Emoji an der Schnittkante wird nicht halbiert', () {
      // 115 Zeichen, dann ein Emoji (zwei UTF-16-Einheiten) über die Grenze.
      final s = sichererDateiname('${'a' * 115}😀😀😀.pdf');
      expect(s, endsWith('.pdf'));
      final kopf = s.substring(0, s.length - 4);
      final letzte = kopf.codeUnitAt(kopf.length - 1);
      expect(letzte & 0xFC00, isNot(0xD800), reason: 'halbes Ersatzpaar');
    });
  });

  group('freierDateiname', () {
    test('frei bleibt frei', () {
      expect(freierDateiname('a.pdf', (_) => false), 'a.pdf');
    });

    test('vorhandene Dateien werden nie überschrieben', () {
      final da = {'a.pdf', 'a(1).pdf'};
      expect(freierDateiname('a.pdf', da.contains), 'a(2).pdf');
      expect(freierDateiname('ohne', {'ohne'}.contains), 'ohne(1)');
    });
  });

  group('dateiAblegen', () {
    final bytes = Uint8List.fromList([0x25, 0x50, 0x44, 0x46, 1, 2, 3]);

    test('Telefon: der Speichern-Dialog bekommt Namen und Inhalt', () async {
      String? name;
      Uint8List? inhalt;
      final ort = await dateiAblegen(
        bytes: bytes,
        dateiname: 'Bescheid 09/2026.pdf',
        dialog: (n, b) async {
          name = n;
          inhalt = b;
          return '/document/primary:Download/$n';
        },
      );
      expect(name, 'Bescheid 09_2026.pdf');
      expect(inhalt, bytes);
      // Zurück kommt der Name, nicht die Dokument-Adresse des Dialogs.
      expect(ort, 'Bescheid 09_2026.pdf');
    });

    test('Telefon: im Dialog abgebrochen heißt null, kein Fehler', () async {
      final ort = await dateiAblegen(
        bytes: bytes,
        dateiname: 'a.pdf',
        dialog: (_, __) async => null,
      );
      expect(ort, isNull);
    });

    test('Rechner: direkt in den Ordner, ohne zu überschreiben', () async {
      final ordner = await Directory.systemTemp.createTemp('datei_ablage_');
      addTearDown(() => ordner.delete(recursive: true));

      final erste = await dateiAblegen(bytes: bytes, dateiname: 'a.pdf', ordner: ordner);
      final zweite = await dateiAblegen(
        bytes: Uint8List.fromList([9]),
        dateiname: 'a.pdf',
        ordner: ordner,
      );

      expect(erste, '${ordner.path}${Platform.pathSeparator}a.pdf');
      expect(zweite, '${ordner.path}${Platform.pathSeparator}a(1).pdf');
      expect(await File(erste!).readAsBytes(), bytes);
      expect(await File(zweite!).readAsBytes(), [9]);
      // Keine Zwischendatei bleibt liegen.
      final namen = ordner.listSync().map((e) => e.uri.pathSegments.last).toSet();
      expect(namen, {'a.pdf', 'a(1).pdf'});
    });
  });
}
