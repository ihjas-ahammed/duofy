import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PsychologicalProgressBar extends StatefulWidget {
  final Duration estimatedDuration;
  final DateTime startTime;
  final bool isComplete;
  final bool isError;
  final String label;
  final bool isCircular;

  const PsychologicalProgressBar({
    super.key,
    required this.estimatedDuration,
    required this.startTime,
    this.isComplete = false,
    this.isError = false,
    this.label = '',
    this.isCircular = false,
  });

  @override
  State<PsychologicalProgressBar> createState() => _PsychologicalProgressBarState();
}

class _PsychologicalProgressBarState extends State<PsychologicalProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (widget.isComplete || widget.isError || !mounted) {
        timer.cancel();
        _updateTarget(widget.isError ? _animation.value : 1.0);
        return;
      }

      final elapsedMs = DateTime.now().difference(widget.startTime).inMilliseconds.toDouble();
      final totalMs = widget.estimatedDuration.inMilliseconds.toDouble().clamp(1000.0, double.infinity);

      double target;
      if (elapsedMs < totalMs) {
        // Linear progression up to 90%
        target = (elapsedMs / totalMs) * 0.90;
      } else {
        // Zeno's Paradox: Asymptotic crawl between 90% and 99%
        final overtimeMs = elapsedMs - totalMs;
        target = 0.90 + (0.09 * (1.0 - math.exp(-overtimeMs / 15000)));
      }

      _updateTarget(target);
    });
  }

  void _updateTarget(double target) {
    if (!mounted) return;
    _animation = Tween<double>(begin: _animation.value, end: target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(PsychologicalProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isComplete && !oldWidget.isComplete) {
      _timer?.cancel();
      _updateTarget(1.0);
    } else if (widget.isError && !oldWidget.isError) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCircular) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return SizedBox(
                width: 40, 
                height: 40,
                child: CircularProgressIndicator(
                  value: _animation.value,
                  color: widget.isError ? AppTheme.duoRed : AppTheme.duoViolet,
                  backgroundColor: Colors.white12,
                  strokeWidth: 4,
                ),
              );
            },
          ),
          if (widget.label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.label,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70),
                textAlign: TextAlign.center,
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
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.hardEdge,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isError ? AppTheme.duoRed : (widget.isComplete ? AppTheme.duoGreen : AppTheme.duoBlue),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}