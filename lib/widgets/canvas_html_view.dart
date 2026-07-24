import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import 'platform_webview.dart';

/// Canvas-art rendering helpers.
///
/// Lesson/slide diagram art is stored as one of two things in `canvasSvg`:
///   - a JavaScript program (modern format) — either a `draw(ctx, W, H)`
///     function (static 2D), or a `sketch(canvas, W, H)` function
///     (interactive 2D / 3D via THREE.js), or
///   - raw `<svg>` markup (legacy art generated before the JS switch).
///
/// [isSvgCanvas] tells the two apart, [buildCanvasArt] renders whichever it
/// is, and [showCanvasFullScreen] opens the same art blown up to fill the
/// screen. The JS path runs inside a fixed HTML5 `<canvas>` host built by
/// [buildCanvasHtml] — only the user JS changes between diagrams, so the
/// surrounding page (THREE.js loader, sizing, error handler) is reused
/// verbatim every time.

/// True when [content] is legacy raw SVG markup rather than a JS program.
bool isSvgCanvas(String content) {
  return content.trim().startsWith('<');
}

/// Aspect ratio (w/h) declared by raw SVG art via its viewBox (or width/
/// height attributes), clamped to [4:3, 16:9] so extreme shapes can't turn
/// the art box into a sliver or a tower. Returns 3:2 when the SVG declares
/// nothing parseable — the historical fixed ratio, kept as the JS-canvas and
/// fallback shape.
double svgAspect(String svg) {
  const fallback = 3 / 2;
  double? w, h;
  final viewBox = RegExp(
    r'viewBox\s*=\s*"([^"]+)"',
    caseSensitive: false,
  ).firstMatch(svg);
  if (viewBox != null) {
    final parts = viewBox.group(1)!.trim().split(RegExp(r'[\s,]+'));
    if (parts.length == 4) {
      w = double.tryParse(parts[2]);
      h = double.tryParse(parts[3]);
    }
  }
  if (w == null || h == null) {
    double? attr(String name) {
      final m = RegExp(
        '$name\\s*=\\s*"([0-9.]+)',
        caseSensitive: false,
      ).firstMatch(svg);
      return m == null ? null : double.tryParse(m.group(1)!);
    }

    w = attr('width');
    h = attr('height');
  }
  if (w == null || h == null || w <= 0 || h <= 0) return fallback;
  return (w / h).clamp(4 / 3, 16 / 9).toDouble();
}

double canvasAspect(String content) {
  if (isSvgCanvas(content)) {
    return svgAspect(content);
  }
  final trimmed = content.trim();
  final match = RegExp(
    r'//\s*(?:ASPECT_RATIO|aspect_ratio|aspectRatio|AspectRatio)\s*:\s*([0-9.:/]+)',
    caseSensitive: false,
  ).firstMatch(trimmed);
  if (match != null) {
    final val = match.group(1)!.trim();
    if (val.contains(':')) {
      final parts = val.split(':');
      if (parts.length == 2) {
        final w = double.tryParse(parts[0]);
        final h = double.tryParse(parts[1]);
        if (w != null && h != null && h > 0) {
          return (w / h).clamp(4 / 3, 16 / 9).toDouble();
        }
      }
    } else if (val.contains('/')) {
      final parts = val.split('/');
      if (parts.length == 2) {
        final w = double.tryParse(parts[0]);
        final h = double.tryParse(parts[1]);
        if (w != null && h != null && h > 0) {
          return (w / h).clamp(4 / 3, 16 / 9).toDouble();
        }
      }
    } else {
      final parsed = double.tryParse(val);
      if (parsed != null && parsed > 0) {
        return parsed.clamp(4 / 3, 16 / 9).toDouble();
      }
    }
  }
  return 3 / 2;
}

/// Heuristic: program needs THREE.js when it references `THREE.` or uses
/// the WebGL context name (some models add a manual fallback). Used to
/// decide whether to pull in the three.js CDN bundle.
bool _needsThreeJs(String js) {
  final s = js.replaceAll(RegExp(r'//.*'), '');
  return s.contains('THREE.') || s.contains('WebGLRenderer');
}

