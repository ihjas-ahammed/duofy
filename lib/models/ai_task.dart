import 'dart:async';

class AiTask {
  final String id;
  final String title;
  final String bookId;
  final String? moduleId;
  final String? sectionId;
  final String? unitId;
  
  final String type; // 'book_skeleton', 'index_scan', 'unit', 'manifest', 'qp', 'pyq', 'lesson_regen', 'slide_regen', 'canvas_regen', 'section', 'module', 'book_content'
  final bool generateGraphics;
  final bool isScheduled;
  
  String status; // 'queued', 'running', 'completed', 'failed'
  String statusMessage;
  double? progress;
  String? errorMessage;
  DateTime? startTime;
  DateTime? endTime;
  Duration? estimatedDuration;
  
  final Map<String, dynamic> params;

  // Transient completer for immediate/blocking tasks to await result
  final Completer<dynamic> completer = Completer<dynamic>();

  AiTask({
    required this.id,
    required this.title,
    required this.bookId,
    this.moduleId,
    this.sectionId,
    this.unitId,
    required this.type,
    required this.generateGraphics,
    required this.isScheduled,
    this.status = 'queued',
    this.statusMessage = 'Queued',
    this.progress,
    this.errorMessage,
    this.startTime,
    this.endTime,
    this.estimatedDuration,
    required this.params,
  }) {
    // Prevent unhandled future errors by registering a silent catchError handler
    completer.future.catchError((_) {});
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'bookId': bookId,
      'moduleId': moduleId,
      'sectionId': sectionId,
      'unitId': unitId,
      'type': type,
      'generateGraphics': generateGraphics,
      'isScheduled': isScheduled,
      'status': status,
      'statusMessage': statusMessage,
      'progress': progress,
      'errorMessage': errorMessage,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'estimatedDurationMs': estimatedDuration?.inMilliseconds,
      'params': params,
    };
  }

  factory AiTask.fromJson(Map<String, dynamic> json) {
    return AiTask(
      id: json['id'],
      title: json['title'],
      bookId: json['bookId'] ?? '',
      moduleId: json['moduleId'],
      sectionId: json['sectionId'],
      unitId: json['unitId'],
      type: json['type'] ?? '',
      generateGraphics: json['generateGraphics'] ?? true,
      isScheduled: json['isScheduled'] ?? false,
      status: json['status'] ?? 'queued',
      statusMessage: json['statusMessage'] ?? 'Queued',
      progress: json['progress'],
      errorMessage: json['errorMessage'],
      startTime: json['startTime'] != null ? DateTime.fromMillisecondsSinceEpoch(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.fromMillisecondsSinceEpoch(json['endTime']) : null,
      estimatedDuration: json['estimatedDurationMs'] != null ? Duration(milliseconds: json['estimatedDurationMs']) : null,
      params: Map<String, dynamic>.from(json['params'] ?? {}),
    );
  }
}
