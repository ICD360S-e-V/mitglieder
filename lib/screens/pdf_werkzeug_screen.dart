import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:signature/signature.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/logger_service.dart';
import '../utils/app_theme.dart';
import '../widgets/file_viewer.dart';

/// Ein eigenes PDF unterschreiben, ohne es einer fremden Seite zu geben.
///
/// ─────────────────────────────────────────────────────────────────────────
/// DIES IST NICHT DIE DIGITALE UNTERSCHRIFT DES VEREINS.
///
/// [SignaturScreen] ist der andere Weg: dort legt der Verein ein Dokument vor,
/// es gibt eine TAN per SMS, ein Siegel, einen Zeitstempel und eine
/// Beweiskette, und das Ergebnis soll vor Gericht halten.
///
/// Hier hat das Mitglied privat einen Mietvertrag, ein Formular, eine
/// Kündigung. Es soll das Dokument nicht bei smallpdf oder ilovepdf hochladen
/// müssen, nur um seinen Namen daruntersetzen zu können. Also malt es hier —
/// ohne Datenbankzeile, ohne Code, ohne Siegel, ohne Beweiswert.
///
/// Die Trennung steht auch im Hinweistext, den das Mitglied sieht. Wer glaubt,
/// hier eine beweisfeste Unterschrift geleistet zu haben, hätte sich auf etwas
/// verlassen, das es nicht gibt — und das merkt er erst, wenn es darauf
/// ankommt.
/// ─────────────────────────────────────────────────────────────────────────
class PdfWerkzeugScreen extends StatefulWidget {
  final ApiService apiService;

  const PdfWerkzeugScreen({super.key, required this.apiService});

  @override
  State<PdfWerkzeugScreen> createState() => _PdfWerkzeugScreenState();
}

class _PdfWerkzeugScreenState extends State<PdfWerkzeugScreen> {
  final _log = LoggerService();

  /// Das mitgebrachte Dokument. Es bleibt liegen, wo es liegt — kopiert wird
  /// nichts, hochgeladen erst beim letzten Knopfdruck.
  String? _pfad;
  PdfDocument? _dokument;
  bool _oeffnet = false;

  /// 1-basiert, wie im PDF selbst gezählt. Eine 0-basierte Seite hier und eine
  /// 1-basierte auf dem Server wäre genau die Sorte Fehler, die sich erst am
  /// fertigen Dokument zeigt.
  int _seite = 1;

  /// Die Vorschau der gemalten Unterschrift und derselbe Strich als SVG. Das
  /// Bild ist für den Bildschirm, das SVG für das PDF: ein Bild würde beim
  /// Vergrößern ausfransen, der Pfad nicht.
  Uint8List? _vorschau;
  String? _svg;

  /// Breite geteilt durch Höhe des gemalten Strichs. Die Unterschrift wird
  /// später nur in der Breite verstellt; die Höhe folgt daraus, damit sie nie
  /// verzerrt im Dokument steht.
  double _strichVerhaeltnis = 3;

  /// Lage des Unterschriftsfeldes als Anteil der Seite. Anteile statt Pixel,
  /// weil derselbe Wert gleich für eine Seite in Millimetern gelten muss.
  double _x = 0.10;
  double _y = 0.75;
  double _breiteAnteil = 0.35;

  /// Maße des angezeigten Seitenkastens in Pixeln. Wird beim Bauen gesetzt und
  /// dient nur dazu, aus einer Breite die passende Höhe zu rechnen.
  Size _kasten = Size.zero;

  bool _mitDatum = false;
  bool _sendet = false;

  @override
  void dispose() {
    _dokument?.dispose();
    super.dispose();
  }

  // ── Dokument wählen ──

  Future<void> _dateiWaehlen() async {
    final l10n = AppLocalizations.of(context)!;

    final auswahl = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      withData: false,
    );
    final pfad = auswahl?.files.single.path;
    if (pfad == null || !mounted) return;

    // Die Grenze steht auch auf dem Server. Hier zusätzlich, weil ein Mitglied
    // mit einem 60-MB-Scan sonst erst nach dem Hochladen erfährt, dass es
    // nichts wird — über eine Mobilfunkverbindung sind das Minuten.
    final groesse = await File(pfad).length();
    if (!mounted) return;
    if (groesse > 20 * 1024 * 1024) {
      _meldung(l10n.pdfWerkzeugFehlerZuGross, fehler: true);
      return;
    }

    setState(() {
      _oeffnet = true;
      _svg = null;
      _vorschau = null;
      _seite = 1;
    });

    // Das alte Dokument erst freigeben, wenn das neue steht: schlägt das
    // Öffnen fehl, bleibt der Bildschirm sonst leer zurück und das Mitglied
    // hat beides verloren.
    PdfDocument? neu;
    try {
      neu = await PdfDocument.openFile(pfad);
    } catch (e) {
      _log.error('PDF öffnen: $e', tag: 'PDFWERK');
    }

