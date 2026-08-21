import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:signature/signature.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/logger_service.dart';
import '../utils/app_theme.dart';

/// Was der Verein von diesem Mitglied unterschrieben haben möchte.
///
/// Der Bildschirm zeigt bewusst auch das Erledigte: wer wissen will, ob er
/// etwas schon unterschrieben hat, soll nicht raten müssen.
class SignaturScreen extends StatefulWidget {
  final ApiService apiService;

  const SignaturScreen({super.key, required this.apiService});

  @override
  State<SignaturScreen> createState() => _SignaturScreenState();
}

class _SignaturScreenState extends State<SignaturScreen> {
  List<Map<String, dynamic>> _vorgaenge = const [];
  bool _laedt = true;

  @override
  void initState() {
    super.initState();
    _laden();
  }

  Future<void> _laden() async {
    if (mounted) setState(() => _laedt = true);
    final antwort = await widget.apiService.getSignaturen();
    if (!mounted) return;

    final liste = (antwort['signaturen'] as List?) ?? const [];
    setState(() {
      _vorgaenge = liste
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(growable: false);
      _laedt = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signaturTitel)),
      body: _laedt
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _laden,
              child: _vorgaenge.isEmpty
                  ? _leer(l10n)
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _vorgaenge.length,
                      itemBuilder: (_, i) => _kachel(l10n, _vorgaenge[i]),
                    ),
            ),
    );
  }

  Widget _leer(AppLocalizations l10n) => ListView(
        padding: const EdgeInsets.all(32),
        children: [
          const SizedBox(height: 80),
          Icon(Icons.draw_outlined, size: 56, color: context.colors.textDisabled),
          const SizedBox(height: 16),
          Text(
            l10n.signaturNichtsOffen,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.colors.textSecondary),
          ),
        ],
      );

  Widget _kachel(AppLocalizations l10n, Map<String, dynamic> v) {
    final status = (v['status'] ?? 'offen').toString();
    final offen = status == 'offen';

    // Unterschrieben, aber das Dokument liegt noch nicht vor: bei einer
    // Vollmacht unterschreiben zwei Personen, und gesiegelt wird erst, wenn
    // beide fertig sind. Ohne eigenen Zustand sähe das Mitglied denselben
    // grünen Haken wie sonst und würde beim Antippen die Siegelmeldung lesen —
    // die hier falsch wäre: es wird nicht gerechnet, es fehlt ein Mensch.
    final wartetAufAndere = v['wartet_auf_mitunterzeichner'] == true;

    final (farbe, symbol, text) = switch (status) {
      'signiert' when wartetAufAndere => (
          context.colors.infoFg,
          Icons.hourglass_top,
          '${l10n.signaturStatusSigniert} · ${l10n.signaturWartetZweiteUnterschrift}',
        ),
      'signiert' => (context.colors.successFg, Icons.verified, l10n.signaturStatusSigniert),
      'abgelehnt' => (context.colors.dangerFg, Icons.cancel, l10n.signaturStatusAbgelehnt),
      'widerrufen' => (context.colors.textSecondary, Icons.undo, l10n.signaturStatusWiderrufen),
      'abgelaufen' => (context.colors.textSecondary, Icons.schedule, l10n.signaturStatusAbgelaufen),
      _ => (context.colors.warningFg, Icons.edit_document, l10n.signaturStatusOffen),
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: farbe.withValues(alpha: 0.15),
          child: Icon(symbol, color: farbe),
        ),
        title: Text((v['dokument_titel'] ?? '').toString(),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(text, style: TextStyle(color: farbe, fontSize: 12)),
        // Auch das Unterschriebene bleibt anklickbar. Wer etwas unterschreibt,
        // muss nachlesen können, was er unterschrieben hat — sonst hat der
        // Verein eine Kopie und das Mitglied keine.
        trailing: switch (status) {
          // Beim Warten kein Pfeil: er verspricht eine Seite, die es noch nicht
          // gibt. Antippbar bleibt die Zeile trotzdem — sie erklärt dann, worauf
          // gewartet wird.
          'signiert' when wartetAufAndere => Icon(Icons.info_outline,
              size: 20, color: context.colors.infoFg),
          _ when offen || status == 'signiert' => const Icon(Icons.chevron_right),
          _ => null,
        },
        onTap: switch (status) {
          'signiert' when wartetAufAndere => () => _wartenErklaeren(l10n),
          _ when offen => () => _oeffnen(v),
          _ when status == 'signiert' => () => _ansehen(v),
          _ => null,
        },
      ),
    );
  }

  /// Erklärt, warum das unterschriebene Dokument noch nicht abrufbar ist.
  ///
  /// Bewusst getrennt von der Siegelmeldung: dort rechnet der Server noch und
  /// eine Minute später ist es da. Hier fehlt eine zweite Unterschrift, und die
  /// kann Tage dauern. Beides in einen Satz zu packen hiesse, das Mitglied
  /// vergeblich nachsehen zu lassen.
  void _wartenErklaeren(AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: Icon(Icons.hourglass_top, color: context.colors.infoFg),
        title: Text(l10n.signaturWartetZweiteUnterschrift),
        content: Text(l10n.signaturWartenHinweis),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(MaterialLocalizations.of(ctx).okButtonLabel),
          ),
        ],
      ),
    );
  }

  /// Zeigt dem Mitglied die gesiegelte Fassung seines eigenen Dokuments.
  void _ansehen(Map<String, dynamic> v) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _SigniertesDokumentScreen(
          apiService: widget.apiService,
          signaturId: (v['id'] as num).toInt(),
          titel: (v['dokument_titel'] ?? '').toString(),
        ),
      ),
    );
  }

  Future<void> _oeffnen(Map<String, dynamic> v) async {
    final fertig = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => SignaturUnterschreibenScreen(
          apiService: widget.apiService,
          signaturId: (v['id'] as num).toInt(),
          titel: (v['dokument_titel'] ?? '').toString(),
          seiten: v['pdf_seiten'] is num ? (v['pdf_seiten'] as num).toInt() : null,
        ),
      ),
    );
    if (fertig == true) await _laden();
  }
}

