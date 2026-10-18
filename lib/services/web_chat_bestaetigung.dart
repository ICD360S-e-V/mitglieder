import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'logger_service.dart';

/// Die Frage des Vorstands „Schreiben Sie gerade im Chat auf icd360s.de?".
///
/// Jemand schreibt im Live-Chat der Website und sagt „Ich bin Mitglied". Der
/// Vorstand sieht, welche Mitglieder in Frage kommen, und lässt eines davon
/// fragen (Server: `member/web_chat_bestaetigen.php`, Push mit Tag
/// `web_chat`). Im Website-Chat steht dann eine Zahl; die App zeigt drei
/// Zahlen, und das Mitglied tippt dieselbe.
///
/// ⚠️ Der Zahlenabgleich ist der eigentliche Schutz, nicht die Frage: wer
/// gerade NICHT auf der Website schreibt, kennt die Zahl nicht. Ein
/// versehentliches „Ja" gibt es so nicht — und ohne Bestätigung sieht der
/// Besucher keine Antwort, die für das Mitglied bestimmt ist.
class WebChatAnfrage {
  const WebChatAnfrage({required this.id, required this.zahlen});

  final int id;

  /// Genau drei verschiedene Zahlen, eine davon steht im Website-Chat.
  final List<int> zahlen;

  /// Aus der Antwort auf `aktion: offen`. `null` heißt: keine Frage offen —
  /// oder eine Antwort, mit der sich nichts anfangen lässt. Dann lieber kein
  /// Dialog als einer mit falschen Zahlen.
  static WebChatAnfrage? ausAntwort(Object? json) {
    if (json is! Map) return null;
    final a = json['anfrage'];
    if (a is! Map) return null;
    final id = _ganz(a['id']);
    final roh = a['zahlen'];
    if (id == null || id <= 0 || roh is! List || roh.length != 3) return null;
    final zahlen = <int>[];
    for (final z in roh) {
      final n = _ganz(z);
      if (n == null || n < 0 || n > 999 || zahlen.contains(n)) return null;
      zahlen.add(n);
    }
    return WebChatAnfrage(id: id, zahlen: List.unmodifiable(zahlen));
  }

  static int? _ganz(Object? v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v.trim());
    return null;
  }
}

enum WebChatErgebnis { bestaetigt, abgelehnt, falsch, abgelaufen, fehler }

/// Holt die Frage ab und schickt die Antwort. Ein Exemplar je App-Lauf.
class WebChatBestaetigung {
  WebChatBestaetigung._();
  static final WebChatBestaetigung instance = WebChatBestaetigung._();

  /// Häufiger fragt die App nicht von selbst nach (Start, Zurückkommen in den
  /// Vordergrund). Ein Push des Vorstands fragt sofort.
  static const abstand = Duration(seconds: 30);

  final _log = LoggerService();

  @visibleForTesting
  Future<http.Response> Function() holen = () => ApiService().webChatOffen();

  @visibleForTesting
  Future<http.Response> Function(int id, {int? zahl}) senden =
      (id, {zahl}) => ApiService().webChatAntworten(id, zahl: zahl);

  @visibleForTesting
  DateTime Function() jetzt = DateTime.now;

  DateTime? _zuletzt;

  /// Läuft gerade eine Abfrage oder steht der Dialog? Dann tut ein zweiter
  /// Auslöser nichts — es gibt nie zwei Dialoge übereinander.
  bool _beschaeftigt = false;
  bool get beschaeftigt => _beschaeftigt;

  /// Kam während der Abfrage ein Push? Dann wird danach noch einmal gefragt:
  /// die Abfrage kann die Frage um Augenblicke verpasst haben.
  bool _nochmal = false;

  /// Fragt den Server und zeigt die Frage mit [zeigen], falls eine offen ist.
  ///
  /// [sofort] (Push) übergeht den Abstand von 30 s. Ohne Antwort weggeklickt
  /// kommt die Frage beim nächsten Auslöser wieder, solange sie gilt — der
  /// Server weiß, ob sie noch offen ist, die App merkt sich dazu nichts.
  Future<void> pruefen({
    required Future<void> Function(WebChatAnfrage anfrage) zeigen,
    bool sofort = false,
  }) async {
    if (_beschaeftigt) {
      if (sofort) _nochmal = true;
      return;
    }
    final t = jetzt();
    if (!sofort && _zuletzt != null && t.difference(_zuletzt!) < abstand) return;
    _beschaeftigt = true;
    _nochmal = false;
    var gezeigt = false;
    try {
      _zuletzt = t;
      final anfrage = await _abholen();
      if (anfrage != null) {
        gezeigt = true;
        await zeigen(anfrage);
      }
    } finally {
      _beschaeftigt = false;
    }
    if (_nochmal && !gezeigt) {
      _nochmal = false;
      await pruefen(zeigen: zeigen, sofort: true);
    }
  }

  Future<WebChatAnfrage?> _abholen() async {
    try {
      final r = await holen().timeout(const Duration(seconds: 15));
      if (r.statusCode != 200) {
        _log.warning('WebChat: Abfrage HTTP ${r.statusCode}', tag: 'WEBCHAT');
        return null;
      }
      return WebChatAnfrage.ausAntwort(jsonDecode(r.body));
    } catch (e) {
      _log.warning('WebChat: Abfrage fehlgeschlagen (${e.runtimeType})', tag: 'WEBCHAT');
      return null;
    }
  }

  /// Antwortet: mit [zahl] „das bin ich", ohne „nein, das bin ich nicht".
  Future<WebChatErgebnis> antworten(WebChatAnfrage anfrage, {int? zahl}) async {
    try {
      final r = await senden(anfrage.id, zahl: zahl).timeout(const Duration(seconds: 15));
      Object? json;
      try {
        json = jsonDecode(r.body);
      } catch (_) {
        json = null;
      }
      final ergebnis = ergebnisAus(r.statusCode, json);
      _log.info('WebChat: Antwort ${ergebnis.name} (HTTP ${r.statusCode})', tag: 'WEBCHAT');
      return ergebnis;
    } catch (e) {
      _log.warning('WebChat: Antwort fehlgeschlagen (${e.runtimeType})', tag: 'WEBCHAT');
      return WebChatErgebnis.fehler;
    }
  }

  /// Statuscode und Rumpf von `aktion: antworten`, gedeutet.
  ///
  /// ⚠️ `falsch` gilt auch ohne 200: die Frage ist dann verbraucht, und das
  /// muss das Mitglied erfahren — sonst tippt es weiter auf Zahlen, die nichts
  /// mehr bewirken.
  static WebChatErgebnis ergebnisAus(int status, Object? json) {
    final j = json is Map ? json : const <String, dynamic>{};
    final s = j['status'];
    if (s == 'falsch') return WebChatErgebnis.falsch;
    if (status == 404 || status == 410 || j['grund'] == 'keine') {
      return WebChatErgebnis.abgelaufen;
    }
    if (status == 200 && j['success'] == true) {
      if (s == 'bestaetigt') return WebChatErgebnis.bestaetigt;
      if (s == 'abgelehnt') return WebChatErgebnis.abgelehnt;
    }
    return WebChatErgebnis.fehler;
  }

  /// Nur für Tests: alles auf Anfang.
  @visibleForTesting
  void zuruecksetzen() {
    _zuletzt = null;
    _beschaeftigt = false;
    _nochmal = false;
    holen = () => ApiService().webChatOffen();
    senden = (id, {zahl}) => ApiService().webChatAntworten(id, zahl: zahl);
    jetzt = DateTime.now;
  }
}
