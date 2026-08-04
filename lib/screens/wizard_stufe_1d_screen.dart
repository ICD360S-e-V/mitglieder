import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../services/language_service.dart';
import '../services/wizard_service.dart';
import '../utils/eu_eea_citizenship.dart';
import '../utils/staatsangehoerigkeit_options.dart';
import '../widgets/wizard_step_shell.dart';

/// Stufe 1d — Staatsangehörigkeit + Aufenthaltsstatus + Muttersprache.
///
/// The Aufenthaltsstatus dropdown derives its option set from the
/// typed Staatsangehörigkeit. German citizens see a fixed read-only
/// "Kein Titel erforderlich" badge; EU/EEA/CH citizens see a fixed
/// "Freizügigkeit"; third-country nationals get the full list of
/// German residence titles (Aufenthaltserlaubnis, Niederlassung, GFK
/// refugee, subsidiary protection, Duldung, etc.) — the Vorstand
/// doesn't need to retype it during verification. Muttersprache
/// defaults to the app language so visitors hit "Next" without typing.
class WizardStufe1dScreen extends StatefulWidget {
  final Map<String, dynamic>? initial;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const WizardStufe1dScreen({
    super.key,
    required this.onNext,
    this.onBack,
    this.initial,
  });

  @override
  State<WizardStufe1dScreen> createState() => _WizardStufe1dScreenState();
}

