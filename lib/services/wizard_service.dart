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

/// One row from `wizard_draft_files` — the relational sidecar that
/// holds every Stufe 3 Bescheid upload. The id is the canonical
/// identifier (used for delete); name, path, size and mime are
/// surfaced for the UI list.
class WizardBescheidFile {
  final int id;
  final String name;
  final String path;
  final int size;
  final String mimeType;

  const WizardBescheidFile({
    required this.id,
    required this.name,
    required this.path,
    required this.size,
    required this.mimeType,
  });

  factory WizardBescheidFile.fromJson(Map<String, dynamic> j) =>
      WizardBescheidFile(
        id:       (j['id'] as num).toInt(),
        name:     (j['file_name'] as String?) ?? '',
        path:     (j['file_path'] as String?) ?? '',
        size:     (j['file_size'] as num?)?.toInt() ?? 0,
        mimeType: (j['mime_type'] as String?) ?? '',
      );
}

/// Outcome of a single Stufe 3 file upload. Success carries the
/// freshly-inserted row plus the full ordered list of every Bescheid
/// row in the draft (so the UI can rerender deterministically without
/// merging local state). Error carries the HTTP status and the
/// server's `message` so the screen can show a precise toast — 413 for
/// the 10 MB or 100 MB caps, 409 for "20 files already", anything else
/// is generic.
class WizardLeistungsbescheidUploadResult {
  final bool isSuccess;
  final WizardBescheidFile? freshFile;
  final List<WizardBescheidFile> allFiles;
  final int totalBytes;
  final int? errorCode;
  final String? errorMessage;

  const WizardLeistungsbescheidUploadResult._({
    required this.isSuccess,
    this.freshFile,
    this.allFiles = const [],
    this.totalBytes = 0,
    this.errorCode,
    this.errorMessage,
  });

  factory WizardLeistungsbescheidUploadResult.success({
    required WizardBescheidFile? freshFile,
    required List<WizardBescheidFile> allFiles,
    required int totalBytes,
  }) =>
      WizardLeistungsbescheidUploadResult._(
        isSuccess: true,
        freshFile: freshFile,
        allFiles: allFiles,
        totalBytes: totalBytes,
      );

  factory WizardLeistungsbescheidUploadResult.error({
    required int code,
    required String? message,
  }) =>
      WizardLeistungsbescheidUploadResult._(
        isSuccess: false,
        errorCode: code,
        errorMessage: message,
      );
}

/// One row from `user_verifizierung`. The bottom sheet on the final
/// screen renders these chronologically (Stufe 1 → 8) so the visitor
/// sees what's been filled and what the Vorstand has signed off.
class WizardStufeStatus {
  final int stufe;
  /// 'offen' | 'ausgefuellt' | 'geprueft' | 'abgelehnt'.
  final String status;
  /// When the visitor finished filling this Stufe in the wizard.
  /// Null for Stufe 4 of fee-exempt members (never filled — skipped).
  final DateTime? ausgefuelltAm;
  /// When the Vorstand reviewed it. Null until they have.
  final DateTime? geprueftAm;

  const WizardStufeStatus({
    required this.stufe,
    required this.status,
    this.ausgefuelltAm,
    this.geprueftAm,
  });

  factory WizardStufeStatus.fromJson(Map<String, dynamic> j) =>
      WizardStufeStatus(
        stufe:          (j['stufe'] as num).toInt(),
        status:         (j['status'] as String?) ?? 'offen',
        ausgefuelltAm:  _parseDt(j['ausgefuellt_am']),
        geprueftAm:     _parseDt(j['geprueft_am']),
      );

  static DateTime? _parseDt(dynamic raw) {
    if (raw is! String || raw.isEmpty) return null;
    // MariaDB returns 'YYYY-MM-DD HH:MM:SS' in local time. DateTime.parse
    // accepts that with a space replaced by 'T'.
    return DateTime.tryParse(raw.replaceFirst(' ', 'T'));
  }
}

/// Snapshot returned by check_status.php — used by the final screen
/// to flip the Status Card from "În verificare" to "Activat" when the
/// Vorstand approves, and to drive the chronological details sheet.
class WizardStatusProbe {
  final String? mitgliedernummer;
  final int? userId;
  final String? status;
  final bool isActive;
  final bool isMinor;
  final List<WizardStufeStatus> stufen;
  const WizardStatusProbe({
    this.mitgliedernummer,
    this.userId,
    this.status,
    this.isActive = false,
    this.isMinor = false,
    this.stufen = const [],
  });
}

/// Envelope returned by [WizardService.finalize]. Either carries a
/// [WizardFinalizeResult] (success) or an [errorCode] the orchestrator
/// can switch on. `too_many_withdrawals` is the anti-abuse 429 path —
/// the applicant's name+DOB hash matched ≥3 recent withdrawn rows,
/// finalize.php rejected the automated path.
class WizardFinalizeOutcome {
  final WizardFinalizeResult? result;
  final String? errorCode;
  const WizardFinalizeOutcome._({this.result, this.errorCode});
  factory WizardFinalizeOutcome.success(WizardFinalizeResult r) =>
      WizardFinalizeOutcome._(result: r);
  factory WizardFinalizeOutcome.failure({String? code}) =>
      WizardFinalizeOutcome._(errorCode: code);

