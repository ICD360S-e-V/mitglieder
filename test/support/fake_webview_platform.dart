// Ein Platzhalter für `webview_flutter`, damit der WebView-Bildschirm im Test
// überhaupt gebaut werden kann.
//
// Ohne eine gesetzte `WebViewPlatform.instance` bricht schon der Konstruktor
// des Controllers ab („A platform implementation for `webview_flutter` has not
// been set"). Geprüft wird hier nicht der Browser selbst — den gibt es im Test
// nicht —, sondern alles drumherum: Titelleiste mit fünf Schaltflächen,
// Fortschrittsbalken und Adresszeile. Genau dort saß in der App-Titelleiste
// derselbe Fehler.
import 'package:flutter/widgets.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class FakeWebViewPlatform extends WebViewPlatform {
  /// Setzt diese Attrappe als Plattform ein. Mehrfach aufrufbar.
  static void install() {
    WebViewPlatform.instance ??= FakeWebViewPlatform();
  }

  @override
  PlatformWebViewController createPlatformWebViewController(
    PlatformWebViewControllerCreationParams params,
  ) =>
      _FakeController(params);

  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(
    PlatformNavigationDelegateCreationParams params,
  ) =>
      _FakeNavigationDelegate(params);

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
    PlatformWebViewWidgetCreationParams params,
  ) =>
      _FakeWidget(params);
}

class _FakeController extends PlatformWebViewController {
  _FakeController(super.params) : super.implementation();

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) async {}

  @override
  Future<void> setPlatformNavigationDelegate(
      PlatformNavigationDelegate handler) async {}

  @override
  Future<void> loadRequest(LoadRequestParams params) async {}

  @override
  Future<void> reload() async {}

  @override
  Future<bool> canGoBack() async => false;

  @override
  Future<bool> canGoForward() async => false;
}

class _FakeNavigationDelegate extends PlatformNavigationDelegate {
  _FakeNavigationDelegate(super.params) : super.implementation();

  @override
  Future<void> setOnNavigationRequest(
      NavigationRequestCallback onNavigationRequest) async {}

  @override
  Future<void> setOnPageStarted(PageEventCallback onPageStarted) async {}

  @override
  Future<void> setOnPageFinished(PageEventCallback onPageFinished) async {}

  @override
  Future<void> setOnProgress(ProgressCallback onProgress) async {}

  @override
  Future<void> setOnWebResourceError(
      WebResourceErrorCallback onWebResourceError) async {}
}

class _FakeWidget extends PlatformWebViewWidget {
  _FakeWidget(super.params) : super.implementation();

  // Eine leere Fläche an der Stelle des Browsers: sie nimmt den Platz ein, den
  // der echte WebView einnähme, und beeinflusst das Layout drumherum genauso.
  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}
