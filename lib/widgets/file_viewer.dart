import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:open_filex/open_filex.dart';

/// Internal file viewer for PDF and images
/// Opens files inside the app instead of requiring external apps
class FileViewer extends StatelessWidget {
  final File file;
  final String filename;

  const FileViewer({
    super.key,
    required this.file,
    required this.filename,
  });

  /// Open a file - uses internal viewer for PDF/images, external for others
  static Future<void> open(BuildContext context, File file, String filename) async {
    final ext = filename.split('.').last.toLowerCase();

    if (ext == 'pdf') {
      _openInternalViewer(context, file, filename);
    } else if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext)) {
      _openInternalViewer(context, file, filename);
    } else {
      // Other file types → system default app
      await OpenFilex.open(file.path);
    }
  }

  static void _openInternalViewer(BuildContext context, File file, String filename) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FileViewer(file: file, filename: filename),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ext = filename.split('.').last.toLowerCase();
    final isPdf = ext == 'pdf';
    final isImage = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          filename,
          style: const TextStyle(fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // Button to open with external app if needed
          IconButton(
            icon: const Icon(Icons.open_in_new),
            tooltip: 'Extern öffnen',
            onPressed: () => OpenFilex.open(file.path),
          ),
        ],
      ),
      body: isPdf
          ? _PdfViewerBody(file: file)
          : isImage
              ? _ImageViewerBody(file: file)
              : const Center(
                  child: Text(
                    'Nicht unterstütztes Format',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}

/// PDF viewer with page navigation
class _PdfViewerBody extends StatelessWidget {
  final File file;
  const _PdfViewerBody({required this.file});

  @override
  Widget build(BuildContext context) {
    return PdfViewer.file(
      file.path,
      params: PdfViewerParams(
        maxScale: 5.0,
      ),
    );
  }
}

/// Image viewer with zoom and pan
class _ImageViewerBody extends StatelessWidget {
  final File file;
  const _ImageViewerBody({required this.file});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 5.0,
        child: Image.file(
          file,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.broken_image, color: Colors.white54, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Bild konnte nicht geladen werden',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
