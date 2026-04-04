import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../screens/webview_screen.dart';

class VerifizierungTab extends StatefulWidget {
  final String mitgliedernummer;

  const VerifizierungTab({super.key, required this.mitgliedernummer});

  @override
  State<VerifizierungTab> createState() => _VerifizierungTabState();
}

class _VerifizierungTabState extends State<VerifizierungTab> {
  final _apiService = ApiService();

  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _stufen = [];
  Map<String, dynamic> _personalData = {};
  Map<String, dynamic> _documentAcceptances = {};

  // Stufe 1: Personal data controllers
  final _vornameController = TextEditingController();
  final _nachnameController = TextEditingController();
  final _strasseController = TextEditingController();
  final _hausnummerController = TextEditingController();
  final _plzController = TextEditingController();
  final _ortController = TextEditingController();
  final _telefonMobilController = TextEditingController();
  DateTime? _selectedGeburtsdatum;

  // Stufe 2: Mitgliedsart
  String? _selectedMitgliedsart;

  // Stufe 3: Finanzielle Situation
  String? _selectedFinanzielleSituation;

  // Stufe 4: Zahlungsmethode + Zahlungstag
  String? _selectedZahlungsmethode;
  int? _selectedZahlungstag;

  // Stufe 5: Mitgliedschaftsbeginn
  String? _selectedMitgliedschaftsbeginnOption;
  DateTime? _selectedMitgliedschaftsbeginnDatum;

  // Stufe 6-8: Document acceptance
  final Map<int, bool> _documentChecked = {6: false, 7: false, 8: false};

  bool _isSaving = false;

  Map<String, String> _getMitgliedsartLabels() {
    final l = AppLocalizations.of(context)!;
    return {
      'ordentlich': l.memberType_ordentlich,
      'foerdermitglied': l.memberType_foerder,
      'ehrenmitglied': l.memberType_ehren,
    };
  }

  Map<String, String> _getMitgliedsartDescriptions() {
    final l = AppLocalizations.of(context)!;
    return {
      'ordentlich': l.memberDesc_ordentlich,
      'foerdermitglied': l.memberDesc_foerder,
      'ehrenmitglied': l.memberDesc_ehren,
    };
  }

  Map<String, String> _getZahlungsmethodeLabels() {
    final l = AppLocalizations.of(context)!;
    return {
      'ueberweisung': l.payMethod_ueberweisung,
      'sepa_lastschrift': 'SEPA-Lastschrift',
      'dauerauftrag': l.payMethod_dauerauftrag,
    };
  }

  Map<int, String> _getStufenNames() {
    final l = AppLocalizations.of(context)!;
    return {
      1: l.stufe1_name,
      2: l.stufe2_name,
      3: l.stufe3_name,
      4: l.stufe4_name,
      5: l.stufe5_name,
      6: l.stufe6_name,
      7: l.stufe7_name,
      8: l.stufe8_name,
    };
  }

  static const Map<int, IconData> _stufenIcons = {
    1: Icons.person,
    2: Icons.badge,
    3: Icons.account_balance_wallet,
    4: Icons.payment,
    5: Icons.calendar_today,
    6: Icons.description,
    7: Icons.lock,
    8: Icons.gavel,
  };

  static const Map<int, String> _documentUrls = {
    6: 'https://icd360sev.icd360s.de/satzung',
    7: 'https://icd360sev.icd360s.de/datenschutz',
    8: 'https://icd360sev.icd360s.de/widerrufsbelehrung',
  };

  @override
  void initState() {
    super.initState();
    _loadVerifizierung();
  }

  @override
  void dispose() {
    _vornameController.dispose();
    _nachnameController.dispose();
    _strasseController.dispose();
    _hausnummerController.dispose();
    _plzController.dispose();
    _ortController.dispose();
    _telefonMobilController.dispose();
    super.dispose();
  }

  Future<void> _loadVerifizierung() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _apiService.getMyVerifizierung();

      if (!mounted) return;

