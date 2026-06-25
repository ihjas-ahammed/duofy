import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../platform_webview.dart';
import '../duo_button.dart';

class CustomHtmlView extends StatefulWidget {
  final Slide slide;
  final VoidCallback onComplete;

  const CustomHtmlView({
    super.key,
    required this.slide,
    required this.onComplete,
  });

  @override
  State<CustomHtmlView> createState() => _CustomHtmlViewState();
}

class _CustomHtmlViewState extends State<CustomHtmlView> {
  bool _isCompleted = false;

  @override
  void didUpdateWidget(CustomHtmlView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id ||
        oldWidget.slide.interactiveCanvasHtml != widget.slide.interactiveCanvasHtml ||
        oldWidget.slide.content != widget.slide.content) {
      setState(() {
        _isCompleted = false;
      });
    }
  }

  String _wrapHtml(String userHtml) {
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <script>
    // Platform compatibility shims for DuoMessageChannel and DuoErrorChannel.
    // On some platforms (like Linux CEF), channels are registered as global functions
    // rather than objects with a postMessage method. We ensure postMessage is always
    // supported, and handle asynchronous injection.
    (function() {
      function setupChannelShim(name) {
        var channel = window[name];
        if (channel && typeof channel.postMessage === 'function') {
          return;
        }
        if (typeof channel === 'function') {
          const original = channel;
          window[name] = {
            postMessage: function(msg) {
              original(msg);
            }
          };
          return;
        }
        var pending = [];
        window[name] = {
          postMessage: function(msg) {
            console.log("Pending message for " + name + ":", msg);
            if (typeof window[name] === 'function') {
              window[name](msg);
            } else if (typeof window.chrome?.webview?.postMessage === 'function') {
              window.chrome.webview.postMessage(JSON.stringify({channel: name === 'DuoMessageChannel' ? 'message' : 'error', message: String(msg)}));
            } else {
              pending.push(msg);
            }
          }
        };
        var attempts = 0;
        var interval = setInterval(function() {
          attempts++;
          var current = window[name];
          if (typeof current === 'function') {
            const original = current;
            window[name] = {
              postMessage: function(msg) {
                original(msg);
              }
            };
            pending.forEach(function(msg) {
              original(msg);
            });
            clearInterval(interval);
          }
          if (attempts > 100) {
            clearInterval(interval);
          }
        }, 50);
      }
      setupChannelShim('DuoMessageChannel');
      setupChannelShim('DuoErrorChannel');
    })();
  </script>
  <style>
    :root {
      --duo-blue: #1cb0f6;
      --duo-green: #58cc02;
      --duo-orange: #ff9600;
      --duo-red: #ff4b4b;
      --duo-violet: #ce82ff;
      --background: #0b0f19;
      --surface: rgba(255, 255, 255, 0.05);
      --border: rgba(255, 255, 255, 0.1);
      --text-primary: #ffffff;
      --text-secondary: rgba(255, 255, 255, 0.6);
    }
    /* Hide scrollbar globally */
    ::-webkit-scrollbar {
      display: none;
    }
    html, body {
      scrollbar-width: none;
      -ms-overflow-style: none;
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
      background-color: transparent;
      color: var(--text-primary);
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      box-sizing: border-box;
      -webkit-font-smoothing: antialiased;
      overflow: auto; /* enable standard scroll gestures internally but without scrollbars */
    }
    * {
      box-sizing: border-box;
    }
  </style>
</head>
<body>
  $userHtml
</body>
</html>
''';
  }

  void _handleMessage(String message) {
    if (message == 'complete' || message == 'success') {
      if (!_isCompleted) {
        HapticFeedback.heavyImpact();
        setState(() {
          _isCompleted = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Webview taking full remaining screen space (edge-to-edge)
        Expanded(
          child: PlatformWebView(
            html: _wrapHtml(widget.slide.interactiveCanvasHtml ?? ''),
            onMessage: _handleMessage,
          ),
        ),
        bottomBarWidget,
      ],
    );
  }

  Widget get bottomBarWidget {
    if (_isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: const Color(0xFF111827),
        child: DuoButton(
          text: 'CONTINUE',
          color: AppTheme.duoGreen,
          shadowColor: AppTheme.duoGreenDark,
          onPressed: widget.onComplete,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF111827),
      child: Row(
        children: [
          DuoIconButton(
            color: AppTheme.duoOrange,
            shadowColor: AppTheme.duoOrangeDark,
            onPressed: widget.onComplete,
            icon: const Icon(
              Icons.skip_next_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DuoButton(
              text: 'INCOMPLETE',
              color: const Color(0xFF334155),
              shadowColor: const Color(0xFF1E293B),
              onPressed: () {}, // Disabled until JavaScript sends 'complete'
            ),
          ),
        ],
      ),
    );
  }
}
