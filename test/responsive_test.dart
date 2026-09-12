// Prüft die zentrale Geräteskalierung: den Faktor selbst, den Deckel auf der
// System-Schriftgröße und dass die Oberfläche auf kleinen Geräten nicht
// überläuft.
//
// Hintergrund: die Größen dieser App stehen fest im Code (fontSize: 16,
// EdgeInsets.all(20) …) und waren für ein ~390 dp breites Telefon gezeichnet.
// Auf schmaleren Geräten und bei hochgedrehter Systemschrift war sie zu groß.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:icd360sev_mitglied/main.dart';
import 'package:icd360sev_mitglied/utils/responsive.dart';

/// Rendert [child] in einem Fenster der Größe [size] und gibt den BuildContext
/// zurück, mit dem sich die Responsive-Helfer abfragen lassen.
Future<BuildContext> _contextAt(WidgetTester tester, Size size) async {
  late BuildContext captured;
  await tester.pumpWidget(
    MediaQuery(
      // Über die View, damit die vom Test gesetzte System-Schriftgröße
      // (textScaleFactorTestValue) mit ankommt — genau die wird gedeckelt.
      data: MediaQueryData.fromView(tester.view).copyWith(size: size),
      child: Builder(
        builder: (context) {
          captured = context;
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return captured;
}

/// Setzt die Fenstergröße für einen Test und räumt danach wieder auf.
void _setWindow(WidgetTester tester, Size logicalSize, {double dpr = 2.0}) {
  tester.view.devicePixelRatio = dpr;
  tester.view.physicalSize = logicalSize * dpr;
  addTearDown(tester.view.reset);
}

void main() {
  group('Responsive.uiScale', () {
    testWidgets('Referenzgerät bleibt bei 1.0', (tester) async {
      final context = await _contextAt(tester, const Size(390, 844));
      expect(Responsive.uiScale(context), closeTo(1.0, 0.001));
    });

    testWidgets('schmales Telefon wird kleiner, aber nie unter das Minimum',
        (tester) async {
      final context = await _contextAt(tester, const Size(320, 568));
      final scale = Responsive.uiScale(context);
      expect(scale, lessThan(1.0));
      expect(scale, greaterThanOrEqualTo(Responsive.minScale));
    });

    testWidgets('gewöhnliches 360×640-Telefon landet nicht am Anschlag',
        (tester) async {
      // Die Breite trägt hier noch; nur die Höhe bremst — und das mit halbem
      // Gewicht, sonst wäre die ganze Oberfläche unnötig geschrumpft.
      final context = await _contextAt(tester, const Size(360, 640));
      final scale = Responsive.uiScale(context);
      expect(scale, greaterThan(Responsive.minScale));
      expect(scale, lessThan(1.0));
    });

    testWidgets('großes Desktop-Fenster wird gedeckelt', (tester) async {
      final context = await _contextAt(tester, const Size(1920, 1080));
      expect(Responsive.uiScale(context), Responsive.maxScale);
    });

    testWidgets('Abstände schrumpfen stärker als Schriften', (tester) async {
      final context = await _contextAt(tester, const Size(320, 568));
      expect(Responsive.space(context, 100),
          lessThan(Responsive.scaled(context, 100)));
    });
  });

  group('Responsive.textScaler', () {
    testWidgets('deckelt die System-Schriftgröße', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final context = await _contextAt(tester, const Size(390, 844));
      final scaled = Responsive.textScaler(context).scale(10);
      expect(scaled, lessThanOrEqualTo(10 * Responsive.maxTextScale));
      // Gedeckelt, aber nicht ignoriert: wer groß eingestellt hat, sieht groß.
      expect(scaled, greaterThan(10));
    });

    testWidgets('bleibt bei kleiner Systemschrift über dem Minimum',
        (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 0.5;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final context = await _contextAt(tester, const Size(320, 568));
      expect(Responsive.textScaler(context).scale(10),
          greaterThanOrEqualTo(10 * Responsive.minTextScale));
    });
  });

  group('Responsive.dialogSize', () {
    testWidgets('Wunschmaß bleibt auf dem Desktop erhalten', (tester) async {
      final context = await _contextAt(tester, const Size(1600, 1000));
      final size = Responsive.dialogSize(context, width: 550, height: 720);
      expect(size, const Size(550, 720));
    });

    testWidgets('auf dem Telefon passt der Dialog ins Fenster', (tester) async {
      const window = Size(360, 640);
      final context = await _contextAt(tester, window);
      final size = Responsive.dialogSize(context, width: 550, height: 720);
      expect(size.width, lessThan(window.width));
      expect(size.height, lessThan(window.height));
    });
  });

  group('Sprachauswahl rendert ohne Überlauf', () {
    // Klein, üblich, groß, Tablet — plus einmal mit maximal hochgedrehter
    // Systemschrift, denn genau diese Kombination ließ Karten überlaufen.
    const geraete = <String, Size>{
      'kleines Telefon (320×568)': Size(320, 568),
      'übliches Telefon (360×640)': Size(360, 640),
      'aktuelles Telefon (412×915)': Size(412, 915),
      'Tablet (800×1280)': Size(800, 1280),
    };

    geraete.forEach((name, size) {
      testWidgets(name, (tester) async {
        SharedPreferences.setMockInitialValues({});
        _setWindow(tester, size);

        await tester.pumpWidget(const MitgliedApp());
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(find.byType(GridView), findsOneWidget);
      });
    });

    testWidgets('kleines Telefon mit größter Systemschrift', (tester) async {
      SharedPreferences.setMockInitialValues({});
      _setWindow(tester, const Size(320, 568));
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(const MitgliedApp());
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });
}
