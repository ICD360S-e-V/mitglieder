import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Records every step of `main()` to a plain-text log file from the very
/// first call, so that a startup that never reaches `runApp()` is still
/// debuggable: the user can `cat` the file and see exactly which step
/// hung, threw, or timed out — even when the GUI never renders.
///
/// Log location (in order of preference):
///   $XDG_CACHE_HOME/icd360sev/mitglieder/startup.log
///   $HOME/.cache/icd360sev/mitglieder/startup.log
///   $TMPDIR/icd360sev-mitglieder-startup.log
///   /tmp/icd360sev-mitglieder-startup.log
///
/// Usage in main():
///   void main() async {
///     WidgetsFlutterBinding.ensureInitialized();
///     StartupDiagnostics.init();
///     await StartupDiagnostics.step('ApiService.initialize',
///       () => ApiService().initialize());
///     // ... more steps ...
///     runApp(const MyApp());
///   }
///
/// The in-memory buffer is also exposed via [transcript] so a "show
/// startup log" widget can surface it without re-reading from disk.
class StartupDiagnostics {
  StartupDiagnostics._();

  static final List<String> _entries = [];
  static File? _logFile;
  static bool _hadFailure = false;

  /// Whether at least one step has logged an error or timeout. Cheap to
  /// query from widgets that want to decide whether to surface a banner.
  static bool get hadFailure => _hadFailure;

  /// Resolved absolute path of the log file (or empty if init() failed
  /// to open one).
  static String get logPath => _logFile?.path ?? '';

  /// All log lines emitted so far, joined with '\n'. Safe to use from a
  /// widget tree; updated in-place as more steps run.
  static String get transcript => _entries.join('\n');

  /// Open the log file and write the initial environment snapshot.
  /// Idempotent — safe to call more than once; subsequent calls log a
  /// new "session reopened" marker without truncating.
  static void init() {
    if (_logFile == null) {
      try {
        final dir = _resolveDir();
        Directory(dir).createSync(recursive: true);
        _logFile = File('$dir/startup.log');
      } catch (e) {
        // Fallback to /tmp if XDG / HOME aren't usable.
        try {
          _logFile = File('/tmp/icd360sev-mitglieder-startup.log');
        } catch (_) {
          _logFile = null;
        }
      }
      // Truncate so each launch starts with a clean log — yesterday's
      // hang shouldn't be confused with today's.
      try {
        _logFile?.writeAsStringSync('');
      } catch (_) {}
    }

    log('==================================================');
    log('startup @ ${DateTime.now().toIso8601String()}');
    log('==================================================');
    log('OS: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');
    log('Dart: ${Platform.version.split(' ').first}');
    log('locale: ${Platform.localeName}');
    log('executable: ${Platform.resolvedExecutable}');
    log('cwd: ${Directory.current.path}');
    log('inDebug: $kDebugMode  inProfile: $kProfileMode  inRelease: $kReleaseMode');
    log('-- environment hints --');
    for (final key in const [
      'XDG_SESSION_TYPE',
      'XDG_CURRENT_DESKTOP',
      'WAYLAND_DISPLAY',
      'DISPLAY',
      'GDK_BACKEND',
      'QT_QPA_PLATFORM',
      'LIBGL_ALWAYS_SOFTWARE',
      'GALLIUM_DRIVER',
      'MESA_LOADER_DRIVER_OVERRIDE',
      'FLATPAK_ID',
      'container',
    ]) {
      final v = Platform.environment[key];
      log('  $key=${v ?? "<unset>"}');
    }
    log('-- end environment --');
  }

  /// Append a raw line to the log buffer + file + stderr. Cheap; safe
  /// from any isolate.
  static void log(String msg) {
    final line = '[${DateTime.now().toIso8601String()}] $msg';
    _entries.add(line);
    debugPrint(line);
    try {
      _logFile?.writeAsStringSync(
        '$line\n',
        mode: FileMode.append,
        flush: true,
      );
    } catch (_) {
      // Log file is best-effort. If the disk is full or we lost the
      // handle, don't crash the app over it.
    }
  }

  /// Wrap an init step with start/done/fail markers. The result of
  /// [body] is returned; any thrown exception is logged and rethrown
  /// so the caller's try/catch can react. Timeouts are logged through
  /// the same code path so the transcript shows where the budget was
  /// spent.
  static Future<T> step<T>(String name, Future<T> Function() body) async {
    log('→ START $name');
    final sw = Stopwatch()..start();
    try {
      final result = await body();
      log('  ← DONE  $name  (${sw.elapsedMilliseconds}ms)');
      return result;
    } catch (e, st) {
      _hadFailure = true;
      log('  ✗ FAIL  $name  (${sw.elapsedMilliseconds}ms): $e');
      final stackLines = st.toString().split('\n').take(8).toList();
      for (final s in stackLines) {
        if (s.isNotEmpty) log('     $s');
      }
      rethrow;
    }
  }

