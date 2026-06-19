import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/login.dart';
import '../screens/problem_help.dart';
import '../screens/register.dart';
import '../services/language_service.dart';

/// Conversational welcome surface — replaces the static button stack on
/// WelcomeScreen with a chat-style flow centred on the Claudiu mascot.
///
/// Timeline (fixed; runs to completion every welcome entry):
///   T+0       Mascot slides in from the right (1.5s, easeOutCubic).
///   T+2s      Speech bubble fades in; greeting types out via
///             [TypewriterAnimatedText] over ~2s.
///   T+9s      The four option pills cascade in (200ms stagger, fade+
///             slide, via [flutter_animate]'s declarative API).
///
/// The visible character is a Material placeholder icon for now; once
/// the commissioned SVG/Lottie/Rive of "boy in wheelchair" lands at
/// `assets/mascot/claudiu.*` only [_mascot] needs updating. Per the
/// 2026 Flutter mascot guide the long-term target is a Rive state
/// machine (idle / wave / look-around states) — we ship the static
/// placeholder + scripted reveal first and swap the asset in v2.
///
/// TTS deliberately deferred: Linux espeak voices are robotic and a
/// first-launch greeting that sounds artificial would undermine the
/// warmth this whole flow is here to convey.
class ClaudiuWelcome extends StatelessWidget {
  final double scale;
  const ClaudiuWelcome({super.key, this.scale = 1.0});

  // --- Timing anchors (deliberate; user-specified 9s on options). ---
  static const Duration _entranceDur = Duration(milliseconds: 1500);
  static const Duration _bubbleDelay = Duration(seconds: 2);
  static const Duration _typewriterDur = Duration(milliseconds: 2000);
  static const Duration _optionsDelay = Duration(seconds: 9);
  static const Duration _optionStagger = Duration(milliseconds: 200);
  static const Duration _optionDur = Duration(milliseconds: 350);

  // ---------------------------------------------------------------------------
  // Per-language string table. Inline (vs. .arb) until copy stabilises; once
  // it does, migrate to AppLocalizations across all 28 ARB files. English is
  // the implicit fallback for any unknown language code.
  // ---------------------------------------------------------------------------

