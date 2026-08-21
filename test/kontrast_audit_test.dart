// Misst den Kontrast an dem, was wirklich gezeichnet wird.
//
// Die Farbtabelle in dunkelmodus_test.dart prüft die Palette gegen sich
// selbst — sie kann nicht wissen, welche Farbe am Ende tatsächlich auf
// welchem Grund landet. Dieser Test rendert die Bausteine, läuft den
// Widget-Baum ab und sucht zu jedem Textstück die nächste deckende Fläche
// darüber. Genau so entsteht der Fehler, den man sucht: eine Fläche, die auf
// die Theme-Farbe umgestellt wurde, und ein Text darauf, der es nicht wurde.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';

import 'package:icd360sev_mitglied/widgets/chat_message_bubble.dart';
import 'package:icd360sev_mitglied/widgets/conversation_list_item.dart';
import 'package:icd360sev_mitglied/widgets/claudiu_login_coach.dart';
import 'package:icd360sev_mitglied/widgets/legal_footer.dart';
import 'package:icd360sev_mitglied/widgets/login_tab.dart';
import 'package:icd360sev_mitglied/widgets/register_tab.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_banners.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_cards.dart';
import 'package:icd360sev_mitglied/widgets/signatur_card.dart';

double _ratio(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final hi = math.max(la, lb);
  final lo = math.min(la, lb);
  return (hi + 0.05) / (lo + 0.05);
}

/// Die nächste deckende Fläche über diesem Element.
///
/// Halbdurchsichtige Flächen werden übersprungen: sie legen sich über das,
/// was darunter liegt, und sind nicht der Grund, gegen den gemessen wird.
/// Bei einem Verlauf zählt der hellste Stopp — der ungünstigste Fall für
/// hellen Text.
Color? _grundFarbe(Element element) {
  Color? treffer;
  element.visitAncestorElements((vorfahr) {
    final w = vorfahr.widget;
    Color? kandidat;
    if (w is DecoratedBox) {
      final d = w.decoration;
      if (d is BoxDecoration) {
        if (d.gradient is LinearGradient) {
          final stops = (d.gradient! as LinearGradient).colors;
          kandidat = stops.reduce(
              (a, b) => a.computeLuminance() > b.computeLuminance() ? a : b);
        } else {
          kandidat = d.color;
        }
      }
    } else if (w is ColoredBox) {
      kandidat = w.color;
    } else if (w is Material) {
      kandidat = w.color;
    } else if (w is Badge) {
      // Badge zeichnet seine Fläche selbst, nicht über eine DecoratedBox.
      // Ohne diesen Zweig liefe der Aufstieg daran vorbei und vergliche die
      // Zahl mit der Karte dahinter.
      kandidat = w.backgroundColor;
    }
    if (kandidat != null && kandidat.a > 0.9) {
      treffer = kandidat;
      return false;
    }
    return true;
  });
  return treffer;
}

/// Alle sichtbaren Textstücke mit ihrer Farbe und dem Grund darunter.
List<(String, Color, Color, double)> _messen(WidgetTester tester) {
  final ergebnis = <(String, Color, Color, double)>[];
  for (final element in find.byType(RichText).evaluate()) {
    final render = element.renderObject;
    if (render is! RenderParagraph) continue;
    final span = render.text;
    if (span is! TextSpan) continue;
    final farbe = span.style?.color;
    final text = span.toPlainText().trim();
    if (farbe == null || farbe.a < 0.5) continue;
    // Nur echte Schrift. Symbole aus der Icon-Schriftart kommen hier ebenfalls
    // als Textstück an, und bei ihnen lässt sich der Grund nicht zuverlässig
    // bestimmen: das Häkchen eines Badge etwa liegt auf der Karte, seine Zahl
    // auf der Badge-Fläche, und beide hängen im selben Teilbaum.
    if (!RegExp(r'[\p{L}\p{N}]', unicode: true).hasMatch(text)) continue;
    final grund = _grundFarbe(element);
    if (grund == null) continue;
    ergebnis.add((text, farbe, grund, _ratio(farbe, grund)));
  }
  return ergebnis;
}

Widget _huelle(Widget kind, ThemeData theme) => MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(16), child: kind),
        ),
      ),
    );

Widget _aufHero(Widget kind) => Builder(
      builder: (context) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: context.colors.heroGradient,
          ),
        ),
        child: Padding(padding: const EdgeInsets.all(16), child: kind),
      ),
    );

