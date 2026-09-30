/// Was dieses Gerät bei einer Fernwartung WIRKLICH aufnimmt, kodiert und
/// sendet — als Zahlen fürs Protokoll.
///
/// ⚠️ Warum es das gibt: am 30.09.2026 teilte ein Mitglied an Windows 11
/// seinen Bildschirm, im Protokoll stand „answered offer, sharing screen",
/// über das Relais flossen rund 100 kB/s — und der Vorsitz sah Schwarz. Ob die
/// Aufnahme Bilder lieferte, in welcher Größe, mit welchem Codec, und ob die
/// Gegenseite ständig um ein neues Vollbild bat: nichts davon stand irgendwo.
///
/// Die vier Stationen, an denen ein Bild verloren gehen kann, und woran man
/// sie erkennt:
///
///   Aufnahme liefert nichts   → [quelleBilder] bleibt 0
///   aufgenommen, nicht kodiert → [quelleBilder] wächst, [kodiert] bleibt 0
///   kodiert, Gegenseite kommt nicht mit → [pli] wächst von Messung zu Messung
///   alles läuft               → [kodiert] wächst, [pli] steht
///
/// Dazu gehört die Gegenrechnung beim Vorsitz (`BildBefund` in der
/// Vorsitzer-App): erst beide Protokolle zusammen sagen, WO es hängt.
library;

class SendeBefund {
  /// Gibt es überhaupt einen Bildsender? Ohne ihn ist die Bildspur nicht
  /// ausgehandelt worden.
  final bool sender;

  /// Bilder, die die Aufnahme geliefert hat, und ihre Größe.
  final int quelleBilder;
  final int quelleBreite;
  final int quelleHoehe;

  /// Kodierte Bilder, davon Schlüsselbilder, und die kodierte Größe.
  final int kodiert;
  final int schluesselbilder;
  final int breite;
  final int hoehe;
  final double fps;

  final int bytes;
  final int pakete;

  /// Bitten der Gegenseite um ein Schlüsselbild (PLI, FIR) und um
  /// Wiederholung (NACK).
  final int pli;
  final int fir;
  final int nack;

  final String? codec;

  /// Wer kodiert — `libvpx`, `OpenH264` und dergleichen.
  final String? kodierer;

  /// Was die Bibliothek als Bremse nennt: `none`, `bandwidth`, `cpu`.
  final String? grenze;

  /// Zielbitrate des Kodierers in kbit/s.
  final int zielKbit;

  const SendeBefund({
    this.sender = true,
    this.quelleBilder = 0,
    this.quelleBreite = 0,
    this.quelleHoehe = 0,
    this.kodiert = 0,
    this.schluesselbilder = 0,
    this.breite = 0,
    this.hoehe = 0,
    this.fps = 0,
    this.bytes = 0,
    this.pakete = 0,
    this.pli = 0,
    this.fir = 0,
    this.nack = 0,
    this.codec,
    this.kodierer,
    this.grenze,
    this.zielKbit = 0,
  });

  static const lageKeinSender = 'kein-Bildsender';
  static const lageKeineAufnahme = 'Aufnahme-liefert-nichts';
  static const lageNichtKodiert = 'nicht-kodiert';
  static const lageBittet = 'Gegenseite-bittet-um-Vollbild';
  static const lageSteht = 'steht';
  static const lageLaeuft = 'läuft';

  /// Ab so vielen neuen Bitten zwischen zwei Messungen (fünf Sekunden) gilt:
  /// die Gegenseite kommt mit dem Strom nicht zurecht. Eine einzelne Bitte
  /// gehört zum Verbindungsaufbau.
  static const int bittenSchwelle = 3;

  /// Genau eine Lage — gemessen gegen die Messung [vorher].
  String lage(SendeBefund? vorher) {
    if (!sender) return lageKeinSender;
    if (kodiert == 0) {
      return quelleBilder == 0 ? lageKeineAufnahme : lageNichtKodiert;
    }
    if (vorher != null && vorher.sender) {
      final bitten = (pli + fir) - (vorher.pli + vorher.fir);
      if (bitten >= bittenSchwelle) return lageBittet;
      if (kodiert <= vorher.kodiert) return lageSteht;
    }
    return lageLaeuft;
  }

