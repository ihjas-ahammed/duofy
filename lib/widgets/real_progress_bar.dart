import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Honest progress indicator driven by REAL work or elapsed time.
///
/// - [startTime] and [estimatedDuration] non-null -> runs a timer in the UI to
///   estimate optimistic progress value: `(elapsed / estimatedDuration * 0.95).clamp(0.0, 0.95)`.
/// - [progress] non-null → falls back to that static fraction.
/// - [isComplete] true → instantly pins to 1.0.
class RealProgressBar extends StatefulWidget {
  final double? progress;
  final DateTime? startTime;
  final Duration? estimatedDuration;
  final bool isComplete;
  final bool isError;
  final String label;
  final bool isCircular;

  const RealProgressBar({
    super.key,
    this.progress,
    this.startTime,
    this.estimatedDuration,
    this.isComplete = false,
    this.isError = false,
    this.label = '',
    this.isCircular = false,
  });

  @override
  State<RealProgressBar> createState() => _RealProgressBarState();
}

class _RealProgressBarState extends State<RealProgressBar> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(RealProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _startTimerIfNeeded();
  }

  void _startTimerIfNeeded() {
    if (widget.isComplete || widget.isError) {
      _timer?.cancel();
      _timer = null;
      return;
    }
    if (widget.startTime != null && widget.estimatedDuration != null) {
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

  Color get _color => widget.isError
      ? AppTheme.duoRed
      : (widget.isComplete ? AppTheme.duoGreen : AppTheme.duoBlue);

  /// Effective value: complete pins to 1.0; otherwise the reported fraction
  /// (clamped), or null to stay indeterminate.
  double? get _value {
    if (widget.isComplete) return 1.0;
    if (widget.startTime != null && widget.estimatedDuration != null) {
      final elapsed = DateTime.now().difference(widget.startTime!).inMilliseconds;
      final est = widget.estimatedDuration!.inMilliseconds;
      if (est > 0) {
        final ratio = elapsed / est;
        return (ratio * 0.95).clamp(0.0, 0.95);
      }
    }
    final p = widget.progress;
    return p == null ? null : p.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final val = _value;
    final color = _color;

    if (widget.isCircular) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: val == null
                ? CircularProgressIndicator(
                    color: color,
                    backgroundColor: Colors.white12,
                    strokeWidth: 4,
                  )
                : TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: val),
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    builder: (context, v, _) => CircularProgressIndicator(
                      value: v,
                      color: color,
                      backgroundColor: Colors.white12,
                      strokeWidth: 4,
                    ),
                  ),
          ),
          if (val != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${(val * 100).round()}%',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: color),
              ),
            ),
          if (widget.label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                widget.label,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: val == null
              ? LinearProgressIndicator(
                  minHeight: 12,
                  color: color,
                  backgroundColor: Colors.white12,
                )
              : TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: val),
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  builder: (context, v, _) => LinearProgressIndicator(
                    value: v,
                    minHeight: 12,
                    color: color,
                    backgroundColor: Colors.white12,
                  ),
                ),
        ),
      ],
    );
  }
}
