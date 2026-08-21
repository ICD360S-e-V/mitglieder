import 'dart:async';
import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../utils/app_theme.dart';

/// Consent prompt shown to the MEMBER before any screen is shared for
/// Fernwartung (remote support). Nothing starts until the member taps "Erlauben".
///
/// Legally this is the core safeguard: explicit, per-session, informed consent.
/// The text is shown in the member's own language (the five the association
/// actually serves: DE/RO/UK/TR/EN) with a German fallback. A 60-second timer
/// auto-declines so a prompt on an unattended device never grants access.
class RemoteConsentDialog extends StatefulWidget {
  final String controllerName;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const RemoteConsentDialog({
    super.key,
    required this.controllerName,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  State<RemoteConsentDialog> createState() => _RemoteConsentDialogState();
}

class _RemoteConsentDialogState extends State<RemoteConsentDialog> {
  static const int _timeoutSeconds = 60;
  int _remaining = _timeoutSeconds;
  Timer? _timer;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _remaining--);
      if (_remaining <= 0) _finish(accept: false);
    });
  }

  void _finish({required bool accept}) {
    if (_done) return;
    _done = true;
    _timer?.cancel();
    if (accept) {
      widget.onAccept();
    } else {
      widget.onDecline();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Map<String, String> get _t {
    const table = {
      'de': {
        'title': 'Fernwartung-Anfrage',
        'body': '„%s" möchte Ihren Bildschirm sehen und steuern, um Ihnen zu helfen. '
            'Es wird nichts ohne Ihre Zustimmung übertragen.',
        'note': 'Sie sehen die ganze Zeit einen Hinweis und können jederzeit auf „Stopp" tippen.',
        'allow': 'Erlauben',
        'deny': 'Ablehnen',
      },
      'ro': {
        'title': 'Cerere de asistență la distanță',
        'body': '„%s" dorește să vă vadă și să vă controleze ecranul pentru a vă ajuta. '
            'Nu se transmite nimic fără acordul dvs.',
        'note': 'Veți vedea tot timpul un mesaj și puteți apăsa „Stop" oricând.',
        'allow': 'Permite',
        'deny': 'Refuză',
      },
      'uk': {
        'title': 'Запит на віддалену підтримку',
        'body': '«%s» хоче бачити та керувати вашим екраном, щоб допомогти вам. '
            'Нічого не передається без вашої згоди.',
        'note': 'Ви весь час бачитимете повідомлення й можете натиснути «Стоп» будь-коли.',
        'allow': 'Дозволити',
        'deny': 'Відхилити',
      },
      'tr': {
        'title': 'Uzaktan destek isteği',
        'body': '„%s" size yardımcı olmak için ekranınızı görmek ve kontrol etmek istiyor. '
            'İzniniz olmadan hiçbir şey aktarılmaz.',
        'note': 'Her zaman bir uyarı görürsünüz ve istediğiniz an „Durdur"a dokunabilirsiniz.',
        'allow': 'İzin ver',
        'deny': 'Reddet',
      },
      'en': {
        'title': 'Remote support request',
        'body': '"%s" would like to see and control your screen to help you. '
            'Nothing is shared without your consent.',
        'note': 'You will see a banner the whole time and can tap "Stop" at any moment.',
        'allow': 'Allow',
        'deny': 'Decline',
      },
    };
    final code = LanguageService.instance.currentCode;
    return table[code] ?? table['de']!;
  }

  @override
  Widget build(BuildContext context) {
    final t = _t;
    final body = t['body']!.replaceAll('%s', widget.controllerName);
    return Material(
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 440),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 36,
                child: Icon(Icons.screen_share, size: 36),
              ),
              const SizedBox(height: 16),
              Text(
                t['title']!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(body, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, size: 16, color: context.colors.textSecondary),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      t['note']!,
                      style: TextStyle(fontSize: 12, color: context.colors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _finish(accept: false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: context.colors.dangerFg,
                      ),
                      child: Text('${t['deny']!} ($_remaining)'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => _finish(accept: true),
                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: Text(t['allow']!),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
