import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Der Knopf „Jetzt unterschreiben" muss freigegeben werden, sobald der Code
/// im Feld steht — ohne dass irgendwo ein setState danebengeht.
///
/// Anlass ist ein echter Ausfall: ein Mitglied bekam die SMS, tippte den Code
/// ein und kam nicht weiter. Auf dem Server standen drei Code-Anforderungen
/// hintereinander und KEIN einziger Signier-Versuch — jemand tippte, kam nicht
/// weiter, forderte einen neuen Code an, wieder von vorn.
///
/// Ursache war, dass der Knopfzustand aus `_tanFeld.text` gelesen, der
/// Neuaufbau aber nur bei `onChanged` mit vorhandener Fehlermeldung ausgelöst
/// wurde. Beim ersten Eintippen gibt es keine.
///
/// Der Test bildet genau diese Verdrahtung nach, in beiden Varianten: die
/// kaputte muss durchfallen, die eingebaute muss halten. Ohne die kaputte
/// Variante daneben wäre nicht belegt, dass der Test den Fehler überhaupt
/// bemerkt hätte.
void main() {
  Future<void> tippen(WidgetTester tester, String code) async {
    await tester.enterText(find.byType(TextField), code);
    await tester.pump();
  }

  bool knopfAktiv(WidgetTester tester) {
    final knopf = tester.widget<FilledButton>(find.byType(FilledButton));
    return knopf.onPressed != null;
  }

  testWidgets('so wie eingebaut: Knopf wird beim Eintippen freigegeben',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _RichtigVerdrahtet()));

    expect(knopfAktiv(tester), isFalse, reason: 'leeres Feld -> gesperrt');
    await tippen(tester, '047961');
    expect(knopfAktiv(tester), isTrue,
        reason: 'Code steht im Feld — der Knopf MUSS freigegeben sein, sonst '
            'kann das Mitglied nicht unterschreiben.');
  });

  testWidgets('Gegenprobe: die alte Verdrahtung bleibt gesperrt', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _AlteVerdrahtung()));

    await tippen(tester, '047961');
    expect(knopfAktiv(tester), isFalse,
        reason: 'Das war der Fehler. Wird das hier grün, prüft der Test oben '
            'nichts mehr.');
  });

  testWidgets('zu kurzer Code gibt den Knopf nicht frei', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _RichtigVerdrahtet()));

    await tippen(tester, '04');
    expect(knopfAktiv(tester), isFalse);
    await tippen(tester, '0479');
    expect(knopfAktiv(tester), isTrue);
  });

  testWidgets('Loeschen sperrt den Knopf wieder', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _RichtigVerdrahtet()));

    await tippen(tester, '047961');
    expect(knopfAktiv(tester), isTrue);
    await tippen(tester, '');
    expect(knopfAktiv(tester), isFalse);
  });
}

/// Der Zustand kommt aus dem Controller — wie im Bildschirm eingebaut.
class _RichtigVerdrahtet extends StatefulWidget {
  const _RichtigVerdrahtet();
  @override
  State<_RichtigVerdrahtet> createState() => _RichtigVerdrahtetState();
}

class _RichtigVerdrahtetState extends State<_RichtigVerdrahtet> {
  final _feld = TextEditingController();
  String? _fehler;

  @override
  void dispose() {
    _feld.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          TextField(
            controller: _feld,
            decoration: InputDecoration(errorText: _fehler),
            onChanged: (_) {
              if (_fehler != null) setState(() => _fehler = null);
            },
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _feld,
            builder: (_, wert, __) => FilledButton(
              onPressed: wert.text.trim().length >= 4 ? () {} : null,
              child: const Text('Jetzt unterschreiben'),
            ),
          ),
        ]),
      );
}

/// Wie es vorher war: Knopfzustand aus dem Text gelesen, Neuaufbau nur bei
/// wegfallender Fehlermeldung.
class _AlteVerdrahtung extends StatefulWidget {
  const _AlteVerdrahtung();
  @override
  State<_AlteVerdrahtung> createState() => _AlteVerdrahtungState();
}

class _AlteVerdrahtungState extends State<_AlteVerdrahtung> {
  final _feld = TextEditingController();
  String? _fehler;

  @override
  void dispose() {
    _feld.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          TextField(
            controller: _feld,
            decoration: InputDecoration(errorText: _fehler),
            onChanged: (_) {
              if (_fehler != null) setState(() => _fehler = null);
            },
          ),
          FilledButton(
            onPressed: _feld.text.trim().length >= 4 ? () {} : null,
            child: const Text('Jetzt unterschreiben'),
          ),
        ]),
      );
}