  /// Eine Zeile Rohzahlen. Die Deutung steht in [lage].
  String get protokoll {
    final q = (quelleBreite > 0 && quelleHoehe > 0) ? '$quelleBreite×$quelleHoehe' : '?×?';
    final g = (breite > 0 && hoehe > 0) ? '$breite×$hoehe' : '?×?';
    return 'Aufnahme $q $quelleBilder Bilder, '
        'kodiert $g ${codec ?? "?"} (${kodierer ?? "?"}) '
        '$kodiert Bilder, $schluesselbilder Schlüsselbilder, '
        '${fps.toStringAsFixed(1)} fps, '
        '$pakete Pakete, ${(bytes / 1024).round()} kB, '
        'PLI $pli, FIR $fir, NACK $nack, '
        'Ziel $zielKbit kbit/s, Grenze ${grenze ?? "?"}';
  }

  /// Wann eine Messung ins Protokoll gehört. [takt] zählt ab 1, alle fünf
  /// Sekunden einer: die ersten beiden, eine nach einer halben Minute, danach
  /// jede Minute — und jeder Wechsel der Lage.
  ///
  /// ⚠️ Jede Zeile wird hochgeladen; bei einem Mitglied am Mobilfunkvertrag
  /// ist das kein Nebenbei.
  static bool faellig(int takt, {required bool wechsel}) {
    if (wechsel || takt <= 2 || takt == 6) return true;
    return takt % 12 == 0;
  }

  /// Zahl aus der Statistik — als Zahl oder als Text geliefert.
  static int zahl(dynamic v) {
    if (v is num) return v.toInt();
    if (v is String) return num.tryParse(v)?.toInt() ?? 0;
    return 0;
  }

  /// Baut den Befund aus den Berichten von `getStats()`.
  ///
  /// [berichte] sind Tripel aus Kennung, Art und Werten — so bleibt diese
  /// Datei frei von flutter_webrtc und lässt sich ohne Gerät prüfen.
  static SendeBefund ausStatistik(
      Iterable<({String id, String type, Map<dynamic, dynamic> werte})> berichte) {
    Map<dynamic, dynamic>? aus;
    Map<dynamic, dynamic>? quelle;
    final codecs = <String, String>{};
    for (final b in berichte) {
      final w = b.werte;
      if (b.type == 'outbound-rtp' && w['kind'] == 'video') {
        aus = w;
      } else if (b.type == 'media-source' && w['kind'] == 'video') {
        quelle = w;
      } else if (b.type == 'codec' && w['mimeType'] is String) {
        final m = w['mimeType'] as String;
        if (m.startsWith('video/')) codecs[b.id] = m.split('/').last;
      }
    }
    if (aus == null) {
      return SendeBefund(
        sender: false,
        quelleBilder: zahl(quelle?['frames']),
        quelleBreite: zahl(quelle?['width']),
        quelleHoehe: zahl(quelle?['height']),
      );
    }
    final fps = aus['framesPerSecond'];
    final ziel = aus['targetBitrate'];
    final grenze = aus['qualityLimitationReason'];
    final kodierer = aus['encoderImplementation'];
    return SendeBefund(
      quelleBilder: zahl(quelle?['frames']),
      quelleBreite: zahl(quelle?['width']),
      quelleHoehe: zahl(quelle?['height']),
      kodiert: zahl(aus['framesEncoded']),
      schluesselbilder: zahl(aus['keyFramesEncoded']),
      breite: zahl(aus['frameWidth']),
      hoehe: zahl(aus['frameHeight']),
      fps: fps is num ? fps.toDouble() : 0,
      bytes: zahl(aus['bytesSent']),
      pakete: zahl(aus['packetsSent']),
      pli: zahl(aus['pliCount']),
      fir: zahl(aus['firCount']),
      nack: zahl(aus['nackCount']),
      codec: codecs[aus['codecId']],
      kodierer: kodierer is String && kodierer.isNotEmpty ? kodierer : null,
      grenze: grenze is String ? grenze : null,
      zielKbit: ziel is num ? (ziel / 1000).round() : 0,
    );
  }
}
