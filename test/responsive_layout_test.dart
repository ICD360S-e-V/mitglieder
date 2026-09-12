// Rendert die echten Bausteine der App auf einer Matrix aus Fenstergrößen und
// prüft, dass nichts überläuft.
//
// Die Größen decken ab, was die App laut Plattform-Setup tatsächlich bekommen
// kann: mobil ist sie auf Hochformat festgenagelt (main.dart), auf dem Desktop
// erlaubt der windowManager ein Fenster bis herunter auf 800×600
// (desktop_platform_service.dart). Dazu kommt die System-Schriftgröße, die
// Android und iOS bis auf das Doppelte hochdrehen können.
//
// Der Test hängt bewusst dieselbe ResponsiveScaling in den Baum, die auch
// main.dart benutzt — sonst prüfte er eine Skalierung, die es in der App gar
// nicht gibt.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:icd360sev_mitglied/l10n/app_localizations.dart';
import 'package:icd360sev_mitglied/screens/anonymous_chat.dart';
import 'package:icd360sev_mitglied/screens/login.dart';
import 'package:icd360sev_mitglied/screens/mitglied_dashboard.dart';
import 'package:icd360sev_mitglied/screens/problem_help.dart';
import 'package:icd360sev_mitglied/screens/problem_report.dart';
import 'package:icd360sev_mitglied/screens/register.dart';
import 'package:icd360sev_mitglied/screens/welcome.dart';
import 'package:icd360sev_mitglied/screens/wizard_age_gate_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_intro_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_1a_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_2_screen.dart';
import 'package:icd360sev_mitglied/utils/app_theme.dart';
import 'package:icd360sev_mitglied/utils/responsive.dart';
import 'package:icd360sev_mitglied/services/api_service.dart';
import 'package:icd360sev_mitglied/widgets/benachrichtigungen_dialog.dart';
import 'package:icd360sev_mitglied/widgets/changelog_dialog.dart';
import 'package:icd360sev_mitglied/widgets/chat_input_area.dart';
import 'package:icd360sev_mitglied/widgets/debug_console.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_profile_dialog.dart';
import 'package:icd360sev_mitglied/widgets/new_ticket_dialog.dart';
import 'package:icd360sev_mitglied/widgets/personal_data_dialog.dart';
import 'package:icd360sev_mitglied/widgets/chat_message_bubble.dart';
import 'package:icd360sev_mitglied/widgets/dokumente_tab.dart';
import 'package:icd360sev_mitglied/widgets/member_calendar_view.dart';
import 'package:icd360sev_mitglied/widgets/mitgliedschaft_tab.dart';
import 'package:icd360sev_mitglied/widgets/verifizierung_tab.dart';
import 'package:icd360sev_mitglied/widgets/verwarnungen_tab.dart';
import 'package:icd360sev_mitglied/widgets/claudiu_login_coach.dart';
import 'package:icd360sev_mitglied/widgets/claudiu_welcome.dart';
import 'package:icd360sev_mitglied/widgets/conversation_list_item.dart';
import 'package:icd360sev_mitglied/widgets/diagnostic_consent_dialog.dart';
import 'package:icd360sev_mitglied/widgets/icd360s_header.dart';
import 'package:icd360sev_mitglied/widgets/legal_footer.dart';
import 'package:icd360sev_mitglied/widgets/login_tab.dart';
import 'package:icd360sev_mitglied/widgets/update_dialog.dart';
import 'package:icd360sev_mitglied/widgets/wizard_step_shell.dart';
import 'package:icd360sev_mitglied/services/ntfy_service.dart';
import 'package:icd360sev_mitglied/services/update_service.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_appbar.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_banners.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_cards.dart';
import 'package:icd360sev_mitglied/widgets/mitglied_sidebar.dart';
import 'package:icd360sev_mitglied/widgets/remote_consent_dialog.dart';
import 'package:icd360sev_mitglied/widgets/signatur_card.dart';
import 'package:icd360sev_mitglied/screens/language_selection.dart';
import 'package:icd360sev_mitglied/screens/signatur_screen.dart';
import 'package:icd360sev_mitglied/screens/webview_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_screen.dart';

