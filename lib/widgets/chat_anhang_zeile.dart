import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// Eine Datei in einer Live-Chat-Blase: Symbol, Name, Größe — und rechts
/// daneben der Herunterladen-Knopf.
///
/// Tippen auf die Zeile öffnet die Datei nur (im Betrachter der App oder in
/// der zuständigen App); sie liegt danach im Zwischenspeicher der App, den
/// das Mitglied nie zu sehen bekommt. Wer ein Schreiben vom Vorstand behalten
/// will, braucht den Knopf: er legt die Datei dort ab, wo es sie wiederfindet.
class ChatAnhangZeile extends StatelessWidget {
  const ChatAnhangZeile({
    super.key,
    required this.attachment,
    required this.isOwn,
    required this.onOeffnen,
    required this.onHerunterladen,
    this.laedt = false,
    this.gespeichertIn,
  });

  final Map<String, dynamic> attachment;
  final bool isOwn;
  final VoidCallback onOeffnen;

  /// ⚠️ Bleibt auch während des Ladens gesetzt. Ein gesperrter Knopf nähme
  /// keine Tipps mehr an, und die fielen dann auf die Zeile darunter — die
  /// öffnet die Datei. Doppelte Tipps fängt der Aufrufer ab.
  final VoidCallback onHerunterladen;

  /// Dieser Anhang wird gerade geholt und gespeichert.
  final bool laedt;

  /// Wohin er zuletzt gespeichert wurde: dann steht ein Haken statt des
  /// Pfeils und der Ort im Tooltip. Nochmal tippen speichert erneut.
  final String? gespeichertIn;

  static String _dateigroesse(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final filename = attachment['filename'] ?? l.file;
    final size = attachment['size'];
    final extension = (attachment['extension'] ?? '').toString().toLowerCase();
    final akzent = isOwn ? Colors.white : const Color(0xFF667eea);

    IconData icon;
    switch (extension) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        break;
      case 'png':
      case 'jpg':
      case 'jpeg':
        icon = Icons.image;
        break;
      default:
        icon = Icons.attach_file;
    }

    final ort = gespeichertIn;

    return InkWell(
      onTap: onOeffnen,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        // Rechts und oben/unten knapper: der Knopf bringt seinen eigenen
        // Rand mit (48-dp-Tippfläche), die Zeile bleibt so hoch wie vorher.
        padding: const EdgeInsets.fromLTRB(10, 4, 0, 4),
        decoration: BoxDecoration(
          color: isOwn ? Colors.white.withValues(alpha: 0.2) : context.colors.cardSubtle,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isOwn ? Colors.white.withValues(alpha: 0.3) : const Color(0xFF667eea).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: akzent),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filename,
                    style: TextStyle(
                      fontSize: 13,
                      color: isOwn ? Colors.white : context.colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _dateigroesse(size is num ? size.toInt() : int.tryParse('$size') ?? 0),
                    style: TextStyle(
                      fontSize: 11,
                      color: isOwn ? Colors.white70 : context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: onHerunterladen,
              color: akzent,
              tooltip: laedt
                  ? l.downloading
                  : ort == null
                      ? l.downloadTooltip
                      : l.savedFilename(ort),
              icon: laedt
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: akzent),
                    )
                  : Icon(ort == null ? Icons.download : Icons.download_done),
            ),
          ],
        ),
      ),
    );
  }
}
