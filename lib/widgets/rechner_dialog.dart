import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../utils/app_theme.dart';
import '../utils/rechner_ausdruck.dart';
import '../utils/rechner_eingabe.dart';

/// Öffnet den Taschenrechner.
Future<void> zeigeRechner(BuildContext context) => showDialog<void>(
      context: context,
      builder: (_) => const RechnerDialog(),
    );

/// Der Taschenrechner aus den Sonderfunktionen.
///
/// ⚠️ **Er rechnet ohne Netz.** Auf dem Server liegt einzig der Verlauf; die
/// Rechnung selbst entsteht im Gerät. Ein Netzwackler darf das Rechnen
/// deshalb weder aufhalten noch scheitern lassen — und „Verlauf nicht ladbar"
/// ist etwas anderes als „Verlauf ist leer". Beides steht unten ausdrücklich
/// auf dem Schirm.
///
/// ⚠️ Übernommen aus der Vorsitzer-App (PR #773, #775, #776 dort). Angepasst
/// wurde dreierlei und sonst nichts:
///
///  * jeder Text kommt aus den Sprachdateien statt fest aus dem Quelltext —
///    diese App spricht 28 Sprachen;
///  * die Farben kommen aus `context.colors` statt aus `F`, damit der
///    dunkle Modus trägt;
///  * er hängt in den Sonderfunktionen und nicht in der Kopfleiste. Dort
///    stehen schon sechs Schaltflächen, und die Leiste bricht auf einem
///    320 dp breiten Telefon als Erste.
class RechnerDialog extends StatefulWidget {
  const RechnerDialog({super.key, this.api});

  /// Naht für die Prüfmappe — sonst wird der echte Dienst genommen.
  final ApiService? api;

  @override
  State<RechnerDialog> createState() => _RechnerDialogState();
}

class _RechnerDialogState extends State<RechnerDialog> {
  RechnerStand _stand = const RechnerStand();

  /// Der Fehler des letzten `=`. Beim Tippen bleibt er leer — eine Meldung,
  /// die bei jeder halb getippten Rechnung aufblitzt, liest niemand mehr.
  ///
  /// ⚠️ Der Code, nicht der Satz: übersetzt wird erst beim Zeichnen, weil erst
  /// dort ein `BuildContext` und damit die Sprache des Mitglieds vorliegt.
  RechnerFehler? _fehler;
  String? _fehlerDetail;

  final _zeileStrom = ScrollController();
  final _tastenFokus = FocusNode();

  ApiService get _api => widget.api ?? ApiService();

  // ── Verlauf ────────────────────────────────────────────────────
  bool _zeigtVerlauf = false;
  bool _verlaufLaedt = false;

  /// ⚠️ Drei Zustände, nicht zwei: `null` heisst **noch nicht geladen oder
  /// nicht erreichbar**, eine leere Liste heisst **wirklich nichts da**. Als
  /// ein Feld hätte der Schirm bei einem Netzfehler „noch nichts gerechnet"
  /// behauptet — eine Aussage über Daten, die niemand gesehen hat.
  List<Map<String, dynamic>>? _verlauf;
  String? _verlaufFehler;

  /// Wie viele Rechnungen dieser Sitzung NICHT gespeichert werden konnten.
  ///
  /// ⚠️ Eine Zahl und kein blosses Ja/Nein: „eine Rechnung fehlt" und „der
  /// ganze Nachmittag fehlt" sind zwei verschiedene Auskünfte.
  int _ungespeichert = 0;
  String? _speicherFehler;

  /// Die Rechnung, die zum angezeigten Ergebnis geführt hat.
  ///
  /// ⚠️ **Ohne sie stand dieselbe Zahl zweimal auf dem Schirm.** Nach einem
  /// `=` trägt [RechnerStand.ausdruck] die Rohfassung des Ergebnisses — die
  /// kleine Zeile darüber hätte also `142,8` gezeigt und die grosse darunter
  /// noch einmal `142,8`. Zwei Zeilen, die dasselbe behaupten, sagen zusammen
  /// weniger als eine: die interessante Auskunft ist, WAS gerechnet wurde.
  String? _letzteRechnung;

