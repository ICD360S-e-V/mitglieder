/// Was ein Tastendruck mit der Rechenzeile macht — ohne Oberfläche.
///
/// ⚠️ Bewusst von [RechnerDialog] getrennt. Hier sitzt die Zustandsmaschine
/// eines Rechners, und dort sitzen die Fehler, die niemand sieht: was ein
/// Rechenzeichen tut, wenn schon eines dasteht; was eine Ziffer tut, wenn
/// gerade ein Ergebnis auf dem Schirm steht; ob ein zweites Komma in dieselbe
/// Zahl darf. Durch eine Oberfläche geprüft wäre jeder dieser Fälle ein
/// Widget-Test mit Tippen und Pumpen — hier ist er eine Zeile.
///
/// ⚠️ Wortgleich übernommen aus der Vorsitzer-App
/// (`lib/utils/rechner_eingabe.dart`, PR #773 dort). Hier steht kein einziger
/// Text, den ein Mensch liest — nur Regeln —, deshalb war für die 28 Sprachen
/// dieser App an dieser Schicht nichts zu ändern. Wer dort etwas ändert,
/// ändert es hier mit: die beiden Fassungen dürfen nicht auseinanderlaufen,
/// sonst verhält sich dieselbe Taste in zwei Apps verschieden.
library;

import 'rechner_ausdruck.dart';

/// Die Rechenzeile und die Frage, ob sie gerade ein **Ergebnis** zeigt.
///
/// ⚠️ [ausdruck] ist immer die einzige Wahrheit — auch nach einem `=`. Dort
/// steht dann die Rohfassung des Ergebnisses ([rechnerZahlRoh]), nicht eine
/// zweite, daneben geführte Zahl. Zwei Stellen, die dasselbe behaupten, laufen
/// auseinander; hier gibt es nur eine, und [nachErgebnis] sagt lediglich, wie
/// die nächste Taste sie zu lesen hat.
class RechnerStand {
  const RechnerStand({this.ausdruck = '', this.nachErgebnis = false});

  final String ausdruck;

  /// Das zuletzt Geschehene war ein `=`. Eine Ziffer fängt dann von vorn an,
  /// ein Rechenzeichen rechnet weiter.
  final bool nachErgebnis;

  bool get istLeer => ausdruck.isEmpty;

  static const _ziffern = '0123456789';
  static const _rechenzeichen = '+-×÷';

  String get _letztes => ausdruck.isEmpty ? '' : ausdruck[ausdruck.length - 1];

  /// Wie viele Klammern noch offen sind.
  int get offeneKlammern =>
      '('.allMatches(ausdruck).length - ')'.allMatches(ausdruck).length;

  /// Endet die Zeile auf etwas, hinter das ein `)` oder ein `×` passt?
  ///
  /// ⚠️ **`ausdruck.isNotEmpty` ist hier Pflicht, nicht Vorsicht.** In Dart
  /// gibt `'0123456789'.contains('')` **`true`** zurück — die leere Zeile
  /// galt damit als „endet auf einer Zahl". Gemessen hiess das: die erste
  /// Klammertaste schrieb `×(` statt `(`, und `%` liess sich auf eine leere
  /// Zeile setzen. Beides sah nach einem Bedienfehler aus, nicht nach einem
  /// Programmfehler.
  bool get _endetAufWert =>
      ausdruck.isNotEmpty &&
      (_ziffern.contains(_letztes) || _letztes == ')' || _letztes == '%');

  RechnerStand _mit(String neu, {bool nachErgebnis = false}) =>
      RechnerStand(ausdruck: neu, nachErgebnis: nachErgebnis);

  // ──────────────────────────────────────────────────────────────
  // Die einzelnen Tasten
  // ──────────────────────────────────────────────────────────────

  RechnerStand ziffer(String z) {
    // Nach einem Ergebnis beginnt eine Ziffer eine NEUE Rechnung. Anzuhängen
    // hiesse, aus dem Ergebnis 14 und einer 5 die Zahl 145 zu machen — und
    // niemand tippt eine Ziffer, um ein Ergebnis zu verlängern.
    if (nachErgebnis) return _mit(z);
    return _mit(ausdruck + z);
  }

