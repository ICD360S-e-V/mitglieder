// Sucht dunkle Farbliterale, die als SCHRIFT benutzt werden.
//
// Anlass ist ein echter Fehler: im Live-Chat stand der Text empfangener
// Nachrichten fest auf #1a1a2e, während die Blase darunter auf die
// Theme-Fläche umgestellt wurde. Im hellen Modus fiel das nicht auf — dunkel
// auf weiß. Im dunklen stand es bei 1,1:1, also gar nicht mehr da.
//
// Der Kontrast-Test daneben misst am gerenderten Baum und ist genauer, aber er
// sieht nur, was in seiner Bausteinliste steht; der Live-Chat-Dialog steht
// dort nicht, weil seine Blase privat ist und der Dialog einen ApiService
// braucht. Dieser Test liest stattdessen den Quelltext und deckt damit auch
// die Ecken ab, die sich schlecht rendern lassen.
//
// Er ist absichtlich eng: nur Argumente, die eine Vordergrundfarbe benennen,
// und nur Literale, die dunkel genug sind, um auf einer dunklen Fläche zu
// verschwinden. Flächenfarben und die Bildschirme, die in beiden Themes
// dunkel sind, stehen unten in der Ausnahmeliste — mit Begründung.

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';

/// Dateien, die in BEIDEN Themes dunkel sind. Dort ist ein dunkles Literal
/// als Schrift kein Widerspruch, sondern die Absicht.
const _immerDunkel = <String>{
  'native_call_screen.dart',
  'video_call_screen.dart',
  'debug_console.dart',
  'changelog_dialog.dart',
  'network_security_banner.dart', // satte Warnflächen mit weißer Schrift
  'mitglied_sidebar.dart',
  'chat_header.dart',
};

/// Dateien, die dekorative Paletten führen (Ostern, Emotionen) — die Farben
/// dort sind Grafik, nicht Schrift auf einer Fläche.
const _dekorativ = <String>{
  'eastern.dart',
  'message_emotion.dart',
  'mitglied_banners.dart',
};

/// Argumentnamen, die eine Vordergrundfarbe setzen.
const _vordergrund = <String>{
  'color',
  'linkColor',
  'iconColor',
  'foregroundColor',
  'textColor',
  'decorationColor',
};

/// Konstruktoren, bei denen `color:` die FLÄCHE meint, nicht die Schrift.
const _flaechen = <String>{
  'BoxDecoration',
  'ShapeDecoration',
  'Container',
  'Card',
  'Material',
  'Scaffold',
  'AppBar',
  'ColoredBox',
  'DecoratedBox',
};

double _luminanz(int rgb) {
  double kanal(int v) {
    final c = v / 255.0;
    return c <= 0.03928 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
  }

  return 0.2126 * kanal((rgb >> 16) & 0xFF) +
      0.7152 * kanal((rgb >> 8) & 0xFF) +
      0.0722 * kanal(rgb & 0xFF);
}

/// Name des Konstruktors, dessen Klammern [pos] umschließen.
String _konstruktorUm(String quelle, int pos) {
  var tiefe = 0;
  for (var i = pos - 1; i >= 0 && pos - i < 4000; i--) {
    final c = quelle[i];
    if (c == ')' || c == ']' || c == '}') {
      tiefe++;
    } else if (c == '(' || c == '[' || c == '{') {
      if (tiefe == 0) {
        var j = i - 1;
        while (j >= 0 && ' \n\t\r'.contains(quelle[j])) {
          j--;
        }
        final ende = j + 1;
        while (j >= 0 && RegExp(r'[A-Za-z0-9_]').hasMatch(quelle[j])) {
          j--;
        }
        final name = quelle.substring(j + 1, ende);
        if (name.isNotEmpty &&
            !const {'const', 'return', 'if', 'else'}.contains(name)) {
          return name;
        }
        i = j + 1;
        continue;
      }
      tiefe--;
    }
  }
  return '?';
}

/// Name des Arguments, zu dem [pos] gehört.
///
/// Läuft auf gleicher Klammerebene zurück bis zum Anfang des Arguments — bis
/// zum Komma oder zur öffnenden Klammer. Das ist der Punkt, an dem die erste
/// Fassung dieses Tests danebenlag: sie suchte das Literal direkt hinter dem
/// Argumentnamen und ging damit an `color: isOwn ? Colors.white : <Literal>`
/// vorbei, also genau an der Stelle, die den Fehler ausgelöst hat.
String _argumentUm(String quelle, int pos) {
  var tiefe = 0;
  var i = pos - 1;
  for (; i >= 0; i--) {
    final c = quelle[i];
    if (c == ')' || c == ']' || c == '}') {
      tiefe++;
    } else if (c == '(' || c == '[' || c == '{') {
      if (tiefe == 0) break;
      tiefe--;
    } else if (c == ',' && tiefe == 0) {
      break;
    }
  }
  final abschnitt = quelle.substring(i + 1, pos);
  final m = RegExp(r'^\s*([A-Za-z_]\w*)\s*:').firstMatch(abschnitt);
  return m == null ? '?' : m.group(1)!;
}

void main() {
  test('kein dunkles Literal als Schriftfarbe', () {
    final wurzel = Directory('lib');
    expect(wurzel.existsSync(), isTrue,
        reason: 'Der Test muss aus dem Projektwurzelverzeichnis laufen.');

    final literal = RegExp(
        r'Color\(0x[fF]{2}([0-9A-Fa-f]{6})\)|Colors\.black(?![\w.\d])');

    final treffer = <String>[];
    for (final e in wurzel.listSync(recursive: true)) {
      if (e is! File || !e.path.endsWith('.dart')) continue;
      if (e.path.contains('${Platform.pathSeparator}l10n${Platform.pathSeparator}')) continue;
      final datei = e.uri.pathSegments.last;
      if (datei == 'app_theme.dart') continue;
      if (_immerDunkel.contains(datei) || _dekorativ.contains(datei)) continue;

      final quelle = e.readAsStringSync();
      for (final m in literal.allMatches(quelle)) {
        final rgb = m.group(1) == null ? 0 : int.parse(m.group(1)!, radix: 16);
        if (_luminanz(rgb) > 0.18) continue;
        // Halbdurchsichtiges legt sich über den Grund und folgt ihm damit.
        if (quelle.startsWith('.with', m.end)) continue;
        final argument = _argumentUm(quelle, m.start);
        if (!_vordergrund.contains(argument)) continue;
        if (_flaechen.contains(_konstruktorUm(quelle, m.start))) continue;
        final zeile = '\n'.allMatches(quelle.substring(0, m.start)).length + 1;
        treffer.add('${e.path}:$zeile  $argument: '
            '#${m.group(1) ?? "000000"}');
      }
    }

    expect(
      treffer,
      isEmpty,
      reason: 'Diese Farben bleiben dunkel, wenn das Theme umschaltet — die\n'
          'Fläche darunter aber nicht. Im dunklen Modus steht die Schrift dann\n'
          'dunkel auf dunkel. Nimm ein Token (context.colors.textPrimary,\n'
          'successFg …), oder trage die Datei oben ein, wenn sie in BEIDEN\n'
          'Themes dunkel ist.\n\n${treffer.join('\n')}',
    );
  });
}
