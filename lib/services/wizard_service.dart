import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'device_key_service.dart';
import 'http_client_factory.dart';
import 'logger_service.dart';

/// Verdict returned by `/api/public/wizard/check_age.php`. Source of
/// truth for the Satzung §6 / BGB §106 gating — the client mirrors the
/// logic for snappy UX but the server has the final say at
/// finalize-time.
enum WizardAgeStatus { ok, minor, tooYoung }

/// Mirror of the wizard step labels accepted by save_step.php.
/// Order matches the natural flow but the wizard widget enforces
/// step-by-step traversal, not this enum's index.
enum WizardStep {
  intro,
  introDone,
  stufe1a,
  stufe1b,
  stufe1b1,           // minor → parent hint capture
  stufe1c,
  stufe1d,
  stufe1e,
  stufe1f,
  stufe2,
  stufe3,
  stufe3Upload,       // conditional: bürgergeld/sozialamt only
  stufe4,
  stufe5,
  stufe6,             // Satzung
  stufe7,             // Datenschutz
  stufe8,             // Widerrufsbelehrung
  done,
}

/// Maps the enum to the string the server expects.
String wizardStepName(WizardStep s) => switch (s) {
      WizardStep.intro       => 'intro',
      WizardStep.introDone   => 'intro_done',
      WizardStep.stufe1a     => '1a',
      WizardStep.stufe1b     => '1b',
      WizardStep.stufe1b1    => '1b1',
      WizardStep.stufe1c     => '1c',
      WizardStep.stufe1d     => '1d',
      WizardStep.stufe1e     => '1e',
      WizardStep.stufe1f     => '1f',
      WizardStep.stufe2      => '2',
      WizardStep.stufe3      => '3',
      WizardStep.stufe3Upload=> '3_upload',
      WizardStep.stufe4      => '4',
      WizardStep.stufe5      => '5',
      WizardStep.stufe6      => '6',
      WizardStep.stufe7      => '7',
      WizardStep.stufe8      => '8',
      WizardStep.done        => 'done',
    };

WizardStep wizardStepFromName(String s) => switch (s) {
      'intro'      => WizardStep.intro,
      'intro_done' => WizardStep.introDone,
      '1a'         => WizardStep.stufe1a,
      '1b'         => WizardStep.stufe1b,
      '1b1'        => WizardStep.stufe1b1,
      '1c'         => WizardStep.stufe1c,
      '1d'         => WizardStep.stufe1d,
      '1e'         => WizardStep.stufe1e,
      '1f'         => WizardStep.stufe1f,
      '2'          => WizardStep.stufe2,
      '3'          => WizardStep.stufe3,
      '3_upload'   => WizardStep.stufe3Upload,
      '4'          => WizardStep.stufe4,
      '5'          => WizardStep.stufe5,
      '6'          => WizardStep.stufe6,
      '7'          => WizardStep.stufe7,
      '8'          => WizardStep.stufe8,
      'done'       => WizardStep.done,
      _            => WizardStep.intro,
    };

/// Result returned from `start.php`. `resumed=true` when the server
/// found an existing draft for this anonymous_id (we resume from the
/// stored `currentStep` instead of restarting from the intro story).
class WizardStartResult {
  final String anonymousId;
  final WizardStep currentStep;
  final bool resumed;

  const WizardStartResult({
    required this.anonymousId,
    required this.currentStep,
    required this.resumed,
  });
}

/// Result returned from `finalize.php` once the wizard is done. For
/// adults the `mitgliedernummer` is the live member id; for minors
/// the same field carries the placeholder id pending parent linkage.
class WizardFinalizeResult {
  final String mitgliedernummer;
  final int userId;
  final String status;        // 'neu' or 'waiting_for_parent_consent'
  final bool isMinor;
  final String message;

  const WizardFinalizeResult({
    required this.mitgliedernummer,
    required this.userId,
    required this.status,
    required this.isMinor,
    required this.message,
  });
}

/// Singleton bridge between the wizard UI and the six
/// /api/public/wizard/*.php endpoints. Keeps a single anonymous_id
/// per install in SharedPreferences (key `wizard_anonymous_id`) so a
/// visitor returning to the app picks up exactly where they left off.
/// Also persists the "device-blocked under 16" flag so a visitor who
/// got rejected by the age gate can't simply restart the wizard.
class WizardService {
  static const String _baseUrl =
      'https://icd360sev.icd360s.de/api/public/wizard';
  static const String _kIdKey         = 'wizard_anonymous_id';
  static const String _kBlockKey      = 'wizard_blocked_under16_until';