final Map<String, Widget Function()> _bausteine = <String, Widget Function()>{
  'PersonalDataCard': () => PersonalDataCard(onUpdate: () {}),
  'BeitragCard': () => const BeitragCard(
        isLoading: false,
        beitragBezahlt: false,
        beitragJahr: 2026,
      ),
  'WelcomeCard': () => const WelcomeCard(
        userName: 'Maximilian Freiherr von Habsburg',
        greeting: 'Guten Morgen',
      ),
  'TrialWarningBanner': () =>
      TrialWarningBanner(daysRemaining: 3, trialEndsAt: DateTime(2026, 9, 1)),
  'SignaturCard': () => SignaturCard(offen: 2, onOeffnen: () {}),
  'LegalFooter': () => const LegalFooter(),
  'ConversationListItem': () => ConversationListItem(
        conversation: const {
          'id': 1,
          'name': 'Vorsitzender Bartholomäus',
          'last_message': 'Ihre Unterlagen sind vollständig angekommen.',
          'unread_count': 4,
          'updated_at': '2026-08-09T10:15:00',
        },
        // isSelected: false, weil der ausgewählte Zustand die Zeile in einen
        // Container mit Farbe wickelt und Flutter dann zu Recht meldet, dass
        // die ListTile darunter ihren eigenen Hintergrund nicht mehr zeigen
        // kann. Das ist eine bestehende Eigenheit dieses Widgets und hat mit
        // Kontrast nichts zu tun; hier würde sie nur den Test rot färben.
        isSelected: false,
        hasActiveCall: true,
        onTap: () {},
      ),
  'ChatMessageBubble fremd': () => ChatMessageBubble(
        message: const {
          'sender_name': 'Vorsitzender Bartholomäus',
          'message': 'Guten Tag, Ihre Unterlagen sind vollständig angekommen.',
          'created_at': '2026-08-09T10:15:00',
          'status': 'read',
        },
        isOwn: false,
        onDownloadAttachment: (_) {},
      ),
  'LoginTab (Fehler)': () => _aufHero(LoginTab(
        mitgliedernummerController: TextEditingController(text: '360'),
        isLoading: false,
        errorMessage: 'Anmeldung fehlgeschlagen.',
        onLogin: () {},
      )),
  'RegisterTab (Fehler)': () => _aufHero(RegisterTab(
        apiService: ApiService(),
        isLoading: false,
        errorMessage: 'Diese E-Mail ist bereits vergeben.',
        onRegisterSuccess: (_) {},
        onLoadingChanged: (_) {},
        onErrorChanged: (_) {},
        onSuccessChanged: (_) {},
      )),
  'RegisterTab (Erfolg)': () => _aufHero(RegisterTab(
        apiService: ApiService(),
        isLoading: false,
        successMessage: 'Ihr Antrag ist eingegangen.',
        onRegisterSuccess: (_) {},
        onLoadingChanged: (_) {},
        onErrorChanged: (_) {},
        onSuccessChanged: (_) {},
      )),
  'ClaudiuLoginCoach': () => _aufHero(const ClaudiuLoginCoach(
        digitCount: 3,
        isLoading: false,
        errorMessage: 'Die Mitgliedsnummer ist unbekannt.',
      )),
  'ChatMessageBubble eigen': () => ChatMessageBubble(
        message: const {
          'message': 'Vielen Dank für die schnelle Rückmeldung!',
          'created_at': '2026-08-09T10:16:00',
          'status': 'read',
        },
        isOwn: true,
        onDownloadAttachment: (_) {},
      ),
};

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<Map<String, double>> messen(
      WidgetTester tester, Widget Function() bauen, ThemeData theme) async {
    // Bewusst breiter als ein Telefon. Gemessen wird hier Kontrast, nicht
    // Layout; ein Überlauf in einem engen Rahmen würde als Ausnahme im Test
    // landen und eine Aussage über Farben mit einer über Breiten vermischen.
    // Für Breiten gibt es einen eigenen Test.
    tester.view.physicalSize = const Size(700, 1200) * 2.0;
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_huelle(bauen(), theme));
    await tester.pump(const Duration(milliseconds: 800));
    final werte = <String, double>{};
    for (final (text, _, _, verhaeltnis) in _messen(tester)) {
      // Beim gleichen Text zweimal zählt der schlechtere Wert.
      werte[text] = math.min(werte[text] ?? double.infinity, verhaeltnis);
    }
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 5));
    return werte;
  }

  // Die Messlatte ist nicht WCAG, sondern das helle Theme.
  //
  // Ein fester Grenzwert würde hier an Stellen anschlagen, die es schon vor
  // dem dunklen Modus gab: die graue Uhrzeit an der Chat-Blase steht seit
  // jeher bei 2,7:1, die orange Testphasen-Plakette bei 2,7:1. Diese Zahlen zu
  // ändern wäre eine Designentscheidung und nicht Teil dieser Arbeit.
  //
  // Was der dunkle Modus dagegen schuldet, ist, nichts zu verschlechtern. Das
  // ist die Eigenschaft, die kaputtgehen kann, wenn jemand später eine Fläche
  // auf eine Theme-Farbe umstellt und den Text darauf vergisst — und genau die
  // steht hier.
  group('Der dunkle Modus ist nirgends schwächer als der helle', () {
    _bausteine.forEach((name, bauen) {
      testWidgets(name, (tester) async {
        final hell = await messen(tester, bauen, AppTheme.light);
        final dunkel = await messen(tester, bauen, AppTheme.dark);

        expect(hell, isNotEmpty,
            reason: '$name lieferte keinen messbaren Text — dann prüft dieser '
                'Test nichts.');
        expect(dunkel.keys.toSet(), equals(hell.keys.toSet()),
            reason: '$name zeigt in den beiden Themes verschiedenen Text; '
                'dann vergleicht der Test Äpfel mit Birnen.');

        final schlechter = <String>[];
        for (final eintrag in hell.entries) {
          final d = dunkel[eintrag.key]!;
          // Wo das helle Theme über AA liegt, muss das dunkle das auch — dass
          // es dabei von 17:1 auf 13:1 fällt, ist folgenlos und darf nicht
          // anschlagen. Wo das helle Theme schon darunter liegt, ist der helle
          // Wert selbst die Latte. 0,15 Toleranz gegen Rundung beim Rendern.
          final latte = math.min(eintrag.value, 4.5);
          if (d < latte - 0.15) {
            schlechter.add('"${eintrag.key}": hell '
                '${eintrag.value.toStringAsFixed(2)}:1 -> dunkel '
                '${d.toStringAsFixed(2)}:1');
          }
        }
        expect(schlechter, isEmpty, reason: schlechter.join('\n'));
      });
    });
  });
}
