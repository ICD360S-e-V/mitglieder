/// Der Rechenkern des Taschenrechners — Auswertung und Darstellung.
///
/// Bewusst OHNE Oberfläche und ohne Netz: hier steht nur, was aus einer
/// Zeichenkette eine Zahl macht. Das ist der Teil, der falsch sein kann, ohne
/// dass es auffällt — eine Ziffer zu viel im Ergebnis sieht genauso aus wie
/// eine richtige —, und deshalb der Teil, der einzeln geprüft wird.
///
/// ⚠️ Übernommen aus der Vorsitzer-App (`lib/utils/rechner_ausdruck.dart`,
/// PR #773 dort) mit EINER Abweichung: ein Fehler ist hier kein deutscher
/// Satz, sondern ein [RechnerFehler]. Diese App spricht 28 Sprachen; ein
/// fest eingebauter Satz wäre für 27 davon die falsche Auskunft. Übersetzt
/// wird im Dialog, gerechnet wird hier — und damit bleibt dieser Kern auch
/// frei von `AppLocalizations`, also einzeln prüfbar ohne Widget.
library;

// ⚠️ **PUNKT VOR STRICH, nicht von links nach rechts.**
//
// Ein Taschenrechner aus Plastik rechnet `2 + 3 × 4` von links nach rechts
// und kommt auf **20**. Dieser hier hält sich an die Vorrangregel und kommt
// auf **14**. Das ist eine Entscheidung, keine Nachlässigkeit:
//
// * Die Zeile steht sichtbar auf dem Schirm, man liest sie also als
//   geschriebene Rechnung — und geschrieben gilt Punkt vor Strich.
// * Wer die andere Reihenfolge will, kann sie mit Klammern erzwingen;
//   umgekehrt geht es nicht.
//
// Wer das je umstellt, stellt damit auch jede gespeicherte Zeile im Verlauf
// um: dort steht der Ausdruck, nicht das Ergebnis, und derselbe Ausdruck
// ergäbe danach etwas anderes.
//
// Der Satz dazu steht als `rechnerVorrang` in den Sprachdateien.

// ⚠️ **Prozent hängt vom Zeichen davor ab** — so, wie es die Rechner auf
// Telefon und Rechner seit jeher machen, und so, wie man es für eine
// Mehrwertsteuer braucht:
//
// | Eingabe        | Ergebnis | Lesart                    |
// |----------------|----------|---------------------------|
// | `120 + 19 %`   | 142,8    | 19 % **von 120** dazu     |
// | `120 − 19 %`   | 97,2     | 19 % **von 120** weg      |
// | `500 × 19 %`   | 95       | 19 % **von 500**          |
// | `200 ÷ 10 %`   | 2000     | „200 sind 10 % wovon?"    |
// | `19 %`         | 0,19     | allein: schlicht ÷ 100    |
//
// ⚠️ Die ersten beiden Zeilen gelten nur, wenn rechts vom `+`/`−` **genau
// eine** Prozentzahl steht. In `100 + 2 × 10 %` ist das nicht der Fall; dort
// heisst `%` schlicht ÷ 100. Alles andere wäre geraten — welcher Wert dort
// die Bezugsgrösse sein soll, sagt der Ausdruck nicht.
/// Warum eine Rechnung nicht aufgeht.
///
/// ⚠️ Ein Code und kein Satz. In der Vorsitzer-App steht hier deutscher Text,
/// weil die App einsprachig ist; diese hier nicht. Der Dialog setzt den Code
/// in die Sprache des Mitglieds um.
enum RechnerFehler {
  /// Das Ergebnis passt in keine Gleitkommazahl mehr.
  zuGross,

  /// `)` ohne ein `(` davor.
  klammerOhneAnfang,

  /// `(` ohne ein `)` danach.
  klammerNichtGeschlossen,

  /// Geteilt durch null.
  divisionDurchNull,

  /// Die Zeile hört mitten in der Rechnung auf.
  unvollstaendig,

  /// Ein Zeichen, mit dem der Kern nichts anfangen kann. [RechnerErgebnis.detail]
  /// trägt dann das Zeichen selbst.
  unerwartetesZeichen,

