import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Canvas-art rendering helpers.
///
/// Lesson/slide diagram art is stored as one of two things in `canvasSvg`:
///   - a JavaScript `draw(ctx, W, H)` function (the modern format), or
///   - raw `<svg>` markup (legacy art generated before the switch).
///
/// [isSvgCanvas] tells the two apart, [buildCanvasArt] renders whichever it
/// is, and [showCanvasFullScreen] opens the same art blown up to fill the
/// screen. The JS path runs inside a fixed HTML5 `<canvas>` host built by
/// [buildCanvasHtml] — only the draw function changes between diagrams, so the
/// surrounding page is reused verbatim every time.

/// True when [content] is legacy raw SVG markup rather than a JS draw function.
bool isSvgCanvas(String content) => content.contains('<svg');

/// Wraps an AI-generated `draw(ctx, W, H)` function in a reusable HTML page
/// that owns the `<canvas>`, scales for devicePixelRatio, clears to a
/// transparent dark background, and calls `draw()` once (re-running it on
/// resize). A thrown error inside `draw` is caught so a bad function degrades
/// to a small label instead of a blank/broken view.
String buildCanvasHtml(String drawFunction) {
  return '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<style>
  html, body { margin: 0; padding: 0; height: 100%; background: transparent; overflow: hidden; }
  #c { display: block; width: 100vw; height: 100vh; }
</style>
</head>
<body>
<canvas id="c"></canvas>
<script>
const canvas = document.getElementById('c');
const ctx = canvas.getContext('2d');
function _render() {
  const dpr = window.devicePixelRatio || 1;
  const W = window.innerWidth, H = window.innerHeight;
  canvas.width = Math.floor(W * dpr);
  canvas.height = Math.floor(H * dpr);
  ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
  ctx.clearRect(0, 0, W, H);
  try {
    draw(ctx, W, H);
  } catch (e) {
    ctx.fillStyle = '#94A3B8';
    ctx.font = '12px sans-serif';
    ctx.fillText('Diagram error', 10, 20);
  }
}
$drawFunction
window.addEventListener('resize', _render);
_render();
</script>
</body>
</html>
''';
}

/// Renders a JS `draw(ctx, W, H)` function inside a transparent WebView canvas.
/// Rebuilds its controller when the function changes (e.g. after regenerate).
class CanvasHtmlView extends StatefulWidget {
  final String drawFunction;

  const CanvasHtmlView({super.key, required this.drawFunction});

  @override
  State<CanvasHtmlView> createState() => _CanvasHtmlViewState();
}

class _CanvasHtmlViewState extends State<CanvasHtmlView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(CanvasHtmlView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.drawFunction != widget.drawFunction) _load();
  }

  void _load() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(buildCanvasHtml(widget.drawFunction));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}

/// Renders [content] as the right kind of canvas art: a scalable SVG for
/// legacy markup, or a live HTML5 canvas for a JS draw function.
/// [svgPlaceholder] is used only on the SVG path (e.g. a tap-to-generate
/// fallback when the markup fails to parse).
Widget buildCanvasArt(
  String content, {
  BoxFit fit = BoxFit.contain,
  WidgetBuilder? svgPlaceholder,
}) {
  if (isSvgCanvas(content)) {
    return SvgPicture.string(
      content,
      fit: fit,
      placeholderBuilder: svgPlaceholder,
    );
  }
  return CanvasHtmlView(drawFunction: content);
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
