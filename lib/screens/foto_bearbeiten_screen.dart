import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import '../l10n/app_localizations.dart';
import '../services/logger_service.dart';
import '../utils/app_theme.dart';
import '../utils/foto_bearbeiten.dart';
import '../utils/foto_quelle.dart';

/// „Foto bearbeiten" (Photo Edit): ein Ordner oder ein einzelnes Foto,
/// bearbeitet wie in Microsofts „Fotos" — Zuschneiden, Anpassen, Filter,
/// Zeichnen, Text, Größe.
///
/// ⚠️ Alles auf dem Gerät, nichts geht an den Server. Der Satz dazu steht im
/// ersten Fenster, und er muss stimmen.
///
/// ⚠️ Das Original bleibt unangetastet: gespeichert wird immer eine Kopie.
/// Erst danach fragt die App, ob das Original weg soll.
///
/// Im Protokoll (Tag `FOTOEDIT`) stehen nie Datei- oder Ordnernamen.
enum FotoWahl { ordner, foto }

/// Aus dem Stern-Fenster: erst die Wahl, dann die Auswahl des Systems, dann
/// Übersicht oder Editor.
Future<void> fotoBearbeitenStarten(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);

  final wahl = await showDialog<FotoWahl>(
    context: context,
    builder: (_) => const FotoBearbeitenAuswahl(),
  );
  if (wahl == null) return;

  try {
    switch (wahl) {
      case FotoWahl.ordner:
        final quelle = await fotoOrdnerWaehlen(titel: l10n.fotoEditOrdnerTitel);
        if (quelle == null) return;
        await navigator.push(MaterialPageRoute<void>(
          builder: (_) => FotoOrdnerScreen(quelle: quelle),
        ));
      case FotoWahl.foto:
        final auswahl = await einzelFotoWaehlen();
        if (auswahl == null) return;
        await navigator.push(MaterialPageRoute<void>(
          builder: (_) => FotoEditorScreen(
            quelle: auswahl.$1,
            eintraege: [auswahl.$2],
            index: 0,
          ),
        ));
    }
  } catch (e) {
    LoggerService().warning('Auswahl: ${e.runtimeType}', tag: 'FOTOEDIT');
    messenger.showSnackBar(SnackBar(content: Text(l10n.fotoEditFehlerOeffnen)));
  }
}

