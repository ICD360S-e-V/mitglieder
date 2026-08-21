import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
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
class KontaktBestaetigung extends StatefulWidget {
  final ApiService apiService;

  /// Wird nach einer erfolgreichen Bestätigung gerufen, damit die
  /// darüberliegende Ansicht ihre Daten neu holen kann.
  final VoidCallback? onBestaetigt;

  /// true = nur zeigen, wenn wirklich etwas fällig ist. Für die Einbettung in
  /// einen Bildschirm, der sonst schon voll ist.
  final bool nurWennFaellig;

  const KontaktBestaetigung({
    super.key,
    required this.apiService,
    this.onBestaetigt,
    this.nurWennFaellig = true,
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
    setState(() => _laedt = true);
    try {
      final r = await widget.apiService.kontaktStatus();
      if (!mounted) return;
      setState(() {
        _stand = r['success'] == true ? Map<String, dynamic>.from(r) : null;
        _laedt = false;
      });
    } catch (_) {
      if (mounted) setState(() => _laedt = false);
    }
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
    if (_laedt) return const SizedBox.shrink();
    final s = _stand;
    if (s == null) return const SizedBox.shrink();
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
                    _codeAnfordern(kanal);
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
      const SizedBox(height: 4),
      Row(children: [
        TextButton(
          onPressed: _sendet ? null : () => setState(() {
            _offenerKanal = null;
            _fehler = null;
          }),
          child: Text(t.cancel),
        ),
        const Spacer(),
        if (_sendet)
          const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
        else
          ElevatedButton(
            onPressed: _codeCtrl.text.trim().length == 6 ? _codePruefen : null,
            child: Text(t.confirm),
          ),
      ]),
    ]);
  }

  String _datum(dynamic iso) {
    final d = DateTime.tryParse(iso?.toString() ?? '');
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}.'
        '${d.month.toString().padLeft(2, '0')}.${d.year}';
  }
}
