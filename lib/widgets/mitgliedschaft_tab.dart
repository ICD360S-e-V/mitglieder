import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../utils/error_helpers.dart';

class MitgliedschaftTab extends StatefulWidget {
  final String mitgliedernummer;

  const MitgliedschaftTab({super.key, required this.mitgliedernummer});

  @override
  State<MitgliedschaftTab> createState() => _MitgliedschaftTabState();
}

class _MitgliedschaftTabState extends State<MitgliedschaftTab> {
  final _apiService = ApiService();

  bool _isLoading = true;
  String? _error;
  Map<String, dynamic> _profile = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _apiService.getProfile(widget.mitgliedernummer);

      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          _profile = result;
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
        _error = getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'MEMBERSHIP');
        _isLoading = false;
      });
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

  String _formatDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd.MM.yyyy HH:mm').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String _statusLabel(String? status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'active':
        return l10n.statusActive;
      case 'suspended':
        return l10n.statusSuspended;
      case 'neu':
        return l10n.statusNew;
      case 'gekuendigt':
        return l10n.statusCancelled;
      case 'deleted':
        return l10n.statusDeleted;
      default:
        return status ?? l10n.unknownValue;
    }
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'suspended':
        return Colors.red;
      case 'neu':
        return Colors.orange;
      case 'gekuendigt':
        return Colors.grey;
      case 'deleted':
        return Colors.red.shade900;
      default:
        return Colors.grey;
    }
  }

  String _roleLabel(String? role) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case 'mitglied':
        return l10n.roleMitglied;
      case 'vorsitzer':
        return l10n.roleVorsitzer;
      case 'schatzmeister':
        return l10n.roleSchatzmeister;
      case 'kassierer':
        return l10n.roleKassierer;
      case 'mitgliedergrunder':
        return l10n.roleMitgliedergruender;
      default:
        return role ?? l10n.unknownValue;
    }
  }

  String _mitgliedsartLabel(String? art) {
    final l10n = AppLocalizations.of(context)!;
    switch (art) {
      case 'ordentlich':
        return l10n.memberType_ordentlich;
      case 'foerdermitglied':
        return l10n.memberType_foerder;
      case 'ehrenmitglied':
        return l10n.memberType_ehren;
      default:
        return l10n.memberTypeNotSet;
    }
  }

  String _zahlungsmethodeLabel(String? methode) {
    final l10n = AppLocalizations.of(context)!;
    switch (methode) {
      case 'ueberweisung':
        return l10n.payMethod_ueberweisung;
      case 'sepa_lastschrift':
        return l10n.payMethodSepa;
      case 'dauerauftrag':
        return l10n.payMethod_dauerauftrag;
      default:
        return l10n.memberTypeNotSet;
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
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProfile,
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    final status = _profile['status']?.toString();
    final mitgliedernummer = _profile['mitgliedernummer']?.toString() ?? '';
    final role = _profile['role']?.toString();
    final mitgliedsart = _profile['mitgliedsart']?.toString();
    final zahlungsmethode = _profile['zahlungsmethode']?.toString();
    final createdAt = _profile['created_at']?.toString();
    final lastLogin = _profile['last_login']?.toString();
    final mitgliedschaftDatum = _profile['mitgliedschaft_datum']?.toString();

    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              // Status
              _buildRow(
                icon: Icons.circle,
                iconColor: _statusColor(status),
                label: l10n.labelStatus,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(status).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _statusLabel(status),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _statusColor(status),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, indent: 56),
              // Mitgliedernummer
              _buildTextRow(
                icon: Icons.badge,
                iconColor: Colors.blue.shade700,
                label: l10n.labelMemberNumber,
                value: mitgliedernummer,
              ),
              const Divider(height: 1, indent: 56),
              // Rolle
              _buildTextRow(
                icon: Icons.person,
                iconColor: Colors.indigo,
                label: l10n.labelRole,
                value: _roleLabel(role),
              ),
              const Divider(height: 1, indent: 56),
              // Mitgliedsart
              _buildTextRow(
                icon: Icons.group,
                iconColor: Colors.teal,
                label: l10n.labelMemberType,
                value: _mitgliedsartLabel(mitgliedsart),
                valueColor: (mitgliedsart == null || mitgliedsart.isEmpty) ? Colors.grey : null,
              ),
              const Divider(height: 1, indent: 56),
              // Zahlungsmethode
              _buildTextRow(
                icon: Icons.payment,
                iconColor: Colors.amber.shade800,
                label: l10n.labelPaymentMethod,
                value: _zahlungsmethodeLabel(zahlungsmethode),
                valueColor: (zahlungsmethode == null || zahlungsmethode.isEmpty) ? Colors.grey : null,
              ),
              const Divider(height: 1, indent: 56),
              // Registriert am
              _buildTextRow(
                icon: Icons.app_registration,
                iconColor: Colors.purple,
                label: l10n.labelRegisteredOn,
                value: createdAt != null && createdAt.isNotEmpty
                    ? _formatDate(createdAt)
                    : '-',
              ),
              const Divider(height: 1, indent: 56),
              // Letzter Login
              _buildTextRow(
                icon: Icons.login,
                iconColor: Colors.green.shade700,
                label: l10n.labelLastLogin,
                value: lastLogin != null && lastLogin.isNotEmpty
                    ? _formatDateTime(lastLogin)
                    : l10n.neverLoggedIn,
                valueColor: (lastLogin == null || lastLogin.isEmpty) ? Colors.grey : null,
              ),
              const Divider(height: 1, indent: 56),
              // Mitglied seit
              _buildTextRow(
                icon: Icons.card_membership,
                iconColor: Colors.deepOrange,
                label: l10n.labelMemberSince,
                value: mitgliedschaftDatum != null && mitgliedschaftDatum.isNotEmpty
                    ? _formatDate(mitgliedschaftDatum)
                    : l10n.notActivatedYet,
                valueColor: (mitgliedschaftDatum == null || mitgliedschaftDatum.isEmpty) ? Colors.grey : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return _buildRow(
      icon: icon,
      iconColor: iconColor,
      label: label,
      child: Flexible(
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: valueColor,
          ),
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const Spacer(),
          child,
        ],
      ),
    );
  }
}