/// Das erste Fenster: Ordner oder ein Foto.
class FotoBearbeitenAuswahl extends StatelessWidget {
  const FotoBearbeitenAuswahl({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        // Wie das Stern-Fenster: auf dem Tablet nicht über die ganze Breite.
        constraints: const BoxConstraints(maxWidth: 420),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.extrasFotoEditTitel,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              _WahlKnopf(
                symbol: Icons.folder_open_outlined,
                titel: l10n.fotoEditOrdnerOeffnen,
                text: l10n.fotoEditOrdnerOeffnenText,
                onDruck: () => Navigator.pop(context, FotoWahl.ordner),
              ),
              const SizedBox(height: 10),
              _WahlKnopf(
                symbol: Icons.photo_outlined,
                titel: l10n.fotoEditFotoOeffnen,
                text: l10n.fotoEditFotoOeffnenText,
                onDruck: () => Navigator.pop(context, FotoWahl.foto),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: context.colors.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.fotoEditAufDemGeraet,
                      style: TextStyle(
                          fontSize: 12, color: context.colors.textSecondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WahlKnopf extends StatelessWidget {
  const _WahlKnopf({
    required this.symbol,
    required this.titel,
    required this.text,
    required this.onDruck,
  });

  final IconData symbol;
  final String titel;
  final String text;
  final VoidCallback onDruck;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.colors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onDruck,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(symbol, color: context.colors.brandFill),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titel,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: 12, color: context.colors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Ordner: Übersicht ──

/// Alle Fotos eines Ordners, neueste zuerst. Antippen öffnet den Editor.
class FotoOrdnerScreen extends StatefulWidget {
  const FotoOrdnerScreen({super.key, required this.quelle});

  final FotoQuelle quelle;

  @override
  State<FotoOrdnerScreen> createState() => _FotoOrdnerScreenState();
}

class _FotoOrdnerScreenState extends State<FotoOrdnerScreen> {
  final _log = LoggerService();

  List<FotoEintrag>? _eintraege;
  bool _fehler = false;

  /// Einmal geladen, bleibt eine Vorschau, solange die Übersicht steht —
  /// beim Zurückscrollen soll nichts neu von der Platte kommen.
  final _vorschauen = <String, Future<Uint8List?>>{};

  @override
  void initState() {
    super.initState();
    _laden();
  }

  @override
  void dispose() {
    // Die Übersicht gehört zum Ordner: wird sie geschlossen, ist er fertig.
    unawaited(widget.quelle.schliessen());
    super.dispose();
  }

  Future<void> _laden() async {
    try {
      final liste = await widget.quelle.auflisten();
      if (!mounted) return;
      setState(() {
        _eintraege = liste;
        _fehler = false;
      });
    } catch (e) {
      _log.warning('Ordner lesen: ${e.runtimeType}', tag: 'FOTOEDIT');
      if (mounted) setState(() => _fehler = true);
    }
  }

  Future<void> _oeffnen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => FotoEditorScreen(
          quelle: widget.quelle,
          eintraege: _eintraege!,
          index: index,
        ),
      ),
    );
    // Gespeicherte Kopien und gelöschte Originale sollen sich zeigen.
    if (!mounted) return;
    _vorschauen.clear();
    await _laden();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final liste = _eintraege;
    final name = widget.quelle.name.isEmpty ? '…' : widget.quelle.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          liste == null ? name : l10n.fotoEditOrdnerKopf(liste.length, name),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _fehler
          ? _hinweis(l10n.fotoEditFehlerOrdner)
          : liste == null
              ? const Center(child: CircularProgressIndicator())
              : liste.isEmpty
                  ? _hinweis(l10n.fotoEditOrdnerLeer)
                  : _raster(liste),
    );
  }

  Widget _hinweis(String text) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.colors.textSecondary),
          ),
        ),
      );

  Widget _raster(List<FotoEintrag> liste) {
    // Auf dem Telefon drei nebeneinander, auf dem Rechner so viele, wie passen.
    const kachel = 140.0;
    final px = (kachel * MediaQuery.devicePixelRatioOf(context))
        .round()
        .clamp(128, 512);

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: kachel,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: liste.length,
      itemBuilder: (context, i) {
        final eintrag = liste[i];
        return Tooltip(
          message: eintrag.name,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: context.colors.dividerSubtle,
              child: InkWell(
                onTap: () => _oeffnen(i),
                child: _vorschau(eintrag, px),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _vorschau(FotoEintrag eintrag, int px) {
    final pfad = eintrag.pfad;
    if (pfad != null) {
      // Am Rechner direkt von der Platte, verkleinert dekodiert.
      return Image.file(
        File(pfad),
        cacheWidth: px,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _platzhalter(),
      );
    }
    final vorschau = _vorschauen.putIfAbsent(
      eintrag.schluessel,
      () => widget.quelle.vorschau(eintrag, px),
    );
    return FutureBuilder<Uint8List?>(
      future: vorschau,
      builder: (context, s) {
        final bytes = s.data;
        if (bytes != null) {
          return Image.memory(bytes, fit: BoxFit.cover, gaplessPlayback: true);
        }
        return s.connectionState == ConnectionState.done
            ? _platzhalter()
            : const SizedBox.expand();
      },
    );
  }

  Widget _platzhalter() => Center(
        child: Icon(Icons.image_outlined, color: context.colors.textDisabled),
      );
}

// ── Editor ──

/// Ein Foto im Editor. Im Ordner blättert `<` / `>` durch die übrigen.
class FotoEditorScreen extends StatefulWidget {
  const FotoEditorScreen({
    super.key,
    required this.quelle,
    required this.eintraege,
    required this.index,
  });

  final FotoQuelle quelle;
  final List<FotoEintrag> eintraege;
  final int index;

  @override
  State<FotoEditorScreen> createState() => _FotoEditorScreenState();
}

class _FotoEditorScreenState extends State<FotoEditorScreen> {
  final _log = LoggerService();

  late List<FotoEintrag> _eintraege = widget.eintraege;
  late int _index = widget.index;

  /// Das Original, wie es in den Editor geht. `null`: wird geladen.
  Uint8List? _bytes;
  String? _fehler;

  /// Was unter „Größe" eingestellt ist — gilt für dieses eine Foto.
  FotoGroesse _groesse = const FotoGroesse();

  /// Speichern oder Löschen läuft.
  bool _arbeitet = false;

  /// Zählt die geladenen Fotos: jedes bekommt einen frischen Editor, ohne den
  /// Verlauf des vorigen.
  int _ladung = 0;

  FotoEintrag get _eintrag => _eintraege[_index];

  @override
  void initState() {
    super.initState();
    _laden(erstesMal: true);
  }

  /// [erstesMal]: aus initState — dort ist noch nichts zurückzusetzen, und
  /// weder setState noch die Texte der Sprache sind dort schon erlaubt.
  Future<void> _laden({bool erstesMal = false}) async {
    final eintrag = _eintrag;
    if (!erstesMal) {
      setState(() {
        _bytes = null;
        _fehler = null;
        _groesse = const FotoGroesse();
      });
    }
    try {
      final bytes = await widget.quelle.lesen(eintrag);
      await _pruefen(bytes);
      if (!mounted || !identical(eintrag, _eintrag)) return;
      setState(() {
        _bytes = bytes;
        _ladung++;
      });
    } on HeicNichtMoeglich {
      if (mounted) {
        setState(() =>
            _fehler = AppLocalizations.of(context)!.fotoEditHeicNichtHier);
      }
    } catch (e) {
      _log.warning('Foto öffnen: ${e.runtimeType}', tag: 'FOTOEDIT');
      if (mounted) {
        setState(() =>
            _fehler = AppLocalizations.of(context)!.fotoEditFehlerOeffnen);
      }
    }
  }

  /// Kann Flutter das Bild dekodieren? Sonst zeigte der Editor nur Schwarz.
  /// Klein dekodiert: es geht nur ums Ob.
  static Future<void> _pruefen(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes, targetWidth: 64);
    try {
      (await codec.getNextFrame()).image.dispose();
    } finally {
      codec.dispose();
    }
  }

  Future<void> _wechseln(ProImageEditorState? editor, int neu) async {
    if (_arbeitet || neu < 0 || neu >= _eintraege.length) return;
    if (editor != null && editor.canUndo && !await _verwerfenFragen()) return;
    if (!mounted) return;
    setState(() => _index = neu);
    await _laden();
  }

  Future<bool> _verwerfenFragen() async {
    final l10n = AppLocalizations.of(context)!;
    final ja = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.fotoEditVerwerfenTitel),
        content: Text(l10n.fotoEditVerwerfenText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.fotoEditVerwerfen),
          ),
        ],
      ),
    );
    return ja ?? false;
  }

  // ── Speichern ──

  Future<void> _speichern(ProImageEditorState editor) async {
    if (_arbeitet) return;
    final l10n = AppLocalizations.of(context)!;
    final eintrag = _eintrag;
    final format = _groesse.format ?? FotoFormat.wieOriginal(eintrag.name);

    setState(() => _arbeitet = true);
    String? gespeichert;
    try {
      // Das Bild mit allen Änderungen, in voller Größe (`fotoMaxKante`).
      final roh = await editor.captureEditorImage();
      final kopie = await fotoKodieren(roh, _groesse, format);
      gespeichert = await widget.quelle.kopieSpeichern(
        eintrag,
        dateiname: kopieName(eintrag.name, l10n.fotoEditDateiZusatz, format),
        bytes: kopie.bytes,
        mime: format.mime,
      );
    } catch (e) {
      _log.warning('Speichern: ${e.runtimeType}', tag: 'FOTOEDIT');
      if (mounted) {
        setState(() => _arbeitet = false);
        _meldung(l10n.fotoEditFehlerSpeichern, fehler: true);
      }
      return;
    }
    if (!mounted) return;
    setState(() => _arbeitet = false);

    if (gespeichert == null) {
      // Im Speichern-Dialog abgebrochen: die Arbeit ist noch da, „Speichern"
      // ruft den Dialog wieder auf.
      _meldung(l10n.fotoEditNichtGespeichert);
      return;
    }
    _log.info('Kopie gespeichert (${format.name})', tag: 'FOTOEDIT');

    // Ohne Schlüssel (iPhone ohne Kennung in „Fotos") lässt sich nichts
    // löschen — dann auch nicht fragen.
    final loeschen = eintrag.schluessel.isNotEmpty &&
        (await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (_) => FotoGespeichertDialog(
                kopie: gespeichert!,
                original: eintrag.name,
                inFotosApp: widget.quelle.inFotosApp,
              ),
            ) ??
            false);
    if (!mounted) return;

    if (eintrag.schluessel.isEmpty) {
      _meldung(l10n.fotoEditGespeichertTitel, erfolg: true);
    } else if (loeschen) {
      setState(() => _arbeitet = true);
      var geloescht = false;
      try {
        geloescht = await widget.quelle.originalLoeschen(eintrag);
      } catch (e) {
        _log.warning('Original löschen: ${e.runtimeType}', tag: 'FOTOEDIT');
      }
      _log.info('Original ${geloescht ? 'gelöscht' : 'nicht gelöscht'}',
          tag: 'FOTOEDIT');
      if (!mounted) return;
      setState(() => _arbeitet = false);
      _meldung(
        geloescht
            ? l10n.fotoEditOriginalGeloescht
            : l10n.fotoEditOriginalNichtGeloescht,
        erfolg: geloescht,
        fehler: !geloescht,
      );
    }

    if (!widget.quelle.istOrdner) {
      // Ein einzelnes Foto ist mit dem Speichern fertig.
      Navigator.pop(context);
      return;
    }
    await _nachDemSpeichern(gespeichert);
  }

  /// Im Ordner: die Liste neu lesen und mit der gespeicherten Kopie weiter —
  /// sie ist jetzt das, was das Mitglied sieht; das Original ist vielleicht weg.
  Future<void> _nachDemSpeichern(String name) async {
    List<FotoEintrag> liste;
    try {
      liste = await widget.quelle.auflisten();
    } catch (e) {
      _log.warning('Ordner neu lesen: ${e.runtimeType}', tag: 'FOTOEDIT');
      return;
    }
    if (!mounted) return;
    if (liste.isEmpty) {
      Navigator.pop(context);
      return;
    }
    var neu = liste.indexWhere((e) => e.name == name);
    if (neu < 0) neu = _index.clamp(0, liste.length - 1);
    setState(() {
      _eintraege = liste;
      _index = neu;
    });
    await _laden();
  }

  // ── Größe ──

  Future<void> _groesseOeffnen(ProImageEditorState editor) async {
    final bytes = _bytes;
    if (bytes == null || _arbeitet) return;
    final eintrag = _eintrag;
    // Schon jetzt anstoßen: das Bild mit allen Änderungen braucht bei
    // 12 Megapixel eine Weile, das Fenster soll derweil schon stehen.
    final aktuell = editor.captureEditorImage();
    final neu = await showModalBottomSheet<FotoGroesse>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => FotoGroessePanel(
        start: _groesse,
        standardFormat: FotoFormat.wieOriginal(eintrag.name),
        jetztMasse: fotoMasse(bytes),
        jetztBytes: eintrag.groesse ?? bytes.length,
        bild: aktuell,
      ),
    );
    if (neu != null && mounted) setState(() => _groesse = neu);
  }

  // ── Aufbau ──

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bytes = _bytes;

    // Ein Scaffold aus flutter/material um den Editor: dessen eigenes kommt
    // aus material_ui und meldet sich nicht beim ScaffoldMessenger der App —
    // Meldungen landeten sonst auf dem Bildschirm darunter, unsichtbar.
    return Scaffold(
      backgroundColor: Colors.black,
      body: PopScope(
        // Während gespeichert oder gelöscht wird, kein Zurück.
        canPop: !_arbeitet,
        child: Stack(
          children: [
            if (bytes == null)
              _ladenOderFehler(l10n)
            else
              ProImageEditor.memory(
                bytes,
                key: ValueKey(_ladung),
                callbacks: const ProImageEditorCallbacks(),
                configs: _einstellungen(l10n),
              ),
            if (_arbeitet) ...[
              const ModalBarrier(dismissible: false, color: Colors.black54),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      l10n.fotoEditSpeichert,
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _ladenOderFehler(AppLocalizations l10n) {
    final fehler = _fehler;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(_eintrag.name, overflow: TextOverflow.ellipsis),
      ),
      body: Center(
        child: fehler == null
            ? const CircularProgressIndicator(color: Colors.white)
            : Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  fehler,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
      ),
      // Ein Foto, das sich nicht öffnen lässt, soll das Blättern nicht beenden.
      bottomNavigationBar: _blaettern(l10n, null) == null
          ? null
          : ColoredBox(
              color: Colors.black,
              child: SafeArea(top: false, child: _blaettern(l10n, null)!),
            ),
    );
  }

  ProImageEditorConfigs _einstellungen(AppLocalizations l10n) {
    return ProImageEditorConfigs(
      i18n: _texte(l10n),
      imageGeneration: const ImageGenerationConfigs(
        // ⚠️ Ohne das verkleinert das Paket auf 2000 × 2000 (`fotoMaxKante`).
        maxOutputSize: Size(fotoMaxKante + 0.0, fotoMaxKante + 0.0),
      ),
      mainEditor: MainEditorConfigs(
        widgets: MainEditorWidgets(
          appBar: (editor, neu) => ReactiveAppbar(
            stream: neu,
            builder: (_) => _obereLeiste(editor, l10n),
          ),
          bottomBar: (editor, neu, key) => ReactiveWidget(
            stream: neu,
            builder: (_) => _untereLeiste(editor, key, l10n),
          ),
          closeWarningDialog: (_) => _verwerfenFragen(),
        ),
      ),
      // Ohne Sechseck, Vieleck und gestrichelte Linien: Microsofts „Fotos" hat
      // sie nicht, und jede weitere Taste ist eine mehr, die man suchen muss.
      // Verpixeln und Weichzeichnen bleiben — damit verschwindet eine IBAN
      // oder Ausweisnummer, bevor das Foto weitergeht.
      paintEditor: const PaintEditorConfigs(
        tools: [
          PaintMode.moveAndZoom,
          PaintMode.freeStyle,
          PaintMode.arrow,
          PaintMode.line,
          PaintMode.rect,
          PaintMode.circle,
          PaintMode.pixelate,
          PaintMode.blur,
          PaintMode.eraser,
        ],
      ),
      cropRotateEditor: CropRotateEditorConfigs(
        aspectRatios: [
          AspectRatioItem(text: l10n.fotoEditFrei, value: -1),
          AspectRatioItem(text: l10n.fotoEditOriginal, value: 0.0),
          const AspectRatioItem(text: '1:1', value: 1.0),
          const AspectRatioItem(text: '4:3', value: 4.0 / 3.0),
          const AspectRatioItem(text: '3:4', value: 3.0 / 4.0),
          const AspectRatioItem(text: '16:9', value: 16.0 / 9.0),
          const AspectRatioItem(text: '9:16', value: 9.0 / 16.0),
        ],
      ),
    );
  }

  PreferredSizeWidget _obereLeiste(
      ProImageEditorState editor, AppLocalizations l10n) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: _arbeitet ? null : editor.closeEditor,
      ),
      actions: [
        IconButton(
          tooltip: l10n.fotoEditRueckgaengig,
          icon: const Icon(Icons.undo),
          color: Colors.white,
          disabledColor: Colors.white38,
          onPressed: editor.canUndo && !_arbeitet ? editor.undoAction : null,
        ),
        IconButton(
          tooltip: l10n.fotoEditWiederholen,
          icon: const Icon(Icons.redo),
          color: Colors.white,
          disabledColor: Colors.white38,
          onPressed: editor.canRedo && !_arbeitet ? editor.redoAction : null,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, end: 8),
          child: FilledButton(
            onPressed: _arbeitet ? null : () => _speichern(editor),
            child: Text(l10n.save),
          ),
        ),
      ],
    );
  }

  /// Zwei Reihen zu drei: auf einem 411 dp breiten Telefon passen sechs
  /// Tasten nebeneinander nur mit abgeschnittenen Namen — und auf Deutsch oder
  /// Russisch erst recht nicht. Nichts muss zur Seite geschoben werden.
  Widget _untereLeiste(
      ProImageEditorState editor, Key key, AppLocalizations l10n) {
    final blaettern = _blaettern(l10n, editor);
    // ⚠️ Material, kein Container: der Editor baut auf material_ui, und
    // dessen Fläche zählt für InkWell und IconButton aus flutter/material
    // nicht — ohne eigene Fläche werfen sie „No Material widget found".
    return Material(
      // ⚠️ Der Schlüssel muss hier stehen: der Editor misst damit die Leiste.
      key: key,
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (blaettern != null) blaettern,
            Row(
              children: [
                _werkzeug(Icons.crop_rotate, l10n.fotoEditZuschneiden,
                    editor.openCropRotateEditor),
                _werkzeug(
                    Icons.tune, l10n.fotoEditAnpassen, editor.openTuneEditor),
                _werkzeug(Icons.photo_filter_outlined, l10n.fotoEditFilter,
                    editor.openFilterEditor),
              ],
            ),
            Row(
              children: [
                _werkzeug(Icons.brush_outlined, l10n.fotoEditZeichnen,
                    editor.openPaintEditor),
                _werkzeug(Icons.text_fields, l10n.fotoEditText,
                    () => editor.openTextEditor()),
                _werkzeug(
                  Icons.photo_size_select_large_outlined,
                  l10n.fotoEditGroesse,
                  () => _groesseOeffnen(editor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// `< 3 von 24 >` — nur im Ordner mit mehr als einem Foto.
  Widget? _blaettern(AppLocalizations l10n, ProImageEditorState? editor) {
    if (!widget.quelle.istOrdner || _eintraege.length < 2) return null;
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          color: Colors.white,
          disabledColor: Colors.white38,
          tooltip: MaterialLocalizations.of(context).previousPageTooltip,
          onPressed: _index > 0 && !_arbeitet
              ? () => _wechseln(editor, _index - 1)
              : null,
        ),
        Expanded(
          child: Text(
            l10n.fotoEditPosition(_index + 1, _eintraege.length),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          color: Colors.white,
          disabledColor: Colors.white38,
          tooltip: MaterialLocalizations.of(context).nextPageTooltip,
          onPressed: _index < _eintraege.length - 1 && !_arbeitet
              ? () => _wechseln(editor, _index + 1)
              : null,
        ),
      ],
    );
  }

  Widget _werkzeug(IconData symbol, String text, VoidCallback onDruck) {
    return Expanded(
      child: InkWell(
        onTap: _arbeitet ? null : onDruck,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(symbol, color: Colors.white, size: 22),
              const SizedBox(height: 4),
              Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
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
      duration: Duration(seconds: erfolg ? 6 : 4),
    ));
  }

  /// Die Texte des Editors in der Sprache des Mitglieds. Doppelte (Zurück,
  /// Fertig, Rückgängig …) kommen aus einem Schlüssel.
  static I18n _texte(AppLocalizations l10n) {
    final zurueck = l10n.fotoEditZurueck;
    final fertig = l10n.fotoEditFertig;
    final rueckgaengig = l10n.fotoEditRueckgaengig;
    final wiederholen = l10n.fotoEditWiederholen;
    final abbrechen = l10n.cancel;
    final mehr = l10n.fotoEditMehr;
    return I18n(
      importStateHistoryMsg: l10n.fotoEditWirdVorbereitet,
      cancel: abbrechen,
      undo: rueckgaengig,
      redo: wiederholen,
      done: fertig,
      remove: l10n.fotoEditEntfernen,
      doneLoadingMsg: l10n.fotoEditWirdAngewendet,
      layerInteraction: I18nLayerInteraction(
        remove: l10n.fotoEditEntfernen,
        edit: l10n.fotoEditBearbeiten,
        rotateScale: l10n.fotoEditDrehenSkalieren,
      ),
      paintEditor: I18nPaintEditor(
        moveAndZoom: l10n.fotoEditZoomen,
        bottomNavigationBarText: l10n.fotoEditZeichnen,
        freestyle: l10n.fotoEditFreihand,
        arrow: l10n.fotoEditPfeil,
        line: l10n.fotoEditLinie,
        rectangle: l10n.fotoEditRechteck,
        circle: l10n.fotoEditKreis,
        blur: l10n.fotoEditWeichzeichnen,
        pixelate: l10n.fotoEditVerpixeln,
        lineWidth: l10n.fotoEditLinienstaerke,
        eraser: l10n.fotoEditRadierer,
        toggleFill: l10n.fotoEditFuellung,
        changeOpacity: l10n.fotoEditDeckkraft,
        undo: rueckgaengig,
        redo: wiederholen,
        done: fertig,
        back: zurueck,
        smallScreenMoreTooltip: mehr,
        opacity: l10n.fotoEditDeckkraft,
        color: l10n.fotoEditFarbe,
        strokeWidth: l10n.fotoEditLinienstaerke,
        fill: l10n.fotoEditFuellung,
        cancel: abbrechen,
      ),
      textEditor: I18nTextEditor(
        inputHintText: l10n.fotoEditTextEingeben,
        bottomNavigationBarText: l10n.fotoEditText,
        back: zurueck,
        done: fertig,
        textAlign: l10n.fotoEditTextAusrichten,
        fontScale: l10n.fotoEditSchriftgroesse,
        backgroundMode: l10n.fotoEditHintergrund,
        smallScreenMoreTooltip: mehr,
      ),
      cropRotateEditor: I18nCropRotateEditor(
        bottomNavigationBarText: l10n.fotoEditZuschneiden,
        rotate: l10n.fotoEditDrehen,
        flip: l10n.fotoEditSpiegeln,
        tilt: l10n.fotoEditBegradigen,
        tiltRotate: l10n.fotoEditDrehen,
        tiltHorizontal: l10n.fotoEditWaagerecht,
        tiltVertical: l10n.fotoEditSenkrecht,
        ratio: l10n.fotoEditSeitenformat,
        back: zurueck,
        done: fertig,
        cancel: abbrechen,
        undo: rueckgaengig,
        redo: wiederholen,
        smallScreenMoreTooltip: mehr,
        reset: l10n.fotoEditZuruecksetzen,
      ),
      tuneEditor: I18nTuneEditor(
        bottomNavigationBarText: l10n.fotoEditAnpassen,
        back: zurueck,
        done: fertig,
        brightness: l10n.fotoEditHelligkeit,
        contrast: l10n.fotoEditKontrast,
        saturation: l10n.fotoEditSaettigung,
        exposure: l10n.fotoEditBelichtung,
        hue: l10n.fotoEditFarbton,
        temperature: l10n.fotoEditFarbtemperatur,
        fade: l10n.fotoEditVerblassen,
        tint: l10n.fotoEditToenung,
        undo: rueckgaengig,
        redo: wiederholen,
      ),
      filterEditor: I18nFilterEditor(
        bottomNavigationBarText: l10n.fotoEditFilter,
        back: zurueck,
        done: fertig,
        // Die Namen der Filter sind Eigennamen (Clarendon, Juno …) und
        // bleiben, wie sie sind — nur „Kein Filter" wird übersetzt.
        filters: I18nFilters(none: l10n.fotoEditKeinFilter),
      ),
      various: I18nVarious(
        loadingDialogMsg: l10n.fotoEditBitteWarten,
        closeEditorWarningTitle: l10n.fotoEditVerwerfenTitel,
        closeEditorWarningMessage: l10n.fotoEditVerwerfenText,
        closeEditorWarningConfirmBtn: l10n.fotoEditVerwerfen,
        closeEditorWarningCancelBtn: abbrechen,
      ),
    );
  }
}

// ── Nach dem Speichern ──

/// „Das bearbeitete Foto ist gespeichert" — und die Frage nach dem Original.
/// `true`: löschen.
class FotoGespeichertDialog extends StatelessWidget {
  const FotoGespeichertDialog({
    super.key,
    required this.kopie,
    required this.original,
    required this.inFotosApp,
  });

  /// Name der Kopie.
  final String kopie;
  final String original;

  /// iPhone, Original in „Fotos": die Kopie liegt dort, und gelöscht wird
  /// nach „Zuletzt gelöscht" — nicht endgültig.
  final bool inFotosApp;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final klein = TextStyle(fontSize: 13, color: context.colors.textSecondary);
    final name = TextStyle(
        fontWeight: FontWeight.w600, color: context.colors.textPrimary);

    return AlertDialog(
      // Titel, Namen und Frage scrollen zusammen: auf 320 dp mit der größten
      // Systemschrift ragte sonst der Inhalt unten über den Rand.
      scrollable: true,
      title: Text(l10n.fotoEditGespeichertTitel),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(inFotosApp ? l10n.fotoEditInFotosApp : kopie, style: name),
          const SizedBox(height: 16),
          Text(l10n.fotoEditOriginalUnveraendert, style: klein),
          const SizedBox(height: 2),
          Text(original, style: name),
          const SizedBox(height: 16),
          Text(l10n.fotoEditOriginalLoeschenFrage,
              style: TextStyle(color: context.colors.textPrimary)),
          const SizedBox(height: 4),
          Text(
            inFotosApp
                ? l10n.fotoEditLoeschenZuletztGeloescht
                : l10n.fotoEditLoeschenEndgueltig,
            style: klein,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.fotoEditBehalten),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: context.colors.dangerFg),
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.fotoEditLoeschen),
        ),
      ],
    );
  }
}

