import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';

import '../l10n/app_localizations.dart';
import '../services/logger_service.dart';
import '../utils/app_theme.dart';
import '../utils/ordner_ablage.dart';
import '../utils/pdf_bilder.dart';

/// „PDF in Bilder": jede Seite eines eigenen PDF wird ein Bild — JPG, JPEG
/// oder PNG — in einem Ordner, den das Mitglied wählt.
///
/// ⚠️ Alles auf dem Gerät. Anders als beim Unterschreiben
/// (`PdfWerkzeugScreen`) geht hier nichts an den Server: pdfium rendert die
/// Seiten im Gerät, umgewandelt wird im Gerät, geschrieben wird in den
/// gewählten Ordner. Der Satz dazu steht auf dem Schirm, und er muss stimmen.
///
/// Der Ordner wird erst beim Start gewählt, nicht vorher: wer abbricht, hat
/// nichts verloren, und der Ordner gilt genau für diesen einen Lauf.
class PdfBilderScreen extends StatefulWidget {
  const PdfBilderScreen({super.key});

  @override
  State<PdfBilderScreen> createState() => _PdfBilderScreenState();
}

class _PdfBilderScreenState extends State<PdfBilderScreen> {
  final _log = LoggerService();

  /// Das mitgebrachte Dokument. Es wird nur gelesen, nie verändert.
  String? _pfad;
  PdfDocument? _dokument;
  bool _oeffnet = false;

  BildFormat _format = BildFormat.jpg;

  /// Die Seite, an der gerade gearbeitet wird (ab 1). 0: es läuft nichts.
  int _seite = 0;

  /// „Anhalten" gedrückt — gefragt wird vor jeder Seite.
  bool _anhalten = false;

  /// Die Ordnerauswahl ist offen. Ein zweiter Druck öffnete sonst eine
  /// zweite.
  bool _waehlt = false;

  bool get _laeuft => _seite > 0;

  @override
  void dispose() {
    _anhalten = true;
    // Läuft noch ein Durchgang, gibt ER das Dokument frei, sobald er die
    // laufende Seite beendet hat — sonst rendert er auf einem freigegebenen.
    if (!_laeuft) _dokument?.dispose();
    super.dispose();
  }

  // ── Dokument wählen ──