  bool get isSuccess => result != null;
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

  /// Mitgliedernummer reserved by the server at check_age time (or
  /// rehydrated from get_state on resume). Drives the small pill the
  /// shell renders in every Stufe screen so the visitor sees their
  /// number from Stufe 1c onwards. Null until the age verdict lands;
  /// nulled on [resetLocal].
  String? _mitgliedernummer;
  String? get mitgliedernummer => _mitgliedernummer;

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
    _mitgliedernummer = null;
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
      final mnr = body['mitgliedernummer'] as String?;
      if (mnr != null && mnr.isNotEmpty) {
        _mitgliedernummer = mnr;
      }
      final filesRaw = body['leistungsbescheid_files'] as List<dynamic>?;
      final files = (filesRaw ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(WizardBescheidFile.fromJson)
          .toList();
      return {
        'current_step':            body['current_step'],
        'mitgliedernummer':        mnr,
        'data':                    (body['data'] as Map<String, dynamic>?) ?? const {},
        'leistungsbescheid_files': files,
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
      // Server reserves the mitgliedernummer at this point (M for ok,
      // J for minor; too_young drafts skip it). Cache for the shell
      // pill so the visitor sees it from Stufe 1c onwards.
      final mnr = body['mitgliedernummer'] as String?;
      if (mnr != null && mnr.isNotEmpty) {
        _mitgliedernummer = mnr;
      }
      if (verdict == WizardAgeStatus.tooYoung) {
        await _markDeviceBlocked(birthdate);
      }
      return verdict;
    } catch (e) {
      _log.error('wizard.checkAge: $e', tag: 'WIZ');
      return null;
    }
  }

  /// Outcome of a Stufe 3 upload call. `freshPath` is the path the
  /// server saved this specific file to, while `allFiles` is the
  /// whole array after the append — the UI keeps both so it can
  /// highlight the latest tile and render the full list.
  ///
  /// On the server cap responses (409 / 413) we still return so the
  /// caller can show a precise toast; in that case [freshPath] is
  /// null and [errorMessage] carries the server's `message`.
  /// [errorCode] mirrors the HTTP status so the UI can switch on it.
  /// [category] must be one of the 4 fee-exempt buckets recognised by
  /// the server (`buergergeld`, `sozialamt`, `alg1`, `krankengeld`).
  /// It steers the storage subfolder so each Behörde's Bescheide land
  /// in their own bucket on disk — easier auditing for the Vorstand,
  /// no mixed-bag folder.
  Future<WizardLeistungsbescheidUploadResult> uploadLeistungsbescheid(
    File file,
    String category,
  ) async {
    try {
      final id = await ensureId();
      final uri = Uri.parse('$_baseUrl/upload_leistungsbescheid.php');
      final req = http.MultipartRequest('POST', uri);
      req.headers.addAll(_headers(includeJson: false));
      req.fields['anonymous_id'] = id;
      req.fields['category']     = category;
      req.files.add(await http.MultipartFile.fromPath('file', file.path));
      final streamed = await req.send().timeout(const Duration(seconds: 60));
      final r = await http.Response.fromStream(streamed);
      Map<String, dynamic>? body;
      try {
        body = jsonDecode(r.body) as Map<String, dynamic>;
      } catch (_) {
        body = null;
      }
      if (r.statusCode != 200 || body == null || body['success'] != true) {
        _log.error('wizard.upload HTTP ${r.statusCode}: ${r.body}', tag: 'WIZ');
        return WizardLeistungsbescheidUploadResult.error(
          code: r.statusCode,
          message: body?['message']?.toString(),
        );
      }
      final filesRaw = (body['files'] as List<dynamic>?) ?? const [];
      final files = filesRaw
          .whereType<Map<String, dynamic>>()
          .map(WizardBescheidFile.fromJson)
          .toList();
      final freshRaw = body['file'];
      final fresh = (freshRaw is Map<String, dynamic>)
          ? WizardBescheidFile.fromJson(freshRaw)
          : null;
      return WizardLeistungsbescheidUploadResult.success(
        freshFile: fresh,
        allFiles: files,
        totalBytes: (body['total_bytes'] as num?)?.toInt() ?? 0,
      );
    } catch (e) {
      _log.error('wizard.upload: $e', tag: 'WIZ');
      return WizardLeistungsbescheidUploadResult.error(
        code: 0,
        message: null,
      );
    }
  }

