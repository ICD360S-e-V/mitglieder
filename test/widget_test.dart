// Smoke-Test: die App startet auf der Sprachauswahl.
//
// Vorher prüfte dieser Test die Texte des alten Login-Screens
// („Mitgliederportal", „Anmelden"). `main.dart` zeigt beim ersten Start aber
// `LanguageSelectionScreen` — erst nach der Sprachwahl kommt der
// WelcomeScreen. Die erwarteten Texte gab es nirgends mehr, der Test war rot,
// ohne dass etwas kaputt gewesen wäre.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icd360sev_mitglied/main.dart';

void main() {
  testWidgets('App startet auf der Sprachauswahl', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MitgliedApp());

    expect(tester.takeException(), isNull);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('ICD360S e.V'), findsOneWidget);
    // Dreisprachig, weil zu diesem Zeitpunkt noch niemand weiß, welche
    // Sprache das Mitglied spricht.
    expect(find.text('Sprache wählen / Choose language / Selectează limba'),
        findsOneWidget);
  });
}
