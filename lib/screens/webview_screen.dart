import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  /// Returns true if the current platform supports embedded WebView
  static bool get isWebViewSupported =>
      Platform.isAndroid || Platform.isIOS || Platform.isMacOS;

  /// Opens URL: WebView on mobile/macOS, external browser on Windows/Linux
  static void openUrl(BuildContext context, String title, String url) {
    if (isWebViewSupported) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(title: title, url: url),
        ),
      );
    } else {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  const WebViewScreen({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String _currentUrl = '';
  bool _canGoBack = false;
  bool _canGoForward = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // Security: URL whitelist - only allow trusted domains
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.parse(request.url);
            // Whitelist: Only ICD360S domain and HTTPS
            if (uri.scheme == 'https' && uri.host.endsWith('icd360s.de')) {
              return NavigationDecision.navigate;
            }
            // Block all other URLs (including http://)
            debugPrint('[WebView] Blocked navigation to: ${request.url}');
            return NavigationDecision.prevent;
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _currentUrl = url;
              });
            }
          },
          onPageFinished: (String url) async {
            if (mounted) {
              final canGoBack = await _controller.canGoBack();
              final canGoForward = await _controller.canGoForward();
              setState(() {
                _isLoading = false;
                _currentUrl = url;
                _canGoBack = canGoBack;
                _canGoForward = canGoForward;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.loadingErrorGeneric(error.description)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF4a90d9),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _canGoBack
                ? () async {
                    await _controller.goBack();
                    final canGoBack = await _controller.canGoBack();
                    final canGoForward = await _controller.canGoForward();
                    if (mounted) {
                      setState(() {
                        _canGoBack = canGoBack;
                        _canGoForward = canGoForward;
                      });
                    }
                  }
                : null,
            tooltip: AppLocalizations.of(context)!.goBack,
          ),
          // Forward button
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _canGoForward
                ? () async {
                    await _controller.goForward();
                    final canGoBack = await _controller.canGoBack();
                    final canGoForward = await _controller.canGoForward();
                    if (mounted) {
                      setState(() {
                        _canGoBack = canGoBack;
                        _canGoForward = canGoForward;
                      });
                    }
                  }
                : null,
            tooltip: AppLocalizations.of(context)!.goForward,
          ),
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
            tooltip: AppLocalizations.of(context)!.refresh,
          ),
          // Home button
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              _controller.loadRequest(Uri.parse(widget.url));
            },
            tooltip: AppLocalizations.of(context)!.homePage,
          ),
        ],
      ),
      body: Column(
        children: [
          // Loading indicator
          if (_isLoading)
            const LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4a90d9)),
            ),
          // URL bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Icon(
                  Icons.lock,
                  size: 16,
                  color: _currentUrl.startsWith('https')
                      ? Colors.green
                      : Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _currentUrl.isNotEmpty ? _currentUrl : widget.url,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // WebView content
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
