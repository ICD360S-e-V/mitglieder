import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/language_service.dart';

/// Conversational coaching surface for the login screen — Claudiu sits
/// above the two-box mitgliedernummer form and updates his speech bubble
/// in real time as the user types. Reads four signals from the parent:
///
///   • [digitCount]   — 0..5 (digits already typed in the second box).
///   • [isLoading]    — true while the auth request is in flight.
///   • [errorMessage] — non-null when the request failed.
///   • [foundName]    — set after success so the bubble can say
///                       "Te-am găsit, <name>!" before the redirect.
///
/// After 8 s of inactivity with an empty digit box, the "forgot your
/// number?" panel slides in. It deliberately does NOT offer
/// email/SMS/post recovery — the member number is recovered only via an
/// in-person meeting at the association office, after ID verification.
class ClaudiuLoginCoach extends StatefulWidget {
  final int digitCount;
  final bool isLoading;
  final String? errorMessage;
  final String? foundName;

  /// Same support phone the SOS dialog uses. Kept here as a constructor
  /// argument (with a default) so a future endpoint can override it
  /// without changing this widget's API.
  final String supportPhone;

  const ClaudiuLoginCoach({
    super.key,
    required this.digitCount,
    required this.isLoading,
    this.errorMessage,
    this.foundName,
    this.supportPhone = '+4916094482053',
  });

  @override
  State<ClaudiuLoginCoach> createState() => _ClaudiuLoginCoachState();
}

class _ClaudiuLoginCoachState extends State<ClaudiuLoginCoach> {
  /// Forgot prompt is hidden by default; appears after 8 s of inactivity
  /// with a fully empty digit box, OR immediately on error 404. The
  /// prompt is just a clickable "Ai uitat?" headline — the explanation +
  /// phone number stay hidden behind [_forgotExpanded] so the panel
  /// never feels noisy for users who know their number.
  bool _showForgot = false;

  /// User tapped the "Ai uitat?" headline → the security disclaimer and
  /// the call-the-office phone number are revealed.
  bool _forgotExpanded = false;

  Timer? _idleTimer;

  @override
  void initState() {
    super.initState();
    _scheduleIdleReveal();
  }

  @override
  void didUpdateWidget(covariant ClaudiuLoginCoach old) {
    super.didUpdateWidget(old);
    if (old.digitCount != widget.digitCount) {
      // Any typing resets the idle timer.
      _scheduleIdleReveal();
    }
    if (widget.errorMessage != null && old.errorMessage == null) {
      // Errors reveal the forgot panel immediately — the user likely
      // doesn't remember the digits they just tried.
      setState(() => _showForgot = true);
    }
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    super.dispose();
  }

  void _scheduleIdleReveal() {
    _idleTimer?.cancel();
    if (widget.digitCount > 0) return;
    _idleTimer = Timer(const Duration(seconds: 8), () {
      if (!mounted) return;
      setState(() => _showForgot = true);
    });
  }

  // ---------------------------------------------------------------------------
  // String tables. Same inline pattern as ClaudiuWelcome — 5 priority
  // locales, English fallback for the rest.
  // ---------------------------------------------------------------------------

  static const Map<String, _Strings> _strings = {
    'ro': _Strings(
      welcome: 'Bine ai revenit, drag membru!',
      ask: 'Spune-mi numărul tău de membru.',
      progress: 'Mai aproape… continuă să tastezi.',
      ready: 'Perfect! Apasă butonul de mai jos.',
      loading: 'Verific identitatea… 🔍',
      foundPlain: 'Te-am găsit! Te conectez acum…',
      foundNamed: 'Te-am găsit, {name}! Te conectez acum…',
      error: 'Hm, nu găsesc numărul ăsta. Verifici dacă ai scris bine?',
      forgotHeader: 'Ai uitat numărul de membru?',
      noSms: 'Nu trimitem numărul prin email sau SMS.',
      onlyWay:
          'Singura cale: să ne întâlnim personal la sediul asociației, după verificare CI.',
      contactUs: 'Contactează-ne pentru programare:',
    ),
    'de': _Strings(
      welcome: 'Willkommen zurück, liebes Mitglied!',
      ask: 'Bitte gib mir deine Mitgliedsnummer.',
      progress: 'Fast geschafft… tippe weiter.',
      ready: 'Perfekt! Drück jetzt den Anmelden-Knopf.',
      loading: 'Ich prüfe die Identität… 🔍',
      foundPlain: 'Gefunden! Du wirst jetzt eingeloggt…',
      foundNamed: 'Gefunden, {name}! Du wirst jetzt eingeloggt…',
      error:
          'Hm, die Nummer finde ich nicht. Hast du dich vielleicht vertippt?',
      forgotHeader: 'Mitgliedsnummer vergessen?',
      noSms: 'Wir verschicken die Nummer nicht per E-Mail oder SMS.',
      onlyWay:
          'Der einzige Weg: ein persönlicher Termin im Vereinsbüro, mit Personalausweis.',
      contactUs: 'Ruf uns an für einen Termin:',
    ),
    'en': _Strings(
      welcome: 'Welcome back, dear member!',
      ask: 'Please tell me your member number.',
      progress: 'Getting closer… keep typing.',
      ready: 'Perfect! Tap the button below.',
      loading: "I'm verifying your identity… 🔍",
      foundPlain: 'Found you! Signing you in…',
      foundNamed: 'Found you, {name}! Signing you in…',
      error: "Hm, I can't find that number. Did you type it correctly?",
      forgotHeader: 'Forgot your member number?',
      noSms: "We don't send the number by email or SMS.",
      onlyWay:
          'The only way: meet us in person at the association office, after ID verification.',
      contactUs: 'Call us to book an appointment:',
    ),
    'ru': _Strings(
      welcome: 'С возвращением, дорогой член!',
      ask: 'Пожалуйста, скажи свой членский номер.',
      progress: 'Почти… продолжай вводить.',
      ready: 'Отлично! Нажми кнопку ниже.',
      loading: 'Проверяю личность… 🔍',
      foundPlain: 'Нашёл! Сейчас войдёшь…',
      foundNamed: 'Нашёл, {name}! Сейчас войдёшь…',
      error: 'Хм, такой номер не нахожу. Проверь, не ошибся ли?',
      forgotHeader: 'Забыл членский номер?',
      noSms: 'Мы не отправляем номер по email или SMS.',
      onlyWay:
          'Единственный путь: личная встреча в офисе ассоциации с удостоверением.',
      contactUs: 'Позвони, чтобы записаться:',
    ),
    'uk': _Strings(
      welcome: 'З поверненням, дорогий члене!',
      ask: 'Скажи мені свій членський номер.',
      progress: 'Майже… продовжуй вводити.',
      ready: 'Чудово! Натисни кнопку нижче.',
      loading: 'Перевіряю особу… 🔍',
      foundPlain: 'Знайшов! Зараз увійдеш…',
      foundNamed: 'Знайшов, {name}! Зараз увійдеш…',
      error: 'Хм, такого номера не знаходжу. Перевір, чи правильно ввів?',
      forgotHeader: 'Забув членський номер?',
      noSms: 'Ми не надсилаємо номер електронною поштою або SMS.',
      onlyWay:
          'Єдиний шлях: особиста зустріч в офісі асоціації, з посвідченням.',
      contactUs: 'Зателефонуй, щоб записатися:',
    ),
  };