  /// Ziffern, die zusammen keine Zahl ergeben. [RechnerErgebnis.detail] trägt
  /// die Zeichenfolge.
  keineZahl,
}

/// Ergebnis einer Auswertung: entweder eine Zahl oder ein Grund, warum nicht.
///
/// ⚠️ Zwei Zustände, nie einer. Ein `double?` mit `null` für den Fehlerfall
/// hätte bedeutet, dass der Bildschirm „geht nicht" sagt, ohne sagen zu
/// können warum — und bei einem Rechner ist das Warum die ganze Auskunft.
class RechnerErgebnis {
  const RechnerErgebnis.wert(double this.wert)
      : fehler = null,
        detail = null;
  const RechnerErgebnis.fehler(RechnerFehler this.fehler, [this.detail])
      : wert = null;

  final double? wert;
  final RechnerFehler? fehler;

  /// Das beanstandete Zeichen bzw. die beanstandete Zeichenfolge — nur bei
  /// [RechnerFehler.unerwartetesZeichen] und [RechnerFehler.keineZahl].
  final String? detail;

  bool get istFehler => fehler != null;
}

/// Alles, was als Dezimaltrennzeichen durchgeht.
///
/// ⚠️ Beides, und das ist kein Schlendrian: eine angeschlossene Tastatur
/// liefert auf dem Ziffernblock je nach Belegung `,` **oder** `.`, und wer vom
/// Ziffernblock tippt, sieht nicht hin. Ein Rechner, der bei `.` stumm nichts
/// tut, wirkt kaputt.
const String _dezimalZeichen = ',.';

/// Gleichwertige Schreibweisen der vier Rechenzeichen.
///
/// ⚠️ Die Tastatur hat kein `×` und kein `÷`. Ohne diese Tabelle wäre der
/// Rechner am Schreibtisch nur mit der Maus bedienbar — und diese App läuft
/// auch auf Windows, Linux und macOS.
const Map<String, String> rechnerZeichenErsatz = {
  '*': '×',
  'x': '×',
  'X': '×',
  '/': '÷',
  ':': '÷',
  '−': '-', // U+2212, das typografische Minus
  '·': '×',
};

/// Wandelt Tastatureingaben in die Zeichen um, mit denen der Kern rechnet.
String rechnerZeichenNormalisieren(String eingabe) {
  final b = StringBuffer();
  for (final z in eingabe.split('')) {
    b.write(rechnerZeichenErsatz[z] ?? z);
  }
  return b.toString();
}

// ──────────────────────────────────────────────────────────────────
// Auswertung
// ──────────────────────────────────────────────────────────────────

/// Wertet [ausdruck] aus. Leere Eingabe ergibt 0, keinen Fehler.
RechnerErgebnis rechnerAuswerten(String ausdruck) {
  final text = rechnerZeichenNormalisieren(ausdruck).trim();
  if (text.isEmpty) return const RechnerErgebnis.wert(0);
  try {
    final p = _Parser(text);
    final wert = p.ausdruck().wert;
    p.erwarteEnde();
    if (!wert.isFinite) {
      return const RechnerErgebnis.fehler(RechnerFehler.zuGross);
    }
    return RechnerErgebnis.wert(rechnerRunden(wert));
  } on _RechenFehler catch (e) {
    return RechnerErgebnis.fehler(e.art, e.detail);
  }
}

class _RechenFehler implements Exception {
  _RechenFehler(this.art, [this.detail]);
  final RechnerFehler art;
  final String? detail;
}

/// Wert eines Teilausdrucks plus die Angabe, ob er aus **genau einer**
/// Prozentzahl bestand — davon hängt ab, was `+ 19 %` bedeutet.
class _Teil {
  const _Teil(this.wert, {this.nurProzent = false});
  final double wert;
  final bool nurProzent;
}

class _Parser {
  _Parser(this.s);
  final String s;
  int i = 0;

  void _leerzeichen() {
    while (i < s.length && s[i] == ' ') {
      i++;
    }
  }

  bool _istDa(String zeichen) {
    _leerzeichen();
    return i < s.length && s[i] == zeichen;
  }

