import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
bool isSvgCanvas(String content) => content.contains('<svg');

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
  html, body { margin: 0; padding: 0; height: 100%; background: transparent; overflow: hidden; touch-action: none; }
  #c { display: block; width: 100vw; height: 100vh; }
</style>
$threeTag
</head>
<body>
<canvas id="c"></canvas>
<script>
const canvas = document.getElementById('c');
const ctx = canvas.getContext('2d');
let __setupRan = false;
function _sizeCanvas() {
  const dpr = window.devicePixelRatio || 1;
  const W = window.innerWidth, H = window.innerHeight;
  canvas.width = Math.floor(W * dpr);
  canvas.height = Math.floor(H * dpr);
  canvas.style.width = W + 'px';
  canvas.style.height = H + 'px';
  return { W: W, H: H, dpr: dpr };
}
function _showError(msg) {
  try {
    const { W, H } = _sizeCanvas();
    const c2 = canvas.getContext('2d');
    c2.setTransform(1, 0, 0, 1, 0, 0);
    c2.clearRect(0, 0, canvas.width, canvas.height);
    c2.fillStyle = '#94A3B8';
    c2.font = '12px sans-serif';
    c2.fillText('Diagram error: ' + msg, 10, 20);
    if (window.DuoErrorChannel) {
      window.DuoErrorChannel.postMessage(msg);
    }
  } catch (_) {}
}
window.addEventListener('error', function(e) { _showError(e.message || 'unknown'); });
function _render() {
  const { W, H, dpr } = _sizeCanvas();
  if (typeof sketch === 'function') {
    if (__setupRan) return; // sketch owns its own lifecycle; resize just resizes the canvas.
    __setupRan = true;
    try {
      // 2D path: pre-scale for devicePixelRatio so coordinates are CSS pixels.
      if (typeof window.THREE === 'undefined' || !/WebGLRenderer|new\\s+THREE\\.WebGL/.test(sketch.toString())) {
        ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      }
      sketch(canvas, W, H);
    } catch (e) { _showError(e.message || String(e)); }
    return;
  }
  if (typeof draw === 'function') {
    try {
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      ctx.clearRect(0, 0, W, H);
      draw(ctx, W, H);
    } catch (e) { _showError(e.message || String(e)); }
    return;
  }
  _showError('no draw() or sketch() defined');
}
$userJs
let __lastW = 0, __lastH = 0, __stableFrames = 0;
function _waitForLayout() {
  if (__setupRan) return;
  const W = window.innerWidth, H = window.innerHeight;
  if (W > 10 && H > 10) {
    if (W === __lastW && H === __lastH) {
      __stableFrames++;
      if (__stableFrames > 2) {
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

  const CanvasHtmlView({super.key, required this.drawFunction, this.onJsError});

  @override
  Widget build(BuildContext context) {
    return PlatformWebView(
      html: buildCanvasHtml(drawFunction),
      onJsError: onJsError,
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
}) {
  if (isSvgCanvas(content)) {
    return SvgPicture.string(
      content,
      fit: fit,
      placeholderBuilder: svgPlaceholder,
    );
  }
  return CanvasHtmlView(drawFunction: content, onJsError: onJsError);
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
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: isSvg
                    ? InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 5,
                        child: Center(
                          child: SvgPicture.string(content, fit: BoxFit.contain),
                        ),
                      )
                    : CanvasHtmlView(drawFunction: content),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(LucideIcons.x, size: 22, color: Colors.white),
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
