import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// A single attachment item in a chat message
class ChatAttachmentItem extends StatelessWidget {
  final Map<String, dynamic> attachment;
  final bool isOwn;
  final Function(Map<String, dynamic>) onDownload;

  const ChatAttachmentItem({
    super.key,
    required this.attachment,
    required this.isOwn,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final filename = attachment['filename'] ?? AppLocalizations.of(context)!.file;
    final extension = attachment['extension'] ?? '';
    final size = attachment['size'] ?? 0;

    final (icon, iconColor) = _getIconForExtension(context, extension);

    return InkWell(
      onTap: () => onDownload(attachment),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isOwn ? Colors.white.withValues(alpha: 0.1) : context.colors.cardSubtle,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filename,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isOwn ? Colors.white : context.colors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _formatFileSize(size),
                    style: TextStyle(
                      fontSize: 10,
                      color: isOwn ? Colors.white70 : context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.download,
              size: 16,
              color: isOwn ? Colors.white70 : context.colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  (IconData, Color) _getIconForExtension(BuildContext context, String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return (Icons.picture_as_pdf, context.colors.dangerFg);
      case 'png':
      case 'jpg':
      case 'jpeg':
        return (Icons.image, context.colors.infoFg);
      case 'txt':
        return (Icons.description, context.colors.textSecondary);
      default:
        return (Icons.insert_drive_file, context.colors.textSecondary);
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
