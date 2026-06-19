import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/diagnostic_service.dart';
import '../services/language_service.dart';

/// Conversational diagnostic-consent surface — Claudiu asks for permission
/// to send anonymous app diagnostics. Replaces the corporate AlertDialog
/// the previous revision used. Three options:
///   • "Da, vreau să ajut"               → consent granted, service starts
///   • "Nu, doar exploram"               → consent denied, service stays off
///   • "Spune-mi mai mult"               → expands a brutally-honest
///     transparency panel listing every field the diagnostic payload
///     actually contains. Decision can still be made after expanding.
///
/// The transparency text is the SOURCE OF TRUTH for what
/// diagnostic_service.dart sends. If the payload schema there changes,
/// this list has to change too — they document each other.
class DiagnosticConsentDialog extends StatefulWidget {
  const DiagnosticConsentDialog({super.key});

  @override
  State<DiagnosticConsentDialog> createState() =>
      _DiagnosticConsentDialogState();
}

class _DiagnosticConsentDialogState extends State<DiagnosticConsentDialog> {
  bool _expanded = false;

  // ---------------------------------------------------------------------------
  // Per-language string table. Same approach as ClaudiuWelcome — inline until
  // copy stabilises, then migrate to .arb across all 28 locales. English is
  // the implicit fallback for any unknown language code.
  // ---------------------------------------------------------------------------

