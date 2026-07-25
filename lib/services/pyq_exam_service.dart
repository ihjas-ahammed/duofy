import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../models/pyq_models.dart';
import 'ai_service.dart';
import 'notification_service.dart';

class PyqExamService {
  PyqExamService._();
  static final PyqExamService instance = PyqExamService._();

  static String _bankKey(String bookId) => 'pyq_bank_$bookId';
  static String _historyKey(String bookId) => 'pyq_score_history_$bookId';

  /// Retrieves all saved PYQ items for a course. Fallbacks to reading from course sections.
  Future<List<PyqItem>> getPyqBank(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_bankKey(book.id));
    if (raw != null && raw.isNotEmpty) {
      try {
        final List decoded = jsonDecode(raw);
        return decoded.map((e) => PyqItem.fromJson(Map<String, dynamic>.from(e))).toList();
      } catch (_) {}
    }

    // Fallback: collect from book modules/sections
    final List<PyqItem> items = [];
    for (final m in book.modules) {
      for (final s in m.sections) {
        for (final q in s.pyqQuestions) {
          int marks = 5;
          final titleLower = q.title.toLowerCase();
          if (titleLower.contains('10 mark') || titleLower.contains('10m')) {
            marks = 10;
          } else if (titleLower.contains('6 mark') || titleLower.contains('6m')) {
            marks = 6;
          } else if (titleLower.contains('3 mark') || titleLower.contains('3m')) {
            marks = 3;
          }
          items.add(PyqItem(
            id: q.id,
            title: q.title,
            content: q.content,
            marks: marks,
            moduleId: m.id,
            moduleTitle: m.title,
            sectionId: s.id,
            sectionTitle: s.title,
            isGenerated: q.source == 'generated',
            source: q.source ?? 'extracted',
          ));
        }
      }
    }
    return items;
  }

  /// Saves updated PYQ items to the course PYQ Bank.
  Future<void> savePyqBank(String bookId, List<PyqItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map((i) => i.toJson()).toList());
    await prefs.setString(_bankKey(bookId), encoded);
  }

  /// Adds new PYQ items into the bank (deduplicating by ID/title).
  Future<void> addPyqItems(String bookId, Book book, List<PyqItem> newItems) async {
    final existing = await getPyqBank(book);
    final Set<String> existingKeys = existing.map((i) => i.id.isNotEmpty ? i.id : i.title.toLowerCase().trim()).toSet();

    final List<PyqItem> merged = [...existing];
    for (final item in newItems) {
      final key = item.id.isNotEmpty ? item.id : item.title.toLowerCase().trim();
      if (!existingKeys.contains(key)) {
        merged.add(item);
        existingKeys.add(key);
      }
    }
    await savePyqBank(bookId, merged);
  }

  /// Retrieves score history for a course.
  Future<List<PyqExamAttempt>> getScoreHistory(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_historyKey(bookId));
    if (raw == null || raw.isEmpty) return [];
    try {
      final List decoded = jsonDecode(raw);
      final list = decoded.map((e) => PyqExamAttempt.fromJson(Map<String, dynamic>.from(e))).toList();
      list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return list;
    } catch (_) {
      return [];
    }
  }

  /// Saves a completed exam attempt to score history.
  Future<void> saveExamAttempt(PyqExamAttempt attempt) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getScoreHistory(attempt.bookId);
    history.insert(0, attempt);
    final encoded = jsonEncode(history.map((a) => a.toJson()).toList());
    await prefs.setString(_historyKey(attempt.bookId), encoded);
  }

  /// Background AI Evaluation for submitted exam answers.
  /// Batches evaluation per section using gemini-3.5-flash-lite and syllabus context.
  Future<PyqExamAttempt> evaluateExamPaper({
    required Book book,
    required List<String> moduleIds,
    required List<PyqQuestionAnswer> studentAnswers,
  }) async {
    final notifId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await NotificationService.showProgress(
      notifId,
      'Evaluating PYQ Exam Paper',
      'AI is grading your answers...',
      progress: 0,
      maxProgress: 100,
    );

    final ai = AiService();
    final syllabusContext = book.description.isNotEmpty ? book.description : book.title;

    double totalEarnedScore = 0;
    double maxTotalScore = 0;

    final List<PyqQuestionAnswer> evaluatedAnswers = [];

    final int totalCount = studentAnswers.length;
    for (int i = 0; i < studentAnswers.length; i++) {
      final ans = studentAnswers[i];
      maxTotalScore += ans.marks;

      final progressPercent = (((i + 1) / totalCount) * 100).toInt();
      await NotificationService.showProgress(
        notifId,
        'Evaluating Exam Paper (${i + 1}/$totalCount)',
        'Grading: "${ans.questionTitle}"',
        progress: progressPercent,
        maxProgress: 100,
      );

      // AI grading prompt
      final prompt = '''
You are an expert academic examiner grading a student exam question.
Syllabus Context: "$syllabusContext"

Question Title: "${ans.questionTitle}"
Question Details/Content: "${ans.content}"
Max Marks for Question: ${ans.marks}

Student Written Answer:
"${ans.textAnswer.isEmpty ? '(No written text response provided)' : ans.textAnswer}"

Number of attached answer photos/diagrams: ${ans.imagePaths.length}

Evaluate the student's submission carefully:
1. Assign a numeric score out of ${ans.marks} marks (can be fractional, e.g., 4.5 out of 5).
2. Provide a 2-3 sentence feedback explaining what was correct, missing, or needs improvement.

Respond strictly in JSON format:
{
  "score": 4.5,
  "feedback": "Clear explanation of core concept. Included key definitions, but missed concluding summary."
}
''';

      double score = 0.0;
      String feedback = 'Answer submitted.';

      try {
        final rawResponse = await ai.generateSimpleText(
          prompt: prompt,
          slotName: 'Lite',
        );
        final decoded = ai.cleanAndDecodeJson(rawResponse);
        if (decoded['score'] is num) {
          score = (decoded['score'] as num).toDouble().clamp(0.0, ans.marks.toDouble());
        } else {
          score = (ans.textAnswer.trim().isNotEmpty || ans.imagePaths.isNotEmpty) ? ans.marks * 0.7 : 0.0;
        }
        feedback = decoded['feedback']?.toString() ?? 'Evaluated.';
      } catch (e) {
        score = (ans.textAnswer.trim().isNotEmpty || ans.imagePaths.isNotEmpty) ? ans.marks * 0.75 : 0.0;
        feedback = 'Evaluated based on content presence.';
      }

      totalEarnedScore += score;
      evaluatedAnswers.add(PyqQuestionAnswer(
        questionId: ans.questionId,
        questionTitle: ans.questionTitle,
        content: ans.content,
        marks: ans.marks,
        textAnswer: ans.textAnswer,
        imagePaths: ans.imagePaths,
        aiScore: score,
        aiFeedback: feedback,
      ));
    }

    final attempt = PyqExamAttempt(
      id: 'exam_${DateTime.now().millisecondsSinceEpoch}',
      bookId: book.id,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      totalScore: double.parse(totalEarnedScore.toStringAsFixed(1)),
      maxScore: maxTotalScore,
      moduleIds: moduleIds,
      answers: evaluatedAnswers,
    );

    await saveExamAttempt(attempt);

    await NotificationService.cancel(notifId);
    await NotificationService.showActionable(
      notifId + 1,
      'Exam Graded: ${attempt.totalScore.toStringAsFixed(1)} / ${attempt.maxScore.toStringAsFixed(0)} (${attempt.percentage.round()}%)',
      'Your PYQ exam evaluation is complete and saved to Score History!',
      'trophy',
    );

    return attempt;
  }

  // --- Background QP Analysis Jobs (Per Course) ---

  final Map<String, PyqAnalysisJob> _analysisJobs = {};

  PyqAnalysisJob? getAnalysisJob(String bookId) => _analysisJobs[bookId];

  Future<void> startBackgroundAnalysis({
    required Book book,
    required List<File> files,
    required int maxQuestions,
  }) async {
    final job = PyqAnalysisJob(
      bookId: book.id,
      bookTitle: book.title,
      progress: 0.05,
      status: 'Starting QP Analysis...',
      isRunning: true,
    );
    _analysisJobs[book.id] = job;
    job.notify();

    final notifId = (book.id.hashCode).abs() % 100000 + 5000;
    await NotificationService.showProgress(
      notifId,
      'QP Analysis: ${book.title}',
      'Analyzing question paper...',
      progress: 5,
      maxProgress: 100,
    );

    try {
      final result = await AiService().analyzeAndExtractPyqQuestions(
        files: files,
        book: book,
        maxQuestions: maxQuestions,
        onProgress: (p, s) async {
          job.progress = p;
          job.status = s;
          job.notify();

          await NotificationService.showProgress(
            notifId,
            'QP Analysis: ${book.title}',
            s,
            progress: (p * 100).toInt(),
            maxProgress: 100,
          );
        },
      );

      job.result = result;
      job.isRunning = false;
      job.isCompleted = true;
      job.progress = 1.0;
      job.status = 'Completed!';

      // Auto save extracted & generated questions to course bank
      final allToSave = [...result.extractedQuestions, ...result.generatedQuestions];
      if (allToSave.isNotEmpty) {
        await addPyqItems(book.id, book, allToSave);
      }

      job.notify();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId + 1,
        'QP Analysis Finished (${book.title})',
        'Extracted ${result.extractedQuestions.length} real & ${result.generatedQuestions.length} practice questions!',
        'fileText',
      );
    } catch (e) {
      job.isRunning = false;
      job.isFailed = true;
      job.status = 'Failed: $e';
      job.notify();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId + 2,
        'QP Analysis Error (${book.title})',
        'Failed to analyze question paper: $e',
        'alertCircle',
      );
    }
  }
}

class PyqAnalysisJob {
  final String bookId;
  final String bookTitle;
  double progress;
  String status;
  bool isRunning;
  bool isCompleted;
  bool isFailed;
  PyqExtractionResult? result;
  final List<void Function()> _listeners = [];

  PyqAnalysisJob({
    required this.bookId,
    required this.bookTitle,
    this.progress = 0.0,
    this.status = 'Queued',
    this.isRunning = true,
    this.isCompleted = false,
    this.isFailed = false,
    this.result,
  });

  void addListener(void Function() listener) {
    if (!_listeners.contains(listener)) _listeners.add(listener);
  }

  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  void notify() {
    for (final l in List.from(_listeners)) {
      try {
        l();
      } catch (_) {}
    }
  }
}
