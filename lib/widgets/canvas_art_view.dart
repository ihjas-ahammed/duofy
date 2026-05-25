import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';

/// Top-of-lesson / top-of-proof diagram widget. Renders an SVG produced by
/// the graphics AI and exposes a small regenerate affordance overlaid on
/// the art.
///
/// Behaviour:
/// - [svg] non-null & valid → diagram renders inside a glass card.
/// - [svg] null & [hasPrompt] true → "Generating…" placeholder while the
///   background canvas pass is still running, OR a "Tap to generate"
///   affordance if [isLoading] is false.
/// - [svg] null & [hasPrompt] false → returns [SizedBox.shrink] so no
///   space is reserved.
/// - SVG render failure → silently hides the panel so a malformed model
///   response never breaks the lesson layout.
class CanvasArtView extends StatelessWidget {
  final String? svg;
  final bool hasPrompt;
  final bool isLoading;
  final VoidCallback? onRegenerate;

  const CanvasArtView({
    super.key,
    required this.svg,
    required this.hasPrompt,
    this.isLoading = false,
    this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    // No prompt → no slot at all. We don\'t want an empty rectangle for
    // lessons the text AI decided didn\'t need a diagram.
    if (!hasPrompt && (svg == null || svg!.trim().isEmpty)) {
      return const SizedBox.shrink();
    }

    final hasSvg = svg != null && svg!.trim().isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: AspectRatio(
              aspectRatio: 16 / 7,
              child: hasSvg
                  ? SvgPicture.string(
                      svg!,
                      fit: BoxFit.contain,
                      // If the model returned malformed SVG we don\'t want a
                      // red error widget breaking the layout — show the
                      // generating placeholder instead.
                      placeholderBuilder: (_) => const _CanvasPlaceholder(label: 'Rendering diagram…', spinning: true),
                    )
                  : _CanvasPlaceholder(
                      label: isLoading ? 'Generating diagram…' : 'Tap regenerate to draw the diagram.',
                      spinning: isLoading,
                    ),
            ),
          ),
          if (onRegenerate != null)
            Positioned(
              top: 6,
              right: 6,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: isLoading ? null : onRegenerate,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: isLoading
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white70),
                          )
                        : const Icon(LucideIcons.refreshCcw, size: 14, color: Colors.white70),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CanvasPlaceholder extends StatelessWidget {
  final String label;
  final bool spinning;
  const _CanvasPlaceholder({required this.label, required this.spinning});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (spinning)
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.duoBlue),
            )
          else
            const Icon(LucideIcons.image, color: Colors.white24, size: 26),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