  /// Same as [step] but with a [timeout]. If the timeout fires the
  /// step is recorded as `TIMEOUT` (counts as a failure) and [body]'s
  /// future is abandoned — control returns immediately to the caller
  /// with `null`, so a missing return value doesn't have to crash the
  /// whole startup.
  static Future<T?> stepWithTimeout<T>(
    String name,
    Duration timeout,
    Future<T> Function() body,
  ) async {
    log('→ START $name (budget ${timeout.inSeconds}s)');
    final sw = Stopwatch()..start();
    try {
      final result = await body().timeout(timeout);
      log('  ← DONE  $name  (${sw.elapsedMilliseconds}ms)');
      return result;
    } on Object catch (e, st) {
      _hadFailure = true;
      final isTimeout = e.toString().contains('TimeoutException');
      final label = isTimeout ? 'TIMEOUT' : 'FAIL';
      log('  ✗ $label  $name  (${sw.elapsedMilliseconds}ms): $e');
      if (!isTimeout) {
        for (final s in st.toString().split('\n').take(8)) {
          if (s.isNotEmpty) log('     $s');
        }
      }
      return null;
    }
  }

  /// Per-platform log endpoint — 7 distinct buckets so a transcript from
  /// one platform never gets buried in another's stream. The trailing
  /// `mitglieder_startup.php` is a safety fallback if Platform.is* ever
  /// returns false on every branch (a Flutter target we don't ship to yet,
  /// or a host where `Platform` reports a new OS string).
  ///
  /// Flatpak Linux is routed by the FLATPAK_ID env var the runtime sets,
  /// not by `Platform.isLinux`, so a non-Flatpak Linux install
  /// (AppImage / .deb / .rpm) keeps writing to the cleaner `_linux.php`
  /// bucket.
  static String get _reportUrl {
    const base = 'https://icd360sev.icd360s.de/api/logs';
    if (Platform.environment['FLATPAK_ID'] != null) return '$base/mitglieder_flatpack.php';
    if (Platform.isWindows) return '$base/mitglieder_windows.php';
    if (Platform.isAndroid) return '$base/mitglieder_android.php';
    if (Platform.isMacOS)   return '$base/mitglieder_macos.php';
    if (Platform.isIOS)     return '$base/mitglieder_ios.php';
    if (Platform.isLinux)   return '$base/mitglieder_linux.php';
    return '$base/mitglieder_startup.php';
  }

  /// 32-byte hex (256-bit AES-GCM key) injected at build time via
  /// `--dart-define=STARTUP_DIAG_KEY=…`. The value lives in the
  /// `STARTUP_DIAG_KEY` GitHub Secret on the CI side and never lands in
  /// source. The same value must live in the server-side PHP — see the
  /// decryption snippet in [uploadToServer]'s docstring.
  ///
  /// If the constant is empty (local `flutter run`, forgotten CI secret,
  /// developer build), `uploadToServer` short-circuits and only the
  /// on-disk transcript is produced. This is intentional: an unencrypted
  /// upload of diagnostic data should never happen by accident.
  ///
  /// Rotation: change the GitHub Secret + the matching server-side env
  /// var in the same release; the next build picks the new value up
  /// automatically.
  static const String _diagKeyHex =
      String.fromEnvironment('STARTUP_DIAG_KEY', defaultValue: '');

