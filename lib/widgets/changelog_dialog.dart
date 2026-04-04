import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';

/// Changelog Dialog - displays version history with detailed changes
class ChangelogDialog extends StatefulWidget {
  const ChangelogDialog({super.key});

  @override
  State<ChangelogDialog> createState() => _ChangelogDialogState();
}

class _ChangelogDialogState extends State<ChangelogDialog> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  String? _error;
  List<dynamic> _versions = [];
  String? _lastUpdated;

  @override
  void initState() {
    super.initState();
    _loadChangelog();
  }

  Future<void> _loadChangelog() async {
    final failedText = AppLocalizations.of(context)!.failedLoadChangelog;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _apiService.getChangelog();

      if (response['versions'] != null) {
        setState(() {
          _versions = response['versions'] as List<dynamic>;
          _lastUpdated = response['last_updated'] as String?;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = response['error'] ?? failedText;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = '$failedText: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 700,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.history,
                  color: Colors.blue,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.versionHistory,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            if (_lastUpdated != null) ...[
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.lastUpdated(_formatDate(_lastUpdated!)),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
            const SizedBox(height: 24),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    )
                  : _error != null
                      ? _buildErrorState()
                      : _buildVersionList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            _error!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadChangelog,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)!.retry),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionList() {
    if (_versions.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noVersionHistory,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _versions.length,
      itemBuilder: (context, index) {
        final version = _versions[index] as Map<String, dynamic>;
        return _buildVersionCard(version, index == 0);
      },
    );
  }

  Widget _buildVersionCard(Map<String, dynamic> version, bool isLatest) {
    final versionNumber = version['version'] as String;
    final buildNumber = version['build_number'] as int;
    final releaseDate = version['release_date'] as String;
    final title = version['title'] as String;
    final changes = version['changes'] as List<dynamic>;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLatest ? Colors.blue : Colors.white12,
          width: isLatest ? 2 : 1,
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLatest ? Colors.blue : Colors.white12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isLatest ? Icons.new_releases : Icons.check_circle_outline,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Text(
              'v$versionNumber',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '(Build $buildNumber)',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            if (isLatest) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'LATEST',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(releaseDate),
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),
          ],
        ),
        children: [
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),
          ...changes.map((change) {
            final changeMap = change as Map<String, dynamic>;
            return _buildChangeCategory(changeMap);
          }),
        ],
      ),
    );
  }

  Widget _buildChangeCategory(Map<String, dynamic> category) {
    final categoryName = category['category'] as String;
    final items = category['items'] as List<dynamic>;

    Color categoryColor;
    IconData categoryIcon;

    switch (categoryName) {
      case 'Security':
        categoryColor = Colors.red;
        categoryIcon = Icons.security;
        break;
      case 'Features':
        categoryColor = Colors.green;
        categoryIcon = Icons.new_releases;
        break;
      case 'Improvements':
        categoryColor = Colors.blue;
        categoryIcon = Icons.trending_up;
        break;
      case 'Bug Fixes':
        categoryColor = Colors.orange;
        categoryIcon = Icons.bug_report;
        break;
      default:
        categoryColor = Colors.grey;
        categoryIcon = Icons.info;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(categoryIcon, color: categoryColor, size: 18),
              const SizedBox(width: 8),
              Text(
                categoryName,
                style: TextStyle(
                  color: categoryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(left: 26, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}.${date.month}.${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}
