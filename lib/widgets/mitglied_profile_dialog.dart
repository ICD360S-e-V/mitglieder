import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import 'verifizierung_tab.dart';
import 'verwarnungen_tab.dart';
import 'dokumente_tab.dart';
import 'mitglieder_device.dart';
import 'mitgliedschaft_tab.dart';

class MitgliedProfileDialog extends StatefulWidget {
  final String userName;
  final String mitgliedernummer;
  final String email;
  final String status;
  final ApiService apiService;
  final Function(String) onEmailChanged;

  const MitgliedProfileDialog({
    super.key,
    required this.userName,
    required this.mitgliedernummer,
    required this.email,
    required this.status,
    required this.apiService,
    required this.onEmailChanged,
  });

  @override
  State<MitgliedProfileDialog> createState() => _MitgliedProfileDialogState();
}

class _MitgliedProfileDialogState extends State<MitgliedProfileDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _newEmailController = TextEditingController();
  final _emailPasswordController = TextEditingController();

  bool _obscureEmailPassword = true;

  // Device sessions + registered devices
  List<Map<String, dynamic>> _sessions = [];
  List<dynamic> _devices = [];
  int _totalSessions = 0;
  bool _loadingSessions = true;

  // Account data from profile
  String? _createdAt;
  String? _lastLogin;
  String? _deactivatedAt;
  String? _deactivationReason;
  String? _role;
  String _displayName = '';
  String _displayEmail = '';
  bool _loadingAccountInfo = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadMySessions();
    _loadAccountInfo();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _newEmailController.dispose();
    _emailPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadAccountInfo() async {
    _displayName = widget.userName;
    _displayEmail = widget.email;
    try {
      final result = await widget.apiService.getProfile(widget.mitgliedernummer);

      if (result['success'] == true && mounted) {
        final data = result['data'] ?? result;
        setState(() {
          _createdAt = data['created_at']?.toString();
          _lastLogin = data['last_login']?.toString();
          _deactivatedAt = data['deactivated_at']?.toString();
          _deactivationReason = data['deactivation_reason']?.toString();
          _role = data['role']?.toString();
          _displayName = data['name']?.toString() ?? widget.userName;
          _displayEmail = data['email']?.toString() ?? widget.email;
          _loadingAccountInfo = false;
        });
      } else {
        if (mounted) setState(() => _loadingAccountInfo = false);
      }
    } catch (e) {
      if (mounted) setState(() => _loadingAccountInfo = false);
    }
  }

  Future<void> _loadMySessions() async {
    try {
      final result = await widget.apiService.getMySessions();

      if (result['success'] == true && mounted) {
        // Also load registered devices
        List<dynamic> deviceList = [];
        try {
          final devResult = await widget.apiService.getMyDevices();
          if (devResult['success'] == true) {
            deviceList = devResult['devices'] ?? [];
          }
        } catch (_) {}

        setState(() {
          _sessions = List<Map<String, dynamic>>.from(result['sessions'] ?? []);
          _totalSessions = result['total_sessions'] ?? 0;
          _devices = deviceList;
          _loadingSessions = false;
        });
      } else {
        if (mounted) {
          setState(() => _loadingSessions = false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingSessions = false);
      }
    }
  }

  Future<void> _revokeMySession(int sessionId) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await widget.apiService.revokeMySession(sessionId);

      if (!mounted) return;

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.deviceLoggedOut),
            backgroundColor: Colors.green,
          ),
        );
        _loadMySessions(); // Reload sessions
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error(result['message'] ?? l10n.unknownValue)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.connectionError(e.toString())),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _changeEmail() async {
    final l10n = AppLocalizations.of(context)!;
    if (_newEmailController.text.isEmpty || !_newEmailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.validEmailRequired),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final result = await widget.apiService.changeEmail(
        widget.mitgliedernummer,
        _newEmailController.text,
        _emailPasswordController.text,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        widget.onEmailChanged(_newEmailController.text);
        setState(() {
          _displayEmail = _newEmailController.text;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.emailChangedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
        _newEmailController.clear();
        _emailPasswordController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? l10n.errorChangingEmail),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.error(e.toString())),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 550,
        height: 720,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF4a90d9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Text(
                      widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'M',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4a90d9),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              widget.mitgliedernummer,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: widget.status == 'neu'
                                    ? Colors.orange
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Builder(
                                builder: (context) {
                                  final l10n = AppLocalizations.of(context)!;
                                  return Text(
                                    widget.status == 'neu' ? l10n.newBadge : l10n.verified,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Tabs
            Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return Container(
                  color: Colors.grey.shade200,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xFF4a90d9),
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: const Color(0xFF4a90d9),
                    tabs: [
                      Tab(icon: Tooltip(message: l10n.account, child: const Icon(Icons.settings))),
                      Tab(icon: Tooltip(message: '${l10n.myDevices} ($_totalSessions/3)', child: const Icon(Icons.devices))),
                      Tab(icon: Tooltip(message: l10n.tabVerification, child: const Icon(Icons.verified_user))),
                      Tab(icon: Tooltip(message: l10n.tabWarnings, child: const Icon(Icons.warning_amber))),
                      Tab(icon: Tooltip(message: l10n.tabDocuments, child: const Icon(Icons.folder))),
                      Tab(icon: Tooltip(message: l10n.tabMembership, child: const Icon(Icons.card_membership))),
                    ],
                  ),
                );
              },
            ),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProfileTab(),
                  MitgliederDeviceWidget(
                    sessions: _sessions,
                    devices: _devices,
                    isLoading: _loadingSessions,
                    onRevokeSession: (id) => _confirmRevokeMySession(id),
                  ),
                  VerifizierungTab(mitgliedernummer: widget.mitgliedernummer),
                  const VerwarnungenTab(),
                  const DokumenteTab(),
                  MitgliedschaftTab(mitgliedernummer: widget.mitgliedernummer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty || dateTimeStr == 'null') {
      return '—';
    }
    try {
      final dt = DateTime.parse(dateTimeStr);
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      final year = dt.year.toString();
      final hour = dt.hour.toString().padLeft(2, '0');
      final minute = dt.minute.toString().padLeft(2, '0');
      return '$day.$month.$year, $hour:$minute';
    } catch (e) {
      return dateTimeStr;
    }
  }

  String _getRoleDisplayName(String? role) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case 'mitglied': return l10n.roleMitglied;
      case 'vorsitzer': return l10n.roleVorsitzer;
      case 'stellvertreter': return l10n.roleStellvertreter;
      case 'schatzmeister': return l10n.roleSchatzmeister;
      case 'schriftfuehrer': return l10n.roleSchriftfuehrer;
      case 'beisitzer': return l10n.roleBeisitzer;
      case 'kassierer': return l10n.roleKassierer;
      case 'kassenprufer': return l10n.roleKassenpruefer;
      case 'ehrenamtlich': return l10n.roleEhrenamtlich;
      case 'mitgliedergrunder': return l10n.roleMitgliedergruender;
      case 'ehrenmitglied': return l10n.roleEhrenmitglied;
      case 'foerdermitglied': return l10n.roleFoerdermitglied;
      default: return role ?? '—';
    }
  }

  Color _getRoleColor(String? role) {
    switch (role) {
      case 'vorsitzer': return Colors.purple;
      case 'schatzmeister': return Colors.teal;
      case 'kassierer': return Colors.indigo;
      case 'mitgliedergrunder': return Colors.deepOrange;
      case 'ehrenmitglied': return Colors.amber.shade800;
      default: return Colors.blue;
    }
  }

  Future<void> _showEditEmailDialog() async {
    _newEmailController.text = _displayEmail;
    _emailPasswordController.clear();
    _obscureEmailPassword = true;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.email, color: Color(0xFF4a90d9)),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context)!.changeEmail),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _newEmailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.newEmailLabel,
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailPasswordController,
                obscureText: _obscureEmailPassword,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.currentPasswordLabel,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureEmailPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setDialogState(() => _obscureEmailPassword = !_obscureEmailPassword),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4a90d9),
                foregroundColor: Colors.white,
              ),
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );

    if (result == true) {
      await _changeEmail();
    }
  }


  Widget _buildKontoDataRow(IconData icon, String label, String value, {VoidCallback? onEdit, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                const SizedBox(height: 2),
                if (trailing != null)
                  trailing
                else
                  Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          if (onEdit != null)
            IconButton(
              icon: Icon(Icons.edit, size: 18, color: Colors.grey.shade500),
              onPressed: onEdit,
              tooltip: AppLocalizations.of(context)!.changeField(label),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    if (_loadingAccountInfo) {
      return const Center(child: CircularProgressIndicator());
    }

    final roleColor = _getRoleColor(_role);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== KONTODATEN =====
          _buildSectionHeader(Icons.person, 'Kontodaten', Colors.blue.shade700),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // Mitgliedernummer (read-only)
                  _buildKontoDataRow(Icons.badge, 'Mitgliedernummer', widget.mitgliedernummer),
                  Divider(height: 1, color: Colors.grey.shade200),
                  // Name (read-only)
                  _buildKontoDataRow(Icons.person_outline, 'Name', _displayName),
                  Divider(height: 1, color: Colors.grey.shade200),
                  // Email (editable)
                  _buildKontoDataRow(Icons.email, AppLocalizations.of(context)!.email, _displayEmail, onEdit: _showEditEmailDialog),
                  Divider(height: 1, color: Colors.grey.shade200),
                  // Rolle (read-only with color)
                  _buildKontoDataRow(
                    Icons.shield,
                    AppLocalizations.of(context)!.labelRole,
                    '',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: roleColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getRoleDisplayName(_role),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: roleColor),
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                  // Passwordless login info
                  _buildKontoDataRow(
                    Icons.verified_user,
                    'Anmeldung',
                    'Ohne Passwort (Vorstand-Genehmigung)',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ===== REGISTRIERUNG =====
          _buildSectionHeader(Icons.calendar_today, AppLocalizations.of(context)!.registration, Colors.green.shade700),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAccountDateRow(
                    Icons.person_add,
                    AppLocalizations.of(context)!.labelRegisteredOn,
                    _formatDateTime(_createdAt),
                    Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _buildAccountDateRow(
                    Icons.login,
                    AppLocalizations.of(context)!.labelLastLogin,
                    _formatDateTime(_lastLogin),
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ),

          // ===== DEAKTIVIERUNG (conditional) =====
          if (_deactivatedAt != null && _deactivatedAt!.isNotEmpty && _deactivatedAt != 'null') ...[
            const SizedBox(height: 20),
            _buildSectionHeader(Icons.block, AppLocalizations.of(context)!.deactivation, Colors.red.shade700),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: Colors.red.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.red.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAccountDateRow(
                      Icons.event_busy,
                      AppLocalizations.of(context)!.deactivatedOn,
                      _formatDateTime(_deactivatedAt),
                      Colors.red,
                    ),
                    if (_deactivationReason != null && _deactivationReason!.isNotEmpty && _deactivationReason != 'null') ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: Colors.red.shade700, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.reasonLabel2, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                Text(
                                  _deactivationReason!,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red.shade800),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    // 30-day info box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber, color: Colors.orange.shade700, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.accountAutoSuspend,
                              style: TextStyle(fontSize: 12, color: Colors.orange.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color),
        ),
      ],
    );
  }

  Future<void> _confirmRevokeMySession(int sessionId) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning, color: Colors.orange),
            const SizedBox(width: 8),
            Text(l10n.confirmLogoutDevice),
          ],
        ),
        content: Text(l10n.confirmLogoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _revokeMySession(sessionId);
    }
  }

  Widget _buildAccountDateRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