  static const Map<String, _ClaudiuStrings> _strings = {
    'ro': _ClaudiuStrings(
      morning: 'Bună dimineața',
      day: 'Bună ziua',
      evening: 'Bună seara',
      night: 'Bună seara',
      visitor: 'drag vizitator',
      ask: 'Cu ce te pot ajuta?',
      becomeMember: 'Vreau să devin membru',
      login: 'Sunt deja membru și vreau să mă autentific',
      problem: 'Am o problemă cu aplicația',
      emergency: 'Urgență — sună-ne',
      claudiuName: 'Claudiu',
      emergencyIntro: 'Înainte să suni — programul nostru de lucru:',
      scheduleOffice: 'La birou',
      scheduleField: 'Pe teren cu clienții',
      outsideHoursNote:
          'În afara acestui program preluăm doar urgențele. Poți să ne și scrii la același număr — te contactăm noi.',
      callNow: 'Sună-ne acum',
      sendSms: 'Trimite SMS',
      smsBody:
          'Urgență ICD360S e.V. — vă rog să mă contactați cât mai curând.',
      closeButton: 'Închide',
    ),
    'de': _ClaudiuStrings(
      morning: 'Guten Morgen',
      day: 'Hallo',
      evening: 'Guten Abend',
      night: 'Guten Abend',
      visitor: 'lieber Besucher',
      ask: 'Wie kann ich dir helfen?',
      becomeMember: 'Ich möchte Mitglied werden',
      login: 'Ich bin bereits Mitglied und möchte mich anmelden',
      problem: 'Ich habe ein Problem mit der App',
      emergency: 'Notfall — ruf uns an',
      claudiuName: 'Claudiu',
      emergencyIntro: 'Bevor du anrufst — unsere Geschäftszeiten:',
      scheduleOffice: 'Im Büro',
      scheduleField: 'Beim Klienten vor Ort',
      outsideHoursNote:
          'Außerhalb dieser Zeiten nehmen wir nur Notfälle entgegen. Du kannst uns auch eine SMS schicken — wir melden uns zurück.',
      callNow: 'Jetzt anrufen',
      sendSms: 'SMS senden',
      smsBody:
          'Notfall ICD360S e.V. — bitte ruft mich so schnell wie möglich zurück.',
      closeButton: 'Schließen',
    ),
    'en': _ClaudiuStrings(
      morning: 'Good morning',
      day: 'Hello',
      evening: 'Good evening',
      night: 'Good evening',
      visitor: 'dear visitor',
      ask: 'How can I help you?',
      becomeMember: 'I want to become a member',
      login: "I'm already a member and want to sign in",
      problem: 'I have a problem with the app',
      emergency: 'Emergency — call us',
      claudiuName: 'Claudiu',
      emergencyIntro: 'Before you call — our office hours:',
      scheduleOffice: 'At the office',
      scheduleField: 'On the field with our clients',
      outsideHoursNote:
          "Outside these hours we only handle emergencies. You can also text the same number — we'll get back to you.",
      callNow: 'Call us now',
      sendSms: 'Send SMS',
      smsBody:
          'Emergency at ICD360S e.V. — please contact me as soon as possible.',
      closeButton: 'Close',
    ),
    'ru': _ClaudiuStrings(
      morning: 'Доброе утро',
      day: 'Здравствуйте',
      evening: 'Добрый вечер',
      night: 'Добрый вечер',
      visitor: 'дорогой гость',
      ask: 'Чем я могу помочь?',
      becomeMember: 'Я хочу стать членом',
      login: 'Я уже член и хочу войти',
      problem: 'У меня проблема с приложением',
      emergency: 'Срочно — позвоните нам',
      claudiuName: 'Клаудиу',
      emergencyIntro: 'Прежде чем звонить — наш график работы:',
      scheduleOffice: 'В офисе',
      scheduleField: 'На выезде с клиентами',
      outsideHoursNote:
          'Вне этого времени мы принимаем только срочные обращения. Можно также отправить SMS — мы свяжемся с вами.',
      callNow: 'Позвонить сейчас',
      sendSms: 'Отправить SMS',
      smsBody:
          'Срочно, ICD360S e.V. — пожалуйста, свяжитесь со мной как можно скорее.',
      closeButton: 'Закрыть',
    ),
    'uk': _ClaudiuStrings(
      morning: 'Доброго ранку',
      day: 'Вітаю',
      evening: 'Доброго вечора',
      night: 'Доброго вечора',
      visitor: 'дорогий відвідувачу',
      ask: 'Чим я можу допомогти?',
      becomeMember: 'Я хочу стати членом',
      login: 'Я вже член і хочу увійти',
      problem: 'У мене проблема з застосунком',
      emergency: 'Терміново — зателефонуйте нам',
      claudiuName: 'Клаудіу',
      emergencyIntro: 'Перш ніж телефонувати — наш робочий графік:',
      scheduleOffice: 'В офісі',
      scheduleField: 'На виїзді з клієнтами',
      outsideHoursNote:
          'Поза цим часом ми приймаємо лише термінові звернення. Можна також надіслати SMS — ми зв\'яжемося з вами.',
      callNow: 'Зателефонувати зараз',
      sendSms: 'Надіслати SMS',
      smsBody:
          'Терміново, ICD360S e.V. — зв\'яжіться зі мною якнайшвидше.',
      closeButton: 'Закрити',
    ),
  };

  static _ClaudiuStrings _stringsFor(String code) =>
      _strings[code] ?? _strings['en']!;

  /// 5–12 → morning, 12–18 → day, 18–22 → evening, otherwise → night.
  static String _timeGreeting(_ClaudiuStrings s) {
    final h = DateTime.now().hour;
    if (h >= 5 && h < 12) return s.morning;
    if (h >= 12 && h < 18) return s.day;
    if (h >= 18 && h < 22) return s.evening;
    return s.night;
  }