  @override
  void dispose() {
    _zeileStrom.dispose();
    _tastenFokus.dispose();
    super.dispose();
  }

  /// Setzt einen Fehlercode in die Sprache des Mitglieds um.
  String _fehlerText(AppLocalizations l10n, RechnerFehler f, String? detail) {
    switch (f) {
      case RechnerFehler.zuGross:
        return l10n.rechnerFehlerZuGross;
      case RechnerFehler.klammerOhneAnfang:
        return l10n.rechnerFehlerKlammerOhneAnfang;
      case RechnerFehler.klammerNichtGeschlossen:
        return l10n.rechnerFehlerKlammerOffen;
      case RechnerFehler.divisionDurchNull:
        return l10n.rechnerFehlerDurchNull;
      case RechnerFehler.unvollstaendig:
        return l10n.rechnerFehlerUnvollstaendig;
      case RechnerFehler.unerwartetesZeichen:
        return l10n.rechnerFehlerZeichen(detail ?? '?');
      case RechnerFehler.keineZahl:
        return l10n.rechnerFehlerKeineZahl(detail ?? '?');
    }
  }

  // ──────────────────────────────────────────────────────────────
  // Tasten
  // ──────────────────────────────────────────────────────────────

  void _druck(String taste) {
    // Auf dem Gerät ein kurzer Anschlag — auf dem Rechner tut das nichts und
    // schadet nichts.
    unawaited(HapticFeedback.selectionClick());

    if (taste == '=') {
      _gleich();
      return;
    }
    setState(() {
      _stand = rechnerTaste(_stand, taste);
      _fehler = null;
      _fehlerDetail = null;
      // Sobald wieder getippt wird, ist die alte Rechnung nicht mehr das,
      // was auf dem Schirm steht.
      if (!_stand.nachErgebnis) _letzteRechnung = null;
    });
    _zeileAnsEnde();
  }

  void _gleich() {
    if (_stand.istLeer) return;
    final e = rechnerAuswerten(_stand.ausdruck);
    if (e.istFehler) {
      setState(() {
        _fehler = e.fehler;
        _fehlerDetail = e.detail;
      });
      return;
    }
    final ausdruck = _stand.ausdruck;
    setState(() {
      _fehler = null;
      _fehlerDetail = null;
      _letzteRechnung = ausdruck;
      _stand = _stand.mitErgebnis(e.wert!);
    });
    _merken(ausdruck, e.wert!);
  }

  /// Rechnung in den Verlauf schreiben.
  ///
  /// ⚠️ Nur ECHTE Rechnungen. Wer eine Zahl eintippt und `=` drückt, hat nicht
  /// gerechnet — stünde das im Verlauf, wäre er nach einem Nachmittag voller
  /// Zahlen ohne Zusammenhang.
  void _merken(String ausdruck, double wert) {
    if (!_istRechnung(ausdruck)) return;
    final ergebnis = rechnerZahlFormat(wert);
    final nichtErreichbar = AppLocalizations.of(context)!.rechnerNichtErreichbar;
    // ⚠️ `unawaited`: ein misslungenes Speichern darf das Rechnen nicht
    // anhalten — gerechnet wird im Gerät, der Verlauf ist die Zugabe.
    //
    // 🔴 **Aber es darf auch nicht STUMM misslingen.** In der Vorsitzer-App
    // stand hier zuerst „sichtbar wird es beim Öffnen des Verlaufs" — das war
    // falsch: dort stand dann eine erfolgreich geladene, leere Liste mit dem
    // Satz „Noch nichts gerechnet". Also genau die Behauptung, die nicht
    // stimmt. Wer rechnet und später nichts wiederfindet, hält den Verlauf
    // für kaputt, und niemand kann sehen, dass bloss das Netz weg war.
    unawaited(() async {
      final a = await _api.rechnerVerlaufAktion(
        'add',
        {'ausdruck': ausdruck, 'ergebnis': ergebnis},
      );
      if (!mounted) return;
      if (a['success'] == true) {
        if (_zeigtVerlauf) await _verlaufLaden();
      } else {
        setState(() {
          _ungespeichert++;
          _speicherFehler = (a['message'] ?? nichtErreichbar).toString();
        });
      }
    }());
  }