  RechnerStand komma() {
    if (nachErgebnis) return _mit('0,');
    // Kein zweites Komma in dieselbe Zahl.
    if (_laufendeZahlHatKomma()) return this;
    // „,5“ ist keine Zahl; daraus wird „0,5“.
    if (ausdruck.isEmpty || !_ziffern.contains(_letztes)) {
      return _mit('${ausdruck}0,');
    }
    return _mit('$ausdruck,');
  }

  bool _laufendeZahlHatKomma() {
    for (var k = ausdruck.length - 1; k >= 0; k--) {
      final z = ausdruck[k];
      if (z == ',') return true;
      if (!_ziffern.contains(z)) return false;
    }
    return false;
  }

  /// Ein Rechenzeichen: `+`, `-`, `×` oder `÷`.
  RechnerStand rechenzeichen(String op) {
    // Nach einem Ergebnis wird weitergerechnet — die Zeile trägt bereits die
    // Rohfassung des Ergebnisses, es wird also nur angehängt.
    if (nachErgebnis) return _mit(ausdruck + op);

    if (ausdruck.isEmpty) {
      // Nur das Minus darf eine Rechnung eröffnen: `-5` ist eine Zahl,
      // `×5` ist nichts.
      return op == '-' ? _mit(op) : this;
    }
    // Steht schon ein Rechenzeichen da, wird es ERSETZT statt angehängt —
    // wer sich vertippt, drückt die richtige Taste und erwartet nicht, dass
    // beide stehen bleiben.
    //
    // ⚠️ Eine Ausnahme: hinter `×` oder `÷` ist ein `-` kein Ersatz, sondern
    // ein Vorzeichen. `5×-3` ist eine gültige Rechnung und soll möglich sein.
    if (_rechenzeichen.contains(_letztes)) {
      if (op == '-' && (_letztes == '×' || _letztes == '÷')) {
        return _mit(ausdruck + op);
      }
      return _mit(ausdruck.substring(0, ausdruck.length - 1) + op);
    }
    // Hinter einer offenen Klammer beginnt eine neue Rechnung.
    if (_letztes == '(') return op == '-' ? _mit(ausdruck + op) : this;
    return _mit(ausdruck + op);
  }

  /// Die Klammertaste entscheidet selbst, welche Klammer gemeint ist.
  ///
  /// ⚠️ Hinter einer Zahl OHNE offene Klammer wird `×(` eingefügt, nicht `(`.
  /// Der Rechenkern kennt keine unausgesprochene Multiplikation — `5(2+3)`
  /// wäre für ihn ein Fehler, und zwar erst beim `=`, also lange nachdem man
  /// die Klammer gedrückt hat. Das `×` steht sichtbar in der Zeile; geraten
  /// wird nichts.
  RechnerStand klammer() {
    if (nachErgebnis) return _mit('(');
    if (_endetAufWert && offeneKlammern > 0) return klammerZu();
    return klammerAuf();
  }

  /// Ausdrücklich eine öffnende Klammer — so kommt sie von der Tastatur.
  ///
  /// ⚠️ Der Bildschirm hat nur EINE Klammertaste, die Tastatur hat zwei. Ohne
  /// diesen Weg täte `(` am Schreibtisch schlicht nichts: `rechnerTaste` wäre
  /// in den Zweig für Unbekanntes gelaufen und hätte die Zeile unverändert
  /// gelassen — eine Taste, die nicht klemmt, aber auch nichts tut.
  RechnerStand klammerAuf() {
    if (nachErgebnis) return _mit('(');
    return _endetAufWert ? _mit('$ausdruck×(') : _mit('$ausdruck(');
  }

  /// Ausdrücklich eine schliessende Klammer. Ohne offene Klammer und ohne
  /// Zahl davor geschieht nichts — `)` allein ist keine Rechnung.
  RechnerStand klammerZu() {
    if (nachErgebnis || !_endetAufWert || offeneKlammern <= 0) return this;
    return _mit('$ausdruck)');
  }

