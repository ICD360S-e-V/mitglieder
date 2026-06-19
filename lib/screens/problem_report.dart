import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_service.dart';
import '../services/language_service.dart';
import '../widgets/icd360s_header.dart';

/// "I have a problem with the app" surface — reached from the Claudiu
/// welcome flow. A guided form: checklist of what to include, free-text
/// area for the user's own description, send to the server. We do NOT
/// attach OS / app version / device-id payload here — that already
/// arrives via the periodic diagnostic POST when consent is granted, and
/// the user explicitly asked us not to duplicate it.
///
/// The only fallback channel is a `tel:` link to the office line. No
/// email, no WhatsApp, by user request.
class ProblemReportScreen extends StatefulWidget {
  /// Phone number rendered at the bottom of the screen for the
  /// "call us instead" path. Defaults to the same line used by SOS /
  /// ClaudiuLoginCoach so a future contact-info endpoint can replace
  /// one place.
  final String supportPhone;

  const ProblemReportScreen({
    super.key,
    this.supportPhone = '+4916094482053',
  });

  @override
  State<ProblemReportScreen> createState() => _ProblemReportScreenState();
}

class _ProblemReportScreenState extends State<ProblemReportScreen> {
  /// Bug report descriptions shorter than this are unlikely to be
  /// actionable. The submit button stays disabled until reached and the
  /// character counter shows the user how close they are.
  static const int _minChars = 20;

  final TextEditingController _descController = TextEditingController();
  bool _isSending = false;

  // ---------------------------------------------------------------------------
  // Per-language string table. Same inline pattern as the other Claudiu
  // surfaces — ro/de/en/ru/uk, English fallback for the rest.
  // ---------------------------------------------------------------------------

  static const Map<String, _Strings> _strings = {
    'ro': _Strings(
      title: 'Raportează o problemă',
      greeting: 'Ce s-a întâmplat?',
      ask: 'Spune-mi în detaliu și trimit raportul la echipă.',
      includeHeader: 'Include în descrierea ta:',
      includeBullets: [
        'Ce făceai când a apărut problema',
        'Ce mesaj de eroare ai văzut',
        'Pe ce ecran erai',
        'Aplicația crapă? Se închide? Apare ecran alb?',
        'Se repetă mereu sau o singură dată',
      ],
      descriptionLabel: 'Descrierea ta',
      descriptionHint:
          'Ex: Când deschid ecranul de chat, apare un mesaj „Connection error" și aplicația nu mai răspunde…',
      tooShort: 'Mai detaliază, te rog (minim $_minChars caractere)',
      submit: 'Trimite raportul',
      submitting: 'Trimit...',
      sentTitle: 'Mulțumesc!',
      sentBody:
          'Raportul a fost trimis. Echipa noastră îl va analiza cât mai curând.',
      sentClose: 'Înțeles',
      sendFailed:
          'Nu am putut trimite raportul. Sună-ne pentru asistență urgentă.',
      alt: 'Sau, dacă e ceva urgent:',
      callLabel: 'Sună-ne',
    ),
    'de': _Strings(
      title: 'Problem melden',
      greeting: 'Was ist passiert?',
      ask: 'Beschreibe es im Detail, und ich leite den Bericht weiter.',
      includeHeader: 'Bitte mit angeben:',
      includeBullets: [
        'Was du gerade gemacht hast',
        'Welche Fehlermeldung erschien',
        'Auf welchem Bildschirm du warst',
        'Stürzt die App ab? Wird sie weiß? Schließt sie sich?',
        'Passiert es einmalig oder wiederholt',
      ],
      descriptionLabel: 'Deine Beschreibung',
      descriptionHint:
          'Z.B.: Beim Öffnen des Chat-Bildschirms erscheint „Connection error" und die App reagiert nicht mehr…',
      tooShort: 'Bitte etwas ausführlicher (mind. $_minChars Zeichen)',
      submit: 'Bericht senden',
      submitting: 'Wird gesendet…',
      sentTitle: 'Danke!',
      sentBody:
          'Der Bericht wurde gesendet. Unser Team schaut so schnell wie möglich darauf.',
      sentClose: 'Verstanden',
      sendFailed:
          'Bericht konnte nicht gesendet werden. Ruf uns bei dringenden Anliegen an.',
      alt: 'Oder bei dringenden Anliegen:',
      callLabel: 'Ruf uns an',
    ),
    'en': _Strings(
      title: 'Report a problem',
      greeting: 'What happened?',
      ask: "Tell me in detail and I'll forward the report to the team.",
      includeHeader: 'Please include:',
      includeBullets: [
        'What you were doing when the problem appeared',
        'Any error message you saw',
        'Which screen you were on',
        'Does the app crash, close, or show a blank screen?',
        'Does it happen every time or just once?',
      ],
      descriptionLabel: 'Your description',
      descriptionHint:
          "E.g.: When I open the chat screen I get a 'Connection error' message and the app stops responding…",
      tooShort: 'A bit more detail, please (at least $_minChars characters)',
      submit: 'Send report',
      submitting: 'Sending…',
      sentTitle: 'Thank you!',
      sentBody:
          'The report has been sent. Our team will look into it as soon as possible.',
      sentClose: 'Got it',
      sendFailed:
          "Couldn't send the report. Please call us for urgent help.",
      alt: "Or, if it's urgent:",
      callLabel: 'Call us',
    ),
    'ru': _Strings(
      title: 'Сообщить о проблеме',
      greeting: 'Что случилось?',
      ask: 'Расскажи подробно, и я передам отчёт команде.',
      includeHeader: 'Пожалуйста, укажи:',
      includeBullets: [
        'Что ты делал, когда появилась проблема',
        'Какое сообщение об ошибке появилось',
        'На каком экране ты был',
        'Приложение вылетает? Закрывается? Показывает белый экран?',
        'Повторяется или это один раз?',
      ],
      descriptionLabel: 'Твоё описание',
      descriptionHint:
          'Напр.: При открытии чата появляется «Connection error» и приложение не отвечает…',
      tooShort: 'Чуть подробнее, пожалуйста (минимум $_minChars символов)',
      submit: 'Отправить отчёт',
      submitting: 'Отправка…',
      sentTitle: 'Спасибо!',
      sentBody:
          'Отчёт отправлен. Наша команда рассмотрит его как можно скорее.',
      sentClose: 'Понятно',
      sendFailed:
          'Не удалось отправить отчёт. Позвони нам, если срочно.',
      alt: 'Или, если срочно:',
      callLabel: 'Позвонить',
    ),
    'uk': _Strings(
      title: 'Повідомити про проблему',
      greeting: 'Що сталося?',
      ask: 'Розкажи детально, і я передам звіт команді.',
      includeHeader: 'Будь ласка, вкажи:',
      includeBullets: [
        'Що ти робив, коли з\'явилася проблема',
        'Яке повідомлення про помилку з\'явилося',
        'На якому екрані ти був',
        'Застосунок крашиться? Закривається? Показує білий екран?',
        'Це повторюється чи разово?',
      ],
      descriptionLabel: 'Твій опис',
      descriptionHint:
          'Напр.: При відкритті чату з\'являється «Connection error» і застосунок не відповідає…',
      tooShort: 'Трохи більше деталей, будь ласка (мінімум $_minChars символів)',
      submit: 'Надіслати звіт',
      submitting: 'Надсилання…',
      sentTitle: 'Дякую!',
      sentBody:
          'Звіт надіслано. Наша команда розгляне його якомога швидше.',
      sentClose: 'Зрозуміло',
      sendFailed:
          'Не вдалося надіслати звіт. Зателефонуй нам у разі терміновості.',
      alt: 'Або, якщо терміново:',
      callLabel: 'Зателефонувати',
    ),
  };

