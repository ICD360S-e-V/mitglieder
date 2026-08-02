import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Nachrichtentext, in dem enthaltene Links anklickbar sind.
///
/// Bewusst gemeinsam genutzt: die Linkerkennung lag vorher nur in
/// [ChatMessageBubble], weshalb derselbe Link im Live-Chat als toter
/// Fliesstext ankam. Jede Chat-Blase benutzt jetzt dieselbe Logik.
class LinkifiedText extends StatefulWidget {
  const LinkifiedText(
    this.text, {
    super.key,
    required this.style,
    this.linkColor,
  });

  final String text;
  final TextStyle style;

  /// Farbe des Links; ohne Angabe eine helle bzw. dunkle Blaustufe,
  /// passend zur Textfarbe der Blase.
  final Color? linkColor;

  /// Findet http(s)- und www-Adressen. Klammern und Anfuehrungszeichen enden
  /// die URL, damit "(siehe https://x.de/a)" nicht die Klammer mitnimmt.
  static final RegExp urlRegex = RegExp(
    r'(?:https?://|www\.)[^\s<>"\x27()\[\]]+',
    caseSensitive: false,
  );

  /// Satzzeichen am Ende gehoeren zum Satz, nicht zur Adresse.
  static String trimTrailingPunctuation(String url) {
    var end = url.length;
    while (end > 0 && '.,;:!?'.contains(url[end - 1])) {
      end--;
    }
    return url.substring(0, end);
  }

  @override
  State<LinkifiedText> createState() => _LinkifiedTextState();
}

class _LinkifiedTextState extends State<LinkifiedText> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  Future<void> _open(String url) async {
    final normalized = url.toLowerCase().startsWith('www.') ? 'https://$url' : url;
    final uri = Uri.tryParse(normalized);
    if (uri == null) return;
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Link konnte nicht geöffnet werden')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();

    final matches = LinkifiedText.urlRegex.allMatches(widget.text).toList();
    if (matches.isEmpty) {
      return Text(widget.text, style: widget.style);
    }

    final baseColor = widget.style.color ?? Colors.black87;
    final linkColor = widget.linkColor ??
        (baseColor.computeLuminance() > 0.5
            ? Colors.lightBlueAccent
            : Colors.blue.shade700);

    final spans = <TextSpan>[];
    var lastEnd = 0;
    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: widget.text.substring(lastEnd, match.start)));
      }
      final raw = match.group(0)!;
      final url = LinkifiedText.trimTrailingPunctuation(raw);
      if (url.isEmpty) {
        spans.add(TextSpan(text: raw));
        lastEnd = match.end;
        continue;
      }
      final recognizer = TapGestureRecognizer()..onTap = () => _open(url);
      _recognizers.add(recognizer);
      spans.add(TextSpan(
        text: url,
        style: widget.style.copyWith(
          color: linkColor,
          decoration: TextDecoration.underline,
          decorationColor: linkColor,
        ),
        recognizer: recognizer,
      ));
      if (url.length < raw.length) {
        spans.add(TextSpan(text: raw.substring(url.length)));
      }
      lastEnd = match.end;
    }
    if (lastEnd < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(lastEnd)));
    }

    return RichText(
      text: TextSpan(style: widget.style, children: spans),
    );
  }
}