  @override
  Widget build(BuildContext context) {
    final code = LanguageService.instance.currentCode;
    final s = _stringsFor(code);
    final greeting = '${_timeGreeting(s)}, ${s.visitor}!';

    final options = <_OptionData>[
      _OptionData(Icons.person_add_alt_1, s.becomeMember, false, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegisterPage()),
        );
      }),
      _OptionData(Icons.login, s.login, false, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }),
      _OptionData(Icons.bug_report_outlined, s.problem, false, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProblemHelpScreen()),
        );
      }),
      _OptionData(Icons.phone_in_talk, s.emergency, true, () {
        _showEmergencySheet(context, s);
      }),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Claudiu rolls in from the right: 1.5s easeOutCubic slide.
              _mascot(scale).animate().slideX(
                    begin: 1.6,
                    end: 0,
                    duration: _entranceDur,
                    curve: Curves.easeOutCubic,
                  ),
              SizedBox(width: 12 * scale),
              // Bubble holds until 2s after page open, then fades in.
              Expanded(
                child: _bubble(s, greeting, scale)
                    .animate()
                    .fadeIn(delay: _bubbleDelay, duration: 400.ms),
              ),
            ],
          ),
        ),
        SizedBox(height: 24 * scale),

        // Option list waits a full 9s after page open, then cascades.
        // Each option's delay = 9s + (index × 200ms); fade + slide-up are
        // a single chained expression — the entire scripted animation
        // contract is expressed declaratively rather than in
        // AnimationController/Timer state.
        for (var i = 0; i < options.length; i++) ...[
          _option(options[i], scale).animate().fadeIn(
                delay: _optionsDelay + _optionStagger * i,
                duration: 300.ms,
              ).slideY(
                begin: 0.25,
                end: 0,
                delay: _optionsDelay + _optionStagger * i,
                duration: _optionDur,
                curve: Curves.easeOut,
              ),
          if (i < options.length - 1) SizedBox(height: 10 * scale),
        ],
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Mascot — circle frame around a Material placeholder. The entire
  // entrance animation is applied by the caller, so this widget is just
  // the static visual; when the Rive/Lottie/SVG of Claudiu arrives, swap
  // the Icon for an `RiveAnimation.asset(...)` here and nothing else
  // needs touching.
  // ---------------------------------------------------------------------------

  Widget _mascot(double scale) {
    return Container(
      width: 88 * scale,
      height: 88 * scale,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.accessible_forward,
        size: 52 * scale,
        color: Colors.white,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Speech bubble. Greeting uses TypewriterAnimatedText from
  // animated_text_kit — battle-tested, handles glyph clusters / RTL
  // properly which my AnimatedBuilder + substring hack did not.
  // ---------------------------------------------------------------------------

  Widget _bubble(_ClaudiuStrings s, String greeting, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 12 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(4),
          topRight: Radius.circular(16 * scale),
          bottomLeft: Radius.circular(16 * scale),
          bottomRight: Radius.circular(16 * scale),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                greeting,
                speed: Duration(
                  // Per-character speed: total ≈ _typewriterDur. Floor at
                  // 30ms so very short greetings don't blink past.
                  milliseconds: (_typewriterDur.inMilliseconds /
                          greeting.length)
                      .floor()
                      .clamp(30, 120),
                ),
                textStyle: TextStyle(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0d47a1),
                  height: 1.3,
                ),
              ),
            ],
          ),
          SizedBox(height: 4 * scale),
          Text(
            s.ask,
            style: TextStyle(
              fontSize: 14 * scale,
              color: Colors.grey[800],
              height: 1.3,
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            '— ${s.claudiuName}',
            style: TextStyle(
              fontSize: 11 * scale,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Option pill.
  // ---------------------------------------------------------------------------

  Widget _option(_OptionData data, double scale) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 14 * scale,
          ),
          decoration: BoxDecoration(
            color: data.danger
                ? const Color(0xFFE57373).withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: data.danger
                  ? const Color(0xFFEF9A9A)
                  : Colors.white.withValues(alpha: 0.30),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(data.icon, color: Colors.white, size: 22 * scale),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  data.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.7),
                size: 20 * scale,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Side-effects.
  // ---------------------------------------------------------------------------

  static const String _supportPhone = '+4916094482053';

  /// Pretty form for the dialer / SMS app: spaces every 4 digits, makes
  /// it easier to read at a glance in the bottom-sheet card.
  static String get _supportPhoneDisplay => '+49 1609 4482053';

  /// Office windows shown to the user. Plain ASCII colon — kept here as
  /// constants so they're easy to find when the schedule changes.
  static const String _scheduleOfficeWindow = '10:00 – 12:00';
  static const String _scheduleFieldWindow  = '14:00 – 17:00';

  Future<void> _call() async {
    // tel: → system dialer (Phone on Android, FaceTime/Phone on iOS+macOS,
    // Phone Link on Windows, whatever handler is registered on Linux).
    // externalApplication forces the OS picker rather than letting iOS
    // try to open the URL in SFSafariViewController.
    final uri = Uri(scheme: 'tel', path: _supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sms(String body) async {
    // sms:+number?body=… is the supported scheme on every platform we
    // ship to (Android: handled by Messages, iOS: Messages, Linux/macOS/
    // Windows: KDE Connect / Phone Link forwards to the paired device).
    final uri = Uri.parse(
      'sms:$_supportPhone?body=${Uri.encodeQueryComponent(body)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Slide-in bottom sheet shown when the user taps the "Emergency" option.
  /// Replaces the silent tel: dial — the office hours are surfaced first
  /// so the caller knows whether they'll reach a human or after-hours
  /// emergency mode, and we offer SMS as an alternative for non-urgent
  /// callbacks.
  Future<void> _showEmergencySheet(
    BuildContext context,
    _ClaudiuStrings s,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0d47a1),
                Color(0xFF1565c0),
              ],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag handle.
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  // Mascot + bubble row.
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        child: const Icon(Icons.phone_in_talk,
                            color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14),
                            ),
                          ),
                          child: Text(
                            s.emergencyIntro,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0d47a1),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Office hours.
                  _scheduleRow(
                    icon: Icons.business_outlined,
                    label: s.scheduleOffice,
                    window: _scheduleOfficeWindow,
                  ),
                  const SizedBox(height: 10),
                  _scheduleRow(
                    icon: Icons.directions_walk,
                    label: s.scheduleField,
                    window: _scheduleFieldWindow,
                  ),
                  const SizedBox(height: 14),

                  // Outside-hours note.
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline,
                            color: Colors.amber.shade200, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            s.outsideHoursNote,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Call action.
                  _bigAction(
                    icon: Icons.phone_in_talk,
                    label: s.callNow,
                    sub: _supportPhoneDisplay,
                    onTap: () {
                      Navigator.of(sheetCtx).pop();
                      _call();
                    },
                  ),
                  const SizedBox(height: 10),
                  // SMS action.
                  _bigAction(
                    icon: Icons.sms_outlined,
                    label: s.sendSms,
                    sub: _supportPhoneDisplay,
                    onTap: () {
                      Navigator.of(sheetCtx).pop();
                      _sms(s.smsBody);
                    },
                  ),
                  const SizedBox(height: 14),

                  // Close.
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(sheetCtx).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            Colors.white.withValues(alpha: 0.85),
                      ),
                      child: Text(s.closeButton),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _scheduleRow({
    required IconData icon,
    required String label,
    required String window,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            window,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bigAction({
    required IconData icon,
    required String label,
    required String sub,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sub,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.7), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionData {
  final IconData icon;
  final String label;
  final bool danger;
  final VoidCallback onTap;
  const _OptionData(this.icon, this.label, this.danger, this.onTap);
}

class _ClaudiuStrings {
  final String morning;
  final String day;
  final String evening;
  final String night;
  final String visitor;
  final String ask;
  final String becomeMember;
  final String login;
  final String problem;
  final String emergency;
  final String claudiuName;
  // Emergency bottom sheet copy.
  final String emergencyIntro;
  final String scheduleOffice;
  final String scheduleField;
  final String outsideHoursNote;
  final String callNow;
  final String sendSms;
  final String smsBody;
  final String closeButton;

  const _ClaudiuStrings({
    required this.morning,
    required this.day,
    required this.evening,
    required this.night,
    required this.visitor,
    required this.ask,
    required this.becomeMember,
    required this.login,
    required this.problem,
    required this.emergency,
    required this.claudiuName,
    required this.emergencyIntro,
    required this.scheduleOffice,
    required this.scheduleField,
    required this.outsideHoursNote,
    required this.callNow,
    required this.sendSms,
    required this.smsBody,
    required this.closeButton,
  });
}
