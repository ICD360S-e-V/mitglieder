import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

/// Was das Mitglied auf dem Klingelschirm getippt hat.
class KlingelEntscheidung {
  const KlingelEntscheidung({
    required this.art,
    required this.gespraechId,
    required this.zeit,
  });

  /// `annehmen` oder `ablehnen`.
  final String art;
  final int gespraechId;
  final DateTime zeit;

  bool get istAnnehmen => art == 'annehmen';
  bool get istAblehnen => art == 'ablehnen';

  @override
  String toString() => 'KlingelEntscheidung($art, $gespraechId, $zeit)';
}

/// Der Klingelschirm über dem Sperrbildschirm.
///
/// ⚠️ Nur Android. Auf allen anderen Plattformen tun die Aufrufe nichts und
/// melden das auch so — ein Hinweis „gibt es hier nicht" ist ehrlicher als ein
/// Knopf, der nichts bewirkt.
class IcdKlingel {
  IcdKlingel._();

  static const MethodChannel _kanal =
      MethodChannel('de.icd360s.mitglied/klingel');
  static const EventChannel _ereignisse =
      EventChannel('de.icd360s.mitglied/klingel_ereignisse');

  /// ⚠️ Eine Entscheidung, die älter ist als das, wird VERWORFEN. Sonst
  /// beantwortete ein Tipp von vor einer Stunde den Anruf von jetzt. Der
  /// Anrufer klingelt ~45 s; zwei Minuten sind reichlich.
  static const Duration hoechstalter = Duration(minutes: 2);

  static bool get verfuegbar => Platform.isAndroid;

  /// Zeigt Meldung + Vollbild-Klingelschirm. `false`, wenn Android die
  /// Benachrichtigung abgelehnt hat.
  static Future<bool> zeigen({
    required String name,
    required bool video,
    required int gespraechId,
    required String titel,
    required String annehmen,
    required String ablehnen,
  }) async {
    if (!verfuegbar) return false;
    try {
      final ok = await _kanal.invokeMethod<bool>('zeigen', <String, dynamic>{
        'name': name,
        'video': video,
        'gespraech': gespraechId,
        'titel': titel,
        'annehmen': annehmen,
        'ablehnen': ablehnen,
      });
      return ok ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Nimmt Meldung, Ton UND den Klingelschirm weg.
  static Future<void> verbergen() async {
    if (!verfuegbar) return;
    try {
      await _kanal.invokeMethod<bool>('verbergen');
    } catch (_) {
      // Ein Anruf darf am Aufräumen nicht scheitern.
    }
  }

  /// Darf die App einen Vollbild-Intent zeigen?
  ///
  /// ⚠️ Vor Android 14 gibt es nichts zu prüfen und die Antwort ist `true`.
  /// Ab Android 14 entzieht der Play Store die Berechtigung bei Installation
  /// jeder App, die er nicht als Telefonie- oder Weckerapp einordnet.
  static Future<bool> erlaubt() async {
    if (!verfuegbar) return false;
    try {
      return await _kanal.invokeMethod<bool>('erlaubt') ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Öffnet die Systemeinstellung. `false`, wenn kein Weg aufging.
  static Future<bool> einstellungOeffnen() async {
    if (!verfuegbar) return false;
    try {
      return await _kanal.invokeMethod<bool>('einstellungOeffnen') ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Sieht die anstehende Entscheidung an, OHNE sie zu verbrauchen.
  ///
  /// 🔴 Ansehen und Quittieren sind getrennt, weil BEIDE Isolate anklopfen
  /// hören — das des Hintergrunddienstes und das der Oberfläche. Ein Lesen,
  /// das löscht, hätte dem anderen die Entscheidung gestohlen: die Absage
  /// braucht die stehende WebSocket-Verbindung des Dienstes, das Annehmen
  /// braucht WebRTC in der Oberfläche. Je nach Reihenfolge wäre der eine oder
  /// der andere Weg stumm ausgefallen.
  static Future<KlingelEntscheidung?> entscheidungAnsehen() async {
    if (!verfuegbar) return null;
    String? rohwert;
    try {
      rohwert = await _kanal.invokeMethod<String>('entscheidungAnsehen');
    } catch (_) {
      return null;
    }
    return entscheidungLesen(rohwert);
  }

  /// Quittiert die Entscheidung — erst danach ist sie weg.
  static Future<void> entscheidungQuittieren() async {
    if (!verfuegbar) return;
    try {
      await _kanal.invokeMethod<bool>('entscheidungQuittieren');
    } catch (_) {
      // Bleibt sie stehen, verwirft sie [entscheidungLesen] nach zwei Minuten
      // wegen Alters. Schlimmer wäre ein Absturz beim Aufräumen.
    }
  }

  /// Der reine Textteil, damit er ohne Kanal prüfbar ist.
  ///
  /// Form: `<art>:<gespraechId>:<millis>`.
  static KlingelEntscheidung? entscheidungLesen(
    String? rohwert, {
    DateTime? jetzt,
  }) {
    if (rohwert == null || rohwert.isEmpty) return null;
    final teile = rohwert.split(':');
    if (teile.length != 3) return null;
    final art = teile[0];
    if (art != 'annehmen' && art != 'ablehnen') return null;
    final id = int.tryParse(teile[1]);
    final millis = int.tryParse(teile[2]);
    if (id == null || millis == null) return null;
    final zeit = DateTime.fromMillisecondsSinceEpoch(millis);
    final bezug = jetzt ?? DateTime.now();
    // ⚠️ Auch eine Entscheidung AUS DER ZUKUNFT wird verworfen: nach einer
    // Zeitumstellung oder einem gestellten Systemdatum wäre sie sonst ewig
    // „frisch" und beantwortete jeden künftigen Anruf.
    final alter = bezug.difference(zeit);
    if (alter.isNegative || alter > hoechstalter) return null;
    return KlingelEntscheidung(art: art, gespraechId: id, zeit: zeit);
  }

  static Stream<void>? _klopfen;

  /// Klopft, wenn eine Entscheidung ansteht. Trägt sie NICHT mit sich —
  /// angesehen wird über [entscheidungAnsehen].
  static Stream<void> get anklopfen {
    if (!verfuegbar) return const Stream<void>.empty();
    return _klopfen ??= _ereignisse.receiveBroadcastStream().map((_) {});
  }
}
