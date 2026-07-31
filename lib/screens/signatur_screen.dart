import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:signature/signature.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/device_key_service.dart';
import '../services/logger_service.dart';

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
          Icon(Icons.draw_outlined, size: 56, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            l10n.signaturNichtsOffen,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      );

  Widget _kachel(AppLocalizations l10n, Map<String, dynamic> v) {
    final status = (v['status'] ?? 'offen').toString();
    final offen = status == 'offen';

    final (farbe, symbol, text) = switch (status) {
      'signiert' => (Colors.green.shade700, Icons.verified, l10n.signaturStatusSigniert),
      'abgelehnt' => (Colors.red.shade700, Icons.cancel, l10n.signaturStatusAbgelehnt),
      'widerrufen' => (Colors.grey.shade600, Icons.undo, l10n.signaturStatusWiderrufen),
      'abgelaufen' => (Colors.grey.shade600, Icons.schedule, l10n.signaturStatusAbgelaufen),
      _ => (Colors.orange.shade800, Icons.edit_document, l10n.signaturStatusOffen),
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
        trailing: offen ? const Icon(Icons.chevron_right) : null,
        onTap: offen ? () => _oeffnen(v) : null,
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
    final url = '${ApiService.baseUrl}/member/signatur_pdf.php'
        '?id=${widget.signaturId}&which=original';

    return Column(
      children: [
        Expanded(
          child: PdfViewer.uri(
            Uri.parse(url),
            // Das PDF liegt hinter requireAuth() — ohne diese Kopfzeilen kommt
            // vom Server kein Dokument, sondern eine 401.
            headers: {
              if (widget.apiService.token != null)
                'Authorization': 'Bearer ${widget.apiService.token}',
              if (DeviceKeyService().deviceKey != null)
                'X-Device-Key': DeviceKeyService().deviceKey!,
              'User-Agent': 'ICD360S-Mitglied/1.0',
            },
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
                    style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
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
                Icon(Icons.sms, size: 48, color: Colors.blue.shade700),
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
        _fussleiste(
          knopf: l10n.signaturJetztUnterschreiben,
          aktiv: _tanFeld.text.trim().length >= 4 && !_sendet,
          laedt: _sendet,
          onDruck: _signieren,
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
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Column(
          children: [
            if (hinweis != null) ...[
              Text(hinweis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.orange.shade900)),
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
          ? Colors.red.shade700
          : erfolg
              ? Colors.green.shade700
              : null,
    ));
  }
}
