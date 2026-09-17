// Prüft nicht, ob etwas überläuft, sondern ob man es noch benutzen kann.
//
// „Kein Überlauf" ist die schwächere Aussage: eine Schaltfläche kann auch ohne
// Überlaufmeldung außerhalb des Fensters oder unter einer anderen liegen. Die
// Tests hier tippen die Bedienelemente an, auf die es ankommt — Auflegen,
// Weiter, Absenden, Zustimmen, der letzte Reiter im Profil. `tester.tap`
// scheitert von sich aus, wenn das Ziel nicht sichtbar oder nicht getroffen
// wird; zusätzlich wird geprüft, dass der hinterlegte Rückruf wirklich feuert.
//
// Gemessen wird im ungünstigsten Fall: schmalstes unterstütztes Telefon
// (320×568) mit der größten Systemschrift.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/utils/responsive.dart';
import 'package:icd360sev_mitglied/widgets/benachrichtigung_consent_dialog.dart';
import 'package:icd360sev_mitglied/widgets/incoming_call_dialog.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_appbar.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_profile_dialog.dart';
import 'package:icd360sev_mitglied/widgets/native_call_screen.dart';
import 'package:icd360sev_mitglied/widgets/new_ticket_dialog.dart';
import 'package:icd360sev_mitglied/widgets/remote_consent_dialog.dart';
import 'package:icd360sev_mitglied/widgets/wizard_step_shell.dart';

const Size _engstesGeraet = Size(320, 568);
const double _groessteSystemschrift = 2.0;

Future<void> _pump(WidgetTester tester, Widget home) async {
  SharedPreferences.setMockInitialValues({});
  tester.view.devicePixelRatio = 2.0;
  tester.view.physicalSize = _engstesGeraet * 2.0;
  tester.platformDispatcher.textScaleFactorTestValue = _groessteSystemschrift;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

  await tester.pumpWidget(MaterialApp(
    locale: const Locale('de'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    builder: (context, child) =>
        ResponsiveScaling(child: child ?? const SizedBox.shrink()),
    home: home,
  ));
  await tester.pump(const Duration(milliseconds: 800));
}

Future<void> _abraeumen(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(seconds: 2));
  tester.takeException();
}

/// Liegt das Ziel vollständig im Fenster? `tester.tap` trifft auch etwas, das
/// zur Hälfte über dem Rand hängt — für eine Schaltfläche ist das zu wenig.
void _erwarteVollstaendigSichtbar(WidgetTester tester, Finder finder) {
  final rect = tester.getRect(finder);
  final fenster = Offset.zero & _engstesGeraet;
  expect(rect.width, greaterThan(0), reason: 'Ziel hat keine Breite');
  expect(rect.height, greaterThan(0), reason: 'Ziel hat keine Höhe');
  expect(
    fenster.contains(rect.topLeft) && fenster.contains(rect.bottomRight),
    isTrue,
    reason: 'Ziel liegt bei $rect außerhalb von $fenster',
  );
}

