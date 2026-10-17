import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import '../services/kontakt_link.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// Bestätigung von E-Mail-Adresse und Mobilnummer.
///
/// ⚠️ Diese Karte war bei ihrer ersten Auslieferung komplett auf Deutsch —
/// zweiundzwanzig fest eingetippte Zeichenketten, kein einziger Aufruf von
/// AppLocalizations, in einer App mit achtundzwanzig Sprachdateien. Wer hier
/// etwas ergänzt, ergänzt es in `lib/l10n/app_de.arb` und in den siebenundzwanzig
/// anderen; ein Text im Code ist an dieser Stelle immer ein Fehler.
///
/// Alle 90 Tage fragt der Verein nach, ob beides noch stimmt. Bestätigt wird
/// mit einem sechsstelligen Code, der an genau diesen Kanal geht — eine
/// Adresse, an der ein Code ankommt, ist eine Adresse, die es gibt.
///
/// ⚠️ Die Mobilnummer lässt sich NUR hier ändern, nicht mehr im Profil. An ihr
/// hängen Terminerinnerung, Medikamentenerinnerung und der Zugangscode für ein
/// neues Gerät. Eine Nummer, die man im Profil frei überschreiben kann, ist
/// kein Nachweis über irgendetwas — sie ist dann nur die zuletzt eingetippte
/// Zeichenkette. Der Code geht an die NEUE Nummer; wer ihn eingibt, hat
/// bewiesen, dass er das Telefon in der Hand hält.
///
/// ⚠️ Liegt schon ein Code bereit (`code_offen`), steht das Eingabefeld vorn —
/// nicht der Knopf, der einen NEUEN Code schickt. Den Code bringt meist die
/// Erinnerungsmail des Vereins (7 Tage gültig), und die sagte bis zum
/// 17.10.2026 „tippen Sie auf „Bestätigen““. Der Knopf forderte einen neuen
/// Code an, der Server löschte dabei den aus der Mail, und wer ihn eintippte,
/// las „Der Code stimmt nicht“. Der Server lässt ihn seitdem stehen; hier
/// kommt man gar nicht erst auf den Umweg.
class KontaktBestaetigung extends StatefulWidget {
  final ApiService apiService;

  /// Wird nach einer erfolgreichen Bestätigung gerufen, damit die
  /// darüberliegende Ansicht ihre Daten neu holen kann.
  final VoidCallback? onBestaetigt;

  /// true = nur zeigen, wenn wirklich etwas fällig ist. Für die Einbettung in
  /// einen Bildschirm, der sonst schon voll ist.
  final bool nurWennFaellig;

  /// Ein Code, der per Link aus der Mail kam ([KontaktLink]): wird eingetragen
  /// und gleich geprüft, als hätte das Mitglied ihn abgetippt. Ist der Kanal
  /// schon bestätigt, passiert nichts — ein zweites Öffnen desselben Links
  /// zeigt „bestätigt am …“, keinen Fehler.
  final KontaktCodeAusLink? codeAusLink;

  const KontaktBestaetigung({
    super.key,
    required this.apiService,
    this.onBestaetigt,
    this.nurWennFaellig = true,
    this.codeAusLink,
  });

  @override
  State<KontaktBestaetigung> createState() => _KontaktBestaetigungState();
}

class _KontaktBestaetigungState extends State<KontaktBestaetigung> {
  Map<String, dynamic>? _stand;
  bool _laedt = true;

  /// Für welchen Kanal läuft gerade eine Eingabe? null = keine.
  String? _offenerKanal;
  final _codeCtrl = TextEditingController();
  final _neuCtrl = TextEditingController();
  bool _aendern = false;
  bool _sendet = false;
  String? _fehler;
  String? _zielKurz;

  /// Kanäle, deren Eingabefeld das Mitglied mit „Abbrechen" zugemacht hat —
  /// die öffnen sich nicht von selbst wieder.
  final _zugemacht = <String>{};

  /// Der Code aus dem Link ist schon eingetragen worden — nur einmal, auch
  /// wenn die Karte nach der Bestätigung neu lädt.
  bool _linkEingetragen = false;

  @override
  void initState() {
    super.initState();
    _laden();
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _neuCtrl.dispose();
    super.dispose();
  }

