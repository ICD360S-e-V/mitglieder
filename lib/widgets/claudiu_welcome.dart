import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/login.dart';
import '../screens/register.dart';
import '../services/language_service.dart';

/// Conversational welcome surface — replaces the static
/// "Anmelden / Mitglied werden / email / phone / SOS" button block on
/// WelcomeScreen with a chat-style flow centred around the Claudiu mascot.
///
/// The mascot is a placeholder Material icon for now; once the final
/// SVG/Lottie of "boy in wheelchair" lands at `assets/mascot/claudiu.*`,
/// only the `_mascot()` builder below needs to change.
///
/// TTS deliberately deferred: Linux espeak voices sound robotic on cold
/// start, and a first-launch greeting that sounds artificial would
/// undermine the warmth this whole flow is here to convey. Will revisit
/// when per-platform voice quality (especially Linux) is acceptable.
class ClaudiuWelcome extends StatelessWidget {
  final double scale;
  const ClaudiuWelcome({super.key, this.scale = 1.0});

  // ---------------------------------------------------------------------------
  // Tiny per-language string table. Kept inline (vs. .arb) until the mascot
  // copy stabilises — once it does, migrate to AppLocalizations across all
  // 28 ARB files. English is the implicit fallback for any unknown language.
  // ---------------------------------------------------------------------------

  static const Map<String, _ClaudiuStrings> _strings = {
    'ro': _ClaudiuStrings(
      morning: 'Bună dimineața',
      day: 'Bună ziua',
      evening: 'Bună seara',
      night: 'Bună seara', // intentionally not "noaptea" — too late for a hi
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _mascotAndBubble(context, s, greeting),
        SizedBox(height: 24 * scale),
        _option(
          context,
          icon: Icons.person_add_alt_1,
          label: s.becomeMember,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RegisterPage()),
          ),
        ),
        SizedBox(height: 10 * scale),
        _option(
          context,
          icon: Icons.login,
          label: s.login,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          ),
        ),
        SizedBox(height: 10 * scale),
        _option(
          context,
          icon: Icons.bug_report_outlined,
          label: s.problem,
          onTap: () => _emailSupport(s),
        ),
        SizedBox(height: 10 * scale),
        _option(
          context,
          icon: Icons.phone_in_talk,
          label: s.emergency,
          onTap: () => _call(),
          danger: true,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Mascot + speech bubble row.
  // ---------------------------------------------------------------------------

  Widget _mascotAndBubble(
    BuildContext context,
    _ClaudiuStrings s,
    String greeting,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mascot(),
        SizedBox(width: 12 * scale),
        Expanded(child: _bubble(context, s, greeting)),
      ],
    );
  }

  Widget _mascot() {
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
      // accessible_forward = stylised wheelchair user — placeholder until the
      // commissioned Claudiu SVG/Lottie asset lands. Sized to fill the circle.
      child: Icon(
        Icons.accessible_forward,
        size: 52 * scale,
        color: Colors.white,
      ),
    );
  }

  Widget _bubble(BuildContext context, _ClaudiuStrings s, String greeting) {
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
          Text(
            greeting,
            style: TextStyle(
              fontSize: 15 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0d47a1),
              height: 1.3,
            ),
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
  // Option button.
  // ---------------------------------------------------------------------------

  Widget _option(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 14 * scale,
          ),
          decoration: BoxDecoration(
            color: danger
                ? const Color(0xFFE57373).withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: danger
                  ? const Color(0xFFEF9A9A)
                  : Colors.white.withValues(alpha: 0.30),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 22 * scale),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  label,
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
  // Side-effects: open mail client / dial number. Same destinations as the
  // existing WelcomeScreen helpers — kept in sync deliberately so a single
  // contact change updates both Claudiu's offer and any future direct button.
  // ---------------------------------------------------------------------------

  static const String _supportEmail = 'mitglied@icd360s.de';
  static const String _supportPhone = '+4916094482053';

  Future<void> _emailSupport(_ClaudiuStrings s) async {
    final uri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {'subject': '${s.problem} — ICD360S Mitglieder-App'},
    );
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: _supportPhone);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
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
