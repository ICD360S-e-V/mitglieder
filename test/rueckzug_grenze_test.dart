// Die Zahl im Dialog muss die Zahl im Server sein.
//
// Anlass ist ein echter Fehler, und zwar ein dreifacher: der Abbruch-Dialog
// versprach dem Besucher drei Versuche, check_age.php sperrte aber schon beim
// ERSTEN Rueckzug im 90-Tage-Fenster, und finalize.php erst beim dritten.
// Keine der drei Zahlen stimmte mit einer anderen. Gemerkt haette man das erst
// an jemandem, der nach einem einzigen Abbruch nicht mehr hineinkam — und der
// haette dem Text geglaubt, nicht dem Code.
//
// ── Was sich am 17.09.2026 geaendert hat ───────────────────────────────────
//
// Dieser Test las die Grenze frueher aus `server/api/lib/RueckzugFenster.php`.
// Dieses Verzeichnis war eine Kopie des Serverzustands im Repository, und die
// Kopie war Fiktion: RueckzugFenster.php liegt auf dem Produktionsserver
// NIRGENDS, und kein einziger Endpunkt dort erwaehnt die Klasse. Der Test hat
// also gegen eine Datei geprueft, die es im Betrieb nie gab — und war deshalb
// gruen, waehrend die Zahlen live auseinanderliefen.
//
// Was live gilt (nachgesehen auf der Produktion am 17.09.2026):
//
//   check_age.php (Stand 28.06.2026, von PR #393 nie erreicht) ZAEHLT NICHT.
//   Es prueft, ob ueberhaupt eine Zeile 'gekuendigt_selbst' mit
//   deactivated_at > -90 Tage existiert, und sperrt dann hart.
//   finalize.php laesst 3 zu — kommt aber nie dran, weil check_age.php am
//   ANFANG des Assistenten laeuft und finalize.php am Ende.
//
// Die wirksame Grenze ist also 1. Die App verspricht in allen 28 Sprachen 10.
//
// Das ist exakt der Fehler, gegen den PR #393 geschrieben wurde: die
// Dart-Haelfte jenes PRs ist ausgeliefert, die PHP-Haelfte wurde nie auf den
// Server kopiert. Es gibt keinen automatischen PHP-Rollout.
//
// Aufloesen laesst sich das nur auf dem Server: die vier Dateien aus PR #393
// ausrollen. Danach [_serverGrenze] hier auf 10 setzen und den skip entfernen.
// Solange das nicht geschehen ist, steht die Zusicherung unten bewusst als
// uebersprungener Test da und nicht als roter Balken: sie beschreibt einen
// Befund im Betrieb, keinen Regressionsschaden an diesem Zweig.
//
// Der Server ist aus dem Repository verschwunden, die Pruefung der Sprachen
// gegeneinander nicht: dass alle 28 Dateien DIESELBE Zahl nennen, faengt den
// haeufigeren Fall ab — jemand zieht eine Sprache nach und vergisst die
// anderen 27.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Was der Produktionsserver tatsaechlich durchlaesst.
///
/// Steht hier als Zahl und nicht mehr als Lesevorgang, weil der serverseitige
/// PHP-Code nicht mehr im Repository liegt. Sie ist damit eine Zusicherung,
/// die jemand bewusst anfassen muss — genau das ist der Zweck.
///
/// Quelle: `api/public/wizard/check_age.php` auf icd360sev.icd360s.de. Die
/// Datei zaehlt nicht; die blosse Anwesenheit EINER zurueckgezogenen Anmeldung
/// im Fenster genuegt. Die 3 in finalize.php ist toter Code dahinter.
const int _serverGrenze = 1;
const int _serverFensterTage = 90;

/// Zieht alle Zahlen aus einem Text, damit „10-mal" und „10 retrageri"
/// gleichermassen gefunden werden.
Set<int> _zahlenIn(String text) =>
    RegExp(r'\d+').allMatches(text).map((m) => int.parse(m.group(0)!)).toSet();

void main() {
  final arbs = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  test('die Sprachdateien liegen ueberhaupt vor', () {
    expect(arbs.length, greaterThanOrEqualTo(28));
  });

  test('alle Sprachen nennen dieselbe Grenze und dasselbe Fenster', () {
    final proSprache = <String, Set<int>>{};

    for (final arb in arbs) {
      final name = arb.uri.pathSegments.last;
      final daten = jsonDecode(arb.readAsStringSync()) as Map<String, dynamic>;
      final text = daten['wizardAbandonDialogBody'] as String?;
      expect(text, isNotNull,
          reason: '$name: wizardAbandonDialogBody fehlt — dann verspricht '
              'diese Sprache dem Besucher gar nichts.');
      proSprache[name] = _zahlenIn(text!);
    }

    // Die erste Sprache gibt vor, was die anderen nennen muessen. Welche das
    // ist, spielt keine Rolle — es geht nur darum, dass sie sich einig sind.
    final erste = proSprache.entries.first;
    final abweichler = proSprache.entries
        .where((e) => !_mengenGleich(e.value, erste.value))
        .map((e) => '${e.key}: ${e.value.toList()..sort()}')
        .toList();

    expect(
      abweichler,
      isEmpty,
      reason: 'Diese Sprachen nennen andere Zahlen als '
          '${erste.key} (${erste.value.toList()..sort()}). Wer die Grenze '
          'verschiebt, muss alle 28 Dateien mitnehmen:\n'
          '${abweichler.join('\n')}',
    );
  });

  test('der Text verspricht, was der Server durchlaesst', () {
    final daten =
        jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync())
            as Map<String, dynamic>;
    final zahlen = _zahlenIn(daten['wizardAbandonDialogBody'] as String);

    expect(zahlen, contains(_serverGrenze),
        reason: 'Der Server sperrt bei $_serverGrenze Rueckzuegen, der Text '
            'nennt ${zahlen.toList()..sort()}.');
    expect(zahlen, contains(_serverFensterTage),
        reason: 'Der Server rechnet in $_serverFensterTage Tagen, der Text '
            'nennt ${zahlen.toList()..sort()}.');
  },
      skip: 'OFFEN seit 17.09.2026: check_age.php sperrt live schon beim '
          'ERSTEN Rueckzug im 90-Tage-Fenster, alle 28 Sprachen versprechen '
          '10. Die PHP-Haelfte von PR #393 wurde nie auf den Server '
          'kopiert. Erst ausrollen, dann _serverGrenze auf 10 setzen und '
          'diesen skip entfernen.');
}

bool _mengenGleich(Set<int> a, Set<int> b) =>
    a.length == b.length && a.containsAll(b);
