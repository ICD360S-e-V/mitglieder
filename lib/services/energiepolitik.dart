import 'dart:math' as math;

/// Wie grosszügig die App gerade mit Funkzeit umgehen darf.
///
/// Die Stufen sind nach dem schlechtesten zutreffenden Signal benannt, nicht
/// nach dem Akkustand allein: ein volles Gerät im Energiesparmodus gehört in
/// [sparsam], nicht in [normal].
enum Energiestufe {
  /// Am Ladegerät. Zusätzliche Funkzeit kostet den Nutzer nichts.
  grosszuegig,

  /// Am Akku, ausreichend geladen, keine Einschränkungen des Systems.
  normal,

  /// Akku unter der Hälfte, oder das System hat begonnen zu drosseln.
  sparsam,

  /// Wenig Akku, Energiesparmodus, thermische Drosselung oder vom System
  /// bereits stillgelegt. Hier zählt jede vermiedene Anfrage.
  streng,
}

/// Leitet aus dem Gerätezustand ab, wie stark periodische Takte gestreckt
/// werden sollen.
///
/// Warum überhaupt: die Messung im Feld zeigte, dass die App im Hintergrund
/// unabhängig vom Gerätezustand immer gleich häufig funkt — bei 95 % Akku am
/// Ladegerät genauso wie bei 8 % im Energiesparmodus. Android rät ausdrücklich
/// zum Gegenteil: am Ladegerät ist der Einfluss vernachlässigbar und die
/// Frequenz darf hoch bleiben, beim Entladen soll sie sinken, und bei fast
/// leerem Akku soll sie sinken oder ganz aussetzen.
///
/// Die Signale liest die App ohnehin schon für die Verbrauchsmessung aus
/// ([BatteryPlatformState]); hier werden sie zum ersten Mal benutzt, um etwas
/// zu ändern statt nur zu berichten.
///
/// Bewusst NICHT angewandt auf den Heartbeat: `api/chat/support_status.php`
/// wertet jemanden nur als online, wenn `last_seen` keine 30 Sekunden alt ist.
/// Ein gestreckter Heartbeat zeigte Mitglieder dauerhaft als offline — eine
/// sichtbare Fehlfunktion für eine Handvoll gesparter Anfragen.
class Energiepolitik {
  /// Ab hier gilt der Akku als knapp.
  static const int schwelleKnapp = 20;

  /// Darunter gilt er als mässig gefüllt.
  static const int schwelleMittel = 50;

  /// Ab diesem Standby-Bucket (40 = rare) hat Android die App bereits als
  /// auffällig eingestuft und beschränkt ihren Netzzugriff. Dagegen
  /// anzulaufen bringt nichts — die Anfragen werden ohnehin verzögert, kosten
  /// aber trotzdem Funkzeit.
  static const int bucketSelten = 40;

  /// Ab `moderate` drosselt das System wegen Wärme. Weiterzufunken heizt
  /// zusätzlich und verzerrt obendrein jede Messung im selben Zeitraum.
  static const int thermalGedrosselt = 2;

  /// Obergrenze der Streckung. Ohne Deckel würde bei mehreren zutreffenden
  /// Signalen ein Takt entstehen, bei dem die Funktion praktisch aussetzt —
  /// und ein Mitglied, das die App wieder öffnet, sähe minutenlang alte
  /// Daten, ohne zu verstehen warum.
  static const double maxFaktor = 8.0;

  const Energiepolitik._(this.stufe, this.faktor, this.begruendung);

  final Energiestufe stufe;

  /// Womit ein Grundintervall multipliziert wird.
  final double faktor;

  /// Welches Signal die Stufe bestimmt hat — landet im Protokoll, damit ein
  /// „warum aktualisiert die App gerade so selten" beantwortbar bleibt.
  final String begruendung;

  static const Energiepolitik standard =
      Energiepolitik._(Energiestufe.normal, 1.0, 'Ausgangszustand');

  /// Bestimmt die Politik aus dem Gerätezustand.
  ///
  /// [ladend] schlägt alles andere: am Ladegerät gibt es nichts zu sparen.
  /// Sonst gewinnt das restriktivste zutreffende Signal — nicht das
  /// häufigste, denn jedes einzelne ist für sich ein hinreichender Grund,
  /// zurückhaltend zu sein.
  factory Energiepolitik.ausZustand({
    required bool ladend,
    int? akkustand,
    bool? energiesparmodus,
    int? standbyBucket,
    int? thermalStatus,
    bool zaehlendesNetz = false,
  }) {
    if (ladend) {
      return const Energiepolitik._(
        Energiestufe.grosszuegig,
        1.0,
        'am Ladegerät',
      );
    }

    // (Faktor, Begründung) je zutreffendem Signal. Der grösste gewinnt.
    final gruende = <(double, String)>[];

    if (energiesparmodus == true) {
      gruende.add((4.0, 'Energiesparmodus'));
    }
    if (standbyBucket != null && standbyBucket >= bucketSelten) {
      gruende.add((4.0, 'Standby-Bucket $standbyBucket'));
    }
    if (thermalStatus != null && thermalStatus >= thermalGedrosselt) {
      gruende.add((4.0, 'thermische Drosselung ($thermalStatus)'));
    }
    if (akkustand != null) {
      if (akkustand <= schwelleKnapp) {
        gruende.add((4.0, 'Akku $akkustand %'));
      } else if (akkustand <= schwelleMittel) {
        gruende.add((2.0, 'Akku $akkustand %'));
      }
    }
    if (zaehlendesNetz) {
      // Mobilfunk kostet je Aufwachvorgang mehr als WLAN: das Modem muss aus
      // einem tieferen Ruhezustand hoch und hält danach länger nach.
      gruende.add((1.5, 'Mobilfunk'));
    }

    if (gruende.isEmpty) {
      return const Energiepolitik._(Energiestufe.normal, 1.0, 'unauffällig');
    }

    gruende.sort((a, b) => b.$1.compareTo(a.$1));
    final (faktor, grund) = gruende.first;
    final gedeckelt = math.min(faktor, maxFaktor);

    return Energiepolitik._(
      gedeckelt >= 4.0 ? Energiestufe.streng : Energiestufe.sparsam,
      gedeckelt,
      grund,
    );
  }

  /// Streckt [grundintervall] gemäss der Politik.
  ///
  /// Auf ganze Sekunden gerundet: krumme Millisekunden brächten nichts und
  /// erschwerten es dem System, mehrere Takte zu bündeln.
  Duration intervall(Duration grundintervall) {
    if (faktor == 1.0) return grundintervall;
    final sekunden = (grundintervall.inMilliseconds * faktor / 1000).round();
    return Duration(seconds: math.max(1, sekunden));
  }

  @override
  String toString() =>
      'Energiepolitik(${stufe.name}, ×$faktor, $begruendung)';
}
