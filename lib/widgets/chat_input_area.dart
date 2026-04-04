import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Chat input area with attachment button and send button
class ChatInputArea extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final bool isUploading;
  final VoidCallback onSend;
  final VoidCallback onPickFiles;
  final VoidCallback? onFocus;
  final String hintText;

  const ChatInputArea({
    super.key,
    required this.controller,
    required this.isSending,
    required this.isUploading,
    required this.onSend,
    required this.onPickFiles,
    this.onFocus,
    this.hintText = '...',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          // Attachment button
          IconButton(
            icon: isUploading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.attach_file, color: Color(0xFF1a1a2e)),
            onPressed: isUploading ? null : onPickFiles,
            tooltip: AppLocalizations.of(context)!.attachFiles,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              onTap: onFocus,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: const Color(0xFF1a1a2e),
            child: IconButton(
              icon: isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: isSending ? null : onSend,
            ),
          ),
        ],
      ),
    );
  }
}

/// Closed conversation indicator
class ClosedConversationIndicator extends StatelessWidget {
  const ClosedConversationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        AppLocalizations.of(context)!.conversationClosed,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