import 'support/fake_webview_platform.dart';
import 'package:icd360sev_mitglied/screens/wizard_document_accept_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_duplicate_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_final_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_1b1_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_1b_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_1c_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_1d_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_1e_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_1f_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_3_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_4_screen.dart';
import 'package:icd360sev_mitglied/screens/wizard_stufe_5_screen.dart';
import 'package:icd360sev_mitglied/services/ticket_service.dart';
import 'package:icd360sev_mitglied/services/wizard_service.dart';
import 'package:icd360sev_mitglied/widgets/approval_waiting_dialog.dart';
import 'package:icd360sev_mitglied/widgets/benachrichtigung_consent_dialog.dart';
import 'package:icd360sev_mitglied/widgets/chat_attachment_item.dart';
import 'package:icd360sev_mitglied/widgets/chat_header.dart';
import 'package:icd360sev_mitglied/widgets/chat_image_attachment.dart';
import 'package:icd360sev_mitglied/widgets/chat_pending_attachments.dart';
import 'package:icd360sev_mitglied/widgets/file_viewer.dart';
import 'package:icd360sev_mitglied/widgets/incoming_call_dialog.dart';
import 'package:icd360sev_mitglied/widgets/linkified_text.dart';
import 'package:icd360sev_mitglied/widgets/live_chat_dialog.dart';
import 'package:icd360sev_mitglied/widgets/member_ticket_details_dialog.dart';
import 'package:icd360sev_mitglied/widgets/mitglieder_device.dart';
import 'package:icd360sev_mitglied/widgets/native_call_screen.dart';
import 'package:icd360sev_mitglied/widgets/profile_dialog.dart';
import 'package:icd360sev_mitglied/widgets/remote_sharing_banner.dart';
import 'package:icd360sev_mitglied/widgets/video_call_screen.dart';

/// Fenstergrößen, die auf den unterstützten Plattformen wirklich vorkommen.
const Map<String, Size> _geraete = <String, Size>{
  // Android/iOS, Hochformat erzwungen.
  'Telefon klein 320×568': Size(320, 568),
  'Telefon 360×640': Size(360, 640),
  'Telefon 390×844': Size(390, 844),
  'Telefon groß 412×915': Size(412, 915),
  'Tablet 800×1280': Size(800, 1280),
  // Windows/macOS/Linux: kleinstes zugelassenes Fenster und ein großer Monitor.
  'Desktop Minimum 800×600': Size(800, 600),
  'Desktop 1920×1080': Size(1920, 1080),
};

/// Der ungünstigste Fall: schmalstes Gerät, größte Systemschrift.
const Size _engstesGeraet = Size(320, 568);
const double _groessteSystemschrift = 2.0;

/// Der häufigste Fall unter den Bedienungshilfen: ein ganz gewöhnliches
/// Telefon, auf dem jemand die Schrift auf 200 % gestellt hat, weil er sonst
/// nichts lesen kann. Kein Randfall — genau so benutzen sehbehinderte
/// Mitglieder die App.
const Size _gewoehnlichesGeraet = Size(390, 844);

/// Schriftgröße ist nicht die einzige Stellschraube: Android hat daneben die
/// *Anzeigegröße*, und wer schlecht sieht, dreht beide hoch. Sie ändert nicht
/// die Schrift, sondern die Dichte — das Gerät meldet der App dann weniger dp.
/// Auf der höchsten Stufe bleiben rund 77 % übrig: aus einem 360×800er Telefon
/// der Galaxy-A-Klasse werden 277×616 dp.
///
/// Das ist schmaler als jedes andere Gerät hier und kein konstruierter Fall —
/// es ist die Einstellung, die ein sehbehindertes Mitglied am Ende fährt.
const Size _geraetMitGrosserAnzeige = Size(277, 616);

