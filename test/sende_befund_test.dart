import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/utils/sende_befund.dart';

/// 🔴 30.09.2026 — ein Mitglied an Windows 11 teilt seinen Bildschirm, die
/// Verbindung steht, über das Relais fließen rund 100 kB/s, und der Vorsitz
/// sieht Schwarz. Im Protokoll dieses Geräts stand dazu: „answered offer,
/// sharing screen". Mehr nicht.
///
/// Seither schreibt die Sitzung, was sie aufnimmt, kodiert und sendet.
void main() {
  ({String id, String type, Map<dynamic, dynamic> werte}) b(
          String id, String type, Map<dynamic, dynamic> werte) =>
      (id: id, type: type, werte: werte);

  final voll = [
    b('C1', 'codec', {'mimeType': 'video/VP8'}),
    b('C2', 'codec', {'mimeType': 'video/H264'}),
    b('C3', 'codec', {'mimeType': 'audio/opus'}),
    b('S1', 'media-source', {'kind': 'video', 'width': 1920, 'height': 1080, 'frames': 450}),
    b('S2', 'media-source', {'kind': 'audio'}),
    b('O1', 'outbound-rtp', {
      'kind': 'video',
      'codecId': 'C1',
      'framesEncoded': 440,
      'keyFramesEncoded': 3,
      'frameWidth': 1920,
      'frameHeight': 1080,
      'framesPerSecond': 14.8,
      'bytesSent': 3 * 1024 * 1024,
      'packetsSent': 2900,
      'pliCount': 2,
      'firCount': 0,
      'nackCount': 5,
      'encoderImplementation': 'libvpx',
      'qualityLimitationReason': 'none',
      'targetBitrate': 2500000.0,
    }),
    b('O2', 'outbound-rtp', {'kind': 'audio', 'bytesSent': 9999}),
  ];

  group('aus der Statistik', () {
    test('Aufnahme, Kodierer und Bitten der Gegenseite werden gelesen', () {
      final s = SendeBefund.ausStatistik(voll);
      expect(s.sender, isTrue);
      expect(s.quelleBilder, 450);
      expect('${s.quelleBreite}×${s.quelleHoehe}', '1920×1080');
      expect(s.kodiert, 440);
      expect(s.schluesselbilder, 3);
      expect(s.pli, 2);
      expect(s.nack, 5);
      expect(s.kodierer, 'libvpx');
      expect(s.grenze, 'none');
      expect(s.zielKbit, 2500);
    });

    /// ⚠️ Ausgehandelt sind mehrere Codecs. Im Protokoll muss der stehen, mit
    /// dem GESENDET wird — der, auf den `codecId` zeigt.
    test('der Codec ist der des Senders, nicht der letzte der Liste', () {
      expect(SendeBefund.ausStatistik(voll).codec, 'VP8');
    });

    test('die Tonspur zählt nicht als Bildsender', () {
      final s = SendeBefund.ausStatistik([
        b('O2', 'outbound-rtp', {'kind': 'audio', 'bytesSent': 9999}),
      ]);
      expect(s.sender, isFalse);
      expect(s.lage(null), SendeBefund.lageKeinSender);
    });

    test('Zahlen als Text werden ebenfalls gelesen', () {
      final s = SendeBefund.ausStatistik([
        b('O1', 'outbound-rtp', {'kind': 'video', 'framesEncoded': '12', 'pliCount': '4'}),
      ]);
      expect(s.kodiert, 12);
      expect(s.pli, 4);
    });
  });

  group('die Lage', () {
    /// flutter-webrtc#2137: scheitert der Start der Aufnahme, bekommt die App
    /// trotzdem eine Spur zurück — sie liefert nur nie ein Bild.
    test('eine Aufnahme ohne Bilder ist als solche benannt', () {
      const s = SendeBefund();
      expect(s.lage(null), SendeBefund.lageKeineAufnahme);
    });

    test('aufgenommen, aber nicht kodiert', () {
      const s = SendeBefund(quelleBilder: 80);
      expect(s.lage(null), SendeBefund.lageNichtKodiert);
    });

    test('kodiert und wächst: läuft', () {
      const vorher = SendeBefund(quelleBilder: 80, kodiert: 75, pli: 1);
      const jetzt = SendeBefund(quelleBilder: 155, kodiert: 150, pli: 1);
      expect(vorher.lage(null), SendeBefund.lageLaeuft);
      expect(jetzt.lage(vorher), SendeBefund.lageLaeuft);
    });

    /// Das ist das Zeichen, dass die GEGENSEITE mit dem Strom nicht
    /// zurechtkommt: sie bittet in einem fort um ein neues Vollbild.
    test('drei neue Bitten in fünf Sekunden: die Gegenseite kommt nicht mit', () {
      const vorher = SendeBefund(quelleBilder: 80, kodiert: 75, pli: 1);
      const jetzt = SendeBefund(quelleBilder: 155, kodiert: 150, pli: 3, fir: 1);
      expect(jetzt.lage(vorher), SendeBefund.lageBittet);
    });

    test('eine einzelne Bitte gehört zum Verbindungsaufbau', () {
      const vorher = SendeBefund(quelleBilder: 80, kodiert: 75);
      const jetzt = SendeBefund(quelleBilder: 155, kodiert: 150, pli: 1);
      expect(jetzt.lage(vorher), SendeBefund.lageLaeuft);
    });

    test('kein neues Bild seit der letzten Messung: steht', () {
      const vorher = SendeBefund(quelleBilder: 80, kodiert: 75);
      const jetzt = SendeBefund(quelleBilder: 155, kodiert: 75);
      expect(jetzt.lage(vorher), SendeBefund.lageSteht);
    });
  });

  test('die Protokollzeile nennt alle Stationen', () {
    final p = SendeBefund.ausStatistik(voll).protokoll;
    expect(p, contains('Aufnahme 1920×1080 450 Bilder'));
    expect(p, contains('kodiert 1920×1080 VP8 (libvpx) 440 Bilder'));
    expect(p, contains('3 Schlüsselbilder'));
    expect(p, contains('PLI 2, FIR 0, NACK 5'));
    expect(p, contains('Ziel 2500 kbit/s'));
    expect(p, contains('Grenze none'));
    expect(p, contains('3072 kB'));
  });

  test('ohne Messwerte stehen Fragezeichen, keine erfundenen Werte', () {
    expect(const SendeBefund().protokoll, contains('Aufnahme ?×? 0 Bilder'));
  });

  /// Jede Zeile wird hochgeladen — bei einem Mitglied am Mobilfunkvertrag.
  group('wann eine Messung ins Protokoll geht', () {
    bool f(int takt, {bool wechsel = false}) =>
        SendeBefund.faellig(takt, wechsel: wechsel);

    test('die ersten beiden, eine nach 30 s, dann jede Minute', () {
      expect([for (var t = 1; t <= 40; t++) if (f(t)) t], [1, 2, 6, 12, 24, 36]);
    });

    test('ein Wechsel der Lage immer', () {
      expect(f(9, wechsel: true), isTrue);
    });
  });

  /// Geprüft am Quelltext: es bräuchte zwei verbundene Gegenstellen, um es
  /// laufen zu lassen.
  group('die Sitzung schreibt ihren Befund', () {
    final quelle = File('lib/services/remote_agent_service.dart').readAsStringSync();

    test('die Uhr startet mit der Antwort und endet mit der Sitzung', () {
      expect(quelle, contains('_befundUhrStarten();'));
      final aufraeumen = quelle.substring(quelle.indexOf('void _cleanup()'));
      expect(aufraeumen, contains('_befundUhr?.cancel()'));
      expect(aufraeumen, contains('Bild am Ende'));
    });

    /// ⚠️ Eine eigene Uhr. Der Regeltakt läuft nur in der Automatik und bricht
    /// ab, solange es keine Umlaufzeit gibt — also genau dann, wenn etwas
    /// nicht stimmt.
    test('unabhängig vom Regeltakt der Bildgüte', () {
      final lesen = RegExp(r'Future<void> _befundLesen\(\) async \{(.*?)\n  \}', dotAll: true)
          .firstMatch(quelle)!
          .group(1)!;
      expect(lesen, isNot(contains('Bildguete.automatik')));
      expect(lesen, contains('SendeBefund.ausStatistik'));
    });

    test('Angebot und Antwort werden zusammengefasst', () {
      expect(quelle, contains("_sdpProtokollieren('Angebot', offer.sdp)"));
      expect(quelle, contains("_sdpProtokollieren('Antwort', answer.sdp)"));
    });

    test('welcher Bildschirm aufgenommen wird, steht im Protokoll', () {
      expect(quelle, contains('RemoteAgent: Aufnahme — '));
    });
  });
}
