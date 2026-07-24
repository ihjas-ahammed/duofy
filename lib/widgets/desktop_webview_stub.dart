import 'package:flutter/material.dart';

import 'platform_webview.dart' show PlatformWebViewController;

/// Web stand-in for desktop_webview_io.dart: never used at runtime
/// ([useDesktopWebView] is false), exists so the conditional import resolves
/// without pulling webview_cef / webview_windows into the web build.
bool get useDesktopWebView => false;

Future<void> desktopWebViewEnsureInitialized() => Future.value();

class DesktopWebView extends StatelessWidget {
  final String html;
  final ValueChanged<String>? onJsError;
  final ValueChanged<String>? onMessage;
  final void Function(PlatformWebViewController)? onControllerCreated;

  const DesktopWebView({
    super.key,
    required this.html,
    this.onJsError,
    this.onMessage,
    this.onControllerCreated,
  });

  @override
  Widget build(BuildContext context) =>
      throw UnsupportedError('DesktopWebView is not available on this platform');
}