void main() {
  testWidgets('AppBar: alle sechs Schaltflächen sind antippbar', (tester) async {
    final getippt = <String>[];
    await _pump(
      tester,
      Scaffold(
        appBar: MitgliedAppBar(
          mitgliedernummer: '360-1234',
          status: 'active',
          unreadChatCount: 12,
          unreadTicketCount: 3,
          pendingTerminCount: 5,
          onHome: () => getippt.add('home'),
          onTermine: () => getippt.add('termine'),
          onTickets: () => getippt.add('tickets'),
          onLiveChat: () => getippt.add('chat'),
          onExtras: () => getippt.add('extras'),
          onProfile: () => getippt.add('profil'),
        ),
        body: const SizedBox.shrink(),
      ),
    );

    final symbole = <IconData, String>{
      Icons.home_outlined: 'home',
      Icons.calendar_month_outlined: 'termine',
      Icons.local_activity_outlined: 'tickets',
      Icons.forum_outlined: 'chat',
      Icons.auto_awesome_outlined: 'extras',
      Icons.person_outlined: 'profil',
    };

    for (final eintrag in symbole.entries) {
      final finder = find.byIcon(eintrag.key);
      expect(finder, findsOneWidget, reason: '${eintrag.value} fehlt in der Leiste');
      _erwarteVollstaendigSichtbar(tester, finder);
      await tester.tap(finder);
      await tester.pump();
    }

    expect(getippt, symbole.values.toList());

    await _abraeumen(tester);
  });

  testWidgets('AppBar: der Stern bleibt auch neben vollen Plaketten erreichbar',
      (tester) async {
    // Vorher stand hier der Fall der Glocke: ihre Plakette wurde bei „99+" so
    // breit, dass sie über der Mitte der Glocke lag und jeden Tipper
    // schluckte. Die Glocke ist weg, die Gefahr nicht: der Stern steht
    // zwischen vier Schaltflächen, die alle eine Plakette tragen können, und
    // die Zeile schrumpft erst, wenn sie sonst nicht mehr passt. Getestet wird
    // deshalb der volle Fall — alle Zähler an der Obergrenze, schmalstes
    // Gerät, größte Systemschrift.
    var gesternt = 0;
    await _pump(
      tester,
      Scaffold(
        appBar: MitgliedAppBar(
          mitgliedernummer: '360-1234',
          status: 'active',
          unreadChatCount: 150,
          unreadTicketCount: 150,
          pendingTerminCount: 150,
          onHome: () {},
          onTermine: () {},
          onTickets: () {},
          onLiveChat: () {},
          onExtras: () => gesternt++,
          onProfile: () {},
        ),
        body: const SizedBox.shrink(),
      ),
    );

    final stern = find.byIcon(Icons.auto_awesome_outlined);
    _erwarteVollstaendigSichtbar(tester, stern);
    await tester.tap(stern);
    await tester.pump();
    expect(gesternt, 1, reason: 'Der Stern war nicht zu treffen');
    await _abraeumen(tester);
  });

  testWidgets('Profil: auch der letzte Reiter ist erreichbar', (tester) async {
    await _pump(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => MitgliedProfileDialog(
                  userName: 'Maximilian',
                  mitgliedernummer: '360-1234',
                  email: 'maximilian@example.invalid',
                  status: 'active',
                  apiService: ApiService(),
                  onEmailChanged: (_) {},
                ),
              ),
              child: const Text('auf'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('auf'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Sechs Reiter — die letzten beiden (Dokumente, Mitgliedschaft) waren auf
    // einem Telefon vorher gar nicht erreichbar.
    expect(find.byType(Tab), findsNWidgets(6));
    final letzter = find.byIcon(Icons.card_membership);
    await tester.scrollUntilVisible(letzter, 60, scrollable: find.byType(Scrollable).first);
    await tester.tap(letzter);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(tester.takeException(), isNull);
    await _abraeumen(tester);
  });

  testWidgets('Assistent: „Weiter" ist sichtbar und löst aus', (tester) async {
    var weiter = 0;
    await _pump(
      tester,
      WizardStepShell(
        stepLabel: 'Schritt 3 von 8',
        prompt: 'Bitte geben Sie Ihre Staatsangehörigkeit an.',
        onBack: () {},
        onNext: () => weiter++,
        child: const TextField(),
      ),
    );

    final knopf = find.byType(ElevatedButton);
    expect(knopf, findsOneWidget);
    _erwarteVollstaendigSichtbar(tester, knopf);
    await tester.tap(knopf);
    await tester.pump();
    expect(weiter, 1);
    await _abraeumen(tester);
  });

  testWidgets('Ticket: „Absenden" ist sichtbar', (tester) async {
    await _pump(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) =>
                    const NewTicketDialog(mitgliedernummer: '360-1234'),
              ),
              child: const Text('auf'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('auf'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Im Dialog ist genau eine ElevatedButton — die zum Absenden.
    final absenden = find.descendant(
      of: find.byType(Dialog),
      matching: find.byType(ElevatedButton),
    );
    expect(absenden, findsOneWidget);
    // Der Dialog scrollt; erreichbar heißt hier: hinscrollen und dann
    // vollständig im Fenster stehen.
    await tester.ensureVisible(absenden);
    await tester.pump();
    _erwarteVollstaendigSichtbar(tester, absenden);
    await _abraeumen(tester);
  });

  testWidgets('Benachrichtigungen: „Speichern" ist sichtbar', (tester) async {
    await _pump(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) =>
                    BenachrichtigungConsentDialog(apiService: ApiService()),
              ),
              child: const Text('auf'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('auf'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    final speichern = find.byType(FilledButton);
    expect(speichern, findsOneWidget);
    await tester.ensureVisible(speichern);
    await tester.pump();
    _erwarteVollstaendigSichtbar(tester, speichern);
    await _abraeumen(tester);
  });

  testWidgets('Fernwartung: die Zustimmung ist erreichbar', (tester) async {
    var angenommen = 0;
    await _pump(
      tester,
      RemoteConsentDialog(
        controllerName: 'Vorsitzender Bartholomäus',
        onAccept: () => angenommen++,
        onDecline: () {},
      ),
    );

    final zustimmen = find.byType(FilledButton);
    expect(zustimmen, findsOneWidget);
    // Der Inhalt scrollt jetzt; die Schaltfläche muss dadurch erreichbar sein.
    await tester.ensureVisible(zustimmen);
    await tester.pump();
    _erwarteVollstaendigSichtbar(tester, zustimmen);
    await tester.tap(zustimmen);
    await tester.pump();
    expect(angenommen, 1);
    await _abraeumen(tester);
  });

  testWidgets('Anruf: Auflegen ist erreichbar und löst aus', (tester) async {
    var aufgelegt = 0;
    await _pump(
      tester,
      NativeCallScreen(
        remoteName: 'Vorsitzender Bartholomäus',
        isActive: true,
        callDuration: const Duration(minutes: 1),
        isMuted: false,
        isSpeakerOn: false,
        onToggleMute: () {},
        onToggleSpeaker: () {},
        onEndCall: () => aufgelegt++,
      ),
    );

    final auflegen = find.byIcon(Icons.call_end);
    expect(auflegen, findsOneWidget);
    await tester.ensureVisible(auflegen);
    await tester.pump();
    _erwarteVollstaendigSichtbar(tester, auflegen);
    await tester.tap(auflegen);
    await tester.pump();
    expect(aufgelegt, 1);
    await _abraeumen(tester);
  });

  testWidgets('Laufender Anruf: alle drei Bedienknöpfe liegen im Fenster',
      (tester) async {
    var beendet = 0;
    await _pump(
      tester,
      Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: InCallOverlay(
            remoteName: 'Vorsitzender Bartholomäus',
            callDuration: const Duration(minutes: 3, seconds: 12),
            isMuted: false,
            isSpeakerOn: true,
            onToggleMute: () {},
            onToggleSpeaker: () {},
            onEndCall: () => beendet++,
          ),
        ),
      ),
    );

    for (final symbol in [Icons.volume_up, Icons.mic, Icons.call_end]) {
      final finder = find.byIcon(symbol);
      expect(finder, findsOneWidget);
      _erwarteVollstaendigSichtbar(tester, finder);
    }
    await tester.tap(find.byIcon(Icons.call_end));
    await tester.pump();
    expect(beendet, 1);
    await _abraeumen(tester);
  });
}
