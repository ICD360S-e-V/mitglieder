import 'dart:io';

import 'package:flutter/material.dart';

/// Streifen über dem Eingabefeld: was gleich mitgeschickt wird.
///
/// Eingefügte Bilder gehen bewusst nicht sofort raus — ein danebengegangener
/// Strg+V landet sonst ungefragt beim Mitglied. Erst hier sichtbar, dann Senden.
class ChatPendingAttachments extends StatelessWidget {
  const ChatPendingAttachments({
    super.key,
    required this.files,
    required this.onRemove,
    this.isUploading = false,
  });

  final List<File> files;
  final ValueChanged<File> onRemove;
  final bool isUploading;

  static const _imageExtensions = {'png', 'jpg', 'jpeg'};

  static bool _isImage(File f) =>
      _imageExtensions.contains(f.path.split('.').last.toLowerCase());

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SizedBox(
        height: 64,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: files.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) => _Tile(
            file: files[i],
            isUploading: isUploading,
            onRemove: () => onRemove(files[i]),
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.file,
    required this.onRemove,
    required this.isUploading,
  });

  final File file;
  final VoidCallback onRemove;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    final name = file.path.split(Platform.pathSeparator).last;
    final isImage = ChatPendingAttachments._isImage(file);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: isImage ? 64 : 150,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          clipBehavior: Clip.antiAlias,
          child: isImage
              ? Image.file(
                  file,
                  fit: BoxFit.cover,
                  width: 64,
                  height: 64,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image_outlined, color: Colors.grey),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file_outlined,
                          size: 18, color: Color(0xFF4a90d9)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        if (!isUploading)
          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(2),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
