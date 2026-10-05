import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import 'kontakt_bestaetigung.dart';
import '../services/api_service.dart';
import '../screens/webview_screen.dart';
import '../utils/error_helpers.dart';
import '../utils/eu_eea_citizenship.dart';
import '../utils/staatsangehoerigkeit_options.dart';
import '../utils/app_theme.dart';
import '../utils/mitglied_felder.dart';

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

  // Stufe 1: Personal data controllers — mirror every column the
  // registration wizard writes via finalize.php so the Verifizierung
  // tab can display and edit every field collected in Stufe 1a–1f
  // (vorname, nachname, geburtsname, geburtsdatum, geburtsort,
  // geschlecht, familienstand, staatsangehoerigkeit, aufenthaltsstatus,
  // muttersprache, address + land, telefon_mobil, email).
  final _vornameController = TextEditingController();
  final _vorname2Controller = TextEditingController();
  final _nachnameController = TextEditingController();
  final _geburtsnameController = TextEditingController();
  final _geburtsortController = TextEditingController();
  final _strasseController = TextEditingController();
  final _hausnummerController = TextEditingController();
  final _plzController = TextEditingController();
  final _ortController = TextEditingController();
  final _landController = TextEditingController();
  final _telefonMobilController = TextEditingController();

  /// Festnetznummer.
  ///
  /// ⚠️ Getrennt von der Mobilnummer, weil nur an eine Mobilnummer eine SMS
  /// geht: Terminerinnerung, Medikamentenerinnerung und der
  /// Bestätigungscode laufen alle über SMS. Steht dort ein
  /// Festnetzanschluss, kommt nichts an und niemand erfährt warum.
  final _telefonFixController = TextEditingController();
  final _emailController = TextEditingController();
  final _staatsangehoerigkeitController = TextEditingController();
  final _mutterspracheController = TextEditingController();

  /// Auswahlliste vom Server. Bleibt sie leer (kein Netz, alter Server), fällt
  /// das Feld auf Freitext zurück — die Verifizierung darf nicht daran
  /// scheitern, dass eine Liste nicht geladen werden konnte.
  List<Map<String, dynamic>> _staatsangehoerigkeitenListe = [];
  DateTime? _selectedGeburtsdatum;
  String? _selectedGeschlecht;
  String? _selectedFamilienstand;
  String? _selectedAufenthaltsstatus;

  /// Was gespeichert war. ⚠️ Ein Familienstand außerhalb der Liste
  /// ('unbekannt' setzt nur der Vorstand) und ein Aufenthalts-Etikett, das
  /// keinem Schlüssel entspricht, gehen UNBERÜHRT so zurück, wie sie kamen —
  /// sonst ersetzte jedes Speichern der Anschrift die genaue Angabe des
  /// Vorstands durch „Sonstiges".
  String _familienstandGespeichert = '';
  String _aufenthaltGespeichert = '';
  bool _aufenthaltAngefasst = false;

  // Stufe 2: Mitgliedsart
  String? _selectedMitgliedsart;

  // Stufe 3: Finanzielle Situation
  String? _selectedFinanzielleSituation;

  /// Noch nicht 18 (aus dem Geburtsdatum) — Stufe 3 ohne Auswahl, beitragsfrei.
  bool _istMinderjaehrig = false;

  // Stufe 4: Zahlungsmethode + Zahlungstag
  String? _selectedZahlungsmethode;
  int? _selectedZahlungstag;

  // Stufe 5: Mitgliedschaftsbeginn
  String? _selectedMitgliedschaftsbeginnOption;
  DateTime? _selectedMitgliedschaftsbeginnDatum;

  // Stufe 6-8: Document acceptance
  final Map<int, bool> _documentChecked = {6: false, 7: false, 8: false};

  bool _isSaving = false;

  /// Nur was das Mitglied selbst wählen kann — die Ehrenmitgliedschaft
  /// verleiht die Mitgliederversammlung (Satzung § 6 Abs. 1b).
  Map<String, String> _getMitgliedsartLabels() {
    final l = AppLocalizations.of(context)!;
    return {
      for (final m in mitgliedsartWaehlbar) m: mitgliedsartAnzeige(m, l),
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

  /// SEPA-Lastschrift braucht ein unterschriebenes Mandat — die trägt der
  /// Vorstand ein, gewählt wird sie hier nicht.
  Map<String, String> _getZahlungsmethodeLabels() {
    final l = AppLocalizations.of(context)!;
    return {
      for (final z in zahlungsmethodeWaehlbar) z: zahlungsmethodeAnzeige(z, l),
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
    _staatsangehoerigkeitController.addListener(_onCitizenshipChanged);
    _loadVerifizierung();
    _loadStaatsangehoerigkeiten();
  }

  Future<void> _loadStaatsangehoerigkeiten() async {
    final liste = await _apiService.getStaatsangehoerigkeiten();
    if (!mounted || liste.isEmpty) return;
    setState(() {
      _staatsangehoerigkeitenListe = liste;
      // Früher war das Feld Freitext. „Rumanisch" ohne Umlaut ist dieselbe
      // Staatsangehörigkeit wie „rumänisch" — ohne diesen Abgleich fände das
      // Dropdown den gespeicherten Wert nicht wieder.
      final angepasst = staatsangehoerigkeitNormalisieren(
          _staatsangehoerigkeitController.text, liste);
      if (angepasst != _staatsangehoerigkeitController.text) {
        _staatsangehoerigkeitController.text = angepasst;
      }
    });
  }

  @override
  void dispose() {
    _staatsangehoerigkeitController.removeListener(_onCitizenshipChanged);
    _vornameController.dispose();
    _nachnameController.dispose();
    _geburtsnameController.dispose();
    _geburtsortController.dispose();
    _strasseController.dispose();
    _hausnummerController.dispose();
    _plzController.dispose();
    _ortController.dispose();
    _landController.dispose();
    _vorname2Controller.dispose();
    _telefonMobilController.dispose();
    _telefonFixController.dispose();
    _emailController.dispose();
    _staatsangehoerigkeitController.dispose();
    _mutterspracheController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // Aufenthaltsstatus conditional logic — mirrors wizard Stufe 1d so the
  // member's Verifizierung view shows the same buckets the visitor saw at
  // registration: German citizen → "kein Titel erforderlich", EU/EEA/CH →
  // Freizügigkeit fixed, third-country → dropdown of German residence
  // titles (Aufenthaltserlaubnis, Niederlassung, GFK refugee, etc.).
  // --------------------------------------------------------------------------


  /// Beibehaltene String-Werte, damit die Aufrufstellen unverändert bleiben;
  /// die Einstufung selbst kommt aus dem gemeinsamen Util.
  String get _citizenshipBucket => switch (citizenshipBucket(
        _staatsangehoerigkeitController.text,
      )) {
        CitizenshipBucket.none => 'none',
        CitizenshipBucket.german => 'german',
        CitizenshipBucket.euEea => 'eu_eea',
        CitizenshipBucket.thirdCountry => 'third',
      };

  void _onCitizenshipChanged() {
    if (!mounted) return;
    final bucket = _citizenshipBucket;
    setState(() {
      // Neue Staatsangehörigkeit = neuer Status; das alte Etikett gilt nicht mehr.
      _aufenthaltAngefasst = true;
      if (bucket == 'german') {
        if (_selectedAufenthaltsstatus != 'doppelt_de') {
          _selectedAufenthaltsstatus = 'deutsch';
        }
      } else if (bucket == 'eu_eea') {
        _selectedAufenthaltsstatus = 'eu_eea_freizuegigkeit';
      } else if (bucket == 'third' &&
          (_selectedAufenthaltsstatus == 'deutsch' ||
              _selectedAufenthaltsstatus == 'doppelt_de' ||
              _selectedAufenthaltsstatus == 'eu_eea_freizuegigkeit')) {
        _selectedAufenthaltsstatus = null;
      }
    });
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
        _error = getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'VERIFY');
        _isLoading = false;
      });
    }
  }

  void _populateFormFields() {
    _vornameController.text = _personalData['vorname'] ?? '';
    _vorname2Controller.text = _personalData['vorname2'] ?? '';
    _nachnameController.text = _personalData['nachname'] ?? '';
    _geburtsnameController.text = _personalData['geburtsname'] ?? '';
    _geburtsortController.text = _personalData['geburtsort'] ?? '';
    _strasseController.text = _personalData['strasse'] ?? '';
    _hausnummerController.text = _personalData['hausnummer'] ?? '';
    _plzController.text = _personalData['plz'] ?? '';
    _ortController.text = _personalData['ort'] ?? '';
    _landController.text = _personalData['land'] ?? '';
    _telefonMobilController.text = _personalData['telefon_mobil'] ?? '';
    _telefonFixController.text = _personalData['telefon_fix'] ?? '';
    _emailController.text = _personalData['email'] ?? '';
    // Setting the citizenship controller below triggers _onCitizenshipChanged
    // which would clobber the loaded aufenthaltsstatus. Suppress by
    // removing the listener for the load, then re-attaching.
    _staatsangehoerigkeitController
        .removeListener(_onCitizenshipChanged);
    _staatsangehoerigkeitController.text =
        _personalData['staatsangehoerigkeit'] ?? '';
    _staatsangehoerigkeitController.addListener(_onCitizenshipChanged);
    _mutterspracheController.text = _personalData['muttersprache'] ?? '';

    final gd = _personalData['geburtsdatum'];
    _selectedGeburtsdatum = gd != null ? DateTime.tryParse(gd.toString()) : null;

    // Altwerte ('maennlich' …) werden zum Code, wie überall sonst.
    _selectedGeschlecht =
        geschlechtCode(_personalData['geschlecht']?.toString());

    _familienstandGespeichert =
        _personalData['familienstand']?.toString().trim() ?? '';
    _selectedFamilienstand =
        familienstandWerte.contains(_familienstandGespeichert)
            ? _familienstandGespeichert
            : null;

    // Aufenthaltsstatus: der Server speichert das deutsche Etikett; ein
    // bekanntes wird wieder zum Schlüssel, ein fremdes bleibt gespeichert
    // und erscheint als „Sonstiges".
    _aufenthaltGespeichert =
        _personalData['aufenthaltsstatus']?.toString().trim() ?? '';
    _aufenthaltAngefasst = false;
    _selectedAufenthaltsstatus = aufenthaltSchluessel(_aufenthaltGespeichert) ??
        (_aufenthaltGespeichert.isNotEmpty ? 'sonstige' : null);

    final ma = _personalData['mitgliedsart']?.toString() ?? '';
    _selectedMitgliedsart = mitgliedsartWaehlbar.contains(ma) ? ma : null;

    // Unter 18: keine Auswahl, beitragsfrei ('minderjaehrig'). Sonst nur ein
    // wählbarer Wert — ein gespeichertes 'minderjaehrig' eines inzwischen
    // Volljährigen muss neu gewählt werden.
    _istMinderjaehrig =
        istMinderjaehrigAm(_personalData['geburtsdatum']?.toString());
    final fs = _personalData['finanzielle_situation']?.toString() ?? '';
    _selectedFinanzielleSituation = _istMinderjaehrig
        ? finanzielleSituationMinderjaehrig
        : (finanzielleSituationWerte.contains(fs) ? fs : null);

    final zm = _personalData['zahlungsmethode'] ?? '';
    _selectedZahlungsmethode =
        zahlungsmethodeWaehlbar.contains(zm) ? zm.toString() : null;

    final zt = _personalData['zahlungstag'];
    final tag = zt != null ? int.tryParse(zt.toString()) : null;
    // 1–28: einen 29.–31. gibt es nicht in jedem Monat.
    _selectedZahlungstag =
        (tag != null && tag >= 1 && tag <= zahlungstagMax) ? tag : null;

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
        return context.colors.successFg;
      case 'ausgefuellt':
        return context.colors.infoFg;
      case 'abgelehnt':
        return context.colors.dangerFg;
      default:
        return context.colors.textSecondary;
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

  /// Stufe 4 entfällt bei beantragter Ermäßigung (nur mit Nachweis, der
  /// Vorstand entscheidet) und unter 18 (beitragsfrei).
  bool _isStufe4Skipped() =>
      _istMinderjaehrig || zahlungswegEntfaellt(_selectedFinanzielleSituation);

  /// Der Aufenthaltsstatus, der gespeichert wird.
  String? _aufenthaltZumSenden() {
    // Unberührt → genau das zurück, was kam (auch ein Etikett des Vorstands).
    if (!_aufenthaltAngefasst && _aufenthaltGespeichert.isNotEmpty) {
      return _aufenthaltGespeichert;
    }
    return switch (_citizenshipBucket) {
      'german' => aufenthaltDeutsch.contains(_selectedAufenthaltsstatus)
          ? _selectedAufenthaltsstatus
          : 'deutsch',
      'eu_eea' => 'eu_eea_freizuegigkeit',
      _ => _selectedAufenthaltsstatus,
    };
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
        _telefonMobilController.text.trim().isEmpty ||
        _staatsangehoerigkeitController.text.trim().isEmpty ||
        _mutterspracheController.text.trim().isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.fillRequiredFields, isError: true);
      return;
    }
    // Third-country citizens must explicitly pick an Aufenthaltstitel
    // before save — the dropdown is shown but a fresh load leaves it
    // null until the visitor confirms.
    if (_citizenshipBucket == 'third' &&
        (_aufenthaltZumSenden() ?? '').isEmpty) {
      _showSnackBar(
        AppLocalizations.of(context)!.wizardStufe1dAufenthaltRequired,
        isError: true,
      );
      return;
    }

    // Festnetz: freiwillig, aber wenn ausgefüllt mit Ländervorwahl — dieselbe
    // Regel wie beim Server, im Online-Formular und im Assistenten.
    final festnetzRoh = _telefonFixController.text.trim();
    String festnetz = '';
    if (festnetzRoh.isNotEmpty) {
      final p = telefonPruefen(festnetzRoh);
      final meldung = telefonMeldung(p, AppLocalizations.of(context)!);
      if (meldung != null) {
        _showSnackBar(meldung, isError: true);
        return;
      }
      festnetz = p.nummer!;
    }

    setState(() => _isSaving = true);
    try {
      final result = await _apiService.updatePersonalData(
        vorname: _vornameController.text.trim(),
        vorname2: _vorname2Controller.text.trim(),
        nachname: _nachnameController.text.trim(),
        geburtsname: _geburtsnameController.text.trim(),
        strasse: _strasseController.text.trim(),
        hausnummer: _hausnummerController.text.trim(),
        plz: _plzController.text.trim(),
        ort: _ortController.text.trim(),
        land: _landController.text.trim(),
        telefonMobil: _telefonMobilController.text.trim(),
        telefonFix: festnetz,
        email: _emailController.text.trim(),
        geburtsdatum: DateFormat('yyyy-MM-dd').format(_selectedGeburtsdatum!),
        geburtsort: _geburtsortController.text.trim(),
        geschlecht: _selectedGeschlecht,
        familienstand: _selectedFamilienstand,
        staatsangehoerigkeit: _staatsangehoerigkeitController.text.trim(),
        aufenthaltsstatus: _aufenthaltZumSenden(),
        muttersprache: _mutterspracheController.text.trim(),
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
      _showSnackBar(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'VERIFY'), isError: true);
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
      // ⚠️ NUR die Mitgliedsart. Vorher ging hier updatePersonalData() mit
      // leerer Mobilnummer hinaus — der Server las das als Änderungswunsch
      // und antwortete „Die Mobilnummer kann hier nicht geaendert werden"
      // (gemeldet 05.10.2026), und Festnetz, zweiter Vorname, Bundesland
      // und Land wären geleert worden.
      final result = await _apiService.updateMitgliedsart(_selectedMitgliedsart!);
      if (!mounted) return;
      if (result['success'] == true) {
        _showSnackBar(AppLocalizations.of(context)!.memberTypeSaved);
        _loadVerifizierung();
      } else {
        _showSnackBar(result['message'] ?? AppLocalizations.of(context)!.notifError, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'VERIFY'), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _saveStufe3Finanziell() async {
    if (_istMinderjaehrig ||
        !finanzielleSituationWerte.contains(_selectedFinanzielleSituation)) {
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
      _showSnackBar(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'VERIFY'), isError: true);
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
      _showSnackBar(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'VERIFY'), isError: true);
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
      _showSnackBar(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'VERIFY'), isError: true);
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
      _showSnackBar(getUserFriendlyError(AppLocalizations.of(context)!, e, tag: 'VERIFY'), isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? context.colors.dangerFg : context.colors.successFg,
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
            Icon(Icons.error_outline, size: 48, color: context.colors.dangerFg),
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
      color: context.colors.infoBg,
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
                    color: totalCompleted == totalStages ? context.colors.successFg : context.colors.infoFg,
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
                backgroundColor: context.colors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(
                  totalCompleted == totalStages ? context.colors.successFg : context.colors.infoFg,
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
        color: context.colors.cardSubtle,
        child: ListTile(
          leading: Icon(Icons.block, color: context.colors.textDisabled),
          title: Row(
            children: [
              Icon(_stufenIcons[stufe] ?? Icons.circle, size: 18, color: context.colors.textDisabled),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${_stufenCircle(stufe)} ${_getStufenNames()[stufe]}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: context.colors.textTertiary),
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: context.colors.warningFg),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              AppLocalizations.of(context)!.socialBenefitsExempt,
              style: TextStyle(fontSize: 11, color: context.colors.textTertiary, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      );
    }

    // Locked stufe (previous not completed) - grey card with lock icon
    if (!isUnlocked) {
      return Card(
        clipBehavior: Clip.antiAlias,
        color: context.colors.cardSubtle,
        child: ListTile(
          leading: Icon(Icons.lock, color: context.colors.textDisabled),
          title: Row(
            children: [
              Icon(_stufenIcons[stufe] ?? Icons.circle, size: 18, color: context.colors.textDisabled),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${_stufenCircle(stufe)} ${_getStufenNames()[stufe]}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: context.colors.textTertiary),
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: context.colors.textTertiary),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              AppLocalizations.of(context)!.completePreviousStep(
                stufe == 5 && _isStufe4Skipped() ? 3 : stufe - 1,
              ),
              style: TextStyle(fontSize: 11, color: context.colors.textTertiary, fontStyle: FontStyle.italic),
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
            Icon(_stufenIcons[stufe] ?? Icons.circle, size: 18, color: context.colors.textSecondary),
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
              color: context.colors.dangerFg,
            ),
          if (status == 'ausgefuellt')
            _buildStatusBanner(
              icon: Icons.hourglass_top,
              text: AppLocalizations.of(context)!.waitingForReview,
              color: context.colors.infoFg,
            ),
          if (status == 'geprueft')
            _buildStatusBanner(
              icon: Icons.check_circle,
              text: AppLocalizations.of(context)!.stepApproved,
              color: context.colors.successFg,
            ),
          if (status == 'geprueft')
            _buildStatusBanner(
              icon: Icons.chat,
              text: AppLocalizations.of(context)!.changesViaChat,
              color: context.colors.warningFg,
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
        // ⚠️ Ganz oben, vor allen Feldern: wenn eine Bestätigung fällig ist,
        // ist sie das Wichtigste auf diesem Bildschirm. Weiter unten würde sie
        // niemand sehen — Stufe 1 ist lang, und wer hier ist, will meist etwas
        // anderes erledigen.
        //
        // Zeigt sich selbst nur, wenn wirklich etwas fällig ist
        // (nurWennFaellig), und verschwindet nach der Bestätigung von allein.
        KontaktBestaetigung(
          apiService: _apiService,
          onBestaetigt: _loadVerifizierung,
        ),
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
        // Zweiter Vorname — wie im Online-Formular und in der Verifizierung
        // des Vorstandspanels.
        _buildTextField(
          controller: _vorname2Controller,
          label: AppLocalizations.of(context)!.wizardStufe1aVorname2Label,
          enabled: canEdit,
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
                fillColor: canEdit ? context.colors.inputFill : context.colors.cardSubtle,
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
        // Land
        _buildTextField(
          controller: _landController,
          label: AppLocalizations.of(context)!.wizardStufe1eLandLabel,
          enabled: canEdit,
        ),
        const SizedBox(height: 12),
        // Telefonnummer + Email
        // ⚠️ „Mobilfunknummer", nicht mehr „Telefonnummer": darunter steht
        // jetzt ein zweites Feld, und zwei Zeilen, von denen eine „Telefon"
        // heißt, sagen nicht, welche gemeint ist.
        _buildTextField(
          controller: _telefonMobilController,
          label: '${AppLocalizations.of(context)!.phoneMobileLabel} *',
          enabled: canEdit,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            AppLocalizations.of(context)!.phonePurpose,
            style: TextStyle(fontSize: 11, color: context.colors.textTertiary, fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _telefonFixController,
          label: AppLocalizations.of(context)!.phoneLandlineLabel,
          enabled: canEdit,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _emailController,
          label: AppLocalizations.of(context)!.email,
          enabled: canEdit,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        _buildVereinsMailZeile(),
        const SizedBox(height: 20),
        // Geburt section: Geburtsname + Geburtsort
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _geburtsnameController,
                label: AppLocalizations.of(context)!.wizardStufe1aGeburtsnameLabel,
                enabled: canEdit,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _geburtsortController,
                label: AppLocalizations.of(context)!.wizardStufe1bGeburtsortLabel,
                enabled: canEdit,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Geschlecht + Familienstand (dropdowns)
        Row(
          children: [
            Expanded(child: _buildGeschlechtDropdown(canEdit)),
            const SizedBox(width: 12),
            Expanded(child: _buildFamilienstandDropdown(canEdit)),
          ],
        ),
        const SizedBox(height: 20),
        // Staatsangehörigkeit + Muttersprache + conditional Aufenthaltsstatus
        Row(
          children: [
            Expanded(child: _buildStaatsangehoerigkeitFeld(canEdit)),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _mutterspracheController,
                label: AppLocalizations.of(context)!.wizardStufe1dMutterspracheLabel,
                enabled: canEdit,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildAufenthaltsstatusField(canEdit),
        if (canEdit) ...[
          const SizedBox(height: 16),
          _buildSaveButton(onPressed: _saveStufe1),
        ],
      ],
    );
  }

  Widget _buildGeschlechtDropdown(bool canEdit) {
    final l = AppLocalizations.of(context)!;
    final labels = {for (final g in geschlechtWerte) g: geschlechtAnzeige(g, l)};
    return DropdownButtonFormField<String>(
      initialValue: _selectedGeschlecht,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: l.wizardStufe1cGeschlechtLabel,
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: canEdit ? context.colors.inputFill : context.colors.cardSubtle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      items: labels.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: canEdit ? (v) => setState(() => _selectedGeschlecht = v) : null,
    );
  }

  Widget _buildFamilienstandDropdown(bool canEdit) {
    final l = AppLocalizations.of(context)!;
    final labels = {
      for (final f in familienstandWerte) f: familienstandAnzeige(f, l),
    };
    // 'unbekannt' (setzt nur der Vorstand) steht nicht in der Liste — als
    // Hinweis zeigen und unberührt lassen.
    final fremd = _selectedFamilienstand == null &&
        _familienstandGespeichert.isNotEmpty;
    return DropdownButtonFormField<String>(
      initialValue: _selectedFamilienstand,
      isExpanded: true,
      hint: fremd ? Text(familienstandAnzeige(_familienstandGespeichert, l)) : null,
      decoration: InputDecoration(
        labelText: l.wizardStufe1cFamilienstandLabel,
        prefixIcon: const Icon(Icons.favorite_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: canEdit ? context.colors.inputFill : context.colors.cardSubtle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      items: labels.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: canEdit ? (v) => setState(() => _selectedFamilienstand = v) : null,
    );
  }

  /// Verifizierung-flavoured counterpart of the wizard's Stufe 1d
  /// Aufenthaltsstatus field — same buckets (German / EU-EEA-CH /
  /// third-country) but rendered on a white surface to match the rest
  /// of the verifizierung tab.
  Widget _buildAufenthaltsstatusField(bool canEdit) {
    final l = AppLocalizations.of(context)!;
    final bucket = _citizenshipBucket;
    if (bucket == 'german') {
      // Deutsch oder doppelte Staatsbürgerschaft — die erste Zeile der Liste
      // im Vorstandspanel.
      return DropdownButtonFormField<String>(
        initialValue: aufenthaltDeutsch.contains(_selectedAufenthaltsstatus)
            ? _selectedAufenthaltsstatus
            : 'deutsch',
        isExpanded: true,
        decoration: InputDecoration(
          labelText: l.wizardStufe1dAufenthaltLabel,
          prefixIcon: const Icon(Icons.verified_user_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: canEdit ? context.colors.inputFill : context.colors.cardSubtle,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        items: [
          for (final v in aufenthaltDeutsch)
            DropdownMenuItem<String>(
              value: v,
              child: Text(aufenthaltAnzeige(v, l), overflow: TextOverflow.ellipsis),
            ),
        ],
        onChanged: canEdit
            ? (v) => setState(() {
                  _aufenthaltAngefasst = true;
                  _selectedAufenthaltsstatus = v;
                })
            : null,
      );
    }
    if (bucket == 'eu_eea') {
      return _aufenthaltsstatusBadge(
        l.wizardStufe1dAufenthaltEuEea,
        Icons.public_outlined,
      );
    }
    if (bucket == 'none') {
      return _aufenthaltsstatusBadge(
        l.wizardStufe1dAufenthaltAwaitingCitizenship,
        Icons.info_outline,
        dim: true,
      );
    }
    final optionen =
        aufenthaltDrittstaatFuer(_staatsangehoerigkeitController.text);
    // Ein Etikett des Vorstands, das keinem Schlüssel entspricht: als
    // „Sonstiges" gewählt, das genaue Etikett steht darunter.
    final fremdesEtikett = !_aufenthaltAngefasst &&
        _aufenthaltGespeichert.isNotEmpty &&
        aufenthaltSchluessel(_aufenthaltGespeichert) == null;
    return DropdownButtonFormField<String>(
      initialValue: optionen.contains(_selectedAufenthaltsstatus)
          ? _selectedAufenthaltsstatus
          : null,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: l.wizardStufe1dAufenthaltLabel,
        prefixIcon: const Icon(Icons.badge_outlined),
        helperText:
            fremdesEtikett ? _aufenthaltGespeichert : l.wizardStufe1dAufenthaltHelper,
        helperMaxLines: 3,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: canEdit ? context.colors.inputFill : context.colors.cardSubtle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      items: [
        for (final v in optionen)
          DropdownMenuItem<String>(
            value: v,
            child: Text(
              aufenthaltAnzeige(v, l),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: canEdit
          ? (v) => setState(() {
                _aufenthaltAngefasst = true;
                _selectedAufenthaltsstatus = v;
              })
          : null,
    );
  }

  Widget _aufenthaltsstatusBadge(String text, IconData icon,
      {bool dim = false}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: dim ? context.colors.cardSubtle : context.colors.infoBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: dim ? context.colors.divider : context.colors.infoBorder,
        ),
      ),
      child: Row(
        children: [
          Icon(icon,
              color: dim ? context.colors.textSecondary : context.colors.infoFg,
              size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: dim ? context.colors.textPrimary : context.colors.infoFg,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
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
          style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
        ),
        const SizedBox(height: 12),
        // Ehrenmitglied wählt man nicht — ist es gespeichert, steht es hier.
        if ((_personalData['mitgliedsart']?.toString() ?? '').isNotEmpty &&
            !mitgliedsartWaehlbar
                .contains(_personalData['mitgliedsart']?.toString())) ...[
          Text(
            mitgliedsartAnzeige(_personalData['mitgliedsart']?.toString(),
                AppLocalizations.of(context)!),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.colors.infoFg,
            ),
          ),
          const SizedBox(height: 12),
        ],
        for (final entry in _getMitgliedsartLabels().entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: canEdit ? () => setState(() => _selectedMitgliedsart = entry.key) : null,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selectedMitgliedsart == entry.key ? context.colors.infoBg : context.colors.cardSubtle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedMitgliedsart == entry.key ? context.colors.infoBorder : context.colors.dividerSubtle,
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
                          color: _selectedMitgliedsart == entry.key ? context.colors.infoFg : context.colors.textDisabled,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _selectedMitgliedsart == entry.key ? context.colors.infoFg : context.colors.textPrimary,
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
                            color: _selectedMitgliedsart == entry.key ? context.colors.infoFg : context.colors.textSecondary,
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
        // Kein Hochladen: der Nachweis wird gebracht oder geschickt — ohne
        // ihn keine Ermäßigung. Wie im Online-Formular und im Assistenten.
        final nachweis = nachweisFuer(_selectedFinanzielleSituation,
            AppLocalizations.of(context)!);

        if (_istMinderjaehrig) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colors.successBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.successBorder),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 20, color: context.colors.successFg),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.minderjaehrigBeitragsfrei,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: context.colors.successFg,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Explanation text
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.infoBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colors.infoBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 20, color: context.colors.infoFg),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.financialExplanation,
                      style: TextStyle(fontSize: 12, color: context.colors.infoFg),
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
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            for (final wert in finanzielleSituationWerte) ...[
              _buildFinanziellOption(
                value: wert,
                label: finanzielleSituationAnzeige(wert, AppLocalizations.of(context)!),
                icon: switch (wert) {
                  'buergergeld' => Icons.account_balance,
                  'sozialamt' => Icons.health_and_safety,
                  'alg1' => Icons.business_center,
                  'krankengeld' => Icons.medical_services,
                  'rente' => Icons.elderly,
                  'behinderung' => Icons.accessible,
                  _ => Icons.work,
                },
                canEdit: canEdit,
                setLocalState: setLocalState,
              ),
              const SizedBox(height: 8),
            ],
            // Beantragte Ermäßigung: welcher Nachweis gilt — ohne ihn keine
            // Ermäßigung. Keine Zusage, der Vorstand entscheidet.
            if (nachweis != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.infoBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colors.infoBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.fact_check, size: 20, color: context.colors.infoFg),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.ermaessigungBeantragtTitel,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: context.colors.infoFg,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context)!
                                .ermaessigungNurMitNachweisSie(nachweis),
                            style: TextStyle(fontSize: 12, color: context.colors.infoFg),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (_selectedFinanzielleSituation == 'nein') ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.infoBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colors.infoBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.euro, size: 20, color: context.colors.infoFg),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.feeRegular,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: context.colors.infoFg,
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
          color: isSelected ? context.colors.infoBg : context.colors.cardSubtle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? context.colors.infoBorder : context.colors.dividerSubtle,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: isSelected ? context.colors.infoFg : context.colors.textDisabled,
            ),
            const SizedBox(width: 10),
            Icon(icon, size: 18, color: isSelected ? context.colors.infoFg : context.colors.textTertiary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? context.colors.infoFg : context.colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                  color: _selectedZahlungsmethode == entry.key ? context.colors.infoBg : null,
                  child: RadioListTile<String>(
                    title: Text(entry.value),
                    value: entry.key,
                    activeColor: context.colors.brandFill,
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
            fillColor: canEdit ? context.colors.inputFill : context.colors.cardSubtle,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          items: List.generate(zahlungstagMax, (i) => i + 1)
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
                Icon(Icons.info_outline, size: 16, color: context.colors.infoFg),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.paymentDayReminder(_selectedZahlungstag!),
                    style: TextStyle(fontSize: 12, color: context.colors.infoFg),
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
    final unter18 = _istMinderjaehrig ||
        istBeitragsfreiMinderjaehrig(_selectedFinanzielleSituation);
    final ermaessigung =
        istErmaessigungBeantragt(_selectedFinanzielleSituation);

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.membershipStartPrompt,
              style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
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
                    fillColor: canEdit ? context.colors.inputFill : context.colors.cardSubtle,
                    prefixIcon: const Icon(Icons.calendar_today),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  child: Text(
                    _selectedMitgliedschaftsbeginnDatum != null
                        ? DateFormat('dd.MM.yyyy').format(_selectedMitgliedschaftsbeginnDatum!)
                        : AppLocalizations.of(context)!.selectDateHint,
                    style: TextStyle(
                      color: _selectedMitgliedschaftsbeginnDatum != null
                          ? context.colors.textPrimary
                          : context.colors.textTertiary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  AppLocalizations.of(context)!.dateNotBefore,
                  style: TextStyle(fontSize: 11, color: context.colors.textSecondary, fontStyle: FontStyle.italic),
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

                if (unter18 || ermaessigung) {
                  // Unter 18 beitragsfrei, auch rückwirkend. Bei beantragter
                  // Ermäßigung entscheidet der Vorstand — keine Zusage.
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: unter18 ? context.colors.successBg : context.colors.infoBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: unter18 ? context.colors.successBorder : context.colors.infoBorder),
                    ),
                    child: Row(
                      children: [
                        Icon(unter18 ? Icons.check_circle : Icons.fact_check,
                            size: 20,
                            color: unter18 ? context.colors.successFg : context.colors.infoFg),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            unter18
                                ? AppLocalizations.of(context)!.minderjaehrigBeitragsfrei
                                : AppLocalizations.of(context)!.ermaessigungRueckwirkend,
                            style: TextStyle(
                                fontSize: 13,
                                color: unter18 ? context.colors.successFg : context.colors.infoFg),
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
                      color: context.colors.warningBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: context.colors.warningBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 20, color: context.colors.warningFg),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.retroactiveFees,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.warningFg,
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
                          style: TextStyle(fontSize: 13, color: context.colors.warningFg),
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
          color: isSelected ? context.colors.brand.withValues(alpha: 0.08) : context.colors.cardSubtle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? context.colors.brand : context.colors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? context.colors.brand : context.colors.textDisabled,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 18, color: isSelected ? context.colors.brand : context.colors.textSecondary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: isSelected ? context.colors.brand : context.colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: context.colors.textSecondary),
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
          style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
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
            activeColor: context.colors.brandFill,
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
                backgroundColor: context.colors.brandFill,
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
                  color: context.colors.successBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colors.successBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 18, color: context.colors.successFg),
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
                              color: context.colors.successFg,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatTimestamp(timestamp),
                            style: TextStyle(fontSize: 11, color: context.colors.successFg),
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
                color: context.colors.cardSubtle,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: context.colors.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.confirmedByBoard,
                      style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
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
          color: context.colors.successBg,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.verified_user, color: context.colors.successFg, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.acceptedAtRegCount(acceptedCount),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: context.colors.successFg,
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
              color: accepted ? context.colors.successFg : context.colors.textSecondary,
              size: 24,
            ),
            const SizedBox(width: 12),
            // Document icon + name
            Icon(icon, size: 18, color: context.colors.textSecondary),
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
                      style: TextStyle(fontSize: 12, color: context.colors.successFg),
                    )
                  else
                    Text(
                      AppLocalizations.of(context)!.notAccepted,
                      style: TextStyle(fontSize: 12, color: context.colors.textTertiary),
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
                  color: accepted ? context.colors.successFg : context.colors.textSecondary,
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
          backgroundColor: context.colors.brandFill,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  /// Staatsangehörigkeit zum Auswählen statt zum Tippen.
  ///
  /// Der Wert bleibt im `_staatsangehoerigkeitController` — daran hängt
  /// [_onCitizenshipChanged], das aus der Staatsangehörigkeit den
  /// Aufenthaltsstatus ableitet (deutsch / EU-EWR-Freizügigkeit / Drittstaat).
  /// Würde das Dropdown den Wert an einer eigenen Variablen halten, liefe
  /// diese Ableitung stillschweigend ins Leere.
  ///
  /// Ohne geladene Liste bleibt es beim Freitextfeld: lieber tippen als gar
  /// nichts eintragen können.
  Widget _buildStaatsangehoerigkeitFeld(bool canEdit) {
    final label = AppLocalizations.of(context)!.wizardStufe1dStaatLabel;
    if (_staatsangehoerigkeitenListe.isEmpty) {
      return _buildTextField(
        controller: _staatsangehoerigkeitController,
        label: label,
        enabled: canEdit,
      );
    }

    final aktuell = _staatsangehoerigkeitController.text.trim();
    final gruppen = gruppiereStaatsangehoerigkeiten(_staatsangehoerigkeitenListe);
    final eintraege = <DropdownMenuItem<String>>[];
    for (final g in gruppen) {
      eintraege.add(DropdownMenuItem<String>(
        enabled: false,
        child: Text(
          g.kontinent.toUpperCase(),
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: context.colors.textTertiary),
        ),
      ));
      for (final b in g.bezeichnungen) {
        eintraege.add(DropdownMenuItem<String>(value: b, child: Text(b)));
      }
    }
    // Ein gespeicherter Wert, der nicht in der Liste steht, muss trotzdem
    // auswählbar bleiben — sonst wirft das Dropdown und die bereits erfasste
    // Angabe wäre beim nächsten Speichern weg.
    final bekannt = gruppen.expand((g) => g.bezeichnungen).toSet();
    if (aktuell.isNotEmpty && !bekannt.contains(aktuell)) {
      eintraege.add(DropdownMenuItem<String>(value: aktuell, child: Text(aktuell)));
    }

    return DropdownButtonFormField<String>(
      isExpanded: true,
      initialValue: aktuell.isNotEmpty ? aktuell : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: eintraege,
      onChanged: canEdit
          ? (v) => setState(() => _staatsangehoerigkeitController.text = v ?? '')
          : null,
    );
  }

  /// Die Vereinsadresse: `<Mitgliedsnummer>@icd360s.de`.
  ///
  /// ⚠️ Berechnet, nicht gespeichert. Es gibt genau eine Spalte `users.email`,
  /// und dort steht die private Adresse — an die geht die Post. Die
  /// Vereinsadresse folgt zwingend aus der Mitgliedsnummer; sie zusätzlich
  /// abzulegen hieße, zwei Werte gleichzuhalten, die sich nie unterscheiden
  /// dürfen.
  ///
  /// ⚠️ Zeichengleich mit `_stufe1VereinsMailRow()` im Vorsitzer-Panel. Wer
  /// eines von beiden ändert, ändert das andere mit — sonst sieht dasselbe
  /// Mitglied in den zwei Anwendungen zwei verschiedene Adressen, und dann
  /// gibt es keine Möglichkeit mehr zu sagen, welche stimmt.
  ///
  /// ⚠️ Nicht änderbar, und das steht auch dabei. Die Mitgliedsnummer ist der
  /// Schlüssel des Kontos.
  Widget _buildVereinsMailZeile() {
    final nummer = widget.mitgliedernummer.trim();
    if (nummer.isEmpty) return const SizedBox.shrink();
    // ⚠️ Die Mitgliedsnummer behält ihre Großschreibung: M90566@icd360s.de,
    // nicht m90566@. Sie steht so auf dem Mitgliedsausweis, und eine Adresse,
    // die anders aussieht als die Nummer daneben, wirkt wie eine andere
    // Angabe. Nur die Domäne ist klein — die ist ohnehin unveränderlich.
    //
    // Zustellung ist davon unberührt: die Spalten in `mailserver` haben die
    // Kollation utf8mb4_unicode_ci, und am 13.08.2026 mit einer SMTP-Sonde
    // gegenprobiert — Groß- und Kleinschreibung werden gleich angenommen.
    final adresse = '$nummer@icd360s.de';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.colors.cardSubtle,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          Icon(Icons.badge_outlined, size: 18, color: context.colors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.email,
                  style: TextStyle(fontSize: 11, color: context.colors.textSecondary),
                ),
                const SizedBox(height: 2),
                SelectableText(
                  adresse,
                  style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: adresse));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(adresse),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.copy, size: 18),
            color: context.colors.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
        ],
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
        fillColor: enabled ? context.colors.inputFill : context.colors.cardSubtle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
