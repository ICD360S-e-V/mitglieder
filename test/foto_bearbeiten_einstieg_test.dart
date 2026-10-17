import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/screens/foto_bearbeiten_screen.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/utils/foto_bearbeiten.dart';
import 'package:icd360sev_mitglied/utils/foto_quelle.dart';
import 'package:icd360sev_mitglied/utils/responsive.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_extras_dialog.dart';
import 'package:image/image.dart' as img;
import 'package:material_ui/material_ui.dart' as material_ui;

/// Der Weg durch „Foto bearbeiten": vierte Zeile in den Sonderfunktionen, die
/// Wahl Ordner/Foto, der Editor mit unseren Tasten, „Größe", und die Frage
/// nach dem Original. Die Quelle ist erfunden — Lesen, Kopie und Löschen
/// prüft foto_quelle_test.dart.
Widget _app(Widget home) {
  return MaterialApp(
    locale: const Locale('de'),
    localizationsDelegates: [
      ...AppLocalizations.localizationsDelegates,
      // Wie in main.dart: der Editor braucht die Texte von material_ui.
      ...material_ui.GlobalMaterialLocalizations.delegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light,
    builder: (context, child) =>
        ResponsiveScaling(child: child ?? const SizedBox.shrink()),
    home: home,
  );
}

/// Öffnet [inhalt] über einen Knopf und merkt sich, was der Dialog zurückgibt.
Widget _oeffner<T>(Widget inhalt, void Function(T?) ergebnis) {
  return Builder(
    builder: (context) => Scaffold(
      body: TextButton(
        onPressed: () async => ergebnis(
            await showDialog<T>(context: context, builder: (_) => inhalt)),
        child: const Text('öffnen'),
      ),
    ),
  );
}

Uint8List _bild(int breite, int hoehe) =>
    img.encodePng(img.Image(width: breite, height: hoehe)
      ..clear(img.ColorRgb8(90, 140, 200)));

/// Wartet auf echte asynchrone Arbeit (Dekodieren, Isolate) — im Testtakt
/// läuft die nicht von allein.
Future<void> _warten(WidgetTester tester, bool Function() fertig) async {
  for (var i = 0; i < 100 && !fertig(); i++) {
    await tester
        .runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump(const Duration(milliseconds: 50));
  }
}

class _TestQuelle implements FotoQuelle {
  _TestQuelle(this.fotos);

  final Map<String, Uint8List> fotos;
  final geloescht = <String>[];
  final kopien = <String, Uint8List>{};

  @override
  String get name => 'Camera';

  @override
  bool get istOrdner => true;

  @override
  bool get inFotosApp => false;

  @override
  Future<List<FotoEintrag>> auflisten() async => [
        for (final n in fotos.keys)
          FotoEintrag(schluessel: n, name: n, groesse: fotos[n]!.length),
      ];

  @override
  Future<Uint8List> lesen(FotoEintrag eintrag) async =>
      fotos[eintrag.schluessel]!;

  @override
  Future<Uint8List?> vorschau(FotoEintrag eintrag, int kante) async =>
      fotos[eintrag.schluessel];

  @override
  Future<String?> kopieSpeichern(
    FotoEintrag original, {
    required String dateiname,
    required Uint8List bytes,
    required String mime,
  }) async {
    kopien[dateiname] = bytes;
    fotos[dateiname] = bytes;
    return dateiname;
  }

  @override
  Future<bool> originalLoeschen(FotoEintrag eintrag) async {
    geloescht.add(eintrag.schluessel);
    return fotos.remove(eintrag.schluessel) != null;
  }

  @override
  Future<void> schliessen() async {}
}

void main() {
  testWidgets(
      'Sonderfunktionen: vier Werkzeuge, das vierte ist „Foto bearbeiten“',
      (tester) async {
    var foto = 0;
    var bilder = 0;
    await tester.pumpWidget(_app(_oeffner<void>(
      MitgliedExtrasDialog(
        onPdfUnterschreiben: () {},
        onPdfInBilder: () => bilder++,
        onFotoBearbeiten: () => foto++,
      ),
      (_) {},
    )));
    await tester.tap(find.text('öffnen'));
    await tester.pumpAndSettle();

    final titel = tester
        .widgetList<ListTile>(find.byType(ListTile))
        .map((t) => (t.title as Text).data)
        .toList();
    expect(titel, [
      'Eigenes PDF unterschreiben',
      'Taschenrechner',
      'PDF in Bilder',
      'Foto bearbeiten',
    ]);

    await tester.tap(find.text('Foto bearbeiten'));
    await tester.pumpAndSettle();
    expect(foto, 1);
    expect(bilder, 0);
    expect(find.byType(MitgliedExtrasDialog), findsNothing);
  });

  testWidgets(
      'die Wahl: Ordner oder ein Foto, und der Satz, dass nichts das Gerät verlässt',
      (tester) async {
    FotoWahl? wahl;
    await tester.pumpWidget(_app(_oeffner<FotoWahl>(
      const FotoBearbeitenAuswahl(),
      (w) => wahl = w,
    )));
    await tester.tap(find.text('öffnen'));
    await tester.pumpAndSettle();

    expect(find.text('Ordner öffnen'), findsOneWidget);
    expect(find.text('alle Fotos darin'), findsOneWidget);
    expect(find.text('Ein Foto öffnen'), findsOneWidget);
    expect(find.text('aus der Galerie oder aus den Dateien'), findsOneWidget);
    expect(
        find.text('Die Fotos verlassen dieses Gerät nicht.'), findsOneWidget);

    await tester.tap(find.text('Ordner öffnen'));
    await tester.pumpAndSettle();
    expect(wahl, FotoWahl.ordner);

    await tester.tap(find.text('öffnen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ein Foto öffnen'));
    await tester.pumpAndSettle();
    expect(wahl, FotoWahl.foto);
  });

  group('nach dem Speichern', () {
    Future<bool?> antwortAuf(
        WidgetTester tester, Widget dialog, String knopf) async {
      bool? ergebnis;
      await tester
          .pumpWidget(_app(_oeffner<bool>(dialog, (e) => ergebnis = e)));
      await tester.tap(find.text('öffnen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(knopf));
      await tester.pumpAndSettle();
      return ergebnis;
    }

    const dialog = FotoGespeichertDialog(
      kopie: 'IMG_20261017_142305_bearbeitet.jpg',
      original: 'IMG_20261017_142305.jpg',
      inFotosApp: false,
    );

    testWidgets('Kopie und Original stehen da; „Löschen“ heißt löschen',
        (tester) async {
      bool? ergebnis;
      await tester
          .pumpWidget(_app(_oeffner<bool>(dialog, (e) => ergebnis = e)));
      await tester.tap(find.text('öffnen'));
      await tester.pumpAndSettle();

      expect(find.text('Das bearbeitete Foto ist gespeichert'), findsOneWidget);
      expect(find.text('IMG_20261017_142305_bearbeitet.jpg'), findsOneWidget);
      expect(
          find.text('Das Original ist unverändert geblieben:'), findsOneWidget);
      expect(find.text('IMG_20261017_142305.jpg'), findsOneWidget);
      expect(find.text('Möchten Sie das Original löschen?'), findsOneWidget);
      expect(find.text('Das Löschen lässt sich nicht rückgängig machen.'),
          findsOneWidget);

      await tester.tap(find.text('Löschen'));
      await tester.pumpAndSettle();
      expect(ergebnis, isTrue);
    });

    testWidgets('„Behalten“ behält', (tester) async {
      expect(await antwortAuf(tester, dialog, 'Behalten'), isFalse);
    });

    testWidgets(
        'iPhone: Kopie in „Fotos“, gelöscht wird nach „Zuletzt gelöscht“',
        (tester) async {
      await tester.pumpWidget(_app(_oeffner<bool>(
        const FotoGespeichertDialog(
          kopie: 'IMG_0042_bearbeitet.jpg',
          original: 'IMG_0042.jpg',
          inFotosApp: true,
        ),
        (_) {},
      )));
      await tester.tap(find.text('öffnen'));
      await tester.pumpAndSettle();
      expect(find.text('In „Fotos“'), findsOneWidget);
      expect(
        find.text(
            'Es kommt in „Zuletzt gelöscht“ und lässt sich dort wiederherstellen.'),
        findsOneWidget,
      );
      expect(find.text('Das Löschen lässt sich nicht rückgängig machen.'),
          findsNothing);
    });
  });

  testWidgets(
      '„Größe“: 50 % rechnet die Maße und die Datei, „Anwenden“ gibt es zurück',
      (tester) async {
    FotoGroesse? ergebnis;
    await tester.pumpWidget(_app(Builder(
      builder: (context) => Scaffold(
        body: TextButton(
          onPressed: () async =>
              ergebnis = await showModalBottomSheet<FotoGroesse>(
            context: context,
            isScrollControlled: true,
            builder: (_) => FotoGroessePanel(
              start: const FotoGroesse(),
              standardFormat: FotoFormat.jpg,
              jetztMasse: (breite: 4000, hoehe: 3000),
              jetztBytes: 3201478,
              bild: Future.value(_bild(400, 300)),
            ),
          ),
          child: const Text('öffnen'),
        ),
      ),
    )));
    await tester.tap(find.text('öffnen'));
    await tester.pumpAndSettle();

    expect(find.text('Größe'), findsOneWidget);
    expect(find.text('4000 x 3000 · 3.1 MB'), findsOneWidget);
    expect(find.text('400 x 300 px'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '50');
    await tester.pump();
    expect(find.text('200 x 150 px'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 400));
    await _warten(tester,
        () => find.textContaining('200 x 150 · ').evaluate().isNotEmpty);
    expect(find.textContaining('200 x 150 · '), findsOneWidget);

    await tester.tap(find.text('Anwenden'));
    await tester.pumpAndSettle();
    expect(ergebnis?.prozent, 50);
    expect(ergebnis?.inProzent, isTrue);
    expect(ergebnis?.format, isNull, reason: 'JPG wie das Original');
  });

  testWidgets(
      'Editor: unsere sechs Tasten, Blättern im Ordner, Speichern und Original löschen',
      (tester) async {
    tester.view.physicalSize = const Size(411 * 2.0, 914 * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    final quelle = _TestQuelle({
      'IMG_2.png': _bild(64, 48),
      'IMG_1.png': _bild(48, 64),
    });
    final eintraege = await quelle.auflisten();
    await tester.pumpWidget(_app(Builder(
      builder: (context) => Scaffold(
        body: TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => FotoEditorScreen(
                  quelle: quelle, eintraege: eintraege, index: 0),
            ),
          ),
          child: const Text('öffnen'),
        ),
      ),
    )));
    await tester.tap(find.text('öffnen'));
    await tester.pump();
    await _warten(tester, () => find.text('Zuschneiden').evaluate().isNotEmpty);
    // Der Editor fährt erst herein; vorher liegen die Tasten noch versetzt.
    await tester.pump(const Duration(seconds: 2));

    for (final taste in [
      'Zuschneiden',
      'Anpassen',
      'Filter',
      'Zeichnen',
      'Text',
      'Größe'
    ]) {
      expect(find.text(taste), findsOneWidget, reason: taste);
    }
    expect(find.text('1 von 2'), findsOneWidget);
    expect(find.text('Speichern'), findsOneWidget);

    // Auf einem 411 dp breiten Telefon liegen beide Pfeile im Bild.
    expect(tester.getRect(find.byIcon(Icons.chevron_right)).right,
        lessThanOrEqualTo(411));
    expect(tester.getRect(find.byIcon(Icons.chevron_left)).left,
        greaterThanOrEqualTo(0));

    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pump();
    // „2 von 2" steht schon während des Ladens unten; fertig ist der Editor
    // erst, wenn seine Tasten wieder da sind.
    await _warten(
        tester,
        () =>
            find.text('2 von 2').evaluate().isNotEmpty &&
            find.text('Zuschneiden').evaluate().isNotEmpty);
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('2 von 2'), findsOneWidget);

    // Speichern: Kopie neben dem Original, dann die Frage — „Löschen".
    await tester.tap(find.text('Speichern'));
    await tester.pump();
    await _warten(tester, () => find.text('Behalten').evaluate().isNotEmpty);
    expect(quelle.kopien.keys, ['IMG_1_bearbeitet.png']);
    expect(find.text('IMG_1_bearbeitet.png'), findsOneWidget);

    await tester.tap(find.text('Löschen'));
    await tester.pump();
    await _warten(tester, () => quelle.geloescht.isNotEmpty);
    expect(quelle.geloescht, ['IMG_1.png']);
    expect(quelle.fotos.containsKey('IMG_1.png'), isFalse);
    // Die Kopie ist jetzt das Foto im Editor — wieder zwei Fotos im Ordner.
    await _warten(
        tester,
        () =>
            find.text('2 von 2').evaluate().isNotEmpty &&
            find.text('Zuschneiden').evaluate().isNotEmpty);
    expect(find.text('2 von 2'), findsOneWidget);
    expect(find.text('Das Original wurde gelöscht.'), findsOneWidget);
  });
}