// ── Größe ──

/// Das Fenster „Größe", wie in Microsofts „Fotos": Prozent oder Pixel, das
/// Seitenverhältnis bleibt; Format; Qualität bei JPG; und vor dem Speichern,
/// wie groß die Datei wird.
class FotoGroessePanel extends StatefulWidget {
  const FotoGroessePanel({
    super.key,
    required this.start,
    required this.standardFormat,
    required this.jetztMasse,
    required this.jetztBytes,
    required this.bild,
  });

  final FotoGroesse start;
  final FotoFormat standardFormat;

  /// Das Original, wie es jetzt auf dem Gerät liegt.
  final ({int breite, int hoehe})? jetztMasse;
  final int jetztBytes;

  /// Das Bild mit allen Änderungen — daraus wird „Danach" gerechnet.
  final Future<Uint8List> bild;

  @override
  State<FotoGroessePanel> createState() => _FotoGroessePanelState();
}

class _FotoGroessePanelState extends State<FotoGroessePanel> {
  late bool _inProzent = widget.start.inProzent;
  late FotoFormat _format = widget.start.format ?? widget.standardFormat;
  late int _qualitaet = widget.start.qualitaet;
  late final _prozent = TextEditingController(text: '${widget.start.prozent}');
  final _breite = TextEditingController();
  final _hoehe = TextEditingController();

