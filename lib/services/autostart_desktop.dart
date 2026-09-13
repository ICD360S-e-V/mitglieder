// „Beim Anmelden starten" — auf Windows, Linux und macOS.
//
// 🔴 WARUM DAS ÜBERHAUPT NÖTIG IST. Auf Android hält ein Vordergrunddienst die
// Verbindung, auch wenn die App aus dem Blick ist; auf dem Rechner gibt es
// keinen solchen Dienst (`BackgroundService.isSupported` = Android ∨ iOS). Die
// App ist EIN Prozess mit EINER Verbindung: läuft sie nicht, kommt kein Anruf
// an — es klingelt nirgends, und niemand erfährt davon. Das Schliessen des
// Fensters minimiert bereits in den Infobereich; was fehlte, war der Start nach
// dem Anmelden.
//
// ⚠️ Der Schalter steht VOREINGESTELLT AUS und wird nie von selbst umgelegt.
// Eine App, die sich ohne Zutun in den Autostart des Rechners einträgt, ist
// eine Zumutung — auch wenn sie es gut meint. Das Mitglied entscheidet, und der
// Text daneben sagt, was es kostet, wenn es „aus" bleibt.
import 'dart:io';

import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'logger_service.dart';

class AutostartDesktop {
  AutostartDesktop._();

  static final LoggerService _log = LoggerService();
  static bool _eingerichtet = false;

  static bool get verfuegbar =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  /// ⚠️ Im Flatpak trägt sich nichts in den Autostart ein: der Sandkasten hat
  /// kein Verzeichnis, in das ein `.desktop` gehörte, und der Pfad zur
  /// ausführbaren Datei gilt nur INNERHALB des Sandkastens. Ein Schalter, der
  /// dort nichts bewirkt, wäre eine Lüge — deshalb wird er gar nicht angeboten.
  /// (Dieselbe Erkennung wie in [StartupDiagnostics]: `FLATPAK_ID`.)
  static bool get imFlatpak => Platform.environment['FLATPAK_ID'] != null;

  static bool get moeglich => verfuegbar && !imFlatpak;

  static Future<void> _einrichten() async {
    if (_eingerichtet) return;
    final info = await PackageInfo.fromPlatform();
    launchAtStartup.setup(
      appName: info.appName,
      // ⚠️ `Platform.resolvedExecutable` und nicht `executable`: der zweite ist
      // der Pfad, mit dem der Prozess gestartet wurde, und der kann relativ
      // sein. In einem Autostart-Eintrag muss ein absoluter Pfad stehen.
      appPath: Platform.resolvedExecutable,
    );
    _eingerichtet = true;
  }

  /// `null`, wenn es sich nicht feststellen liess — das ist etwas anderes als
  /// „aus", und die Zeile im Konto sagt es entsprechend.
  static Future<bool?> istAn() async {
    if (!moeglich) return null;
    try {
      await _einrichten();
      return await launchAtStartup.isEnabled();
    } catch (e) {
      _log.warning('Autostart: Zustand nicht lesbar: $e', tag: 'DESKTOP');
      return null;
    }
  }

  /// Gibt zurück, was danach WIRKLICH gilt — nicht, was gewünscht war.
  ///
  /// ⚠️ Der Rückgabewert von `enable()`/`disable()` wird nicht geglaubt,
  /// sondern nachgelesen: ein Schalter, der umspringt, obwohl im Register
  /// nichts stand, ist genau die stille Lüge, die dieses Projekt zweimal
  /// eingesammelt hat.
  static Future<bool?> setzen(bool an) async {
    if (!moeglich) return null;
    try {
      await _einrichten();
      if (an) {
        await launchAtStartup.enable();
      } else {
        await launchAtStartup.disable();
      }
      return await launchAtStartup.isEnabled();
    } catch (e) {
      _log.error('Autostart: nicht setzbar: $e', tag: 'DESKTOP');
      return null;
    }
  }
}
