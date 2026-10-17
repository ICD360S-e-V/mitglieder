import 'package:flutter/services.dart';

/// Ergebnis einer APK-Installation — die Statuscodes von
/// `android.content.pm.PackageInstaller`.
enum InstallStatus {
  erfolg(0),
  fehler(1),
  blockiert(2),
  abgebrochen(3),
  ungueltig(4),
  konflikt(5),
  speicher(6),
  inkompatibel(7),
  unbekannt(-2),

  /// Eine Installation desselben Pakets wartet schon (Bestätigung offen oder
  /// unterwegs) — es wurde KEINE zweite angelegt. Kein Code von Android,
  /// sondern von `IcdInstallerPlugin.STATUS_LAEUFT`.
  laeuft(-3);

  const InstallStatus(this.code);
  final int code;

  static InstallStatus ausCode(int? code) => InstallStatus.values.firstWhere(
        (s) => s.code == code,
        orElse: () => InstallStatus.unbekannt,
      );
}

/// Installiert ein heruntergeladenes APK über die PackageInstaller-Session-API.
///
/// Kopie aus der Vorsitzer-App (packages/icd_installer, 17.10.2026). Gleicher
/// Ablauf: Session, wenn nötig der Bestätigungsdialog des Systems, Endstatus
/// zurück.
///
/// ⚠️ Bei einer Selbst-Aktualisierung kommt [InstallStatus.erfolg] nie an —
/// Android beendet den Prozess, während es das Paket ersetzt. Das Future hängt
/// dann bis zum Prozessende; wer darauf wartet, wartet vergebens. Ein Abbruch
/// durch den Nutzer kommt dagegen als [InstallStatus.abgebrochen].
class IcdInstaller {
  IcdInstaller._();

  static const _kanal = MethodChannel('de.icd360s.mitglied/installer');

  /// Würde Android ein Update DIESER App jetzt ohne Rückfrage einspielen?
  ///
  /// Nein vor Android 12, ohne „Apps aus unbekannten Quellen installieren"
  /// für diese App, und wenn sich ein Store die Updates vorbehalten hat. Ob
  /// die Zielversion der App reicht, entscheidet erst Android selbst — dann
  /// fragt es eben doch.
  static Future<bool> kannOhneNachfrage() async {
    try {
      return await _kanal.invokeMethod<bool>('kannOhneNachfrage') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  /// Wirft [PlatformException] bei fehlender Datei, fehlender Activity oder
  /// einem Fehler beim Anlegen der Session — das sind Fehler des Aufrufers oder
  /// des Systems, keine Statuscodes.
  ///
  /// [ohneNachfrage]: ab Android 12 darf ein UPDATE ohne Bestätigungsdialog
  /// laufen — wenn die App sich selbst ersetzt und
  /// `UPDATE_PACKAGES_WITHOUT_USER_ACTION` hält. Sonst fragt das System wie
  /// immer; schiefgehen kann dabei nichts.
  static Future<InstallStatus> apkInstallieren(
    String pfad, {
    bool ohneNachfrage = false,
  }) async {
    final code = await _kanal.invokeMethod<int>(
      'installApk',
      {'pfad': pfad, 'ohneNachfrage': ohneNachfrage},
    );
    return InstallStatus.ausCode(code);
  }
}
