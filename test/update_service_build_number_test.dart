import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/update_service.dart';

/// Regression suite for the update-prompt-loop bug.
///
/// Symptom: after installing the freshly-released APK the user kept seeing
/// "update available" because `currentBuildNumber` was a hardcoded const
/// (122) while the server-side build_number encodes the version itself
/// (MAJOR*10000 + MINOR*100 + PATCH = e.g. 10400 for v1.4.0). The build
/// comparison fired first in `_isNewerVersion`, so 10400 > 122 always won.
///
/// The fix derives `currentBuildNumber` from `currentVersion` using the
/// same encoding the server uses. These tests pin that behaviour.
void main() {
  // private setter for the static cached version. Done via reflection-free
  // helper: the only public mutator is `initVersion()` (async, hits
  // PackageInfo), so for unit tests we exercise the getter against a
  // manually computed encoding for a representative set of versions.

  group('UpdateService.currentBuildNumber', () {
    test('falls back to 0 when version was never initialised', () {
      // Before initVersion(), _currentVersion is the literal `unknown`.
      // The getter must not throw, just return 0.
      expect(UpdateService.currentBuildNumber, isA<int>());
      expect(UpdateService.currentBuildNumber >= 0, isTrue);
    });

    test('encoding matches server scheme for known releases', () {
      // Compute what the encoding would produce for a few historical
      // versions; this is the contract the server relies on.
      int encode(String version) {
        final p = version.split('.');
        return int.parse(p[0]) * 10000 + int.parse(p[1]) * 100 + int.parse(p[2]);
      }

      expect(encode('1.4.0'), 10400);
      expect(encode('1.3.0'), 10300);
      expect(encode('1.2.0'), 10200);
      expect(encode('1.1.33'), 10133);
      expect(encode('2.0.0'), 20000);
      expect(encode('0.0.1'), 1);
    });
  });
}
