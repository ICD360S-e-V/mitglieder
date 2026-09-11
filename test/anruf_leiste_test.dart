// Der Rueckweg in einen laufenden Anruf.
//
// Der Anrufschirm ist eine GESCHOBENE Route. Wer sie wegwischt, hat den Anruf
// weiterhin am Laufen — der Dienst besitzt ihn —, sah ihn aber nirgends mehr
// und konnte ihn nicht beenden. Ein solcher unsichtbarer Anruf weist jeden
// naechsten mit „busy" ab; am 11.09.2026 im Betrieb beobachtet.
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';

String ohneKommentare(String q) => q
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i);
    })
    .join('\n');

void main() {
  late String leiste, dash, main_;

  setUpAll(() {
    leiste = ohneKommentare(File('lib/widgets/anruf_leiste.dart').readAsStringSync());
    dash = ohneKommentare(File('lib/screens/mitglied_dashboard.dart').readAsStringSync());
    main_ = ohneKommentare(File('lib/main.dart').readAsStringSync());
  });

  test('die Leiste haengt ueber der ganzen App', () {
    expect(main_, contains('AnrufLeiste('),
        reason: 'sonst deckt sie geschobene Seiten und Dialoge nicht ab');
  });

  test('sie zeigt sich nur, wenn der Anrufschirm NICHT zu sehen ist', () {
    expect(leiste, contains('AnrufRueckweg.schirmSichtbar'));
    expect(leiste, contains('CallState.inCall'));
    // `ringing` gehoert dem Annehmen-Schirm.
    expect(leiste.contains('CallState.ringing'), isFalse);
  });

  test('sie kann auflegen, nicht nur zurueckfuehren', () {
    expect(leiste, contains('VoiceCallService().endCall()'),
        reason: 'ohne Auflegen bleibt ein toter Anruf bis zum App-Neustart');
    expect(leiste, contains('AnrufRueckweg.zurueck'));
  });

  test('der Anrufschirm meldet sich an UND wieder ab', () {
    // Meldet er sich nicht ab, bleibt die Leiste fuer immer verborgen — der
    // Anruf waere wieder unsichtbar, nur eine Ebene tiefer versteckt.
    expect(dash, contains('AnrufRueckweg.schirmSichtbar.value = true'));
    expect(dash, contains('AnrufRueckweg.schirmSichtbar.value = false'));
    expect(dash, contains('AnrufRueckweg.oeffner ='),
        reason: 'ohne Oeffner zeigt die Leiste keinen Rueckweg');
  });

  test('es gibt genau EINEN Weg, den Anrufschirm zu zeigen', () {
    // Ein zweiter Weg wuerde sich beim naechsten Umbau von diesem
    // unterscheiden — und dann meldet sich mal jemand an und mal nicht.
    final n = 'VideoCallScreen(remoteName:'.allMatches(dash).length;
    expect(n, 1, reason: 'gefunden: $n Stellen, die den Anrufschirm bauen');
  });

  test('weiss auf dem Leisten-Gruen erfuellt WCAG AA', () {
    double kanal(double c) =>
        c <= 0.03928 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
    const r = 0x2E / 255, g = 0x7D / 255, b = 0x32 / 255;
    final l = 0.2126 * kanal(r) + 0.7152 * kanal(g) + 0.0722 * kanal(b);
    final k = 1.05 / (l + 0.05);
    expect(k, greaterThanOrEqualTo(4.5),
        reason: 'weiss auf dem Gruen: ${k.toStringAsFixed(2)}:1');
    expect(leiste, contains('0xFF2E7D32'));
  });
}
