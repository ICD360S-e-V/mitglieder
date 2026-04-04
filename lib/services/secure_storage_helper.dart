import 'dart:io' show Platform;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Fix for flutter_secure_storage bug on macOS:
/// Dart sends key 'usesDataProtectionKeychain' but Swift reads 'useDataProtectionKeyChain'
/// (different casing). This causes the setting to never reach Swift, which defaults to true
/// (Data Protection Keychain), requiring entitlements that aren't present in dev builds.
///
/// This class overrides toMap() to send the correct key name that Swift expects.
class FixedMacOsOptions extends MacOsOptions {
  const FixedMacOsOptions() : super(usesDataProtectionKeychain: false);

  @override
  Map<String, String> toMap() => <String, String>{
    ...super.toMap(),
    // Fix: Swift plugin reads 'useDataProtectionKeyChain' (no 's', capital C)
    // but Dart sends 'usesDataProtectionKeychain' (with 's', lowercase c)
    'useDataProtectionKeyChain': 'false',
  };
}

/// Creates a FlutterSecureStorage instance with the correct macOS options.
/// On macOS, uses the legacy file-based Keychain (equally secure, no extra entitlements needed).
/// On other platforms, uses default options.
FlutterSecureStorage createSecureStorage() {
  if (Platform.isMacOS) {
    return const FlutterSecureStorage(
      mOptions: FixedMacOsOptions(),
    );
  }
  return const FlutterSecureStorage();
}
