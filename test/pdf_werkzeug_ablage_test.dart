import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/screens/pdf_werkzeug_screen.dart';

/// „Eigenes PDF unterschreiben": wohin das Ergebnis geht.
void main() {
  group('unterschriebenName', () {
    test('Name aus dem Pfad, mit _unterschrieben', () {
      expect(unterschriebenName('/storage/emulated/0/Download/Mietvertrag.pdf'),
          'Mietvertrag_unterschrieben.pdf');
      expect(unterschriebenName(r'C:\Users\x\Kündigung.PDF'),
          'Kündigung_unterschrieben.pdf');
      expect(unterschriebenName('/tmp/ohne_endung'),
          'ohne_endung_unterschrieben.pdf');
    });
  });

  // ⚠️ Der Grund für dieses Werkstück: bis 10/2026 schrieb `_ablegen` auf dem
  // Telefon ins App-Verzeichnis (`getApplicationDocumentsDirectory`) — von
  // außen unsichtbar. Das darf nicht zurückkommen: abgelegt wird nur noch
  // über `dateiAblegen(..., immerDialog: true)`, also über den
  // Speichern-Dialog, in dem das Mitglied den Ort wählt.
  test('das unterschriebene PDF geht über den Speichern-Dialog, nicht ins App-Verzeichnis',
      () {
    final quelle = File('lib/screens/pdf_werkzeug_screen.dart').readAsStringSync();
    expect(quelle, isNot(contains('getApplicationDocumentsDirectory')));
    expect(quelle, isNot(contains('getDownloadsDirectory')));
    expect(quelle, contains('immerDialog: true'));
  });
}
