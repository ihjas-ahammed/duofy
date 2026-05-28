import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import 'canvas_html_view.dart';

/// Top-of-lesson / top-of-proof diagram widget. Renders an SVG produced by
/// the graphics AI and exposes a small regenerate affordance overlaid on
/// the art.
///
/// Behaviour:
/// - [svg] non-null & valid → diagram renders inside a glass card.
/// - [svg] null & [isLoading] true → "Generating…" placeholder box while the
///   background canvas pass is still running.
/// - [svg] null & not loading (generation failed / not yet run) → a compact
///   "tap to generate" prompt card showing the diagram description. We do NOT
///   reserve the full empty image box in this state.
/// - [svg] null & [hasPrompt] false → returns [SizedBox.shrink] so no
///   space is reserved.
/// - SVG render failure → falls back to the same "tap to generate" prompt
///   card so a malformed model response never breaks the lesson layout.
class CanvasArtView extends StatefulWidget {
  final String? svg;
  final bool hasPrompt;
  /// The natural-language diagram description. Shown in the "tap to generate"
  /// state so the user knows what the diagram would depict.
  final String? prompt;
  final bool isLoading;
  final void Function(String? errorContext)? onRegenerate;

  const CanvasArtView({
    super.key,
    required this.svg,
    required this.hasPrompt,
    this.prompt,
    this.isLoading = false,
    this.onRegenerate,
  });

  @override
  State<CanvasArtView> createState() => _CanvasArtViewState();
}

class _CanvasArtViewState extends State<CanvasArtView> {
  bool _hasAutoRetried = false;

  void _handleJsError(String message) {
    if (!_hasAutoRetried && widget.onRegenerate != null && !widget.isLoading) {
      _hasAutoRetried = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.onRegenerate != null) {
          widget.onRegenerate!(message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // No prompt → no slot at all. We don\'t want an empty rectangle for
    // lessons the text AI decided didn\'t need a diagram.
    if (!widget.hasPrompt && (widget.svg == null || widget.svg!.trim().isEmpty)) {
      return const SizedBox.shrink();
    }

    final hasArt = widget.svg != null && widget.svg!.trim().isNotEmpty;

    // No art and not actively generating → the diagram either failed or was
    // never generated. Instead of a blank placeholder box, show the prompt
    // text with a "tap to generate" affordance.
    if (!hasArt && !widget.isLoading) {
      return _TapToGenerateCard(prompt: widget.prompt, onTap: widget.onRegenerate == null ? null : () => widget.onRegenerate!(null));
    }

    // Full-width hero sized by aspect ratio (not a fixed screen fraction) so
    // the box hugs the diagram's shape — no empty bands above/below — while
    // still filling the width. 3:2 is a roomy landscape close to the diagrams'
    // own proportions. The full-screen / refresh buttons float on top, and the
    // canvas is allowed to sit directly beneath them.
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: hasArt
                // Renders an SVG or a JS canvas draw function depending on what
                // the model produced. Malformed SVG falls back to the
                // tap-to-generate card instead of a red error widget.
                ? buildCanvasArt(
                    widget.svg!,
                    svgPlaceholder: (_) => _TapToGenerateCard(prompt: widget.prompt, onTap: widget.onRegenerate == null ? null : () => widget.onRegenerate!(null), embedded: true),
                    onJsError: _handleJsError,
                  )
                : const _CanvasPlaceholder(label: 'Generating diagram…', spinning: true),
          ),
          // Expand-to-full-screen affordance (top-left).
          if (hasArt)
              Positioned(
                top: 6,
                left: 6,
                child: Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => showCanvasFullScreen(context, widget.svg!),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(LucideIcons.maximize2, size: 14, color: Colors.white70),
                    ),
                  ),
                ),
              ),
            if (widget.onRegenerate != null && hasArt)
              Positioned(
                top: 6,
                right: 6,
                child: Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: widget.isLoading ? null : () => widget.onRegenerate!(null),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: widget.isLoading
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

/// Compact card shown when there is a diagram prompt but no rendered SVG
/// (generation failed, or hasn\'t run yet). Tapping it triggers [onTap]
/// (regenerate). Shows the prompt so the learner knows what would be drawn.
class _TapToGenerateCard extends StatelessWidget {
  final String? prompt;
  final VoidCallback? onTap;
  /// When true the card is rendered inside an existing AspectRatio box (the
  /// SVG render-failure fallback), so it fills its parent instead of adding
  /// its own outer margin.
  final bool embedded;

  const _TapToGenerateCard({this.prompt, this.onTap, this.embedded = false});

  @override
  Widget build(BuildContext context) {
    final trimmed = prompt?.trim() ?? '';
    final card = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.duoBlue.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.duoBlue.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.duoBlue.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.imagePlus, size: 18, color: AppTheme.duoBlue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'TAP TO GENERATE DIAGRAM',
                          style: TextStyle(
                            color: AppTheme.duoBlue,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                          ),
                        ),
                        if (onTap != null) ...[
                          const SizedBox(width: 6),
                          const Icon(LucideIcons.refreshCcw, size: 12, color: AppTheme.duoBlue),
                        ],
                      ],
                    ),
                    if (trimmed.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        trimmed,
                        style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.35),
                        maxLines: embedded ? 3 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (embedded) return Center(child: card);
    return Padding(padding: const EdgeInsets.only(bottom: 16), child: card);
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