// ───────────────────────────────────────────────────────────────────────────

/// Der eigentliche Ablauf: lesen → unterschreiben → mit TAN bestätigen.
///
/// Die drei Schritte stehen in dieser Reihenfolge und nicht anders. Wer die
/// Unterschrift vor das Dokument setzen dürfte, hätte etwas unterschrieben,
/// das er nicht gesehen hat — und genau das würde die Unterschrift später
/// wertlos machen.
class SignaturUnterschreibenScreen extends StatefulWidget {
  final ApiService apiService;
  final int signaturId;
  final String titel;
  final int? seiten;

  const SignaturUnterschreibenScreen({
    super.key,
    required this.apiService,
    required this.signaturId,
    required this.titel,
    this.seiten,
  });

  @override
  State<SignaturUnterschreibenScreen> createState() =>
      _SignaturUnterschreibenScreenState();
}

class _SignaturUnterschreibenScreenState
    extends State<SignaturUnterschreibenScreen> {
  final _log = LoggerService();

  final _unterschrift = SignatureController(
    penStrokeWidth: 3,
    // Bleibt schwarz, auch im dunklen Modus: dieser Pfad wird als SVG
    // exportiert und landet im PDF auf weißem Papier. Eine helle Unterschrift
    // wäre dort unsichtbar. Der Strich auf dem Bildschirm ist nur die Vorschau
    // dessen, was gedruckt wird — die Zeichenfläche darunter ist deshalb auch
    // im dunklen Modus hell.
    penColor: Colors.black,
    // Kein exportBackgroundColor: der Pfad soll transparent bleiben, damit er
    // später im PDF auf dem Papier sitzt und nicht auf einem weißen Kasten.
  );
  final _tanFeld = TextEditingController();

  /// 0 = lesen, 1 = unterschreiben, 2 = TAN
  int _schritt = 0;

  int _letzteGeseheneSeite = 1;
  bool _sendet = false;
  String? _tanZiel;
  String? _fehler;

  /// Wenn der Server die Seitenzahl nicht kennt, wird kein Scroll-Ziel
  /// verlangt. Ein erfundenes Ziel wäre schlimmer als keines: es würde einen
  /// Knopf sperren, den niemand mehr freibekommt.
  bool get _durchgelesen =>
      widget.seiten == null || _letzteGeseheneSeite >= widget.seiten!;

  @override
  void dispose() {
    _unterschrift.dispose();
    _tanFeld.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titel, style: const TextStyle(fontSize: 16)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: (_schritt + 1) / 3),
        ),
      ),
      body: switch (_schritt) {
        0 => _lesen(l10n),
        1 => _malen(l10n),
        _ => _bestaetigen(l10n),
      },
    );
  }

  // ── Schritt 1: lesen ──

  Widget _lesen(AppLocalizations l10n) {
    return Column(
      children: [
        Expanded(
          // Geladen wird über den eigenen Client — siehe _SignaturPdfAnsicht.
          // Vorher lud der Betrachter selbst und scheiterte unter Windows an
          // der Zertifikatskette, sichtbar nur als „Failed to open PDF".
          child: _SignaturPdfAnsicht(
            apiService: widget.apiService,
            signaturId: widget.signaturId,
            welche: 'original',
            quellName: 'original_${widget.signaturId}.pdf',
            fehlerAufbau: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off, size: 48, color: context.colors.textDisabled),
                    const SizedBox(height: 16),
                    Text(
                      l10n.errorDownloading,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: context.colors.textPrimary),
                    ),
                  ],
                ),
              ),
            ),
            params: PdfViewerParams(
              onPageChanged: (seite) {
                if (seite != null && seite > _letzteGeseheneSeite) {
                  setState(() => _letzteGeseheneSeite = seite);
                }
              },
            ),
          ),
        ),
        _fussleiste(
          hinweis: _durchgelesen
              ? null
              : l10n.signaturBitteGanzLesen(
                  _letzteGeseheneSeite, widget.seiten ?? 0),
          knopf: l10n.signaturWeiterZurUnterschrift,
          aktiv: _durchgelesen,
          onDruck: () => setState(() => _schritt = 1),
          zweitknopf: l10n.signaturAblehnen,
          onZweit: _ablehnen,
        ),
      ],
    );
  }

  // ── Schritt 2: unterschreiben ──

  Widget _malen(AppLocalizations l10n) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(l10n.signaturMitFingerHinweis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: context.colors.textPrimary)),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.card,
                      border: Border.all(color: context.colors.textDisabled),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Signature(
                      controller: _unterschrift,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () => setState(_unterschrift.clear),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: Text(l10n.signaturNochmal),
                    ),
                    TextButton.icon(
                      onPressed: () => setState(() => _schritt = 0),
                      icon: const Icon(Icons.arrow_back, size: 18),
                      label: Text(l10n.signaturZurueckZumDokument),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // ValueListenableBuilder statt setState bei jedem Strich: der Knopf
        // soll auf den ersten Punkt reagieren, ohne dass die Zeichenfläche
        // dabei jedes Mal neu gebaut wird.
        ValueListenableBuilder<List<Point>>(
          valueListenable: _unterschrift,
          builder: (_, punkte, __) => _fussleiste(
            knopf: l10n.signaturCodeAnfordern,
            aktiv: punkte.isNotEmpty,
            onDruck: _tanAnfordern,
          ),
        ),
      ],
    );
  }

  // ── Schritt 3: TAN ──

  Widget _bestaetigen(AppLocalizations l10n) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(Icons.sms, size: 48, color: context.colors.infoFg),
                const SizedBox(height: 16),
                Text(
                  _tanZiel == null
                      ? l10n.signaturCodeUnterwegs
                      : l10n.signaturCodeGesendetAn(_tanZiel!),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _tanFeld,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  style: const TextStyle(fontSize: 28, letterSpacing: 8),
                  decoration: InputDecoration(
                    counterText: '',
                    border: const OutlineInputBorder(),
                    hintText: '••••••',
                    errorText: _fehler,
                  ),
                  onChanged: (_) {
                    // Nur noch die Fehlermeldung wegräumen. Ob der Knopf
                    // freigegeben ist, hängt NICHT mehr an diesem setState —
                    // siehe unten.
                    if (_fehler != null) setState(() => _fehler = null);
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _sendet ? null : _tanAnfordern,
                  child: Text(l10n.signaturCodeErneutSenden),
                ),
              ],
            ),
          ),
        ),
        // Der Knopf hört direkt auf das Textfeld, statt auf ein setState zu
        // hoffen.
        //
        // Vorher stand hier `aktiv: _tanFeld.text.trim().length >= 4`, und
        // neu aufgebaut wurde nur, wenn gerade eine Fehlermeldung wegfiel.
        // Beim ERSTEN Eintippen gab es keine — also kein Neuaufbau, also blieb
        // der Knopf grau, und das Mitglied konnte den Code, den es gerade
        // bekommen hatte, nicht abschicken. Auf dem Server sah man drei
        // Code-Anforderungen hintereinander und keinen einzigen
        // Signier-Versuch: jemand tippte den Code ein, kam nicht weiter und
        // forderte einen neuen an.
        //
        // Dieselbe Bauart wie beim Unterschriftsfeld einen Schritt vorher: der
        // Zustand kommt aus dem Controller, nicht aus einem Aufruf, den man
        // vergessen kann.
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _tanFeld,
          builder: (_, wert, __) => _fussleiste(
            knopf: l10n.signaturJetztUnterschreiben,
            aktiv: wert.text.trim().length >= 4 && !_sendet,
            laedt: _sendet,
            onDruck: _signieren,
          ),
        ),
      ],
    );
  }

  // ── Aktionen ──

  Future<void> _tanAnfordern() async {
    setState(() {
      _sendet = true;
      _fehler = null;
    });

    final antwort = await widget.apiService.signaturTanAnfordern(widget.signaturId);
    if (!mounted) return;

    setState(() => _sendet = false);

    if (antwort['success'] == true) {
      setState(() {
        _tanZiel = antwort['gesendet_an']?.toString();
        _schritt = 2;
      });
      return;
    }

    // Fehlt die Rufnummer, ist das kein Fehler der App, sondern eine Lücke im
    // Konto — und die kann nur der Verein füllen. Das muss dastehen, sonst
    // versucht es das Mitglied endlos weiter.
    final l10n = AppLocalizations.of(context)!;
    final grund = antwort['grund']?.toString();
    _meldung(
      grund == 'keine_rufnummer'
          ? l10n.signaturKeineRufnummer
          : (antwort['message']?.toString() ?? l10n.signaturCodeFehlgeschlagen),
      fehler: true,
    );
  }

  Future<void> _signieren() async {
    final l10n = AppLocalizations.of(context)!;
    final svg = _unterschrift.toRawSVG();

    if (svg == null || svg.isEmpty) {
      // Kann passieren, wenn zwischen Malen und Absenden geleert wurde.
      setState(() => _schritt = 1);
      _meldung(l10n.signaturLeer, fehler: true);
      return;
    }

    setState(() {
      _sendet = true;
      _fehler = null;
    });

    final antwort = await widget.apiService.signaturSignieren(
      signaturId: widget.signaturId,
      signatureSvg: svg,
      tan: _tanFeld.text.trim(),
      signedAtLocal: DateTime.now().toIso8601String(),
      deviceHostname: await _geraetename(),
    );

    if (!mounted) return;
    setState(() => _sendet = false);

    if (antwort['success'] == true) {
      _meldung(l10n.signaturErfolg, erfolg: true);
      if (mounted) Navigator.pop(context, true);
      return;
    }

    final grund = antwort['grund']?.toString();
    setState(() {
      _fehler = switch (grund) {
        'tan_falsch' => l10n.signaturCodeFalsch,
        'tan_abgelaufen' => l10n.signaturCodeAbgelaufen,
        'zu_viele_versuche' => l10n.signaturZuVieleVersuche,
        _ => antwort['message']?.toString() ?? l10n.signaturFehlgeschlagen,
      };
    });
  }

  Future<void> _ablehnen() async {
    final l10n = AppLocalizations.of(context)!;
    final grundFeld = TextEditingController();

    final bestaetigt = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.signaturAblehnen),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.signaturAblehnenHinweis),
            const SizedBox(height: 12),
            TextField(
              controller: grundFeld,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.signaturAblehnenGrund,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.signaturAblehnen),
          ),
        ],
      ),
    );

    if (bestaetigt != true || !mounted) return;

    final antwort = await widget.apiService
        .signaturAblehnen(widget.signaturId, grundFeld.text.trim());
    if (!mounted) return;

    if (antwort['success'] == true) {
      Navigator.pop(context, true);
    } else {
      _meldung(antwort['message']?.toString() ?? l10n.signaturFehlgeschlagen,
          fehler: true);
    }
  }

  /// Menschenlesbarer Gerätename fürs Beweisbündel — „Galaxy Tab A11" liest
  /// sich im Audit besser als ein Hash. Schlägt es fehl, bleibt das Feld leer:
  /// der Beweis hängt am device_key, nicht an diesem Namen.
  Future<String?> _geraetename() async {
    try {
      final info = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final a = await info.androidInfo;
        return '${a.manufacturer} ${a.model}'.trim();
      }
      if (Platform.isIOS) {
        final i = await info.iosInfo;
        return i.utsname.machine;
      }
      return null;
    } catch (e) {
      _log.error('Gerätename: $e', tag: 'SIGNATUR');
      return null;
    }
  }

  // ── Bausteine ──

  Widget _fussleiste({
    required String knopf,
    required bool aktiv,
    required VoidCallback onDruck,
    String? hinweis,
    bool laedt = false,
    String? zweitknopf,
    VoidCallback? onZweit,
  }) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.colors.divider)),
        ),
        child: Column(
          children: [
            if (hinweis != null) ...[
              Text(hinweis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: context.colors.warningFg)),
              const SizedBox(height: 8),
            ],
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: aktiv && !laedt ? onDruck : null,
                child: laedt
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(knopf),
              ),
            ),
            if (zweitknopf != null && onZweit != null)
              TextButton(onPressed: onZweit, child: Text(zweitknopf)),
          ],
        ),
      ),
    );
  }

  void _meldung(String text, {bool erfolg = false, bool fehler = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: fehler
          ? context.colors.dangerFg
          : erfolg
              ? context.colors.successFg
              : null,
    ));
  }
}

