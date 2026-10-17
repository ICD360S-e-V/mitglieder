// Das Update installiert sich auf Android selbst — wie bei der Vorsitzer-App.
//
// Wunsch des Vorsitzenden (17.10.2026): „se poate aplica si la aplicatia
// mitglieder … auto actualizarea ca pe vorsitzer“, und auf die Frage nach
// mobilen Daten: „B indiferent ca e pe date mobile sau wifi plus de asta ii
// ajutam pe membru sa aiba aplicatia la zi actualizata“.
//
// Diese Datei hält fest:
//  * nie während eines Anrufs mit dem Verein oder einer Fernwartung — Android
//    beendet die App beim Ersetzen des Pakets und mit ihr das Gespräch;
//  * je Fassung nur EIN Versuch von selbst — sonst käme die Dialogschleife
//    zurück, die die Vorsitzer-App vom 01.–13.10.2026 hatte;
//  * nur dort, wo Android ohne Rückfrage installiert; sonst wird nichts im
//    Hintergrund geladen, und es bleibt beim Dialog;
//  * kurz davor der Hinweis, dass die App gleich neu startet.
//
// ⚠️ Anrufe, Fernwartung und Einstellungen sind hier nur im Test gesetzt
// (testZustand, SharedPreferences.setMockInitialValues) — nichts davon geht
// an ein Gerät oder einen Server.
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/remote_agent_service.dart';
import 'package:icd360sev_mitglied/services/update_gespraechssperre.dart';
import 'package:icd360sev_mitglied/services/update_service.dart';
import 'package:icd360sev_mitglied/services/voice_call_service.dart';
import 'package:icd360sev_mitglied/widgets/anruf_overlay.dart';
import 'package:icd360sev_mitglied/widgets/update_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Ein Stück Quelltext von [anfang] bis vor [ende].
String _stueck(String text, String anfang, String ende) {
  final a = text.indexOf(anfang);
  expect(a, greaterThanOrEqualTo(0), reason: 'nicht gefunden: $anfang');
  final e = text.indexOf(ende, a + anfang.length);
  expect(e, greaterThan(a), reason: 'nicht gefunden: $ende');
  return text.substring(a, e);
}

