import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/screens/wizard_intro_screen.dart';
import 'package:icd360sev_mitglied/services/wizard_service.dart';
import 'package:icd360sev_mitglied/widgets/wizard_step_shell.dart';

/// Aus der Anmeldung MUSS man wieder herauskommen.
///
/// Anlass ist ein echter Fehler: wer die Vereinsanmeldung begonnen hatte,
/// konnte sie nicht mehr verlassen. Drei Fallen lagen übereinander.
///
///   1. `WizardScreen._goBack` rief `maybePop` nur, wenn es keinen
///      vorherigen Schritt gab — den gab es aber immer, denn von Stufe 1a
///      führte Zurück auf den Intro-Bildschirm.
///   2. Der Intro-Bildschirm hatte gar keinen Zurück-Weg: kein Pfeil, keine
///      Leiste, und seine einzige Schaltfläche blendet sich erst nach 24
///      Sekunden ein. Wer dort landete, saß fest.
///   3. Der Willkommensbildschirm schob den Wizard beim Start erneut auf den
///      Stapel. Selbst wer sich mit der System-Geste herausrettete, war beim
///      nächsten App-Start wieder drin. Auf Linux/Windows/macOS gibt es diese
///      Geste nicht — dort war die Anmeldung vollständig dicht.
///
/// Die Tests hier decken die Bildschirmseite ab (1 und 2). Sie prüfen nicht
/// die Optik, sondern genau eine Eigenschaft: es gibt einen sichtbaren Weg
/// hinaus, und er führt tatsächlich hinaus.
void main() {
  const marke = 'HAUPTMENUE';

  /// Baut Startbildschirm → Zielbildschirm auf, wie im echten Fluss: der
  /// Wizard liegt als eigene Route über dem Willkommensbildschirm. Nur so
  /// lässt sich belegen, dass der Ausstieg auch wirklich zurückführt.
  Future<void> pumpUeberStart(WidgetTester tester, Widget ziel) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: _Startbildschirm(marke: marke, ziel: ziel),
    ));
    await tester.tap(find.text(marke));
    // Kein pumpAndSettle: der Intro-Bildschirm läuft eine 24-Sekunden-
    // Zeitleiste, die niemals zur Ruhe kommt.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  Future<void> abraeumen(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 2));
    tester.takeException();
  }

  Widget schrittBildschirm() => WizardStepShell(
        stepLabel: 'Schritt 3 von 8 · Test',
        prompt: 'Eine Frage.',
        child: const SizedBox.shrink(),
        onBack: () {},
        onNext: () {},
      );

  testWidgets('Ein Schritt bietet einen sichtbaren Ausstieg an',
      (tester) async {
    await pumpUeberStart(tester, schrittBildschirm());

    // Unten steht nur noch „Weiter". „Zurueck" haengt am Pfeil oben links,
    // wo es auch vorher schon hing — doppelt gemoppelt hat dem schmalen
    // Telefon nur die Breite gekostet.
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(OutlinedButton), findsNothing);

    expect(
      find.byIcon(Icons.close),
      findsOneWidget,
      reason: 'Ohne diesen Weg ist die Anmeldung auf dem Schreibtisch-Rechner '
          'eine Sackgasse — dort gibt es keine System-Zurück-Geste.',
    );
    await abraeumen(tester);
  });

  testWidgets('Auf dem schmalsten Telefon bleibt das X bedienbar',
      (tester) async {
    // Der Ausstieg sitzt jetzt als drittes Symbol in der Kopfleiste. Genau
    // dort wurde es eng: Pfeil, Chat und X nebeneinander, daneben die
    // Schrittanzeige — und bei 320 px mit doppelt gestellter Systemschrift
    // ist nichts mehr geschenkt. Ein Ziel, das halb ueber dem Rand haengt,
    // trifft `tester.tap` trotzdem; der Mensch davor nicht.
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = const Size(320, 568) * 2.0;
    tester.platformDispatcher.textScaleFactorTestValue = 2.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await pumpUeberStart(tester, schrittBildschirm());

    final x = find.byIcon(Icons.close);
    expect(x, findsOneWidget);
    final rect = tester.getRect(x);
    expect(rect.width, greaterThan(0));
    expect(rect.left, greaterThanOrEqualTo(0));
    expect(
      rect.right,
      lessThanOrEqualTo(tester.view.physicalSize.width /
          tester.view.devicePixelRatio),
      reason: 'Das X haengt ueber dem rechten Rand — unerreichbar.',
    );
    expect(
      tester.takeException(),
      isNull,
      reason: 'Die Kopfleiste ist uebergelaufen.',
    );
    await abraeumen(tester);
  });

  testWidgets('Der Intro-Bildschirm ist keine Sackgasse mehr', (tester) async {
    await pumpUeberStart(tester, WizardIntroScreen(onStart: () {}));

    // Entscheidend ist der Zeitpunkt: die Start-Schaltfläche erscheint erst
    // bei T+24s. Wer vorher hinauswill, braucht JETZT einen Weg.
    expect(
      find.byIcon(Icons.arrow_back),
      findsOneWidget,
      reason: 'Das war die Falle: 24 Sekunden lang keine einzige bedienbare '
          'Schaltfläche auf dem Bildschirm.',
    );
    await abraeumen(tester);
  });

  testWidgets('„Später weitermachen" führt zurück und merkt sich das',
      (tester) async {
    await pumpUeberStart(tester, schrittBildschirm());
    final l10n = await AppLocalizations.delegate.load(const Locale('de'));

    expect(find.text(marke), findsNothing, reason: 'Wizard liegt oben');

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text(l10n.wizardExitLater));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.text(marke),
      findsOneWidget,
      reason: 'Der Ausstieg muss tatsächlich auf dem Hauptmenü landen.',
    );
    expect(
      await WizardService().isAutoResumeSuppressed(),
      isTrue,
      reason: 'Ohne diese Merkung schiebt der Willkommensbildschirm den '
          'Wizard beim nächsten Start wieder auf — Falle 3.',
    );
    await abraeumen(tester);
  });

  testWidgets('Abbrechen warnt vor der 90-Tage-Sperre und fragt nach',
      (tester) async {
    await pumpUeberStart(tester, schrittBildschirm());
    final l10n = await AppLocalizations.delegate.load(const Locale('de'));

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text(l10n.wizardExitAbandon));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // finalize.php weist einen Antragsteller mit drei Rückzügen in 90 Tagen
    // ab. Diese Folge sieht der Besucher nirgends sonst — sie MUSS hier
    // stehen, sonst tippt jemand aus Versehen seine Anmeldefähigkeit weg.
    expect(
      find.textContaining('90'),
      findsOneWidget,
      reason: 'Die Warnung vor der Sperre fehlt im Bestätigungsdialog.',
    );

    // Die Gegenprobe: der Dialog darf nicht von allein durchlaufen.
    await tester.tap(find.text(l10n.wizardAbandonKeep));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.text(marke),
      findsNothing,
      reason: 'Wer „Nein" tippt, bleibt in der Anmeldung.',
    );
    expect(
      await WizardService().isAutoResumeSuppressed(),
      isFalse,
      reason: 'Ein abgebrochener Abbruch darf nichts verändert haben.',
    );
    await abraeumen(tester);
  });
}

/// Steht für den Willkommensbildschirm: der Ort, an dem der Besucher nach
/// dem Ausstieg wieder herauskommen muss.
class _Startbildschirm extends StatelessWidget {
  final String marke;
  final Widget ziel;
  const _Startbildschirm({required this.marke, required this.ziel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ziel),
          ),
          child: Text(marke),
        ),
      ),
    );
  }
}
