import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/widgets/chat_anhang_zeile.dart';

/// Hintergrund: im Live-Chat ließ sich ein Anhang nur öffnen, nicht
/// herunterladen. Jetzt steht neben jeder Datei ein Knopf dafür — auf jeder
/// Plattform, in fremden wie in eigenen Blasen.
void main() {
  const bescheid = {
    'id': 42,
    'filename': 'Bescheid Jobcenter.pdf',
    'extension': 'pdf',
    'size': 240000,
  };

  Future<void> zeige(WidgetTester tester, Widget kind) async {
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: kind)),
    ));
  }

  testWidgets('neben der Datei steht ein Herunterladen-Knopf', (tester) async {
    await zeige(
      tester,
      ChatAnhangZeile(
        attachment: bescheid,
        isOwn: false,
        onOeffnen: () {},
        onHerunterladen: () {},
      ),
    );
    expect(find.text('Bescheid Jobcenter.pdf'), findsOneWidget);
    expect(find.text('234.4 KB'), findsOneWidget);
    expect(find.byIcon(Icons.download), findsOneWidget);
    expect(find.byTooltip('Herunterladen'), findsOneWidget);
  });

  testWidgets('auch in der eigenen Blase', (tester) async {
    await zeige(
      tester,
      ColoredBox(
        color: const Color(0xFF667eea),
        child: ChatAnhangZeile(
          attachment: bescheid,
          isOwn: true,
          onOeffnen: () {},
          onHerunterladen: () {},
        ),
      ),
    );
    expect(find.byIcon(Icons.download), findsOneWidget);
  });

  testWidgets('der Knopf lädt herunter, die Zeile öffnet', (tester) async {
    var geoeffnet = 0;
    var geladen = 0;
    await zeige(
      tester,
      ChatAnhangZeile(
        attachment: bescheid,
        isOwn: false,
        onOeffnen: () => geoeffnet++,
        onHerunterladen: () => geladen++,
      ),
    );

    await tester.tap(find.byIcon(Icons.download));
    expect((geladen, geoeffnet), (1, 0));

    await tester.tap(find.text('Bescheid Jobcenter.pdf'));
    expect((geladen, geoeffnet), (1, 1));
  });

  testWidgets('während des Ladens: Kreisel, und ein Tipp öffnet nichts',
      (tester) async {
    var geoeffnet = 0;
    var geladen = 0;
    await zeige(
      tester,
      ChatAnhangZeile(
        attachment: bescheid,
        isOwn: false,
        onOeffnen: () => geoeffnet++,
        onHerunterladen: () => geladen++,
        laedt: true,
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(Icons.download), findsNothing);

    // Der Tipp landet beim Knopf (der Aufrufer fängt ihn ab), nicht bei der
    // Zeile darunter — die würde die Datei öffnen.
    await tester.tap(find.byType(CircularProgressIndicator));
    expect(geoeffnet, 0);
    expect(geladen, 1);
  });

  testWidgets('gespeichert: Haken und Ort im Tooltip', (tester) async {
    await zeige(
      tester,
      ChatAnhangZeile(
        attachment: bescheid,
        isOwn: false,
        onOeffnen: () {},
        onHerunterladen: () {},
        gespeichertIn: '/home/mitglied/Downloads/Bescheid Jobcenter.pdf',
      ),
    );
    expect(find.byIcon(Icons.download_done), findsOneWidget);
    expect(
      find.byTooltip('Gespeichert: /home/mitglied/Downloads/Bescheid Jobcenter.pdf'),
      findsOneWidget,
    );
  });

  testWidgets('langer Name, schmale Blase, doppelte Schrift: kein Überlauf',
      (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2.0;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await zeige(
      tester,
      SizedBox(
        width: 180,
        child: ChatAnhangZeile(
          attachment: {
            ...bescheid,
            'filename': 'Widerspruchsbescheid_Jobcenter_Landkreis_${'x' * 60}.pdf',
          },
          isOwn: false,
          onOeffnen: () {},
          onHerunterladen: () {},
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.byIcon(Icons.download), findsOneWidget);
  });

  test('der Live-Chat baut jede Anhangzeile mit dem Knopf', () {
    var q = File('lib/widgets/live_chat_dialog.dart').readAsStringSync();
    q = q.replaceAll(RegExp(r'^\s*//.*$', multiLine: true), '');

    expect(
      RegExp(r'ChatAnhangZeile\([^;]*onHerunterladen: \(\) => _saveAttachment\(attachment\)')
          .hasMatch(q),
      isTrue,
      reason: 'Knopf nicht mit _saveAttachment verbunden',
    );
    // Keine Plattform-Weiche um die Zeile: der Knopf gehört überall hin.
    final bau = q.substring(q.indexOf('Widget _buildModernAttachment('));
    final ende = bau.indexOf('\n  }\n');
    expect(bau.substring(0, ende), isNot(contains('Platform.')));

    // Öffnen und Speichern holen beide über denselben Weg, der auch große
    // Anhänge (download_url) kennt.
    expect(RegExp(r'chatAnhangAusAntwort\(').allMatches(q).length, 1);
    expect(RegExp(r'await _loadAttachment\(attachment\)').allMatches(q).length, 2);
    expect(q, contains('await dateiAblegen('));
  });
}
