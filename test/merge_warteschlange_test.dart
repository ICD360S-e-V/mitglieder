// Die Merge-Warteschlange: .github/workflows/merge-warteschlange.yml und
// .github/scripts/merge_warteschlange.py (gleich in vorsitzer, mitglieder und
// schatzmeister — nur diese Konstante unterscheidet sich je App).
//
// Seit dem 17.10.2026 nachmittags ohne Zeitplan: ein Lauf wartet SELBST auf die
// Fassung und nimmt dann den nächsten PR (Gruppe „die Schleife“). Vorher kam die
// Schlange nach einem Bau nicht wieder — der Vorsitzende: „trebuie sa astepte
// cand se termina versionarea cand apare versiunea“.
//
// Wunsch des Vorsitzenden (17.10.2026): die PRs der Reihe nach mergen, vom
// ältesten zum neuesten, und den nächsten erst, wenn die Fassung des vorigen
// draußen ist.
//
// ⚠️ Nichts hier spricht mit GitHub. Das Skript entscheidet im Test allein aus
// einer JSON-Datei (`--entscheiden`), mit den Einstellungen, die wirklich im
// Ablauf stehen.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Wie der Knopf „Mergen" dieser App.
const String _mergeArt = 'squash';

const String _ablauf = '.github/workflows/merge-warteschlange.yml';
const String _skript = '.github/scripts/merge_warteschlange.py';
const String _jetzt = '2026-10-17T12:00:00Z';

String _vor(int minuten) =>
    DateTime.parse(_jetzt).subtract(Duration(minutes: minuten)).toUtc().toIso8601String();

String _lesen(String pfad) => File(pfad).readAsStringSync().replaceAll('\r\n', '\n');

/// Die Einstellungen aus dem `env:` des Ablaufs — so, wie das Skript sie liest.
Map<String, dynamic> _konfig() {
  final Map<String, String> env = <String, String>{
    for (final RegExpMatch m
        in RegExp(r'^ {10}([A-Z_]+): (.*)$', multiLine: true).allMatches(_lesen(_ablauf)))
      m.group(1)!: m.group(2)!.trim().replaceAll(RegExp(r'''^["']|["']$'''), ''),
  };
  List<String> liste(String k) => (env[k] ?? '').split(' ').where((String s) => s.isNotEmpty).toList();
  return <String, dynamic>{
    'art': env['MERGE_ART'],
    'warten': liste('LAEUFE_WARTEN'),
    'freigabe': env['FREIGABE_LAUF'],
    'bau': env['BAU_LAUF'],
    'veroeffentlicht': env['BAU_VEROEFFENTLICHT'],
    'nach': liste('NACH_DEM_MERGEN'),
    'autoren': liste('AUTOREN'),
  };
}

final Map<String, dynamic> _k = _konfig();

Map<String, dynamic> _skriptFragen(String schalter, Map<String, dynamic> daten) {
  final Directory d = Directory.systemTemp.createTempSync('warteschlange');
  try {
    final File f = File('${d.path}/daten.json')..writeAsStringSync(jsonEncode(daten));
    final ProcessResult r = Process.runSync('python3', <String>[_skript, schalter, f.path]);
    expect(r.exitCode, 0, reason: '${r.stderr}');
    return <String, dynamic>{'ergebnis': jsonDecode(r.stdout as String)};
  } finally {
    d.deleteSync(recursive: true);
  }
}

Map<String, dynamic> _entscheiden({
  List<Map<String, dynamic>> prs = const <Map<String, dynamic>>[],
  List<Map<String, dynamic>> laeufe = const <Map<String, dynamic>>[],
  List<Map<String, dynamic>> merges = const <Map<String, dynamic>>[],
}) =>
    _skriptFragen('--entscheiden', <String, dynamic>{
      'jetzt': _jetzt,
      'konfig': _k,
      'prs': prs,
      'laeufe': laeufe,
      'merges': merges,
    })['ergebnis'] as Map<String, dynamic>;

