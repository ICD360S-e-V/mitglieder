import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/login.dart';
import '../screens/problem_report.dart';
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
          MaterialPageRoute(builder: (_) => const ProblemReportScreen()),
        );
      }),
      _OptionData(Icons.phone_in_talk, s.emergency, true, _call),
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
  // Side-effects: dial the emergency line. The "problem with the app"
  // option now navigates to ProblemReportScreen — no more mailto: from
  // Claudiu's surface.
  // ---------------------------------------------------------------------------

  static const String _supportPhone = '+4916094482053';

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: _supportPhone);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
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
  });
}