Widget _app(Widget home, {ThemeData? theme}) {
  return MaterialApp(
    locale: const Locale('de'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    // Dasselbe Theme wie main.dart. Ohne das lief der Test gegen Flutters
    // Standardfarben und hätte einen Layoutfehler, der erst durch die
    // Schriftgrößen oder Abstände des echten Themes entsteht, nie gesehen.
    theme: theme ?? AppTheme.light,
    builder: (context, child) =>
        ResponsiveScaling(child: child ?? const SizedBox.shrink()),
    home: home,
  );
}

Future<void> _pumpAt(
  WidgetTester tester,
  Size size,
  Widget home, {
  double textScale = 1.0,
  ThemeData? theme,
}) async {
  SharedPreferences.setMockInitialValues({});
  FakeWebViewPlatform.install();
  tester.view.devicePixelRatio = 2.0;
  tester.view.physicalSize = size * 2.0;
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

  await tester.pumpWidget(_app(home, theme: theme));
  // Einmal über die Einblend-Animationen hinweg, damit auch der Endzustand
  // gelayoutet wird und nicht nur das erste Frame.
  await tester.pump(const Duration(milliseconds: 800));
}

/// Wertet aus, was beim Rendern schiefgegangen ist — und räumt den Baum ab.
///
/// Das Abräumen ist nötig, weil die Einblendanimationen (flutter_animate) sonst
/// Timer offen lassen und die Testumgebung „Pending timers" meldet. Das ist ein
/// Artefakt der Testumgebung und hat mit dem Layout nichts zu tun.
Future<void> _erwarteFehlerfreiesLayout(WidgetTester tester) async {
  final fehler = tester.takeException();
  await tester.pumpWidget(const SizedBox.shrink());
  // Das Dashboard startet den Push-Dienst; dessen Wiederverbindung steht als
  // Timer in der Warteschlange. stop() setzt nur das Flag, der Timer selbst
  // läuft noch — also die Uhr darüber hinweg drehen, damit er verpufft.
  NtfyService().stop();
  await tester.pump(const Duration(seconds: 10));
  expect(fehler, isNull);
}

/// Ein Baustein wird in eine scrollbare Seite gesetzt: geprüft wird die
/// Anpassung an die *Breite*. Wer in der Höhe nicht passt, scrollt in der App
/// genauso.
Widget _aufSeite(Widget child) {
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    ),
  );
}

