// Die App laeuft auf Windows nur EINMAL.
//
// 🔴 WAS HIER SCHIEFGING. Das Kreuz beendet die App nicht, es versteckt sie im
// Infobereich. Wer sie danach ueber die Desktop-Verknuepfung, das Startmenue
// oder den Autostart wieder oeffnete, bekam einen ZWEITEN Prozess — mit
// eigener WebSocket-Verbindung. Der Server stellt eine Fernwartungsanfrage
// jeder Verbindung des Mitglieds zu (ChatServer::handleRemoteOffer), und mit
// mehreren Kopien sah der Vorsitz bei der Fernwartung nur Schwarz.
//
// Diese Zusicherungen halten die Sperre in windows/runner/main.cpp zusammen.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ⚠️ Kommentare werden LAENGENTREU geleert: sonst findet eine Zusicherung
/// ihren eigenen Erklaerkommentar, und Positionsvergleiche verrutschen.
String ohneKommentare(String q) => q
    .replaceAllMapped(RegExp(r'/\*.*?\*/', dotAll: true),
        (m) => m[0]!.replaceAll(RegExp(r'[^\n]'), ' '))
    .split('\n')
    .map((z) {
      final i = z.indexOf('//');
      return i < 0 ? z : z.substring(0, i) + ' ' * (z.length - i);
    })
    .join('\n');

/// Schneidet ab dem Kopf bis zur ausgeglichenen schliessenden Klammer.
String rumpf(String quelle, String kopf) {
  final start = quelle.indexOf(kopf);
  expect(start, greaterThanOrEqualTo(0), reason: 'Kopf nicht gefunden: $kopf');
  var i = start;
  var rund = 0;
  while (i < quelle.length) {
    final c = quelle[i];
    if (c == '(') rund++;
    if (c == ')') rund--;
    if (c == '{' && rund == 0) break;
    i++;
  }
  final ab = i;
  var tiefe = 0;
  while (i < quelle.length) {
    if (quelle[i] == '{') tiefe++;
    if (quelle[i] == '}') {
      tiefe--;
      if (tiefe == 0) return quelle.substring(ab, i + 1);
    }
    i++;
  }
  fail('Rumpf nicht geschlossen: $kopf');
}

void main() {
  late String quelle;
  late String start;

  setUpAll(() {
    quelle = ohneKommentare(File('windows/runner/main.cpp').readAsStringSync());
    start = rumpf(quelle, 'int APIENTRY wWinMain(');
  });

  test('die Pruefung kommt vor allem anderen — vor COM und vor dem Fenster',
      () {
    final pruefung = start.indexOf('if (!EinzigeInstanz())');
    expect(pruefung, greaterThanOrEqualTo(0));
    expect(pruefung, lessThan(start.indexOf('CoInitializeEx(')));
    expect(pruefung, lessThan(start.indexOf('window.Create(')));
    // Der zweite Start beendet sich — er baut keine Engine und keine
    // Verbindung auf.
    expect(start.substring(pruefung, start.indexOf('CoInitializeEx(')),
        contains('return EXIT_SUCCESS;'));
  });

  test('benannter Mutex je Anmeldesitzung, Debug getrennt von Release', () {
    final sperre = rumpf(quelle, 'bool EinzigeInstanz()');
    expect(sperre, contains('CreateMutexW(nullptr, TRUE, kEinzelinstanz)'));
    expect(sperre, contains('ERROR_ALREADY_EXISTS'));
    // "Local\" und nicht "Global\": zwei Benutzer am selben Rechner behalten
    // jeder ihre eigene App.
    expect(quelle,
        contains(r'L"Local\\ICD360S.Mitglieder.Einzelinstanz"'));
    expect(quelle,
        contains(r'L"Local\\ICD360S.Mitglieder.Einzelinstanz.Debug"'));
    expect(quelle, isNot(contains(r'Global\\')));
  });

  test('beendet sich die alte App gerade, startet die neue danach selbst', () {
    // „Beenden" im Infobereich und sofort wieder öffnen: ohne das Warten auf
    // den freigegebenen Mutex täte der zweite Klick gar nichts.
    final sperre = rumpf(quelle, 'bool EinzigeInstanz()');
    expect(sperre, contains('WaitForSingleObject(sperre'));
    expect(sperre, contains('WAIT_ABANDONED'));
    // Schlaegt der Mutex fehl, startet die App trotzdem.
    final fehlschlag = sperre.indexOf('if (sperre == nullptr)');
    expect(fehlschlag, greaterThanOrEqualTo(0));
    expect(
        sperre.substring(fehlschlag, sperre.indexOf('}', fehlschlag)),
        contains('return true;'));
  });

  test('die laufende App kommt nach vorne — auch aus dem Infobereich', () {
    final vorne = rumpf(quelle, 'void NachVorneHolen(HWND fenster)');
    expect(vorne, contains('AllowSetForegroundWindow('));
    // Versteckt (SW_HIDE) braucht SW_SHOW, minimiert SW_RESTORE.
    expect(vorne, contains('SW_RESTORE'));
    expect(vorne, contains('SW_SHOW'));
    expect(vorne, contains('ShowWindowAsync('));
    expect(vorne, contains('SetForegroundWindow(fenster)'));
  });

  test('das Fenster wird an seiner Marke erkannt, nicht an Titel oder Klasse',
      () {
    // Die Fensterklasse FLUTTER_RUNNER_WIN32_WINDOW hat jede Flutter-App —
    // auch die Vorsitzer-App auf demselben Rechner.
    final suche = rumpf(quelle, 'HWND LaufendesFenster()');
    expect(suche, contains('EnumWindows('));
    expect(quelle, isNot(contains('FindWindow')));
    expect(rumpf(quelle, 'BOOL CALLBACK MarkeSuchen('),
        contains('GetPropW(fenster, kFensterMarke)'));
  });

  test('die Marke steht ab dem Fenster und faellt, sobald die Schleife endet',
      () {
    final gesetzt =
        start.indexOf('SetPropW(window.GetHandle(), kFensterMarke');
    expect(gesetzt, greaterThan(start.indexOf('window.Create(')));
    final schleife = start.indexOf('while (::GetMessage(');
    final entfernt =
        start.indexOf('RemovePropW(window.GetHandle(), kFensterMarke)');
    expect(schleife, greaterThan(gesetzt));
    expect(entfernt, greaterThan(schleife));
    expect(entfernt, lessThan(start.indexOf('CoUninitialize();')));
  });
}