/// Die Schleife eines Laufs über feste Stände statt GitHub (`--folge`): jeder
/// Blick nimmt den nächsten Stand, die Uhr läuft nur beim Schlafen.
Map<String, dynamic> _folge(List<Map<String, dynamic>> staende, {bool trocken = false}) =>
    _skriptFragen('--folge', <String, dynamic>{
      'jetzt': _jetzt,
      'konfig': _k,
      'staende': staende,
      'trocken': trocken,
    })['ergebnis'] as Map<String, dynamic>;

List<String> _folgelaeufe(List<String> dateien) =>
    (_skriptFragen('--folgelaeufe', <String, dynamic>{'eintraege': _k['nach'], 'dateien': dateien})['ergebnis']
            as List<dynamic>)
        .cast<String>();

Map<String, dynamic> _pr(
  int n, {
  String pruefung = 'gruen',
  String mergeable = 'MERGEABLE',
  bool entwurf = false,
  String autor = 'icd360sevofficial',
  bool fork = false,
  List<String> etiketten = const <String>[],
  int alter = 120,
  String zweig = 'feat/etwas',
  List<Map<String, String>>? checks,
}) =>
    // [checks] statt [pruefung]: die Läufe genau so, wie gh sie liefert.
    <String, dynamic>{
      'number': n,
      'title': 'feat: PR $n',
      'author': <String, dynamic>{'login': autor},
      'isDraft': entwurf,
      'isCrossRepository': fork,
      'headRefName': zweig,
      'headRefOid': 'sha$n',
      'baseRefName': 'main',
      'mergeable': mergeable,
      'labels': <Map<String, String>>[for (final String e in etiketten) <String, String>{'name': e}],
      'createdAt': _vor(alter),
      'statusCheckRollup': checks ?? switch (pruefung) {
        'gruen' => <Map<String, String>>[
            <String, String>{'__typename': 'CheckRun', 'status': 'COMPLETED', 'conclusion': 'SUCCESS'},
            <String, String>{'__typename': 'CheckRun', 'status': 'COMPLETED', 'conclusion': 'SKIPPED'},
          ],
        'laeuft' => <Map<String, String>>[
            <String, String>{'__typename': 'CheckRun', 'status': 'COMPLETED', 'conclusion': 'SUCCESS'},
            <String, String>{'__typename': 'CheckRun', 'status': 'IN_PROGRESS', 'conclusion': ''},
          ],
        'rot' => <Map<String, String>>[
            <String, String>{'__typename': 'CheckRun', 'status': 'COMPLETED', 'conclusion': 'FAILURE'},
          ],
        _ => <Map<String, String>>[],
      },
    };

Map<String, dynamic> _lauf(
  String datei, {
  String status = 'completed',
  String conclusion = 'success',
  String event = 'workflow_dispatch',
  String zweig = 'v1.0.0',
  int alter = 60,
  List<Map<String, String>>? schritte,
}) =>
    <String, dynamic>{
      'datei': datei,
      'workflowName': datei,
      'status': status,
      'conclusion': status == 'completed' ? conclusion : '',
      'event': event,
      'headBranch': zweig,
      'createdAt': _vor(alter + 10),
      'updatedAt': _vor(alter),
      if (schritte != null) 'jobs': schritte,
    };

/// Der `on:`-Block eines Ablaufs, ohne Kommentare.
List<String> _ausloeser(String text) {
  final List<String> zeilen = text.split('\n');
  final int start = zeilen.indexWhere((String z) => z.startsWith('on:'));
  if (start < 0) return <String>[];
  final List<String> block = <String>[];
  for (final String z in zeilen.skip(start + 1)) {
    if (z.isNotEmpty && !z.startsWith(' ') && !z.startsWith('#')) break;
    final String ohne = z.replaceFirst(RegExp(r'\s+#.*$'), '');
    if (ohne.trim().isEmpty || ohne.trimLeft().startsWith('#')) continue;
    block.add(ohne);
  }
  return block;
}

