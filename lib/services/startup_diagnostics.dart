import 'dart:convert';
import 'dart:io';
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

  /// Same endpoint pattern as LoggerService — Linux falls through to the
  /// "android" log endpoint because the server uses one bucket for every
  /// non-Windows client. No server-side change needed: the transcript
  /// rides on the existing log shape with `tag: "STARTUP"`.
  static String get _reportUrl {
    if (Platform.isWindows) return 'https://icd360sev.icd360s.de/api/logs/mitglieder_windows.php';
    return 'https://icd360sev.icd360s.de/api/logs/mitglieder_android.php';
  }

  /// Fire-and-forget POST of the recorded transcript to the central log
  /// endpoint. Designed to be called once, after runApp(), with whatever
  /// identifiers are available — anything missing is sent as 'unknown'
  /// so the server still has a row to inspect.
  ///
  /// Errors are caught and logged back into the transcript (which the
  /// user can still `cat` locally); they never propagate or crash the
  /// caller. Default 10-second timeout means a hung HTTPS request can't
  /// hold the app hostage forever.
  static Future<void> uploadToServer({
    String? appVersion,
    String? deviceId,
    String? mitgliedernummer,
  }) async {
    if (_entries.isEmpty) return;
    log('→ uploadToServer ($_reportUrl)');
    try {
      final body = jsonEncode({
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
      });
      final response = await http
          .post(
            Uri.parse(_reportUrl),
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(const Duration(seconds: 10));
      log('  ← uploadToServer status=${response.statusCode}');
    } catch (e) {
      log('  ✗ uploadToServer failed: $e');
    }
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
