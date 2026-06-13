import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/ai_estimator.dart';
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

  final bool isStackedWithContent;
  final VoidCallback? onError;
  final String? targetId;

  const CanvasArtView({
    super.key,
    required this.svg,
    required this.hasPrompt,
    this.prompt,
    this.isLoading = false,
    this.onRegenerate,
    this.isStackedWithContent = false,
    this.onError,
    this.targetId,
  });

  @override
  State<CanvasArtView> createState() => _CanvasArtViewState();
}

class _CanvasArtViewState extends State<CanvasArtView> {
  bool _hasError = false;

  @override
  void didUpdateWidget(CanvasArtView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.svg != oldWidget.svg || widget.isLoading != oldWidget.isLoading) {
      _hasError = false;
    }
  }

  void _handleJsError(String message) {
    if (mounted) {
      setState(() {
        _hasError = true;
      });
      widget.onError?.call();
    }
  }

  void _handleSvgError() {
    if (mounted) {
      setState(() {
        _hasError = true;
      });
      widget.onError?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const SizedBox.shrink();
    }

    // No prompt → no slot at all. We don't want an empty rectangle for
    // lessons the text AI decided didn't need a diagram.
    if (!widget.hasPrompt && (widget.svg == null || widget.svg!.trim().isEmpty)) {
      return const SizedBox.shrink();
    }

    final hasArt = widget.svg != null && widget.svg!.trim().isNotEmpty;

    // No art and not actively generating → the diagram either failed or was
    // never generated. Hide it.
    if (!hasArt && !widget.isLoading) {
      return const SizedBox.shrink();
    }

    // Full-width hero sized by aspect ratio (not a fixed screen fraction) so
    // the box hugs the diagram's shape — no empty bands above/below — while
    // still filling the width. 3:2 is a roomy landscape close to the diagrams'
    // own proportions. The full-screen / refresh buttons float on top, and the
    // canvas is allowed to sit directly beneath them.
    return Container(
      margin: widget.isStackedWithContent
          ? EdgeInsets.zero
          : const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: widget.isStackedWithContent
            ? const BorderRadius.vertical(top: Radius.circular(24))
            : BorderRadius.circular(16),
        border: widget.isStackedWithContent
            ? Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1)),
                left: BorderSide(color: Colors.white.withOpacity(0.1)),
                right: BorderSide(color: Colors.white.withOpacity(0.1)),
              )
            : Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: hasArt
                // Renders an SVG or a JS canvas draw function depending on what
                // the model produced. Malformed SVG falls back to the
                // tap-to-generate card instead of a red error widget.
                ? CanvasDoubleTapDetector(
                    onDoubleTap: () => showCanvasCodeDialog(context, widget.svg!),
                    child: buildCanvasArt(
                      widget.svg!,
                      svgPlaceholder: (_) => const SizedBox.shrink(),
                      onJsError: _handleJsError,
                      onSvgError: _handleSvgError,
                    ),
                  )
                : _CanvasPlaceholder(label: 'Generating diagram…', spinning: true, targetId: widget.targetId),
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

class _CanvasPlaceholder extends StatefulWidget {
  final String label;
  final bool spinning;
  final String? targetId;
  const _CanvasPlaceholder({
    required this.label,
    required this.spinning,
    this.targetId,
  });

  @override
  State<_CanvasPlaceholder> createState() => _CanvasPlaceholderState();
}

class _CanvasPlaceholderState extends State<_CanvasPlaceholder> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(_CanvasPlaceholder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _startTimerIfNeeded();
  }

  void _startTimerIfNeeded() {
    if (widget.spinning && widget.targetId != null) {
      if (_timer == null) {
        _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (mounted) {
            setState(() {});
          }
        });
      }
    } else {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? progressValue;
    if (widget.spinning && widget.targetId != null) {
      final info = AiEstimator.activeRequests[widget.targetId];
      if (info != null) {
        final elapsed = DateTime.now().difference(info.startTime).inMilliseconds;
        final est = info.estimatedDuration.inMilliseconds;
        if (est > 0) {
          final ratio = elapsed / est;
          progressValue = (ratio * 0.95).clamp(0.0, 0.95);
        }
      }
    }

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
          if (widget.spinning)
            SizedBox(
              width: 40,
              height: 40,
              child: progressValue == null
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppTheme.duoBlue,
                      backgroundColor: Colors.white12,
                    )
                  : CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 3,
                      color: AppTheme.duoBlue,
                      backgroundColor: Colors.white12,
                    ),
            )
          else
            const Icon(LucideIcons.image, color: Colors.white24, size: 26),
          const SizedBox(height: 8),
          Text(
            widget.label,
            style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w800),
          ),
          if (progressValue != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                '${(progressValue * 100).round()}%',
                style: const TextStyle(
                  color: AppTheme.duoBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
