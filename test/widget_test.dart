// Basic Flutter widget test for ICD360S Mitglied App

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/main.dart';

void main() {
  testWidgets('App loads login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MitgliedApp());

    // Verify login screen is displayed
    expect(find.text('ICD360S e.V'), findsOneWidget);
    expect(find.text('Mitgliederportal'), findsOneWidget);
    expect(find.text('Anmelden'), findsOneWidget);
  });
}