      if (result['success'] == true) {
        final data = result['data'] ?? result;
        setState(() {
          _stufen = List<Map<String, dynamic>>.from(data['stufen'] ?? []);
          _personalData = Map<String, dynamic>.from(data['personal_data'] ?? {});
          _documentAcceptances = Map<String, dynamic>.from(data['document_acceptances'] ?? {});
          _isLoading = false;
          _populateFormFields();
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
        _error = '${AppLocalizations.of(context)!.connectionErrorGeneric}: $e';
        _isLoading = false;
      });
    }
  }

  void _populateFormFields() {
    _vornameController.text = _personalData['vorname'] ?? '';
    _nachnameController.text = _personalData['nachname'] ?? '';
    _strasseController.text = _personalData['strasse'] ?? '';
    _hausnummerController.text = _personalData['hausnummer'] ?? '';
    _plzController.text = _personalData['plz'] ?? '';
    _ortController.text = _personalData['ort'] ?? '';
    _telefonMobilController.text = _personalData['telefon_mobil'] ?? '';

    final gd = _personalData['geburtsdatum'];
    _selectedGeburtsdatum = gd != null ? DateTime.tryParse(gd.toString()) : null;

    final ma = _personalData['mitgliedsart']?.toString() ?? '';
    _selectedMitgliedsart = _getMitgliedsartLabels().containsKey(ma) ? ma : null;

    final fs = _personalData['finanzielle_situation']?.toString() ?? '';
    _selectedFinanzielleSituation = (fs == 'buergergeld' || fs == 'sozialamt' || fs == 'nein') ? fs : null;

    final zm = _personalData['zahlungsmethode'] ?? '';
    _selectedZahlungsmethode = _getZahlungsmethodeLabels().containsKey(zm) ? zm : null;

    final zt = _personalData['zahlungstag'];
    _selectedZahlungstag = zt != null ? int.tryParse(zt.toString()) : null;

    final mbo = _personalData['mitgliedschaftsbeginn_option']?.toString() ?? '';
    _selectedMitgliedschaftsbeginnOption =
        (mbo == 'ab_verifizierung' || mbo == 'gruendungsdatum' || mbo == 'anderes_datum') ? mbo : null;

    final mbd = _personalData['mitgliedschaftsbeginn_datum'];
    _selectedMitgliedschaftsbeginnDatum = mbd != null ? DateTime.tryParse(mbd.toString()) : null;
  }

  String _getStatusForStufe(int stufe) {
    for (final s in _stufen) {
      if (s['stufe'] == stufe) return s['status'] ?? 'offen';
    }
    return 'offen';
  }

  String? _getNotizForStufe(int stufe) {
    for (final s in _stufen) {
      if (s['stufe'] == stufe) return s['notiz'];
    }
    return null;
  }

  String? _getTimestampForStufe(int stufe) {
    for (final s in _stufen) {
      if (s['stufe'] == stufe) {
        return s['accepted_at'] ?? s['updated_at'] ?? s['created_at'];
      }
    }
    return null;
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dt = DateTime.parse(timestamp);
      return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}, '
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return timestamp;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'geprueft':
        return Colors.green;
      case 'ausgefuellt':
        return Colors.blue;
      case 'abgelehnt':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _statusLabel(String status) {
    final l = AppLocalizations.of(context)!;
    switch (status) {
      case 'geprueft':
        return l.verifyStatus_geprueft;
      case 'ausgefuellt':
        return l.verifyStatus_ausgefuellt;
      case 'abgelehnt':
        return l.verifyStatus_abgelehnt;
      default:
        return l.verifyStatus_offen;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'geprueft':
        return Icons.check_circle;
      case 'ausgefuellt':
        return Icons.hourglass_top;
      case 'abgelehnt':
        return Icons.cancel;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  bool _canEdit(String status) {
    return status == 'offen' || status == 'abgelehnt';
  }

  bool _isStufe4Skipped() {
    return _selectedFinanzielleSituation == 'buergergeld' ||
        _selectedFinanzielleSituation == 'sozialamt';
  }

  bool _isStufeUnlocked(int stufe) {
    if (stufe <= 1) return true;
    if (stufe == 4 && _isStufe4Skipped()) return false;
    // Stufe 5 unlocks after Stufe 3 if Stufe 4 is skipped
    if (stufe == 5 && _isStufe4Skipped()) {
      final s3 = _getStatusForStufe(3);
      return s3 == 'ausgefuellt' || s3 == 'geprueft';
    }
    final prevStatus = _getStatusForStufe(stufe - 1);
    return prevStatus == 'ausgefuellt' || prevStatus == 'geprueft';
  }

  // ============ SAVE METHODS ============

  Future<void> _saveStufe1() async {
    if (_vornameController.text.trim().isEmpty ||
        _nachnameController.text.trim().isEmpty ||
        _selectedGeburtsdatum == null ||
        _strasseController.text.trim().isEmpty ||
        _hausnummerController.text.trim().isEmpty ||
        _plzController.text.trim().isEmpty ||
        _ortController.text.trim().isEmpty ||
        _telefonMobilController.text.trim().isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.fillRequiredFields, isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      final result = await _apiService.updatePersonalData(
        vorname: _vornameController.text.trim(),
        nachname: _nachnameController.text.trim(),
        strasse: _strasseController.text.trim(),
        hausnummer: _hausnummerController.text.trim(),
        plz: _plzController.text.trim(),
        ort: _ortController.text.trim(),
        telefonMobil: _telefonMobilController.text.trim(),
        geburtsdatum: DateFormat('yyyy-MM-dd').format(_selectedGeburtsdatum!),
      );

      if (!mounted) return;

      if (result['success'] == true) {
        _showSnackBar(AppLocalizations.of(context)!.personalDataSaved);
        _loadVerifizierung();
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.notifError, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.error(e.toString()), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _saveStufe2() async {
    if (_selectedMitgliedsart == null) {
      _showSnackBar(AppLocalizations.of(context)!.selectMemberType, isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      final result = await _apiService.updatePersonalData(
        vorname: _vornameController.text.trim().isEmpty ? (_personalData['vorname'] ?? '') : _vornameController.text.trim(),
        nachname: _nachnameController.text.trim().isEmpty ? (_personalData['nachname'] ?? '') : _nachnameController.text.trim(),
        strasse: _strasseController.text.trim().isEmpty ? (_personalData['strasse'] ?? '') : _strasseController.text.trim(),
        hausnummer: _hausnummerController.text.trim().isEmpty ? (_personalData['hausnummer'] ?? '') : _hausnummerController.text.trim(),
        plz: _plzController.text.trim().isEmpty ? (_personalData['plz'] ?? '') : _plzController.text.trim(),
        ort: _ortController.text.trim().isEmpty ? (_personalData['ort'] ?? '') : _ortController.text.trim(),
        mitgliedsart: _selectedMitgliedsart,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        _showSnackBar(AppLocalizations.of(context)!.memberTypeSaved);
        _loadVerifizierung();
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.notifError, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.error(e.toString()), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _saveStufe3Finanziell() async {
    if (_selectedFinanzielleSituation == null) {
      _showSnackBar(AppLocalizations.of(context)!.selectOption, isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      final result = await _apiService.updateFinanzielleSituation(
        finanzielleSituation: _selectedFinanzielleSituation!,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        _showSnackBar(AppLocalizations.of(context)!.financialSaved);
        _loadVerifizierung();
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.notifError, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.error(e.toString()), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _saveStufe4Zahlung() async {
    if (_selectedZahlungsmethode == null) {
      _showSnackBar(AppLocalizations.of(context)!.selectPaymentMethod, isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      final result = await _apiService.updateZahlungsdaten(
        zahlungsmethode: _selectedZahlungsmethode!,
        zahlungstag: _selectedZahlungstag,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        _showSnackBar(AppLocalizations.of(context)!.paymentDataSaved);
        _loadVerifizierung();
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.notifError, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.error(e.toString()), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _saveStufe5Mitgliedschaft() async {
    if (_selectedMitgliedschaftsbeginnOption == null) {
      _showSnackBar(AppLocalizations.of(context)!.selectOption, isError: true);
      return;
    }
    if (_selectedMitgliedschaftsbeginnOption == 'anderes_datum' &&
        _selectedMitgliedschaftsbeginnDatum == null) {
      _showSnackBar(AppLocalizations.of(context)!.selectDate, isError: true);
      return;
    }

    setState(() => _isSaving = true);
    try {
      String? datum;
      if (_selectedMitgliedschaftsbeginnOption == 'gruendungsdatum') {
        datum = '2025-08-01';
      } else if (_selectedMitgliedschaftsbeginnOption == 'anderes_datum' &&
          _selectedMitgliedschaftsbeginnDatum != null) {
        datum = DateFormat('yyyy-MM-dd').format(_selectedMitgliedschaftsbeginnDatum!);
      }

      final result = await _apiService.updateMitgliedschaftsbeginn(
        option: _selectedMitgliedschaftsbeginnOption!,
        datum: datum,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        _showSnackBar(AppLocalizations.of(context)!.membershipStartSaved);
        _loadVerifizierung();
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.notifError, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.error(e.toString()), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _acceptDocument(int stufe) async {
    setState(() => _isSaving = true);
    try {
      final result = await _apiService.acceptDocument(stufe);
      if (!mounted) return;
      if (result['success'] == true) {
        _showSnackBar('${_getStufenNames()[stufe]} ${AppLocalizations.of(context)!.statusAccepted.toLowerCase()}');
        _documentChecked[stufe] = false;
        _loadVerifizierung();
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.notifError, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.error(e.toString()), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
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

  // ============ BUILD METHODS ============

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
              onPressed: _loadVerifizierung,
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProgressBar(),
          const SizedBox(height: 16),
          for (int i = 1; i <= 5; i++) ...[
            _buildStufeCard(i),
            const SizedBox(height: 8),
          ],
          // Registration document acceptances
          if (_documentAcceptances.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildRegistrationAcceptanceSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final bool stufe4Skipped = _isStufe4Skipped();
    final int totalStages = stufe4Skipped ? 4 : 5;
    int totalCompleted = 0;
    for (int i = 1; i <= 5; i++) {
      if (i == 4 && stufe4Skipped) continue;
      final status = _getStatusForStufe(i);
      if (status == 'ausgefuellt' || status == 'geprueft') {
        totalCompleted++;
      }
    }

    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.verificationProgress,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  AppLocalizations.of(context)!.stepsCompleted(totalCompleted, totalStages),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: totalCompleted == totalStages ? Colors.green : Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: totalCompleted / totalStages,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  totalCompleted == totalStages ? Colors.green : Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStufeCard(int stufe) {
    final status = _getStatusForStufe(stufe);
    final notiz = _getNotizForStufe(stufe);
    final canEdit = _canEdit(status);
    final isUnlocked = _isStufeUnlocked(stufe);
    final isSkipped = stufe == 4 && _isStufe4Skipped();

    // Stufe 4 skipped (Bürgergeld/Sozialamt) - grey card with "Nicht erforderlich"
    if (isSkipped) {
      return Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.grey.shade100,
        child: ListTile(
          leading: Icon(Icons.block, color: Colors.grey.shade400),
          title: Row(
            children: [
              Icon(_stufenIcons[stufe] ?? Icons.circle, size: 18, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${_stufenCircle(stufe)} ${_getStufenNames()[stufe]}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppLocalizations.of(context)!.notApplicable,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber.shade800),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              AppLocalizations.of(context)!.socialBenefitsExempt,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      );
    }

    // Locked stufe (previous not completed) - grey card with lock icon
    if (!isUnlocked) {
      return Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.grey.shade100,
        child: ListTile(
          leading: Icon(Icons.lock, color: Colors.grey.shade400),
          title: Row(
            children: [
              Icon(_stufenIcons[stufe] ?? Icons.circle, size: 18, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${_stufenCircle(stufe)} ${_getStufenNames()[stufe]}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppLocalizations.of(context)!.locked,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade500),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              AppLocalizations.of(context)!.completePreviousStep(
                stufe == 5 && _isStufe4Skipped() ? 3 : stufe - 1,
              ),
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      );
    }

    // Normal unlocked card
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(
          _statusIcon(status),
          color: _statusColor(status),
        ),
        title: Row(
          children: [
            Icon(_stufenIcons[stufe] ?? Icons.circle, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${_stufenCircle(stufe)} ${_getStufenNames()[stufe]}',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _statusColor(status).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _statusLabel(status),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _statusColor(status),
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more),
          ],
        ),
        children: [
          // Status banners
          if (status == 'abgelehnt' && notiz != null && notiz.isNotEmpty)
            _buildStatusBanner(
              icon: Icons.warning_amber,
              text: AppLocalizations.of(context)!.rejectedNote(notiz),
              color: Colors.red,
            ),
          if (status == 'ausgefuellt')
            _buildStatusBanner(
              icon: Icons.hourglass_top,
              text: AppLocalizations.of(context)!.waitingForReview,
              color: Colors.blue,
            ),
          if (status == 'geprueft')
            _buildStatusBanner(
              icon: Icons.check_circle,
              text: AppLocalizations.of(context)!.stepApproved,
              color: Colors.green,
            ),
          if (status == 'geprueft')
            _buildStatusBanner(
              icon: Icons.chat,
              text: AppLocalizations.of(context)!.changesViaChat,
              color: Colors.orange,
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildStufeContent(stufe, canEdit),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBanner({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color.withValues(alpha: 0.8), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.9)),
            ),
          ),
        ],
      ),
    );
  }

  String _stufenCircle(int stufe) {
    const circles = ['', '\u2460', '\u2461', '\u2462', '\u2463', '\u2464', '\u2465', '\u2466'];
    return (stufe >= 0 && stufe < circles.length) ? circles[stufe] : '';
  }

  Widget _buildStufeContent(int stufe, bool canEdit) {
    switch (stufe) {
      case 1:
        return _buildStufe1Form(canEdit);
      case 2:
        return _buildStufe2Form(canEdit);
      case 3:
        return _buildStufe3FinanziellForm(canEdit);
      case 4:
        return _buildStufe4ZahlungForm(canEdit);
      case 5:
        return _buildStufe5MitgliedschaftForm(canEdit);
      case 6:
      case 7:
      case 8:
        return _buildDocumentStufe(stufe, canEdit);
      default:
        return const SizedBox.shrink();
    }
  }

  // ============ STUFE 1: PERSÖNLICHE DATEN ============

  Widget _buildStufe1Form(bool canEdit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vorname + Nachname
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _vornameController,
                label: AppLocalizations.of(context)!.firstNameRequired,
                enabled: canEdit,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _nachnameController,
                label: AppLocalizations.of(context)!.lastNameRequired,
                enabled: canEdit,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Geburtsdatum
        GestureDetector(
          onTap: canEdit ? () => _pickGeburtsdatum() : null,
          child: AbsorbPointer(
            child: TextField(
              controller: TextEditingController(
                text: _selectedGeburtsdatum != null
                    ? DateFormat('dd.MM.yyyy').format(_selectedGeburtsdatum!)
                    : '',
              ),
              enabled: false,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.birthDateLabel,
                prefixIcon: const Icon(Icons.cake),
                suffixIcon: canEdit ? const Icon(Icons.calendar_today) : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: canEdit ? Colors.white : Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Straße + Hausnummer
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildTextField(
                controller: _strasseController,
                label: AppLocalizations.of(context)!.streetRequired,
                enabled: canEdit,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _hausnummerController,
                label: AppLocalizations.of(context)!.houseNumberRequired,
                enabled: canEdit,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // PLZ + Ort
        Row(
          children: [
            SizedBox(
              width: 100,
              child: _buildTextField(
                controller: _plzController,
                label: AppLocalizations.of(context)!.postalCodeLabel,
                enabled: canEdit,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _ortController,
                label: AppLocalizations.of(context)!.cityRequired,
                enabled: canEdit,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Telefonnummer
        _buildTextField(
          controller: _telefonMobilController,
          label: AppLocalizations.of(context)!.phoneRequired,
          enabled: canEdit,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            AppLocalizations.of(context)!.phonePurpose,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
          ),
        ),
        if (canEdit) ...[
          const SizedBox(height: 16),
          _buildSaveButton(onPressed: _saveStufe1),
        ],
      ],
    );
  }

  Future<void> _pickGeburtsdatum() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedGeburtsdatum ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      locale: const Locale('de'),
    );
    if (picked != null && mounted) {
      setState(() => _selectedGeburtsdatum = picked);
    }
  }

  // ============ STUFE 2: MITGLIEDSART ============

  Widget _buildStufe2Form(bool canEdit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.selectMemberTypePrompt,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 12),
        for (final entry in _getMitgliedsartLabels().entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: canEdit ? () => setState(() => _selectedMitgliedsart = entry.key) : null,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selectedMitgliedsart == entry.key ? Colors.blue.shade50 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedMitgliedsart == entry.key ? Colors.blue.shade300 : Colors.grey.shade200,
                    width: _selectedMitgliedsart == entry.key ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _selectedMitgliedsart == entry.key ? Icons.radio_button_checked : Icons.radio_button_off,
                          size: 20,
                          color: _selectedMitgliedsart == entry.key ? Colors.blue.shade700 : Colors.grey.shade400,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _selectedMitgliedsart == entry.key ? Colors.blue.shade900 : Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_getMitgliedsartDescriptions()[entry.key] != null) ...[
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Text(
                          _getMitgliedsartDescriptions()[entry.key]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: _selectedMitgliedsart == entry.key ? Colors.blue.shade800 : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        if (canEdit) ...[
          const SizedBox(height: 8),
          _buildSaveButton(onPressed: _saveStufe2),
        ],
      ],
    );
  }

  // ============ STUFE 3: FINANZIELLE SITUATION ============

  Widget _buildStufe3FinanziellForm(bool canEdit) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        final showUpload = _selectedFinanzielleSituation == 'buergergeld' ||
            _selectedFinanzielleSituation == 'sozialamt';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Explanation text
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 20, color: Colors.blue.shade700),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.financialExplanation,
                      style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.socialBenefitsQuestion,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            // Option: Bürgergeld
            _buildFinanziellOption(
              value: 'buergergeld',
              label: AppLocalizations.of(context)!.optionBuergergeld,
              icon: Icons.account_balance,
              canEdit: canEdit,
              setLocalState: setLocalState,
            ),
            const SizedBox(height: 8),
            // Option: Sozialamt
            _buildFinanziellOption(
              value: 'sozialamt',
              label: AppLocalizations.of(context)!.optionSozialamt,
              icon: Icons.health_and_safety,
              canEdit: canEdit,
              setLocalState: setLocalState,
            ),
            const SizedBox(height: 8),
            // Option: Nein
            _buildFinanziellOption(
              value: 'nein',
              label: AppLocalizations.of(context)!.optionNoBenefits,
              icon: Icons.work,
              canEdit: canEdit,
              setLocalState: setLocalState,
            ),
            // Conditional content based on selection
            if (showUpload) ...[
              const SizedBox(height: 16),
              // 0€ hint
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 20, color: Colors.green.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.feeExempt,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Upload hint
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.upload_file, size: 20, color: Colors.orange.shade700),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.uploadLeistungsbescheid,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.uploadLeistungsbescheidHint,
                      style: TextStyle(fontSize: 12, color: Colors.orange.shade800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.allowedFormatsUpload,
                      style: TextStyle(fontSize: 11, color: Colors.orange.shade700, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              if (canEdit) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _isSaving ? null : _pickLeistungsbescheid,
                    icon: const Icon(Icons.cloud_upload),
                    label: Text(AppLocalizations.of(context)!.selectFile),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ] else if (_selectedFinanzielleSituation == 'nein') ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.euro, size: 20, color: Colors.blue.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.feeRegular,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (canEdit) ...[
              const SizedBox(height: 16),
              _buildSaveButton(onPressed: _saveStufe3Finanziell),
            ],
          ],
        );
      },
    );
  }

  Widget _buildFinanziellOption({
    required String value,
    required String label,
    required IconData icon,
    required bool canEdit,
    required void Function(void Function()) setLocalState,
  }) {
    final isSelected = _selectedFinanzielleSituation == value;
    return GestureDetector(
      onTap: canEdit
          ? () {
              setState(() => _selectedFinanzielleSituation = value);
              setLocalState(() {});
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue.shade300 : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: isSelected ? Colors.blue.shade700 : Colors.grey.shade400,
            ),
            const SizedBox(width: 10),
            Icon(icon, size: 18, color: isSelected ? Colors.blue.shade700 : Colors.grey.shade500),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.blue.shade900 : Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickLeistungsbescheid() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result == null || result.files.single.path == null) return;

    final filePath = result.files.single.path!;
    final fileSize = File(filePath).lengthSync();

    // Max 10 MB
    if (fileSize > 10 * 1024 * 1024) {
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.fileTooLarge, isError: true);
      return;
    }

    if (!mounted) return;

    // Show upload progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(AppLocalizations.of(context)!.uploading),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      final uploadResult = await _apiService.uploadLeistungsbescheid(filePath);

      if (!mounted) return;
      Navigator.pop(context); // Close progress dialog

      if (uploadResult['success'] == true) {
        _showSnackBar(AppLocalizations.of(context)!.leistungsbescheidUploaded);
        _loadVerifizierung();
      } else {
        _showSnackBar(uploadResult['message'] ?? AppLocalizations.of(context)!.uploadFailed, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close progress dialog
      _showSnackBar('${AppLocalizations.of(context)!.errorUploading}: $e', isError: true);
    }
  }

  // ============ STUFE 4: ZAHLUNGSMETHODE ============

  Widget _buildStufe4ZahlungForm(bool canEdit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioGroup<String>(
          groupValue: _selectedZahlungsmethode ?? '',
          onChanged: (value) {
            if (canEdit) setState(() => _selectedZahlungsmethode = value);
          },
          child: Column(
            children: [
              for (final entry in _getZahlungsmethodeLabels().entries)
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: _selectedZahlungsmethode == entry.key ? Colors.blue.shade50 : null,
                  child: RadioListTile<String>(
                    title: Text(entry.value),
                    value: entry.key,
                    activeColor: const Color(0xFF4a90d9),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Zahlungstag Dropdown
        DropdownButtonFormField<int>(
          key: ValueKey('zahlungstag_$_selectedZahlungstag'),
          initialValue: _selectedZahlungstag,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.paymentDayLabel,
            prefixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: canEdit ? Colors.white : Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          items: List.generate(31, (i) => i + 1)
              .map((day) => DropdownMenuItem(
                    value: day,
                    child: Text(AppLocalizations.of(context)!.dayOfMonth(day)),
                  ))
              .toList(),
          onChanged: canEdit ? (value) => setState(() => _selectedZahlungstag = value) : null,
        ),
        if (_selectedZahlungstag != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.blue.shade700),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.paymentDayReminder(_selectedZahlungstag!),
                    style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (canEdit) ...[
          const SizedBox(height: 16),
          _buildSaveButton(onPressed: _saveStufe4Zahlung),
        ],
      ],
    );
  }

  // ============ STUFE 5: MITGLIEDSCHAFTSBEGINN ============

  Widget _buildStufe5MitgliedschaftForm(bool canEdit) {
    final gruendungsdatum = DateTime(2025, 8, 1);
    final today = DateTime.now();
    final isBeitragsfrei = _isStufe4Skipped();

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.membershipStartPrompt,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),

            // Option 1: Ab Abschluss der Verifizierung
            _buildMitgliedschaftOption(
              value: 'ab_verifizierung',
              label: AppLocalizations.of(context)!.optionAfterVerification,
              subtitle: AppLocalizations.of(context)!.optionAfterVerificationDesc,
              icon: Icons.check_circle_outline,
              canEdit: canEdit,
              setLocalState: setLocalState,
            ),
            const SizedBox(height: 8),

            // Option 2: Rückwirkend zum Gründungsdatum
            _buildMitgliedschaftOption(
              value: 'gruendungsdatum',
              label: AppLocalizations.of(context)!.optionRetroFoundation,
              subtitle: AppLocalizations.of(context)!.optionRetroFoundationDesc,
              icon: Icons.history,
              canEdit: canEdit,
              setLocalState: setLocalState,
            ),
            const SizedBox(height: 8),

            // Option 3: Rückwirkend zu einem anderen Datum
            _buildMitgliedschaftOption(
              value: 'anderes_datum',
              label: AppLocalizations.of(context)!.optionRetroCustom,
              subtitle: AppLocalizations.of(context)!.optionRetroCustomDesc,
              icon: Icons.date_range,
              canEdit: canEdit,
              setLocalState: setLocalState,
            ),

            // Date picker for "anderes_datum"
            if (_selectedMitgliedschaftsbeginnOption == 'anderes_datum') ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: canEdit
                    ? () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedMitgliedschaftsbeginnDatum ?? today,
                          firstDate: gruendungsdatum,
                          lastDate: today,
                          locale: const Locale('de'),
                        );
                        if (picked != null) {
                          setState(() => _selectedMitgliedschaftsbeginnDatum = picked);
                          setLocalState(() {});
                        }
                      }
                    : null,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.selectDateLabel,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: canEdit ? Colors.white : Colors.grey.shade100,
                    prefixIcon: const Icon(Icons.calendar_today),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  child: Text(
                    _selectedMitgliedschaftsbeginnDatum != null
                        ? DateFormat('dd.MM.yyyy').format(_selectedMitgliedschaftsbeginnDatum!)
                        : AppLocalizations.of(context)!.selectDateHint,
                    style: TextStyle(
                      color: _selectedMitgliedschaftsbeginnDatum != null
                          ? Colors.black87
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  AppLocalizations.of(context)!.dateNotBefore,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                ),
              ),
            ],

            // Info box about retroactive fees
            if (_selectedMitgliedschaftsbeginnOption == 'gruendungsdatum' ||
                (_selectedMitgliedschaftsbeginnOption == 'anderes_datum' &&
                    _selectedMitgliedschaftsbeginnDatum != null)) ...[
              const SizedBox(height: 16),
              Builder(builder: (_) {
                DateTime startDate;
                if (_selectedMitgliedschaftsbeginnOption == 'gruendungsdatum') {
                  startDate = gruendungsdatum;
                } else {
                  startDate = _selectedMitgliedschaftsbeginnDatum!;
                }
                final months = _monthsBetween(startDate, today);

                if (isBeitragsfrei) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, size: 20, color: Colors.green.shade700),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.feeExemptRetro,
                            style: TextStyle(fontSize: 13, color: Colors.green.shade800),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  final retroBeitrag = months * 25.0;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 20, color: Colors.orange.shade700),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.retroactiveFees,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.retroFeeCalculation(
                            DateFormat('dd.MM.yyyy').format(startDate),
                            DateFormat('dd.MM.yyyy').format(today),
                            months.toString(),
                            retroBeitrag.toStringAsFixed(2),
                          ),
                          style: TextStyle(fontSize: 13, color: Colors.orange.shade800),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ],

            if (canEdit) ...[
              const SizedBox(height: 16),
              _buildSaveButton(onPressed: _saveStufe5Mitgliedschaft),
            ],
          ],
        );
      },
    );
  }

  Widget _buildMitgliedschaftOption({
    required String value,
    required String label,
    required String subtitle,
    required IconData icon,
    required bool canEdit,
    required void Function(void Function()) setLocalState,
  }) {
    final isSelected = _selectedMitgliedschaftsbeginnOption == value;
    return GestureDetector(
      onTap: canEdit
          ? () {
              setState(() => _selectedMitgliedschaftsbeginnOption = value);
              setLocalState(() {});
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4a90d9).withValues(alpha: 0.08) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF4a90d9) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? const Color(0xFF4a90d9) : Colors.grey.shade400,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 18, color: isSelected ? const Color(0xFF4a90d9) : Colors.grey.shade600),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: isSelected ? const Color(0xFF4a90d9) : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _monthsBetween(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + to.month - from.month;
  }

  // ============ STUFE 6/7/8: DOCUMENTS ============

  Widget _buildDocumentStufe(int stufe, bool canEdit) {
    final url = _documentUrls[stufe] ?? '';
    final name = _getStufenNames()[stufe] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stufe == 6
              ? AppLocalizations.of(context)!.pleaseReadSatzung
              : stufe == 7
                  ? AppLocalizations.of(context)!.pleaseReadDatenschutz
                  : AppLocalizations.of(context)!.pleaseReadWiderruf,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              WebViewScreen.openUrl(context, name, url);
            },
            icon: const Icon(Icons.open_in_new),
            label: Text(AppLocalizations.of(context)!.openDocument(name)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        if (canEdit) ...[
          const SizedBox(height: 12),
          CheckboxListTile(
            value: _documentChecked[stufe] ?? false,
            onChanged: (value) => setState(() => _documentChecked[stufe] = value ?? false),
            title: Text(AppLocalizations.of(context)!.acceptDocumentCheckbox),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: const Color(0xFF4a90d9),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: (_documentChecked[stufe] == true && !_isSaving)
                  ? () => _acceptDocument(stufe)
                  : null,
              icon: _isSaving
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.check),
              label: Text(AppLocalizations.of(context)!.accept),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4a90d9),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ] else ...[
          const SizedBox(height: 12),
          // Show acceptance timestamp if available
          Builder(builder: (_) {
            final timestamp = _getTimestampForStufe(stufe);
            if (timestamp != null) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 18, color: Colors.green.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.acceptedAtRegistration,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatTimestamp(timestamp),
                            style: TextStyle(fontSize: 11, color: Colors.green.shade700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.confirmedByBoard,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  // ============ REGISTRATION ACCEPTANCES (STAGES 8-10) ============

  Map<String, String> _getAcceptanceNames() {
    final l = AppLocalizations.of(context)!;
    return {
      'datenschutz': l.docDatenschutz,
      'satzung': l.docSatzung,
      'widerrufsbelehrung': l.docWiderruf,
    };
  }

  static const Map<String, IconData> _acceptanceIcons = {
    'datenschutz': Icons.lock,
    'satzung': Icons.description,
    'widerrufsbelehrung': Icons.gavel,
  };

  Widget _buildRegistrationAcceptanceSection() {
    final keys = ['datenschutz', 'satzung', 'widerrufsbelehrung'];
    final acceptedCount = keys.where((k) => _documentAcceptances[k] != null).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Card(
          color: Colors.green.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.verified_user, color: Colors.green.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.acceptedAtRegCount(acceptedCount),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < keys.length; i++) ...[
          _buildRegistrationAcceptanceCard(keys[i], 8 + i),
          if (i < keys.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _buildRegistrationAcceptanceCard(String key, int stageNumber) {
    final name = _getAcceptanceNames()[key] ?? key;
    final icon = _acceptanceIcons[key] ?? Icons.description;
    final timestamp = _documentAcceptances[key]?.toString();
    final bool accepted = timestamp != null && timestamp.isNotEmpty;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Status icon
            Icon(
              accepted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: accepted ? Colors.green : Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 12),
            // Document icon + name
            Icon(icon, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_stufenCircleForIndex(stageNumber)} $name',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  if (accepted)
                    Text(
                      AppLocalizations.of(context)!.acceptedOn(_formatTimestamp(timestamp)),
                      style: TextStyle(fontSize: 12, color: Colors.green.shade700),
                    )
                  else
                    Text(
                      AppLocalizations.of(context)!.notAccepted,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                ],
              ),
            ),
            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accepted
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.grey.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                accepted ? AppLocalizations.of(context)!.statusAccepted : AppLocalizations.of(context)!.verifyStatus_offen,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: accepted ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _stufenCircleForIndex(int index) {
    const circles = [
      '\u2467', // ⑧
      '\u2468', // ⑨
      '\u2469', // ⑩
    ];
    final i = index - 8;
    return (i >= 0 && i < circles.length) ? circles[i] : '';
  }

  // ============ SHARED WIDGETS ============

  Widget _buildSaveButton({required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isSaving ? null : onPressed,
        icon: _isSaving
            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Icon(Icons.save),
        label: Text(AppLocalizations.of(context)!.save),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4a90d9),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