/// Wraps the AI-generated JavaScript in a reusable HTML page that owns the
/// `<canvas>`, scales for devicePixelRatio, clears to a transparent dark
/// background, loads THREE.js when the JS references it, and dispatches to
/// whichever entry point the program defined:
///   - `function sketch(canvas, W, H)` — interactive / animated / 3D.
///   - `function draw(ctx, W, H)` — static single-frame 2D.
/// A thrown error inside user code is caught so a bad program degrades to a
/// small label instead of a blank/broken view.
String buildCanvasHtml(String userJs) {
  final needsThree = _needsThreeJs(userJs);
  final threeTag = needsThree
      ? '<script src="https://unpkg.com/three@0.150.1/build/three.min.js"></script>'
      : '';
  return '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<style>
  html, body { margin: 0; padding: 0; height: 100%; background: #10172a; overflow: hidden; touch-action: none; }
  #c, #s { display: block; width: 100vw; height: 100vh; }
</style>
$threeTag
</head>
<body>
<canvas id="c"></canvas>
<svg id="s" style="display:none;"></svg>
<script>
window.canvas = document.getElementById('c');
window.svg = document.getElementById('s');
window.ctx = window.canvas.getContext('2d');

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

window.console.log = function() {
  if (window.DuoMessageChannel && typeof window.DuoMessageChannel.postMessage === 'function') {
    window.DuoMessageChannel.postMessage('[JS LOG] ' + Array.prototype.slice.call(arguments).join(' '));
  }
};
window.console.error = function() {
  if (window.DuoErrorChannel && typeof window.DuoErrorChannel.postMessage === 'function') {
    window.DuoErrorChannel.postMessage('[JS ERROR] ' + Array.prototype.slice.call(arguments).join(' '));
  }
};

console.log('HTML wrapper script initialized. devicePixelRatio:', window.devicePixelRatio);

let __setupRan = false;
let __lastSetupW = 0, __lastSetupH = 0;
function _sizeCanvas() {
  const dpr = window.devicePixelRatio || 1;
  const W = Math.floor(window.innerWidth), H = Math.floor(window.innerHeight);
  window.canvas.width = Math.floor(W * dpr);
  window.canvas.height = Math.floor(H * dpr);
  window.canvas.style.width = W + 'px';
  window.canvas.style.height = H + 'px';
  console.log('_sizeCanvas runs. W:', W, 'H:', H, 'dpr:', dpr, 'canvasWidth:', window.canvas.width, 'canvasHeight:', window.canvas.height);
  return { W: W, H: H, dpr: dpr };
}
function _showError(msg) {
  try {
    console.error('showError triggered inside HTML wrapper: ' + msg);
    const { W, H } = _sizeCanvas();
    const c2 = window.canvas.getContext('2d');
    c2.setTransform(1, 0, 0, 1, 0, 0);
    c2.clearRect(0, 0, window.canvas.width, window.canvas.height);
    c2.fillStyle = '#94A3B8';
    c2.font = '12px sans-serif';
    c2.fillText('Diagram error: ' + msg, 10, 20);
    
    let retries = 0;
    function send() {
      let sent = false;
      if (window.DuoErrorChannel && typeof window.DuoErrorChannel.postMessage === 'function') {
        window.DuoErrorChannel.postMessage(msg);
        sent = true;
      } else if (typeof window.DuoErrorChannel === 'function') {
        window.DuoErrorChannel(msg);
        sent = true;
      } else if (typeof DuoErrorChannel === 'function') {
        DuoErrorChannel(msg);
        sent = true;
      }
      
      if (!sent && retries < 100) {
        retries++;
        setTimeout(send, 50);
      }
    }
    send();
  } catch (_) {}
}
window.addEventListener('error', function(e) { _showError(e.message || 'unknown'); });
window.addEventListener('unhandledrejection', function(e) { _showError(e.reason || 'unhandled promise rejection'); });
function _render() {
  console.log('_render called');
  const { W, H, dpr } = _sizeCanvas();
  window.canvas.style.display = 'block';
  window.svg.style.display = 'none';
  if (typeof sketch === 'function') {
    console.log('_render: sketch function detected');
    try {
      if (typeof window.THREE === 'undefined' || !/WebGLRenderer|new\\s+THREE\\.WebGL/.test(sketch.toString())) {
        window.ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      }
    } catch (e) { _showError(e.message || String(e)); }
    if (__setupRan) {
      if (Math.abs(W - __lastSetupW) > 8 || Math.abs(H - __lastSetupH) > 8) {
        console.log('Size changed significantly post-setup. Reloading page. Old:', __lastSetupW, 'x', __lastSetupH, 'New:', W, 'x', H);
        window.location.reload();
        return;
      }
      console.log('_render: sketch already setup, skipping rerun');
      return;
    }
    __lastSetupW = W;
    __lastSetupH = H;
    __setupRan = true;
    try {
      console.log('Invoking sketch()...');
      sketch(window.canvas, W, H);
      console.log('sketch() successfully invoked');
    } catch (e) { _showError(e.message || String(e)); }
    return;
  }
  if (typeof draw === 'function') {
    try {
      const drawStr = draw.toString();
      const isSvgDraw = /^\\s*(function\\s+)?draw\\s*\\(\\s*svg\\b/.test(drawStr) || 
                        /\\(\\s*svg\\b/.test(drawStr) ||
                        /svg/i.test(drawStr.split(')')[0]);
      if (isSvgDraw) {
        window.canvas.style.display = 'none';
        window.svg.style.display = 'block';
        window.svg.setAttribute('width', W);
        window.svg.setAttribute('height', H);
        window.svg.setAttribute('viewBox', `0 0 \${W} \${H}`);
        window.svg.innerHTML = '';
        draw(window.svg, W, H);
        return;
      }

      window.canvas.style.display = 'block';
      window.svg.style.display = 'none';

      window.ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      window.ctx.clearRect(0, 0, W, H);
      draw(window.ctx, W, H);
    } catch (e) { _showError(e.message || String(e)); }
    return;
  }
  _showError('no draw() or sketch() defined');
}
</script>
<script>
$userJs
</script>
<script>
let __lastW = 0, __lastH = 0, __stableFrames = 0;
function _waitForLayout() {
  if (__setupRan) return;
  const W = Math.floor(window.innerWidth), H = Math.floor(window.innerHeight);
  console.log('_waitForLayout tick. W:', W, 'H:', H, 'lastW:', __lastW, 'lastH:', __lastH, 'stableFrames:', __stableFrames);
  if (W > 10 && H > 10) {
    if (W === __lastW && H === __lastH) {
      __stableFrames++;
      if (__stableFrames > 2) {
        console.log('Layout stabilized! Running render loop.');
        _render();
        window.addEventListener('resize', _render);
        return;
      }
    } else {
      __lastW = W;
      __lastH = H;
      __stableFrames = 0;
    }
  }
  requestAnimationFrame(_waitForLayout);
}
_waitForLayout();
</script>
</body>
</html>
''';
}

/// Renders a JS program (draw() or sketch()) inside a transparent WebView
/// canvas. Backed by [PlatformWebView] so the same program runs on every
/// platform — webview_flutter on mobile/desktop-with-native-support, and
/// webview_cef on Linux.
class CanvasHtmlView extends StatelessWidget {
  final String drawFunction;
  final ValueChanged<String>? onJsError;
  final ValueChanged<String>? onMessage;

  const CanvasHtmlView({
    super.key,
    required this.drawFunction,
    this.onJsError,
    this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('[CanvasHtmlView] Rendering drawFunction (length: ${drawFunction.length})');
    return PlatformWebView(
      html: buildCanvasHtml(drawFunction),
      onJsError: onJsError,
      onMessage: onMessage,
    );
  }
}

/// Renders [content] as the right kind of canvas art: a scalable SVG for
/// legacy markup, or a live HTML5 canvas for a JS program.
/// [svgPlaceholder] is used only on the SVG path (e.g. a tap-to-generate
/// fallback when the markup fails to parse).
Widget buildCanvasArt(
  String content, {
  BoxFit fit = BoxFit.contain,
  WidgetBuilder? svgPlaceholder,
  ValueChanged<String>? onJsError,
  VoidCallback? onSvgError,
  ValueChanged<String>? onMessage,
}) {
  final isSvg = isSvgCanvas(content);
  debugPrint('[buildCanvasArt] content length: ${content.length}, isSvg: $isSvg');
  if (isSvg) {
    debugPrint('[buildCanvasArt] Rendering as SVG picture');
    return SvgPicture.string(
      content,
      fit: fit,
      placeholderBuilder: svgPlaceholder,
      errorBuilder: onSvgError != null
          ? (context, error, stackTrace) {
              debugPrint('[buildCanvasArt] SvgPicture parsing error: $error');
              WidgetsBinding.instance.addPostFrameCallback((_) => onSvgError());
              return svgPlaceholder?.call(context) ?? const SizedBox.shrink();
            }
          : null,
    );
  }
  debugPrint('[buildCanvasArt] Rendering as CanvasHtmlView');
  return CanvasHtmlView(
    drawFunction: content,
    onJsError: onJsError,
    onMessage: onMessage,
  );
}

/// Opens [content] in a full-screen viewer. SVG art is wrapped in an
/// [InteractiveViewer] so it can be pinch-zoomed; the JS canvas simply fills
/// the screen (and re-renders at the larger size for crisp output).
void showCanvasFullScreen(BuildContext context, String content) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _CanvasFullScreenScreen(content: content),
    ),
  );
}

class _CanvasFullScreenScreen extends StatelessWidget {
  final String content;

  const _CanvasFullScreenScreen({required this.content});

  @override
  Widget build(BuildContext context) {
    final isSvg = isSvgCanvas(content);
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: isSvg
                    ? CanvasDoubleTapDetector(
                        onDoubleTap: () =>
                            showCanvasCodeDialog(context, content),
                        child: InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 5,
                          child: Center(
                            child: SvgPicture.string(
                              content,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : CanvasDoubleTapDetector(
                        onDoubleTap: () =>
                            showCanvasCodeDialog(context, content),
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: canvasAspect(content),
                            child: CanvasHtmlView(drawFunction: content),
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: context.colors.surfaceAlt,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(LucideIcons.x, size: 22, color: context.colors.textPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper widget to detect double taps even on top of PlatformViews/WebViews
/// that would normally swallow standard Flutter gestures.
class CanvasDoubleTapDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onDoubleTap;

  const CanvasDoubleTapDetector({
    super.key,
    required this.child,
    required this.onDoubleTap,
  });

  @override
  State<CanvasDoubleTapDetector> createState() =>
      _CanvasDoubleTapDetectorState();
}

class _CanvasDoubleTapDetectorState extends State<CanvasDoubleTapDetector> {
  DateTime? _lastTap;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        final now = DateTime.now();
        if (_lastTap != null &&
            now.difference(_lastTap!) < const Duration(milliseconds: 320)) {
          _lastTap = null;
          widget.onDoubleTap();
        } else {
          _lastTap = now;
        }
      },
      child: widget.child,
    );
  }
}

void showCanvasCodeDialog(BuildContext context, String code) {
  final isSvg = isSvgCanvas(code);
  final displayText = isSvg ? code : buildCanvasHtml(code);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: context.colors.outline),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Source Code',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: context.colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isSvg
                                ? AppTheme.duoGreen.withValues(alpha: 0.15)
                                : AppTheme.duoBlue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSvg
                                  ? AppTheme.duoGreen.withValues(alpha: 0.3)
                                  : AppTheme.duoBlue.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            isSvg
                                ? 'SVG Vector Markup'
                                : 'JS Canvas / Three.js',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: isSvg
                                  ? AppTheme.duoGreen
                                  : AppTheme.duoBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      LucideIcons.x,
                      color: context.colors.textFaint,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Code Area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.surfaceAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.colors.outline),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: SelectableText(
                      displayText.trim(),
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: context.colors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Actions
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.duoBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(LucideIcons.copy, size: 16),
                      label: const Text(
                        'Copy Code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: displayText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: context.colors.textFaint,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Close',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}