  void erwarteEnde() {
    _leerzeichen();
    if (i < s.length) {
      if (s[i] == ')') throw _RechenFehler(RechnerFehler.klammerOhneAnfang);
      throw _RechenFehler(RechnerFehler.unerwartetesZeichen, s[i]);
    }
  }

  /// ausdruck := term (('+' | '-') term)*
  _Teil ausdruck() {
    var links = term();
    while (true) {
      _leerzeichen();
      if (i >= s.length) break;
      final op = s[i];
      if (op != '+' && op != '-') break;
      i++;
      final rechts = term();
      // ⚠️ Hier sitzt die Prozentregel: nur wenn rechts GENAU eine
      // Prozentzahl steht, ist sie „vom Wert davor". Sonst ist sie ÷ 100,
      // und dann rechnet die Zeile darunter ganz gewöhnlich.
      final summand =
          rechts.nurProzent ? links.wert * rechts.wert : rechts.wert;
      links = _Teil(op == '+' ? links.wert + summand : links.wert - summand);
    }
    return links;
  }

  /// term := faktor (('×' | '÷') faktor)*
  _Teil term() {
    var links = faktor();
    var einzeln = true;
    while (true) {
      _leerzeichen();
      if (i >= s.length) break;
      final op = s[i];
      if (op != '×' && op != '÷') break;
      i++;
      einzeln = false;
      final rechts = faktor();
      if (op == '×') {
        links = _Teil(links.wert * rechts.wert);
      } else {
        if (rechts.wert == 0) {
          throw _RechenFehler(RechnerFehler.divisionDurchNull);
        }
        links = _Teil(links.wert / rechts.wert);
      }
    }
    // Ein Term ist nur dann „reine Prozentzahl", wenn er aus einem einzigen
    // Faktor bestand — `2 × 10 %` ist keine.
    return einzeln ? links : _Teil(links.wert);
  }

  /// faktor := ('+' | '-')* primaer '%'*
  _Teil faktor() {
    _leerzeichen();
    var negativ = false;
    while (i < s.length && (s[i] == '+' || s[i] == '-')) {
      if (s[i] == '-') negativ = !negativ;
      i++;
      _leerzeichen();
    }
    var wert = primaer();
    var prozent = false;
    while (_istDa('%')) {
      i++;
      wert = wert / 100;
      prozent = true;
    }
    return _Teil(negativ ? -wert : wert, nurProzent: prozent);
  }

  double primaer() {
    _leerzeichen();
    if (i >= s.length) throw _RechenFehler(RechnerFehler.unvollstaendig);

    if (s[i] == '(') {
      i++;
      final innen = ausdruck();
      _leerzeichen();
      if (i >= s.length || s[i] != ')') {
        throw _RechenFehler(RechnerFehler.klammerNichtGeschlossen);
      }
      i++;
      return innen.wert;
    }

    final start = i;
    var punktGesehen = false;
    while (i < s.length) {
      final z = s[i];
      if (z.codeUnitAt(0) >= 0x30 && z.codeUnitAt(0) <= 0x39) {
        i++;
      } else if (_dezimalZeichen.contains(z) && !punktGesehen) {
        punktGesehen = true;
        i++;
      } else {
        break;
      }
    }
    if (i == start) {
      throw _RechenFehler(RechnerFehler.unerwartetesZeichen, s[i]);
    }

    // ⚠️ **Exponent mitlesen, sonst bricht das Weiterrechnen.**
    // Ein großes Ergebnis wird als `9,9999999998E+21` angezeigt, und wer
    // danach `+ 1` drückt, schickt genau diese Zeichenkette wieder herein.
    // Ohne diesen Zweig wäre die Antwort „Unerwartetes Zeichen: E" — der
    // Rechner hätte sein eigenes Ergebnis nicht mehr lesen können.
    var expEnde = i;
    if (i < s.length && (s[i] == 'E' || s[i] == 'e')) {
      var k = i + 1;
      if (k < s.length && (s[k] == '+' || s[k] == '-')) k++;
      final zifferStart = k;
      while (k < s.length &&
          s.codeUnitAt(k) >= 0x30 &&
          s.codeUnitAt(k) <= 0x39) {
        k++;
      }
      // Nur übernehmen, wenn nach dem `E` wirklich Ziffern stehen — sonst
      // wäre `5E` eine Zahl, und das ist keine.
      if (k > zifferStart) {
        expEnde = k;
        i = k;
      }
    }

    final roh = s.substring(start, expEnde).replaceAll(',', '.');
    // „5." ist beim Tippen ein Zwischenstand, kein Fehler.
    final zahl = double.tryParse(
        roh.endsWith('.') ? '${roh}0' : roh.replaceFirst('.E', '.0E'));
    if (zahl == null) throw _RechenFehler(RechnerFehler.keineZahl, roh);
    return zahl;
  }
}