  static const Map<String, _Strings> _strings = {
    'ro': _Strings(
      greeting: 'Înainte să intri, am o întrebare',
      ask:
          'Pot trimite raportări anonime ca să-i ajutăm pe dezvoltatori să facă aplicația mai bună?',
      yes: 'Da, vreau să ajut',
      no: 'Nu, doar exploram',
      tellMore: 'Spune-mi mai mult',
      sendsHeader: '📤 Ce TRIMITEM (anonim):',
      sends: [
        'Un cod anonim al dispozitivului (nu mitgliedernummer-ul)',
        'Rolul tău (membru / vorstand)',
        'Sistemul (Linux / Android / iOS / Windows)',
        'Limba aleasă',
        'Nivelul + starea bateriei',
        'Pe ce ecran ești',
        'Durata sesiunii (secunde)',
        'Erori dacă apar (ultimele 10)',
        'Navigare (ultimele 20 ecrane)',
      ],
      neverHeader: '🛡️ Ce NU trimitem NICIODATĂ:',
      never: [
        'Numele tău real',
        'Adresa de email',
        'Numărul de telefon',
        'Parola',
        'Conținutul mesajelor din chat',
        'Conținutul ticket-urilor',
        'Documente sau atașamente',
      ],
      techHeader: '📡 Detalii tehnice:',
      tech: [
        'Trimite la fiecare 2 minute',
        'Conexiune TLS criptată cu certificat fix (pinned)',
        'Poți opri oricând din Setări',
      ],
    ),
    'de': _Strings(
      greeting: 'Bevor du loslegst, eine Frage',
      ask:
          'Darf ich anonyme Berichte senden, damit die Entwickler die App verbessern können?',
      yes: 'Ja, ich helfe gerne',
      no: 'Nein, ich schaue mich nur um',
      tellMore: 'Mehr Details',
      sendsHeader: '📤 Was wir SENDEN (anonym):',
      sends: [
        'Ein anonymer Gerätecode (NICHT die Mitgliedsnummer)',
        'Deine Rolle (Mitglied / Vorstand)',
        'Betriebssystem (Linux / Android / iOS / Windows)',
        'Gewählte Sprache',
        'Akkustand + Status',
        'Aktueller Bildschirm',
        'Sitzungsdauer (Sekunden)',
        'Fehler falls vorhanden (letzte 10)',
        'Navigation (letzte 20 Bildschirme)',
      ],
      neverHeader: '🛡️ Was wir NIE senden:',
      never: [
        'Dein echter Name',
        'E-Mail-Adresse',
        'Telefonnummer',
        'Passwort',
        'Inhalte deiner Chat-Nachrichten',
        'Inhalte deiner Tickets',
        'Dokumente oder Anhänge',
      ],
      techHeader: '📡 Technische Details:',
      tech: [
        'Wird alle 2 Minuten gesendet',
        'TLS-verschlüsselte Verbindung mit Pinned-Zertifikat',
        'Du kannst es jederzeit in den Einstellungen abschalten',
      ],
    ),
    'en': _Strings(
      greeting: 'Before you go in, one quick question',
      ask:
          'May I send anonymous reports so the developers can improve the app?',
      yes: "Yes, I'd like to help",
      no: "No, I'm just exploring",
      tellMore: 'Tell me more',
      sendsHeader: '📤 What we SEND (anonymous):',
      sends: [
        'An anonymous device code (NOT your member number)',
        'Your role (member / board)',
        'Operating system (Linux / Android / iOS / Windows)',
        'Selected language',
        'Battery level + state',
        'Current screen',
        'Session duration (seconds)',
        'Errors if any (last 10)',
        'Navigation (last 20 screens)',
      ],
      neverHeader: '🛡️ What we NEVER send:',
      never: [
        'Your real name',
        'Email address',
        'Phone number',
        'Password',
        'Chat message contents',
        'Ticket contents',
        'Documents or attachments',
      ],
      techHeader: '📡 Technical details:',
      tech: [
        'Sent every 2 minutes',
        'TLS-encrypted connection, pinned certificate',
        'You can turn it off any time in Settings',
      ],
    ),
    'ru': _Strings(
      greeting: 'Перед тем как войти, один вопрос',
      ask:
          'Можно отправлять анонимные отчёты, чтобы разработчики могли улучшить приложение?',
      yes: 'Да, я хочу помочь',
      no: 'Нет, я просто смотрю',
      tellMore: 'Расскажи подробнее',
      sendsHeader: '📤 Что мы ОТПРАВЛЯЕМ (анонимно):',
      sends: [
        'Анонимный код устройства (НЕ номер члена)',
        'Ваша роль (член / правление)',
        'Система (Linux / Android / iOS / Windows)',
        'Выбранный язык',
        'Уровень и состояние батареи',
        'Текущий экран',
        'Длительность сессии (секунды)',
        'Ошибки, если есть (последние 10)',
        'Навигация (последние 20 экранов)',
      ],
      neverHeader: '🛡️ Что мы НИКОГДА не отправляем:',
      never: [
        'Ваше настоящее имя',
        'Адрес электронной почты',
        'Номер телефона',
        'Пароль',
        'Содержимое сообщений чата',
        'Содержимое тикетов',
        'Документы или вложения',
      ],
      techHeader: '📡 Технические детали:',
      tech: [
        'Отправляется каждые 2 минуты',
        'TLS-шифрование, фиксированный сертификат',
        'Можно отключить в настройках',
      ],
    ),
    'uk': _Strings(
      greeting: 'Перш ніж увійти, одне запитання',
      ask:
          'Чи можу я надсилати анонімні звіти, щоб розробники могли покращити застосунок?',
      yes: 'Так, я хочу допомогти',
      no: 'Ні, я просто переглядаю',
      tellMore: 'Розкажи більше',
      sendsHeader: '📤 Що ми НАДСИЛАЄМО (анонімно):',
      sends: [
        'Анонімний код пристрою (НЕ номер члена)',
        'Ваша роль (член / правління)',
        'Система (Linux / Android / iOS / Windows)',
        'Вибрана мова',
        'Рівень і стан акумулятора',
        'Поточний екран',
        'Тривалість сесії (секунди)',
        'Помилки, якщо є (останні 10)',
        'Навігація (останні 20 екранів)',
      ],
      neverHeader: '🛡️ Що ми НІКОЛИ не надсилаємо:',
      never: [
        'Ваше справжнє ім\'я',
        'Електронна адреса',
        'Номер телефону',
        'Пароль',
        'Вміст повідомлень чату',
        'Вміст тикетів',
        'Документи або вкладення',
      ],
      techHeader: '📡 Технічні деталі:',
      tech: [
        'Надсилається кожні 2 хвилини',
        'TLS-шифрування, фіксований сертифікат',
        'Можна вимкнути в налаштуваннях',
      ],
    ),
  };

  static _Strings _stringsFor(String code) =>
      _strings[code] ?? _strings['en']!;