final Map<String, Widget Function()> _bausteine = <String, Widget Function()>{
  'PersonalDataCard': () => _aufSeite(PersonalDataCard(onUpdate: () {})),
  'BeitragCard': () => _aufSeite(
        const BeitragCard(
          isLoading: false,
          beitragBezahlt: false,
          beitragJahr: 2026,
        ),
      ),
  'WelcomeCard': () => _aufSeite(
        const WelcomeCard(
          userName: 'Maximilian Freiherr von Habsburg',
          greeting: 'Guten Morgen',
        ),
      ),
  'MeineTerminePlaceholder': () =>
      Scaffold(body: MeineTerminePlaceholder(onRefresh: () {})),
  'TrialWarningBanner': () => _aufSeite(
        TrialWarningBanner(daysRemaining: 3, trialEndsAt: DateTime(2026, 9, 1)),
      ),
  'Icd360sHeader': () => _aufSeite(const Icd360sHeader()),
  'Icd360sHeader kompakt': () => _aufSeite(const Icd360sHeader(compact: true)),
  'SignaturCard': () =>
      _aufSeite(SignaturCard(offen: 2, onOeffnen: () {})),
  'ClaudiuWelcome': () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Builder(
              builder: (context) =>
                  ClaudiuWelcome(scale: Responsive.uiScale(context)),
            ),
          ),
        ),
      ),
  'ChatMessageBubble fremd': () => _aufSeite(
        ChatMessageBubble(
          message: const {
            'sender_name': 'Vorsitzender Bartholomäus',
            'message': 'Guten Tag, Ihre Unterlagen sind vollständig angekommen.',
            'created_at': '2026-08-09T10:15:00',
            'status': 'read',
          },
          isOwn: false,
          onDownloadAttachment: (_) {},
        ),
      ),
  'ChatMessageBubble eigen': () => _aufSeite(
        ChatMessageBubble(
          message: const {
            'message': 'Vielen Dank für die schnelle Rückmeldung!',
            'created_at': '2026-08-09T10:16:00',
            'status': 'read',
          },
          isOwn: true,
          onDownloadAttachment: (_) {},
        ),
      ),
  'MitgliedSidebar': () => Scaffold(
        body: Row(
          children: [
            MitgliedSidebar(
              userName: 'Maximilian',
              selectedIndex: 0,
              onIndexChanged: (_) {},
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
  'LegalFooter': () => _aufSeite(const LegalFooter()),
  'ClaudiuLoginCoach': () => _aufSeite(
        const ClaudiuLoginCoach(
          digitCount: 3,
          isLoading: false,
          errorMessage: 'Die Mitgliedsnummer ist unbekannt.',
        ),
      ),
  'LoginTab': () => _aufSeite(
        LoginTab(
          mitgliedernummerController: TextEditingController(text: '360'),
          isLoading: false,
          errorMessage: 'Anmeldung fehlgeschlagen.',
          onLogin: () {},
        ),
      ),
  'ConversationListItem': () => _aufSeite(
        ConversationListItem(
          conversation: const {
            'id': 1,
            'name': 'Vorsitzender Bartholomäus',
            'last_message': 'Ihre Unterlagen sind vollständig angekommen.',
            'unread_count': 4,
            'updated_at': '2026-08-09T10:15:00',
          },
          isSelected: true,
          hasActiveCall: true,
          onTap: () {},
        ),
      ),
  'WizardStepShell': () => WizardStepShell(
        stepLabel: 'Schritt 3 von 8',
        prompt: 'Bitte geben Sie Ihre Staatsangehörigkeit an.',
        onBack: () {},
        onNext: () {},
        child: const TextField(),
      ),
  // Ganze Bildschirme. Sie rufen zwar Dienste auf, überstehen im Test aber den
  // fehlgeschlagenen Netzaufruf und rendern ihren Ausgangszustand — genau den,
  // den ein Mitglied beim Öffnen sieht.
  'WelcomeScreen': () => const WelcomeScreen(),
  'MitgliedDashboard': () => const MitgliedDashboard(
        userName: 'Maximilian Freiherr von Habsburg',
        mitgliedernummer: '360-1234',
        email: 'maximilian@example.invalid',
        status: 'active',
      ),
  'LoginPage': () => const LoginPage(),
  'RegisterPage': () => const RegisterPage(),
  'AnonymousChatScreen': () => const AnonymousChatScreen(),
  'ProblemHelpScreen': () => const ProblemHelpScreen(),
  'ProblemReportScreen': () => const ProblemReportScreen(),
  // Registerkarten des Profils und die Terminübersicht: laden ihre Daten vom
  // Server, rendern im Test also den Ausgangs- bzw. Leerzustand.
  'MemberCalendarView': () =>
      const Scaffold(body: MemberCalendarView(mitgliedernummer: '360-1234')),
  'DokumenteTab': () => const Scaffold(body: DokumenteTab()),
  'MitgliedschaftTab': () =>
      const Scaffold(body: MitgliedschaftTab(mitgliedernummer: '360-1234')),
  'VerifizierungTab': () =>
      const Scaffold(body: VerifizierungTab(mitgliedernummer: '360-1234')),
  'VerwarnungenTab': () => const Scaffold(body: VerwarnungenTab()),
  'ChatInputArea': () => Scaffold(
        body: Column(
          children: [
            const Spacer(),
            ChatInputArea(
              controller: TextEditingController(),
              isSending: false,
              isUploading: false,
              onSend: () {},
              onPickFiles: () {},
              hintText: 'Nachricht an den Vorstand schreiben …',
            ),
          ],
        ),
      ),
  // Registrierungsassistent: der Einstieg, die Altersgrenze und zwei
  // Formularschritte — sie tragen dieselbe WizardStepShell wie die übrigen.
  'WizardIntroScreen': () => WizardIntroScreen(onStart: () {}),
  'WizardAgeGateScreen': () => WizardAgeGateScreen(age: 13, onExit: () {}),
  'WizardStufe1aScreen': () =>
      WizardStufe1aScreen(onNext: () {}, onBack: () {}),
  'WizardStufe2Screen': () => WizardStufe2Screen(onNext: () {}, onBack: () {}),
  // Die übrigen Assistentenschritte. Sie holen ihren Entwurf vom Server und
  // zeigen im Test den leeren Ausgangszustand — das Gerüst, die Eingabefelder
  // und die Fußleiste sind dabei vollständig gelayoutet.
  'WizardScreen': () => const WizardScreen(),
  'WizardStufe1bScreen': () =>
      WizardStufe1bScreen(onAdvance: (_, {duplicateAction}) {}, onBack: () {}),
  'WizardStufe1b1Screen': () =>
      WizardStufe1b1Screen(onNext: () {}, onBack: () {}),
  'WizardStufe1cScreen': () => WizardStufe1cScreen(onNext: () {}, onBack: () {}),
  'WizardStufe1dScreen': () => WizardStufe1dScreen(onNext: () {}, onBack: () {}),
  'WizardStufe1eScreen': () => WizardStufe1eScreen(onNext: () {}, onBack: () {}),
  'WizardStufe1fScreen': () => WizardStufe1fScreen(onNext: () {}, onBack: () {}),
  'WizardStufe3Screen': () => WizardStufe3Screen(onNext: () {}, onBack: () {}),
  'WizardStufe4Screen': () => WizardStufe4Screen(onNext: () {}, onBack: () {}),
  'WizardStufe5Screen': () => WizardStufe5Screen(onNext: () {}, onBack: () {}),
  'WizardDuplicateScreen': () => WizardDuplicateScreen(
        action: WizardDuplicateAction.login,
        onClose: () {},
      ),
  'WizardFinalScreen': () => WizardFinalScreen(
        result: const WizardFinalizeResult(
          mitgliedernummer: '360-1234',
          userId: 7,
          status: 'neu',
          isMinor: false,
          message: 'Ihr Antrag ist eingegangen und wird geprüft.',
        ),
        onClose: () {},
      ),
  'WizardDocumentAcceptScreen': () => WizardDocumentAcceptScreen(
        stepNumber: 6,
        step: WizardStep.stufe6,
        dataKey: 'satzung_read',
        documentName: 'Satzung',
        url: 'https://icd360s.de/satzung360s/',
        onNext: () {},
        onBack: () {},
      ),
  'LanguageSelectionScreen': () => const LanguageSelectionScreen(),
  // Der eingebettete Browser für Satzung, Impressum und Datenschutz. Geprüft
  // wird das Gerüst darum herum — Titelleiste mit fünf Schaltflächen,
  // Fortschrittsbalken, Adresszeile; die Seite selbst rendert im Test eine
  // leere Fläche (siehe FakeWebViewPlatform).
  'WebViewScreen': () => const WebViewScreen(
        title: 'Widerrufsbelehrung',
        url: 'https://icd360s.de/widerrufsrecht',
      ),
  'SignaturScreen': () => SignaturScreen(apiService: ApiService()),
  // Anruf- und Chatoberflächen.
  'InCallOverlay': () => InCallOverlay(
        remoteName: 'Vorsitzender Bartholomäus',
        callDuration: const Duration(minutes: 3, seconds: 12),
        isMuted: false,
        isSpeakerOn: true,
        onToggleMute: () {},
        onToggleSpeaker: () {},
        onEndCall: () {},
      ),
  'CallingOverlay': () =>
      CallingOverlay(targetName: 'Vorstand', onCancel: () {}),
  'NativeCallScreen': () => NativeCallScreen(
        remoteName: 'Vorsitzender Bartholomäus',
        isActive: true,
        callDuration: const Duration(minutes: 1),
        isMuted: false,
        isSpeakerOn: false,
        onToggleMute: () {},
        onToggleSpeaker: () {},
        onEndCall: () {},
      ),
  'VideoCallScreen': () => const VideoCallScreen(remoteName: 'Vorstand'),
  'ConversationHeader': () => _aufSeite(
        ConversationHeader(
          conversation: const {
            'member_name': 'Maximilian Freiherr von Habsburg',
            'mitgliedernummer': '360-1234',
            'status': 'open',
          },
          canCall: true,
          isOpen: true,
          onCall: () {},
          onClose: () {},
        ),
      ),
  'TypingIndicator': () =>
      _aufSeite(const TypingIndicator(userName: 'Vorsitzender Bartholomäus')),
  'ChatAttachmentItem': () => _aufSeite(
        ChatAttachmentItem(
          attachment: const {
            'filename': 'Mitgliedsantrag_unterschrieben.pdf',
            'extension': 'pdf',
            'size': 240000,
          },
          isOwn: false,
          onDownload: (_) {},
        ),
      ),
  'ChatPendingAttachments': () => _aufSeite(
        ChatPendingAttachments(
          files: [File('unterlagen.pdf')],
          onRemove: (_) {},
        ),
      ),
  'ChatImageAttachment': () => _aufSeite(
        const ChatImageAttachment(
          attachment: {'filename': 'foto.jpg', 'id': 3},
          mitgliedernummer: '360-1234',
        ),
      ),
  'FileViewer': () =>
      FileViewer(file: File('unterlagen.pdf'), filename: 'unterlagen.pdf'),
  'MitgliederDeviceWidget': () => _aufSeite(
        MitgliederDeviceWidget(
          sessions: const [],
          // Ein Gerät mit den Werten, um die es geht: größte Anzeigegröße
          // (277 dp statt 360) und 200 % Schrift. Mit leerer Liste hätte der
          // Test die beiden neuen Zeilen nie gerendert.
          devices: const [
            {
              'device_name': 'samsung SM-A536B',
              'platform': 'Android 14 (SDK 34)',
              'device_type': 'phone',
              'app_version': '1.92.0',
              'os_version': 'Android 14 (SDK 34, Patch 2026-08-01)',
              'screen_width_dp': 277,
              'screen_height_dp': 616,
              'device_pixel_ratio': 2.75,
              'text_scale': 2.0,
              'battery_level': 64,
              'battery_state': 'discharging',
              'connection_type': 'wifi',
              'last_validated': '2026-09-11 08:15:00',
            },
          ],
          isLoading: false,
          onRevokeSession: (_) {},
        ),
      ),
  'RemoteSharingBanner': () => _aufSeite(const RemoteSharingBanner()),
  'LinkifiedText': () => _aufSeite(
        const LinkifiedText(
          'Die Satzung finden Sie unter https://icd360s.de/satzung360s/',
          style: TextStyle(fontSize: 14),
        ),
      ),
  'MitgliedAppBar': () => Scaffold(
        appBar: MitgliedAppBar(
          mitgliedernummer: '360-1234',
          status: 'active',
          unreadChatCount: 12,
          unreadTicketCount: 3,
          pendingTerminCount: 5,
          ungeleseneBenachrichtigungen: 9,
          onHome: () {},
          onTermine: () {},
          onTickets: () {},
          onLiveChat: () {},
          onNotifications: () {},
          onProfile: () {},
        ),
        body: const SizedBox.shrink(),
      ),
};

void main() {
  group('Bausteine passen sich der Fenstergröße an', () {
    _bausteine.forEach((name, bauen) {
      _geraete.forEach((geraet, size) {
        testWidgets('$name — $geraet', (tester) async {
          await _pumpAt(tester, size, bauen());
          await _erwarteFehlerfreiesLayout(tester);
        });
      });

      testWidgets('$name — engstes Gerät, größte Systemschrift',
          (tester) async {
        await _pumpAt(
          tester,
          _engstesGeraet,
          bauen(),
          textScale: _groessteSystemschrift,
        );
        await _erwarteFehlerfreiesLayout(tester);
      });

      testWidgets('$name — gewöhnliches Telefon, größte Systemschrift',
          (tester) async {
        await _pumpAt(
          tester,
          _gewoehnlichesGeraet,
          bauen(),
          textScale: _groessteSystemschrift,
        );
        await _erwarteFehlerfreiesLayout(tester);
      });

      testWidgets('$name — größte Anzeige und größte Systemschrift',
          (tester) async {
        await _pumpAt(
          tester,
          _geraetMitGrosserAnzeige,
          bauen(),
          textScale: _groessteSystemschrift,
        );
        await _erwarteFehlerfreiesLayout(tester);
      });

      // Derselbe Baustein, andere Palette. Fängt das ab, was beim Umstellen
      // auf Theme-Farben schiefgehen kann: eine Hilfsmethode ohne
      // BuildContext, ein `const`, das eine Farbe aus dem Theme einschließt,
      // ein Extension-Zugriff außerhalb des Themes.
      testWidgets('$name — dunkler Modus', (tester) async {
        await _pumpAt(tester, const Size(390, 844), bauen(),
            theme: AppTheme.dark);
        await _erwarteFehlerfreiesLayout(tester);
      });
    });
  });

  group('Dialoge passen ins Fenster', () {
    Future<void> zeige(WidgetTester tester, Size size, Widget Function() bauen,
        {double textScale = 1.0, ThemeData? theme}) async {
      final dialog = bauen();
      await _pumpAt(
        tester,
        size,
        Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () =>
                    showDialog<void>(context: context, builder: (_) => dialog),
                child: const Text('auf'),
              ),
            ),
          ),
        ),
        textScale: textScale,
        theme: theme,
      );
      await tester.tap(find.text('auf'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
    }

    // Erst im Test gebaut, nicht beim Aufbau der Gruppe: ApiService legt im
    // Konstruktor einen HttpClient an, und das geht außerhalb einer Testzone
    // nicht.
    final dialoge = <String, Widget Function()>{
      'RemoteConsentDialog': () => RemoteConsentDialog(
        controllerName: 'Vorsitzender Bartholomäus',
        onAccept: () {},
        onDecline: () {},
      ),
      'DiagnosticConsentDialog': () => const DiagnosticConsentDialog(),
      // Die Dialoge mit fester Wunschgröße — genau die, die auf einem Telefon
      // vorher über den Rand hinausstanden.
      'MitgliedProfileDialog': () => MitgliedProfileDialog(
        userName: 'Maximilian Freiherr von Habsburg',
        mitgliedernummer: '360-1234',
        email: 'maximilian@example.invalid',
        status: 'active',
        apiService: ApiService(),
        onEmailChanged: (_) {},
      ),
      'BenachrichtigungenDialog': () =>
          BenachrichtigungenDialog(apiService: ApiService()),
      'PersonalDataDialog': () => const PersonalDataDialog(
        userName: 'Maximilian Freiherr von Habsburg',
        mitgliedernummer: '360-1234',
      ),
      'NewTicketDialog': () =>
          const NewTicketDialog(mitgliedernummer: '360-1234'),
      'ChangelogDialog': () => const ChangelogDialog(),
      'ApprovalWaitingDialog': () => ApprovalWaitingDialog(
            requestToken: 'abc123',
            memberName: 'Maximilian Freiherr von Habsburg',
            expiresAt: '2026-09-01T10:00:00',
            onApproved: (_) {},
            onDenied: () {},
            onExpired: () {},
          ),
      'BenachrichtigungConsentDialog': () =>
          BenachrichtigungConsentDialog(apiService: ApiService()),
      'ProfileDialog': () => ProfileDialog(
            userName: 'Maximilian Freiherr von Habsburg',
            mitgliedernummer: '360-1234',
            email: 'maximilian@example.invalid',
            role: 'mitglied',
            apiService: ApiService(),
            onEmailChanged: (_) {},
          ),
      'LiveChatDialog': () => const LiveChatDialog(
            mitgliedernummer: '360-1234',
            userName: 'Maximilian Freiherr von Habsburg',
          ),
      'MemberTicketDetailsDialog': () => MemberTicketDetailsDialog(
            ticket: Ticket(
              id: 1,
              mitgliedernummer: '360-1234',
              subject: 'Beitragsbescheinigung fehlt',
              message: 'Guten Tag, mir fehlt die Bescheinigung für 2026.',
              status: 'open',
              priority: 'medium',
              createdAt: DateTime(2026, 8, 1),
            ),
            mitgliedernummer: '360-1234',
          ),
      'DebugConsole': () => const DebugConsole(),
      'UpdateDialog': () => UpdateDialog(
        updateInfo: UpdateInfo(
          version: '2.4.0',
          buildNumber: 240,
          downloadUrl: 'https://example.invalid/app.apk',
          changelog: 'Behobene Fehler in der Terminverwaltung.\n'
              'Neue Übersicht für Beiträge.\n'
              'Schnellere Anmeldung.',
          forceUpdate: false,
        ),
      ),
    };

    dialoge.forEach((name, bauen) {
      _geraete.forEach((geraet, size) {
        testWidgets('$name — $geraet', (tester) async {
          await zeige(tester, size, bauen);
          await _erwarteFehlerfreiesLayout(tester);
        });
      });

      testWidgets('$name — engstes Gerät, größte Systemschrift',
          (tester) async {
        await zeige(tester, _engstesGeraet, bauen,
            textScale: _groessteSystemschrift);
        await _erwarteFehlerfreiesLayout(tester);
      });

      testWidgets('$name — gewöhnliches Telefon, größte Systemschrift',
          (tester) async {
        await zeige(tester, _gewoehnlichesGeraet, bauen,
            textScale: _groessteSystemschrift);
        await _erwarteFehlerfreiesLayout(tester);
      });

      testWidgets('$name — größte Anzeige und größte Systemschrift',
          (tester) async {
        await zeige(tester, _geraetMitGrosserAnzeige, bauen,
            textScale: _groessteSystemschrift);
        await _erwarteFehlerfreiesLayout(tester);
      });

      testWidgets('$name — dunkler Modus', (tester) async {
        await zeige(tester, const Size(390, 844), bauen,
            theme: AppTheme.dark);
        await _erwarteFehlerfreiesLayout(tester);
      });
    });
  });
}
