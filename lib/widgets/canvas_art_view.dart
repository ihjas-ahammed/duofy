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
    if (widget.svg != oldWidget.svg ||
        widget.isLoading != oldWidget.isLoading) {
      _hasError = false;
    }
  }

  void _handleJsError(String message) {
    debugPrint('[CanvasArtView] JS Error received: $message');
    if (mounted) {
      setState(() {
        _hasError = true;
      });
      widget.onError?.call();
    }
  }

  void _handleSvgError() {
    debugPrint('[CanvasArtView] SVG Error received');
    if (mounted) {
      setState(() {
        _hasError = true;
      });
      widget.onError?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[CanvasArtView] build - targetId: ${widget.targetId}, hasPrompt: ${widget.hasPrompt}, hasError: $_hasError, svgLength: ${widget.svg?.length ?? 0}, isLoading: ${widget.isLoading}');
    
    if (_hasError) {
      debugPrint('[CanvasArtView] Showing error placeholder and terminal debugger trigger');
      return Container(
        margin: widget.isStackedWithContent
            ? EdgeInsets.zero
            : const EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppTheme.darkColors.surface,
          borderRadius: widget.isStackedWithContent
              ? const BorderRadius.vertical(top: Radius.circular(24))
              : BorderRadius.circular(16),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
        ),
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.alertTriangle, color: Colors.redAccent, size: 24),
                    const SizedBox(height: 8),
                    Text(
                      'Diagram execution failed',
                      style: TextStyle(color: context.colors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              if (widget.onRegenerate != null)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: Colors.black54,
                    shape: CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: widget.isLoading ? null : () => widget.onRegenerate!(null),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: const Icon(
                          LucideIcons.refreshCcw,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // No prompt → no slot at all. We don't want an empty rectangle for
    // lessons the text AI decided didn't need a diagram.
    if (!widget.hasPrompt &&
        (widget.svg == null || widget.svg!.trim().isEmpty)) {
      debugPrint('[CanvasArtView] Hiding canvas: no prompt and empty/null SVG');
      return const SizedBox.shrink();
    }

    final hasArt = widget.svg != null && widget.svg!.trim().isNotEmpty;

    // No art and not actively generating → the diagram either failed or was
    // never generated. Hide it.
    if (!hasArt && !widget.isLoading) {
      debugPrint('[CanvasArtView] Hiding canvas: no art and not loading');
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
        color: context.colors.surface,
        borderRadius: widget.isStackedWithContent
            ? const BorderRadius.vertical(top: Radius.circular(24))
            : BorderRadius.circular(16),
        border: widget.isStackedWithContent
            ? Border(
                top: BorderSide(color: context.colors.outline),
                left: BorderSide(color: context.colors.outline),
                right: BorderSide(color: context.colors.outline),
              )
            : Border.all(color: context.colors.outline),
      ),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: hasArt ? canvasAspect(widget.svg!) : 3 / 2,
            child: hasArt
                // Renders an SVG or a JS canvas draw function depending on what
                // the model produced. Malformed SVG falls back to the
                // tap-to-generate card instead of a red error widget.
                ? CanvasDoubleTapDetector(
                    onDoubleTap: () =>
                        showCanvasCodeDialog(context, widget.svg!),
                    child: buildCanvasArt(
                      widget.svg!,
                      svgPlaceholder: (_) => const SizedBox.shrink(),
                      onJsError: _handleJsError,
                      onSvgError: _handleSvgError,
                      onMessage: (msg) => debugPrint('[CanvasArtView JS] $msg'),
                    ),
                  )
                : _CanvasPlaceholder(
                    label: 'Generating diagram…',
                    spinning: true,
                    targetId: widget.targetId,
                  ),
          ),
          // Expand-to-full-screen affordance (top-left).
          if (hasArt)
            Positioned(
              top: 6,
              left: 6,
              child: Material(
                color: Colors.black54,
                shape: CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => showCanvasFullScreen(context, widget.svg!),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: const Icon(
                      LucideIcons.maximize2,
                      size: 14,
                      color: Colors.white,
                    ),
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
                shape: CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: widget.isLoading
                      ? null
                      : () => widget.onRegenerate!(null),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: widget.isLoading
                        ? SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: context.colors.textSecondary,
                            ),
                          )
                        : const Icon(
                            LucideIcons.refreshCcw,
                            size: 14,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
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
      _timer ??= Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (mounted) {
            setState(() {});
          }
        });
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
        final elapsed = DateTime.now()
            .difference(info.startTime)
            .inMilliseconds;
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
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.spinning)
            SizedBox(
              width: 40,
              height: 40,
              child: progressValue == null
                  ? CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppTheme.duoBlue,
                      backgroundColor: context.colors.outline,
                    )
                  : CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 3,
                      color: AppTheme.duoBlue,
                      backgroundColor: context.colors.outline,
                    ),
            )
          else
            Icon(LucideIcons.image, color: context.colors.textFaint, size: 26),
          SizedBox(height: 8),
          Text(
            widget.label,
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
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