import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import 'chat_attachment_item.dart';

/// A chat message bubble with optional attachments
class ChatMessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isOwn;
  final Function(Map<String, dynamic>) onDownloadAttachment;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isOwn,
    required this.onDownloadAttachment,
  });

  // Responsive spacing helper
  double _getResponsiveSpacing(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.5; // 50% on very small screens
    if (width < 400) return baseSize * 0.75; // 75% on small screens
    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    final attachments = List<Map<String, dynamic>>.from(message['attachments'] ?? []);
    final status = message['status'] ?? 'sent';
    final messageText = message['message'] ?? '';
    final hasTextMessage = messageText.toString().isNotEmpty &&
                           !messageText.toString().startsWith('[');

    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: _getResponsiveSpacing(context, 8),
          left: isOwn ? _getResponsiveSpacing(context, 50) : 0,
          right: isOwn ? 0 : _getResponsiveSpacing(context, 50),
        ),
        padding: EdgeInsets.all(_getResponsiveSpacing(context, 10)),
        decoration: BoxDecoration(
          color: isOwn ? const Color(0xFF1a1a2e) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender name (only for non-own messages)
            if (!isOwn)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  message['sender_name'] ?? AppLocalizations.of(context)!.member,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            // Message text (with clickable links)
            if (hasTextMessage)
              _buildLinkifiedText(messageText, isOwn),
            // Attachments
            if (attachments.isNotEmpty) ...[
              if (hasTextMessage) const SizedBox(height: 8),
              ...attachments.map((att) => ChatAttachmentItem(
                attachment: att,
                isOwn: isOwn,
                onDownload: onDownloadAttachment,
              )),
            ],
            // Time and read receipt
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message['created_at']),
                    style: TextStyle(
                      fontSize: 10,
                      color: isOwn ? Colors.white70 : Colors.grey.shade500,
                    ),
                  ),
                  // Read receipt checkmarks (only for own messages)
                  if (isOwn) ...[
                    const SizedBox(width: 4),
                    _buildReadReceipt(status),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final _urlRegex = RegExp(
    r'https?://[^\s<>\"\)]+',
    caseSensitive: false,
  );

  Widget _buildLinkifiedText(String text, bool isOwn) {
    final matches = _urlRegex.allMatches(text).toList();
    if (matches.isEmpty) {
      return Text(text, style: TextStyle(color: isOwn ? Colors.white : Colors.black87));
    }

    final spans = <TextSpan>[];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      final url = match.group(0)!;
      spans.add(TextSpan(
        text: url,
        style: TextStyle(
          color: isOwn ? Colors.lightBlueAccent : Colors.blue.shade700,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(color: isOwn ? Colors.white : Colors.black87, fontSize: 14),
        children: spans,
      ),
    );
  }

  Widget _buildReadReceipt(String status) {
    // WhatsApp style: ✓ = sent, ✓✓ = delivered, ✓✓ blue = read
    switch (status) {
      case 'read':
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.done_all, size: 14, color: Colors.lightBlueAccent),
          ],
        );
      case 'delivered':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.done_all, size: 14, color: Colors.white.withValues(alpha: 0.7)),
          ],
        );
      case 'sent':
      default:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.done, size: 14, color: Colors.white.withValues(alpha: 0.7)),
          ],
        );
    }
  }

  String _formatTime(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final messageDate = DateTime(date.year, date.month, date.day);

      if (messageDate == today) {
        return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      } else {
        return '${date.day}.${date.month}. ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      }
    } catch (e) {
      return '';
    }
  }
}
