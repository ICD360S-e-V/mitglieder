import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:icd360sev_mitglied/services/theme_service.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';

/// Der dunkle Modus hat zwei Stellen, an denen ein Fehler nicht auffällt,
/// bevor ihn ein Mitglied sieht.
///
/// Die erste ist das Nachtfenster. Es läuft über Mitternacht, und genau da
/// stimmt die naheliegende Bedingung `stunde >= 20 && stunde < 6` nie — sie
/// ist für jede Stunde des Tages falsch. Der Test hält die Grenzen fest.
///
/// Die zweite ist der Kontrast. Die App zeichnete ihre Karten weiß auf einen
/// mittelblauen Verlauf; im dunklen Modus muss die Karte weiterhin HELLER sein
/// als der Grund, auf dem sie liegt. Wird der Verlauf später einmal
/// aufgehellt, ohne die Kartenfarbe mitzuziehen, kippt die Schichtung, und die
/// Karte verschwindet im Hintergrund.
void main() {
  group('Nachtfenster 20:00–06:00', () {
    bool nachts(int stunde) =>
        ThemeService.isNightNow(DateTime(2026, 8, 21, stunde));

    test('tagsüber hell', () {
      for (final stunde in [6, 7, 12, 18, 19]) {
        expect(nachts(stunde), isFalse, reason: '$stunde Uhr ist Tag');
      }
    });

    test('nachts dunkel, auch über Mitternacht hinweg', () {
      for (final stunde in [20, 21, 23, 0, 3, 5]) {
        expect(nachts(stunde), isTrue, reason: '$stunde Uhr ist Nacht');
      }
    });

    test('die Grenzen liegen auf 20:00 und 06:00', () {
      expect(nachts(19), isFalse);
      expect(nachts(20), isTrue, reason: '20:00 schaltet um');
      expect(nachts(5), isTrue);
      expect(nachts(6), isFalse, reason: '06:00 schaltet zurück');
    });
  });

  group('Palette', () {
    double helligkeit(Color c) => c.computeLuminance();

    test('Karten liegen im dunklen Modus über dem Verlauf', () {
      final karte = helligkeit(AppColors.dark.card);
      for (final stopp in AppColors.dark.heroGradient) {
        expect(karte, greaterThan(helligkeit(stopp)),
            reason: 'Eine Karte auf dem Verlauf muss heller sein als der '
                'Verlauf, sonst liest sich die Schichtung verkehrt herum.');
      }
    });

    test('Karten liegen über dem Seitenhintergrund', () {
      expect(helligkeit(AppColors.dark.card),
          greaterThan(helligkeit(AppColors.dark.scaffoldBg)));
      expect(helligkeit(AppColors.light.card),
          greaterThan(helligkeit(AppColors.light.scaffoldBg)));
    });

    test('Text hebt sich in beiden Themes von der Karte ab', () {
      for (final (name, p) in [('hell', AppColors.light), ('dunkel', AppColors.dark)]) {
        final abstand = (helligkeit(p.textPrimary) - helligkeit(p.card)).abs();
        expect(abstand, greaterThan(0.5),
            reason: '$name: Fließtext auf einer Karte braucht Abstand');
      }
    });

    test('der kurze Verlauf sind die ersten beiden Stopps', () {
      expect(AppColors.light.heroGradientShort,
          equals(AppColors.light.heroGradient.sublist(0, 2)));
    });
  });

  group('Anbindung an das Theme', () {
    testWidgets('context.colors folgt der Helligkeit des Themes',
        (tester) async {
      late AppColors gelesen;

      Future<void> zeigen(ThemeData theme) async {
        await tester.pumpWidget(MaterialApp(
          theme: theme,
          home: Builder(builder: (context) {
            gelesen = context.colors;
            return const SizedBox.shrink();
          }),
        ));
        // MaterialApp blendet den Themenwechsel über 200 ms; ohne Ausblenden
        // liest der erste Bild noch die alte Palette. Dass hier überhaupt
        // etwas zu blenden ist, ist der Beleg dafür, dass AppColors.lerp
        // greift — eine Extension ohne lerp würde hart umspringen.
        await tester.pumpAndSettle();
      }

      await zeigen(AppTheme.light);
      expect(gelesen.card, equals(AppColors.light.card));

      await zeigen(AppTheme.dark);
      expect(gelesen.card, equals(AppColors.dark.card));
    });

    testWidgets('ohne AppColors-Extension fällt context.colors nicht um',
        (tester) async {
      // showDialog und die Anruf-Overlays schieben Routen, deren Kontext
      // während des Übergangs neben dem MaterialApp-Theme stehen kann. Dort
      // darf die Abkürzung nicht mit einem Null-Fehler die App abräumen.
      late AppColors gelesen;
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: Builder(builder: (context) {
          gelesen = context.colors;
          return const SizedBox.shrink();
        }),
      ));
      expect(gelesen.card, equals(AppColors.dark.card));
    });
  });
}