/// Hört der Ablauf auf einen Push nach main? Dann seine `paths:` (leer: alle).
List<String>? _pushAufMain(String text) {
  final List<String> block = _ausloeser(text);
  final int i = block.indexWhere((String z) => z.trim() == 'push:');
  if (i < 0) return null;
  final int einzug = block[i].indexOf('push:');
  final List<String> teil = <String>[];
  for (final String z in block.skip(i + 1)) {
    if (z.length - z.trimLeft().length <= einzug) break;
    teil.add(z.trim());
  }
  final int b = teil.indexWhere((String z) => z.startsWith('branches:'));
  if (b < 0) return null;
  final bool main = teil[b].contains('main') ||
      teil.skip(b + 1).takeWhile((String z) => z.startsWith('- ')).any((String z) => z.contains('main'));
  if (!main) return null;
  final int p = teil.indexWhere((String z) => z.startsWith('paths:'));
  return <String>[
    if (p >= 0)
      for (final String z in teil.skip(p + 1).takeWhile((String z) => z.startsWith('- ')))
        z.substring(2).replaceAll(RegExp(r'''["']'''), '').trim(),
  ];
}

/// Auf welche Ereignisse eines PR hört der Ablauf? Ohne `types:` die drei, die
/// GitHub von sich aus nimmt — ein fertig gemeldeter Entwurf ist nicht dabei.
List<String> _prArten(String text) {
  final List<String> block = _ausloeser(text);
  final int i = block.indexWhere((String z) => z.trim() == 'pull_request:');
  if (i < 0) return <String>[];
  final int einzug = block[i].indexOf('pull_request:');
  for (final String z in block.skip(i + 1)) {
    if (z.length - z.trimLeft().length <= einzug) break;
    final RegExpMatch? m = RegExp(r'^types: *\[(.*)\]$').firstMatch(z.trim());
    if (m != null) return m.group(1)!.split(',').map((String s) => s.trim()).toList();
  }
  return <String>['opened', 'synchronize', 'reopened'];
}

Map<String, String> _ablaeufe() => <String, String>{
      for (final File f in Directory('.github/workflows')
          .listSync()
          .whereType<File>()
          .where((File f) => f.path.endsWith('.yml')))
        f.uri.pathSegments.last: _lesen(f.path),
    };

String? _name(String text) => RegExp(r'^name: *(.+)$', multiLine: true).firstMatch(text)?.group(1)?.trim();

