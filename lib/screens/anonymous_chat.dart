import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/language_service.dart';
import '../widgets/icd360s_header.dart';
import 'problem_report.dart';

/// Live anonymous chat surface. Currently a placeholder that ships the
/// landing UX (mascot + bubble + "coming soon" copy + safe alternatives)
/// while the server-side work lands in a follow-up commit:
///
///   • SQL: add users.is_anonymous + new anonymous_chat_users table
///   • PHP: /api/public/anonymous_chat/init.php → creates a ghost user
///     record and returns mitgliedernummer + JWT
///   • Client: connect via the existing chat_service.dart with that
///     mitgliedernummer; the WebSocket auth + translator + read receipts
///     pipeline already works because the anonymous user IS a row in
///     the users table, just flagged is_anonymous=1.
///
/// Until that ships, the screen offers the two fallback paths the user
/// already knows: the written report form and a phone call.
class AnonymousChatScreen extends StatelessWidget {
  final String supportPhone;
  const AnonymousChatScreen({
    super.key,
    this.supportPhone = '+4916094482053',
  });

  static const Map<String, _Strings> _strings = {
    'ro': _Strings(
      title: 'Chat anonim',
      greeting: 'Salut!',
      ask:
          'Chat-ul live anonim e aproape gata. Până atunci, scrie-ne un raport sau sună-ne — primim mesajul instant.',
      writeButton: 'Scriu un raport',
      callButton: 'Sună-ne',
      soonBadge: 'În curând',
    ),
    'de': _Strings(
      title: 'Anonymer Chat',
      greeting: 'Hallo!',
      ask:
          'Der anonyme Live-Chat ist fast fertig. Bis dahin schreib uns einen Bericht oder ruf an — wir bekommen es sofort.',
      writeButton: 'Bericht schreiben',
      callButton: 'Ruf uns an',
      soonBadge: 'Bald',
    ),
    'en': _Strings(
      title: 'Anonymous chat',
      greeting: 'Hi!',
      ask:
          "Anonymous live chat is almost ready. Until then, send us a report or call — we'll get it right away.",
      writeButton: 'Write a report',
      callButton: 'Call us',
      soonBadge: 'Soon',
    ),
    'ru': _Strings(
      title: 'Анонимный чат',
      greeting: 'Привет!',
      ask:
          'Анонимный чат почти готов. Пока напиши нам отчёт или позвони — мы получим сразу.',
      writeButton: 'Написать отчёт',
      callButton: 'Позвонить',
      soonBadge: 'Скоро',
    ),
    'uk': _Strings(
      title: 'Анонімний чат',
      greeting: 'Привіт!',
      ask:
          'Анонімний чат майже готовий. Поки напиши нам звіт або зателефонуй — ми отримаємо відразу.',
      writeButton: 'Написати звіт',
      callButton: 'Зателефонувати',
      soonBadge: 'Скоро',
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
                      const SizedBox(height: 24),
                      _mascotAndBubble(s),
                      const SizedBox(height: 28),
                      _action(
                        icon: Icons.edit_outlined,
                        label: s.writeButton,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const ProblemReportScreen(),
                            ),
                          );
                        },
                      )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0, delay: 400.ms),
                      const SizedBox(height: 12),
                      _action(
                        icon: Icons.phone_in_talk,
                        label: s.callButton,
                        sub: supportPhone,
                        onTap: _call,
                      )
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0, delay: 600.ms),
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
          Stack(
            clipBehavior: Clip.none,
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
                  Icons.chat_bubble_outline,
                  size: 38,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: -6,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB74D),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    s.soonBadge,
                    style: const TextStyle(
                      color: Color(0xFF0d47a1),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          )
              .animate()
              .slideX(
                begin: -0.5,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              )
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
                      height: 1.4,
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

  Widget _action({
    required IconData icon,
    required String label,
    String? sub,
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
                    if (sub != null) ...[
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

class _Strings {
  final String title;
  final String greeting;
  final String ask;
  final String writeButton;
  final String callButton;
  final String soonBadge;

  const _Strings({
    required this.title,
    required this.greeting,
    required this.ask,
    required this.writeButton,
    required this.callButton,
    required this.soonBadge,
  });
}
