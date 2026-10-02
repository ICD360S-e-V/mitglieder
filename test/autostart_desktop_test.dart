// Autostart ohne launch_at_startup: die Einträge, die eine ältere Fassung der
// App mit launch_at_startup 0.5.1 gesetzt hat, müssen weiter erkannt und beim
// Ausschalten entfernt werden — sonst startete die App, obwohl der Schalter
// „aus" zeigt.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icd360sev_mitglied/services/autostart_desktop.dart';

void main() {
  late Directory heim;

  setUp(() => heim = Directory.systemTemp.createTempSync('autostart_test_'));
  tearDown(() => heim.deleteSync(recursive: true));

  const appName = 'ICD360S e.V. Mitglied';
  const appPfad = '/opt/icd360sev-mitglied/icd360sev_mitglied';

  AutostartLinux linux() =>
      AutostartLinux(appName: appName, appPfad: appPfad, heim: heim.path);

  File desktopDatei() => File('${heim.path}/.config/autostart/$appName.desktop');

  group('Linux (XDG-Autostart)', () {
    test('einschalten legt die Datei an, ausschalten entfernt sie', () async {
      final eintrag = linux();
      expect(await eintrag.istAn(), isFalse);

      await eintrag.einschalten();
      expect(await eintrag.istAn(), isTrue);
      expect(desktopDatei().existsSync(), isTrue);

      await eintrag.ausschalten();
      expect(await eintrag.istAn(), isFalse);
      expect(desktopDatei().existsSync(), isFalse);
    });

    test('🔴 ein Eintrag von launch_at_startup 0.5.1 wird erkannt und entfernt',
        () async {
      // Genau so schrieb launch_at_startup 0.5.1 die Datei (ohne args).
      const alt = '[Desktop Entry]\n'
          'Type=Application\n'
          'Name=$appName\n'
          'Comment=$appName startup script\n'
          'Exec=$appPfad\n'
          'StartupNotify=false\n'
          'Terminal=false\n';
      desktopDatei()
        ..createSync(recursive: true)
        ..writeAsStringSync(alt);

      final eintrag = linux();
      expect(await eintrag.istAn(), isTrue,
          reason: 'der Schalter muss den alten Eintrag als „an" zeigen');
      expect(eintrag.inhalt, alt, reason: 'neu geschrieben wird dasselbe');

      await eintrag.ausschalten();
      expect(desktopDatei().existsSync(), isFalse,
          reason: 'sonst startete die App weiter, obwohl „aus" angezeigt wird');
    });

    test('einschalten legt ~/.config/autostart an, wenn es fehlt', () async {
      expect(Directory('${heim.path}/.config').existsSync(), isFalse);
      await linux().einschalten();
      expect(desktopDatei().readAsStringSync(), contains('Exec=$appPfad\n'));
    });
  });

  test('Windows: dieselben Registerstellen wie launch_at_startup 0.5.1', () {
    expect(AutostartWindows.runPfad,
        r'Software\Microsoft\Windows\CurrentVersion\Run');
    expect(AutostartWindows.freigabePfad,
        r'Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run');
  });
}
