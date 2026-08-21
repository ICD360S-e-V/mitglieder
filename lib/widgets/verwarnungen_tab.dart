import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../utils/error_helpers.dart';
import '../utils/app_theme.dart';

class VerwarnungenTab extends StatefulWidget {
  const VerwarnungenTab({super.key});

  @override
  State<VerwarnungenTab> createState() => _VerwarnungenTabState();
}

class _VerwarnungenTabState extends State<VerwarnungenTab> {
  final _apiService = ApiService();

  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _warnings = [];
  Map<String, dynamic> _stats = {};

  @override
  void initState() {
    super.initState();
    _loadVerwarnungen();
  }

  Future<void> _loadVerwarnungen() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _apiService.getMyVerwarnungen();

      if (!mounted) return;

      if (result['success'] == true) {
        final data = result['data'] ?? result;
        setState(() {
          _warnings = List<Map<String, dynamic>>.from(data['warnings'] ?? []);
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
        _error = getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'WARNINGS');
        _isLoading = false;
      });
    }
  }

  Color _typColor(String typ) {
    switch (typ) {
      case 'ermahnung':
        return context.colors.warningFg;
      case 'abmahnung':
        return context.colors.warningFg;
      case 'letzte_abmahnung':
        return context.colors.dangerFg;
      default:
        return context.colors.textSecondary;
    }
  }

  IconData _typIcon(String typ) {
    switch (typ) {
      case 'ermahnung':
        return Icons.info_outline;
      case 'abmahnung':
        return Icons.warning_amber;
      case 'letzte_abmahnung':
        return Icons.gavel;
      default:
        return Icons.help_outline;
    }
  }

  String _typLabel(String typ) {
    final l = AppLocalizations.of(context)!;
    switch (typ) {
      case 'ermahnung':
        return l.warningType_ermahnung;
      case 'abmahnung':
        return l.warningType_abmahnung;
      case 'letzte_abmahnung':
        return l.warningType_letzte;
      default:
        return typ;
    }
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
            Icon(Icons.error_outline, size: 48, color: context.colors.dangerFg),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadVerwarnungen,
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadVerwarnungen,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats chips
            _buildStatsRow(),
            const SizedBox(height: 16),
            // Warnings list or empty state
            if (_warnings.isEmpty)
              _buildEmptyState()
            else
              ..._warnings.map(_buildWarningCard),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    final total = _stats['total'] ?? 0;
    final ermahnung = _stats['ermahnung'] ?? 0;
    final abmahnung = _stats['abmahnung'] ?? 0;
    final letzteAbmahnung = _stats['letzte_abmahnung'] ?? 0;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildStatChip(AppLocalizations.of(context)!.warningsTotal(total), context.colors.textSecondary),
        if (ermahnung > 0) _buildStatChip(AppLocalizations.of(context)!.warningsErmahnung(ermahnung), context.colors.warningFg),
        if (abmahnung > 0) _buildStatChip(AppLocalizations.of(context)!.warningsAbmahnung(abmahnung), context.colors.warningFg),
        if (letzteAbmahnung > 0) _buildStatChip(AppLocalizations.of(context)!.warningsLetzte(letzteAbmahnung), context.colors.dangerFg),
      ],
    );
  }

  Widget _buildStatChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color == context.colors.textSecondary ? context.colors.textPrimary : color.shade900,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.15),
      side: BorderSide(color: color.withValues(alpha: 0.4)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: context.colors.successFg),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noWarnings,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: context.colors.successFg,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.noWarningsDescription,
              style: TextStyle(color: context.colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningCard(Map<String, dynamic> warning) {
    final typ = warning['typ'] ?? '';
    final color = _typColor(typ);
    final datum = _formatDate(warning['datum']);
    final grund = warning['grund'] ?? '';
    final beschreibung = warning['beschreibung'];
    final createdByName = warning['created_by_name'] ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_typIcon(typ), color: color.shade800, size: 24),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type badge + date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _typLabel(typ),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color.shade900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        datum,
                        style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Grund (bold)
                  Text(
                    grund,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  // Beschreibung
                  if (beschreibung != null && beschreibung.toString().isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      beschreibung.toString(),
                      style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
                    ),
                  ],
                  // Created by
                  if (createdByName.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.createdBy(createdByName),
                      style: TextStyle(fontSize: 11, color: context.colors.textTertiary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension to get shade900 on any MaterialColor or Color
extension _ColorShade on Color {
  Color get shade800 {
    if (this is MaterialColor) return (this as MaterialColor).shade800;
    return this;
  }

  Color get shade900 {
    if (this is MaterialColor) return (this as MaterialColor).shade900;
    return this;
  }
}