    if (!mounted) {
      neu?.dispose();
      return;
    }

    if (neu == null) {
      setState(() => _oeffnet = false);
      _meldung(l10n.pdfWerkzeugFehlerOeffnen, fehler: true);
      return;
    }

    final alt = _dokument;
    setState(() {
      _dokument = neu;
      _pfad = pfad;
      _oeffnet = false;
    });
    alt?.dispose();
  }

  // ── Unterschrift malen ──

  Future<void> _unterschriftMalen() async {
    final ergebnis = await showModalBottomSheet<_Strich>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _UnterschriftBlatt(),
    );
    if (ergebnis == null || !mounted) return;

    setState(() {
      _svg = ergebnis.svg;
      _vorschau = ergebnis.png;
      _strichVerhaeltnis = ergebnis.verhaeltnis;
      // Breite auf einen Wert zurücksetzen, der auf jede Seite passt. Bliebe
      // eine vorher eingestellte Breite stehen, könnte ein hoher, schmaler
      // Strich unten aus dem Blatt laufen, ohne dass es jemand angefasst hat.
      _breiteAnteil = 0.35;
      _x = 0.10;
      _y = 0.75;
    });
  }

  /// Höhe des Feldes als Anteil der Seitenhöhe.
  ///
  /// Der Umweg über die Pixel des angezeigten Kastens ist nötig, weil ein
  /// Anteil der Breite und ein Anteil der Höhe auf einer nicht quadratischen
  /// Seite verschiedene Längen sind. Ohne ihn stünde die Unterschrift im
  /// Dokument gestaucht oder gestreckt — auf einer A4-Seite um gut 40 %.
  double get _hoeheAnteil {
    if (_kasten.width <= 0 || _kasten.height <= 0) return 0.1;
    final breitePx = _breiteAnteil * _kasten.width;
    final hoehePx = breitePx / _strichVerhaeltnis;
    return (hoehePx / _kasten.height).clamp(0.01, 1.0);
  }

  // ── Absenden ──

  Future<void> _einsetzen() async {
    final l10n = AppLocalizations.of(context)!;
    final pfad = _pfad;
    final svg = _svg;
    if (pfad == null || svg == null) return;

    setState(() => _sendet = true);

    final antwort = await widget.apiService.pdfWerkzeugUnterschreiben(
      pdfPfad: pfad,
      unterschriftSvg: svg,
      seite: _seite,
      x: _x.clamp(0.0, 1.0),
      y: _y.clamp(0.0, 1.0),
      breite: _breiteAnteil.clamp(0.0, 1.0),
      hoehe: _hoeheAnteil,
      mitDatum: _mitDatum,
    );

    if (!mounted) return;
    setState(() => _sendet = false);

    final bytes = antwort.pdf;
    if (bytes == null) {
      _meldung(antwort.fehler ?? l10n.pdfWerkzeugFehlerAllgemein, fehler: true);
      return;
    }

    await _ablegen(bytes, pfad);
  }

  /// Legt das fertige Dokument dorthin, wo das Mitglied es wiederfindet.
  Future<void> _ablegen(Uint8List bytes, String quellPfad) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      // Auf dem Schreibtisch gibt es einen Download-Ordner, auf dem Telefon
      // nicht — dort ist das App-Verzeichnis der einzige Ort, in den ohne
      // zusätzliche Berechtigung geschrieben werden darf.
      final Directory ziel = (Platform.isMacOS || Platform.isWindows || Platform.isLinux)
          ? (await getDownloadsDirectory()) ?? await getApplicationDocumentsDirectory()
          : await getApplicationDocumentsDirectory();

      final ausgang = quellPfad.split(RegExp(r'[/\\]')).last;
      final ohneEndung = ausgang.toLowerCase().endsWith('.pdf')
          ? ausgang.substring(0, ausgang.length - 4)
          : ausgang;
      final name = '${ohneEndung}_unterschrieben.pdf';

      final datei = File('${ziel.path}/$name');
      await datei.writeAsBytes(bytes);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l10n.pdfWerkzeugFertig),
        backgroundColor: context.colors.successSolid,
        duration: const Duration(seconds: 8),
        action: SnackBarAction(
          label: l10n.pdfWerkzeugOeffnen,
          textColor: Colors.white,
          onPressed: () => FileViewer.open(context, datei, name),
        ),
      ));
    } catch (e) {
      _log.error('Ablegen: $e', tag: 'PDFWERK');
      if (mounted) _meldung(l10n.pdfWerkzeugFehlerAllgemein, fehler: true);
    }
  }

  // ── Aufbau ──

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pdfWerkzeugTitel)),
      body: _dokument == null ? _einstieg(l10n) : _werkbank(l10n),
    );
  }

  /// Der leere Zustand: der Hinweis, wofür das hier gut ist, und ein Knopf.
  Widget _einstieg(AppLocalizations l10n) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.draw_outlined, size: 64, color: context.colors.textDisabled),
            const SizedBox(height: 20),
            Text(
              l10n.pdfWerkzeugKeineDatei,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.colors.textSecondary),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _oeffnet ? null : _dateiWaehlen,
              icon: _oeffnet
                  ? const SizedBox(
                      width: 18, height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.folder_open),
              label: Text(l10n.pdfWerkzeugDateiWaehlen),
            ),
            const SizedBox(height: 32),
            _rechtlicherHinweis(l10n),
          ],
        ),
      ),
    );
  }

  /// Steht auf dem Einstieg und nicht in einem Dialog, den man wegtippt.
  ///
  /// Der Satz ist der einzige Ort, an dem das Mitglied erfährt, dass diese
  /// Unterschrift nichts beweist. Hinter einem „Verstanden"-Knopf hätte ihn
  /// beim zweiten Mal niemand mehr gelesen.
  Widget _rechtlicherHinweis(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.infoBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.infoBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 18, color: context.colors.infoFg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.pdfWerkzeugHinweisRechtlich,
              style: TextStyle(fontSize: 12, color: context.colors.infoFg),
            ),
          ),
        ],
      ),
    );
  }

  Widget _werkbank(AppLocalizations l10n) {
    final dokument = _dokument!;
    final seiten = dokument.pages.length;
    final seite = dokument.pages[_seite - 1];
    final verhaeltnis = seite.width / seite.height;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: AspectRatio(
                aspectRatio: verhaeltnis,
                child: LayoutBuilder(
                  builder: (context, grenzen) {
                    // Der Kasten ist die ganze Seite. Jede Zahl im Zustand ist
                    // ein Anteil davon, also unabhängig von Bildschirmgröße
                    // und Drehung — beim Kippen des Geräts wandert die
                    // Unterschrift deshalb nicht.
                    final kasten = Size(grenzen.maxWidth, grenzen.maxHeight);
                    if (kasten != _kasten) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) setState(() => _kasten = kasten);
                      });
                    }

                    return Stack(
                      children: [
                        Positioned.fill(
                          child: PdfPageView(
                            document: dokument,
                            pageNumber: _seite,
                            alignment: Alignment.center,
                          ),
                        ),
                        if (_vorschau != null) _unterschriftsFeld(kasten),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        _fussleiste(l10n, seiten),
      ],
    );
  }

  /// Das verschiebbare Feld mit der gemalten Unterschrift.
  Widget _unterschriftsFeld(Size kasten) {
    final breitePx = _breiteAnteil * kasten.width;
    final hoehePx = breitePx / _strichVerhaeltnis;
    final linksPx = _x * kasten.width;
    final obenPx = _y * kasten.height;

    return Positioned(
      left: linksPx,
      top: obenPx,
      width: breitePx,
      height: hoehePx,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanUpdate: (details) {
              setState(() {
                // Geklemmt wird an der Kante, an der das Feld herausliefe —
                // nicht an 0…1 für die linke obere Ecke allein. Sonst ließe
                // sich die Unterschrift bis zur rechten Kante schieben und
                // ragte mit ihrer Breite darüber hinaus.
                _x = (_x + details.delta.dx / kasten.width)
                    .clamp(0.0, (1 - _breiteAnteil).clamp(0.0, 1.0));
                _y = (_y + details.delta.dy / kasten.height)
                    .clamp(0.0, (1 - _hoeheAnteil).clamp(0.0, 1.0));
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.colors.brandFill,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              // Das gemalte PNG ist außerhalb des Strichs durchsichtig, es
              // deckt den Text darunter also nicht zu — genau wie später im
              // PDF.
              child: Image.memory(_vorschau!, fit: BoxFit.fill),
            ),
          ),
          // Der Griff zum Vergrößern. Unten rechts, weil dort links und oben
          // das Feld steht und der Finger nichts verdeckt, was gerade wichtig
          // wäre.
          Positioned(
            right: -14,
            bottom: -14,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: (details) {
                setState(() {
                  _breiteAnteil = (_breiteAnteil + details.delta.dx / kasten.width)
                      .clamp(0.08, (1 - _x).clamp(0.08, 1.0));
                });
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: context.colors.brandFill,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.open_in_full,
                    size: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fussleiste(AppLocalizations l10n, int seiten) {
    final hatUnterschrift = _svg != null;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.colors.divider)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Blättern. Die Unterschrift bleibt dabei stehen, wo sie steht —
            // sie gehört zu der Seite, auf der man sie absetzt, und das ist
            // die, die gerade zu sehen ist.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _seite > 1 ? () => setState(() => _seite--) : null,
                ),
                Text(
                  l10n.pdfWerkzeugSeiteVon(_seite, seiten),
                  style: TextStyle(color: context.colors.textSecondary),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _seite < seiten ? () => setState(() => _seite++) : null,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _sendet ? null : _dateiWaehlen,
                  icon: const Icon(Icons.folder_open, size: 18),
                  label: Text(l10n.pdfWerkzeugDateiWaehlen),
                ),
              ],
            ),
            if (hatUnterschrift) ...[
              Text(
                l10n.pdfWerkzeugPlatzierenHinweis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: context.colors.textSecondary),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      value: _mitDatum,
                      onChanged: (wert) => setState(() => _mitDatum = wert ?? false),
                      title: Text(l10n.pdfWerkzeugMitDatum,
                          style: const TextStyle(fontSize: 13)),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _sendet ? null : _unterschriftMalen,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text(l10n.pdfWerkzeugUnterschriftNochmal),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _sendet
                    ? null
                    : (hatUnterschrift ? _einsetzen : _unterschriftMalen),
                icon: _sendet
                    ? const SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Icon(hatUnterschrift ? Icons.check : Icons.draw),
                label: Text(_sendet
                    ? l10n.pdfWerkzeugLaeuft
                    : (hatUnterschrift
                        ? l10n.pdfWerkzeugFertigstellen
                        : l10n.pdfWerkzeugUnterschriftMalen)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _meldung(String text, {bool fehler = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: fehler ? context.colors.dangerFg : null,
    ));
  }
}

// ───────────────────────────────────────────────────────────────────────────

/// Was von der Zeichenfläche zurückkommt.
class _Strich {
  final String svg;
  final Uint8List png;

  /// Breite geteilt durch Höhe des gemalten Strichs.
  final double verhaeltnis;

  const _Strich(this.svg, this.png, this.verhaeltnis);
}

/// Die Zeichenfläche.
class _UnterschriftBlatt extends StatefulWidget {
  const _UnterschriftBlatt();

  @override
  State<_UnterschriftBlatt> createState() => _UnterschriftBlattState();
}

class _UnterschriftBlattState extends State<_UnterschriftBlatt> {
  final _steuerung = SignatureController(
    penStrokeWidth: 3,
    // Schwarz, auch im dunklen Modus: dieser Strich landet auf weißem Papier.
    // Eine helle Unterschrift wäre dort unsichtbar. Dieselbe Begründung wie
    // im Unterschriftsbildschirm des Vereins.
    penColor: Colors.black,
    // Kein exportBackgroundColor: der Strich bleibt durchsichtig und sitzt im
    // PDF auf dem Text statt in einem weißen Kasten, der ihn zudeckt.
  );

  bool _rechnet = false;

  @override
  void dispose() {
    _steuerung.dispose();
    super.dispose();
  }

  Future<void> _uebernehmen() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _rechnet = true);

    final svg = _steuerung.toRawSVG();
    final png = await _steuerung.toPngBytes();
    // Beides kommt aus demselben Strich und hat damit dasselbe Verhältnis:
    // die Vorschau auf dem Bildschirm zeigt genau das, was im PDF steht.
    final breite = _steuerung.defaultWidth;
    final hoehe = _steuerung.defaultHeight;

    if (!mounted) return;

    if (svg == null || svg.isEmpty || png == null ||
        breite == null || hoehe == null || hoehe == 0) {
      setState(() => _rechnet = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pdfWerkzeugLeer)),
      );
      return;
    }

    Navigator.pop(context, _Strich(svg, png, breite / hoehe));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        left: 16, right: 16, top: 16,
        // Die Tastatur spielt hier keine Rolle, das Systemmenü unten schon:
        // ohne diesen Abstand liegen die Knöpfe unter der Wischleiste.
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.pdfWerkzeugUnterschriftMalen,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              // Helle Fläche in beiden Themes: sie ist die Vorschau des
              // Papiers, auf dem der Strich landet, nicht Teil der Oberfläche.
              color: Colors.white,
              border: Border.all(color: context.colors.textDisabled),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Signature(
              controller: _steuerung,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => setState(_steuerung.clear),
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(l10n.pdfWerkzeugUnterschriftNochmal),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
              const SizedBox(width: 8),
              // Der Knopf hört direkt auf die Zeichenfläche statt auf ein
              // setState bei jedem Strich: er soll auf den ersten Punkt
              // reagieren, ohne dass dabei die Fläche neu gebaut wird.
              ValueListenableBuilder<List<Point>>(
                valueListenable: _steuerung,
                builder: (_, punkte, __) => FilledButton(
                  onPressed: punkte.isEmpty || _rechnet ? null : _uebernehmen,
                  child: Text(l10n.pdfWerkzeugUebernehmen),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
