import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/utils/chat_anhang_laden.dart';

/// Hintergrund: `chat/download.php` schickt den Inhalt nur bis 5 MB als
/// Base64 mit, darüber eine `download_url` auf `chat/stream.php`. Die App
/// kannte nur den ersten Weg — ein größerer Anhang ließ sich weder öffnen noch
/// herunterladen.
void main() {
  final pdf = Uint8List.fromList(utf8.encode('%PDF-1.7 Bescheid'));

  Future<Uint8List?> keinStream(String url) async =>
      fail('Stream darf hier nicht geholt werden: $url');

  group('chatAnhangAusAntwort', () {
    test('bis 5 MB: Inhalt als Base64 auf oberster Ebene', () async {
      final a = await chatAnhangAusAntwort({
        'success': true,
        'filename': 'Bescheid.pdf',
        'content': base64Encode(pdf),
        'encoding': 'base64',
      }, streamLaden: keinStream);
      expect(a!.dateiname, 'Bescheid.pdf');
      expect(a.bytes, pdf);
    });

    test('älteres Format unter data (file_data)', () async {
      final a = await chatAnhangAusAntwort({
        'success': true,
        'data': {'filename': 'Bescheid.pdf', 'file_data': base64Encode(pdf)},
      }, streamLaden: keinStream);
      expect(a!.bytes, pdf);
    });

    test('über 5 MB: die Bytes kommen von der download_url', () async {
      const url = 'https://icd360sev.icd360s.de/api/chat/stream.php?id=7&mn=360-1';
      String? geholt;
      final a = await chatAnhangAusAntwort({
        'success': true,
        'filename': 'Scan 12 Seiten.pdf',
        'file_size': 8 * 1024 * 1024,
        'download_url': url,
      }, streamLaden: (u) async {
        geholt = u;
        return pdf;
      });
      expect(geholt, url);
      expect(a!.dateiname, 'Scan 12 Seiten.pdf');
      expect(a.bytes, pdf);
    });

    test('Stream liefert nichts: null statt einer leeren Datei', () async {
      final a = await chatAnhangAusAntwort({
        'filename': 'a.pdf',
        'download_url': 'https://icd360sev.icd360s.de/api/chat/stream.php?id=1',
      }, streamLaden: (_) async => null);
      expect(a, isNull);
    });

    test('weder Inhalt noch Adresse, oder kein Name: null', () async {
      expect(await chatAnhangAusAntwort({'filename': 'a.pdf'}, streamLaden: keinStream), isNull);
      expect(
        await chatAnhangAusAntwort({'content': base64Encode(pdf)}, streamLaden: keinStream),
        isNull,
      );
    });

    test('data als leere Liste (leeres PHP-Array) wirft nicht', () async {
      final a = await chatAnhangAusAntwort({
        'filename': 'a.pdf',
        'content': base64Encode(pdf),
        'data': [],
      }, streamLaden: keinStream);
      expect(a!.bytes, pdf);
    });
  });

  group('chatStreamAdresseErlaubt', () {
    test('nur der Stream-Endpunkt des eigenen Servers', () {
      expect(
        ApiService.chatStreamAdresseErlaubt(
            'https://icd360sev.icd360s.de/api/chat/stream.php?id=7&mn=360-1'),
        isTrue,
      );
    });

    test('Gerätschlüssel und Token gehen an keine andere Adresse', () {
      for (final url in [
        'http://icd360sev.icd360s.de/api/chat/stream.php?id=7',
        'https://icd360sev.icd360s.de.example.com/api/chat/stream.php?id=7',
        'https://example.com/api/chat/stream.php?id=7',
        'https://icd360sev.icd360s.de@example.com/api/chat/stream.php?id=7',
        'https://nutzer@icd360sev.icd360s.de/api/chat/stream.php?id=7',
        'https://icd360sev.icd360s.de:8443/api/chat/stream.php?id=7',
        'https://icd360sev.icd360s.de/api/chat/download.php',
        'https://icd360sev.icd360s.de/api/member/profile.php',
        '/api/chat/stream.php?id=7',
        '',
      ]) {
        expect(ApiService.chatStreamAdresseErlaubt(url), isFalse, reason: url);
      }
    });
  });
}
