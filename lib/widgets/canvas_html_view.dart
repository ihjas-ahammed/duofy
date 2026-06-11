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
  final trimmed = content.trim();
  return trimmed.startsWith('<') ||
      trimmed.toLowerCase().contains('<svg') ||
      trimmed.toLowerCase().contains('xmlns="http://www.w3.org/2000/svg"');
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
  const { W, H, dpr } = _sizeCanvas();
  if (typeof sketch === 'function') {
    if (__setupRan) return;
    __setupRan = true;
    try {
      if (typeof window.THREE === 'undefined' || !/WebGLRenderer|new\\s+THREE\\.WebGL/.test(sketch.toString())) {
        ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      }
      sketch(canvas, W, H);
    } catch (e) { _showError(e.message || String(e)); }
    return;
  }
  if (typeof draw === 'function') {
    try {
      // --- Auto-fit: render offscreen, measure bounds, re-render scaled ---
      const REF = Math.max(W, H, 800);
      const off = document.createElement('canvas');
      off.width = REF; off.height = REF;
      const oc = off.getContext('2d');
      oc.clearRect(0, 0, REF, REF);
      draw(oc, REF, REF);

      // Scan pixels to find content bounding box
      const imgData = oc.getImageData(0, 0, REF, REF);
      const px = imgData.data;
      let minX = REF, minY = REF, maxX = 0, maxY = 0;
      let found = false;
      // Sample every 2nd pixel for speed
      for (let y = 0; y < REF; y += 2) {
        for (let x = 0; x < REF; x += 2) {
          const i = (y * REF + x) * 4;
          if (px[i+3] > 10) { // non-transparent pixel
            if (x < minX) minX = x;
            if (x > maxX) maxX = x;
            if (y < minY) minY = y;
            if (y > maxY) maxY = y;
            found = true;
          }
        }
      }

      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      ctx.clearRect(0, 0, W, H);

      if (!found) {
        // Nothing drawn, just render normally
        draw(ctx, W, H);
      } else {
        // Add a small padding around the content
        const pad = 16;
        minX = Math.max(0, minX - pad);
        minY = Math.max(0, minY - pad);
        maxX = Math.min(REF, maxX + pad);
        maxY = Math.min(REF, maxY + pad);

        const contentW = maxX - minX;
        const contentH = maxY - minY;
        if (contentW < 1 || contentH < 1) {
          draw(ctx, W, H);
        } else {
          const scaleX = W / contentW;
          const scaleY = H / contentH;
          const scale = Math.min(scaleX, scaleY, 1.5); // cap upscale at 1.5x
          const drawW = contentW * scale;
          const drawH = contentH * scale;
          const offsetX = (W - drawW) / 2;
          const offsetY = (H - drawH) / 2;

          ctx.save();
          ctx.translate(offsetX, offsetY);
          ctx.scale(scale, scale);
          ctx.translate(-minX, -minY);
          draw(ctx, REF, REF);
          ctx.restore();
        }
      }
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
  VoidCallback? onSvgError,
}) {
  if (isSvgCanvas(content)) {
    return SvgPicture.string(
      content,
      fit: fit,
      placeholderBuilder: svgPlaceholder,
      errorBuilder: onSvgError != null
          ? (context, error, stackTrace) {
              WidgetsBinding.instance.addPostFrameCallback((_) => onSvgError());
              return svgPlaceholder?.call(context) ?? const SizedBox.shrink();
            }
          : null,
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
                    ? CanvasDoubleTapDetector(
                        onDoubleTap: () => showCanvasCodeDialog(context, content),
                        child: InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 5,
                          child: Center(
                            child: SvgPicture.string(content, fit: BoxFit.contain),
                          ),
                        ),
                      )
                    : CanvasDoubleTapDetector(
                        onDoubleTap: () => showCanvasCodeDialog(context, content),
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 3 / 2,
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
  State<CanvasDoubleTapDetector> createState() => _CanvasDoubleTapDetectorState();
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.white12),
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
                        const Text(
                          'Source Code',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isSvg
                                ? AppTheme.duoGreen.withOpacity(0.15)
                                : AppTheme.duoBlue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSvg
                                  ? AppTheme.duoGreen.withOpacity(0.3)
                                  : AppTheme.duoBlue.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            isSvg ? 'SVG Vector Markup' : 'JS Canvas / Three.js',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: isSvg ? AppTheme.duoGreen : AppTheme.duoBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.x, color: Colors.white54, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Code Area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF020617),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SelectableText(
                      code.trim(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Color(0xFFE2E8F0),
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                        Clipboard.setData(ClipboardData(text: code));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white54,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
