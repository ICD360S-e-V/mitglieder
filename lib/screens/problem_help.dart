import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/language_service.dart';
import '../widgets/icd360s_header.dart';
import 'anonymous_chat.dart';
import 'problem_report.dart';

/// Landing screen reached from Claudiu's "Am o problemă cu aplicația"
/// option. Asks the user whether they'd rather write a detailed report
/// or chat live with an operator. Replaces the direct navigation to the
/// report form so live chat sits side-by-side with the written form
/// instead of behind a separate welcome option.
///
/// "📝 Scriu un raport" → ProblemReportScreen (the existing written form)
/// "💬 Vorbim acum"     → AnonymousChatScreen (live chat, no auth)
class ProblemHelpScreen extends StatelessWidget {
  final String supportPhone;
  const ProblemHelpScreen({
    super.key,
    this.supportPhone = '+4916094482053',
  });

  // ---------------------------------------------------------------------------
  // Per-language string table — ro/de/en/ru/uk, English fallback for the rest.
  // ---------------------------------------------------------------------------

  static const Map<String, _Strings> _strings = {
    'ro': _Strings(
      title: 'Cum te pot ajuta?',
      greeting: 'Ce s-a întâmplat?',
      ask: 'Cum vrei să-mi povestești?',
      writeTitle: 'Scriu un raport',
      writeBody: 'Cu detalii pas cu pas. Echipa primește textul și îl rezolvă mai târziu.',
      chatTitle: 'Vorbim acum',
      chatBody: 'Chat anonim cu un operator. Răspuns în timp real, dacă e cineva online.',
      altCallHeader: 'Sau, dacă e ceva urgent:',
      altCallLabel: 'Sună-ne',
    ),
    'de': _Strings(
      title: 'Wie kann ich helfen?',
      greeting: 'Was ist passiert?',
      ask: 'Wie möchtest du es mir mitteilen?',
      writeTitle: 'Bericht schreiben',
      writeBody: 'Mit Schritt-für-Schritt-Details. Das Team erhält den Text und kümmert sich später darum.',
      chatTitle: 'Jetzt sprechen',
      chatBody: 'Anonymer Chat mit einem Mitarbeiter. Antwort in Echtzeit, falls jemand online ist.',
      altCallHeader: 'Oder bei dringenden Anliegen:',
      altCallLabel: 'Ruf uns an',
    ),
    'en': _Strings(
      title: 'How can I help?',
      greeting: 'What happened?',
      ask: 'How would you like to tell me?',
      writeTitle: 'Write a report',
      writeBody: 'With step-by-step details. The team gets the text and resolves it later.',
      chatTitle: "Let's talk now",
      chatBody: 'Anonymous chat with an operator. Realtime reply if someone is online.',
      altCallHeader: "Or, if it's urgent:",
      altCallLabel: 'Call us',
    ),
    'ru': _Strings(
      title: 'Чем я могу помочь?',
      greeting: 'Что случилось?',
      ask: 'Как тебе удобно рассказать?',
      writeTitle: 'Написать отчёт',
      writeBody: 'С подробностями шаг за шагом. Команда получит текст и разберётся позже.',
      chatTitle: 'Поговорим сейчас',
      chatBody: 'Анонимный чат с оператором. Ответ в реальном времени, если кто-то онлайн.',
      altCallHeader: 'Или, если срочно:',
      altCallLabel: 'Позвонить',
    ),
    'uk': _Strings(
      title: 'Чим я можу допомогти?',
      greeting: 'Що сталося?',
      ask: 'Як тобі зручно розповісти?',
      writeTitle: 'Написати звіт',
      writeBody: 'З покроковими деталями. Команда отримає текст і розгляне пізніше.',
      chatTitle: 'Поговорімо зараз',
      chatBody: 'Анонімний чат з оператором. Відповідь у режимі реального часу, якщо хтось онлайн.',
      altCallHeader: 'Або, якщо терміново:',
      altCallLabel: 'Зателефонувати',
    ),
  };

  static _Strings _stringsFor(String code) =>
      _strings[code] ?? _strings['en']!;

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _stringsFor(LanguageService.instance.currentCode);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0d47a1),
              Color(0xFF1565c0),
              Color(0xFF1976d2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _header(context, s.title),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icd360sHeader(compact: true),
                      const SizedBox(height: 20),
                      _mascotAndBubble(s),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _choiceCard(
                              context: context,
                              icon: Icons.edit_outlined,
                              title: s.writeTitle,
                              body: s.writeBody,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ProblemReportScreen(),
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 300.ms, duration: 400.ms)
                                .slideY(begin: 0.2, end: 0, delay: 300.ms),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _choiceCard(
                              context: context,
                              icon: Icons.chat_bubble_outline,
                              title: s.chatTitle,
                              body: s.chatBody,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AnonymousChatScreen(),
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 500.ms, duration: 400.ms)
                                .slideY(begin: 0.2, end: 0, delay: 500.ms),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      _altCallSection(s),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _mascotAndBubble(_Strings s) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.accessible_forward,
              size: 38,
              color: Colors.white,
            ),
          )
              .animate()
              .slideX(
                  begin: -0.5,
                  end: 0,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic)
              .fadeIn(duration: 400.ms),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
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
                  Text(
                    s.greeting,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0d47a1),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s.ask,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey[800],
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '— Claudiu',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
          ),
        ],
      ),
    );
  }

  Widget _choiceCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String body,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 168,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Text(
                  body,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _altCallSection(_Strings s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📞 ${s.altCallHeader}',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _call,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone_in_talk,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.altCallLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          supportPhone,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Strings {
  final String title;
  final String greeting;
  final String ask;
  final String writeTitle;
  final String writeBody;
  final String chatTitle;
  final String chatBody;
  final String altCallHeader;
  final String altCallLabel;

  const _Strings({
    required this.title,
    required this.greeting,
    required this.ask,
    required this.writeTitle,
    required this.writeBody,
    required this.chatTitle,
    required this.chatBody,
    required this.altCallHeader,
    required this.altCallLabel,
  });
}
