import 'package:flutter_test/flutter_test.dart';
import 'package:flow/widgets/canvas_html_view.dart';
import 'package:flow/services/prompt_service.dart';

void main() {
  group('Canvas Art HTML & Responsive Mobile Viewport Evaluation', () {
    test('buildCanvasHtml produces mobile-optimized responsive HTML host', () {
      const sampleJs = '''
function draw(ctx, W, H) {
  ctx.fillStyle = "#3B82F6";
  ctx.fillRect(10, 10, W - 20, H - 20);
}
''';

      final html = buildCanvasHtml(sampleJs);

      // Verify viewport meta tag exists for mobile scaling
      expect(html, contains('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">'));

      // Verify box-sizing and responsive style declarations (prevent horizontal overflow)
      expect(html, contains('box-sizing: border-box'));
      expect(html, contains('width: 100%'));
      expect(html, contains('height: 100%'));
      expect(html, contains('overflow: hidden'));
      expect(html, contains('touch-action: none'));

      // Verify element IDs
      expect(html, contains('<canvas id="c"></canvas>'));
      expect(html, contains('<svg id="s" style="display:none;"></svg>'));

      // Verify bridge channel shims for DuoMessageChannel and DuoErrorChannel
      expect(html, contains("setupChannelShim('DuoMessageChannel')"));
      expect(html, contains("setupChannelShim('DuoErrorChannel')"));

      // Verify user JS injected
      expect(html, contains('function draw(ctx, W, H)'));
    });

    test('buildCanvasHtml injects Three.js when WebGL or THREE is referenced', () {
      const threeJs = '''
function sketch(canvas, W, H) {
  const THREE = window.THREE;
  const renderer = new THREE.WebGLRenderer({ canvas });
  renderer.setSize(W, H, false);
}
''';

      final html = buildCanvasHtml(threeJs);
      expect(html, contains('three.min.js'));
    });

    test('buildCanvasHtml omits Three.js when 2D canvas is used', () {
      const pure2D = '''
function draw(ctx, W, H) {
  ctx.stroke();
}
''';

      final html = buildCanvasHtml(pure2D);
      expect(html, isNot(contains('three.min.js')));
    });

    test('canvasAspect detects and clamps aspect ratios between 4:3 and 16:9', () {
      expect(canvasAspect('// ASPECT_RATIO: 16:9'), closeTo(16 / 9, 0.01));
      expect(canvasAspect('// ASPECT_RATIO: 4:3'), closeTo(4 / 3, 0.01));
      expect(canvasAspect('// ASPECT_RATIO: 1:1'), closeTo(4 / 3, 0.01)); // clamped to 4:3
      expect(canvasAspect('// ASPECT_RATIO: 21:9'), closeTo(16 / 9, 0.01)); // clamped to 16:9
      expect(canvasAspect('// no declared ratio'), closeTo(3 / 2, 0.01)); // default 3:2
    });

    test('isSvgCanvas distinguishes raw SVG from JS programs', () {
      expect(isSvgCanvas('<svg viewBox="0 0 300 200"></svg>'), isTrue);
      expect(isSvgCanvas('  <svg width="100" height="100"></svg>'), isTrue);
      expect(isSvgCanvas('function draw(ctx, W, H) {}'), isFalse);
      expect(isSvgCanvas('function sketch(canvas, W, H) {}'), isFalse);
    });

    test('PromptService.canvasArt includes mobile viewport bounds and touch constraints', () {
      final prompt = PromptService.canvasArt;
      expect(prompt, contains('STRICT SMALL MOBILE VIEWPORT CONTAINMENT'));
      expect(prompt, contains('Safe Margin Bounding Box'));
      expect(prompt, contains('Top Corners Safe Area'));
      expect(prompt, contains('Touch Hitboxes'));
      expect(prompt, contains('Dynamic & Safe Text Labels'));
    });
  });
}
