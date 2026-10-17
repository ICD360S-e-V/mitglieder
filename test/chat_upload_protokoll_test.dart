import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/services/logger_service.dart';
import 'package:icd360sev_mitglied/utils/chat_upload_protokoll.dart';

/// App-Fehler #136 (17.10.2026): fünfmal HTTP 400 auf `chat/upload.php`, und
/// die App schrieb nichts. Jetzt steht der Grund im Protokoll — ohne den
/// Dateinamen, der oft selbst ein Personendatum ist.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const name = 'Bescheid_Mustermann_2026.pdf';

  group('Meldungen von chat/upload.php', () {
    test('jede Form mit Dateinamen verliert den Namen', () {
      for (final vor in kUploadMeldungenMitNamen) {
        final m = chatUploadMeldungOhneNamen('$vor$name', const [name]);
        expect(m, '$vor$kDateiPlatzhalter');
        expect(m, isNot(contains('Mustermann')));
      }
      // Die Virusmeldung steht im Original hinter einem deutschen Anfang.
      expect(
        chatUploadMeldungOhneNamen(
            'Datei abgelehnt: Virus/Malware erkannt in $name', const []),
        'Datei abgelehnt: Virus/Malware erkannt in $kDateiPlatzhalter',
      );
    });

    test('der Name fällt auch ohne die Liste der gesendeten Dateien', () {
      expect(
          chatUploadMeldungOhneNamen('Upload error for file: $name', const []),
          'Upload error for file: $kDateiPlatzhalter');
    });

    test(
        'eine unbekannte Formulierung mit dem Namen verliert ihn über die Liste',
        () {
      final m = chatUploadMeldungOhneNamen(
          'Die Datei $name ist kaputt', const [name]);
      expect(m, 'Die Datei $kDateiPlatzhalter ist kaputt');
    });

    test('Endung, Typ und Größe bleiben — sie sagen nichts über die Person',
        () {
      const typ =
          'File type not allowed: heic. Allowed: pdf, png, jpeg, jpg, txt';
      expect(chatUploadMeldungOhneNamen(typ, const ['IMG_1.heic']), typ);
      expect(
          chatUploadMeldungOhneNamen('Invalid file type: image/heic', const []),
          'Invalid file type: image/heic');
      expect(
          chatUploadMeldungOhneNamen(
              'Total file size (55.12MB) exceeds maximum (50MB)', const []),
          'Total file size (55.12MB) exceeds maximum (50MB)');
      for (final s in [
        'Missing required fields: conversation_id, mitgliedernummer',
        'No files uploaded',
        'Maximum 10 files allowed',
        'Access denied',
        'Conversation not found',
      ]) {
        expect(chatUploadMeldungOhneNamen(s, const [name]), s);
      }
    });

    test('höchstens 200 Zeichen', () {
      final m = chatUploadMeldungOhneNamen('x' * 500, const []);
      expect(m.length, 201);
      expect(m, endsWith('…'));
    });
  });

  group('Antwort des Servers', () {
    test('JSON mit message', () {
      final a = jsonEncode(
          {'success': false, 'message': 'Upload error for file: $name'});
      expect(chatUploadGrundAusAntwort(a, const [name]),
          'Upload error for file: $kDateiPlatzhalter');
    });

    test('keine JSON-Antwort (nginx 413) geht nie roh ins Protokoll', () {
      const html =
          '<html><head><title>413 Request Entity Too Large</title></head></html>';
      final g = chatUploadGrundAusAntwort(html, const []);
      expect(g, 'Antwort ohne JSON (${html.length} Zeichen)');
      expect(g, isNot(contains('<')));
    });

    test('JSON ohne Meldung', () {
      expect(chatUploadGrundAusAntwort('{"success":false}', const []),
          'Antwort ohne Meldung');
      expect(
          chatUploadGrundAusAntwort('[1,2]', const []), 'Antwort ohne Meldung');
    });
  });

  group('Ausnahmen', () {
    test('der volle Pfad aus PathNotFoundException verschwindet', () {
      const pfad =
          '/data/user/0/de.icd360s.mitglieder/cache/file_picker/17292/$name';
      final e = PathNotFoundException(pfad,
          const OSError('No such file or directory', 2), 'Cannot open file');
      final t = chatUploadAusnahmeOhneNamen(e, const [pfad]);
      expect(t, contains(kDateiPlatzhalter));
      expect(t, isNot(contains('Mustermann')));
      expect(t, isNot(contains('/data/')));
      expect(t, contains('No such file or directory'));
    });

    test('auch ein anderer Pfad als der gesendete (Android und Windows)', () {
      final a = chatUploadAusnahmeOhneNamen(
          Exception("path = '/storage/emulated/0/Download/$name'"), const []);
      expect(a, isNot(contains('Mustermann')));
      final w = chatUploadAusnahmeOhneNamen(
          Exception(
              r'Cannot open C:\Users\Ana\Documents\Arbeitsvertrag_Popescu.pdf'),
          const []);
      expect(w, isNot(contains('Popescu')));
      expect(w, isNot(contains('Ana')));
    });

    test('Linux und macOS: der Benutzername im Pfad verschwindet', () {
      for (final p in [
        '/home/ana/Dokumente/x.pdf',
        '/Users/ana/Desktop/x.pdf'
      ]) {
        final t =
            chatUploadAusnahmeOhneNamen(Exception('Cannot open $p'), const []);
        expect(t, isNot(contains('ana')), reason: p);
      }
    });

    test('ein Dateiname ohne Pfad und ohne Liste verschwindet trotzdem', () {
      final t =
          chatUploadAusnahmeOhneNamen(Exception('Cannot read $name'), const []);
      expect(t, 'Exception: Cannot read $kDateiPlatzhalter');
    });

    test('der gesendete Pfad verschwindet auch an einem ungewöhnlichen Ort',
        () {
      const p = '/opt/sonst/Akte_Ionescu.dat';
      final t =
          chatUploadAusnahmeOhneNamen(Exception("Cannot open '$p'"), const [p]);
      expect(t, "Exception: Cannot open '$kDateiPlatzhalter'");
    });

    test('Netzfehler bleiben lesbar', () {
      final t = chatUploadAusnahmeOhneNamen(
          const SocketException('Connection reset by peer',
              osError: OSError('', 104)),
          const []);
      expect(t, contains('Connection reset by peer'));
      expect(t, isNot(contains(kDateiPlatzhalter)));
    });
  });

  group('die Zeile', () {
    test('Code, Anzahl, Größe und Endungen — nie der Name', () {
      final z = chatUploadProtokollZeile(
        was: 'abgelehnt, HTTP 400',
        grund: 'Upload error for file: $kDateiPlatzhalter',
        anzahl: 3,
        bytes: 2516582,
        dateinamen: const [name, 'IMG_2.JPG', 'scan.pdf'],
      );
      expect(z,
          'Chat-Upload abgelehnt, HTTP 400 · „Upload error for file: «Datei»“ · 3 Datei(en), 2.4 MB · jpg, pdf');
      expect(z, isNot(contains('Mustermann')));
      expect(z, isNot(contains('scan')));
    });

    test('unbekannte Größe und Dateien ohne Endung', () {
      final z = chatUploadProtokollZeile(
          was: 'x',
          grund: 'y',
          anzahl: 1,
          bytes: -1,
          dateinamen: const ['ohne_endung']);
      expect(z, endsWith('1 Datei(en), ? MB · –'));
    });
  });

  group('ApiService.uploadChatAttachments schreibt die Zeile', () {
    late Directory tmp;
    late File datei;
    late List<http.BaseRequest> gesendet;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      LoggerService().zuruecksetzen();
      tmp = Directory.systemTemp.createTempSync('chat_upload_');
      datei = File('${tmp.path}/$name')..writeAsBytesSync(List.filled(2048, 7));
      gesendet = [];
    });
    tearDown(() => tmp.deleteSync(recursive: true));

    void server(Future<http.Response> Function(http.Request r) antwort) {
      ApiService().testClient = MockClient((r) async {
        gesendet.add(r);
        return antwort(r);
      });
    }

    List<LogEntry> zeilen() => LoggerService()
        .logs
        .where((l) => l.message.startsWith('Chat-Upload'))
        .toList();

    test(
        'HTTP 400 → eine Warnung mit dem Grund, ohne Namen; Ergebnis wie bisher',
        () async {
      server((_) async => http.Response(
          jsonEncode(
              {'success': false, 'message': 'Upload error for file: $name'}),
          400));
      final r = await ApiService().uploadChatAttachments(
          conversationId: 9, mitgliedernummer: 'M1', files: [datei]);
      expect(r, {'success': false, 'message': 'Upload error for file: $name'});
      final z = zeilen();
      expect(z, hasLength(1));
      expect(z.single.level, LogLevel.warning);
      expect(z.single.tag, 'CHAT');
      expect(z.single.message,
          'Chat-Upload abgelehnt, HTTP 400 · „Upload error for file: «Datei»“ · 1 Datei(en), 0.0 MB · pdf');
      expect(LoggerService().logs.map((l) => l.message).join('\n'),
          isNot(contains('Mustermann')));
      expect(gesendet, hasLength(1));
    });

    test('Erfolg → keine Zeile', () async {
      server((_) async =>
          http.Response(jsonEncode({'success': true, 'attachments': []}), 201));
      final r = await ApiService().uploadChatAttachments(
          conversationId: 9, mitgliedernummer: 'M1', files: [datei]);
      expect(r['success'], isTrue);
      expect(zeilen(), isEmpty);
    });

    test(
        'nginx-Fehlerseite (413) → Warnung mit Länge, Ergebnis „Upload failed“ wie bisher',
        () async {
      const html = '<html><body>413 Request Entity Too Large</body></html>';
      server((_) async => http.Response(html, 413));
      final r = await ApiService().uploadChatAttachments(
          conversationId: 9, mitgliedernummer: 'M1', files: [datei]);
      expect(r, {'success': false, 'message': 'Upload failed'});
      expect(
          zeilen().single.message,
          contains(
              'abgelehnt, HTTP 413 · „Antwort ohne JSON (${html.length} Zeichen)“'));
      expect(LoggerService().logs.map((l) => l.message).join('\n'),
          isNot(contains('<html>')));
    });

    test('Netzfehler → Fehlerzeile im selben Stil, ohne Namen', () async {
      server(
          (_) async => throw const SocketException('Connection reset by peer'));
      final r = await ApiService().uploadChatAttachments(
          conversationId: 9, mitgliedernummer: 'M1', files: [datei]);
      expect(r, {'success': false, 'message': 'Upload failed'});
      final z = zeilen().single;
      expect(z.level, LogLevel.error);
      expect(z.tag, 'API');
      expect(z.message, startsWith('Chat-Upload fehlgeschlagen, '));
      expect(z.message, contains('Connection reset by peer'));
      expect(z.message, isNot(contains('Mustermann')));
    });

    test('verschwundene Datei → Fehlerzeile ohne Pfad und Namen', () async {
      server((_) async => http.Response('{}', 200));
      datei.deleteSync();
      final r = await ApiService().uploadChatAttachments(
          conversationId: 9, mitgliedernummer: 'M1', files: [datei]);
      expect(r, {'success': false, 'message': 'Upload failed'});
      final z = zeilen().single;
      expect(z.message,
          startsWith('Chat-Upload fehlgeschlagen, PathNotFoundException'));
      expect(z.message, contains('? MB'));
      expect(z.message, isNot(contains('Mustermann')));
      expect(z.message, isNot(contains(tmp.path)));
      expect(gesendet, isEmpty);
    });
  });
}
