import 'dart:io';

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/remote_input/input_injector_android.dart';
import '../services/theme_service.dart';
import '../services/update_service.dart';
import 'verifizierung_tab.dart';
import 'verwarnungen_tab.dart';
import 'dokumente_tab.dart';
import 'mitglieder_device.dart';
import 'mitgliedschaft_tab.dart';
import '../utils/app_theme.dart';

/// Die Einwilligung zu den SMS-Erinnerungen lässt sich hier jederzeit
/// ändern. Art. 7 Abs. 3 DSGVO verlangt das ausdrücklich: der Widerruf muss
/// so einfach sein wie die Erteilung — die im Startdialog erteilte
/// Zustimmung wäre sonst angreifbar.
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

class _MitgliedProfileDialogState extends State<MitgliedProfileDialog>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
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
  bool _autoUpdateEnabled = false;
  bool _fernsteuerungAn = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadMySessions();
    _loadAccountInfo();
    _loadAutoUpdatePreference();
    _ladeBenachrichtigung();
    if (Platform.isAndroid) {
      // ⚠️ Beobachter, weil der Schalter die App VERLAESST: das Mitglied
      // schaltet den Dienst in den Android-Einstellungen ein und kommt zurueck.
      // Ohne erneutes Lesen stuende hier weiter „aus", waehrend die Steuerung
      // laengst laeuft — und niemand wuesste, welche Anzeige stimmt.
      WidgetsBinding.instance.addObserver(this);
      _ladeFernsteuerung();
    }
  }

  Future<void> _ladeFernsteuerung() async {
    final an = await AndroidInputInjector.istAktiviert();
    if (mounted) setState(() => _fernsteuerungAn = an);
  }

  Future<void> _fernsteuerungEinstellungen() async {
    final offen = await AndroidInputInjector.einstellungenOeffnen();
    if (!offen && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.fernwartungSteuerungHinweis)),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && Platform.isAndroid) {
      _ladeFernsteuerung();
    }
  }

  Future<void> _loadAutoUpdatePreference() async {
    final enabled = await UpdateService.isAutoUpdateEnabled();
    if (mounted) setState(() => _autoUpdateEnabled = enabled);
  }

  @override
  void dispose() {
    if (Platform.isAndroid) WidgetsBinding.instance.removeObserver(this);
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
            backgroundColor: context.colors.successSolid,
          ),
        );
        _loadMySessions(); // Reload sessions
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error(result['message'] ?? l10n.unknownValue)),
            backgroundColor: context.colors.dangerSolid,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.connectionError(e.toString())),
          backgroundColor: context.colors.dangerSolid,
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
          backgroundColor: context.colors.dangerSolid,
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
            backgroundColor: context.colors.successSolid,
          ),
        );
        _newEmailController.clear();
        _emailPasswordController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? l10n.errorChangingEmail),
            backgroundColor: context.colors.dangerSolid,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.error(e.toString())),
          backgroundColor: context.colors.dangerSolid,
        ),
      );
    }
  }

  bool _smsTermine = false;
  bool _smsMedikamente = false;
  bool _smsWetter = false;
  bool _smsGeladen = false;
  bool _smsSpeichert = false;

  Future<void> _ladeBenachrichtigung() async {
    final res = await widget.apiService.getBenachrichtigung();
    if (!mounted || res['success'] != true) return;
    setState(() {
      _smsTermine = res['sms_termine'] == 'ja';
      _smsMedikamente = res['sms_medikamente'] == 'ja';
      _smsWetter = res['sms_wetter'] == 'ja';
      _smsGeladen = true;
    });
  }

  Future<void> _speichereBenachrichtigung(
      {bool? termine, bool? medikamente, bool? wetter}) async {
    setState(() => _smsSpeichert = true);
    final res = await widget.apiService.saveBenachrichtigung(
      termine: termine,
      medikamente: medikamente,
      wetter: wetter,
    );
    if (!mounted) return;
    setState(() {
      if (res['success'] == true) {
        if (termine != null) _smsTermine = termine;
        if (medikamente != null) _smsMedikamente = medikamente;
        if (wetter != null) _smsWetter = wetter;
      }
      _smsSpeichert = false;
    });
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
              decoration: BoxDecoration(
                color: context.colors.brand,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: context.colors.card,
                    child: Text(
                      widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'M',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: context.colors.brand,
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
                                    ? context.colors.warningFg
                                    : context.colors.successFg,
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
                  color: context.colors.dividerSubtle,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: context.colors.brand,
                    unselectedLabelColor: context.colors.textSecondary,
                    indicatorColor: context.colors.brandFill,
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
      case 'ehrenmitglied': return context.colors.warningFg;
      default: return context.colors.infoFg;
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
              Icon(Icons.email, color: context.colors.brand),
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
                backgroundColor: context.colors.brandFill,
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


  /// Label of the currently selected theme mode, for the settings row.
  String _themeAnzeige(AppLocalizations l10n) =>
      _themeLabel(l10n, ThemeService.instance.mode);

  IconData _themeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.phone_android;
      case AppThemeMode.schedule:
        return Icons.schedule;
    }
  }

  String _themeLabel(AppLocalizations l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return l10n.themeLight;
      case AppThemeMode.dark:
        return l10n.themeDark;
      case AppThemeMode.system:
        return l10n.themeSystem;
      case AppThemeMode.schedule:
        return l10n.themeSchedule;
    }
  }

  /// Vier Modi, die sich gegenseitig ausschließen — und nicht ein Hell/Dunkel-
  /// Schalter plus ein Nachtplan darüber. Übereinandergelegt widerspricht die
  /// App um 20 Uhr dem Telefon und stimmt ihm um 6 Uhr wieder zu; wer sie in
  /// der Hand hält, liest das als Fehler und nicht als Funktion.
  ///
  /// Die Auswahl greift sofort, ohne Speichern-Knopf: der Dialog zeichnet sich
  /// selbst im neuen Theme und IST damit die Vorschau.
  Future<void> _showThemeAuswahl() async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.themeTitle),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          content: SizedBox(
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final mode in AppThemeMode.values)
                  ListTile(
                    leading: Icon(
                      _themeIcon(mode),
                      color: ThemeService.instance.mode == mode
                          ? ctx.colors.brand
                          : ctx.colors.textSecondary,
                    ),
                    title: Text(_themeLabel(l10n, mode)),
                    subtitle: mode == AppThemeMode.schedule
                        ? Text(
                            l10n.themeScheduleHint,
                            style: TextStyle(
                                fontSize: 12, color: ctx.colors.textSecondary),
                          )
                        : null,
                    trailing: ThemeService.instance.mode == mode
                        ? Icon(Icons.check, color: ctx.colors.brand)
                        : null,
                    onTap: () async {
                      await ThemeService.instance.setMode(mode);
                      setDialogState(() {});
                      if (mounted) setState(() {});
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.close),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKontoDataRow(IconData icon, String label, String value, {VoidCallback? onEdit, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: context.colors.textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 11, color: context.colors.textTertiary)),
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
              icon: Icon(Icons.edit, size: 18, color: context.colors.textTertiary),
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
          _buildSectionHeader(Icons.person, 'Kontodaten', context.colors.infoFg),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: context.colors.divider),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // Mitgliedernummer (read-only)
                  _buildKontoDataRow(Icons.badge, 'Mitgliedernummer', widget.mitgliedernummer),
                  Divider(height: 1, color: context.colors.dividerSubtle),
                  // Name (read-only)
                  _buildKontoDataRow(Icons.person_outline, 'Name', _displayName),
                  Divider(height: 1, color: context.colors.dividerSubtle),
                  // Email (editable)
                  _buildKontoDataRow(Icons.email, AppLocalizations.of(context)!.email, _displayEmail, onEdit: _showEditEmailDialog),
                  Divider(height: 1, color: context.colors.dividerSubtle),
                  // Darstellung (editable) — eine Einstellung der Oberfläche,
                  // die mit der Mitgliedschaft nichts zu tun hat, aber hier
                  // steht, weil dies der einzige Ort ist, an den ein Mitglied
                  // seine eigenen Einstellungen zu suchen kommt.
                  _buildKontoDataRow(
                      Icons.brightness_6,
                      AppLocalizations.of(context)!.themeTitle,
                      _themeAnzeige(AppLocalizations.of(context)!),
                      onEdit: _showThemeAuswahl),
                  Divider(height: 1, color: context.colors.dividerSubtle),
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
                  Divider(height: 1, color: context.colors.dividerSubtle),
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
          _buildSectionHeader(Icons.calendar_today, AppLocalizations.of(context)!.registration, context.colors.successFg),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: context.colors.divider),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAccountDateRow(
                    Icons.person_add,
                    AppLocalizations.of(context)!.labelRegisteredOn,
                    _formatDateTime(_createdAt),
                    context.colors.successFg,
                  ),
                  const SizedBox(height: 12),
                  _buildAccountDateRow(
                    Icons.login,
                    AppLocalizations.of(context)!.labelLastLogin,
                    _formatDateTime(_lastLogin),
                    context.colors.infoFg,
                  ),
                ],
              ),
            ),
          ),

          // ===== DEAKTIVIERUNG (conditional) =====
          if (_deactivatedAt != null && _deactivatedAt!.isNotEmpty && _deactivatedAt != 'null') ...[
            const SizedBox(height: 20),
            _buildSectionHeader(Icons.block, AppLocalizations.of(context)!.deactivation, context.colors.dangerFg),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: context.colors.dangerBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: context.colors.dangerBorder),
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
                      context.colors.dangerFg,
                    ),
                    if (_deactivationReason != null && _deactivationReason!.isNotEmpty && _deactivationReason != 'null') ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: context.colors.dangerFg, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.reasonLabel2, style: TextStyle(fontSize: 12, color: context.colors.textSecondary)),
                                Text(
                                  _deactivationReason!,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: context.colors.dangerFg),
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
                        color: context.colors.warningBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.warningBorder),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber, color: context.colors.warningFg, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.accountAutoSuspend,
                              style: TextStyle(fontSize: 12, color: context.colors.warningFg),
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

          // ===== UPDATES (desktop only) =====
          // The consent checkbox in UpdateDialog can only ever turn this on,
          // and once it is on the dialog stops appearing entirely - so without
          // a switch here the choice would be one-way in both directions.
          if (_smsGeladen) ...[
            const SizedBox(height: 20),
            _buildSectionHeader(
              Icons.sms_outlined,
              AppLocalizations.of(context)!.benachrichtigungTitel,
              Colors.teal.shade700,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: context.colors.divider),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    value: _smsTermine,
                    onChanged: _smsSpeichert
                        ? null
                        : (v) => _speichereBenachrichtigung(termine: v),
                    title: Text(
                      AppLocalizations.of(context)!.benachrichtigungTermineFrage,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context)!.benachrichtigungTermineDetail,
                      style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    value: _smsWetter,
                    onChanged: _smsSpeichert
                        ? null
                        : (v) => _speichereBenachrichtigung(wetter: v),
                    title: Text(
                      AppLocalizations.of(context)!.benachrichtigungWetterFrage,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context)!.benachrichtigungWetterDetail,
                      style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    value: _smsMedikamente,
                    onChanged: _smsSpeichert
                        ? null
                        : (v) => _speichereBenachrichtigung(medikamente: v),
                    title: Text(
                      AppLocalizations.of(context)!.benachrichtigungMedikamenteFrage,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context)!.benachrichtigungMedikamenteDetail,
                      style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Fernwartung: Fernsteuerung. Nur Android — auf dem Schreibtisch
          // steuert der Vorsitz ohnehin (SendInput/XTest/CGEvent), auf iOS
          // laesst die Plattform es gar nicht zu. Eine Zeile, die auf beiden
          // nichts bewirkt, waere ein leeres Versprechen.
          if (Platform.isAndroid) ...[
            const SizedBox(height: 20),
            _buildSectionHeader(
              Icons.screen_share_outlined,
              AppLocalizations.of(context)!.fernwartungTitel,
              Colors.lightBlue.shade700,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: context.colors.divider),
              ),
              child: SwitchListTile(
                value: _fernsteuerungAn,
                // ⚠️ Der Schalter kann NICHT selbst einschalten: eine App darf
                // sich einen Bedienungshilfen-Dienst nicht erteilen. Er oeffnet
                // die Systemseite; den Zustand liest er beim Zurueckkommen neu.
                // Deshalb ist er ein Schalter mit Aussenwirkung, kein Regler.
                onChanged: (_) => _fernsteuerungEinstellungen(),
                secondary: _fernsteuerungAn
                    ? Icon(Icons.check_circle, color: context.colors.successFg)
                    : null,
                title: Text(
                  AppLocalizations.of(context)!.fernwartungSteuerungTitel,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  _fernsteuerungAn
                      ? AppLocalizations.of(context)!.fernwartungSteuerungAktiv
                      : AppLocalizations.of(context)!.fernwartungSteuerungHinweis,
                  style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
                ),
              ),
            ),
          ],
          if (UpdateService().supportsSilentUpdate) ...[
            const SizedBox(height: 20),
            _buildSectionHeader(
              Icons.system_update,
              AppLocalizations.of(context)!.updateAvailable,
              context.colors.infoFg,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: context.colors.divider),
              ),
              child: SwitchListTile(
                value: _autoUpdateEnabled,
                onChanged: (v) async {
                  await UpdateService.setAutoUpdateEnabled(v);
                  if (mounted) setState(() => _autoUpdateEnabled = v);
                },
                title: Text(
                  AppLocalizations.of(context)!.autoUpdateEnableTitle,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.autoUpdateEnableHint,
                  style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
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
            Icon(Icons.warning, color: context.colors.warningFg),
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
            style: TextButton.styleFrom(foregroundColor: context.colors.dangerFg),
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
                style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
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
