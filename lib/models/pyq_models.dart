import 'dart:convert';

class PyqItem {
  final String id;
  final String title;
  final String content;
  final int marks;
  final String? moduleId;
  final String? moduleTitle;
  final String? sectionId;
  final String? sectionTitle;
  final bool isGenerated;
  final String source;

  PyqItem({
    required this.id,
    required this.title,
    required this.content,
    required this.marks,
    this.moduleId,
    this.moduleTitle,
    this.sectionId,
    this.sectionTitle,
    this.isGenerated = false,
    this.source = 'extracted',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'marks': marks,
        'moduleId': moduleId,
        'moduleTitle': moduleTitle,
        'sectionId': sectionId,
        'sectionTitle': sectionTitle,
        'isGenerated': isGenerated,
        'source': source,
      };

  factory PyqItem.fromJson(Map<String, dynamic> json) {
    return PyqItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      marks: json['marks'] is num ? (json['marks'] as num).toInt() : 5,
      moduleId: json['moduleId']?.toString(),
      moduleTitle: json['moduleTitle']?.toString(),
      sectionId: json['sectionId']?.toString(),
      sectionTitle: json['sectionTitle']?.toString(),
      isGenerated: json['isGenerated'] == true,
      source: json['source']?.toString() ?? 'extracted',
    );
  }
}

class PyqQuestionAnswer {
  final String questionId;
  final String questionTitle;
  final String content;
  final int marks;
  final String textAnswer;
  final List<String> imagePaths;
  final double aiScore;
  final String aiFeedback;

  PyqQuestionAnswer({
    required this.questionId,
    required this.questionTitle,
    required this.content,
    required this.marks,
    required this.textAnswer,
    this.imagePaths = const [],
    this.aiScore = 0.0,
    this.aiFeedback = '',
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'questionTitle': questionTitle,
        'content': content,
        'marks': marks,
        'textAnswer': textAnswer,
        'imagePaths': imagePaths,
        'aiScore': aiScore,
        'aiFeedback': aiFeedback,
      };

  factory PyqQuestionAnswer.fromJson(Map<String, dynamic> json) {
    return PyqQuestionAnswer(
      questionId: json['questionId']?.toString() ?? '',
      questionTitle: json['questionTitle']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      marks: json['marks'] is num ? (json['marks'] as num).toInt() : 5,
      textAnswer: json['textAnswer']?.toString() ?? '',
      imagePaths: (json['imagePaths'] as List?)?.map((e) => e.toString()).toList() ?? [],
      aiScore: json['aiScore'] is num ? (json['aiScore'] as num).toDouble() : 0.0,
      aiFeedback: json['aiFeedback']?.toString() ?? '',
    );
  }
}

class PyqExamAttempt {
  final String id;
  final String bookId;
  final int timestamp;
  final double totalScore;
  final double maxScore;
  final List<String> moduleIds;
  final List<PyqQuestionAnswer> answers;

  PyqExamAttempt({
    required this.id,
    required this.bookId,
    required this.timestamp,
    required this.totalScore,
    required this.maxScore,
    required this.moduleIds,
    required this.answers,
  });

  double get percentage => maxScore > 0 ? (totalScore / maxScore) * 100 : 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookId': bookId,
        'timestamp': timestamp,
        'totalScore': totalScore,
        'maxScore': maxScore,
        'moduleIds': moduleIds,
        'answers': answers.map((a) => a.toJson()).toList(),
      };

  factory PyqExamAttempt.fromJson(Map<String, dynamic> json) {
    return PyqExamAttempt(
      id: json['id']?.toString() ?? '',
      bookId: json['bookId']?.toString() ?? '',
      timestamp: json['timestamp'] is num ? (json['timestamp'] as num).toInt() : 0,
      totalScore: json['totalScore'] is num ? (json['totalScore'] as num).toDouble() : 0.0,
      maxScore: json['maxScore'] is num ? (json['maxScore'] as num).toDouble() : 0.0,
      moduleIds: (json['moduleIds'] as List?)?.map((e) => e.toString()).toList() ?? [],
      answers: (json['answers'] as List?)
              ?.map((a) => PyqQuestionAnswer.fromJson(Map<String, dynamic>.from(a)))
              .toList() ??
          [],
    );
  }
}
