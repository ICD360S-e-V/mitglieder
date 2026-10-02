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
//
// ⚠️ OHNE `launch_at_startup` (bis 10/2026 im Einsatz). Dessen letzte Fassung
// 0.5.1 verlangt `win32_registry ^2` und hielt damit win32 auf 5 fest — und
// mit ihm device_info_plus, package_info_plus, network_info_plus und
// file_picker. Was es tat, steht jetzt hier, und zwar GENAU so: dieselbe
// Registerstelle und derselbe Wertname unter Windows, dieselbe `.desktop`-Datei
// unter Linux. Einen Eintrag, den ein Mitglied mit einer älteren Fassung der
// App gesetzt hat, erkennt der Schalter weiter — und entfernt ihn beim
// Ausschalten.
import 'dart:io';
import 'dart:typed_data';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:win32_registry/win32_registry.dart';

import 'logger_service.dart';

class AutostartDesktop {
  AutostartDesktop._();

  static final LoggerService _log = LoggerService();
  static AutostartEintrag? _eintrag;

  static bool get verfuegbar =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  /// ⚠️ Im Flatpak trägt sich nichts in den Autostart ein: der Sandkasten hat
  /// kein Verzeichnis, in das ein `.desktop` gehörte, und der Pfad zur
  /// ausführbaren Datei gilt nur INNERHALB des Sandkastens. Ein Schalter, der
  /// dort nichts bewirkt, wäre eine Lüge — deshalb wird er gar nicht angeboten.
  /// (Dieselbe Erkennung wie in [StartupDiagnostics]: `FLATPAK_ID`.)
  static bool get imFlatpak => Platform.environment['FLATPAK_ID'] != null;

  static bool get moeglich => verfuegbar && !imFlatpak;

  static Future<AutostartEintrag> _einrichten() async {
    final vorhanden = _eintrag;
    if (vorhanden != null) return vorhanden;
    final info = await PackageInfo.fromPlatform();
    return _eintrag = AutostartEintrag.fuerDiesesSystem(
      appName: info.appName,
      // ⚠️ `Platform.resolvedExecutable` und nicht `executable`: der zweite ist
      // der Pfad, mit dem der Prozess gestartet wurde, und der kann relativ
      // sein. In einem Autostart-Eintrag muss ein absoluter Pfad stehen.
      appPfad: Platform.resolvedExecutable,
    );
  }

  /// `null`, wenn es sich nicht feststellen liess — das ist etwas anderes als
  /// „aus", und die Zeile im Konto sagt es entsprechend.
  static Future<bool?> istAn() async {
    if (!moeglich) return null;
    try {
      final eintrag = await _einrichten();
      return await eintrag.istAn();
    } catch (e) {
      _log.warning('Autostart: Zustand nicht lesbar: $e', tag: 'DESKTOP');
      return null;
    }
  }

  /// Gibt zurück, was danach WIRKLICH gilt — nicht, was gewünscht war.
  ///
  /// ⚠️ Nach dem Schreiben wird nachgelesen statt angenommen: ein Schalter,
  /// der umspringt, obwohl im Register nichts stand, ist genau die stille
  /// Lüge, die dieses Projekt zweimal eingesammelt hat.
  static Future<bool?> setzen(bool an) async {
    if (!moeglich) return null;
    try {
      final eintrag = await _einrichten();
      if (an) {
        await eintrag.einschalten();
      } else {
        await eintrag.ausschalten();
      }
      return await eintrag.istAn();
    } catch (e) {
      _log.error('Autostart: nicht setzbar: $e', tag: 'DESKTOP');
      return null;
    }
  }
}

/// Der Autostart-Eintrag des Betriebssystems für [appName] → [appPfad].
abstract class AutostartEintrag {
  const AutostartEintrag({required this.appName, required this.appPfad});

  final String appName;
  final String appPfad;

