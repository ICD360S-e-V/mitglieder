import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/widgets/conversation_list_item.dart';

/// Die Gesprächsliste zeigt, mit WEM man schreibt — nicht sich selbst.
///
/// 🔴 Beide Widgets stammen aus der Vorsitzer-App; der Kommentar sagt es noch:
/// „A single conversation item in the ADMIN chat list". Dort ist `member_name`
/// richtig — der Verwalter sieht das Mitglied. Hier ist das Mitglied selbst der
/// Anmelder, also stand in seiner Liste sein EIGENER Name.
void main() {
  Widget rahmen(Widget kind) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: kind),
      );

  Widget eintrag(Map<String, dynamic> g) => rahmen(ConversationListItem(
        conversation: g,
        isSelected: false,
        hasActiveCall: false,
        onTap: () {},
      ));

  testWidgets('zeigt das Gegenüber, nicht das Mitglied des Gesprächs',
      (tester) async {
    await tester.pumpWidget(eintrag({
      'id': 1,
      'member_name': 'V. Bancu', // das bin ich selbst
      'gegenueber_name': 'I. C. Duinea', // mit dem schreibe ich
      'last_message': 'Guten Tag',
      'unread_count': 0,
    }));
    expect(find.text('I. C. Duinea'), findsOneWidget);
    expect(find.text('V. Bancu'), findsNothing,
        reason: 'der eigene Name gehört nicht in die eigene Gesprächsliste');
  });

  testWidgets('fällt auf member_name zurück, wenn der Server älter ist',
      (tester) async {
    // Ohne Rückfall bliebe die Liste an einem alten Server namenlos — das
    // wäre schlimmer als ein falscher Name.
    await tester.pumpWidget(eintrag({
      'id': 2,
      'member_name': 'A. Muster',
      'last_message': 'Hallo',
      'unread_count': 0,
    }));
    expect(find.text('A. Muster'), findsOneWidget);
  });

  testWidgets('ein leerer Name zerbricht die Liste nicht', (tester) async {
    // ⚠️ `memberName[0]` wirft bei leerem Text, und `??` fängt nur null.
    // Vorher stand dort der eigene, immer gesetzte Name; jetzt kommt der Wert
    // aus einer Datenzeile. Eine Zeile ohne Namen würde sonst die ganze Liste
    // als roten Bildschirm hinterlassen.
    await tester.pumpWidget(eintrag({
      'id': 3,
      'gegenueber_name': '',
      'last_message': 'x',
      'unread_count': 0,
    }));
    expect(tester.takeException(), isNull);
    expect(find.text('?'), findsOneWidget);
  });
}