  /// Drops one previously-uploaded Bescheid from the draft (and from
  /// disk on the server). Returns the trimmed list on success or null
  /// on failure. The UI normally calls this when the visitor taps the
  /// trash icon on an item before submitting Stufe 3. The row is
  /// identified by its `wizard_draft_files.id` — server-side joined
  /// against the visitor's draft so a hostile client can't drop a
  /// sibling draft's file.
  Future<List<WizardBescheidFile>?> deleteLeistungsbescheid(int fileId) async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/delete_leistungsbescheid.php'),
            headers: _headers(),
            body: jsonEncode({
              'anonymous_id': id,
              'file_id':      fileId,
            }),
          )
          .timeout(const Duration(seconds: 15));
      if (r.statusCode != 200) {
        _log.error('wizard.delete HTTP ${r.statusCode}: ${r.body}', tag: 'WIZ');
        return null;
      }
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      if (body['success'] != true) return null;
      return ((body['files'] as List<dynamic>?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(WizardBescheidFile.fromJson)
          .toList();
    } catch (e) {
      _log.error('wizard.delete: $e', tag: 'WIZ');
      return null;
    }
  }

  /// POST finalize.php — converts the draft into a real users row +
  /// 8 user_verifizierung rows. Returns null on validation failure;
  /// the [WizardFinalizeResult.isMinor] flag tells the UI whether to
  /// route the visitor to the "waiting for parent" screen or the
  /// regular "thank you, Vorstand will review" screen.
  Future<WizardFinalizeOutcome> finalize() async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/finalize.php'),
            headers: _headers(),
            body: jsonEncode({'anonymous_id': id}),
          )
          .timeout(const Duration(seconds: 30));
      Map<String, dynamic>? body;
      try {
        body = jsonDecode(r.body) as Map<String, dynamic>;
      } catch (_) {
        body = null;
      }
      if (r.statusCode != 201 && r.statusCode != 200) {
        _log.error('wizard.finalize HTTP ${r.statusCode}: ${r.body}',
            tag: 'WIZ');
        // 429 = anti-abuse throttle. The server returns
        // {success:false, message, code:'too_many_withdrawals',
        // recent_withdrawals:N}.
        final code = body?['code'] as String?;
        return WizardFinalizeOutcome.failure(code: code);
      }
      if (body == null || body['success'] != true) {
        return WizardFinalizeOutcome.failure(code: body?['code'] as String?);
      }
      return WizardFinalizeOutcome.success(WizardFinalizeResult(
        mitgliedernummer: body['mitgliedernummer'] as String,
        userId: (body['user_id'] as num).toInt(),
        status: body['status'] as String,
        isMinor: body['is_minor'] == true,
        message: (body['message'] as String?) ?? '',
      ));
    } catch (e) {
      _log.error('wizard.finalize: $e', tag: 'WIZ');
      return WizardFinalizeOutcome.failure();
    }
  }

  /// Records a voluntary cancellation from the final screen — the
  /// visitor changed their mind before the Vorstand approved. The
  /// user row stays in the database for audit (registration
  /// timestamps, consent records, Bescheid uploads) but is marked
  /// `status = 'gekuendigt_selbst'` with `deactivated_at` populated.
  /// Idempotent server-side; safe to call twice.
  Future<bool> withdrawRequest() async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/withdraw.php'),
            headers: _headers(),
            body: jsonEncode({'anonymous_id': id}),
          )
          .timeout(const Duration(seconds: 15));
      if (r.statusCode != 200) {
        _log.error('wizard.withdraw HTTP ${r.statusCode}: ${r.body}',
            tag: 'WIZ');
        return false;
      }
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      return body['success'] == true;
    } catch (e) {
      _log.error('wizard.withdraw: $e', tag: 'WIZ');
      return false;
    }
  }

  /// Lightweight status probe used by WizardFinalScreen while it
  /// polls every 30 s. Returns the user's current status (or null
  /// if finalize hasn't created the user row yet — shouldn't happen
  /// since the screen is only rendered post-finalize).
  Future<WizardStatusProbe?> checkUserStatus() async {
    try {
      final id = await ensureId();
      final r = await _client
          .post(
            Uri.parse('$_baseUrl/check_status.php'),
            headers: _headers(),
            body: jsonEncode({'anonymous_id': id}),
          )
          .timeout(const Duration(seconds: 10));
      if (r.statusCode != 200) return null;
      final body = jsonDecode(r.body) as Map<String, dynamic>;
      if (body['success'] != true) return null;
      final stufenRaw = body['stufen'] as List<dynamic>?;
      final stufen = (stufenRaw ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(WizardStufeStatus.fromJson)
          .toList();
      return WizardStatusProbe(
        mitgliedernummer: body['mitgliedernummer'] as String?,
        userId:           (body['user_id'] as num?)?.toInt(),
        status:           body['status'] as String?,
        isActive:         body['is_active'] == true,
        isMinor:          body['is_minor'] == true,
        stufen:           stufen,
      );
    } catch (e) {
      _log.error('wizard.checkUserStatus: $e', tag: 'WIZ');
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