  Future<void> _laden() async {
    if (!mounted) return;
    setState(() => _laedt = true);
    try {
      final r = await widget.apiService.kontaktStatus();
      if (!mounted) return;
      setState(() {
        _stand = r['success'] == true ? Map<String, dynamic>.from(r) : null;
        _laedt = false;
        // Kam der Code per Link, geht es um genau dessen Kanal — kein anderes
        // Feld springt dazwischen auf.
        _offenerKanal ??= widget.codeAusLink == null ? _kanalMitCode() : null;
      });
      _linkEintragen();
    } catch (_) {
      if (mounted) setState(() => _laedt = false);
    }
  }

  /// Trägt den Code aus dem Link ein und prüft ihn. Nur, wenn der Kanal
  /// fällig ist.
  void _linkEintragen() {
    final link = widget.codeAusLink;
    if (link == null || _linkEingetragen) return;
    _linkEingetragen = true;
    final k = _stand?[link.kanal];
    if (k is! Map || k['faellig'] != true) return;
    setState(() {
      _offenerKanal = link.kanal;
      _zielKurz = null;
      _fehler = null;
      _codeCtrl.text = link.code;
    });
    _codePruefen();
  }

  /// Der erste fällige Kanal, für den schon ein Code unterwegs ist — aus der
  /// Erinnerungsmail oder von vorhin aus der App. null = keiner.
  String? _kanalMitCode() {
    final s = _stand;
    if (s == null) return null;
    for (final kanal in const ['email', 'telefon']) {
      final k = s[kanal];
      if (k is Map && k['faellig'] == true && k['code_offen'] == true && !_zugemacht.contains(kanal)) {
        return kanal;
      }
    }
    return null;
  }

  /// Das Eingabefeld für einen Code, der schon unterwegs ist — ohne einen
  /// neuen anzufordern.
  void _codeEingeben(String kanal) {
    setState(() {
      _offenerKanal = kanal;
      _zielKurz = null;
      _fehler = null;
      _codeCtrl.clear();
    });
  }

  bool get _etwasFaellig {
    final s = _stand;
    if (s == null) return false;
    return (s['email']?['faellig'] == true) || (s['telefon']?['faellig'] == true);
  }

  Future<void> _codeAnfordern(String kanal) async {
    final t = AppLocalizations.of(context)!;
    setState(() {
      _sendet = true;
      _fehler = null;
    });
    try {
      final r = await widget.apiService.kontaktCodeAnfordern(
        kanal: kanal,
        neu: _aendern ? _neuCtrl.text : null,
      );
      if (!mounted) return;
      setState(() {
        _sendet = false;
        if (r['success'] == true) {
          _offenerKanal = kanal;
          _zielKurz = r['ziel_kurz']?.toString();
          _codeCtrl.clear();
        } else {
          // ⚠️ Die Meldung des Servers wird durchgereicht und nicht durch ein
          // allgemeines „Fehler" ersetzt. Sie sagt genau, was los ist: die
          // Nummer gehört einem anderen Konto, es ist ein Festnetzanschluss,
          // die Landesvorwahl fehlt — und bei der fehlenden Vorwahl enthält
          // sie sogar den korrigierten Vorschlag.
          _fehler = r['message']?.toString() ?? t.signaturFehlgeschlagen;
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _sendet = false;
          _fehler = t.signaturFehlgeschlagen;
        });
      }
    }
  }