  RechnerStand prozent() {
    // Prozent braucht eine Zahl davor — hinter einem Rechenzeichen oder am
    // Anfang bedeutet es nichts.
    if (!_endetAufWert) return this;
    return _mit('$ausdruck%', nachErgebnis: false);
  }

  /// Vorzeichen der zuletzt getippten Zahl umdrehen.
  RechnerStand vorzeichen() {
    if (ausdruck.isEmpty) return _mit('-');

    // Anfang der abschliessenden Zahl suchen.
    var start = ausdruck.length;
    while (start > 0 &&
        (_ziffern.contains(ausdruck[start - 1]) || ausdruck[start - 1] == ',')) {
      start--;
    }
    // Die Zeile endet gar nicht auf einer Zahl (z. B. auf `(` oder `+`):
    // dann eröffnet das Minus die nächste.
    if (start == ausdruck.length) {
      return _mit('$ausdruck-', nachErgebnis: nachErgebnis);
    }

    // Steht direkt davor ein Minus, das selbst ein VORZEICHEN ist (also am
    // Anfang, hinter `(` oder hinter einem Rechenzeichen), wird es entfernt.
    // Andernfalls wäre `5-3` mit ± zu `53` geworden — das Minus dort ist eine
    // Rechnung, kein Vorzeichen.
    if (start > 0 && ausdruck[start - 1] == '-') {
      final davor = start >= 2 ? ausdruck[start - 2] : '';
      final istVorzeichen =
          start == 1 || davor == '(' || _rechenzeichen.contains(davor);
      if (istVorzeichen) {
        return _mit(
          ausdruck.substring(0, start - 1) + ausdruck.substring(start),
          nachErgebnis: nachErgebnis,
        );
      }
    }
    return _mit(
      '${ausdruck.substring(0, start)}-${ausdruck.substring(start)}',
      nachErgebnis: nachErgebnis,
    );
  }

  /// Ein Zeichen zurück.
  ///
  /// ⚠️ Auch nach einem `=`. Das Ergebnis wird dann zu einer ganz gewöhnlichen
  /// Eingabe, an der man weiterschreibt — genau das erwartet man, wenn man
  /// sich in der letzten Stelle vertippt hat. Ein `⌫`, das nach dem `=` nichts
  /// tut, sieht aus wie eine klemmende Taste.
  RechnerStand rueck() {
    if (ausdruck.isEmpty) return const RechnerStand();
    return _mit(ausdruck.substring(0, ausdruck.length - 1));
  }

  RechnerStand alles() => const RechnerStand();

  /// Ergebnis übernehmen: die Zeile trägt danach die Rohfassung der Zahl.
  RechnerStand mitErgebnis(double wert) =>
      RechnerStand(ausdruck: rechnerZahlRoh(wert), nachErgebnis: true);
}

/// Alle Tasten, die der Rechner kennt — Tastatur wie Bildschirm gehen hier
/// hindurch.
///
/// ⚠️ EIN Weg für beide. Ohne das hätte die Tastatur eigene Regeln bekommen
/// (und damit einen eigenen Satz Fehler), und ein Vertippen am Schreibtisch
/// hätte sich anders verhalten als derselbe Griff auf dem Tablet.
RechnerStand rechnerTaste(RechnerStand stand, String taste) {
  const ziffern = '0123456789';
  if (ziffern.contains(taste) && taste.length == 1) return stand.ziffer(taste);
  switch (taste) {
    case ',':
    case '.':
      return stand.komma();
    case '+':
    case '-':
    case '×':
    case '÷':
      return stand.rechenzeichen(taste);
    case '%':
      return stand.prozent();
    case '()':
      return stand.klammer();
    case '(':
      return stand.klammerAuf();
    case ')':
      return stand.klammerZu();
    case '±':
      return stand.vorzeichen();
    case '⌫':
      return stand.rueck();
    case 'AC':
      return stand.alles();
    default:
      // Ein unbekanntes Zeichen ändert nichts. Es einfach anzuhängen hiesse,
      // die Rechenzeile für jede gedrückte Taste zu öffnen — und der Fehler
      // fiele erst beim `=` auf.
      return stand;
  }
}