class _WizardStufe1dScreenState extends State<WizardStufe1dScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _staatsangehoerigkeit;
  late final TextEditingController _muttersprache;
  String? _aufenthaltsstatus;
  bool _saving = false;

  /// Auswahlliste der Staatsangehörigkeiten vom Server. Bleibt sie leer,
  /// zeigt das Feld weiterhin das Freitextfeld — der Wizard darf nicht an
  /// einer Liste hängen bleiben.
  List<Map<String, dynamic>> _staaten = [];

  static final _wordRegex = RegExp(r"^[\p{L}\s\-'.,/()]+$", unicode: true);


  /// Stored as the `aufenthaltsstatus` string in the DB — keep these
  /// snake_case values stable so the Vorstand panel can switch on them.
  static const _residenceTitles = <String>[
    'aufenthaltserlaubnis',
    'niederlassungserlaubnis',
    'daueraufenthalt_eu',
    'blaue_karte_eu',
    'asylberechtigt',
    'fluechtling_gfk',
    'subsidiaerer_schutz',
    'aufenthaltsgestattung',
    'duldung',
    'humanitaer',
    'sonstige',
  ];

  @override
  void initState() {
    super.initState();
    _staatsangehoerigkeit = TextEditingController(
      text: widget.initial?['staatsangehoerigkeit'] ?? 'deutsch',
    );
    // Resume — pick up the previously-saved enum value if it matches one
    // of our keys; otherwise leave null and let the user choose. The
    // resume case for legacy free-text values just shows the dropdown
    // un-selected, which is the most predictable behaviour.
    final saved = widget.initial?['aufenthaltsstatus'] as String?;
    if (saved != null && saved.isNotEmpty) {
      if (saved == 'deutsch' ||
          saved == 'eu_eea_freizuegigkeit' ||
          _residenceTitles.contains(saved)) {
        _aufenthaltsstatus = saved;
      }
    }
    _muttersprache = TextEditingController(
      text: widget.initial?['muttersprache'] ??
          LanguageService.instance.currentCode,
    );
    // Rebuild on citizenship change so the conditional Aufenthaltsstatus
    // UI flips between fixed badge / dropdown immediately.
    _staatsangehoerigkeit.addListener(_onCitizenshipChanged);
    _ladeStaatsangehoerigkeiten();
  }

  Future<void> _ladeStaatsangehoerigkeiten() async {
    final liste = await ApiService().getStaatsangehoerigkeiten();
    if (!mounted || liste.isEmpty) return;
    setState(() {
      _staaten = liste;
      // Der Wizard startet mit „deutsch"; ein aus einer früheren Sitzung
      // übernommener Freitext wird auf die Schreibweise der Liste gebracht,
      // damit das Dropdown ihn auswählt statt ihn unten anzuhängen.
      final angepasst =
          staatsangehoerigkeitNormalisieren(_staatsangehoerigkeit.text, liste);
      if (angepasst != _staatsangehoerigkeit.text) {
        _staatsangehoerigkeit.text = angepasst;
      }
    });
  }

  @override
  void dispose() {
    _staatsangehoerigkeit.removeListener(_onCitizenshipChanged);
    _staatsangehoerigkeit.dispose();
    _muttersprache.dispose();
    super.dispose();
  }

  void _onCitizenshipChanged() {
    if (!mounted) return;
    setState(() {
      // Clear stale dropdown selection when bucket changes.
      final bucket = _bucket;
      if (bucket == CitizenshipBucket.german) {
        _aufenthaltsstatus = 'deutsch';
      } else if (bucket == CitizenshipBucket.euEea) {
        _aufenthaltsstatus = 'eu_eea_freizuegigkeit';
      } else if (bucket == CitizenshipBucket.thirdCountry &&
          (_aufenthaltsstatus == 'deutsch' ||
              _aufenthaltsstatus == 'eu_eea_freizuegigkeit')) {
        // Was auto-filled for previous bucket; reset so the visitor
        // actually picks a residence title for the new third-country
        // citizenship instead of keeping the stale value.
        _aufenthaltsstatus = null;
      }
    });
  }

  CitizenshipBucket get _bucket => citizenshipBucket(_staatsangehoerigkeit.text);

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    // Third-country citizens must pick a residence title.
    if (_bucket == CitizenshipBucket.thirdCountry &&
        (_aufenthaltsstatus == null || _aufenthaltsstatus!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardStufe1dAufenthaltRequired),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _saving = true);
    final ok = await WizardService().saveStep(WizardStep.stufe1d, {
      'staatsangehoerigkeit': _staatsangehoerigkeit.text.trim(),
      'aufenthaltsstatus': _aufenthaltsstatus ?? '',
      'muttersprache': _muttersprache.text.trim(),
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.wizardErrSaveFailed),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WizardStepShell(
      stepLabel: l10n.wizardStepLabel(1, 8, l10n.wizardStufe1dTitle),
      prompt: l10n.wizardStufe1dPrompt,
      onBack: widget.onBack,
      onNext: _submit,
      saving: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _staatsangehoerigkeitField(l10n),
            const SizedBox(height: 14),
            _aufenthaltsstatusField(l10n),
            const SizedBox(height: 14),
            TextFormField(
              controller: _muttersprache,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              maxLength: 50,
              textCapitalization: TextCapitalization.words,
              decoration: _input(
                label: l10n.wizardStufe1dMutterspracheLabel,
                helper: l10n.wizardStufe1dMutterspracheHelper,
                prefixIcon: Icons.translate,
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return l10n.wizardErrRequired;
                if (v.length < 2) return l10n.wizardErrTooShort(2);
                if (!_wordRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Three variants depending on the typed citizenship:
  ///   • German citizen → fixed badge, no input needed.
  ///   • EU/EEA/CH      → fixed Freizügigkeit badge.
  ///   • Third-country  → dropdown of standard German residence titles.
  ///   • Empty          → neutral hint prompting the visitor to fill
  ///                      citizenship first.
  Widget _aufenthaltsstatusField(AppLocalizations l10n) {
    final bucket = _bucket;
    return switch (bucket) {
      CitizenshipBucket.none =>
        _statusBadge(l10n.wizardStufe1dAufenthaltAwaitingCitizenship,
            icon: Icons.info_outline, dim: true),
      CitizenshipBucket.german =>
        _statusBadge(l10n.wizardStufe1dAufenthaltGerman,
            icon: Icons.verified_user_outlined),
      CitizenshipBucket.euEea =>
        _statusBadge(l10n.wizardStufe1dAufenthaltEuEea,
            icon: Icons.public_outlined),
      CitizenshipBucket.thirdCountry => _residenceDropdown(l10n),
    };
  }

  /// Compact read-only chip used for the German + EU/EEA + empty cases.
  /// Mirrors the styled fillColor of the input fields so the form reads
  /// as one continuous surface.
  Widget _statusBadge(String text,
      {required IconData icon, bool dim = false}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: dim ? 0.06 : 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: dim ? 0.2 : 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: dim ? 0.7 : 0.95),
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

  /// Staatsangehörigkeit zum Auswählen. Die Liste kommt vom Server
  /// (Destatis-Verzeichnis), gruppiert nach Erdteil.
  ///
  /// Der Wert bleibt im `_staatsangehoerigkeit`-Controller: daran hängt
  /// [_onCitizenshipChanged], das daraus den Aufenthaltsstatus ableitet.
  ///
  /// Ist die Liste nicht da — kein Netz, oder der Wizard läuft, bevor ein
  /// Token existiert —, bleibt es beim Freitextfeld von vorher. Lieber tippen
  /// als an dieser Stelle nicht weiterzukommen.
  Widget _staatsangehoerigkeitField(AppLocalizations l10n) {
    if (_staaten.isEmpty) {
      return TextFormField(
        controller: _staatsangehoerigkeit,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        maxLength: 100,
        textCapitalization: TextCapitalization.sentences,
        decoration: _input(
          label: l10n.wizardStufe1dStaatLabel,
          helper: l10n.wizardStufe1dStaatHelper,
          prefixIcon: Icons.flag_outlined,
        ),
        validator: (value) {
          final v = (value ?? '').trim();
          if (v.isEmpty) return l10n.wizardErrRequired;
          if (v.length < 2) return l10n.wizardErrTooShort(2);
          if (!_wordRegex.hasMatch(v)) return l10n.wizardErrOnlyLetters;
          return null;
        },
      );
    }

    final aktuell = _staatsangehoerigkeit.text.trim();
    final gruppen = gruppiereStaatsangehoerigkeiten(_staaten);
    final eintraege = <DropdownMenuItem<String>>[];
    for (final g in gruppen) {
      eintraege.add(DropdownMenuItem<String>(
        enabled: false,
        child: Text(
          g.kontinent.toUpperCase(),
          style: const TextStyle(
              color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ));
      for (final b in g.bezeichnungen) {
        eintraege.add(DropdownMenuItem<String>(
          value: b,
          child: Text(b,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis),
        ));
      }
    }
    final bekannt = gruppen.expand((g) => g.bezeichnungen).toSet();
    if (aktuell.isNotEmpty && !bekannt.contains(aktuell)) {
      eintraege.add(DropdownMenuItem<String>(
        value: aktuell,
        child: Text(aktuell,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis),
      ));
    }

    return DropdownButtonFormField<String>(
      initialValue: aktuell.isNotEmpty ? aktuell : null,
      isExpanded: true,
      dropdownColor: const Color(0xFF1565c0),
      iconEnabledColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: _input(
        label: l10n.wizardStufe1dStaatLabel,
        helper: l10n.wizardStufe1dStaatHelper,
        prefixIcon: Icons.flag_outlined,
      ),
      items: eintraege,
      onChanged: (v) => setState(() => _staatsangehoerigkeit.text = v ?? ''),
      validator: (v) => (v ?? '').trim().isEmpty ? l10n.wizardErrRequired : null,
    );
  }

  Widget _residenceDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<String>(
      initialValue: _aufenthaltsstatus,
      isExpanded: true,
      dropdownColor: const Color(0xFF1565c0),
      iconEnabledColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: _input(
        label: l10n.wizardStufe1dAufenthaltLabel,
        helper: l10n.wizardStufe1dAufenthaltHelper,
        prefixIcon: Icons.badge_outlined,
      ),
      items: [
        for (final v in _residenceTitles)
          DropdownMenuItem<String>(
            value: v,
            child: Text(
              _residenceTitleLabel(v, l10n),
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: (v) => setState(() => _aufenthaltsstatus = v),
      validator: (v) =>
          (v == null || v.isEmpty) ? l10n.wizardErrRequired : null,
    );
  }

  /// German legal residence-title labels with localized helper text in
  /// parentheses where the term isn't self-explanatory in the visitor's
  /// language. Legal terms (Aufenthaltserlaubnis, Niederlassungserlaubnis,
  /// GFK, etc.) stay in German since they reference §§ AufenthG/AsylG.
  String _residenceTitleLabel(String key, AppLocalizations l10n) =>
      switch (key) {
        'aufenthaltserlaubnis' =>
          'Aufenthaltserlaubnis (${l10n.wizardStufe1dAufenthaltTempHint})',
        'niederlassungserlaubnis' =>
          'Niederlassungserlaubnis (${l10n.wizardStufe1dAufenthaltPermHint})',
        'daueraufenthalt_eu' => 'Daueraufenthalt-EU',
        'blaue_karte_eu' => 'Blaue Karte EU',
        'asylberechtigt' =>
          'Asylberechtigt (Art. 16a GG)',
        'fluechtling_gfk' =>
          'Anerkannter Flüchtling (GFK § 25 Abs. 2)',
        'subsidiaerer_schutz' => 'Subsidiärer Schutz (§ 25 Abs. 2 Satz 1 Alt. 2)',
        'aufenthaltsgestattung' =>
          'Aufenthaltsgestattung (${l10n.wizardStufe1dAufenthaltAsylumProcessHint})',
        'duldung' => 'Duldung (§ 60a)',
        'humanitaer' =>
          'Humanitärer Aufenthalt (§ 25 Abs. 4/5)',
        'sonstige' => l10n.wizardStufe1dAufenthaltOther,
        _ => key,
      };

  InputDecoration _input({
    required String label,
    required String helper,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
      helperText: helper,
      helperMaxLines: 3,
      helperStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 11.5,
      ),
      counterStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.white.withValues(alpha: 0.7))
          : null,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      errorStyle: TextStyle(color: Colors.red.shade200),
    );
  }
}