  static _Strings _stringsFor(String code) =>
      _strings[code] ?? _strings['en']!;

  @override
  void initState() {
    super.initState();
    _descController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      !_isSending && _descController.text.trim().length >= _minChars;

  Future<void> _submit() async {
    final s = _stringsFor(LanguageService.instance.currentCode);
    setState(() => _isSending = true);
    try {
      final result = await ApiService().submitBugReport(
        description: _descController.text.trim(),
      );
      if (!mounted) return;
      if (result['success'] == true) {
        await _showSentDialog(s);
        if (mounted) Navigator.of(context).pop();
      } else {
        _showFailedSnack(s);
      }
    } catch (_) {
      if (mounted) _showFailedSnack(s);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _showSentDialog(_Strings s) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
            const SizedBox(width: 10),
            Text(s.sentTitle),
          ],
        ),
        content: Text(s.sentBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(s.sentClose),
          ),
        ],
      ),
    );
  }

  void _showFailedSnack(_Strings s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.sendFailed),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: widget.supportPhone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _stringsFor(LanguageService.instance.currentCode);
    final charCount = _descController.text.trim().length;

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
              _header(s),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icd360sHeader(compact: true),
                      const SizedBox(height: 16),
                      _mascotAndBubble(s),
                      const SizedBox(height: 16),
                      _checklist(s),
                      const SizedBox(height: 16),
                      _descriptionField(s, charCount),
                      const SizedBox(height: 16),
                      _submitButton(s),
                      const SizedBox(height: 24),
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

  Widget _header(_Strings s) {
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
              s.title,
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
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.bug_report_outlined,
              size: 38,
              color: Colors.white,
            ),
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

  Widget _checklist(_Strings s) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 ${s.includeHeader}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          for (final bullet in s.includeBullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullet,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _descriptionField(_Strings s, int charCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '✍️ ${s.descriptionLabel}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descController,
          maxLines: 8,
          minLines: 6,
          enabled: !_isSending,
          style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
          decoration: InputDecoration(
            hintText: s.descriptionHint,
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
              height: 1.4,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                charCount < _minChars ? s.tooShort : '',
                style: TextStyle(
                  color: Colors.amber.shade200,
                  fontSize: 11.5,
                ),
              ),
            ),
            Text(
              '$charCount / $_minChars',
              style: TextStyle(
                color: charCount >= _minChars
                    ? Colors.greenAccent.shade100
                    : Colors.white.withValues(alpha: 0.6),
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _submitButton(_Strings s) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _canSubmit ? _submit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.18),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.white.withValues(alpha: 0.05),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.4),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.45),
            width: 2,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: _isSending
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(s.submitting),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send_outlined, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    s.submit,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _altCallSection(_Strings s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '⬇️ ${s.alt}',
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
                color: Colors.white.withValues(alpha: 0.1),
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
                          s.callLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.supportPhone,
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
  final String includeHeader;
  final List<String> includeBullets;
  final String descriptionLabel;
  final String descriptionHint;
  final String tooShort;
  final String submit;
  final String submitting;
  final String sentTitle;
  final String sentBody;
  final String sentClose;
  final String sendFailed;
  final String alt;
  final String callLabel;

  const _Strings({
    required this.title,
    required this.greeting,
    required this.ask,
    required this.includeHeader,
    required this.includeBullets,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.tooShort,
    required this.submit,
    required this.submitting,
    required this.sentTitle,
    required this.sentBody,
    required this.sentClose,
    required this.sendFailed,
    required this.alt,
    required this.callLabel,
  });
}
