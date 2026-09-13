import 'package:flutter/foundation.dart';
import 'package:icd_klingel/icd_klingel.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Das Angebot eines Anrufers, das auf eine Antwort wartet.
@immutable
class WartendesAngebot {
  const WartendesAngebot({
    required this.gespraechId,
    required this.anruferId,
    required this.anruferName,
    required this.sdp,
    required this.sdpTyp,
    required this.video,
    required this.zeit,
  });

  final int gespraechId;
  final String anruferId;
  final String anruferName;
  final String sdp;
  final String sdpTyp;
  final bool video;
  final DateTime zeit;
}

/// Der Klingelschirm über dem Sperrbildschirm — die Seite der App.
///
/// 🔴 DER GRUND, WARUM ES DAS GIBT. Der Anruf trifft im Isolat des
/// Hintergrunddienstes ein; der Klingeldialog lebt im Isolat der Oberfläche.
/// Das sind zwei Isolate mit je eigener WebSocket-Verbindung und ohne
/// gemeinsamen Speicher. Bei ruhendem Tablet lebt nur das erste — es zeigte
/// bisher eine Benachrichtigung, und beim Öffnen der App verband sich das
/// zweite neu, während das Angebot des Anrufers längst verschickt und nicht
/// wiederholt worden war. Der Anruf war also gar nicht annehmbar.
///
/// Das Angebot wird deshalb festgehalten. Der Kommentar an
/// `_showRemoteNotification` im Hintergrunddienst benennt genau diese Lücke.
class AnrufKlingel {
  AnrufKlingel._();

  static const _kSdp = 'anruf_wartend_sdp';
  static const _kTyp = 'anruf_wartend_typ';
  static const _kGespraech = 'anruf_wartend_gespraech';
  static const _kAnrufer = 'anruf_wartend_anrufer';
  static const _kAnruferId = 'anruf_wartend_anrufer_id';
  static const _kVideo = 'anruf_wartend_video';
  static const _kZeit = 'anruf_wartend_zeit';

  /// ⚠️ Ein Angebot, das älter ist, wird VERWORFEN. Der Anrufer klingelt ~45 s
  /// und gibt dann auf; ein Angebot von vor einer Stunde würde beim nächsten
  /// Start der App einen Klingelschirm für ein Gespräch zeigen, das es nicht
  /// mehr gibt. 90 s lassen dem Klingeln Luft, ohne zu spuken.
  static const Duration hoechstalter = Duration(seconds: 90);

  // ------------------------------------------------------------------ merken

  static Future<void> merken({
    required int gespraechId,
    required String anruferId,
    required String anruferName,
    required String sdp,
    required String sdpTyp,
    required bool video,
  }) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kSdp, sdp);
    await p.setString(_kTyp, sdpTyp);
    await p.setInt(_kGespraech, gespraechId);
    await p.setString(_kAnrufer, anruferName);
    await p.setString(_kAnruferId, anruferId);
    await p.setBool(_kVideo, video);
    // ⚠️ Die Zeit ZULETZT. Bricht der Schreibvorgang dazwischen ab, ist das
    // Angebot ohne Zeitstempel — und [lesen] verwirft es, statt eine halbe
    // Zeile für ein gültiges Angebot zu halten.
    await p.setInt(_kZeit, DateTime.now().millisecondsSinceEpoch);
  }

  /// Liest das wartende Angebot. `null`, wenn keines da oder es zu alt ist.
  static Future<WartendesAngebot?> lesen() async {
    final p = await SharedPreferences.getInstance();
    // ⚠️ `reload()` ist PFLICHT: geschrieben hat das andere Isolat, und ohne
    // Nachladen liefert der Zwischenspeicher dieses Isolats den Stand von
    // seinem eigenen Start.
    await p.reload();
    final sdp = p.getString(_kSdp);
    final millis = p.getInt(_kZeit);
    if (sdp == null || sdp.isEmpty || millis == null) return null;

    final zeit = DateTime.fromMillisecondsSinceEpoch(millis);
    final alter = DateTime.now().difference(zeit);
    if (alter.isNegative || alter > hoechstalter) {
      await vergessen();
      return null;
    }
    return WartendesAngebot(
      gespraechId: p.getInt(_kGespraech) ?? 0,
      anruferId: p.getString(_kAnruferId) ?? '',
      anruferName: p.getString(_kAnrufer) ?? '',
      sdp: sdp,
      sdpTyp: p.getString(_kTyp) ?? 'offer',
      video: p.getBool(_kVideo) ?? false,
      zeit: zeit,
    );
  }

  static Future<void> vergessen() async {
    final p = await SharedPreferences.getInstance();
    for (final k in <String>[
      _kSdp, _kTyp, _kGespraech, _kAnrufer, _kAnruferId, _kVideo, _kZeit,
    ]) {
      await p.remove(k);
    }
  }

  // ------------------------------------------------------------------- Texte

  /// Beschriftungen für den NATIVEN Schirm.
  ///
  /// ⚠️ Sie kommen aus den 28 ARB-Dateien und werden von der Oberfläche
  /// hinterlegt, weil das Isolat des Hintergrunddienstes keine
  /// `AppLocalizations` hat. Dieselbe Mechanik wie die vorhandenen
  /// `l10n_*`-Schlüssel — und der Grund, warum der Kotlin-Teil KEIN
  /// `values-xx/strings.xml` anlegt: das wäre eine zweite Übersetzungsquelle.
  static Future<({String titel, String annehmen, String ablehnen})>
      texte() async {
    final p = await SharedPreferences.getInstance();
    await p.reload();
    return (
      titel: p.getString('l10n_notifIncomingCall') ?? 'Eingehender Anruf',
      annehmen: p.getString('l10n_acceptCall') ?? 'Annehmen',
      ablehnen: p.getString('l10n_rejectCall') ?? 'Ablehnen',
    );
  }

  // ------------------------------------------------------------------ zeigen

  /// Hält das Angebot fest UND lässt es klingeln.
  ///
  /// ⚠️ In DIESER Reihenfolge. Klingelte es zuerst, könnte das Mitglied
  /// „Annehmen" tippen, bevor das Angebot festgehalten ist — die App käme nach
  /// vorne und fände nichts vor.
  static Future<bool> anbieten({
    required int gespraechId,
    required String anruferId,
    required String anruferName,
    required String sdp,
    required String sdpTyp,
    required bool video,
  }) async {
    await merken(
      gespraechId: gespraechId,
      anruferId: anruferId,
      anruferName: anruferName,
      sdp: sdp,
      sdpTyp: sdpTyp,
      video: video,
    );
    final t = await texte();
    return IcdKlingel.zeigen(
      name: anruferName,
      video: video,
      gespraechId: gespraechId,
      titel: t.titel,
      annehmen: t.annehmen,
      ablehnen: t.ablehnen,
    );
  }

  /// Nimmt Klingeln, Schirm und das wartende Angebot weg.
  static Future<void> abraeumen() async {
    await IcdKlingel.verbergen();
    await vergessen();
  }
}