  String? _cachedId;
  late http.Client _client;
  final _log = LoggerService();

  static final WizardService _instance = WizardService._internal();
  factory WizardService() => _instance;
  WizardService._internal() {
    _client = IOClient(HttpClientFactory.createPinnedHttpClient());
  }

  // ---------------------------------------------------------------------------
  // Local state — anonymous_id + under-16 deterrent.
  // ---------------------------------------------------------------------------

  /// Returns the persistent anonymous_id, generating it on first
  /// call. 16 random bytes → 32 hex chars. Survives logout / app
  /// restart, resets on a fresh install.
  Future<String> ensureId() async {
    if (_cachedId != null) return _cachedId!;
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_kIdKey);
    if (id == null || id.length < 16) {
      final rng = Random.secure();
      final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
      id = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      await prefs.setString(_kIdKey, id);
    }
    _cachedId = id;
    return id;
  }

  /// True if a previous wizard run flagged this device as below the
  /// Satzung-mandated 16-year minimum. The block expires the day the
  /// visitor would actually turn 16, so they can retry then.
  Future<bool> isDeviceBlocked() async {
    final prefs = await SharedPreferences.getInstance();
    final iso = prefs.getString(_kBlockKey);
    if (iso == null) return false;
    final until = DateTime.tryParse(iso);
    if (until == null) return false;
    if (DateTime.now().isAfter(until)) {
      await prefs.remove(_kBlockKey);
      return false;
    }
    return true;
  }

  /// Date at which the visitor would reach 16 — the day the device
  /// block lifts. Null if no block is active.
  Future<DateTime?> deviceBlockedUntil() async {
    final prefs = await SharedPreferences.getInstance();
    final iso = prefs.getString(_kBlockKey);
    if (iso == null) return null;
    return DateTime.tryParse(iso);
  }

  Future<void> _markDeviceBlocked(DateTime birthdate) async {
    final reach16 = DateTime(
      birthdate.year + 16,
      birthdate.month,
      birthdate.day,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kBlockKey, reach16.toIso8601String());
  }

  /// Wipe the local anonymous_id (e.g. after a successful finalize).
  /// The server keeps the draft row for audit but a new wizard run on
  /// this device starts fresh.
  Future<void> resetLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kIdKey);
    _cachedId = null;
  }

  // ---------------------------------------------------------------------------
  // Server calls.
  // ---------------------------------------------------------------------------

  /// POST start.php — creates or resumes the draft.
  Future<WizardStartResult?> start() async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/start.php'),
            headers: _headers(),
            body: jsonEncode({'anonymous_id': id}),
          )
          .timeout(const Duration(seconds: 15));
      if (r.statusCode != 200) {
        _log.error('wizard.start HTTP ${r.statusCode}: ${r.body}', tag: 'WIZ');
        return null;
      }
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      if (body['success'] != true) return null;
      return WizardStartResult(
        anonymousId: body['anonymous_id'] as String,
        currentStep: wizardStepFromName(body['current_step'] as String),
        resumed: body['resumed'] == true,
      );
    } catch (e) {
      _log.error('wizard.start: $e', tag: 'WIZ');
      return null;
    }
  }

  /// POST save_step.php — persists one step's data + advances cursor.
  /// [data] must contain only the keys appropriate to [step]; extras
  /// are silently dropped server-side.
  Future<bool> saveStep(WizardStep step, Map<String, dynamic> data) async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/save_step.php'),
            headers: _headers(),
            body: jsonEncode({
              'anonymous_id': id,
              'step': wizardStepName(step),
              'data': data,
            }),
          )
          .timeout(const Duration(seconds: 15));
      if (r.statusCode != 200) {
        _log.error('wizard.save HTTP ${r.statusCode}: ${r.body}', tag: 'WIZ');
        return false;
      }
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      return body['success'] == true;
    } catch (e) {
      _log.error('wizard.save: $e', tag: 'WIZ');
      return false;
    }
  }

  /// POST get_state.php — rehydrate the draft after an app restart.
  /// Returned map keys are the data column names without the `data_`
  /// prefix (e.g. `vorname`, `nachname`).
  Future<Map<String, dynamic>?> getState() async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/get_state.php'),
            headers: _headers(),
            body: jsonEncode({'anonymous_id': id}),
          )
          .timeout(const Duration(seconds: 15));
      if (r.statusCode != 200) return null;
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      if (body['success'] != true) return null;
      return {
        'current_step': body['current_step'],
        'data': (body['data'] as Map<String, dynamic>?) ?? const {},
      };
    } catch (e) {
      _log.error('wizard.getState: $e', tag: 'WIZ');
      return null;
    }
  }

  /// POST check_age.php — server-side verdict on the visitor's
  /// birthdate. If the verdict is `tooYoung`, the device is flagged
  /// locally so a subsequent wizard attempt is short-circuited at the
  /// welcome screen.
  Future<WizardAgeStatus?> checkAge(DateTime birthdate) async {
    try {
      final id = await ensureId();
      final iso = '${birthdate.year.toString().padLeft(4, '0')}-'
          '${birthdate.month.toString().padLeft(2, '0')}-'
          '${birthdate.day.toString().padLeft(2, '0')}';
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/check_age.php'),
            headers: _headers(),
            body: jsonEncode({
              'anonymous_id': id,
              'geburtsdatum': iso,
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (r.statusCode != 200) return null;
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      if (body['success'] != true) return null;
      final status = body['status'] as String?;
      final verdict = switch (status) {
        'ok'        => WizardAgeStatus.ok,
        'minor'     => WizardAgeStatus.minor,
        'too_young' => WizardAgeStatus.tooYoung,
        _           => null,
      };
      if (verdict == WizardAgeStatus.tooYoung) {
        await _markDeviceBlocked(birthdate);
      }
      return verdict;
    } catch (e) {
      _log.error('wizard.checkAge: $e', tag: 'WIZ');
      return null;
    }
  }

  /// Multipart upload for Stufe 3 (only when finanzielle_situation
  /// is buergergeld/sozialamt). Returns the relative server path
  /// (e.g. `wizard_leistungsbescheid/abc.pdf`).
  Future<String?> uploadLeistungsbescheid(File file) async {
    try {
      final id = await ensureId();
      final uri = Uri.parse('$_baseUrl/upload_leistungsbescheid.php');
      final req = http.MultipartRequest('POST', uri);
      req.headers.addAll(_headers(includeJson: false));
      req.fields['anonymous_id'] = id;
      req.files.add(await http.MultipartFile.fromPath('file', file.path));
      final streamed = await req.send().timeout(const Duration(seconds: 60));
      final r = await http.Response.fromStream(streamed);
      if (r.statusCode != 200) {
        _log.error('wizard.upload HTTP ${r.statusCode}: ${r.body}', tag: 'WIZ');
        return null;
      }
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      if (body['success'] != true) return null;
      return body['file_path'] as String?;
    } catch (e) {
      _log.error('wizard.upload: $e', tag: 'WIZ');
      return null;
    }
  }

  /// POST finalize.php — converts the draft into a real users row +
  /// 8 user_verifizierung rows. Returns null on validation failure;
  /// the [WizardFinalizeResult.isMinor] flag tells the UI whether to
  /// route the visitor to the "waiting for parent" screen or the
  /// regular "thank you, Vorstand will review" screen.
  Future<WizardFinalizeResult?> finalize() async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/finalize.php'),
            headers: _headers(),
            body: jsonEncode({'anonymous_id': id}),
          )
          .timeout(const Duration(seconds: 30));
      if (r.statusCode != 201 && r.statusCode != 200) {
        _log.error('wizard.finalize HTTP ${r.statusCode}: ${r.body}',
            tag: 'WIZ');
        return null;
      }
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      if (body['success'] != true) return null;
      return WizardFinalizeResult(
        mitgliedernummer: body['mitgliedernummer'] as String,
        userId: (body['user_id'] as num).toInt(),
        status: body['status'] as String,
        isMinor: body['is_minor'] == true,
        message: (body['message'] as String?) ?? '',
      );
    } catch (e) {
      _log.error('wizard.finalize: $e', tag: 'WIZ');
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Internals.
  // ---------------------------------------------------------------------------

  /// Headers attached to every wizard call. The server's
  /// `validateApiKey()` accepts either a Device Key or a legacy API
  /// key; we send the per-install Device Key the same way
  /// `ApiService.register` does for the legacy register endpoint.
  /// The visitor's device is already registered at this point — the
  /// app's main() runs DeviceKeyService.initialize() before any UI is
  /// shown — so the value is reliably non-null.
  Map<String, String> _headers({bool includeJson = true}) {
    final deviceKey = DeviceKeyService().deviceKey;
    return {
      if (includeJson) 'Content-Type': 'application/json',
      'User-Agent': 'ICD360S-Mitglied/1.0',
      if (deviceKey != null) 'X-Device-Key': deviceKey,
    };
  }
}
