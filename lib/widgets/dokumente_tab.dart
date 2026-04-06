import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../l10n/app_localizations.dart';
import 'file_viewer.dart';
import '../services/api_service.dart';
import '../utils/error_helpers.dart';

class DokumenteTab extends StatefulWidget {
  const DokumenteTab({super.key});

  @override
  State<DokumenteTab> createState() => _DokumenteTabState();
}

class _DokumenteTabState extends State<DokumenteTab> {
  final _apiService = ApiService();

  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _dokumente = [];
  Map<String, dynamic> _stats = {};
  int? _downloadingId;

  @override
  void initState() {
    super.initState();
    _loadDokumente();
  }

  Future<void> _loadDokumente() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _apiService.getMyDokumente();

      if (!mounted) return;

      if (result['success'] == true) {
        final data = result['data'] ?? result;
        setState(() {
          _dokumente = List<Map<String, dynamic>>.from(data['dokumente'] ?? []);
          _stats = Map<String, dynamic>.from(data['stats'] ?? {});
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = result['message'] ?? AppLocalizations.of(context)!.errorLoading;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'DOCS');
        _isLoading = false;
      });
    }
  }

  String _getExtension(String filename) {
    final parts = filename.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  Color _extensionColor(String ext) {
    switch (ext) {
      case 'pdf':
        return Colors.red.shade700;
      case 'doc':
      case 'docx':
      case 'odt':
        return Colors.blue.shade700;
      case 'xls':
      case 'xlsx':
      case 'ods':
        return Colors.green.shade700;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Colors.purple.shade700;
      case 'txt':
        return Colors.grey.shade700;
      default:
        return Colors.blueGrey.shade700;
    }
  }

  IconData _extensionIcon(String ext) {
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
      case 'odt':
        return Icons.article;
      case 'xls':
      case 'xlsx':
      case 'ods':
        return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFilesize(dynamic size) {
    final bytes = size is int ? size : int.tryParse(size.toString()) ?? 0;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd.MM.yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Future<void> _downloadDokument(Map<String, dynamic> doc) async {
    final docId = doc['id'];
    if (_downloadingId != null) return;

    setState(() => _downloadingId = docId);

    try {
      final result = await _apiService.downloadMyDokument(docId);

      if (!mounted) return;

      if (result['success'] == true) {
        final data = result['data'] ?? result;
        final filename = data['filename'] ?? doc['original_filename'] ?? 'download';
        final base64Data = data['data'];

        if (base64Data == null) {
          _showSnackBar(AppLocalizations.of(context)!.noFileDataReceived, isError: true);
          return;
        }

        // Decode base64
        final bytes = base64Decode(base64Data);

        // Get downloads directory
        Directory saveDir;
        if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
          saveDir = (await getDownloadsDirectory()) ?? (await getApplicationDocumentsDirectory());
        } else {
          saveDir = await getApplicationDocumentsDirectory();
        }

        final safeName = filename.split(RegExp(r'[/\\]')).last.replaceAll('..', '');
        final filePath = '${saveDir.path}/$safeName';
        final file = File(filePath);
        await file.writeAsBytes(bytes);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.savedFilename(filename)),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.openFile,
              textColor: Colors.white,
              onPressed: () {
                try {
                  FileViewer.open(context, file, filename);
                } catch (e) {
                  debugPrint('[Dokumente] FileViewer error: $e');
                }
              },
            ),
          ),
        );
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.downloadFailed2, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'DOCS'), isError: true);
    } finally {
      if (mounted) setState(() => _downloadingId = null);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadDokumente,
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    final total = _stats['total'] ?? 0;

    return RefreshIndicator(
      onRefresh: _loadDokumente,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.folder, color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.documentsCount(total),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Info box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.documentsProvidedByBoard,
                      style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Documents list or empty state
            if (_dokumente.isEmpty)
              _buildEmptyState()
            else
              ..._dokumente.map(_buildDokumentCard),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.folder_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noDocumentsAvailable,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.noDocumentsDescription,
              style: TextStyle(color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDokumentCard(Map<String, dynamic> doc) {
    final originalFilename = doc['original_filename'] ?? '';
    final dokumentName = doc['dokument_name'] ?? originalFilename;
    final ext = _getExtension(originalFilename);
    final color = _extensionColor(ext);
    final beschreibung = doc['beschreibung'];
    final uploadedByName = doc['uploaded_by_name'] ?? '';
    final filesize = _formatFilesize(doc['filesize'] ?? 0);
    final datum = _formatDate(doc['created_at']);
    final docId = doc['id'];
    final isDownloading = _downloadingId == docId;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File type icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_extensionIcon(ext), color: color, size: 24),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Document name
                  Text(
                    dokumentName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  // Extension badge + filesize + date
                  Row(
                    children: [
                      if (ext.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            ext.toUpperCase(),
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
                          ),
                        ),
                      if (ext.isNotEmpty) const SizedBox(width: 8),
                      Text(
                        filesize,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        datum,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  // Description
                  if (beschreibung != null && beschreibung.toString().isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      beschreibung.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                  // Uploaded by
                  if (uploadedByName.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.uploadedBy(uploadedByName),
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                  ],
                ],
              ),
            ),
            // Download button
            IconButton(
              onPressed: isDownloading ? null : () => _downloadDokument(doc),
              icon: isDownloading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.download, color: Colors.blue.shade700),
              tooltip: AppLocalizations.of(context)!.downloadTooltip,
            ),
          ],
        ),
      ),
    );
  }
}