  Uint8List? _bild;
  ({int breite, int hoehe})? _bildMasse;
  FotoErgebnis? _danach;
  bool _rechnet = true;
  Timer? _verzoegerung;

  /// Nur das Ergebnis der letzten Rechnung zählt.
  int _lauf = 0;

  @override
  void initState() {
    super.initState();
    widget.bild.then((bild) {
      if (!mounted) return;
      final masse = fotoMasse(bild);
      setState(() {
        _bild = bild;
        _bildMasse = masse;
      });
      final b = widget.start.breite ?? masse?.breite;
      if (b != null) _pixelAusBreite(b);
      _rechnen();
    }, onError: (Object e) {
      LoggerService().warning('Größe: ${e.runtimeType}', tag: 'FOTOEDIT');
      if (mounted) setState(() => _rechnet = false);
    });
  }

  @override
  void dispose() {
    _verzoegerung?.cancel();
    _prozent.dispose();
    _breite.dispose();
    _hoehe.dispose();
    super.dispose();
  }

  FotoGroesse get _einstellung => FotoGroesse(
        inProzent: _inProzent,
        prozent: int.tryParse(_prozent.text)?.clamp(1, 100) ?? 100,
        breite: _inProzent ? null : int.tryParse(_breite.text),
        format: _format == widget.standardFormat ? null : _format,
        qualitaet: _qualitaet,
      );