void main() {
  final chat = VoiceCallService();
  final fernwartung = RemoteAgentService();

  /// Lässt die Zuhörer zu Wort kommen (beide Dienste melden über Ströme).
  Future<void> durchlauf() async {
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
  }

  tearDown(() {
    chat.testZustand(CallState.idle);
    fernwartung.testZustand(RemoteAgentState.idle);
  });

  group('was sperrt', () {
    test('ohne Anruf und ohne Fernwartung: frei', () {
      expect(UpdateGespraechssperre.grund, isNull);
      expect(UpdateGespraechssperre.gesperrt, isFalse);
    });

    test('Anruf: klingelnd, wählend, im Aufbau und im Gespräch', () {
      for (final s in CallState.values.where((s) => s != CallState.idle)) {
        chat.testZustand(s);
        expect(UpdateGespraechssperre.grund, 'Anruf', reason: s.name);
      }
    });

    test('Fernwartung: im Aufbau und während sie läuft', () {
      for (final s in RemoteAgentState.values.where((s) => s != RemoteAgentState.idle)) {
        fernwartung.testZustand(s);
        expect(UpdateGespraechssperre.grund, 'Fernwartung', reason: s.name);
      }
    });
  });

  group('abwarten()', () {
    test('ohne Anruf: sofort', () async {
      await UpdateGespraechssperre.abwarten().timeout(const Duration(seconds: 1));
    });

    test('erst, wenn der Anruf vorbei UND die Fernwartung zu ist', () async {
      chat.testZustand(CallState.inCall);
      fernwartung.testZustand(RemoteAgentState.active);
      var fertig = false;
      unawaited(UpdateGespraechssperre.abwarten().then((_) => fertig = true));
      await durchlauf();
      expect(fertig, isFalse);

      chat.testZustand(CallState.idle);
      await durchlauf();
      expect(fertig, isFalse, reason: 'die Fernwartung läuft noch');

      fernwartung.testZustand(RemoteAgentState.idle);
      await durchlauf();
      expect(fertig, isTrue);
    });
  });

  group('von selbst installieren', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    Future<int?> vermerkt() async {
      final p = await SharedPreferences.getInstance();
      await p.reload();
      return p.getInt(UpdateService.vonSelbstSchluessel);
    }

    /// Reichlich Zeit für die Futures der Einstellungen.
    Future<void> weile() => Future<void>.delayed(const Duration(milliseconds: 20));

    test('ohne Anruf: sofort — und je Fassung nur EINMAL', () async {
      expect(await UpdateService.vonSelbstFreigeben(11000), isTrue);
      expect(await vermerkt(), 11000);
      expect(await UpdateService.vonSelbstFreigeben(11000), isFalse,
          reason: 'zweiter Versuch derselben Fassung');
      expect(await UpdateService.vonSelbstFreigeben(11001), isTrue,
          reason: 'die nächste Fassung darf wieder');
    });

    test('im Anruf: erst, wenn er vorbei ist — und erst dann vermerkt', () async {
      chat.testZustand(CallState.ringing);
      var frei = false;
      final f = UpdateService.vonSelbstFreigeben(11000).then((v) => frei = v);
      await weile();
      expect(frei, isFalse);
      expect(await vermerkt(), isNull, reason: 'vermerkt wird erst nach dem Anruf');

      chat.testZustand(CallState.idle);
      await f;
      expect(frei, isTrue);
      expect(await vermerkt(), 11000);
    });

    test('während einer Fernwartung ebenso', () async {
      fernwartung.testZustand(RemoteAgentState.connecting);
      var frei = false;
      final f = UpdateService.vonSelbstFreigeben(11000).then((v) => frei = v);
      await weile();
      expect(frei, isFalse);
      expect(await vermerkt(), isNull);

      fernwartung.testZustand(RemoteAgentState.idle);
      await f;
      expect(frei, isTrue);
    });
  });

  group('der Hinweis, bevor die App neu startet', () {
    testWidgets('kommt auch ohne Bildschirm an — über den Navigator der App', (t) async {
      await t.pumpWidget(MaterialApp(
        navigatorKey: AnrufOverlay.navigatorKey,
        locale: const Locale('de'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: SizedBox.expand()),
      ));

      // So ruft ihn der Start der App (main.dart): ohne BuildContext.
      updateHinweisZeigen('1.110.0');
      await t.pump();
      await t.pump(const Duration(milliseconds: 750));

      expect(find.text('Version 1.110.0 wird im Hintergrund installiert. Die App startet gleich neu.'),
          findsOneWidget);
      await t.pump(const Duration(seconds: 9));
    });
  });

  group('Quelltext', () {
    late String dienst, installieren, android, pruefen, manifest, play, kotlin;

    // In setUpAll, nicht beim Anlegen der Gruppe: `expect` geht nur in einem
    // Test (oder seinem setUpAll).
    setUpAll(() {
      dienst = File('lib/services/update_service.dart').readAsStringSync();
      installieren = _stueck(dienst, 'Future<bool> installUnattended(', 'Future<UpdateInfo?> checkForUpdate()');
      android = _stueck(dienst, 'Future<bool> launchInstaller(', '} else if (Platform.isIOS) {');
      final dialog = File('lib/widgets/update_dialog.dart').readAsStringSync();
      pruefen = _stueck(dialog, 'Future<void> checkAndShowUpdateDialog(', 'showDialog(');
      manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      play = File('android/app/src/googleplay/AndroidManifest.xml').readAsStringSync();
      kotlin = File('packages/icd_installer/android/src/main/kotlin/de/icd360s/icd_installer/'
              'IcdInstallerPlugin.kt')
          .readAsStringSync();
    });

    test('Android installiert über die Session, ohne zweiten Dialog — nicht mehr über OpenFilex', () {
      expect(android, contains('IcdInstaller.apkInstallieren(installerPath, ohneNachfrage: true)'));
      expect(dienst, isNot(contains("import 'package:open_filex/")));
      expect(dienst, isNot(contains('OpenFilex.open(')));
      expect(dienst, contains('bool get supportsSilentUpdate => Platform.isWindows || Platform.isAndroid;'));
    });

    test('erst fragen, ob Android ohne Rückfrage installiert — und ob es schon versucht wurde — DANN laden', () {
      final laden = installieren.indexOf('downloadUpdate(');
      expect(installieren.indexOf('await kannUnbeaufsichtigt()'), inExclusiveRange(0, laden));
      expect(installieren.indexOf('await _schonVersucht(updateInfo.buildNumber)'), inExclusiveRange(0, laden));
    });

    test('nie im Gespräch: vor dem Laden, vor dem Hinweis, und erst danach der Versuch', () {
      final laden = installieren.indexOf('downloadUpdate(');
      final hinweis = installieren.indexOf('vorDemNeustart?.call(updateInfo.version);');
      final frei = installieren.indexOf('await vonSelbstFreigeben(updateInfo.buildNumber)');
      final los = installieren.indexOf('launchInstaller(installerPath, silent: true)');
      expect(installieren.indexOf('await _ohneGespraech();'), inExclusiveRange(0, laden));
      expect(installieren.indexOf('await _ohneGespraech();', laden), inExclusiveRange(laden, hinweis));
      expect(hinweis, inExclusiveRange(laden, frei));
      expect(frei, inExclusiveRange(hinweis, los));
      final freigeben = _stueck(dienst, 'static Future<bool> vonSelbstFreigeben(', 'static Future<bool> _schonVersucht(');
      expect(freigeben.indexOf('await _ohneGespraech();'),
          inExclusiveRange(0, freigeben.indexOf('await prefs.setInt(vonSelbstSchluessel, build);')));
    });

    test('läuft schon ein Update von selbst, fragt der Dialog nicht dazwischen', () {
      expect(pruefen.indexOf('if (updateService.unattendedInProgress) return;'),
          inExclusiveRange(0, pruefen.indexOf('checkForUpdate()')));
      final schon = _stueck(installieren, 'if (_unattendedInProgress) {', '_unattendedInProgress = true;');
      expect(schon, contains('return true;'));
    });

    test('der Start der App zeigt den Hinweis auch', () {
      expect(File('lib/main.dart').readAsStringSync(),
          contains('checkAndInstallAtStartup(vorDemNeustart: updateHinweisZeigen)'));
    });

    test('das Manifest erklärt die Berechtigung — der Play-Flavor nimmt nur das Installieren weg', () {
      expect(manifest, contains('android.permission.UPDATE_PACKAGES_WITHOUT_USER_ACTION'));
      expect(manifest, contains('android.permission.REQUEST_INSTALL_PACKAGES'));
      expect(play, contains('android:name="android.permission.REQUEST_INSTALL_PACKAGES"'));
    });

    test('Kotlin: ohne Rückfrage nur ab Android 12, und das Paket nicht auf dem Hauptfaden', () {
      expect(kotlin, contains('if (ohneNachfrage && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {\n'
          '                    params.setRequireUserAction(PackageInstaller.SessionParams.USER_ACTION_NOT_REQUIRED)'));
      final schreiben = _stueck(kotlin, 'private fun installieren(', 'private fun uebergebenAn(');
      expect(schreiben, contains('Thread({'));
      expect(schreiben.indexOf('sessionSchreiben(context, pfad, ohneNachfrage)'),
          greaterThan(schreiben.indexOf('Thread({')));
      final kann = _stueck(kotlin, 'fun kannOhneNachfrage(ctx: Context): Boolean {', 'fun sessionSchreiben(');
      expect(kann, contains('if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return false'));
      expect(kann, contains('pm.canRequestPackageInstalls()'));
      expect(kann, contains('UPDATE_OHNE_NACHFRAGE'));
      expect(kann, contains('updateOwnerPackageName'));
    });

    test('Kotlin: minSdk 24 — Neueres nur hinter der Android-Fassung', () {
      expect(kotlin, contains('if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {\n'
          '                    params.setInstallReason('));
      expect(kotlin, contains('if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) s.isCommitted else false'));
      expect(kotlin, contains('Build.VERSION.SDK_INT >= Build.VERSION_CODES.R &&\n'
          '                    System.currentTimeMillis() - s.createdMillis'));
      expect(kotlin, contains('if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {\n'
          '                PendingIntent.FLAG_MUTABLE'));
    });
  });
}