// ───────────────────────────────────────────────────────────────────────────

/// Die gesiegelte Fassung, wie das Mitglied sie nach dem Unterschreiben sieht.
///
/// Eigener Bildschirm statt eines Dialogs: das ist ein mehrseitiges Dokument
/// mit angehängtem Unterschriftenblatt, und darin will man blättern können.
///
/// Das Siegel entsteht erst im Minutentakt nach der Unterschrift. Wer sofort
/// nachsieht, bekommt deshalb nicht die Datei, sondern eine Erklärung — ein
/// leerer Betrachter sähe aus, als wäre etwas verloren gegangen.
class _SigniertesDokumentScreen extends StatelessWidget {
  final ApiService apiService;
  final int signaturId;
  final String titel;

  const _SigniertesDokumentScreen({
    required this.apiService,
    required this.signaturId,
    required this.titel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titel, style: const TextStyle(fontSize: 16))),
      // Fehlt die gesiegelte Fassung noch, liefert der Server kein PDF —
      // dann steht hier die Erklärung statt eines leeren Betrachters.
      body: _SignaturPdfAnsicht(
        apiService: apiService,
        signaturId: signaturId,
        welche: 'signiert',
        quellName: 'signiert_$signaturId.pdf',
        fehlerAufbau: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty,
                    size: 48, color: context.colors.textDisabled),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.signaturSiegelInArbeit,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.colors.textPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────

/// Lädt ein Signatur-PDF über den eigenen Client und zeigt es dann an.
///
/// Der Umweg über die Bytes ist der Punkt. Ließe man den Betrachter die URL
/// selbst laden, nähme er seinen eigenen HTTP-Client und damit den
/// Zertifikatsspeicher der Plattform. Unter Windows scheitert das: die Kette
/// des Servers endet an der neuen ISRG Root YE, die dort nicht bekannt ist,
/// und der Nutzer sieht nur „Failed to open PDF" — ohne dass je eine Anfrage
/// beim Server ankäme. Unser Client bringt die Wurzeln selbst mit.
///
/// Zugleich wird damit jeder Fehlschlag zu einer Aussage, die wir formulieren
/// können, statt zu der des Betrachters.
class _SignaturPdfAnsicht extends StatefulWidget {
  final ApiService apiService;
  final int signaturId;
  final String welche;
  final String quellName;
  final WidgetBuilder fehlerAufbau;
  final PdfViewerParams? params;

  const _SignaturPdfAnsicht({
    required this.apiService,
    required this.signaturId,
    required this.welche,
    required this.quellName,
    required this.fehlerAufbau,
    this.params,
  });

  @override
  State<_SignaturPdfAnsicht> createState() => _SignaturPdfAnsichtState();
}

class _SignaturPdfAnsichtState extends State<_SignaturPdfAnsicht> {
  // Im initState angestoßen, nicht im build: der FutureBuilder würde sonst
  // bei jedem Neuaufbau — und den löst schon das Umblättern aus — erneut
  // laden.
  late final Future<Uint8List?> _bytes = widget.apiService
      .signaturPdfLaden(widget.signaturId, welche: widget.welche);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _bytes,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final daten = snapshot.data;
        if (daten == null || daten.isEmpty) {
          return widget.fehlerAufbau(context);
        }
        return PdfViewer.data(
          daten,
          sourceName: widget.quellName,
          params: widget.params ?? const PdfViewerParams(),
        );
      },
    );
  }
}
