import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/utils/sicher_clipboard.dart';
import 'package:icd360sev_mitglied/utils/sicher_clipboard_bindung.dart';
import 'package:icd360sev_mitglied/widgets/zwischenablage_melder.dart';

/// Jede Kopie der App ist nach 30 s gelöscht, auf Android sensibel markiert,
/// und die App sagt es (Festlegung des Vorsitzenden, 02.10.2026, Idee 4 —
/// wie in der Vorsitzer-App #1045/#1049).
///
/// Der native Teil (Zwischenablage.kt) lässt sich hier nicht erleben. Geprüft
/// werden der Bote als Funktion, der Dart-Rückfall und der Melder als Widget,
/// die Übersetzungen, und die Kopplungen am Quelltext — die brechen lautlos.

/// Die Plattform im Test: schreibt auf, was ankommt, und antwortet.
class _Plattform extends BinaryMessenger {
  final gesendet = <(String, ByteData?)>[];

  @override
  Future<void> handlePlatformMessage(
    String channel,
    ByteData? data,
    ui.PlatformMessageResponseCallback? callback,
  ) async {}

  @override
  Future<ByteData?>? send(String channel, ByteData? message) {
    gesendet.add((channel, message));
    return Future.value(
        const JSONMethodCodec().encodeSuccessEnvelope('von der Plattform'));
  }

  @override
  void setMessageHandler(String channel, MessageHandler? handler) {}
}

ByteData _setData(String? text) => const JSONMethodCodec()
    .encodeMethodCall(MethodCall('Clipboard.setData', {'text': text}));

String ohneKommentare(String s) {
  s = s.replaceAllMapped(
    RegExp(r'/\*.*?\*/', dotAll: true),
    (m) => '\n' * '\n'.allMatches(m[0]!).length,
  );
  return s.replaceAllMapped(RegExp(r'//[^\n]*'), (m) => ' ' * m[0]!.length);
}

String quelle(String pfad) => ohneKommentare(File(pfad).readAsStringSync());

const _kt = 'android/app/src/main/kotlin/de/icd360s/mitglieder';

