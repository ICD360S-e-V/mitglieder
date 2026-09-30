/// Kurzfassung der Bildabschnitte einer SDP — für das Protokoll.
///
/// ⚠️ Warum es das gibt: bei der Fernwartung stand am 30.09.2026 die
/// Verbindung, dieses Gerät teilte seinen Bildschirm, über das Relais flossen
/// rund 100 kB/s — und der Vorsitz sah Schwarz. Aus dem Protokoll ging nicht
/// hervor, WAS ausgehandelt war: welcher Codec zuerst steht, ob die Bildspur
/// einer Spurgruppe angehört, welche Erweiterungen gelten. Ohne das wird
/// geraten. Dieselbe Funktion steht in der Vorsitzer-App; beide Protokolle
/// lassen sich so nebeneinanderlegen.
///
/// Bewusst NICHT im Protokoll: `ice-ufrag`, `ice-pwd`, `fingerprint`,
/// Kandidaten und die Kennungen aus `a=msid`/`a=ssrc`. Das eine sind
/// Zugangsdaten der Sitzung, das andere braucht niemand, um einen schwarzen
/// Bildschirm zu erklären — gezählt wird nur, wie viele es sind.
library;

/// Eine Zeile je `m=video`-Abschnitt, davor eine für die Sitzung.
List<String> sdpVideoKurz(String? sdp) {
  if (sdp == null || sdp.trim().isEmpty) return const ['<leer>'];

  final zeilen = <String>[];
  String? bundle;
  var gemischt = false;

  _Abschnitt? a;
  void ablegen() {
    final fertig = a;
    if (fertig != null && fertig.video) zeilen.add(fertig.kurz());
    a = null;
  }

  for (final roh in sdp.split(RegExp(r'\r?\n'))) {
    final l = roh.trim();
    if (l.isEmpty) continue;
    if (l.startsWith('m=')) {
      ablegen();
      a = _Abschnitt(video: l.startsWith('m=video'));
      continue;
    }
    if (l == 'a=extmap-allow-mixed') gemischt = true;
    final jetzt = a;
    if (jetzt == null) {
      if (l.startsWith('a=group:BUNDLE')) {
        bundle = l.substring('a=group:BUNDLE'.length).trim().replaceAll(' ', ',');
      }
      continue;
    }
    jetzt.lesen(l);
  }
  ablegen();

  return [
    'sitzung bundle=${bundle ?? "-"} extmap-allow-mixed=${gemischt ? "ja" : "nein"}',
    if (zeilen.isEmpty) 'kein m=video' else ...zeilen,
  ];
}

class _Abschnitt {
  final bool video;
  _Abschnitt({required this.video});

  String mid = '?';
  String richtung = '?';
  final codecs = <String>[];
  final zusatz = <String>{};
  final erweiterungen = <String>[];
  final rueckmeldungen = <String>{};
  final ssrc = <String>{};
  var msid = 0;
  String? erstesFmtp;
  String? erstePt;

  static const _hilfen = {'rtx', 'red', 'ulpfec', 'flexfec-03'};

  void lesen(String l) {
    if (l.startsWith('a=mid:')) {
      mid = l.substring(6);
    } else if (l == 'a=sendrecv' || l == 'a=sendonly' || l == 'a=recvonly' || l == 'a=inactive') {
      richtung = l.substring(2);
    } else if (l.startsWith('a=rtpmap:')) {
      // a=rtpmap:96 VP8/90000
      final teile = l.substring(9).split(' ');
      if (teile.length < 2) return;
      final name = teile[1].split('/').first;
      if (_hilfen.contains(name.toLowerCase())) {
        zusatz.add(name.toLowerCase());
      } else {
        erstePt ??= teile[0];
        if (!codecs.contains(name)) codecs.add(name);
      }
    } else if (l.startsWith('a=fmtp:')) {
      // Nur die Einstellung des ERSTEN Codecs — er ist der, der gesendet wird.
      final leer = l.indexOf(' ');
      if (leer > 7 && erstesFmtp == null && l.substring(7, leer) == erstePt) {
        erstesFmtp = l.substring(leer + 1);
      }
    } else if (l.startsWith('a=msid:')) {
      msid++;
    } else if (l.startsWith('a=ssrc:')) {
      // a=ssrc:12345 cname:… — nur zählen, wie viele verschiedene es sind.
      final ende = l.indexOf(' ');
      ssrc.add(ende > 7 ? l.substring(7, ende) : l.substring(7));
    } else if (l.startsWith('a=extmap:')) {
      final teile = l.split(' ');
      if (teile.length > 1) erweiterungen.add(_kurzname(teile[1]));
    } else if (l.startsWith('a=rtcp-fb:')) {
      final leer = l.indexOf(' ');
      if (leer > 0) rueckmeldungen.add(l.substring(leer + 1).replaceAll(' ', '-'));
    }
  }

  /// `…/abs-send-time` → `abs-send-time`, `urn:…:sdes:mid` → `mid`.
  static String _kurzname(String uri) {
    var s = uri;
    final raute = s.lastIndexOf('#');
    if (raute >= 0 && raute < s.length - 1) s = s.substring(raute + 1);
    final strich = s.lastIndexOf('/');
    if (strich >= 0 && strich < s.length - 1) s = s.substring(strich + 1);
    final punkt = s.lastIndexOf(':');
    if (punkt >= 0 && punkt < s.length - 1) s = s.substring(punkt + 1);
    return s;
  }

  String kurz() {
    final z = (zusatz.toList()..sort()).map((e) => '+$e').join(' ');
    final f = erstesFmtp == null ? '' : ' fmtp[${codecs.isEmpty ? "?" : codecs.first}]=$erstesFmtp';
    return 'video mid=$mid $richtung codecs=${codecs.join(",")}'
        '${z.isEmpty ? "" : " $z"}$f'
        ' msid=$msid ssrc=${ssrc.length}'
        ' fb=${(rueckmeldungen.toList()..sort()).join(",")}'
        ' ext=${erweiterungen.join(",")}';
  }
}