  static _Strings _stringsFor(String code) =>
      _strings[code] ?? _strings['en']!;

  String _currentMessage(_Strings s) {
    if (widget.isLoading) return s.loading;
    if (widget.foundName != null && widget.foundName!.isNotEmpty) {
      return s.foundNamed.replaceFirst('{name}', widget.foundName!);
    }
    if (widget.foundName != null) return s.foundPlain;
    if (widget.errorMessage != null) return s.error;
    if (widget.digitCount == 5) return s.ready;
    if (widget.digitCount > 0) return s.progress;
    return s.ask;
  }

  IconData _currentMascotIcon() {
    if (widget.isLoading) return Icons.search;
    if (widget.foundName != null) return Icons.celebration;
    if (widget.errorMessage != null) return Icons.sentiment_dissatisfied;
    if (widget.digitCount == 5) return Icons.thumb_up_alt_outlined;
    return Icons.accessible_forward;
  }

  @override
  Widget build(BuildContext context) {
    final code = LanguageService.instance.currentCode;
    final s = _stringsFor(code);
    final message = _currentMessage(s);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mascot + bubble row.
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mascot()
                  .animate()
                  .slideX(
                      begin: -0.6,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutCubic)
                  .fadeIn(duration: 400.ms),
              const SizedBox(width: 12),
              Expanded(
                child: _bubble(s, message)
                    .animate()
                    .fadeIn(delay: 250.ms, duration: 400.ms),
              ),
            ],
          ),
        ),
        // Forgot panel — animated reveal.
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild: _forgotPanel(s)
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.2, end: 0, duration: 400.ms),
          crossFadeState: _showForgot
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 350),
        ),
      ],
    );
  }

  Widget _mascot() {
    final icon = _currentMascotIcon();
    return Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 2,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: Icon(
          icon,
          key: ValueKey(icon),
          size: 42,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _bubble(_Strings s, String message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              s.welcome,
              key: const ValueKey('welcome'),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0d47a1),
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              message,
              key: ValueKey(message),
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey[800],
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '— Claudiu',
            style: TextStyle(
              fontSize: 10.5,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _forgotPanel(_Strings s) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Clickable headline — toggles the details below. No
          // explanation visible until the user actively asks for it.
          InkWell(
            onTap: () =>
                setState(() => _forgotExpanded = !_forgotExpanded),
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  const Text('🤔', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      s.forgotHeader,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _forgotExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0),
            secondChild: Padding(
              padding:
                  const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoLine(Icons.no_cell, s.noSms,
                      color: Colors.amber.shade200),
                  const SizedBox(height: 6),
                  _infoLine(Icons.handshake_outlined, s.onlyWay,
                      color: Colors.greenAccent.shade100),
                  const SizedBox(height: 12),
                  Text(
                    s.contactUs,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _phoneAction(),
                ],
              ),
            ),
            crossFadeState: _forgotExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _infoLine(IconData icon, String text, {required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  /// The phone number itself is the call-to-action. Tapping the row
  /// fires `tel:` so the dialer pre-fills with the office line.
  Widget _phoneAction() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _call,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              const Icon(Icons.phone_in_talk, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.supportPhone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
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

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: widget.supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _Strings {
  final String welcome;
  final String ask;
  final String progress;
  final String ready;
  final String loading;
  final String foundPlain;
  final String foundNamed;
  final String error;
  final String forgotHeader;
  final String noSms;
  final String onlyWay;
  final String contactUs;

  const _Strings({
    required this.welcome,
    required this.ask,
    required this.progress,
    required this.ready,
    required this.loading,
    required this.foundPlain,
    required this.foundNamed,
    required this.error,
    required this.forgotHeader,
    required this.noSms,
    required this.onlyWay,
    required this.contactUs,
  });
}