  static Uint8List _diagKey() {
    final hex = _diagKeyHex;
    final out = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < out.length; i++) {
      out[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return out;
  }

  /// Fire-and-forget POST of the recorded transcript to the log endpoint.
  /// The plaintext metadata is wrapped in an AES-256-GCM envelope so the
  /// body is opaque to anything sitting between the device and the PHP —
  /// not a substitute for TLS, just a second layer that protects request
  /// logs (nginx, CDN) from leaking the diagnostic text.
  ///
  /// Wire format (JSON):
  ///   { "v": 1, "iv": "<base64 12 bytes>", "data": "<base64 ciphertext+tag>" }
  ///
  /// The `cryptography` package returns the GCM auth tag separately;
  /// "data" here is `ciphertext || tag` concatenated, matching what PHP's
  /// `openssl_decrypt(..., OPENSSL_RAW_DATA, $iv, $tag)` expects after a
  /// single `substr` to split the last 16 bytes back off.
  ///
  /// Server-side decryption (single PHP file, no framework needed):
  ///
  ///   <?php
  ///   // same 32-byte hex that gets baked into the client builds via the
  ///   // STARTUP_DIAG_KEY GitHub Secret + --dart-define.
  ///   $key = hex2bin(getenv('STARTUP_DIAG_KEY'));
  ///   $env = json_decode(file_get_contents('php://input'), true);
  ///   if (!$env || ($env['v'] ?? 0) !== 1) { http_response_code(400); exit; }
  ///   $iv      = base64_decode($env['iv']);
  ///   $packed  = base64_decode($env['data']);
  ///   $tag     = substr($packed, -16);
  ///   $cipher  = substr($packed, 0, -16);
  ///   $plain   = openssl_decrypt($cipher, 'aes-256-gcm', $key,
  ///                              OPENSSL_RAW_DATA, $iv, $tag);
  ///   if ($plain === false) { http_response_code(400); exit; }
  ///   $payload = json_decode($plain, true);
  ///   // …write $payload['logs'][0]['message'] (the transcript) to
  ///   // the flatpak log bucket as you would for the android channel.
  ///   echo json_encode(['ok' => true]);
  ///
  /// Errors are caught and logged back into the on-disk transcript
  /// (which the user can still `cat` locally if the upload fails);
  /// they never propagate or crash the caller.
  static Future<void> uploadToServer({
    String? appVersion,
    String? deviceId,
    String? mitgliedernummer,
  }) async {
    if (_entries.isEmpty) return;
    if (_diagKeyHex.isEmpty || _diagKeyHex.length != 64) {
      log('→ uploadToServer skipped (no STARTUP_DIAG_KEY at build time; '
          'on-disk transcript only)');
      return;
    }
    log('→ uploadToServer ($_reportUrl)');
    try {
      final plaintext = utf8.encode(jsonEncode({
        'mitgliedernummer': mitgliedernummer ?? '',
        'device_id': deviceId ?? 'unknown',
        'platform': Platform.operatingSystem,
        'app_version': appVersion ?? 'unknown',
        'logs': [
          {
            'timestamp': DateTime.now().toIso8601String(),
            'message': _entries.join('\n'),
            'level': _hadFailure ? 'error' : 'info',
            'tag': 'STARTUP',
          }
        ],
      }));

      final aes = AesGcm.with256bits();
      final secretKey = SecretKey(_diagKey());
      // 12-byte nonce is the GCM standard — matches the byte length PHP's
      // openssl_decrypt expects in its $iv argument.
      final nonce = _randomNonce(12);
      final box = await aes.encrypt(
        plaintext,
        secretKey: secretKey,
        nonce: nonce,
      );
      // Concatenate ciphertext || tag so PHP can split with a single
      // substr(-16) rather than juggling two base64 fields.
      final packed = Uint8List(box.cipherText.length + box.mac.bytes.length)
        ..setRange(0, box.cipherText.length, box.cipherText)
        ..setRange(box.cipherText.length, box.cipherText.length + box.mac.bytes.length,
            box.mac.bytes);

      final envelope = jsonEncode({
        'v': 1,
        'iv': base64.encode(nonce),
        'data': base64.encode(packed),
      });

      final response = await http
          .post(
            Uri.parse(_reportUrl),
            headers: {'Content-Type': 'application/json'},
            body: envelope,
          )
          .timeout(const Duration(seconds: 10));
      log('  ← uploadToServer status=${response.statusCode}');
    } catch (e) {
      log('  ✗ uploadToServer failed: $e');
    }
  }

  /// dart:math Random — fine for IVs (uniqueness is what matters; the
  /// nonce is sent in cleartext anyway). Switching to Random.secure() is
  /// trivial if a security review later asks for it.
  static List<int> _randomNonce(int bytes) {
    final r = Random.secure();
    return List<int>.generate(bytes, (_) => r.nextInt(256));
  }

  static String _resolveDir() {
    final xdg = Platform.environment['XDG_CACHE_HOME'];
    if (xdg != null && xdg.isNotEmpty) {
      return '$xdg/icd360sev/mitglieder';
    }
    final home = Platform.environment['HOME'];
    if (home != null && home.isNotEmpty) {
      return '$home/.cache/icd360sev/mitglieder';
    }
    final tmp = Platform.environment['TMPDIR'] ?? '/tmp';
    return tmp;
  }
}
