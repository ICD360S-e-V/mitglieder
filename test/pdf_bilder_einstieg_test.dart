import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/screens/pdf_bilder_screen.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/utils/responsive.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_extras_dialog.dart';

/// Der Weg zu „PDF in Bilder": dritte Zeile in den Sonderfunktionen, dann der
/// leere Bildschirm mit seinem Hinweis.
Widget _app(Widget home) {
  return MaterialApp(
    locale: const Locale('de'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light,
    builder: (context, child) =>
        ResponsiveScaling(child: child ?? const SizedBox.shrink()),
    home: home,
  );
}

void main() {
  testWidgets('Sonderfunktionen: drei Werkzeuge, das dritte ist „PDF in Bilder“',
      (tester) async {
    var unterschreiben = 0;
    var bilder = 0;
    await tester.pumpWidget(_app(Builder(
      builder: (context) => Scaffold(
        body: TextButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (_) => MitgliedExtrasDialog(
              onPdfUnterschreiben: () => unterschreiben++,
              onPdfInBilder: () => bilder++,
            ),
          ),
          child: const Text('öffnen'),
        ),
      ),
    )));
    await tester.tap(find.text('öffnen'));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(3));
    final titel = tester
        .widgetList<ListTile>(find.byType(ListTile))
        .map((t) => (t.title as Text).data)
        .toList();
    expect(titel, ['Eigenes PDF unterschreiben', 'Taschenrechner', 'PDF in Bilder']);

    await tester.tap(find.text('PDF in Bilder'));
    await tester.pumpAndSettle();
    expect(bilder, 1);
    expect(unterschreiben, 0);
    // Erst schließen, dann öffnen — sonst schöbe sich der neue Bildschirm
    // unter den Dialog.
    expect(find.byType(MitgliedExtrasDialog), findsNothing);
  });

  testWidgets('leerer Bildschirm: PDF wählen und der Satz, dass nichts das Gerät verlässt',
      (tester) async {
    await tester.pumpWidget(_app(const PdfBilderScreen()));
    await tester.pump();

    expect(find.text('PDF in Bilder'), findsOneWidget);
    expect(find.text('PDF auswählen'), findsOneWidget);
    expect(
      find.text(
          'Die Bilder entstehen auf diesem Gerät. Das PDF wird nirgendwohin geschickt.'),
      findsOneWidget,
    );
  });

  testWidgets('Plural und Ordnername stehen richtig in der Meldung', (tester) async {
    late AppLocalizations de;
    late AppLocalizations ro;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(builder: (context) {
        de = AppLocalizations.of(context)!;
        return const SizedBox.shrink();
      }),
      locale: const Locale('de'),
    ));
    ro = await AppLocalizations.delegate.load(const Locale('ro'));

    expect(de.pdfBilderSeiten(1), '1 Seite → 1 Bild');
    expect(de.pdfBilderSeiten(5), '5 Seiten → 5 Bilder');
    expect(de.pdfBilderFertig(5, 'Poze'), '5 Bilder in „Poze“ gespeichert.');
    expect(ro.pdfBilderSeiten(1), '1 pagină → 1 poză');
    expect(ro.pdfBilderSeiten(5), '5 pagini → 5 poze');
    expect(ro.pdfBilderSeiten(20), '20 de pagini → 20 de poze');
    expect(ro.pdfBilderFertig(3, 'Poze'), '3 poze salvate în „Poze”.');
  });
}