  Future<void> _codePruefen() async {
    final t = AppLocalizations.of(context)!;
    final kanal = _offenerKanal;
    if (kanal == null) return;
    setState(() {
      _sendet = true;
      _fehler = null;
    });
    try {
      final r = await widget.apiService.kontaktCodePruefen(
        kanal: kanal,
        code: _codeCtrl.text.trim(),
      );
      if (!mounted) return;
      if (r['success'] == true) {
        setState(() {
          _sendet = false;
          _offenerKanal = null;
          _aendern = false;
          _neuCtrl.clear();
          _codeCtrl.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.dataSavedSuccess),
            backgroundColor: context.colors.successSolid,
          ),
        );
        widget.onBestaetigt?.call();
        await _laden();
      } else {
        setState(() {
          _sendet = false;
          _fehler = r['message']?.toString() ?? t.signaturCodeFalsch;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _sendet = false;
          _fehler = t.signaturFehlgeschlagen;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    // Kam der Code per Link, sucht das Mitglied genau diese Karte — dort steht
    // beim Laden ein Kreisel und bei einem Fehler ein Satz, kein leerer Platz.
    final ausLink = widget.codeAusLink != null;
    if (_laedt) {
      return ausLink
          ? const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            )
          : const SizedBox.shrink();
    }
    final s = _stand;
    if (s == null) {
      return ausLink ? Text(t.signaturFehlgeschlagen) : const SizedBox.shrink();
    }
    if (widget.nurWennFaellig && !_etwasFaellig) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colors.warningBorder),
      ),
      color: context.colors.warningBg,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.contact_mail_outlined, color: context.colors.warningFg),
              const SizedBox(width: 10),
              Expanded(
                child: Text(t.kontaktNochAktuell,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ]),
            const SizedBox(height: 6),
            Text(
              t.kontaktWarumFragen,
              style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
            ),
            const SizedBox(height: 14),
            if (_offenerKanal == null) ...[
              _zeile(s, 'email', t.email, Icons.alternate_email),
              _zeile(s, 'telefon', t.phoneMobileLabel, Icons.smartphone),
            ] else
              _codeEingabe(),
            if (_fehler != null) ...[
              const SizedBox(height: 10),
              Text(_fehler!,
                  style: TextStyle(fontSize: 12.5, color: context.colors.dangerFg)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _zeile(Map<String, dynamic> s, String kanal, String titel, IconData icon) {
    final t = AppLocalizations.of(context)!;
    final k = Map<String, dynamic>.from(s[kanal] ?? {});
    final faellig = k['faellig'] == true;
    final wert = (k['wert'] ?? '').toString();
    final vorhanden = k['vorhanden'] == true;
    // ⚠️ Nur an eine Mobilnummer geht eine SMS. Steht dort ein
    // Festnetzanschluss, kommt der Code nie an — dann muss die App das sagen,
    // statt das Mitglied auf eine SMS warten zu lassen, die es nicht gibt.
    final smsUnmoeglich = kanal == 'telefon' && k['sms_moeglich'] == false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(faellig ? icon : Icons.verified,
            size: 18, color: faellig ? context.colors.warningFg : context.colors.successFg),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(titel, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
            Text(vorhanden ? wert : 'nicht hinterlegt',
                style: TextStyle(
                    fontSize: 13,
                    color: vorhanden ? context.colors.textPrimary : context.colors.textSecondary,
                    fontStyle: vorhanden ? FontStyle.normal : FontStyle.italic)),
            if (smsUnmoeglich)
              Text(t.kontaktFestnetzKeinSms,
                  style: TextStyle(fontSize: 11, color: context.colors.dangerFg)),
            if (!faellig && k['bestaetigt_am'] != null)
              Text(t.kontaktBestaetigtAm(_datum(k['bestaetigt_am'])),
                  style: TextStyle(fontSize: 11, color: context.colors.successFg)),
          ]),
        ),
        if (faellig)
          TextButton(
            onPressed: _sendet
                ? null
                : () {
                    setState(() {
                      _aendern = false;
                      _neuCtrl.text = wert;
                    });
                    // Ein Code ist schon unterwegs: erst den eingeben lassen.
                    // Ein neuer hiesse eine zweite Mail mit anderem Code.
                    if (k['code_offen'] == true) {
                      _codeEingeben(kanal);
                    } else {
                      _codeAnfordern(kanal);
                    }
                  },
            child: Text(t.confirm),
          ),
        if (faellig)
          IconButton(
            tooltip: t.kontaktIstAndersGeworden,
            onPressed: _sendet
                ? null
                : () => setState(() {
                      _aendern = true;
                      _offenerKanal = null;
                      _neuCtrl.text = wert;
                      _neuEingeben(kanal, titel);
                    }),
            icon: const Icon(Icons.edit, size: 18),
          ),
      ]),
    );
  }

  /// Dialog für eine neue Adresse oder Nummer.
  Future<void> _neuEingeben(String kanal, String titel) async {
    final t = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Neue $titel'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            kanal == 'telefon'
                // ⚠️ Die Landesvorwahl ist Pflicht. Eine führende Null heißt
                // nur im Inland „Deutschland"; eine rumänische 0755… wäre
                // sonst still zu einer deutschen Nummer geworden, an der ein
                // Fremder abhebt.
                // ⚠️ Der Hinweis zur Ländervorwahl steht nur bei der Nummer.
                // Er ist kein Schmuck: eine führende Null heißt nur im Inland
                // „Deutschland" — eine rumänische 0755… würde sonst still zu
                // einer deutschen Nummer, an der ein Fremder abhebt. Der
                // Server weist sie zurück und schlägt die richtige Form vor;
                // dieser Satz erspart den Fehlversuch.
                ? '${t.kontaktWarumFragen}\n\n+49 176 1234567'
                : t.kontaktWarumFragen,
            style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _neuCtrl,
            autofocus: true,
            keyboardType: kanal == 'telefon' ? TextInputType.phone : TextInputType.emailAddress,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: titel,
              hintText: kanal == 'telefon' ? '+49 176 1234567' : 'name@beispiel.de',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.signaturCodeAnfordern)),
        ],
      ),
    );
    if (ok == true && mounted) _codeAnfordern(kanal);
  }

  Widget _codeEingabe() {
    final t = AppLocalizations.of(context)!;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        _offenerKanal == 'email'
            ? 'Wir haben Ihnen eine E-Mail geschickt${_zielKurz != null ? " an $_zielKurz" : ""}.'
            : 'Wir haben Ihnen eine SMS geschickt${_zielKurz != null ? " an $_zielKurz" : ""}.',
        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),
      // ⚠️ EIN Feld für alle sechs Ziffern, nicht sechs einzelne Kästchen.
      // Auf iOS 26 fügt die Code-Übernahme aus der Nachricht den ganzen String
      // in ein einziges Feld ein, statt ihn auf mehrere zu verteilen — mit
      // sechs Kästchen landet der Code komplett im ersten und das Formular
      // ist unbenutzbar, genau bei denen, die die Bequemlichkeit nutzen.
      TextField(
        controller: _codeCtrl,
        autofocus: true,
        enabled: !_sendet,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 6,
        // Lässt Android und iOS den Code aus der Nachricht anbieten.
        autofillHints: const [AutofillHints.oneTimeCode],
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 26, letterSpacing: 10, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          hintText: '••••••',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (v) {
          // Sechs Ziffern beisammen: gleich prüfen. Ein Knopf, den man nach
          // dem Tippen noch drücken muss, ist bei einem Code aus der
          // Zwischenablage ein Schritt zu viel.
          if (v.length == 6 && !_sendet) _codePruefen();
        },
      ),
      // Kein Code angekommen, oder die Mail ist weg: ein neuer. Der Code aus
      // der Erinnerungsmail bleibt dabei gültig (Server); ein früherer Code
      // aus der App wird ersetzt. Eigene Zeile — drei Knöpfe nebeneinander
      // passen auf ein schmales Telefon nicht.
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: TextButton.icon(
          onPressed: _sendet ? null : () => _codeAnfordern(_offenerKanal!),
          icon: const Icon(Icons.refresh, size: 18),
          label: Text(t.signaturCodeErneutSenden),
        ),
      ),
      // OverflowBar statt Row: auf einem schmalen Telefon mit grosser Schrift
      // (277 dp, 130 %) liefen „Abbrechen“ und „Bestätigen“ nebeneinander
      // 165 px über den Rand — dann stehen sie untereinander.
      OverflowBar(
        alignment: MainAxisAlignment.spaceBetween,
        overflowAlignment: OverflowBarAlignment.end,
        overflowSpacing: 4,
        children: [
          TextButton(
            onPressed: _sendet ? null : () => setState(() {
              _zugemacht.add(_offenerKanal!);
              _offenerKanal = null;
              _fehler = null;
            }),
            child: Text(t.cancel),
          ),
          if (_sendet)
            const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
          else
            ElevatedButton(
              onPressed: _codeCtrl.text.trim().length == 6 ? _codePruefen : null,
              child: Text(t.confirm),
            ),
        ],
      ),
    ]);
  }

  String _datum(dynamic iso) {
    final d = DateTime.tryParse(iso?.toString() ?? '');
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}.'
        '${d.month.toString().padLeft(2, '0')}.${d.year}';
  }
}