/// Der Rumpf ab [kopf] bis zur passenden schließenden Klammer.
String rumpf(String q, String kopf) {
  final i = q.indexOf(kopf);
  expect(i, greaterThanOrEqualTo(0), reason: '„$kopf" fehlt');
  final auf = q.indexOf('{', i + kopf.length - 1);
  var tiefe = 0;
  for (var j = auf; j < q.length; j++) {
    if (q[j] == '{') tiefe++;
    if (q[j] == '}' && --tiefe == 0) return q.substring(auf + 1, j);
  }
  fail('„$kopf" endet nicht');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('kopierterText', () {
    test('liest den Text aus Clipboard.setData', () {
      expect(kopierterText(_setData('DE12 3456')), 'DE12 3456');
      expect(kopierterText(_setData('')), '');
    });

    test('alles andere ist null', () {
      expect(kopierterText(null), isNull);
      expect(kopierterText(_setData(null)), isNull);
      expect(
          kopierterText(const JSONMethodCodec().encodeMethodCall(
              const MethodCall('Clipboard.getData', 'text/plain'))),
          isNull);
      expect(kopierterText(ByteData.sublistView(Uint8List.fromList([1, 2, 3]))),
          isNull);
    });
  });

  group('SicherClipboardBote', () {
    late _Plattform plattform;
    late List<String> kopiert;
    late int ohneKanal;

    setUp(() {
      plattform = _Plattform();
      kopiert = [];
      ohneKanal = 0;
    });

    SicherClipboardBote bote({required bool nativ}) => SicherClipboardBote(
          plattform,
          kopieren: (t) async {
            kopiert.add(t);
            return nativ;
          },
          ohneKanal: () => ohneKanal++,
        );

    MethodChannel plattformKanal(SicherClipboardBote b) =>
        MethodChannel('flutter/platform', const JSONMethodCodec(), b);

    test('Android: Clipboard.setData geht an den nativen Weg, nicht an die '
        'Plattform', () async {
      final antwort = await plattformKanal(bote(nativ: true))
          .invokeMethod<Object?>('Clipboard.setData', {'text': 'IBAN DE12'});
      expect(kopiert, ['IBAN DE12']);
      expect(plattform.gesendet, isEmpty);
      expect(ohneKanal, 0);
      expect(antwort, isNull, reason: 'wie Flutter selbst: Erfolg ohne Wert');
    });

    test('🔴 ohne Kanal (Windows, Linux, macOS, iOS): dieselbe Nachricht an '
        'die Plattform — und der Dart-Timer läuft', () async {
      final antwort = await plattformKanal(bote(nativ: false))
          .invokeMethod<Object?>('Clipboard.setData', {'text': 'x'});
      expect(plattform.gesendet, hasLength(1));
      expect(plattform.gesendet.single.$1, 'flutter/platform');
      expect(kopierterText(plattform.gesendet.single.$2), 'x');
      expect(antwort, 'von der Plattform');
      expect(ohneKanal, 1);
    });

    test('leerer Text IST das Leeren — kein neuer Timer', () async {
      await plattformKanal(bote(nativ: false))
          .invokeMethod<Object?>('Clipboard.setData', {'text': ''});
      expect(plattform.gesendet, hasLength(1));
      expect(ohneKanal, 0);
    });

    test('alles andere geht unverändert durch', () async {
      final b = bote(nativ: true);
      await plattformKanal(b).invokeMethod<Object?>('Clipboard.getData');
      final fremd = _setData('nicht abfangen');
      await b.send('de.icd360sev.mitglied/irgendwas', fremd);
      expect(kopiert, isEmpty);
      expect(plattform.gesendet.map((e) => e.$1),
          ['flutter/platform', 'de.icd360sev.mitglied/irgendwas']);
      expect(identical(plattform.gesendet.last.$2, fremd), isTrue);
    });

    test('🔴 der native Weg startet im selben Takt — die Reihenfolge bleibt',
        () {
      final b = SicherClipboardBote(plattform, kopieren: (t) {
        kopiert.add(t);
        return Completer<bool>().future;
      });
      b.send('flutter/platform', _setData('a'));
      expect(kopiert, ['a']);
    });
  });

  testWidgets(
      '🔴 „Kopieren" im Kontextmenü eines Textfelds kommt als Clipboard.setData '
      'auf flutter/platform an — genau das fängt der Bote ab', (t) async {
    final roh = <ByteData?>[];
    t.binding.defaultBinaryMessenger.setMockMessageHandler('flutter/platform',
        (m) async {
      if (kopierterText(m) != null) roh.add(m);
      return const JSONMethodCodec().encodeSuccessEnvelope(null);
    });
    addTearDown(() => t.binding.defaultBinaryMessenger
        .setMockMessageHandler('flutter/platform', null));
    final c = TextEditingController(text: 'Kennwort 123');
    addTearDown(c.dispose);
    await t.pumpWidget(
        MaterialApp(home: Scaffold(body: TextField(controller: c))));
    c.selection = const TextSelection(baseOffset: 0, extentOffset: 12);
    t.state<EditableTextState>(find.byType(EditableText))
        .copySelection(SelectionChangedCause.toolbar);
    await t.pump();
    expect(roh.map(kopierterText), ['Kennwort 123']);
  });

  test('SicherClipboardBindung lässt ein stehendes Binding stehen', () {
    expect(SicherClipboardBindung.ensureInitialized(),
        same(TestWidgetsFlutterBinding.instance));
  });

  group('ZwischenablageMelder', () {
    Future<void> zeige(WidgetTester t, {Locale locale = const Locale('de')}) =>
        t.pumpWidget(MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => ZwischenablageMelder(child: child!),
          home: const Scaffold(body: SizedBox()),
        ));

    Future<void> android(WidgetTester t, DateTime zeit,
            {required bool spaet}) =>
        t.binding.defaultBinaryMessenger.handlePlatformMessage(
          SicherClipboard.kanal.name,
          const StandardMethodCodec().encodeMethodCall(MethodCall('geloescht',
              {'zeit': zeit.millisecondsSinceEpoch, 'spaet': spaet})),
          (_) {},
        );

    testWidgets('Android meldet „gelöscht" → SnackBar, übersetzt', (t) async {
      await zeige(t);
      await android(t, DateTime(2026, 10, 2, 14, 32, 5), spaet: false);
      await t.pump();
      await t.pump(const Duration(milliseconds: 300));
      expect(find.text('Zwischenablage gelöscht'), findsOneWidget);
      expect(find.byIcon(Icons.content_paste_off), findsOneWidget);
      await t.pump(const Duration(seconds: 4));
      await t.pumpAndSettle();
      expect(find.text('Zwischenablage gelöscht'), findsNothing,
          reason: 'nach 3 s wieder weg');
    });

    testWidgets('in der Sprache des Mitglieds', (t) async {
      await zeige(t, locale: const Locale('ro'));
      await android(t, DateTime(2026, 10, 2, 14, 32, 5), spaet: false);
      await t.pump();
      await t.pump(const Duration(milliseconds: 300));
      expect(find.text('Clipboardul a fost golit'), findsOneWidget);
    });

    testWidgets('gelöscht, während die App im Hintergrund war → mit Uhrzeit',
        (t) async {
      await zeige(t);
      await android(t, DateTime(2026, 10, 2, 14, 32, 5), spaet: true);
      await t.pump();
      await t.pump(const Duration(milliseconds: 300));
      expect(find.text('Zwischenablage um 14:32 gelöscht'), findsOneWidget);
    });

    testWidgets('ohne Melder nimmt niemand die Meldung an', (t) async {
      await zeige(t);
      await t.pumpWidget(const SizedBox());
      ByteData? antwort = ByteData(1);
      await t.binding.defaultBinaryMessenger.handlePlatformMessage(
        SicherClipboard.kanal.name,
        const StandardMethodCodec().encodeMethodCall(
            const MethodCall('geloescht', {'zeit': 0, 'spaet': false})),
        (a) => antwort = a,
      );
      expect(antwort, isNull, reason: 'kein Handler mehr am Kanal');
    });

    testWidgets(
        '🔴 Rückfall ohne Kanal: nach 30 s geleert, und die App sagt es',
        (t) async {
      final gesetzt = <String?>[];
      t.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'Clipboard.setData') {
          gesetzt.add((call.arguments as Map)['text'] as String?);
        }
        return null;
      });
      addTearDown(() => t.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null));
      await zeige(t);
      SicherClipboard.ohneKanalGelegt();
      await t.pump(const Duration(seconds: 29));
      expect(gesetzt, isEmpty, reason: 'vor Ablauf noch da');
      await t.pump(const Duration(seconds: 2));
      await t.pump(const Duration(milliseconds: 300));
      expect(gesetzt, ['']);
      expect(find.text('Zwischenablage gelöscht'), findsOneWidget);
      await t.pump(const Duration(seconds: 4));
      await t.pumpAndSettle();
    });
  });

  test('leeren() ohne Kopie der App fasst die Zwischenablage nicht an',
      () async {
    final gesetzt = <String?>[];
    final bote =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    bote.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        gesetzt.add((call.arguments as Map)['text'] as String?);
      }
      return null;
    });
    addTearDown(
        () => bote.setMockMethodCallHandler(SystemChannels.platform, null));
    var gemeldet = 0;
    void melder(DateTime zeit, {required bool spaet}) => gemeldet++;
    SicherClipboard.melderSetzen(melder);
    addTearDown(() => SicherClipboard.melderLoesen(melder));
    await SicherClipboard.leeren();
    expect(gesetzt, isEmpty, reason: 'eine Kopie einer anderen App bleibt');
    expect(gemeldet, 0);
  });

  test('🔴 jede Sprache hat beide Texte, mit {zeit}', () {
    final dateien = Directory('lib/l10n')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.arb'))
        .toList();
    expect(dateien, hasLength(28));
    final de = jsonDecode(File('lib/l10n/app_de.arb').readAsStringSync()) as Map;
    for (final f in dateien) {
      final j = jsonDecode(f.readAsStringSync()) as Map;
      final kurz = j['zwischenablageGeloescht'];
      final um = j['zwischenablageGeloeschtUm'];
      expect(kurz, isA<String>(), reason: f.path);
      expect(um, isA<String>(), reason: f.path);
      expect(um as String, contains('{zeit}'), reason: f.path);
      if (!f.path.endsWith('app_de.arb')) {
        expect(kurz, isNot(de['zwischenablageGeloescht']),
            reason: '${f.path} ist nicht übersetzt');
      }
    }
  });

  group('Kopplungen am Quelltext', () {
    test('🔴 main legt ALS ERSTES SicherClipboardBindung an', () {
      final q = quelle('lib/main.dart');
      expect(rumpf(q, 'void main() async {').trimLeft(),
          startsWith('SicherClipboardBindung.ensureInitialized();'));
      expect(q, isNot(contains('WidgetsFlutterBinding.ensureInitialized()')));
    });

    test('🔴 der Melder sitzt in MaterialApp.builder', () {
      expect(
          RegExp(r'builder: \(context, child\) => ZwischenablageMelder\(')
              .hasMatch(quelle('lib/main.dart')),
          isTrue);
    });

    test('🔴 MainActivity bindet die Zwischenablage an ihre Engine', () {
      final konfig = rumpf(quelle('$_kt/MainActivity.kt'),
          'override fun configureFlutterEngine(flutterEngine: FlutterEngine) {');
      expect(konfig, contains('Zwischenablage.anbinden(this, flutterEngine)'));
    });

    test('🔴 kein Kotlin außer Zwischenablage.kt legt etwas in die Ablage', () {
      for (final f in Directory('android/app/src/main/kotlin')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.kt'))) {
        if (f.path.endsWith('/Zwischenablage.kt')) continue;
        expect(ohneKommentare(f.readAsStringSync()),
            isNot(contains('setPrimaryClip')),
            reason: f.path);
      }
    });

    test('Zwischenablage.kt: 30 s, sensibel, überschreiben VOR dem Leeren', () {
      final q = quelle('$_kt/Zwischenablage.kt');
      expect(q, contains('const val KANAL = "${SicherClipboard.kanal.name}"'));
      final frist = RegExp(r'const val FRIST_MS = ([\d_]+)L').firstMatch(q);
      expect(frist, isNotNull);
      expect(
          Duration(milliseconds: int.parse(frist![1]!.replaceAll('_', ''))),
          SicherClipboard.frist);
      expect(SicherClipboard.frist, const Duration(seconds: 30));
      expect(q, contains('ClipDescription.EXTRA_IS_SENSITIVE'));
      expect(q, contains('"android.content.extra.IS_SENSITIVE"'));
      expect(q, contains('addPrimaryClipChangedListener'));
      final leeren = rumpf(q, 'fun leeren() {');
      final ueber =
          leeren.indexOf('setPrimaryClip(ClipData.newPlainText("", "")');
      final weg = leeren.indexOf('clearPrimaryClip()');
      expect(ueber, greaterThanOrEqualTo(0));
      expect(weg, greaterThan(ueber));
      expect(leeren, contains('melden('));
    });

    test('🔴 minSdk 24: clearPrimaryClip erst ab Android 9, Rückrufe über die '
        'Application', () {
      final q = quelle('$_kt/Zwischenablage.kt');
      expect(
          q,
          contains('if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) '
              'cm.clearPrimaryClip()'));
      expect(q, contains('anwendung.registerActivityLifecycleCallbacks('));
      expect(q, isNot(contains('a.registerActivityLifecycleCallbacks(')),
          reason: 'je Activity gibt es das erst ab Android 10');
    });

    test('🔴 ein Clip ohne Markierung wird nachmarkiert UND geplant', () {
      final q = quelle('$_kt/Zwischenablage.kt');
      final horcher =
          rumpf(q, 'val b = ClipboardManager.OnPrimaryClipChangedListener {');
      final eigen = horcher.indexOf('getBoolean(EIGEN)');
      final nach = horcher.indexOf('nachmarkieren(cm)');
      final plan = horcher.indexOf('planen(FRIST_MS)');
      expect(eigen, greaterThanOrEqualTo(0));
      expect(nach, greaterThan(eigen),
          reason: 'erst die eigenen auslassen — sonst endlos');
      expect(plan, greaterThan(nach));
      final nachm = rumpf(q, 'private fun nachmarkieren(cm: ClipboardManager) {');
      expect(nachm, contains('it.uri != null'));
      expect(nachm, contains('it.intent != null'));
      expect(nachm, contains('it.extras = sensibel()'));
      expect(nachm, contains('htmlText'));
    });
  });
}