  void _pixelAusBreite(int breite) {
    final m = _bildMasse;
    if (m == null) return;
    final z = zielMasse(
        m.breite, m.hoehe, FotoGroesse(inProzent: false, breite: breite));
    _breite.text = '${z.breite}';
    _hoehe.text = '${z.hoehe}';
  }

  /// Nicht bei jedem Tastendruck: eine Rechnung bei 12 Megapixel dauert.
  void _rechnen() {
    _verzoegerung?.cancel();
    setState(() => _rechnet = true);
    _verzoegerung = Timer(const Duration(milliseconds: 350), () async {
      final bild = _bild;
      if (bild == null) return;
      final lauf = ++_lauf;
      try {
        final ergebnis = await fotoKodieren(bild, _einstellung, _format);
        if (!mounted || lauf != _lauf) return;
        setState(() {
          _danach = ergebnis;
          _rechnet = false;
        });
      } catch (e) {
        LoggerService()
            .warning('Größe rechnen: ${e.runtimeType}', tag: 'FOTOEDIT');
        if (mounted && lauf == _lauf) setState(() => _rechnet = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final m = _bildMasse;
    final ziel = m == null ? null : zielMasse(m.breite, m.hoehe, _einstellung);
    final jetzt = widget.jetztMasse;
    final danach = _danach;
    final zahl = [FilteringTextInputFormatter.digitsOnly];
    final klein = TextStyle(fontSize: 12, color: context.colors.textSecondary);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 0, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.fotoEditGroesse,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
              const Divider(height: 24),
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(value: true, label: Text(l10n.fotoEditProzent)),
                  ButtonSegment(value: false, label: Text(l10n.fotoEditPixel)),
                ],
                selected: {_inProzent},
                showSelectedIcon: false,
                onSelectionChanged: (s) {
                  setState(() => _inProzent = s.first);
                  if (!_inProzent && _breite.text.isEmpty && ziel != null) {
                    _pixelAusBreite(ziel.breite);
                  }
                  _rechnen();
                },
              ),
              const SizedBox(height: 14),
              if (_inProzent)
                Row(
                  children: [
                    SizedBox(
                      width: 88,
                      child: TextField(
                        controller: _prozent,
                        keyboardType: TextInputType.number,
                        inputFormatters: zahl,
                        decoration: const InputDecoration(
                          suffixText: '%',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) => _rechnen(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.arrow_forward, size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        ziel == null
                            ? '…'
                            : '${ziel.breite} x ${ziel.hoehe} px',
                        style: TextStyle(color: context.colors.textPrimary),
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _breite,
                        keyboardType: TextInputType.number,
                        inputFormatters: zahl,
                        decoration: InputDecoration(
                          labelText: l10n.fotoEditBreite,
                          suffixText: 'px',
                          isDense: true,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (t) {
                          final b = int.tryParse(t);
                          if (b == null) return;
                          final m = _bildMasse;
                          if (m != null) {
                            _hoehe.text =
                                '${zielMasse(m.breite, m.hoehe, FotoGroesse(inProzent: false, breite: b)).hoehe}';
                          }
                          _rechnen();
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('x'),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _hoehe,
                        keyboardType: TextInputType.number,
                        inputFormatters: zahl,
                        decoration: InputDecoration(
                          labelText: l10n.fotoEditHoehe,
                          suffixText: 'px',
                          isDense: true,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (t) {
                          final h = int.tryParse(t);
                          if (h == null) return;
                          final m = _bildMasse;
                          if (m != null) {
                            _breite.text =
                                '${(h * m.breite / m.hoehe).round().clamp(1, m.breite)}';
                          }
                          _rechnen();
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 6),
              Text(l10n.fotoEditSeitenverhaeltnisBleibt, style: klein),
              const SizedBox(height: 18),
              Text(
                l10n.fotoEditFormat,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary),
              ),
              const SizedBox(height: 8),
              SegmentedButton<FotoFormat>(
                segments: [
                  for (final f in FotoFormat.values)
                    ButtonSegment(value: f, label: Text(f.anzeige)),
                ],
                selected: {_format},
                showSelectedIcon: false,
                onSelectionChanged: (s) {
                  setState(() => _format = s.first);
                  _rechnen();
                },
              ),
              if (_format == FotoFormat.jpg) ...[
                const SizedBox(height: 12),
                // Name und Wert über dem Regler, nicht daneben: „Qualität"
                // ist in manchen Sprachen lang, und mit großer Schrift blieb
                // für den Regler sonst nichts übrig.
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.fotoEditQualitaet,
                        style: TextStyle(color: context.colors.textPrimary),
                      ),
                    ),
                    Text(
                      '$_qualitaet',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.colors.textPrimary),
                    ),
                  ],
                ),
                Slider(
                  value: _qualitaet.toDouble(),
                  min: 10,
                  max: 100,
                  divisions: 18,
                  label: '$_qualitaet',
                  onChanged: (v) => setState(() => _qualitaet = v.round()),
                  onChangeEnd: (_) => _rechnen(),
                ),
              ],
              const SizedBox(height: 16),
              _zeile(
                l10n.fotoEditJetzt,
                [
                  if (jetzt != null) '${jetzt.breite} x ${jetzt.hoehe}',
                  groesseText(widget.jetztBytes),
                ].join(' · '),
              ),
              const SizedBox(height: 4),
              _zeile(
                l10n.fotoEditDanach,
                _rechnet || danach == null
                    ? l10n.fotoEditWirdBerechnet
                    : '${danach.breite} x ${danach.hoehe} · ${groesseText(danach.bytes.length)}',
              ),
              const SizedBox(height: 20),
              // Wie die Knöpfe eines Dialogs: reicht die Breite nicht, stehen
              // sie untereinander statt über den Rand hinaus.
              OverflowBar(
                alignment: MainAxisAlignment.end,
                overflowAlignment: OverflowBarAlignment.end,
                spacing: 8,
                overflowSpacing: 8,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, _einstellung),
                    child: Text(l10n.fotoEditAnwenden),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _zeile(String titel, String wert) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(titel,
              style: TextStyle(color: context.colors.textSecondary)),
        ),
        Expanded(
          child: Text(
            wert,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: context.colors.textPrimary),
          ),
        ),
      ],
    );
  }
}
