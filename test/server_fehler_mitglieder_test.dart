import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/services/termin_service.dart';
import 'package:icd360sev_mitglied/services/ticket_notification_service.dart';
import 'package:icd360sev_mitglied/services/wizard_service.dart';

/// Was die Server-Protokolle der Woche 08.–15.10.2026 über die Mitglieder-App
/// verrieten — seit das Fenster „App-Fehler“ auch nginx liest.
///
///  1. Der Ticket-Abruf im Hintergrund (WorkManager) bekam IMMER 403: er las
///     Token und Geräteschlüssel aus SharedPreferences, wo sie nie stehen.
///  2. Jeder Start ohne begonnene Anmeldung fragte check_status.php mit einer
///     eben erfundenen Kennung — 404.
///  3. Eltern sahen die Termine ihrer Kinder, konnten aber nicht antworten:
///     die App sagte dem Server nicht, für WEN.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Ticket-Abruf im Hintergrund', () {
    test('nimmt Token und Geräteschlüssel aus dem SICHEREN Speicher', () async {
      FlutterSecureStorage.setMockInitialValues({'access_token': 'tok-1', 'device_key': 'dk-1'});
      SharedPreferences.setMockInitialValues({});
      final k = await hintergrundKoepfe(const FlutterSecureStorage());
      expect(k['Authorization'], 'Bearer tok-1');
      expect(k['X-Device-Key'], 'dk-1');
      expect(k['User-Agent'], 'ICD360S-Mitglieder-Android/1.0');
    });

    test('ohne Anmeldung keine leeren Kopfzeilen', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final k = await hintergrundKoepfe(const FlutterSecureStorage());
      expect(k.containsKey('Authorization'), isFalse);
      expect(k.containsKey('X-Device-Key'), isFalse);
    });

    test('liest dieselben Schlüssel, die ApiService und DeviceKeyService schreiben', () {
      final api = File('lib/services/api_service.dart').readAsStringSync();
      final geraet = File('lib/services/device_key_service.dart').readAsStringSync();
      final abruf = File('lib/services/ticket_notification_service.dart').readAsStringSync();
      expect(api, contains("write(key: 'access_token'"));
      expect(geraet, contains("_deviceKeyStorageKey = 'device_key'"));
      expect(abruf, contains("lies('access_token')"));
      expect(abruf, contains("lies('device_key')"));
      // Der Abruf im Hintergrund nimmt seine Kopfzeilen genau von dort …
      expect(abruf, contains('headers: await hintergrundKoepfe(),'));
      // … und der alte Weg darf nicht zurückkommen, in keiner Schreibweise.
      expect(abruf, isNot(contains("getString('auth_token')")));
      expect(abruf, isNot(contains("getString('device_key')")));
      expect(abruf, isNot(contains("getString('access_token')")));
    });
  });

  group('check_status.php nur, wenn es einen Entwurf geben kann', () {
    late List<String> anfragen;
    late int antwortStatus;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      anfragen = [];
      antwortStatus = 404;
      final w = WizardService();
      await w.resetLocal();
      w.testClient = MockClient((r) async {
        anfragen.add(r.url.path.split('/').last);
        if (r.url.path.endsWith('start.php')) {
          return http.Response(
              jsonEncode({'success': true, 'anonymous_id': 'x', 'current_step': '1a', 'resumed': false}), 200);
        }
        if (antwortStatus == 404) {
          return http.Response(jsonEncode({'success': false, 'message': 'Wizard draft not found'}), 404);
        }
        return http.Response(jsonEncode({'success': true, 'status': 'neu', 'user_id': 7, 'stufen': []}), 200);
      });
    });

    test('ohne gespeicherte Kennung: keine Anfrage und keine erfundene Kennung', () async {
      expect(await WizardService().checkUserStatus(), isNull);
      expect(anfragen, isEmpty);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('wizard_anonymous_id'), isNull);
    });

    test('nach einem 404 wird für dieselbe Kennung nicht mehr gefragt', () async {
      SharedPreferences.setMockInitialValues({'wizard_anonymous_id': 'a' * 32});
      expect(await WizardService().checkUserStatus(), isNull);
      expect(await WizardService().checkUserStatus(), isNull);
      expect(await WizardService().checkUserStatus(), isNull);
      expect(anfragen, ['check_status.php'], reason: 'genau eine Anfrage, dann Ruhe');
    });

    test('ein begonnener Entwurf (start) hebt die Ruhe auf', () async {
      SharedPreferences.setMockInitialValues({'wizard_anonymous_id': 'b' * 32});
      await WizardService().checkUserStatus();
      await WizardService().start();
      antwortStatus = 200;
      final p = await WizardService().checkUserStatus();
      expect(anfragen, ['check_status.php', 'start.php', 'check_status.php']);
      expect(p?.status, 'neu');
    });

    test('solange der Server den Entwurf kennt, wird weiter gefragt', () async {
      SharedPreferences.setMockInitialValues({'wizard_anonymous_id': 'c' * 32});
      antwortStatus = 200;
      await WizardService().checkUserStatus();
      await WizardService().checkUserStatus();
      expect(anfragen, ['check_status.php', 'check_status.php']);
    });

    test('resetLocal vergisst auch die Ruhe', () async {
      SharedPreferences.setMockInitialValues({'wizard_anonymous_id': 'd' * 32});
      await WizardService().checkUserStatus();
      await WizardService().resetLocal();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('wizard_ohne_entwurf'), isNull);
    });
  });

  group('Erneuerung abgelehnt (403) beendet die Sitzung', () {
    test('403 → abgemeldet statt einer toten Sitzung, die weiter fragt', () async {
      FlutterSecureStorage.setMockInitialValues({});
      await ApiService().saveTokens('alt', 'r1');
      ApiService().testClient = MockClient(
          (r) async => http.Response(jsonEncode({'success': false, 'message': 'Account is gesperrt'}), 403));
      expect(await ApiService().refreshAccessToken(), isFalse);
      expect(ApiService().isLoggedIn, isFalse);
      expect(ApiService().refreshToken, isNull);
    });

    test('500 lässt die Sitzung stehen — ein kaputter Server ist keine tote Sitzung', () async {
      FlutterSecureStorage.setMockInitialValues({});
      await ApiService().saveTokens('alt', 'r1');
      ApiService().testClient = MockClient((r) async => http.Response('kaputt', 500));
      expect(await ApiService().refreshAccessToken(), isFalse);
      expect(ApiService().isLoggedIn, isTrue);
      expect(ApiService().refreshToken, 'r1');
    });
  });

  group('Antwort auf einen Termin — für wen', () {
    test('participant_user_id geht mit, wenn der Termin einem Kind gehört', () async {
      Map<String, dynamic>? rumpf;
      TerminService().testClient = MockClient((r) async {
        rumpf = jsonDecode(r.body) as Map<String, dynamic>;
        return http.Response(jsonEncode({'success': true}), 200);
      });
      final a = await TerminService().respondToTermin(terminId: 10, response: 'confirmed', participantUserId: 54);
      expect(a['success'], isTrue);
      expect(rumpf, {'termin_id': 10, 'response': 'confirmed', 'participant_user_id': 54});
    });

    test('ohne Kind bleibt der Rumpf wie bisher', () async {
      Map<String, dynamic>? rumpf;
      TerminService().testClient = MockClient((r) async {
        rumpf = jsonDecode(r.body) as Map<String, dynamic>;
        return http.Response(jsonEncode({'success': true}), 200);
      });
      await TerminService().respondToTermin(terminId: 11, response: 'declined', reason: 'krank');
      expect(rumpf, {'termin_id': 11, 'response': 'declined', 'reason': 'krank'});
    });

    test('die Kalenderansicht reicht participantUserId durch und zeigt eine Absage an', () {
      final q = File('lib/widgets/member_calendar_view.dart').readAsStringSync();
      expect(q, contains('participantUserId: termin.participantUserId,'));
      expect(q, contains("result['success'] != true"));
    });
  });
}
