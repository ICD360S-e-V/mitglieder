import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/services/ticket_service.dart';

/// Abgleich App ↔ Server (Etappe 2.6, 16.10.2026): jeder Aufruf der App gegen
/// das, was der Server wirklich kann. Zwei Befunde in der Mitglieder-App,
/// beide still — kein Fehler, nur ein Bildschirm, der nichts tat:
///
/// - Tickets: die App fragte `tickets/categories.php`, `tickets/upload.php`
///   und `tickets/download.php`. Die Endpunkte heißen
///   `tickets/categories/list.php` und `tickets/attachments/{upload,download}.php`
///   — alle drei Adressen gab es nie (404). Den Download öffnete die App
///   außerdem im Browser, und der kommt nie durch (Geräteschlüssel,
///   blockBrowserAccess).
/// - Notar und Vereinsverwaltung: 18 Aufrufe an Endpunkte NUR des Vorstands
///   (requireRollen schatzmeister/vorsitzer → 403). Kein Bildschirm rief sie
///   noch; Wunsch des Vorsitzenden: „mitglieder nu ar trebui sa vada notar,
///   vereinverwaltung … scoatele din aplicatia mitglieder“.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temp;
  final anfragen = <http.BaseRequest>[];
  final rumpf = <String>[];

  setUp(() async {
    temp = Directory.systemTemp.createTempSync('abgleich');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'), (call) async => temp.path);
    FlutterSecureStorage.setMockInitialValues({'access_token': 'tok-1', 'refresh_token': 'ref-1'});
    await ApiService().loadTokens();
    anfragen.clear();
    rumpf.clear();
  });

  tearDown(() {
    try {
      temp.deleteSync(recursive: true);
    } catch (_) {}
  });

  /// Ein Client, der jede Anfrage festhält und mit [antwort] antwortet.
  void client(http.Response Function(http.BaseRequest) antwort) {
    TicketService().testClient = MockClient.streaming((anfrage, body) async {
      anfragen.add(anfrage);
      rumpf.add(String.fromCharCodes(await body.toBytes()));
      final r = antwort(anfrage);
      return http.StreamedResponse(Stream.value(r.bodyBytes), r.statusCode, headers: r.headers);
    });
  }

  test('🔴 Kategorien: tickets/categories/list.php, mit Token und Geräteschlüssel', () async {
    client((_) => http.Response('{"success":true,"categories":[{"id":1,"name":"Allgemein"}]}', 200));
    await TicketService().getCategories(mitgliedernummer: 'M10001');
    final a = anfragen.single;
    expect(a.method, 'GET');
    expect(a.url.path, '/api/tickets/categories/list.php');
    expect(a.headers['Authorization'], 'Bearer tok-1');
    expect(a.headers.containsKey('X-Device-Key'), isTrue);
  });

  test('🔴 Anhang hochladen: tickets/attachments/upload.php, mit Mitgliedsnummer — über den Client der App',
      () async {
    final datei = File('${Directory.systemTemp.createTempSync('anhang').path}/brief.pdf')..writeAsStringSync('%PDF-1.4');
    client((_) => http.Response(
        '{"success":true,"attachment":{"id":7,"ticket_id":3,"original_filename":"brief.pdf","stored_filename":"x","filesize":8,"mime_type":"application/pdf","created_at":"2026-10-16 22:00:00"}}',
        201));
    await TicketService().uploadAttachment(mitgliedernummer: 'M10001', ticketId: 3, filePath: datei.path);
    final a = anfragen.single;
    expect(a.method, 'POST');
    expect(a.url.path, '/api/tickets/attachments/upload.php');
    expect(rumpf.single, contains('name="mitgliedernummer"'));
    expect(rumpf.single, contains('M10001'));
    expect(rumpf.single, contains('name="ticket_id"'));
    expect(rumpf.single, contains('name="file"; filename="brief.pdf"'));
  });

  test('🔴 Anhang herunterladen: in der App, tickets/attachments/download.php, als Datei — der Name ohne Pfad',
      () async {
    client((_) => http.Response('INHALT', 200));
    final pfad = await TicketService().downloadAttachment(
        mitgliedernummer: 'M10001', attachmentId: 42, originalFilename: '../../etc/C:\\x\\Bescheid.pdf');
    final a = anfragen.single;
    expect(a.method, 'GET');
    expect(a.url.path, '/api/tickets/attachments/download.php');
    expect(a.url.queryParameters, {'mitgliedernummer': 'M10001', 'attachment_id': '42'});
    expect(a.headers['Authorization'], 'Bearer tok-1');
    expect(pfad, isNotNull);
    expect(pfad!.startsWith(temp.path), isTrue, reason: 'im Temp-Ordner der App');
    expect(pfad.split(Platform.pathSeparator).last, 'Bescheid.pdf');
    expect(File(pfad).readAsStringSync(), 'INHALT');
  });

  test('Anhang: der Server sagt nein → null, keine leere Datei', () async {
    client((_) => http.Response('{"success":false}', 403));
    final pfad = await TicketService()
        .downloadAttachment(mitgliedernummer: 'M10001', attachmentId: 42, originalFilename: 'x.pdf');
    expect(pfad, isNull);
  });

  test('🔴 Quelltext: keine der Adressen, die es nicht gibt — und kein Anhang im Browser', () {
    final ticket = File('lib/services/ticket_service.dart').readAsStringSync();
    for (final alt in ["/tickets/categories.php'", "/tickets/upload.php'", "/tickets/download.php"]) {
      expect(ticket, isNot(contains(alt)), reason: alt);
    }
    final dialog = File('lib/widgets/member_ticket_details_dialog.dart').readAsStringSync();
    expect(dialog, isNot(contains('launchUrl')), reason: 'der Browser hat keinen Geräteschlüssel');
    expect(dialog, contains('downloadAttachment('));
  });

  test('🔴 die Mitglieder-App ruft keine Bereiche nur des Vorstands: notar/, vereinverwaltung/ — admin/ nur, was offen ist',
      () {
    // admin/rechner_verlauf.php prüft keine Rolle (nachgesehen 16.10.2026) —
    // der Rechner der Mitglieder schreibt dort seinen Verlauf. Jeder andere
    // Endpunkt unter admin/ ist nur für den Vorsitzer.
    const offen = {'admin/rechner_verlauf.php'};
    final befunde = <String>[];
    for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final zeilen = f.readAsLinesSync();
      for (var i = 0; i < zeilen.length; i++) {
        if (zeilen[i].trimLeft().startsWith('//')) continue;
        for (final m in RegExp(r"""(notar|vereinverwaltung|admin)/\w+\.php""").allMatches(zeilen[i])) {
          if (!offen.contains(m.group(0))) befunde.add('${f.path}:${i + 1}: ${m.group(0)}');
        }
      }
    }
    expect(befunde, isEmpty);
  });
}
