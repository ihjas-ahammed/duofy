import 'package:flutter/material.dart';

class LoadingStep {
  final double progress; // 0.0 to 1.0
  final String processName;
  final bool isLoading;

  const LoadingStep({
    required this.progress,
    required this.processName,
    required this.isLoading,
  });

  factory LoadingStep.idle() => const LoadingStep(
        progress: 0.0,
        processName: '',
        isLoading: false,
      );

  LoadingStep copyWith({
    double? progress,
    String? processName,
    bool? isLoading,
  }) {
    return LoadingStep(
      progress: progress ?? this.progress,
      processName: processName ?? this.processName,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoadingProgressController {
  static final LoadingProgressController instance = LoadingProgressController._();
  LoadingProgressController._();

  final ValueNotifier<LoadingStep> loadingNotifier = ValueNotifier<LoadingStep>(LoadingStep.idle());

  void startLoading(String initialProcessName) {
    loadingNotifier.value = LoadingStep(
      progress: 0.05,
      processName: initialProcessName,
      isLoading: true,
    );
  }

  void updateStep(double progress, String processName) {
    final clamped = progress.clamp(0.0, 1.0);
    loadingNotifier.value = LoadingStep(
      progress: clamped,
      processName: processName,
      isLoading: true,
    );
  }

  void stopLoading() {
    loadingNotifier.value = LoadingStep.idle();
  }
}