  factory AutostartEintrag.fuerDiesesSystem({
    required String appName,
    required String appPfad,
  }) {
    if (Platform.isWindows) {
      return AutostartWindows(appName: appName, appPfad: appPfad);
    }
    if (Platform.isLinux) {
      return AutostartLinux(
        appName: appName,
        appPfad: appPfad,
        heim: Platform.environment['HOME'] ?? '',
      );
    }
    // ⚠️ macOS: launch_at_startup sprach dort über einen Kanal, den die App im
    // Runner selbst hätte bereitstellen müssen — diese App hatte ihn nie. Der
    // Schalter zeigte deshalb schon immer „unbekannt" und meldete beim Umlegen
    // einen Fehler. So bleibt es, bis es jemand wirklich baut.
    throw UnsupportedError('Autostart ist unter macOS nicht umgesetzt');
  }

  Future<bool> istAn();
  Future<void> einschalten();
  Future<void> ausschalten();
}

/// XDG-Autostart: eine `.desktop`-Datei in `~/.config/autostart`.
class AutostartLinux extends AutostartEintrag {
  const AutostartLinux({
    required super.appName,
    required super.appPfad,
    required this.heim,
  });

  /// Das Heimatverzeichnis; im Test ein Zwischenordner.
  final String heim;

  /// ⚠️ Ort und Name wie bei launch_at_startup 0.5.1 — sonst fände das
  /// Ausschalten einen alten Eintrag nicht, und die App startete weiter.
  File get datei => File('$heim/.config/autostart/$appName.desktop');

  /// Zeile für Zeile, was launch_at_startup 0.5.1 schrieb.
  String get inhalt => '[Desktop Entry]\n'
      'Type=Application\n'
      'Name=$appName\n'
      'Comment=$appName startup script\n'
      'Exec=$appPfad\n'
      'StartupNotify=false\n'
      'Terminal=false\n';

  @override
  Future<bool> istAn() async => datei.existsSync();

  @override
  Future<void> einschalten() async {
    await datei.parent.create(recursive: true);
    await datei.writeAsString(inhalt);
  }

  @override
  Future<void> ausschalten() async {
    if (datei.existsSync()) await datei.delete();
  }
}

/// Windows: der Wert [appName] unter `HKCU\…\Run`, dazu die Freigabe unter
/// `…\StartupApproved\Run` (die der Task-Manager beim Deaktivieren umschreibt).
class AutostartWindows extends AutostartEintrag {
  const AutostartWindows({required super.appName, required super.appPfad});

  /// ⚠️ Beide Stellen und der Wertname wie bei launch_at_startup 0.5.1.
  static const runPfad = r'Software\Microsoft\Windows\CurrentVersion\Run';
  static const freigabePfad =
      r'Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run';

  /// 12 Byte, das erste 2 = erlaubt (wie launch_at_startup 0.5.1).
  static const _freigabeLaenge = 12;

  T _mitSchluessel<T>(String pfad, T Function(RegistryKey schluessel) tun) {
    final schluessel = CURRENT_USER.open(
      pfad,
      config: const RegistryOpenConfig(access: RegistryAccess.all),
    );
    try {
      return tun(schluessel);
    } finally {
      schluessel.close();
    }
  }

  @override
  Future<bool> istAn() async {
    final wert = _mitSchluessel(runPfad, (k) => k.getString(appName));
    return wert == appPfad && _freigegeben();
  }

  /// Ein ungerades erstes Byte heisst: im Task-Manager deaktiviert. Fehlt der
  /// Wert oder ist er leer, startet Windows die App.
  bool _freigegeben() {
    final bytes = _mitSchluessel(freigabePfad, (k) => k.getBinary(appName));
    if (bytes == null || bytes.isEmpty) return true;
    return bytes[0].isEven;
  }

  @override
  Future<void> einschalten() async {
    _mitSchluessel(
      runPfad,
      (k) => k.setValue(appName, RegistryValue.string(appPfad)),
    );
    final freigabe = Uint8List(_freigabeLaenge)..[0] = 2;
    _mitSchluessel(
      freigabePfad,
      (k) => k.setValue(appName, RegistryValue.binary(freigabe)),
    );
  }

  @override
  Future<void> ausschalten() async {
    for (final pfad in [runPfad, freigabePfad]) {
      _mitSchluessel(pfad, (k) {
        if (k.getValue(appName) != null) k.removeValue(appName);
      });
    }
  }
}