  @override
  Widget build(BuildContext context) {
    final code = LanguageService.instance.currentCode;
    final s = _stringsFor(code);
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 640),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mascotAndBubble(s),
              const SizedBox(height: 20),
              _option(
                icon: Icons.check_circle_outline,
                label: s.yes,
                color: const Color(0xFF2E7D32),
                onTap: () => _handleResponse(true),
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 300.ms)
                  .slideY(begin: 0.2, end: 0, delay: 600.ms),
              const SizedBox(height: 10),
              _option(
                icon: Icons.cancel_outlined,
                label: s.no,
                color: Colors.grey.shade700,
                onTap: () => _handleResponse(false),
              )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 300.ms)
                  .slideY(begin: 0.2, end: 0, delay: 800.ms),
              const SizedBox(height: 10),
              _option(
                icon: _expanded
                    ? Icons.expand_less
                    : Icons.help_outline,
                label: s.tellMore,
                color: theme.colorScheme.primary,
                onTap: () => setState(() => _expanded = !_expanded),
              )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 300.ms)
                  .slideY(begin: 0.2, end: 0, delay: 1000.ms),
              AnimatedCrossFade(
                firstChild: const SizedBox(height: 0),
                secondChild: _transparency(s),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Mascot (placeholder Material icon — same as ClaudiuWelcome) + speech bubble.
  // ---------------------------------------------------------------------------

  Widget _mascotAndBubble(_Strings s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF1565c0).withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF1565c0).withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.accessible_forward,
            size: 38,
            color: Color(0xFF1565c0),
          ),
        )
            .animate()
            .slideX(begin: -0.5, end: 0, duration: 500.ms, curve: Curves.easeOut)
            .fadeIn(duration: 400.ms),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.greeting,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0d47a1),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
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
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 400.ms),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Brutal-honesty transparency panel. Source of truth for what the diagnostic
  // service actually transmits — keep this in lockstep with diagnostic_service
  // .dart's `_sendDiagnostics()` payload schema.
  // ---------------------------------------------------------------------------

  Widget _transparency(_Strings s) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _transparencySection(
            header: s.sendsHeader,
            items: s.sends,
            color: Colors.blue.shade700,
            iconBuilder: () => Icon(
              Icons.check,
              size: 16,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 12),
          _transparencySection(
            header: s.neverHeader,
            items: s.never,
            color: Colors.green.shade700,
            iconBuilder: () => Icon(
              Icons.close,
              size: 16,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 12),
          _transparencySection(
            header: s.techHeader,
            items: s.tech,
            color: Colors.grey.shade700,
            iconBuilder: () =>
                Icon(Icons.info_outline, size: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _transparencySection({
    required String header,
    required List<String> items,
    required Color color,
    required Widget Function() iconBuilder,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: iconBuilder(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12.5, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Option row.
  // ---------------------------------------------------------------------------

  Widget _option({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Persist decision + start the service if granted.
  // ---------------------------------------------------------------------------

  Future<void> _handleResponse(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('diagnostic_asked', true);
    await prefs.setBool('diagnostic_enabled', enabled);

    if (enabled) {
      // Fire-and-forget; the service handles the anonymous-id bootstrap.
      DiagnosticService().start();
    }

    if (mounted) {
      Navigator.of(context).pop(enabled);
    }
  }
}

class _Strings {
  final String greeting;
  final String ask;
  final String yes;
  final String no;
  final String tellMore;
  final String sendsHeader;
  final List<String> sends;
  final String neverHeader;
  final List<String> never;
  final String techHeader;
  final List<String> tech;

  const _Strings({
    required this.greeting,
    required this.ask,
    required this.yes,
    required this.no,
    required this.tellMore,
    required this.sendsHeader,
    required this.sends,
    required this.neverHeader,
    required this.never,
    required this.techHeader,
    required this.tech,
  });
}

// ---------------------------------------------------------------------------
// Same public helpers the previous version exposed — main.dart / welcome.dart
// keep calling these unchanged.
// ---------------------------------------------------------------------------

/// Check if diagnostic consent dialog should be shown
Future<bool> shouldShowDiagnosticConsent() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('diagnostic_asked') != true;
}

/// Check if diagnostics are enabled
Future<bool> isDiagnosticEnabled() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('diagnostic_enabled') ?? false;
}

/// Show diagnostic consent dialog if not already asked
Future<void> checkAndShowDiagnosticConsent(BuildContext context) async {
  if (await shouldShowDiagnosticConsent()) {
    if (context.mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const DiagnosticConsentDialog(),
      );
    }
  } else {
    // Already asked - start service if enabled
    if (await isDiagnosticEnabled()) {
      DiagnosticService().start();
    }
  }
}