void main() {
  group('der Reihe nach', () {
    test('der älteste fertige PR zuerst', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[_pr(12), _pr(11)]);
      expect(e['aktion'], 'mergen');
      expect(e['pr'], 11);
      expect(e['sha'], 'sha11');
    });

    test('laufen beim ältesten noch die Prüfungen, zieht kein jüngerer vorbei', () {
      final Map<String, dynamic> e =
          _entscheiden(prs: <Map<String, dynamic>>[_pr(11, pruefung: 'laeuft'), _pr(12)]);
      expect(e['aktion'], 'warten');
      expect(e['grund'], contains('#11'));
    });

    test('rechnet GitHub noch, ob er sich mergen lässt, wird gewartet', () {
      expect(_entscheiden(prs: <Map<String, dynamic>>[_pr(11, mergeable: 'UNKNOWN'), _pr(12)])['aktion'],
          'warten');
    });

    test('rot, Konflikt, Entwurf und Etikett `asteapta` werden übersprungen', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[
        _pr(11, pruefung: 'rot'),
        _pr(12, mergeable: 'CONFLICTING'),
        _pr(13, entwurf: true),
        _pr(14, etiketten: <String>['asteapta']),
        _pr(15),
      ]);
      expect(e['aktion'], 'mergen');
      expect(e['pr'], 15);
      expect(e['uebersprungen'], hasLength(4));
    });

    test('nie von Fremden: kein Fork, kein anderer Autor, kein Dependabot', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[
        _pr(11, fork: true),
        _pr(12, autor: 'jemand'),
        _pr(13, autor: 'app/dependabot'),
      ]);
      expect(e['aktion'], 'nichts');
      expect(e['uebersprungen'], hasLength(3));
    });

    test('ohne jede Prüfung: erst warten, nach 30 Minuten übersprungen', () {
      expect(_entscheiden(prs: <Map<String, dynamic>>[_pr(11, pruefung: 'keine', alter: 5), _pr(12)])['aktion'],
          'warten');
      final Map<String, dynamic> e =
          _entscheiden(prs: <Map<String, dynamic>>[_pr(11, pruefung: 'keine', alter: 45), _pr(12)]);
      expect(e['aktion'], 'mergen');
      expect(e['pr'], 12);
    });

    test('nichts offen: nichts', () {
      expect(_entscheiden()['aktion'], 'nichts');
    });
  });

  // vorsitzer #1307 am 17.10.2026: `gh pr ready` eine Minute nach dem Push
  // brach den Lauf zum Push ab (cancel-in-progress) und startete einen neuen
  // auf denselben Stand. Gezählt hat der abgebrochene: „Prüfungen rot“.
  group('derselbe Stand zweimal geprüft — es zählt je Prüfung der neueste Lauf', () {
    Map<String, String> lauf(String status, String conclusion, String start,
            {String ablauf = 'PR Checks', String name = '🔍 Analyse & Tests'}) =>
        <String, String>{
          '__typename': 'CheckRun',
          'workflowName': ablauf,
          'name': name,
          'status': status,
          'conclusion': conclusion,
          'startedAt': start,
        };

    test('abgebrochen, dann grün: gemergt', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[
        _pr(11, checks: <Map<String, String>>[
          lauf('COMPLETED', 'CANCELLED', _vor(10)),
          lauf('COMPLETED', 'SUCCESS', _vor(8)),
          lauf('COMPLETED', 'SUCCESS', _vor(10), ablauf: 'Security Scans', name: 'osv-scan'),
        ]),
      ]);
      expect(e['aktion'], 'mergen');
      expect(e['pr'], 11);
    });

    test('abgebrochen, der neue läuft noch: warten — kein jüngerer zieht vorbei', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[
        _pr(11, checks: <Map<String, String>>[
          lauf('COMPLETED', 'CANCELLED', _vor(10)),
          lauf('IN_PROGRESS', '', _vor(2)),
        ]),
        _pr(12),
      ]);
      expect(e['aktion'], 'warten');
      expect(e['grund'], contains('#11'));
    });

    test('neu angestellt, noch ohne Startzeit (0001-01-01): zählt als der neueste', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[
        _pr(11, checks: <Map<String, String>>[
          lauf('COMPLETED', 'FAILURE', _vor(10)),
          lauf('QUEUED', '', '0001-01-01T00:00:00Z'),
        ]),
        _pr(12),
      ]);
      expect(e['aktion'], 'warten');
      expect(e['grund'], contains('#11'));
    });

    test('der neueste ist abgebrochen oder rot: rot, auch wenn ein älterer grün war', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[
        _pr(11, checks: <Map<String, String>>[
          lauf('COMPLETED', 'SUCCESS', _vor(10)),
          lauf('COMPLETED', 'CANCELLED', _vor(8)),
        ]),
        _pr(12, checks: <Map<String, String>>[
          lauf('COMPLETED', 'SUCCESS', _vor(10)),
          lauf('COMPLETED', 'FAILURE', _vor(8)),
        ]),
        _pr(13),
      ]);
      expect(e['aktion'], 'mergen');
      expect(e['pr'], 13);
      expect(e['uebersprungen'], <String>['#11: Prüfungen rot', '#12: Prüfungen rot']);
    });

    test('eine grüne Prüfung macht eine andere, abgebrochene nicht wett', () {
      final Map<String, dynamic> e = _entscheiden(prs: <Map<String, dynamic>>[
        _pr(11, checks: <Map<String, String>>[
          lauf('COMPLETED', 'CANCELLED', _vor(10)),
          lauf('COMPLETED', 'SUCCESS', _vor(8), name: '🔍 Analyse & Tests (Linux)'),
          lauf('COMPLETED', 'SUCCESS', _vor(8), ablauf: 'Security Scans'),
        ]),
      ]);
      expect(e['aktion'], 'nichts');
      expect(e['uebersprungen'], <String>['#11: Prüfungen rot']);
    });
  });

  group('erst, wenn die Fassung davor draußen ist', () {
    test('läuft ein Bau, wartet die Schlange', () {
      final Map<String, dynamic> e = _entscheiden(
        prs: <Map<String, dynamic>>[_pr(11)],
        laeufe: <Map<String, dynamic>>[_lauf(_k['bau'] as String, status: 'in_progress')],
      );
      expect(e['aktion'], 'warten');
    });

    test('auch, solange er nur angestellt ist, und solange der Release läuft', () {
      for (final Map<String, dynamic> l in <Map<String, dynamic>>[
        _lauf(_k['bau'] as String, status: 'queued'),
        _lauf(_k['freigabe'] as String, status: 'in_progress', event: 'push', zweig: 'main'),
      ]) {
        expect(_entscheiden(prs: <Map<String, dynamic>>[_pr(11)], laeufe: <Map<String, dynamic>>[l])['aktion'],
            'warten',
            reason: '${l['datei']} ${l['status']}');
      }
    });

    test('PR-Prüfungen halten sie nicht auf', () {
      final Map<String, dynamic> e = _entscheiden(
        prs: <Map<String, dynamic>>[_pr(11)],
        laeufe: <Map<String, dynamic>>[_lauf(_k['bau'] as String, status: 'in_progress', event: 'pull_request')],
      );
      expect(e['aktion'], 'mergen');
    });

    test('eben gemergt: warten, bis sich die Läufe zeigen', () {
      final List<Map<String, dynamic>> prs = <Map<String, dynamic>>[_pr(11)];
      expect(
          _entscheiden(prs: prs, merges: <Map<String, dynamic>>[
            <String, dynamic>{'number': 10, 'mergedAt': _vor(1)},
          ])['aktion'],
          'warten');
      expect(
          _entscheiden(prs: prs, merges: <Map<String, dynamic>>[
            <String, dynamic>{'number': 10, 'mergedAt': _vor(5)},
          ])['aktion'],
          'mergen');
    });

    test('der Release-Ablauf eben fertig: warten, bis sich sein Bau zeigt', () {
      expect(
          _entscheiden(
            prs: <Map<String, dynamic>>[_pr(11)],
            laeufe: <Map<String, dynamic>>[_lauf(_k['freigabe'] as String, event: 'push', zweig: 'main', alter: 1)],
          )['aktion'],
          'warten');
    });

    test('der Release-PR von release-please ist offen: warten', () {
      expect(
          _entscheiden(prs: <Map<String, dynamic>>[_pr(11), _pr(12, zweig: 'release-please--branches--main')])['aktion'],
          'warten');
    });
  });

  group('die Schleife', () {
    test('nach dem Merge wartet sie selbst auf die Fassung und nimmt dann den nächsten', () {
      final Map<String, dynamic> bau = _lauf(_k['bau'] as String, status: 'in_progress', zweig: 'v1.0.1');
      final Map<String, dynamic> f = _folge(<Map<String, dynamic>>[
        <String, dynamic>{'prs': <Map<String, dynamic>>[_pr(11), _pr(12)]},
        <String, dynamic>{'prs': <Map<String, dynamic>>[_pr(12)], 'laeufe': <Map<String, dynamic>>[bau]},
        <String, dynamic>{'prs': <Map<String, dynamic>>[_pr(12)], 'laeufe': <Map<String, dynamic>>[bau]},
        <String, dynamic>{'prs': <Map<String, dynamic>>[_pr(12)]},
        <String, dynamic>{'prs': <Map<String, dynamic>>[]},
      ]);
      expect(f['aktionen'], <String>['mergen', 'warten', 'mergen', 'nichts']);
      expect(f['gemergt'], <int>[11, 12]);
      expect(f['geschlafen'], 2, reason: 'zweimal nachgesehen, solange der Bau lief');
    });

    test('sie wartet höchstens 40 Minuten, dann endet der Lauf', () {
      final Map<String, dynamic> f = _folge(<Map<String, dynamic>>[
        <String, dynamic>{
          'prs': <Map<String, dynamic>>[_pr(11)],
          'laeufe': <Map<String, dynamic>>[_lauf(_k['bau'] as String, status: 'in_progress')],
        },
      ]);
      expect(f['aktionen'], <String>['warten']);
      expect(f['geschlafen'], 40);
      expect(f['gemergt'], isEmpty);
    });

    test('Halt: der Lauf endet sofort', () {
      final Map<String, dynamic> f = _folge(<Map<String, dynamic>>[
        <String, dynamic>{
          'prs': <Map<String, dynamic>>[_pr(11)],
          'laeufe': <Map<String, dynamic>>[_lauf(_k['bau'] as String, conclusion: 'failure', zweig: 'v1.0.1')],
        },
      ]);
      expect(f['aktionen'], <String>['halt']);
      expect(f['geschlafen'], 0);
    });

    test('trocken: nur der erste Blick, nichts gemergt', () {
      final Map<String, dynamic> f = _folge(<Map<String, dynamic>>[
        <String, dynamic>{'prs': <Map<String, dynamic>>[_pr(11)]},
      ], trocken: true);
      expect(f['aktionen'], <String>['mergen']);
      expect(f['gemergt'], isEmpty);
    });
  });

  group('Halt nach einer gescheiterten Fassung', () {
    test('kam die letzte Fassung nicht ins Release, kommt nichts darauf', () {
      final Map<String, dynamic> e = _entscheiden(
        prs: <Map<String, dynamic>>[_pr(11)],
        laeufe: <Map<String, dynamic>>[_lauf(_k['bau'] as String, conclusion: 'failure', zweig: 'v1.0.1')],
      );
      expect(e['aktion'], 'halt');
    });

    test('nach einer gelungenen geht es weiter', () {
      final Map<String, dynamic> e = _entscheiden(
        prs: <Map<String, dynamic>>[_pr(11)],
        laeufe: <Map<String, dynamic>>[
          _lauf(_k['bau'] as String, conclusion: 'failure', zweig: 'v1.0.1', alter: 90),
          _lauf(_k['bau'] as String, zweig: 'v1.0.2', alter: 30),
        ],
      );
      expect(e['aktion'], 'mergen');
    });

    test('scheitert nur ein Nebenschritt, ist die Fassung trotzdem draußen', () {
      final Map<String, dynamic> e = _entscheiden(
        prs: <Map<String, dynamic>>[_pr(11)],
        laeufe: <Map<String, dynamic>>[
          _lauf(_k['bau'] as String, conclusion: 'failure', zweig: 'v1.0.1', schritte: <Map<String, String>>[
            <String, String>{'name': _k['veroeffentlicht'] as String, 'conclusion': 'success'},
            <String, String>{'name': 'Nebenschritt', 'conclusion': 'failure'},
          ]),
        ],
      );
      expect(e['aktion'], 'mergen');
    });

    test('abgebrochene Läufe und Bauten von Zweigen zählen nicht', () {
      final Map<String, dynamic> e = _entscheiden(
        prs: <Map<String, dynamic>>[_pr(11)],
        laeufe: <Map<String, dynamic>>[
          _lauf(_k['bau'] as String, conclusion: 'cancelled', zweig: 'v1.0.3', alter: 20),
          _lauf(_k['bau'] as String, conclusion: 'failure', zweig: 'feat/probe', alter: 10),
          _lauf(_k['bau'] as String, zweig: 'v1.0.2', alter: 40),
        ],
      );
      expect(e['aktion'], 'mergen');
    });

    test('auch ein gescheiterter Release-Ablauf hält sie an', () {
      expect(
          _entscheiden(
            prs: <Map<String, dynamic>>[_pr(11)],
            laeufe: <Map<String, dynamic>>[
              _lauf(_k['freigabe'] as String, conclusion: 'failure', event: 'push', zweig: 'main'),
            ],
          )['aktion'],
          'halt');
    });
  });

  group('der Ablauf', () {
    final Map<String, String> ablaeufe = _ablaeufe();
    final String text = _lesen(_ablauf);

    test('mergt wie der Knopf der App', () {
      expect(_k['art'], _mergeArt);
      expect(_k['autoren'], <String>['icd360sevofficial']);
    });

    test('startet nach dem Merge genau das, was ein Push auf main startet', () {
      final Map<String, List<String>> push = <String, List<String>>{
        for (final MapEntry<String, String> a in ablaeufe.entries)
          if (_pushAufMain(a.value) != null) a.key: _pushAufMain(a.value)!,
      };
      final Map<String, List<String>> nach = <String, List<String>>{
        for (final String e in (_k['nach'] as List<dynamic>).cast<String>())
          e.split('@').first: e.contains('@')
              ? e.split('@').last.split(',').where((String s) => s.isNotEmpty).toList()
              : <String>[],
      };
      expect(nach.keys.toSet(), push.keys.toSet());
      for (final String datei in push.keys) {
        expect(nach[datei], push[datei], reason: '$datei: dieselben `paths:` wie am Push');
      }
    });

    test('… und mit `paths:` nur, wenn der PR einen davon berührt', () {
      final List<String> alle = (_k['nach'] as List<dynamic>).cast<String>().map((String e) => e.split('@').first).toList();
      final List<String> ohneFilter = (_k['nach'] as List<dynamic>)
          .cast<String>()
          .where((String e) => !e.contains('@'))
          .toList();
      expect(_folgelaeufe(<String>['lib/main.dart']), ohneFilter);
      for (final String e in (_k['nach'] as List<dynamic>).cast<String>().where((String e) => e.contains('@'))) {
        for (final String pfad in e.split('@').last.split(',').where((String s) => s.isNotEmpty)) {
          // `ordner/**`: eine Datei darunter.
          final String datei = pfad.endsWith('/**') ? pfad.replaceFirst('**', 'x.arb') : pfad;
          expect(_folgelaeufe(<String>[datei]), alle, reason: datei);
        }
      }
    });

    test('die Auslöser gibt es — mit genau diesem Namen, ohne Musterzeichen', () {
      final RegExpMatch? m = RegExp(r'workflows: \[(.*)\]').firstMatch(text);
      expect(m, isNotNull);
      final Set<String?> namen = ablaeufe.values.map(_name).toSet();
      for (final String w in m!.group(1)!.split(',').map((String s) => s.trim().replaceAll('"', ''))) {
        expect(namen, contains(w), reason: 'workflow_run auf „$w“ — einen Ablauf dieses Namens gibt es nicht');
        // GitHub liest die Namen als Muster: „Build Linux + Flatpak (priority)“
        // traf am 17.10.2026 nie, das „+“ hiess „ein oder mehr Leerzeichen“.
        expect(w, isNot(matches(RegExp(r'[+*?!\[\]]'))), reason: '„$w“ enthält ein Musterzeichen');
      }
    });

    // Wird ein Entwurf fertig gemeldet oder kommt `asteapta` weg, ändert sich am
    // Code nichts — ohne `types:` lief dann keine Prüfung neu, und ohne fertige
    // Prüfung kein workflow_run: die Schlange schlief weiter (17.10.2026, #1304
    // wäre nach dem Einspielen seines Servers liegen geblieben).
    test('ein Entwurf wird fertig oder `asteapta` kommt weg: die PR-Prüfung läuft neu und weckt sie', () {
      final Set<String> namen = RegExp(r'workflows: \[(.*)\]')
          .firstMatch(text)!
          .group(1)!
          .split(',')
          .map((String s) => s.trim().replaceAll('"', ''))
          .toSet();
      final List<String> pruefungen = <String>[
        for (final MapEntry<String, String> a in ablaeufe.entries)
          if (namen.contains(_name(a.value)) && _prArten(a.value).isNotEmpty) a.key,
      ];
      expect(pruefungen, isNotEmpty, reason: 'kein Auslöser der Schlange läuft auf einem PR');
      for (final String datei in pruefungen) {
        expect(
          _prArten(ablaeufe[datei]!),
          containsAll(<String>['opened', 'synchronize', 'reopened', 'ready_for_review', 'unlabeled']),
          reason: datei,
        );
      }
    });

    test('kein Zeitplan — sie kommt, wenn etwas fertig ist, und wartet dann selbst', () {
      expect(text, isNot(contains('schedule:')));
      expect(text, isNot(contains('cron:')));
      final int warten =
          int.parse(RegExp(r'WARTEN_HOECHSTENS = timedelta\(minutes=(\d+)\)').firstMatch(_lesen(_skript))!.group(1)!);
      final int frist = int.parse(RegExp(r'timeout-minutes: (\d+)').firstMatch(text)!.group(1)!);
      expect(frist, greaterThan(warten), reason: 'der Lauf muss sein Warten zu Ende bringen dürfen');
    });

    // Startet der Release den Bau mit dem GITHUB_TOKEN (vorsitzer,
    // schatzmeister: `gh workflow run build-android.yml`), löst dessen Ende
    // KEIN workflow_run aus — der Bau muss die Schlange selbst anstoßen.
    // In mitglieder kommt der Tag von release-please mit eigenem Token; dort
    // greift workflow_run, und der Test hat nichts zu prüfen.
    test('startet der Release den Bau mit dem GITHUB_TOKEN, stößt der Bau sie an', () {
      if (!ablaeufe[_k['freigabe']]!.contains('gh workflow run ${_k['bau']}')) return;
      final String bau = ablaeufe[_k['bau']]!;
      final int anstoss = bau.indexOf('run: gh workflow run merge-warteschlange.yml --ref main\n');
      expect(anstoss, greaterThan(0));
      // Im Veröffentlichungs-Job, als letzter Schritt — nach dem Hochladen.
      expect(anstoss, greaterThan(bau.indexOf('name: "${_k['veroeffentlicht']}"')));
      expect(bau.indexOf('\n      - name:', anstoss), -1, reason: 'danach kommt kein Schritt mehr');
    });

    test('Release, Bau und Veröffentlichungsschritt gibt es', () {
      for (final String datei in <String>[
        ...(_k['warten'] as List<dynamic>).cast<String>(),
        _k['freigabe'] as String,
        _k['bau'] as String,
      ]) {
        expect(ablaeufe.keys, contains(datei));
      }
      final String schritt = _k['veroeffentlicht'] as String;
      expect(
        RegExp('^ +name: ["\']?${RegExp.escape(schritt)}["\']? *\$', multiLine: true).hasMatch(ablaeufe[_k['bau']]!),
        isTrue,
        reason: 'den Schritt „$schritt“ gibt es in ${_k['bau']} nicht',
      );
    });

    test('nie zwei auf einmal, und nie den Code eines PR', () {
      expect(text, contains('group: merge-warteschlange'));
      expect(text, contains('cancel-in-progress: false'));
      expect(text, contains('sparse-checkout: .github/scripts'));
      for (final String verboten in <String>['head_sha', 'head_branch', 'pull_request_target', 'ref:']) {
        expect(text, isNot(contains(verboten)), reason: verboten);
      }
    });
  });
}
