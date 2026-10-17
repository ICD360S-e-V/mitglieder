import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

/// Ein Bestätigungscode, der über einen Link in die App kam.
@immutable
class KontaktCodeAusLink {
  /// 'email' oder 'telefon' — die Kanäle von member/kontakt_bestaetigen.php.
  final String kanal;

  /// Sechs Ziffern.
  final String code;

  const KontaktCodeAusLink(this.kanal, this.code);

  @override
  bool operator ==(Object other) =>
      other is KontaktCodeAusLink && other.kanal == kanal && other.code == code;

  @override
  int get hashCode => Object.hash(kanal, code);

  /// ⚠️ Ohne den Code: was hier steht, landet sonst irgendwann in einem
  /// Protokoll.
  @override
  String toString() => 'KontaktCodeAusLink($kanal)';
}

/// Der Link in der Mail mit dem Bestätigungscode.
///
/// Meldung des Vorsitzenden, 17.10.2026: „ar fi super daca ar fi un link care
/// sa duca in aplicatie si codul sa se completeze automat“. Unter dem Code
/// steht in der Mail (member/kontakt_bestaetigen.php, cron/kontakt_erinnerung.php)
///
///     https://icd360sev.icd360s.de/code/#email=482913
///
/// - Android öffnet damit gleich die App: ein App Link, den der Server mit
///   /.well-known/assetlinks.json und dem Fingerabdruck des Release-Schlüssels
///   bestätigt.
/// - Überall sonst öffnet sich der Browser mit einer Seite, die den Code zeigt,
///   ihn kopieren lässt und mit „In der App öffnen“ das eigene Schema
///   [schema] aufruft: Windows (Registry, vom Installer), macOS und iOS
///   (Info.plist), Linux (.desktop-Datei).
///
/// ⚠️ Der Code steht hinter dem `#`. Diesen Teil schickt kein Browser an einen
/// Server — der Code landet so in keinem Zugriffsprotokoll, auch nicht in dem
/// eines Link-Prüfers (Proofpoint, Safe Links), der den Link vorab öffnet.
///
/// ⚠️ Ein Link bestätigt NICHTS von selbst. Die Seite im Browser schickt
/// nichts ab; ein Link-Prüfer, der sie öffnet, verbraucht keinen Code.
/// Geprüft wird nur in der angemeldeten App, über `code_pruefen` — dieselbe
/// Prüfung wie beim Eintippen, mit derselben Versuchsgrenze.
class KontaktLink {
  KontaktLink._();
  static final KontaktLink instance = KontaktLink._();

  /// Adresse des Links — dieselbe wie im Intent-Filter (AndroidManifest.xml)
  /// und in assetlinks.json auf dem Server.
  static const host = 'icd360sev.icd360s.de';
  static const pfad = '/code/';

  /// Das eigene Schema für Windows, macOS, iOS, Linux und den Rückweg von der
  /// Seite im Browser: `icd360s-mitglied://code#email=482913`.
  static const schema = 'icd360s-mitglied';

  static final _sechsZiffern = RegExp(r'^[0-9]{6}$');

  /// Der angekommene, noch nicht gezeigte Code. Das Dashboard holt ihn ab
  /// ([abholen]) — erst dort ist jemand angemeldet, der ihn einlösen kann.
  /// Kommt der Link vor der Anmeldung, wartet er hier.
  final ValueNotifier<KontaktCodeAusLink?> offen = ValueNotifier(null);

  StreamSubscription<Uri>? _abo;

  /// Hört auf Links — auch auf den, mit dem die App gestartet wurde: den reicht
  /// app_links beim ersten Zuhören nach.
  void starten({Stream<Uri>? links}) {
    if (_abo != null) return;
    try {
      _abo = (links ?? AppLinks().uriLinkStream).listen(aufnehmen, onError: (_) {});
    } catch (_) {
      // Eine Plattform ohne app_links: dann eben ohne Link. Die Mail nennt den
      // Code auch so.
    }
  }

  void aufnehmen(Uri link) {
    final code = lesen(link);
    if (code != null) offen.value = code;
  }

  /// Gibt den wartenden Code heraus — genau einmal.
  KontaktCodeAusLink? abholen() {
    final code = offen.value;
    offen.value = null;
    return code;
  }

  /// Der Code aus einem unserer Links, sonst null. Fremde Adressen, andere
  /// Pfade und alles, was nicht genau sechs Ziffern sind, zählen nicht.
  static KontaktCodeAusLink? lesen(Uri link) {
    final art = link.scheme.toLowerCase();
    final unserer = (art == 'https' &&
            link.host.toLowerCase() == host &&
            (link.path == pfad || link.path == '/code')) ||
        (art == schema && link.host.toLowerCase() == 'code');
    if (!unserer) return null;
    // Hinter dem # — und, falls ein Mailprogramm den Link umgebaut hat, nach
    // dem ?.
    for (final teil in [link.fragment, link.query]) {
      if (teil.isEmpty) continue;
      final Map<String, String> werte;
      try {
        werte = Uri.splitQueryString(teil);
      } catch (_) {
        continue;
      }
      for (final kanal in const ['email', 'telefon']) {
        final code = werte[kanal]?.trim();
        if (code != null && _sechsZiffern.hasMatch(code)) {
          return KontaktCodeAusLink(kanal, code);
        }
      }
    }
    return null;
  }
}