// ──────────────────────────────────────────────────────────────────
// Runden und Darstellen
// ──────────────────────────────────────────────────────────────────

/// Anzahl der Stellen, auf die jedes Ergebnis gerundet wird.
///
/// ⚠️ **Ohne diesen Schritt ist der Rechner sichtbar kaputt.** Gleitkommazahlen
/// rechnen im Binärsystem: `0,1 + 0,2` ergibt dort `0,30000000000000004`, und
/// genau das stünde auf dem Schirm. 12 geltende Stellen schneiden den Rest weg
/// und lassen zugleich genug für `1 ÷ 3` stehen.
const int rechnerGeltendeStellen = 12;

/// Rundet auf [rechnerGeltendeStellen] geltende Stellen.
double rechnerRunden(double wert) {
  if (!wert.isFinite || wert == 0) return wert;
  return double.parse(wert.toStringAsPrecision(rechnerGeltendeStellen));
}

/// Formatiert eine Zahl in deutscher Schreibweise: `1.234.567,89`.
///
/// ⚠️ **Die Stellenzahl wird NICHT ein zweites Mal hingeschrieben.** Der erste
/// Entwurf in der Vorsitzer-App hatte hier `toStringAsFixed(10)` und
/// `toStringAsExponential(9)` stehen — zwei von Hand gesetzte Zahlen neben dem
/// einen Budget in [rechnerGeltendeStellen]. Gemessen hat das drei Ergebnisse
/// verdorben, und keines davon sah nach einem Fehler aus:
///
/// * `1234567,89` wurde zu `1.234.567,8899999999` — die zehn Nachkommastellen
///   legten genau die Binärungenauigkeit wieder frei, die das Runden eben
///   beseitigt hatte;
/// * `1 ÷ 3` verlor zwei geltende Stellen;
/// * `99999999999 × 99999999999` wurde zu `1E+22` statt `9,9999999998E+21`.
///
/// Deshalb geht alles durch **einen** Aufruf von `toStringAsPrecision`. Der
/// entscheidet zugleich, ob die Zahl in die Exponentialschreibweise gehört —
/// eine zweite Schwelle dafür wäre die nächste Stelle gewesen, an der zwei
/// Angaben auseinanderlaufen.
///
/// ⚠️ Deutsche Schreibweise auch in den anderen 27 Sprachen, und das ist
/// Absicht: der Verein sitzt in Deutschland, jeder Betrag auf jedem Schreiben,
/// das ein Mitglied hier bekommt, steht so. Ein Rechner, der `1,234.57`
/// anzeigt, während der Bescheid daneben `1.234,57` sagt, stiftet genau die
/// Verwechslung, die er ausräumen sollte.
String rechnerZahlFormat(double wert) {
  if (wert.isNaN) return 'NaN';
  if (wert.isInfinite) return wert.isNegative ? '-∞' : '∞';
  if (wert == 0) return '0';

  final negativ = wert < 0;
  final roh = wert.abs().toStringAsPrecision(rechnerGeltendeStellen);

  // Dart wechselt selbst in die Exponentialschreibweise, sobald die Zahl
  // ausserhalb des Bereichs liegt, den [rechnerGeltendeStellen] noch voll
  // darstellen kann. Genau dort soll auch der Rechner wechseln, also wird
  // nicht geschwellt, sondern nachgesehen.
  if (roh.contains('e')) {
    final teile = roh.split('e');
    return '${negativ ? '-' : ''}${_nullenWeg(teile[0]).replaceAll('.', ',')}'
        'E${teile[1]}';
  }

  final schlank = _nullenWeg(roh);
  final punkt = schlank.indexOf('.');
  final ganz = punkt < 0 ? schlank : schlank.substring(0, punkt);
  final nach = punkt < 0 ? '' : schlank.substring(punkt + 1);

  final b = StringBuffer();
  for (var k = 0; k < ganz.length; k++) {
    if (k > 0 && (ganz.length - k) % 3 == 0) b.write('.');
    b.write(ganz[k]);
  }

  return '${negativ ? '-' : ''}$b${nach.isEmpty ? '' : ',$nach'}';
}