  /// Ist das eine Rechnung — oder nur eine Zahl?
  ///
  /// ⚠️ **Das führende Vorzeichen und die Exponentialschreibweise gehören zur
  /// ZAHL, nicht zur Rechnung.** Der erste Entwurf prüfte schlicht, ob nach
  /// dem ersten Zeichen irgendwo ein `-` steht. Bei `-6` stimmte das; bei
  /// `1E-11` nicht — ein zweites `=` auf so einem Ergebnis hätte die blosse
  /// Zahl als „Rechnung" in den Verlauf geschrieben.
  static bool _istRechnung(String ausdruck) {
    var rest = ausdruck.startsWith('-') ? ausdruck.substring(1) : ausdruck;
    rest = rest.replaceAll(RegExp(r'[Ee][+-]?\d+'), '');
    return RegExp(r'[+\-×÷%]').hasMatch(rest);
  }

  void _zeileAnsEnde() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_zeileStrom.hasClients) return;
      _zeileStrom.jumpTo(_zeileStrom.position.maxScrollExtent);
    });
  }

  /// Der Ziffernblock, Taste für Taste.
  ///
  /// 🔴 **Gemessen: jede Taste des Ziffernblocks liefert `character == null`.**
  /// Der Rechner las Ziffern und Rechenzeichen zuerst ausschliesslich aus
  /// `KeyEvent.character` — damit war der ganze Block **tot**, und zwar
  /// ausgerechnet am Schreibtisch, wo er der natürliche Weg ist, eine Rechnung
  /// einzutippen.
  ///
  /// ⚠️ Über die **Tastenkennung** und nicht über das Zeichen: ob eine
  /// Plattform für den Block ein Zeichen mitschickt, hängt an der Belegung und
  /// an NumLock. Die Kennung kommt immer.
  /// ⚠️ `final`, nicht `const`: `LogicalKeyboardKey` überschreibt `==` und
  /// taugt damit nicht als Schlüssel einer konstanten Karte.
  static final _ziffernblock = <LogicalKeyboardKey, String>{
    LogicalKeyboardKey.numpad0: '0',
    LogicalKeyboardKey.numpad1: '1',
    LogicalKeyboardKey.numpad2: '2',
    LogicalKeyboardKey.numpad3: '3',
    LogicalKeyboardKey.numpad4: '4',
    LogicalKeyboardKey.numpad5: '5',
    LogicalKeyboardKey.numpad6: '6',
    LogicalKeyboardKey.numpad7: '7',
    LogicalKeyboardKey.numpad8: '8',
    LogicalKeyboardKey.numpad9: '9',
    LogicalKeyboardKey.numpadAdd: '+',
    LogicalKeyboardKey.numpadSubtract: '-',
    LogicalKeyboardKey.numpadMultiply: '×',
    LogicalKeyboardKey.numpadDivide: '÷',
    LogicalKeyboardKey.numpadDecimal: ',',
  };

  KeyEventResult _tastatur(FocusNode _, KeyEvent e) {
    // ⚠️ Auch `KeyRepeatEvent`: wer die Rücktaste hält, will löschen, nicht
    // ein Zeichen loswerden.
    if (e is! KeyDownEvent && e is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final k = e.logicalKey;
    if (k == LogicalKeyboardKey.backspace) {
      _druck('⌫');
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.enter || k == LogicalKeyboardKey.numpadEnter) {
      _druck('=');
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.delete) {
      _druck('AC');
      return KeyEventResult.handled;
    }
    // ⚠️ Escape wird NICHT abgefangen. Es schliesst überall in dieser
    // Anwendung den Dialog, und ein Rechner, der als einziger daran klebt,
    // wäre eine Falle. Zum Löschen gibt es Entf und `c`.
    if (k == LogicalKeyboardKey.escape) return KeyEventResult.ignored;

    // Der Ziffernblock ZUERST — er schickt kein Zeichen mit.
    final block = _ziffernblock[k];
    if (block != null) {
      _druck(block);
      return KeyEventResult.handled;
    }

    final z = e.character;
    if (z == null || z.isEmpty) return KeyEventResult.ignored;
    if (z == '=') {
      _druck('=');
      return KeyEventResult.handled;
    }
    if (z.toLowerCase() == 'c') {
      _druck('AC');
      return KeyEventResult.handled;
    }
    final norm = rechnerZeichenNormalisieren(z);
    if (norm.length == 1 && '0123456789,.+-×÷%()'.contains(norm)) {
      _druck(norm);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  // ──────────────────────────────────────────────────────────────
  // Verlauf
  // ──────────────────────────────────────────────────────────────

  Future<void> _verlaufLaden() async {
    final nichtErreichbar = AppLocalizations.of(context)!.rechnerNichtErreichbar;
    setState(() => _verlaufLaedt = true);
    final a = await _api.rechnerVerlaufAktion('list');
    if (!mounted) return;
    setState(() {
      _verlaufLaedt = false;
      if (a['success'] == true) {
        _verlaufFehler = null;
        _verlauf = (a['eintraege'] as List? ?? [])
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      } else {
        // ⚠️ Der bisherige Bestand bleibt stehen. Ihn bei einem Netzfehler zu
        // leeren hiesse, eine Liste zu löschen, die es noch gibt.
        _verlaufFehler = (a['message'] ?? nichtErreichbar).toString();
      }
    });
  }

  Future<void> _verlaufUmschalten() async {
    setState(() => _zeigtVerlauf = !_zeigtVerlauf);
    if (_zeigtVerlauf) await _verlaufLaden();
    _tastenFokus.requestFocus();
  }

  /// Eine einzelne Zeile löschen — **mit Rückfrage**.
  ///
  /// 🔴 **Ohne die Rückfrage war die Reihenfolge der Sicherungen verkehrt
  /// herum.** „Alles löschen" fragte nach, das Löschen einer EINZELNEN Zeile
  /// nicht — dabei ist gerade das der Griff, der danebengehen kann: die Zeile
  /// wird angetippt, um mit ihrem Ergebnis weiterzurechnen, und der Papierkorb
  /// liegt in denselben **48 dp am rechten Rand**, also in 13 % der
  /// Zeilenbreite. In der Vorsitzer-App wurde das an einem echten Vorfall
  /// gemessen (17.09.2026): im Serverprotokoll steht `list` mit einem Eintrag
  /// und drei Sekunden später ein `delete`.
  ///
  /// ⚠️ Die Rückfrage nennt die Rechnung selbst. „Eintrag löschen?" allein
  /// wäre eine Frage, die man nicht beantworten kann, ohne hinter den Dialog
  /// zu schauen.
  Future<void> _eintragLoeschen(Map<String, dynamic> e) async {
    final l10n = AppLocalizations.of(context)!;
    final id = e['id'] as int;
    final ja = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(l10n.rechnerZeileLoeschenFrage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rechnerAusdruckFormat((e['ausdruck'] ?? '').toString()),
              style: TextStyle(fontSize: 13, color: c.colors.textSecondary),
            ),
            Text(
              '= ${e['ergebnis'] ?? ''}',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: c.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(l10n.rechnerNichtRueckgaengig,
                style: TextStyle(fontSize: 12, color: c.colors.textTertiary)),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(l10n.cancel)),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            style: TextButton.styleFrom(foregroundColor: c.colors.dangerFg),
            child: Text(l10n.rechnerLoeschen),
          ),
        ],
      ),
    );
    if (ja != true) return;
    final a = await _api.rechnerVerlaufAktion('delete', {'id': id});
    if (!mounted) return;
    if (a['success'] == true) {
      setState(() => _verlauf?.removeWhere((z) => z['id'] == id));
    } else {
      _melde(a['message']?.toString() ?? l10n.rechnerLoeschenFehlgeschlagen);
    }
  }

  Future<void> _verlaufLeeren() async {
    final l10n = AppLocalizations.of(context)!;
    final ja = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(l10n.rechnerVerlaufLoeschenFrage),
        content: Text(l10n.rechnerVerlaufLoeschenText),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(l10n.cancel)),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            style: TextButton.styleFrom(foregroundColor: c.colors.dangerFg),
            child: Text(l10n.rechnerLoeschen),
          ),
        ],
      ),
    );
    if (ja != true) return;
    final a = await _api.rechnerVerlaufAktion('clear');
    if (!mounted) return;
    if (a['success'] == true) {
      setState(() => _verlauf = []);
    } else {
      _melde(a['message']?.toString() ?? l10n.rechnerLoeschenFehlgeschlagen);
    }
  }

  void _melde(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  /// Eine Zeile aus dem Verlauf zurückholen — mit dem ERGEBNIS weiterrechnen.
  ///
  /// ⚠️ Das Ergebnis und nicht der Ausdruck: wer eine alte Zeile antippt, will
  /// mit der Zahl weiterrechnen, die dabei herauskam. Den Ausdruck zu laden
  /// hiesse, ihn erst noch einmal auswerten zu lassen — und falls sich die
  /// Rechenregeln seither geändert hätten, käme dabei etwas anderes heraus als
  /// das, was danebensteht.
  void _uebernehmen(Map<String, dynamic> e) {
    final roh = (e['ergebnis'] ?? '').toString().replaceAll('.', '');
    if (roh.isEmpty) return;
    setState(() {
      _stand = RechnerStand(ausdruck: roh, nachErgebnis: true);
      _fehler = null;
      _fehlerDetail = null;
      _zeigtVerlauf = false;
    });
    _tastenFokus.requestFocus();
  }

  // ──────────────────────────────────────────────────────────────
  // Aufbau
  // ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.card,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Focus(
        focusNode: _tastenFokus,
        autofocus: true,
        onKeyEvent: _tastatur,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
            // Auf einem schmalen Schirm darf der Rechner nicht über den Rand
            // hinauswachsen; die Tastenfläche schrumpft dann mit.
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _kopf(),
              // ⚠️ Im Verlauf wird die Anzeige NICHT gebaut. Sie stand dort
              // mit einer einsamen „0" über der Liste und hinterliess rund
              // hundert Bildpunkte tote Fläche.
              if (!_zeigtVerlauf) _anzeige(),
              Flexible(
                child: _zeigtVerlauf ? _verlaufFlaeche() : _tastenfeld(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// „N Rechnungen konnten nicht gespeichert werden" — oder nichts.
  ///
  /// ⚠️ Steht in BEIDEN Ansichten. Im Verlauf, weil dort die Lücke auffällt;
  /// am Tastenfeld, weil dort gerechnet wird und niemand den Verlauf öffnet,
  /// um nachzusehen, ob das Speichern geklappt hat.
  Widget _ungespeichertHinweis() {
    if (_ungespeichert == 0) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.colors.warningBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.warningBorder),
      ),
      child: Row(children: [
        Icon(Icons.cloud_off, size: 16, color: context.colors.warningFg),
        const SizedBox(width: 8),
        Expanded(
          // ⚠️ Der GRUND steht dabei, in Klammern — wie im Band daneben, das
          // einen misslungenen Abruf meldet. „Nicht erreichbar" und
          // „Speichern fehlgeschlagen" sind zwei verschiedene Auskünfte: die
          // eine heisst warten, die andere nachsehen.
          child: Text(
            (_ungespeichert == 1
                    ? l10n.rechnerEineNichtGespeichert
                    : l10n.rechnerNichtGespeichert(_ungespeichert)) +
                (_speicherFehler == null ? '' : ' ($_speicherFehler)'),
            style: TextStyle(
                fontSize: 11.5,
                color: context.colors.warningFg,
                height: 1.3),
          ),
        ),
      ]),
    );
  }

  Widget _kopf() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 0),
      child: Row(
        children: [
          Icon(Icons.calculate_outlined,
              size: 18, color: context.colors.textSecondary),
          const SizedBox(width: 8),
          // ⚠️ `Expanded` statt `Text` + `Spacer`. Gemessen auf 320 dp: der
          // Titel neben zwei Schaltflächen lief um 72 Bildpunkte über den
          // rechten Rand, und zwar in JEDER Sprache — „Taschenrechner" ist
          // nicht einmal das längste der 28 Wörter. Mit dem Spacer bekam der
          // Titel seine natürliche Breite und nahm sie sich; so bekommt er,
          // was übrig ist, und kürzt notfalls.
          Expanded(
            child: Text(l10n.rechnerTitel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: context.colors.textPrimary)),
          ),
          IconButton(
            icon: Icon(
              _zeigtVerlauf ? Icons.calculate_outlined : Icons.history,
              size: 20,
            ),
            color: _zeigtVerlauf
                ? context.colors.brand
                : context.colors.textSecondary,
            tooltip: _zeigtVerlauf ? l10n.rechnerZurueck : l10n.rechnerVerlauf,
            onPressed: _verlaufUmschalten,
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            color: context.colors.textSecondary,
            tooltip: l10n.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// Rechenzeile oben, Ergebnis darunter.
  ///
  /// 🔴 **EIN ERGEBNIS ERSCHEINT ERST NACH DEM `=`.** Die erste Fassung in der
  /// Vorsitzer-App rechnete beim Tippen mit und zeigte den laufenden Wert grau
  /// an — bei `2+2` stand die 4 also schon da, bevor jemand `=` gedrückt
  /// hatte. Als unlogisch gemeldet, und zu Recht: ein Rechner, der antwortet,
  /// bevor er gefragt wurde, nimmt dem `=` seine Bedeutung — und bei einer
  /// halb getippten Rechnung (`120+1`, gemeint war `120+19%`) ist die
  /// Zwischenzahl eine Antwort auf eine Frage, die niemand gestellt hat.
  Widget _anzeige() {
    final l10n = AppLocalizations.of(context)!;
    // Oben: die Rechnung — aber erst, wenn sie gerechnet IST. Vorher steht
    // sie unten, gross.
    final oben = _stand.nachErgebnis
        ? rechnerAusdruckFormat(_letzteRechnung ?? _stand.ausdruck)
        : '';
    // Unten: nach dem `=` das Ergebnis, davor schlicht das Getippte.
    final gross =
        _stand.istLeer ? '0' : rechnerAusdruckFormat(_stand.ausdruck);
    final fehlerText = _fehler == null
        ? null
        : _fehlerText(l10n, _fehler!, _fehlerDetail);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Die gerechnete Zeile. Waagerecht rollbar, weil eine lange
          // Rechnung sonst umbräche und das Ergebnis aus dem Bild schöbe.
          //
          // ⚠️ Die Höhe steht fest, auch wenn hier nichts steht — sonst
          // sprängen beim `=` alle Tasten um eine Zeile nach unten.
          SizedBox(
            height: 23,
            width: double.infinity,
            child: SingleChildScrollView(
              controller: _zeileStrom,
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  oben,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.3,
                    color: context.colors.textTertiary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 52,
            child: Align(
              alignment: Alignment.centerRight,
              // ⚠️ `scaleDown` und nicht `contain`: eine kurze Zahl soll NICHT
              // auf Fensterbreite aufgeblasen werden. Lange Zahlen schrumpfen,
              // kurze bleiben, wie sie sind.
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  fehlerText ?? gross,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: fehlerText != null ? 20 : 40,
                    fontWeight: FontWeight.w300,
                    height: 1.1,
                    // ⚠️ Auch das Getippte steht STARK da. Grau wäre die Farbe
                    // für „vorläufig", und vorläufig ist hier nichts mehr: es
                    // ist genau das, was jemand geschrieben hat.
                    color: fehlerText != null
                        ? context.colors.dangerFg
                        : context.colors.textPrimary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
          ),
          if (_stand.nachErgebnis && _fehler == null)
            TextButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text: rechnerAusdruckFormat(_stand.ausdruck)));
                _melde(l10n.rechnerKopiert);
              },
              icon: const Icon(Icons.copy_rounded, size: 14),
              label:
                  Text(l10n.rechnerKopieren, style: const TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(
                foregroundColor: context.colors.textSecondary,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 28),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
        ],
      ),
    );
  }

  // ── Tastenfeld ────────────────────────────────────────────────

  static const _reihen = <List<String>>[
    ['AC', '()', '%', '⌫'],
    ['7', '8', '9', '÷'],
    ['4', '5', '6', '×'],
    ['1', '2', '3', '-'],
    ['±', '0', ',', '+'],
  ];

  Widget _tastenfeld() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final reihe in _reihen)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  for (var k = 0; k < reihe.length; k++) ...[
                    if (k > 0) const SizedBox(width: 8),
                    Expanded(child: _taste(reihe[k])),
                  ],
                ],
              ),
            ),
          // Das Gleichheitszeichen über die ganze Breite: es ist die Taste,
          // die am häufigsten und am eiligsten getroffen wird.
          SizedBox(
            width: double.infinity,
            height: _tastenHoehe,
            child: FilledButton(
              onPressed: () => _druck('='),
              style: FilledButton.styleFrom(
                backgroundColor: context.colors.brandFill,
                foregroundColor: context.colors.onBrandFill,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('=',
                  style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _ungespeichertHinweis(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              l10n.rechnerVorrang,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.5,
                  color: context.colors.textTertiary,
                  height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  static const double _tastenHoehe = 50;

  Widget _taste(String t) {
    final istZiffer = '0123456789,'.contains(t) && t.length == 1;
    final istRechenzeichen = '+-×÷'.contains(t) && t.length == 1;
    final istLoeschen = t == 'AC';

    final Color grund;
    final Color schrift;
    if (istZiffer) {
      grund = context.colors.cardSubtle;
      schrift = context.colors.textPrimary;
    } else if (istRechenzeichen) {
      grund = context.colors.infoBg;
      schrift = context.colors.infoFg;
    } else if (istLoeschen) {
      grund = context.colors.dangerBg;
      schrift = context.colors.dangerFg;
    } else {
      grund = context.colors.inputFill;
      schrift = context.colors.textSecondary;
    }

    // Die Klammertaste zeigt, was sie als Nächstes tut — sonst müsste man
    // raten, ob sie öffnet oder schliesst.
    final beschriftung = t == '()'
        ? (_stand.offeneKlammern > 0 &&
                !_stand.istLeer &&
                !'+-×÷('
                    .contains(_stand.ausdruck[_stand.ausdruck.length - 1])
            ? ')'
            : '(')
        : t;

    // ⚠️ **ZWEI Tasten tragen ein SINNBILD statt eines Zeichens, und beide aus
    // demselben gemessenen Grund.** Auf dem gerenderten Bild stand an der
    // Rücktaste ein leeres Kästchen: `⌫` (U+232B) fehlt in vielen Schriften.
    // Der erste Griff dagegen war, das Minus auf das typografische `−`
    // (U+2212) zu setzen — und **damit stand das Kästchen eine Taste weiter**.
    // Zwei Zeichen, zwei Schriftlücken. Material-Icons sind mitgeliefert; auf
    // ein Zeichen zu hoffen, das die Schrift des Geräts vielleicht hat, ist
    // kein Entwurf. `×` und `÷` bleiben Text: sie stehen in Latin-1 und sind
    // praktisch überall da.
    final Widget aufschrift = t == '⌫'
        ? Icon(Icons.backspace_outlined, size: 19, color: schrift)
        : t == '-'
            ? Icon(Icons.remove, size: 21, color: schrift)
            : Text(
                beschriftung,
                style: TextStyle(
                  fontSize: istZiffer ? 20 : 18,
                  fontWeight: istZiffer ? FontWeight.w500 : FontWeight.w600,
                  color: schrift,
                ),
              );

    return SizedBox(
      height: _tastenHoehe,
      child: Material(
        color: grund,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => _druck(t),
          child: Center(child: aufschrift),
        ),
      ),
    );
  }

  // ── Verlauf ───────────────────────────────────────────────────

  Widget _verlaufFlaeche() {
    final l10n = AppLocalizations.of(context)!;
    if (_verlaufLaedt && _verlauf == null) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    final eintraege = _verlauf ?? const <Map<String, dynamic>>[];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ungespeichertHinweis(),
        if (_verlaufFehler != null)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.colors.warningBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: context.colors.warningBorder),
            ),
            child: Row(children: [
              Icon(Icons.cloud_off,
                  size: 16, color: context.colors.warningFg),
              const SizedBox(width: 8),
              Expanded(
                // ⚠️ „nicht ladbar", NICHT „leer". Der Unterschied ist die
                // ganze Aussage: eine leere Liste hiesse, es sei nichts da.
                child: Text(
                  l10n.rechnerVerlaufNichtLadbar(_verlaufFehler!),
                  style: TextStyle(
                      fontSize: 11.5,
                      color: context.colors.warningFg,
                      height: 1.3),
                ),
              ),
            ]),
          ),
        if (eintraege.isEmpty && _verlaufFehler == null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(children: [
              Icon(Icons.history, size: 30, color: context.colors.textTertiary),
              const SizedBox(height: 8),
              // ⚠️ „Noch nichts gerechnet" ist eine BEHAUPTUNG, und sie ist
              // falsch, wenn gerechnet wurde und nur das Speichern misslang.
              // Genau dann sähe der Verlauf leer aus, obwohl er es nicht ist.
              Text(
                  _ungespeichert > 0
                      ? l10n.rechnerLeerWeilUngespeichert
                      : l10n.rechnerLeer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13, color: context.colors.textSecondary)),
              const SizedBox(height: 4),
              Text(
                l10n.rechnerVerlaufErklaerung,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 11,
                    color: context.colors.textTertiary,
                    height: 1.35),
              ),
            ]),
          )
        else
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: eintraege.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: context.colors.dividerSubtle),
              itemBuilder: (_, i) {
                final e = eintraege[i];
                return InkWell(
                  onTap: () => _uebernehmen(e),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              rechnerAusdruckFormat(
                                  (e['ausdruck'] ?? '').toString()),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: context.colors.textTertiary),
                            ),
                            Text(
                              '= ${e['ergebnis'] ?? ''}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: context.colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ⚠️ Der Abstand ist keine Kosmetik: er trennt die
                      // Fläche, die WEITERRECHNET, von der, die LÖSCHT. Ohne
                      // ihn stossen beide Trefferflächen unmittelbar
                      // aneinander.
                      const SizedBox(width: 6),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 18),
                        color: context.colors.textTertiary,
                        tooltip: l10n.rechnerZeileLoeschenTooltip,
                        onPressed: () => _eintragLoeschen(e),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
          child: Row(children: [
            Expanded(
              // ⚠️ Nur wenn wirklich etwas dasteht. Über einer leeren Liste —
              // oder über einem Netzfehler — erklärt dieser Satz eine
              // Handlung, die es gerade nicht gibt.
              child: eintraege.isEmpty
                  ? const SizedBox.shrink()
                  : Text(
                      l10n.rechnerWeiterrechnen,
                      style: TextStyle(
                          fontSize: 11, color: context.colors.textTertiary),
                    ),
            ),
            if (eintraege.isNotEmpty)
              TextButton.icon(
                onPressed: _verlaufLeeren,
                icon: const Icon(Icons.delete_sweep_outlined, size: 16),
                label: Text(l10n.rechnerAllesLoeschen,
                    style: const TextStyle(fontSize: 12)),
                style:
                    TextButton.styleFrom(foregroundColor: context.colors.dangerFg),
              ),
          ]),
        ),
      ],
    );
  }
}
