import 'package:flutter/foundation.dart';

class CapturedError {
  final String id;
  final Object error;
  final StackTrace? stackTrace;
  final String category;
  final String? processName;
  final DateTime timestamp;

  CapturedError({
    required this.id,
    required this.error,
    this.stackTrace,
    this.category = 'Process Error',
    this.processName,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  String get errorString => error.toString();
}

class ErrorCaptureService {
  static final ErrorCaptureService instance = ErrorCaptureService._();
  ErrorCaptureService._();

  final ValueNotifier<List<CapturedError>> errorsNotifier = ValueNotifier<List<CapturedError>>([]);

  void reportError(
    Object error,
    StackTrace? stackTrace, {
    String category = 'Process Error',
    String? processName,
  }) {
    debugPrint('[ErrorCaptureService] Captured $category: $error\n$stackTrace');

    final newError = CapturedError(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      error: error,
      stackTrace: stackTrace,
      category: category,
      processName: processName,
    );

    // Keep at most 10 recent errors to avoid memory ballooning
    final updatedList = List<CapturedError>.from(errorsNotifier.value);
    // Avoid duplicate error notifications popping simultaneously
    if (updatedList.any((e) => e.errorString == newError.errorString)) {
      return;
    }
    updatedList.add(newError);
    if (updatedList.length > 10) {
      updatedList.removeAt(0);
    }

    errorsNotifier.value = updatedList;
  }

  void dismissError(String id) {
    final updated = errorsNotifier.value.where((e) => e.id != id).toList();
    errorsNotifier.value = updated;
  }

  void clearAll() {
    errorsNotifier.value = [];
  }
}