  Future<void> _dateiWaehlen() async {
    final l10n = AppLocalizations.of(context)!;

    final auswahl = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
    final pfad = auswahl?.path;
    if (pfad == null || !mounted) return;

    setState(() => _oeffnet = true);

    // Das alte Dokument erst freigeben, wenn das neue steht — wie beim
    // Unterschreiben: schlägt das Öffnen fehl, bleibt das alte stehen.
    PdfDocument? neu;
    try {
      neu = await PdfDocument.openFile(pfad);
    } catch (e) {
      _log.error('PDF öffnen: ${e.runtimeType}', tag: 'PDFBILD');
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

  // ── Umwandeln ──

  Future<void> _starten() async {
    final l10n = AppLocalizations.of(context)!;
    final dokument = _dokument;
    final pfad = _pfad;
    if (dokument == null || pfad == null || _laeuft) return;

    if (_waehlt) return;
    setState(() => _waehlt = true);
    ZielOrdner? ziel;
    try {
      ziel = await ordnerWaehlen(titel: l10n.pdfBilderOrdnerTitel);
    } catch (e) {
      _log.warning('Ordnerauswahl: ${e.runtimeType}', tag: 'PDFBILD');
      if (mounted) _meldung(l10n.pdfWerkzeugFehlerAllgemein, fehler: true);
      return;
    } finally {
      if (mounted) setState(() => _waehlt = false);
    }
    if (ziel == null) return;
    if (!mounted) {
      await ziel.schliessen();
      return;
    }

    final format = _format;
    final gesamt = dokument.pages.length;
    setState(() {
      _anhalten = false;
      _seite = 1;
    });

    BilderErgebnis? ergebnis;
    Object? fehler;
    try {
      ergebnis = await seitenAblegen(
        gesamt: gesamt,
        rendern: (i) => _rendern(dokument.pages[i]),
        ziel: ziel,
        basis: bildBasis(pfad),
        format: format,
        fortschritt: (seite) {
          if (mounted) setState(() => _seite = seite);
        },
        angehalten: () => _anhalten,
      );
    } catch (e) {
      fehler = e;
    } finally {
      await ziel.schliessen();
      if (mounted) {
        setState(() => _seite = 0);
      } else {
        dokument.dispose();
      }
    }

    // Im Protokoll steht die Tatsache, nie ein Datei- oder Ordnername.
    if (fehler != null) {
      _log.warning('PDF in Bilder: abgebrochen (${fehler.runtimeType})',
          tag: 'PDFBILD');
    } else {
      _log.info(
          'PDF in Bilder: ${ergebnis!.geschrieben} von $gesamt Seiten '
          '(${format.name}${ergebnis.angehalten ? ', angehalten' : ''})',
          tag: 'PDFBILD');
    }
    if (!mounted) return;

    if (fehler != null) {
      // Schreiben gescheitert heißt: dieser Ordner nimmt nichts an. Alles
      // andere ist ein Fehler, für den ein anderer Ordner nichts ändert.
      final ordnerFehler = fehler is FileSystemException ||
          (fehler is PlatformException && fehler.code == 'schreiben');
      _meldung(
        ordnerFehler
            ? l10n.pdfBilderFehlerOrdner
            : l10n.pdfWerkzeugFehlerAllgemein,
        fehler: true,
      );
      return;
    }

    final ordner = ziel.name.isEmpty ? '…' : ziel.name;
    final geschrieben = ergebnis!.geschrieben;
    if (ergebnis.angehalten) {
      _meldung(geschrieben == 0
          ? l10n.pdfBilderAngehaltenLeer
          : l10n.pdfBilderAngehalten(geschrieben, ordner));
    } else {
      _meldung(l10n.pdfBilderFertig(geschrieben, ordner), erfolg: true);
    }
  }

  /// Eine Seite in der Auflösung aus [seitenPixel], auf Weiß.
  Future<SeitenPixel> _rendern(PdfPage seite) async {
    final masse = seitenPixel(seite.width, seite.height);
    final bild = await seite.render(
      fullWidth: masse.breite.toDouble(),
      fullHeight: masse.hoehe.toDouble(),
      // Weiß, nicht durchsichtig: JPG kennt keine Durchsichtigkeit, und eine
      // Seite ist Papier.
      backgroundColor: 0xffffffff,
    );
    if (bild == null) {
      throw StateError('Seite ${seite.pageNumber} ließ sich nicht rendern');
    }
    try {
      // Eine Kopie im Dart-Speicher: pdfrx gibt seinen Puffer mit dispose()
      // frei, und das Umwandeln läuft in einem anderen Isolat.
      return (
        bgra: Uint8List.fromList(bild.pixels),
        breite: bild.width,
        hoehe: bild.height,
      );
    } finally {
      bild.dispose();
    }
  }

  // ── Aufbau ──

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Während des Laufs kein Zurück: der Durchgang schreibt in einen Ordner,
    // und „Anhalten" ist der Weg, ihn sauber zu beenden.
    return PopScope(
      canPop: !_laeuft,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.pdfBilderTitel)),
        body: _dokument == null ? _einstieg(l10n) : _werkbank(l10n),
      ),
    );
  }

  /// Der leere Zustand: was hier passiert, und ein Knopf.
  Widget _einstieg(AppLocalizations l10n) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library_outlined,
                size: 64, color: context.colors.textDisabled),
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
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.folder_open),
              label: Text(l10n.pdfWerkzeugDateiWaehlen),
            ),
            const SizedBox(height: 32),
            _hinweisAufDemGeraet(l10n),
          ],
        ),
      ),
    );
  }

  /// Steht auf beiden Zuständen und nicht in einem Dialog, den man wegtippt:
  /// es ist die Auskunft, die dieses Werkzeug vom Unterschreiben trennt.
  Widget _hinweisAufDemGeraet(AppLocalizations l10n) {
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
              l10n.pdfBilderAufDemGeraet,
              style: TextStyle(fontSize: 12, color: context.colors.infoFg),
            ),
          ),
        ],
      ),
    );
  }

  Widget _werkbank(AppLocalizations l10n) {
    final gesamt = _dokument!.pages.length;
    final name = _pfad!.split(RegExp(r'[/\\]')).last;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.picture_as_pdf_outlined,
                    color: context.colors.brandFill),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.pdfBilderSeiten(gesamt),
                        style: TextStyle(color: context.colors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                onPressed: _laeuft || _oeffnet ? null : _dateiWaehlen,
                icon: const Icon(Icons.folder_open, size: 18),
                label: Text(l10n.pdfWerkzeugDateiWaehlen),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.pdfBilderFormat,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<BildFormat>(
              segments: [
                for (final f in BildFormat.values)
                  ButtonSegment(value: f, label: Text(f.anzeige)),
              ],
              selected: {_format},
              showSelectedIcon: false,
              onSelectionChanged:
                  _laeuft ? null : (s) => setState(() => _format = s.first),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.pdfBilderJpgGleich,
              style:
                  TextStyle(fontSize: 12, color: context.colors.textSecondary),
            ),
            const SizedBox(height: 20),
            _hinweisAufDemGeraet(l10n),
            const SizedBox(height: 24),
            if (_laeuft) ...[
              LinearProgressIndicator(value: (_seite - 1) / gesamt),
              const SizedBox(height: 8),
              Text(
                '${l10n.pdfWerkzeugSeiteVon(_seite, gesamt)} …',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.colors.textSecondary),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed:
                    _anhalten ? null : () => setState(() => _anhalten = true),
                icon: const Icon(Icons.stop_circle_outlined),
                label: Text(l10n.pdfBilderAnhalten),
              ),
            ] else
              FilledButton.icon(
                onPressed: _waehlt ? null : _starten,
                icon: const Icon(Icons.create_new_folder_outlined),
                label: Text(l10n.pdfBilderStarten),
              ),
          ],
        ),
      ),
    );
  }

  void _meldung(String text, {bool fehler = false, bool erfolg = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: fehler
          ? context.colors.dangerFg
          : (erfolg ? context.colors.successSolid : null),
      duration: Duration(seconds: erfolg ? 8 : 4),
    ));
  }
}
