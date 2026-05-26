import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Honest progress indicator driven by REAL work, not elapsed time.
///
/// - [progress] non-null → a determinate bar/ring at that fraction (animated
///   smoothly to each new value).
/// - [progress] null → an indeterminate spinner/bar, for phases where no
///   granular count exists (e.g. a single opaque AI call). We deliberately do
///   NOT fake a creeping percentage in that case.
///
/// Replaces the old time-based `PsychologicalProgressBar`.
class RealProgressBar extends StatelessWidget {
  final double? progress;
  final bool isComplete;
  final bool isError;
  final String label;
  final bool isCircular;

  const RealProgressBar({
    super.key,
    required this.progress,
    this.isComplete = false,
    this.isError = false,
    this.label = '',
    this.isCircular = false,
  });

  Color get _color => isError
      ? AppTheme.duoRed
      : (isComplete ? AppTheme.duoGreen : AppTheme.duoBlue);

  /// Effective value: complete pins to 1.0; otherwise the reported fraction
  /// (clamped), or null to stay indeterminate.
  double? get _value {
    if (isComplete) return 1.0;
    final p = progress;
    return p == null ? null : p.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    if (isCircular) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: _value == null
                ? CircularProgressIndicator(
                    color: _color,
                    backgroundColor: Colors.white12,
                    strokeWidth: 4,
                  )
                : TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: _value!),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                    builder: (context, v, _) => CircularProgressIndicator(
                      value: v,
                      color: _color,
                      backgroundColor: Colors.white12,
                      strokeWidth: 4,
                    ),
                  ),
          ),
          if (_value != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${(_value! * 100).round()}%',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: _color),
              ),
            ),
          if (label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                label,
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
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: _value == null
              ? LinearProgressIndicator(
                  minHeight: 12,
                  color: _color,
                  backgroundColor: Colors.white12,
                )
              : TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: _value!),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                  builder: (context, v, _) => LinearProgressIndicator(
                    value: v,
                    minHeight: 12,
                    color: _color,
                    backgroundColor: Colors.white12,
                  ),
                ),
        ),
      ],
    );
  }
}