/// Schneidet Nachkommanullen weg — und den Punkt gleich mit, wenn nichts
/// bleibt. `2000.00000000` → `2000`, `0.300000000000` → `0.3`.
String _nullenWeg(String text) {
  if (!text.contains('.')) return text;
  var t = text.replaceFirst(RegExp(r'0+$'), '');
  if (t.endsWith('.')) t = t.substring(0, t.length - 1);
  return t;
}

/// Setzt Tausenderpunkte in die **Eingabezeile**, ohne sie sonst anzutasten.
///
/// ⚠️ Nur in Ziffernfolgen VOR dem Komma, und die Rechenzeichen bleiben stehen
/// wie getippt. Die Zeile ist das, was der Mensch geschrieben hat; sie wird
/// lesbarer gemacht, nicht umgeschrieben. Der Kern bekommt weiterhin die
/// ungeschminkte Fassung — [rechnerAuswerten] kennt keine Tausenderpunkte und
/// würde `1.234` sonst als `1,234` lesen.
String rechnerAusdruckFormat(String ausdruck) {
  final b = StringBuffer();
  var k = 0;
  while (k < ausdruck.length) {
    final z = ausdruck[k];
    if (z.codeUnitAt(0) < 0x30 || z.codeUnitAt(0) > 0x39) {
      b.write(z);
      k++;
      continue;
    }
    // Eine Ziffernfolge samt allem, was danach noch zur Zahl gehört.
    final start = k;
    while (k < ausdruck.length &&
        ausdruck.codeUnitAt(k) >= 0x30 &&
        ausdruck.codeUnitAt(k) <= 0x39) {
      k++;
    }
    final ziffern = ausdruck.substring(start, k);
    final nachkomma = start > 0 && _dezimalZeichen.contains(ausdruck[start - 1]);
    if (nachkomma) {
      b.write(ziffern);
    } else {
      for (var m = 0; m < ziffern.length; m++) {
        if (m > 0 && (ziffern.length - m) % 3 == 0) b.write('.');
        b.write(ziffern[m]);
      }
    }
  }
  return b.toString();
}

/// Dieselbe Zahl, aber so, dass [rechnerAuswerten] sie wieder lesen kann.
///
/// ⚠️ **Das ist der Wert, mit dem nach einem `=` weitergerechnet wird — und
/// zwar der GERUNDETE.** Weiterzurechnen wäre mit dem vollen `double`
/// genauer, aber dann stünde auf dem Schirm `0,3` und im Rechner
/// `0,30000000000000004`: die nächste Zeile ergäbe etwas, das zu der
/// angezeigten Zahl nicht passt, und niemand könnte nachvollziehen warum.
/// Was man sieht, ist was gerechnet wird.
///
/// ⚠️ Es werden nur die Tausenderpunkte entfernt, das Komma bleibt — der
/// Leser in [rechnerAuswerten] nimmt `,` als Dezimaltrennzeichen. Die
/// Exponentialschreibweise trägt keine Tausenderpunkte und geht unverändert
/// durch; dass sie wieder gelesen werden kann, dafür sorgt der Zweig für `E`
/// im Zahlenleser.
String rechnerZahlRoh(double wert) {
  if (!wert.isFinite) return '0';
  return rechnerZahlFormat(wert).replaceAll('.', '');
}
