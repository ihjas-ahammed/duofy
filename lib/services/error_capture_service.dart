import 'dart:async';
import 'package:flutter/foundation.dart';
import 'fb/fb_firestore.dart';
import 'fb/fb_auth.dart';
import 'guest_service.dart';

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
  final List<Map<String, dynamic>> _pendingUploads = [];
  bool _isUploading = false;

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

    // Send error record to database at /errors
    _queueErrorUpload(newError);

    // In release mode, never populate UI error banners
    if (kReleaseMode) {
      return;
    }

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

  void _queueErrorUpload(CapturedError err) {
    String? uid;
    try {
      final user = FbAuth.instance.currentUser;
      uid = user?.uid ?? GuestService.instance.guestIdSync;
    } catch (_) {}

    final docId = '${err.timestamp.millisecondsSinceEpoch}_${err.id}';
    final payload = <String, dynamic>{
      'id': docId,
      'error': err.errorString,
      'stackTrace': err.stackTrace?.toString(),
      'category': err.category,
      if (err.processName != null && err.processName!.isNotEmpty) 'processName': err.processName,
      'timestamp': err.timestamp.toIso8601String(),
      'releaseMode': kReleaseMode,
      'platform': defaultTargetPlatform.name,
      if (uid != null && uid.isNotEmpty) 'userId': uid,
    };

    if (_pendingUploads.length < 50) {
      _pendingUploads.add(payload);
    }
    _flushPendingUploads();
  }

  Future<void> _flushPendingUploads() async {
    if (_isUploading || _pendingUploads.isEmpty) return;
    _isUploading = true;

    try {
      while (_pendingUploads.isNotEmpty) {
        final payload = _pendingUploads.first;
        final docId = payload['id'] as String;
        await FbFirestore.instance.collection('errors').doc(docId).set(payload);
        _pendingUploads.removeAt(0);
      }
    } catch (e) {
      // Firebase might not be initialized yet or device is offline.
      // Will retry automatically on next error report.
      debugPrint('[ErrorCaptureService] Error sending to /errors (will retry): $e');
    } finally {
      _isUploading = false;
    }
  }

  void dismissError(String id) {
    final updated = errorsNotifier.value.where((e) => e.id != id).toList();
    errorsNotifier.value = updated;
  }

  void clearAll() {
    errorsNotifier.value = [];
  }
}
