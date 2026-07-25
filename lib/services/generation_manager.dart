import '../platform/io_shim.dart';
import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../main.dart' show scaffoldMessengerKey;
import '../models/app_models.dart';
import '../models/ai_task.dart';
import 'pdf_service.dart';
import 'database_service.dart';
import 'ai_service.dart';
import 'mapping_verifier.dart';
import 'notification_service.dart';
import 'progress_service.dart';
import 'ai_estimator.dart';
import 'auto_index_service.dart';

enum BookGenState { extracting, review, chunking, saving, error }

class GenerationTask {
  final String id;
  final String title;
  final List<File> sourceFiles;
  final List<File> syllabusFiles;
  BookGenState state;
  String statusMessage;
  Book? skeletonBook;
  String? errorMessage;
  Duration estimatedDuration;
  DateTime startTime;
  double? progress;
  final List<String>? plannerQuestions;
  final List<String>? selectedQuestions;
  final String? bloomLevel;

  GenerationTask({
    required this.id,
    required this.title,
    required this.sourceFiles,
    this.syllabusFiles = const [],
    this.state = BookGenState.extracting,
    this.statusMessage = 'Extracting Metadata & Planning...',
    required this.estimatedDuration,
    required this.startTime,
    this.plannerQuestions,
    this.selectedQuestions,
    this.bloomLevel,
  });
}

class UnitGenTask {
  String status;
  Duration estimatedDuration;
  DateTime startTime;
  bool isError;
  double? progress;
  int? plannedLessonsCount;

  UnitGenTask({
    required this.status,
    required this.estimatedDuration,
    required this.startTime,
    this.isError = false,
    this.progress,
    this.plannedLessonsCount,
  });
}

class QpGenTask {
  String status;
  bool isError;
  double? progress;
  QpGenTask({required this.status, this.isError = false, this.progress});
}

class GenerationManager extends ChangeNotifier {
  static final GenerationManager instance = GenerationManager._internal();
  static final Map<String, List<PlatformFile>> _inMemoryPyqFiles = {};

  GenerationManager._internal() {
    _loadQueueFromPrefs();
    _startQueueTimer();

    AiEstimator.onRegisterActiveRequest = (targetId, info) {
      notifyListeners();
    };
    AiEstimator.onUnregisterActiveRequest = (targetId) {
      notifyListeners();
    };
  }

  final List<GenerationTask> activeTasks = [];
  final Map<String, UnitGenTask> activeUnitGenerations = {};
  final Map<String, QpGenTask> activeQpTasks = {};
  final Map<String, QpGenTask> activePyqTasks = {};

  // New queue system variables
  final List<AiTask> queue = [];
  Timer? _queueTimer;
  bool _isProcessing = false;

  final PdfService _pdfService = PdfService();
  final DatabaseService _dbService = DatabaseService();
  final AiService _aiService = AiService();

  String _cachedTextModel = 'gemini-flash-lite-latest';
  String _cachedGraphicsModel = 'gemini-3.5-flash';

  Future<void> _cacheModels() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _cachedTextModel =
          prefs.getString('model_primary_text') ?? 'gemini-flash-lite-latest';
      _cachedGraphicsModel =
          prefs.getString('model_primary_graphics') ?? 'gemini-3.5-flash';
    } catch (_) {}
  }

  final StreamController<Book> _bookUpdateController =
      StreamController<Book>.broadcast();
  Stream<Book> get bookUpdates => _bookUpdateController.stream;

  void triggerBookUpdate(Book book) {
    _bookUpdateController.add(book);
  }

  VoidCallback? onBookGenerated;

  Future<void> _recordRunTime(String key, int durationMs) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(key) ?? [];
    history.add(durationMs.toString());
    if (history.length > 3) history.removeAt(0);
    await prefs.setStringList(key, history);
  }

  Future<int> _getAverageRunTime(String key, int defaultMs) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(key) ?? [];
    if (history.isEmpty) return defaultMs;
    int sum = history.fold(0, (prev, element) => prev + int.parse(element));
    return sum ~/ history.length;
  }

  // ---------------------------------------------------------------------------
  // Persisted Queue Management
  // ---------------------------------------------------------------------------
  /// Quick-run: promote a scheduled queued task to run immediately.
  void runTaskNow(String taskId) {
    AiTask? task;
    for (final t in queue) {
      if (t.id == taskId && t.status == 'queued') {
        task = t;
        break;
      }
    }
    if (task == null || !task.isScheduled) return;
    task.isScheduled = false;
    task.statusMessage = 'Queued';
    _saveQueueToPrefs();
    notifyListeners();
    _processQueue();
  }

  /// Surface a task failure as a toast. Must never throw — a missing
  /// messenger (e.g. during startup) is silently ignored.
  void _notifyTaskFailure(AiTask task) {
    try {
      final messenger = scaffoldMessengerKey.currentState;
      if (messenger == null) return;
      var reason = task.errorMessage ?? 'Unknown error';
      if (reason.length > 120) reason = '${reason.substring(0, 120)}…';
      messenger.showSnackBar(
        SnackBar(
          content: Text('AI task failed: ${task.title}\n$reason'),
          backgroundColor: const Color(0xFFB00020),
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (_) {}
  }

  Future<void> _saveQueueToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = queue.map((t) => t.toJson()).toList();
      await prefs.setString('ai_generation_queue', jsonEncode(jsonList));
    } catch (e) {
      print('[GenerationManager] Error saving queue: $e');
    }
  }

  Future<void> _loadQueueFromPrefs() async {
    await _cacheModels();
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString('ai_generation_queue');
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final List decoded = jsonDecode(jsonStr);
        queue.clear();
        queue.addAll(
          decoded.map((e) => AiTask.fromJson(Map<String, dynamic>.from(e))),
        );

        // Convert running to queued if interrupted; they auto-resume.
        for (final t in queue) {
          if (t.status == 'running') {
            t.status = 'queued';
            t.statusMessage = 'Queued (interrupted)';
          }
        }

        _syncActiveMapsWithQueue();
        notifyListeners();
        _processQueue();
      }
    } catch (e) {
      print('[GenerationManager] Error loading queue: $e');
    }
  }

  void registerActiveRequest(String targetId, ActiveRequestInfo info) {
    AiEstimator.activeRequests[targetId] = info;
    notifyListeners();
  }

  void unregisterActiveRequest(String targetId) {
    AiEstimator.activeRequests.remove(targetId);
    notifyListeners();
  }

  void _syncActiveMapsWithQueue() {
    activeUnitGenerations.clear();
    activeSectionManifests.clear();
    activeQpTasks.clear();
    activePyqTasks.clear();

    for (final task in queue) {
      if (task.status == 'queued' || task.status == 'running') {
        final isError = task.status == 'failed';
        final statusMsg = task.status == 'running'
            ? task.statusMessage
            : 'Queued';

        if (task.type == 'unit') {
          if (task.unitId != null) {
            final int? plannedLessonsCount =
                task.params['plannedLessonsCount'] as int?;
            final double estSecs = AiEstimator.estimateUnitDurationSync(
              textModel: _cachedTextModel,
              graphicsModel: _cachedGraphicsModel,
              generateGraphics: task.generateGraphics,
              plannedLessonsCount: plannedLessonsCount,
            );
            final Duration estDuration = Duration(
              milliseconds: (estSecs * 1000).toInt(),
            );
            task.estimatedDuration = estDuration;

            activeUnitGenerations[task.unitId!] = UnitGenTask(
              status: statusMsg,
              estimatedDuration: estDuration,
              startTime: task.startTime ?? DateTime.now(),
              isError: isError,
              progress: task.progress,
              plannedLessonsCount: plannedLessonsCount,
            );
          }
        } else if (task.type == 'manifest') {
          if (task.sectionId != null) {
            final double estSecs = AiEstimator.estimateDurationSync(
              _cachedTextModel,
              20000,
            );
            final Duration estDuration = Duration(
              milliseconds: (estSecs * 1000).toInt(),
            );
            task.estimatedDuration = estDuration;

            activeSectionManifests[task.sectionId!] = UnitGenTask(
              status: statusMsg,
              estimatedDuration: estDuration,
              startTime: task.startTime ?? DateTime.now(),
              isError: isError,
              progress: task.progress,
            );
          }
        } else if (task.type == 'section') {
          if (task.sectionId != null) {
            activeSectionManifests[task.sectionId!] = UnitGenTask(
              status: task.statusMessage,
              estimatedDuration: const Duration(seconds: 90),
              startTime: task.startTime ?? DateTime.now(),
              isError: isError,
              progress: task.progress,
            );
          }
        } else if (task.type == 'qp') {
          activeQpTasks[task.bookId] = QpGenTask(
            status: statusMsg,
            isError: isError,
            progress: task.progress,
          );
        } else if (task.type == 'pyq') {
          activePyqTasks[task.bookId] = QpGenTask(
            status: statusMsg,
            isError: isError,
            progress: task.progress,
          );
        }
      }
    }
  }

  void _startQueueTimer() {
    _queueTimer?.cancel();
    _queueTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _processQueue();
    });
  }

  // ---------------------------------------------------------------------------
  // Concurrency Queue Loop
  // ---------------------------------------------------------------------------
  Future<void> _processQueue() async {
    if (_isProcessing) return;
    await _cacheModels();

    _isProcessing = true;

    try {
      final prefs = await SharedPreferences.getInstance();

      // Load concurrency limit
      final setting = prefs.getString('gen_concurrency') ?? 'auto';
      int limit = 2;
      if (setting != 'auto') {
        final parsed = int.tryParse(setting);
        if (parsed != null) limit = parsed;
      } else {
        limit = await _resolveConcurrency();
      }

      // Load schedule hours
      final startHour = prefs.getInt('schedule_start_hour') ?? 21;
      final startMinute = prefs.getInt('schedule_start_minute') ?? 0;
      final endHour = prefs.getInt('schedule_end_hour') ?? 9;
      final endMinute = prefs.getInt('schedule_end_minute') ?? 0;

      final now = DateTime.now();
      final nowMin = now.hour * 60 + now.minute;
      final startMin = startHour * 60 + startMinute;
      final endMin = endHour * 60 + endMinute;

      bool isWithinHours = false;
      if (startMin <= endMin) {
        isWithinHours = nowMin >= startMin && nowMin < endMin;
      } else {
        isWithinHours = nowMin >= startMin || nowMin < endMin;
      }

      final runningTasks = queue.where((t) => t.status == 'running').toList();
      final queuedTasks = queue.where((t) => t.status == 'queued').toList();

      if (queuedTasks.isEmpty) {
        _isProcessing = false;
        return;
      }

      // Fetch available keys
      List<String> keys = [];
      try {
        keys = await _aiService.getKeys();
      } catch (e) {
        print('[GenerationManager] Error fetching API keys: $e');
      }

      // Execute all 'canvas_regen' tasks immediately
      final canvasRegens = queuedTasks
          .where((t) => t.type == 'canvas_regen')
          .toList();
      if (canvasRegens.isNotEmpty) {
        if (keys.isEmpty) {
          for (final t in canvasRegens) {
            t.status = 'failed';
            t.statusMessage = 'Failed';
            t.errorMessage =
                'No API Keys configured. Please add keys in Settings.';
            t.endTime = DateTime.now();
            t.completer.completeError(Exception('No API Keys configured.'));
            _notifyTaskFailure(t);
          }
        } else {
          for (final task in canvasRegens) {
            final assignedKey = _selectApiKeyForTask(task, keys, runningTasks);
            task.params['assignedApiKey'] = assignedKey;
            _executeTask(task);
            runningTasks.add(task);
          }
        }
        _syncActiveMapsWithQueue();
        notifyListeners();
        _saveQueueToPrefs();
      }

      final remainingQueued = queuedTasks
          .where((t) => t.type != 'canvas_regen')
          .toList();
      if (remainingQueued.isEmpty) {
        _isProcessing = false;
        return;
      }

      int availableSlots =
          limit - runningTasks.where((t) => t.type != 'canvas_regen').length;
      if (availableSlots <= 0) {
        _isProcessing = false;
        return;
      }

      // Select next tasks to run
      final nextTasks = _getNextTasksToRun(
        remainingQueued,
        isWithinHours,
        availableSlots,
      );

      if (keys.isEmpty) {
        for (final t in nextTasks) {
          t.status = 'failed';
          t.statusMessage = 'Failed';
          t.errorMessage =
              'No API Keys configured. Please add keys in Settings.';
          t.endTime = DateTime.now();
          t.completer.completeError(Exception('No API Keys configured.'));
          _notifyTaskFailure(t);
        }
        _syncActiveMapsWithQueue();
        notifyListeners();
        _saveQueueToPrefs();
        _isProcessing = false;
        return;
      }

      for (final task in nextTasks) {
        final assignedKey = _selectApiKeyForTask(task, keys, runningTasks);
        task.params['assignedApiKey'] = assignedKey;

        // Execute task asynchronously
        _executeTask(task);

        runningTasks.add(task);
      }

      _syncActiveMapsWithQueue();
      notifyListeners();
      _saveQueueToPrefs();
    } catch (e) {
      print('[GenerationManager] Error processing queue: $e');
    } finally {
      _isProcessing = false;
    }
  }

  List<AiTask> _getNextTasksToRun(
    List<AiTask> queuedTasks,
    bool isWithinHours,
    int availableSlots,
  ) {
    final List<AiTask> toRun = [];

    // First, high-priority non-scheduled tasks
    final nonScheduled = queuedTasks.where((t) => !t.isScheduled).toList();
    toRun.addAll(nonScheduled.take(availableSlots));

    // Then, scheduled tasks if within schedule hours
    if (isWithinHours && toRun.length < availableSlots) {
      final scheduled = queuedTasks.where((t) => t.isScheduled).toList();
      toRun.addAll(scheduled.take(availableSlots - toRun.length));
    }

    return toRun;
  }

  String _selectApiKeyForTask(
    AiTask task,
    List<String> allKeys,
    List<AiTask> runningTasks,
  ) {
    if (allKeys.isEmpty) throw Exception("No API keys available");
    if (allKeys.length == 1) return allKeys.first;

    final inUseKeys = runningTasks
        .map((t) => t.params['assignedApiKey'] as String?)
        .whereType<String>()
        .toSet();

    for (final key in allKeys) {
      if (!inUseKeys.contains(key)) {
        return key;
      }
    }

    return allKeys[runningTasks.length % allKeys.length];
  }

  Future<void> _executeTask(AiTask task) async {
    final isCanvasRegen = task.type == 'canvas_regen';
    if (isCanvasRegen) {
      AiService.activeCanvasRegensCount++;
    }
    try {
      final apiKey = (task.params['assignedApiKey'] as String? ?? '');
      task.status = 'running';
      task.startTime = DateTime.now();
      task.progress = 0.0;
      task.statusMessage = 'Starting AI execution...';
      notifyListeners();
      _saveQueueToPrefs();

      switch (task.type) {
        case 'book_skeleton':
          await _runBookSkeletonForTask(task, apiKey);
          break;
        case 'unit':
          final bookId = task.bookId;
          final modIdx = task.params['modIdx'] as int;
          final secIdx = task.params['secIdx'] as int;
          final unitIdx = task.params['unitIdx'] as int;
          final book = await _dbService.getBookFromCache(bookId);
          if (book == null) throw Exception("Course not found");
          final unit = book.modules[modIdx].sections[secIdx].units[unitIdx];
          await _runUnitGenerationForTask(
            task,
            unit,
            book,
            modIdx,
            secIdx,
            unitIdx,
            apiKey,
          );
          break;
        case 'manifest':
          final bookId = task.bookId;
          final modIdx = task.params['modIdx'] as int;
          final secIdx = task.params['secIdx'] as int;
          final instructions = task.params['instructions'] as String?;
          final saveGlobally = task.params['saveGlobally'] as bool? ?? false;
          final selectedQuestions = (task.params['selectedQuestions'] as List?)
              ?.cast<String>();
          final book = await _dbService.getBookFromCache(bookId);
          if (book == null) throw Exception("Course not found");
          await _runManifestGenerationForTask(
            task,
            book,
            modIdx,
            secIdx,
            instructions,
            saveGlobally,
            apiKey,
            selectedQuestions: selectedQuestions,
          );
          break;
        case 'section':
          await _runSectionGenerationForTask(
            task,
            task.bookId,
            task.params['modIdx'] as int,
            task.params['secIdx'] as int,
            apiKey,
          );
          break;
        case 'module':
          await _runModuleGenerationForTask(
            task,
            task.bookId,
            task.params['modIdx'] as int,
            apiKey,
          );
          break;
        case 'book_content':
          await _runBookContentGenerationForTask(task, task.bookId, apiKey);
          break;
        case 'qp':
          final title = task.params['title'] as String;
          final filePaths = List<String>.from(task.params['filePaths']);
          final files = filePaths.map((p) => File(p)).toList();
          final instructions = task.params['instructions'] as String?;
          final book = await _dbService.getBookFromCache(task.bookId);
          if (book == null) throw Exception("Course not found");
          await _runQpGenerationForTask(
            task,
            files,
            title,
            book,
            instructions,
            apiKey,
          );
          break;
        case 'pyq':
          List<dynamic> files = [];
          if (_inMemoryPyqFiles.containsKey(task.id)) {
            files = _inMemoryPyqFiles[task.id]!;
          } else {
            final filePaths = List<String>.from(task.params['filePaths'] ?? []);
            files = filePaths.map((p) => File(p)).toList();
          }
          final instructions = task.params['instructions'] as String?;
          final moduleIndex = task.params['moduleIndex'] as int?;
          final book = await _dbService.getBookFromCache(task.bookId);
          if (book == null) throw Exception("Course not found");
          await _runPyqGenerationForTask(
            task,
            files,
            book,
            instructions,
            apiKey,
            moduleIndex: moduleIndex,
          );
          break;
        case 'lesson_regen':
          final modIdx = task.params['modIdx'] as int;
          final secIdx = task.params['secIdx'] as int;
          final unitIdx = task.params['unitIdx'] as int;
          final lessonIdx = task.params['lessonIdx'] as int;
          final book = await _dbService.getBookFromCache(task.bookId);
          if (book == null) throw Exception("Course not found");
          final lesson = book
              .modules[modIdx]
              .sections[secIdx]
              .units[unitIdx]
              .lessons[lessonIdx];
          await _runLessonRegenForTask(
            task,
            book,
            modIdx,
            secIdx,
            unitIdx,
            lessonIdx,
            lesson,
            apiKey,
          );
          break;
        case 'slide_regen':
          await _runSlideRegenForTask(task, apiKey);
          break;
        case 'canvas_regen':
          await _runCanvasRegenForTask(task, apiKey);
          break;
        case 'custom_lesson_gen':
          final modIdx = task.params['modIdx'] as int;
          final secIdx = task.params['secIdx'] as int;
          final unitIdx = task.params['unitIdx'] as int;
          final book = await _dbService.getBookFromCache(task.bookId);
          if (book == null) throw Exception("Course not found");
          await _runCustomLessonGenForTask(
            task,
            book,
            modIdx,
            secIdx,
            unitIdx,
            apiKey,
          );
          break;
        default:
          throw Exception("Unknown task type: ${task.type}");
      }

      task.status = 'completed';
      task.progress = 1.0;
      task.statusMessage = 'Completed';
      task.endTime = DateTime.now();
    } catch (e) {
      final int retryCount = (task.params['retryCount'] as int? ?? 0);
      if (retryCount < 3) {
        task.params['retryCount'] = retryCount + 1;
        task.status = 'queued';
        task.statusMessage = 'Retrying (${retryCount + 1}/3)...';
        print('[GenerationManager] Retrying task ${task.id} (attempt ${retryCount + 1}): $e');
        await Future.delayed(Duration(seconds: (retryCount + 1) * 2));
      } else {
        task.status = 'failed';
        task.statusMessage = 'Failed';
        task.errorMessage = e.toString();
        task.endTime = DateTime.now();
        task.completer.completeError(e);
        _notifyTaskFailure(task);
      }
    } finally {
      if (isCanvasRegen) {
        AiService.activeCanvasRegensCount =
            (AiService.activeCanvasRegensCount - 1).clamp(0, 9999);
      }
      _syncActiveMapsWithQueue();
      notifyListeners();
      _saveQueueToPrefs();
      _processQueue();
    }
  }

  // ---------------------------------------------------------------------------
  // Task Queue Enqueue Wrappers (Returning Completer Futures)
  // ---------------------------------------------------------------------------
  void _enqueueTaskObject(AiTask task, {bool highPriority = false}) {
    if (highPriority) {
      int insertIdx = 0;
      for (int i = 0; i < queue.length; i++) {
        if (queue[i].status == 'queued') {
          insertIdx = i;
          break;
        }
      }
      queue.insert(insertIdx, task);
    } else {
      queue.add(task);
    }
    _syncActiveMapsWithQueue();
    notifyListeners();
    _saveQueueToPrefs();
    _processQueue();
  }

  void _enqueue({
    required String title,
    required String type,
    required String bookId,
    String? moduleId,
    String? sectionId,
    String? unitId,
    required bool generateGraphics,
    required bool isScheduled,
    required Map<String, dynamic> params,
    String? customTaskId,
    bool highPriority = false,
  }) {
    final taskId =
        customTaskId ??
        '${type}_${DateTime.now().millisecondsSinceEpoch}_${unitId ?? sectionId ?? moduleId ?? bookId}';
    final task = AiTask(
      id: taskId,
      title: title,
      bookId: bookId,
      moduleId: moduleId,
      sectionId: sectionId,
      unitId: unitId,
      type: type,
      generateGraphics: generateGraphics,
      isScheduled: isScheduled,
      params: params,
    );
    _enqueueTaskObject(task, highPriority: highPriority);
  }

  Future<Book?> startBookSkeletonGenerationTask(
    List<File> indexFiles,
    String filename, {
    required List<int> chapter1AbsolutePages,
    String? customInstructions,
    List<File> syllabusFiles = const [],
    bool isHandout = false,
    List<List<int>>? chapterStarts,
    List<File> sourceFiles = const [],
    String? parentTaskId,
  }) async {
    final task = AiTask(
      id: 'skeleton_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Course Structure: $filename',
      bookId: 'new_book',
      type: 'book_skeleton',
      generateGraphics: false,
      isScheduled: false,
      params: {
        'indexFilesPaths': indexFiles.map((f) => f.path).toList(),
        'syllabusFilesPaths': syllabusFiles.map((f) => f.path).toList(),
        'filename': filename,
        'chapter1AbsolutePages': chapter1AbsolutePages,
        'customInstructions': customInstructions,
        'isHandout': isHandout,
        'chapterStarts': ?chapterStarts,
        'sourceFilesPaths': sourceFiles.map((f) => f.path).toList(),
        'parentTaskId': ?parentTaskId,
      },
    );
    _enqueueTaskObject(task);
    final result = await task.completer.future;
    return result as Book?;
  }

  Future<String?> generateCanvasArtTask(
    String canvasPrompt, {
    String contextText = '',
    String? errorContext,
  }) async {
    final task = AiTask(
      id: 'canvas_${DateTime.now().millisecondsSinceEpoch}_${canvasPrompt.hashCode}',
      title:
          'Generate Graphic: ${canvasPrompt.length > 20 ? "${canvasPrompt.substring(0, 20)}..." : canvasPrompt}',
      bookId: 'canvas',
      type: 'canvas_regen',
      generateGraphics: true,
      isScheduled: false,
      params: {
        'canvasPrompt': canvasPrompt,
        'contextText': contextText,
        'errorContext': errorContext,
      },
    );
    _enqueueTaskObject(task);
    final result = await task.completer.future;
    return result as String?;
  }

  Future<Slide?> regenerateSlideTask({
    required Slide slide,
    required Lesson lesson,
    required Book bookContext,
    String? chunkPath,
    String? note,
    String? targetType,
    String? screenSizeInfo,
  }) async {
    Slide? result;
    try {
      _pauseAllOtherTasks();

      final task = AiTask(
        id: 'slide_${DateTime.now().millisecondsSinceEpoch}_${slide.id}',
        title: 'Regenerate Slide text',
        bookId: bookContext.id,
        type: 'slide_regen',
        generateGraphics: false,
        isScheduled: false,
        params: {
          'slide': slide.toJson(),
          'lesson': lesson.toJson(),
          'bookContext': bookContext.toJson(),
          'chunkPath': chunkPath,
          'note': note,
          'targetType': targetType,
          'screenSizeInfo': screenSizeInfo,
        },
      );
      _enqueueTaskObject(task, highPriority: true);
      result = await task.completer.future as Slide?;
    } finally {
      _resumeAllPausedTasks();
    }
    return result;
  }

  // ---------------------------------------------------------------------------
  // Runners for queued tasks
  // ---------------------------------------------------------------------------
  Future<void> _runBookSkeletonForTask(AiTask task, String apiKey) async {
    final indexFilesPaths = List<String>.from(task.params['indexFilesPaths']);
    final syllabusFilesPaths = List<String>.from(
      task.params['syllabusFilesPaths'] ?? [],
    );
    final sourceFilesPaths = List<String>.from(
      task.params['sourceFilesPaths'] ?? [],
    );
    final filename = task.params['filename'] as String;
    final chapter1AbsolutePages = List<int>.from(
      task.params['chapter1AbsolutePages'] ?? [],
    );
    final customInstructions = task.params['customInstructions'] as String?;
    final isHandout = task.params['isHandout'] as bool? ?? false;

    final chapterStartsRaw = task.params['chapterStarts'] as List?;
    final List<List<int>>? chapterStarts = chapterStartsRaw?.map((list) => List<int>.from(list as List)).toList();

    List<File> indexFiles = indexFilesPaths.map((p) => File(p)).toList();
    final syllabusFiles = syllabusFilesPaths.map((p) => File(p)).toList();
    final sourceFiles = sourceFilesPaths.map((p) => File(p)).toList();
    List<int> ch1Pages = chapter1AbsolutePages;

    if (indexFiles.isEmpty && !isHandout) {
      final autoIndexService = AutoIndexService();
      final backgroundIndexFiles = <File>[];
      final backgroundCh1Pages = <int>[];

      void updateProgress(String status, double progress) {
        task.statusMessage = status;
        task.progress = progress;

        final parentTaskId = task.params['parentTaskId'] as String?;
        if (parentTaskId != null) {
          final parentIdx = activeTasks.indexWhere((t) => t.id == parentTaskId);
          if (parentIdx != -1) {
            activeTasks[parentIdx].statusMessage = status;
            activeTasks[parentIdx].progress = progress;
          }
        }

        _syncActiveMapsWithQueue();
        notifyListeners();
      }

      for (int i = 0; i < sourceFiles.length; i++) {
        final pdfFile = sourceFiles[i];
        final pdfName = pdfFile.path.split(RegExp(r'[\\/]')).last;

        updateProgress(
          'Scanning $pdfName for index...',
          0.05 + 0.15 * (i / sourceFiles.length),
        );

        final result = await autoIndexService.findIndexAndChapter1(pdfFile, (
          status,
          progress,
        ) {
          updateProgress(
            '$status ($pdfName)',
            0.05 + 0.15 * ((i + progress) / sourceFiles.length),
          );
        });

        int ch1 = result.chapter1StartPage ?? 1;
        List<int> idxPages = result.indexPages;

        if (idxPages.isEmpty) {
          final pdfPageCount = await _pdfService.getPageCount(pdfFile);
          final endPage = pdfPageCount > 30 ? 30 : pdfPageCount;
          idxPages = List.generate(endPage, (idx) => idx + 1);
          ch1 = endPage + 1;
          if (ch1 > pdfPageCount) ch1 = pdfPageCount;
        }

        backgroundCh1Pages.add(ch1);

        final indexPdf = await _pdfService.extractPages(
          pdfFile,
          idxPages,
          outputName: 'index_$pdfName',
        );
        backgroundIndexFiles.add(indexPdf);
      }

      indexFiles = backgroundIndexFiles;
      ch1Pages = backgroundCh1Pages;
    }

    final result = await _aiService.generateBookSkeleton(
      indexFiles,
      filename,
      chapter1AbsolutePages: ch1Pages,
      customInstructions: customInstructions,
      syllabusFiles: syllabusFiles,
      isHandout: isHandout,
      chapterStarts: chapterStarts,
      sourceFiles: sourceFiles,
      onProgress: (status, progress) {
        task.statusMessage = status;
        task.progress = progress;

        final parentTaskId = task.params['parentTaskId'] as String?;
        if (parentTaskId != null) {
          final parentIdx = activeTasks.indexWhere((t) => t.id == parentTaskId);
          if (parentIdx != -1) {
            activeTasks[parentIdx].statusMessage = status;
            activeTasks[parentIdx].progress = progress;
          }
        }

        _syncActiveMapsWithQueue();
        notifyListeners();
      },
      forcedApiKey: apiKey,
    );
    task.completer.complete(result);
  }

  Future<void> _runCanvasRegenForTask(AiTask task, String apiKey) async {
    final canvasPrompt = task.params['canvasPrompt'] as String;
    final contextText = task.params['contextText'] as String? ?? '';
    final errorContext = task.params['errorContext'] as String?;

    final result = await _aiService.generateCanvasArt(
      canvasPrompt,
      contextText: contextText,
      errorContext: errorContext,
      forcedApiKey: apiKey,
      isHighPriority: true,
    );
    task.completer.complete(result);
  }

  Future<void> _runSlideRegenForTask(AiTask task, String apiKey) async {
    final slideJson = task.params['slide'] as Map<String, dynamic>;
    final lessonJson = task.params['lesson'] as Map<String, dynamic>;
    final bookContextJson = task.params['bookContext'] as Map<String, dynamic>;
    final chunkPath = task.params['chunkPath'] as String?;
    final note = task.params['note'] as String?;
    final targetType = task.params['targetType'] as String?;
    final screenSizeInfo = task.params['screenSizeInfo'] as String?;

    final result = await _aiService.regenerateSlide(
      slide: Slide.fromJson(slideJson),
      lesson: Lesson.fromJson(lessonJson),
      bookContext: Book.fromJson(bookContextJson),
      chunkPath: chunkPath,
      note: note,
      forcedApiKey: apiKey,
      targetType: targetType,
      screenSizeInfo: screenSizeInfo,
    );
    task.completer.complete(result);
  }

  Future<void> _runUnitGenerationForTask(
    AiTask task,
    Unit unit,
    Book book,
    int modIdx,
    int secIdx,
    int unitIdx,
    String apiKey,
  ) async {
    final avgUnitMs = await _getAverageRunTime('unit_gen_history', 90000);
    final notifId = unit.id.hashCode;

    await NotificationService.showProgress(
      notifId,
      "Generating Lesson",
      "AI is crafting content...",
      indeterminate: true,
    );

    Book applyUnit(Book base, Unit u) {
      final List<Unit> uns = List.from(
        base.modules[modIdx].sections[secIdx].units,
      );
      uns[unitIdx] = u;
      final List<Section> secs = List.from(base.modules[modIdx].sections);
      secs[secIdx] = secs[secIdx].copyWith(units: uns);
      final List<Module> mods = List.from(base.modules);
      mods[modIdx] = mods[modIdx].copyWith(sections: secs);
      return base.copyWith(modules: mods);
    }

    try {
      final stopwatch = Stopwatch()..start();
      final String? sectionPdfPath =
          book.modules[modIdx].sections[secIdx].pdfPath;

      final Book ctxBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final List<Unit> sectionUnits =
          ctxBook.modules[modIdx].sections[secIdx].units;
      final Unit? previousUnit = unitIdx > 0 ? sectionUnits[unitIdx - 1] : null;
      final Unit? nextUnit = unitIdx < sectionUnits.length - 1
          ? sectionUnits[unitIdx + 1]
          : null;

      final List<Unit> previousGeneratedUnits = [];
      for (
        int i = unitIdx - 1;
        i >= 0 && previousGeneratedUnits.length < 2;
        i--
      ) {
        final u = sectionUnits[i];
        if (u.isGenerated && u.lessons.isNotEmpty) {
          previousGeneratedUnits.insert(0, u);
        }
      }

      Future<void> saveChain = Future.value();
      void onLessonGenerated(List<Lesson> lessonsSoFar) {
        final snapshot = List<Lesson>.from(lessonsSoFar);
        if (snapshot.isEmpty) return;
        saveChain = saveChain
            .then((_) async {
              final base = (await _dbService.getBookFromCache(book.id)) ?? book;
              final partial = applyUnit(
                base,
                unit.copyWith(isGenerated: false, lessons: snapshot),
              );
              await _dbService.saveGeneratedBook(partial);
              _bookUpdateController.add(partial);
            })
            .catchError((e) {
              print(
                '[GenerationManager] Streaming save failed for ${unit.id}: $e',
              );
            });
      }

      final updatedUnit = await _aiService.generateUnitContent(
        unit,
        ctxBook,
        (status, {progress, plannedLessons}) {
          task.statusMessage = status;
          if (progress != null) {
            task.progress = progress;
            NotificationService.showProgress(
              notifId,
              "Generating Unit: ${unit.title}",
              status,
              progress: (progress * 100).toInt(),
              maxProgress: 100,
              indeterminate: false,
            );
          } else {
            NotificationService.showProgress(
              notifId,
              "Generating Unit: ${unit.title}",
              status,
              indeterminate: true,
            );
          }
          if (plannedLessons != null) {
            task.params['plannedLessonsCount'] = plannedLessons;
          }
          _syncActiveMapsWithQueue();
          notifyListeners();
        },
        sectionPdfPath: sectionPdfPath,
        previousUnit: previousUnit,
        nextUnit: nextUnit,
        previousGeneratedUnits: previousGeneratedUnits,
        generateGraphics: task.generateGraphics,
        onLessonGenerated: onLessonGenerated,
        forcedApiKey: apiKey,
      );
      stopwatch.stop();
      await _recordRunTime('unit_gen_history', stopwatch.elapsedMilliseconds);

      await saveChain;

      Book baseBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final finalBook = applyUnit(baseBook, updatedUnit);
      await _dbService.saveGeneratedBook(finalBook);
      _bookUpdateController.add(finalBook);

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Lesson Ready!",
        "Tap to start learning.",
        "open_home|",
      );
      task.completer.complete(updatedUnit);
      _crossCheckUnit(finalBook, modIdx, secIdx, unitIdx, updatedUnit, apiKey);
    } catch (e) {
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Generation Failed",
        "Failed to generate lesson.",
        "error",
      );
      rethrow;
    }
  }

  Future<void> _runManifestGenerationForTask(
    AiTask task,
    Book book,
    int modIdx,
    int secIdx,
    String? instructions,
    bool saveGlobally,
    String apiKey, {
    List<String>? selectedQuestions,
  }) async {
    final originalSection = book.modules[modIdx].sections[secIdx];
    final section = selectedQuestions != null
        ? originalSection.copyWith(selectedQuestions: selectedQuestions)
        : originalSection;

    final String? effectiveInstructions =
        (instructions?.trim().isNotEmpty ?? false)
        ? instructions!.trim()
        : (section.customInstructions ?? book.customInstructions);

    final notifId = section.id.hashCode;
    await NotificationService.showProgress(
      notifId,
      'Planning section',
      'Generating unit list...',
      indeterminate: true,
    );

    try {
      final manifestResult = await _aiService.generateUnitManifest(
        section,
        book,
        customInstructions: effectiveInstructions,
        forcedApiKey: apiKey,
      );
      final units = manifestResult.units;
      final newFormats = manifestResult.newFormats;

      final baseBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final modules = List<Module>.from(baseBook.modules);
      final sections = List<Section>.from(modules[modIdx].sections);

      final List<LessonFormat> updatedSectionFormats = [];
      for (final nf in newFormats) {
        final alreadyExists = updatedSectionFormats.any(
          (lf) =>
              lf.id == nf.id || lf.name.toLowerCase() == nf.name.toLowerCase(),
        );
        if (!alreadyExists) {
          updatedSectionFormats.add(nf);
        }
      }

      if (updatedSectionFormats.isEmpty) {
        if (sections[secIdx].lessonFormats != null &&
            sections[secIdx].lessonFormats!.isNotEmpty) {
          updatedSectionFormats.addAll(sections[secIdx].lessonFormats!);
        } else {
          updatedSectionFormats.addAll(
            baseBook.lessonFormats.map((f) => f.copyWith()).toList(),
          );
        }
      }

      // Enforce max 10 lesson formats per section limit
      final cappedFormats = updatedSectionFormats.take(10).toList();

      sections[secIdx] = sections[secIdx].copyWith(
        units: units,
        unitsGenerated: true,
        customInstructions: effectiveInstructions,
        selectedQuestions:
            selectedQuestions ?? sections[secIdx].selectedQuestions,
        lessonFormats: cappedFormats,
      );
      modules[modIdx] = modules[modIdx].copyWith(sections: sections);

      final newBook = baseBook.copyWith(
        modules: modules,
        selectedQuestions: saveGlobally
            ? (selectedQuestions ?? baseBook.selectedQuestions)
            : baseBook.selectedQuestions,
        customInstructions: saveGlobally
            ? effectiveInstructions
            : baseBook.customInstructions,
      );

      await _dbService.saveGeneratedBook(newBook);
      _bookUpdateController.add(newBook);
      await NotificationService.cancel(notifId);
      task.completer.complete(manifestResult);
    } catch (e) {
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        'Section Planning Failed',
        'Could not generate units.',
        'error',
      );
      rethrow;
    }
  }

  Future<void> _runSectionGenerationForTask(
    AiTask task,
    String bookId,
    int modIdx,
    int secIdx,
    String apiKey,
  ) async {
    Book? book = await _dbService.getBookFromCache(bookId);
    if (book == null) throw Exception("Course not found");

    Section section = book.modules[modIdx].sections[secIdx];

    if (section.needsUnitManifest) {
      task.statusMessage = 'Planning section units...';
      task.progress = 0.1;
      _syncActiveMapsWithQueue();
      notifyListeners();

      await _runManifestGenerationForTask(
        task,
        book,
        modIdx,
        secIdx,
        null,
        false,
        apiKey,
      );

      book = await _dbService.getBookFromCache(bookId);
      if (book == null) throw Exception("Course not found after planning");
      section = book.modules[modIdx].sections[secIdx];

      if (!section.unitFormatsConfirmed && section.units.isNotEmpty) {
        final modules = List<Module>.from(book.modules);
        final secs = List<Section>.from(modules[modIdx].sections);
        secs[secIdx] = secs[secIdx].copyWith(unitFormatsConfirmed: true);
        modules[modIdx] = modules[modIdx].copyWith(sections: secs);
        book = book.copyWith(modules: modules);
        await _dbService.saveGeneratedBook(book);
        _bookUpdateController.add(book);
      }
    }

    final unitsToGen = section.units
        .asMap()
        .entries
        .where((entry) => !entry.value.isGenerated)
        .toList();
    if (unitsToGen.isEmpty) {
      task.statusMessage = 'All units already generated';
      task.progress = 1.0;
      _syncActiveMapsWithQueue();
      notifyListeners();
      return;
    }

    for (int i = 0; i < unitsToGen.length; i++) {
      final entry = unitsToGen[i];
      final unitIdx = entry.key;
      final unit = entry.value;

      await startUnitGeneration(
        unit,
        book,
        modIdx,
        secIdx,
        unitIdx,
        generateGraphics: task.generateGraphics,
        isScheduled: task.isScheduled,
      );
    }
    task.statusMessage = 'Enqueued ${unitsToGen.length} units';
    task.progress = 1.0;
    _syncActiveMapsWithQueue();
    notifyListeners();
  }

  Future<void> _runModuleGenerationForTask(
    AiTask task,
    String bookId,
    int modIdx,
    String apiKey,
  ) async {
    final book = await _dbService.getBookFromCache(bookId);
    if (book == null) throw Exception("Course not found");
    final module = book.modules[modIdx];

    for (int i = 0; i < module.sections.length; i++) {
      await startSectionGeneration(
        book,
        modIdx,
        i,
        generateGraphics: task.generateGraphics,
        isScheduled: task.isScheduled,
      );
    }
    task.statusMessage = 'Enqueued ${module.sections.length} sections';
    task.progress = 1.0;
    _syncActiveMapsWithQueue();
    notifyListeners();
  }

  Future<void> _runBookContentGenerationForTask(
    AiTask task,
    String bookId,
    String apiKey,
  ) async {
    final book = await _dbService.getBookFromCache(bookId);
    if (book == null) throw Exception("Course not found");

    for (int i = 0; i < book.modules.length; i++) {
      await startModuleGeneration(
        book,
        i,
        generateGraphics: task.generateGraphics,
        isScheduled: task.isScheduled,
      );
    }
    task.statusMessage = 'Enqueued ${book.modules.length} modules';
    task.progress = 1.0;
    _syncActiveMapsWithQueue();
    notifyListeners();
  }

  Future<void> _runQpGenerationForTask(
    AiTask task,
    List<File> files,
    String qpTitle,
    Book book,
    String? customInstructions,
    String apiKey,
  ) async {
    final notifId = book.id.hashCode + 1;
    await NotificationService.showProgress(
      notifId,
      "Analyzing Exam",
      "Extracting and solving questions natively...",
      indeterminate: true,
    );

    try {
      final qp = await _aiService.generateQuestionPaper(
        files,
        qpTitle,
        book.systemPrompt,
        customInstructions: customInstructions,
        forcedApiKey: apiKey,
      );

      final baseBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final updatedBook = baseBook.copyWith(
        questionPapers: [...baseBook.questionPapers, qp],
      );

      await _dbService.saveGeneratedBook(updatedBook);
      _bookUpdateController.add(updatedBook);
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Exam Ready",
        "Past paper solved interactively!",
        "open_home|",
      );
      task.completer.complete(qp);
    } catch (e) {
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Analysis Failed",
        "Failed to solve past paper.",
        "error",
      );
      rethrow;
    }
  }

  Future<void> _runPyqGenerationForTask(
    AiTask task,
    List<dynamic> files,
    Book book,
    String? customInstructions,
    String apiKey, {
    int? moduleIndex,
  }) async {
    final notifId = book.id.hashCode + 2;
    await NotificationService.showProgress(
      notifId,
      "Analyzing PYQ",
      "Extracting and splitting questions...",
      indeterminate: true,
    );

    print('[PYQ_DIAGNOSTIC] _runPyqGenerationForTask starting for bookId: ${book.id}, moduleIndex: $moduleIndex, files count: ${files.length}');
    try {
      Book freshestBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      print('[PYQ_DIAGNOSTIC] Freshest book retrieved: "${freshestBook.title}" (modules: ${freshestBook.modules.length})');

      if (freshestBook.modules.isEmpty) {
        print('[PYQ_DIAGNOSTIC] Course has no modules. Creating default module & section.');
        final defaultSec = Section(
          id: 'sec_pyq_default_${DateTime.now().millisecondsSinceEpoch}',
          title: 'General Questions',
          description: 'Extracted Past Year Exam Questions',
          color: '#58CC02',
          units: [],
        );
        final defaultMod = Module(
          id: 'mod_pyq_default_${DateTime.now().millisecondsSinceEpoch}',
          title: 'Exam Preparation',
          description: 'Past Year Exam Question Practice',
          sections: [defaultSec],
          practiceQuestions: [],
        );
        freshestBook = freshestBook.copyWith(modules: [defaultMod]);
        await _dbService.saveGeneratedBook(freshestBook);
      }

      // Scope extraction to a single module when one is given (the module the
      // user has open on the Path tab). Questions stay within that module — the
      // cross-section spread below is also limited to its sections.
      final List<Module> scopedModules =
          (moduleIndex != null &&
              moduleIndex >= 0 &&
              moduleIndex < freshestBook.modules.length)
          ? [freshestBook.modules[moduleIndex]]
          : freshestBook.modules;

      List<Section> activeSections = [];
      for (final m in scopedModules) {
        activeSections.addAll(m.sections);
      }
      print('[PYQ_DIAGNOSTIC] Scoped modules count: ${scopedModules.length}, Active sections count: ${activeSections.length}');

      if (activeSections.isEmpty) {
        print('[PYQ_DIAGNOSTIC] Active sections list is empty. Creating default section.');
        final defaultSec = Section(
          id: 'sec_pyq_default_${DateTime.now().millisecondsSinceEpoch}',
          title: 'General Questions',
          description: 'Extracted Past Year Exam Questions',
          color: '#58CC02',
          units: [],
        );
        activeSections.add(defaultSec);
        final updatedMods = List<Module>.from(freshestBook.modules);
        final modIdx = (moduleIndex != null &&
                moduleIndex >= 0 &&
                moduleIndex < updatedMods.length)
            ? moduleIndex
            : 0;
        final updatedSecs = List<Section>.from(updatedMods[modIdx].sections)
          ..add(defaultSec);
        updatedMods[modIdx] =
            updatedMods[modIdx].copyWith(sections: updatedSecs);
        freshestBook = freshestBook.copyWith(modules: updatedMods);
        await _dbService.saveGeneratedBook(freshestBook);
      }

      final Map<String, List<Slide>> newSlidesForSections = {};
      for (final s in activeSections) {
        newSlidesForSections[s.id] = [];
      }

      final parentModule = scopedModules.isNotEmpty
          ? scopedModules.first
          : (freshestBook.modules.isNotEmpty ? freshestBook.modules.first : null);
      final moduleTitle = parentModule?.title;

      final syllabusContext = freshestBook.description.isNotEmpty
          ? freshestBook.description
          : freshestBook.title;

      print('[PYQ_DIAGNOSTIC] Calling _aiService.extractAllPyqQuestions with ${files.length} files and ${activeSections.length} sections...');
      task.statusMessage = 'Extracting questions from paper...';
      task.progress = 0.1;
      notifyListeners();

      final extractedQuestions = await _aiService.extractAllPyqQuestions(
        files: files,
        sections: activeSections,
        moduleTitle: moduleTitle,
        customInstructions: customInstructions,
        forcedApiKey: apiKey,
        syllabusContext: syllabusContext,
        onProgress: (progress, status) {
          print('[PYQ_DIAGNOSTIC] AI Progress (${(progress * 100).toInt()}%): $status');
          task.statusMessage = status;
          task.progress = progress;
          notifyListeners();
        },
      );

      print('[PYQ_DIAGNOSTIC] Total extracted questions returned: ${extractedQuestions.length}');

      if (extractedQuestions.isEmpty) {
        print('[PYQ_DIAGNOSTIC] 0 questions extracted from uploaded document.');
        final qpTask = activePyqTasks[book.id];
        if (qpTask != null) {
          qpTask.isError = true;
          qpTask.status = 'No exam questions were found in the uploaded paper. Please check that the PDF/image contains clear exam questions.';
        }
        notifyListeners();
        await NotificationService.cancel(notifId);
        await NotificationService.showActionable(
          notifId,
          "No Questions Found",
          "No exam questions were found in the uploaded paper. Please try uploading a clearer file.",
          "warning",
        );
        return;
      }

      for (final q in extractedQuestions) {
        final targetSectionId = (q.toJson()['sectionId'] ?? '').toString();
        print('[PYQ_DIAGNOSTIC] Extracted Question "${q.title}" mapped to target sectionId: $targetSectionId');
        if (newSlidesForSections.containsKey(targetSectionId)) {
          final existingInSec = newSlidesForSections[targetSectionId]!;
          if (!isDuplicate(q, existingInSec)) {
            newSlidesForSections[targetSectionId]!.add(q);
          }
        } else if (activeSections.isNotEmpty) {
          final defaultSecId = activeSections.first.id;
          final existingInSec = newSlidesForSections[defaultSecId]!;
          if (!isDuplicate(q, existingInSec)) {
            newSlidesForSections[defaultSecId]!.add(q);
          }
        }
      }

      final updatedModules = freshestBook.modules.map((m) {
        final updatedSecs = m.sections.map((s) {
          final newSlides = newSlidesForSections[s.id];
          if (newSlides != null && newSlides.isNotEmpty) {
            return s.copyWith(pyqQuestions: [...s.pyqQuestions, ...newSlides]);
          }
          return s;
        }).toList();
        return m.copyWith(sections: updatedSecs);
      }).toList();

      final finalBook = freshestBook.copyWith(modules: updatedModules);
      await _dbService.saveGeneratedBook(finalBook);
      _bookUpdateController.add(finalBook);
      await NotificationService.cancel(notifId);
      print('[PYQ_DIAGNOSTIC] PYQ extraction completed successfully! Saved book "${finalBook.title}"');
      task.completer.complete(null);
    } catch (e, stack) {
      print('[PYQ_DIAGNOSTIC] CRITICAL EXCEPTION in _runPyqGenerationForTask: $e\n$stack');
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "PYQ Analysis Failed",
        "Failed to extract exam questions: $e",
        "error",
      );
      rethrow;
    }
  }

  Future<void> _runLessonRegenForTask(
    AiTask task,
    Book book,
    int modIdx,
    int secIdx,
    int unitIdx,
    int lessonIdx,
    Lesson lesson,
    String apiKey,
  ) async {
    final notifId = ('regen_${lesson.id}').hashCode;
    await NotificationService.showProgress(
      notifId,
      'Regenerating lesson',
      lesson.title,
      indeterminate: true,
    );

    try {
      final ctxBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final sectionUnits = ctxBook.modules[modIdx].sections[secIdx].units;
      final unit = sectionUnits[unitIdx];
      final Unit? previousUnit = unitIdx > 0 ? sectionUnits[unitIdx - 1] : null;
      final Unit? nextUnit = unitIdx < sectionUnits.length - 1
          ? sectionUnits[unitIdx + 1]
          : null;
      final String? sectionPdfPath =
          ctxBook.modules[modIdx].sections[secIdx].pdfPath;

      final String? customPrompt = task.params['customPrompt'];
      final String? newFormatId = task.params['newFormatId'];

      final fresh = await _aiService.regenerateLesson(
        lesson: lesson,
        unit: unit,
        bookContext: ctxBook,
        sectionPdfPath: sectionPdfPath,
        previousUnit: previousUnit,
        nextUnit: nextUnit,
        generateGraphics: task.generateGraphics,
        forcedApiKey: apiKey,
        customPrompt: customPrompt,
        newFormatId: newFormatId,
      );
      if (fresh == null) {
        throw Exception(
          'Lesson regeneration failed. The previous lesson is kept.',
        );
      }

      final base = (await _dbService.getBookFromCache(book.id)) ?? book;
      final mods = List<Module>.from(base.modules);
      final secs = List<Section>.from(mods[modIdx].sections);
      final uns = List<Unit>.from(secs[secIdx].units);
      final lessons = List<Lesson>.from(uns[unitIdx].lessons);
      lessons[lessonIdx] = fresh;
      uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
      secs[secIdx] = secs[secIdx].copyWith(units: uns);
      mods[modIdx] = mods[modIdx].copyWith(sections: secs);
      final newBook = base.copyWith(modules: mods);

      await ProgressService.clearLessonProgress(lesson.id, book.id);
      await _dbService.saveGeneratedBook(newBook);
      _bookUpdateController.add(newBook);
      await NotificationService.cancel(notifId);
      task.completer.complete(fresh);
    } catch (e) {
      await NotificationService.cancel(notifId);
      rethrow;
    }
  }

  Future<void> _runCustomLessonGenForTask(
    AiTask task,
    Book book,
    int modIdx,
    int secIdx,
    int unitIdx,
    String apiKey,
  ) async {
    final String prompt = task.params['prompt'] as String;
    final List<String> filePaths = List<String>.from(
      task.params['filePaths'] ?? [],
    );
    final List<File> files = filePaths.map((p) => File(p)).toList();
    final Map<String, dynamic> formatJson =
        task.params['format'] as Map<String, dynamic>;
    final format = LessonFormat.fromJson(formatJson);
    final String lessonId = task.params['lessonId'] as String;

    final String? screenSizeInfo = task.params['screenSizeInfo'] as String?;

    final notifId = ('custom_gen_$lessonId').hashCode;
    await NotificationService.showProgress(
      notifId,
      'Creating custom lesson',
      'Preparing...',
      indeterminate: true,
    );

    try {
      final ctxBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final unit = ctxBook.modules[modIdx].sections[secIdx].units[unitIdx];
      final List<Slide> generatedSlides = [];
      final totalSlides = format.slides.length;

      for (int i = 0; i < totalSlides; i++) {
        final template = format.slides[i];

        await NotificationService.showProgress(
          notifId,
          'Creating custom lesson',
          'Generating slide ${i + 1} of $totalSlides (${template.type})...',
          indeterminate: true,
        );

        task.progress = i / totalSlides;
        task.statusMessage = 'Generating slide ${i + 1} of $totalSlides';
        _syncActiveMapsWithQueue();
        notifyListeners();

        final slide = await _aiService.generateCustomLessonSlide(
          lessonTitle: 'Custom Lesson',
          unitTitle: unit.title,
          slideType: template.type,
          slideDescription: template.description,
          userInstructions: prompt,
          attachedFiles: files,
          slidesSoFar: generatedSlides,
          slideIndex: i + 1,
          totalSlides: totalSlides,
          bookContext: ctxBook,
          forcedApiKey: apiKey,
          screenSizeInfo: screenSizeInfo,
        );

        if (slide != null) {
          final uniqueSlideId = '$lessonId-s${i + 1}';
          final updatedSlide = slide.copyWith(id: uniqueSlideId);
          generatedSlides.add(updatedSlide);

          final base = (await _dbService.getBookFromCache(book.id)) ?? book;
          final mods = List<Module>.from(base.modules);
          final secs = List<Section>.from(mods[modIdx].sections);
          final uns = List<Unit>.from(secs[secIdx].units);
          final lessons = List<Lesson>.from(uns[unitIdx].lessons);

          final lessonIndex = lessons.indexWhere((l) => l.id == lessonId);
          if (lessonIndex != -1) {
            lessons[lessonIndex] = lessons[lessonIndex].copyWith(
              slides: List.from(generatedSlides),
              title: generatedSlides.isNotEmpty
                  ? generatedSlides.first.title
                  : 'Custom Lesson',
            );
            uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
            secs[secIdx] = secs[secIdx].copyWith(units: uns);
            mods[modIdx] = mods[modIdx].copyWith(sections: secs);
            final newBook = base.copyWith(modules: mods);

            await _dbService.saveGeneratedBook(newBook);
            _bookUpdateController.add(newBook);
          }
        }
      }
      await NotificationService.cancel(notifId);
    } catch (e) {
      await NotificationService.cancel(notifId);
      rethrow;
    }
  }

  Future<void> startCustomLessonGeneration({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required String prompt,
    required List<File> selectedFiles,
    required LessonFormat format,
    required String lessonId,
    String? screenSizeInfo,
  }) async {
    _enqueue(
      title: 'Generate Custom Lesson',
      type: 'custom_lesson_gen',
      bookId: book.id,
      moduleId: book.modules[modIdx].id,
      sectionId: book.modules[modIdx].sections[secIdx].id,
      unitId: book.modules[modIdx].sections[secIdx].units[unitIdx].id,
      generateGraphics: false,
      isScheduled: false,
      highPriority: true,
      params: {
        'modIdx': modIdx,
        'secIdx': secIdx,
        'unitIdx': unitIdx,
        'prompt': prompt,
        'filePaths': selectedFiles.map((f) => f.path).toList(),
        'format': format.toJson(),
        'lessonId': lessonId,
        'screenSizeInfo': screenSizeInfo,
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Interface Methods called by Screens / Callers
  // ---------------------------------------------------------------------------
  Future<void> startBookGeneration(
    List<File> sourceFiles,
    String filename, {
    List<File> indexFiles = const [],
    List<int> chapter1AbsolutePages = const [],
    String? customInstructions,
    List<File> syllabusFiles = const [],
    bool isHandout = false,
    List<List<int>>? chapterStarts,
    List<String>? plannerQuestions,
    List<String>? selectedQuestions,
    String? bloomLevel,
  }) async {
    sourceFiles = sourceFiles.toList();
    final taskId = DateTime.now().millisecondsSinceEpoch.toString();
    final notifId = taskId.hashCode;

    double totalSize = 0;
    for (var f in sourceFiles) {
      totalSize += await f.length();
    }

    final uploadSecs = (totalSize / 500000).ceil();
    final avgAiMs = await _getAverageRunTime('meta_gen_history', 120000);
    final estimatedDuration = Duration(
      seconds: uploadSecs,
      milliseconds: avgAiMs,
    );

    final task = GenerationTask(
      id: taskId,
      title: filename,
      sourceFiles: sourceFiles,
      syllabusFiles: syllabusFiles,
      startTime: DateTime.now(),
      estimatedDuration: estimatedDuration,
      plannerQuestions: plannerQuestions,
      selectedQuestions: selectedQuestions,
      bloomLevel: bloomLevel,
    );

    activeTasks.add(task);
    notifyListeners();

    await NotificationService.showProgress(
      notifId,
      "Analyzing Source",
      "Extracting metadata...",
      indeterminate: true,
    );

    try {
      final stopwatch = Stopwatch()..start();

      // Route skeleton generation through queue!
      final skeletonBook = await startBookSkeletonGenerationTask(
        indexFiles,
        filename,
        chapter1AbsolutePages: chapter1AbsolutePages,
        customInstructions: customInstructions,
        syllabusFiles: syllabusFiles,
        isHandout: isHandout,
        chapterStarts: chapterStarts,
        sourceFiles: sourceFiles,
        parentTaskId: taskId,
      );

      stopwatch.stop();
      await _recordRunTime('meta_gen_history', stopwatch.elapsedMilliseconds);

      if (skeletonBook != null) {
        if (isHandout) {
          await startBackgroundSplitAndSave(taskId, sourceFiles, skeletonBook);
        } else {
          final prefs = await SharedPreferences.getInstance();
          final autoVerify = prefs.getBool('auto_verify_mappings') ?? true;

          Book bookToSplit = skeletonBook;
          // Knowledge-only books (no source PDFs) have no page mappings to
          // verify or review — save them straight away.
          bool verificationPassed = sourceFiles.isEmpty;
          if (autoVerify && sourceFiles.isNotEmpty) {
            task.statusMessage = 'Verifying page mappings...';
            notifyListeners();
            void onStatus(String s) {
              task.statusMessage = s;
              notifyListeners();
            }

            try {
              final verifier = MappingVerifier(
                pdfService: _pdfService,
                aiService: _aiService,
              );
              var report = await verifier.verify(
                sourceFiles,
                bookToSplit,
                onStatus: onStatus,
              );
              if (!report.pass && report.suggestedShift != null) {
                final shift = report.suggestedShift!;
                onStatus(
                  'Auto-correcting a ${shift > 0 ? '+$shift' : '$shift'} page shift…',
                );
                final shifted = MappingVerifier.applyGlobalShift(
                  bookToSplit,
                  shift,
                );
                report = await verifier.verify(
                  sourceFiles,
                  shifted,
                  onStatus: onStatus,
                );
                if (report.pass) bookToSplit = shifted;
              }
              verificationPassed = report.pass;
              if (verificationPassed) {
                onStatus('Running post-create AI verification...');
                final match = await verifier.verifyPostCreateFirstChunk(
                  sourceFiles,
                  bookToSplit,
                );
                if (!match) {
                  print(
                    '[GenerationManager] Post-create AI verification failed.',
                  );
                  verificationPassed = false;
                  task.statusMessage =
                      'Action Required: AI verification failed. Adjust offset.';
                }
              }
              print('[GenerationManager] ${report.describe()}');
            } catch (e) {
              // Verification is advisory: an internal failure routes to manual
              // review instead of silently passing or blocking.
              print('[GenerationManager] Mapping verification errored: $e');
              verificationPassed = false;
            }
          }

          if (verificationPassed) {
            print(
              '[GenerationManager] Mapping verification passed. Proceeding automatically...',
            );
            await startBackgroundSplitAndSave(
              taskId,
              sourceFiles,
              bookToSplit.copyWith(mappingVerified: true),
            );
          } else {
            task.skeletonBook = bookToSplit;
            task.state = BookGenState.review;
            task.statusMessage = 'Action Required: Review Splits';
            notifyListeners();

            await NotificationService.cancel(notifId);
            await NotificationService.showActionable(
              notifId,
              "Course Skeleton Ready",
              "Tap to review page splits.",
              "review_split|$taskId",
            );
          }
        }
      }
    } catch (e) {
      task.state = BookGenState.error;
      task.errorMessage = e.toString();
      task.statusMessage = 'Failed to generate structure';
      notifyListeners();

      final shortError = e.toString().length > 200
          ? "${e.toString().substring(0, 200)}..."
          : e.toString();
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Generation Failed",
        shortError,
        "error",
      );
    }
  }

  Future<void> startBackgroundSplitAndSave(
    String taskId,
    List<File> sourceFiles,
    Book offsetBook,
  ) async {
    final taskIndex = activeTasks.indexWhere((t) => t.id == taskId);
    if (taskIndex == -1) return;

    final task = activeTasks[taskIndex];
    task.state = BookGenState.chunking;
    task.statusMessage = 'Native Vector Splitting...';
    task.progress = null;
    task.estimatedDuration = const Duration(seconds: 15);
    task.startTime = DateTime.now();
    notifyListeners();

    final notifId = taskId.hashCode;
    await NotificationService.showProgress(
      notifId,
      "Chunking Pages",
      "Processing natively...",
      indeterminate: true,
    );

    try {
      // Knowledge-only books have no source PDFs — nothing to split.
      final completeBook = sourceFiles.isEmpty
          ? offsetBook
          : await _pdfService.splitBookPdf(sourceFiles, offsetBook, (
              status,
              progress,
            ) {
              task.statusMessage = status;
              task.progress = progress;
              notifyListeners();
              NotificationService.showProgress(
                notifId,
                "Chunking Document",
                status,
                indeterminate: true,
              );
            });

      task.state = BookGenState.saving;
      task.statusMessage = 'Saving to Database...';
      notifyListeners();

      Book finalBook = completeBook;
      if (task.plannerQuestions != null) {
        finalBook = finalBook.copyWith(plannerQuestions: task.plannerQuestions);
      }
      if (task.selectedQuestions != null) {
        finalBook = finalBook.copyWith(
          selectedQuestions: task.selectedQuestions,
        );
      }
      if (task.bloomLevel != null) {
        finalBook = finalBook.copyWith(bloomLevel: task.bloomLevel);
      }
      if (task.syllabusFiles.isNotEmpty) {
        try {
          final dir = await getApplicationDocumentsDirectory();
          final bookDirPath = '${dir.path}/books/${finalBook.id}';
          final bookDir = Directory(bookDirPath);
          if (!await bookDir.exists()) {
            await bookDir.create(recursive: true);
          }
          File finalSyllabusFile;
          if (task.syllabusFiles.length == 1) {
            finalSyllabusFile = task.syllabusFiles.first;
          } else {
            finalSyllabusFile = await _pdfService.mergeFiles(
              task.syllabusFiles,
            );
          }
          if (await finalSyllabusFile.exists()) {
            final ext = finalSyllabusFile.path.split('.').last;
            final targetPath = '$bookDirPath/syllabus.$ext';
            await finalSyllabusFile.copy(targetPath);
            finalBook = finalBook.copyWith(syllabusPath: targetPath);
          }
        } catch (e) {
          print('Error automatically saving syllabus file: $e');
        }
      }

      await _dbService.saveGeneratedBook(finalBook);

      activeTasks.remove(task);
      notifyListeners();

      _bookUpdateController.add(finalBook);
      onBookGenerated?.call();

      // Trigger automatic Module 1 generation if configured
      final prefs = await SharedPreferences.getInstance();
      final autoGenModule1 = prefs.getBool('auto_generate_module_1') ?? true;
      if (autoGenModule1) {
        autoGenerateModule1Contents(finalBook);
      }

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Course Created!",
        "Your book is ready.",
        "open_home|",
      );
    } catch (e) {
      task.state = BookGenState.error;
      task.statusMessage = 'Error chunking file';
      task.errorMessage = e.toString();
      notifyListeners();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Error",
        "Failed to split file.",
        "error",
      );
    }
  }

  Future<void> restoreBookFiles(Book book, List<File> sourceFiles) async {
    final taskId = "restore_${book.id}";
    if (activeTasks.any((t) => t.id == taskId)) return;

    final notifId = taskId.hashCode;

    final task = GenerationTask(
      id: taskId,
      title: "Restoring ${book.title}",
      sourceFiles: sourceFiles,
      state: BookGenState.chunking,
      statusMessage: 'Re-splitting source files...',
      estimatedDuration: const Duration(seconds: 15),
      startTime: DateTime.now(),
    );

    activeTasks.add(task);
    notifyListeners();

    await NotificationService.showProgress(
      notifId,
      "Restoring Files",
      "Re-splitting source natively...",
      indeterminate: true,
    );

    try {
      List<File> finalSourceFiles = sourceFiles;
      final bool isMultiBookCourse = book.modules.any(
        (m) => m.sections.any((s) => (s.bookIndex ?? 0) > 0),
      );
      if (!isMultiBookCourse) {
        if (sourceFiles.length > 1 ||
            (sourceFiles.isNotEmpty &&
                !sourceFiles.first.path.toLowerCase().endsWith('.pdf'))) {
          finalSourceFiles = [await _pdfService.mergeFiles(sourceFiles)];
        }
      }

      final completeBook = await _pdfService.splitBookPdf(
        finalSourceFiles,
        book,
        (status, progress) {
          task.statusMessage = status;
          task.progress = progress;
          notifyListeners();
          NotificationService.showProgress(
            notifId,
            "Restoring Document",
            status,
            indeterminate: true,
          );
        },
        preserveLessons: true,
      );

      task.state = BookGenState.saving;
      task.statusMessage = 'Saving to Database...';
      notifyListeners();

      await _dbService.saveGeneratedBook(completeBook);

      activeTasks.remove(task);
      notifyListeners();

      _bookUpdateController.add(completeBook);

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Files Restored!",
        "Your course is ready for generation.",
        "open_home|",
      );
    } catch (e) {
      task.state = BookGenState.error;
      task.statusMessage = 'Error restoring files';
      task.errorMessage = e.toString();
      notifyListeners();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(
        notifId,
        "Error",
        "Failed to restore files.",
        "error",
      );
    }
  }

  Future<void> startUnitGeneration(
    Unit unit,
    Book book,
    int modIdx,
    int secIdx,
    int unitIdx, {
    bool generateGraphics = true,
    bool isScheduled = false,
  }) async {
    if (queue.any(
      (t) =>
          t.unitId == unit.id &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    _enqueue(
      title: 'Unit: ${unit.title}',
      type: 'unit',
      bookId: book.id,
      moduleId: book.modules[modIdx].id,
      sectionId: book.modules[modIdx].sections[secIdx].id,
      unitId: unit.id,
      generateGraphics: generateGraphics,
      isScheduled: isScheduled,
      params: {'modIdx': modIdx, 'secIdx': secIdx, 'unitIdx': unitIdx},
    );
  }

  final Map<String, UnitGenTask> activeSectionManifests = {};
  final Map<String, UnitGenTask> activeSectionGenerations = {};
  final Set<String> activeCanvasRegens = {};
  final Set<String> activeSlideRegens = {};
  final Set<String> activeLessonRegens = {};
  final List<AiTask> _pausedTasks = [];

  Future<void> startSectionUnitManifest(
    Book book,
    int modIdx,
    int secIdx, {
    String? instructions,
    List<String>? selectedQuestions,
    bool saveGlobally = false,
    bool isScheduled = false,
  }) async {
    final section = book.modules[modIdx].sections[secIdx];
    if (queue.any(
      (t) =>
          t.sectionId == section.id &&
          t.type == 'manifest' &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    _enqueue(
      title: 'Plan Manifest: ${section.title}',
      type: 'manifest',
      bookId: book.id,
      moduleId: book.modules[modIdx].id,
      sectionId: section.id,
      generateGraphics: true,
      isScheduled: isScheduled,
      params: {
        'modIdx': modIdx,
        'secIdx': secIdx,
        'instructions': instructions,
        'selectedQuestions': ?selectedQuestions,
        'saveGlobally': saveGlobally,
      },
    );
  }

  Future<void> startSectionGeneration(
    Book book,
    int modIdx,
    int secIdx, {
    bool generateGraphics = true,
    bool isScheduled = false,
  }) async {
    final section = book.modules[modIdx].sections[secIdx];
    if (queue.any(
      (t) =>
          t.sectionId == section.id &&
          t.type == 'section' &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    _enqueue(
      title: 'Section Contents: ${section.title}',
      type: 'section',
      bookId: book.id,
      moduleId: book.modules[modIdx].id,
      sectionId: section.id,
      generateGraphics: generateGraphics,
      isScheduled: isScheduled,
      params: {'modIdx': modIdx, 'secIdx': secIdx},
    );
  }

  Future<void> startModuleGeneration(
    Book book,
    int modIdx, {
    bool generateGraphics = true,
    bool isScheduled = false,
  }) async {
    final module = book.modules[modIdx];
    if (queue.any(
      (t) =>
          t.moduleId == module.id &&
          t.type == 'module' &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    _enqueue(
      title: 'Module Contents: ${module.title}',
      type: 'module',
      bookId: book.id,
      moduleId: module.id,
      generateGraphics: generateGraphics,
      isScheduled: isScheduled,
      params: {'modIdx': modIdx},
    );
  }

  Future<void> startBookContentGeneration(
    Book book, {
    bool generateGraphics = true,
    bool isScheduled = false,
  }) async {
    if (queue.any(
      (t) =>
          t.bookId == book.id &&
          t.type == 'book_content' &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    _enqueue(
      title: 'Course Contents: ${book.title}',
      type: 'book_content',
      bookId: book.id,
      generateGraphics: generateGraphics,
      isScheduled: isScheduled,
      params: {},
    );
  }

  Future<void> regenerateLessonCanvas({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
    String? errorContext,
  }) async {
    final lesson =
        book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
    if ((lesson.canvasPrompt?.trim().isEmpty ?? true) ||
        activeCanvasRegens.contains(lesson.id)) {
      return;
    }
    activeCanvasRegens.add(lesson.id);
    notifyListeners();
    try {
      final svg = await generateCanvasArtTask(
        lesson.canvasPrompt!,
        contextText: lesson.slides.isNotEmpty
            ? lesson.slides.first.content
            : '',
        errorContext: errorContext,
      );
      if (svg == null) return;
      final base = (await _dbService.getBookFromCache(book.id)) ?? book;
      final mods = List<Module>.from(base.modules);
      final secs = List<Section>.from(mods[modIdx].sections);
      final uns = List<Unit>.from(secs[secIdx].units);
      final lessons = List<Lesson>.from(uns[unitIdx].lessons);
      lessons[lessonIdx] = lessons[lessonIdx].copyWith(canvasSvg: svg);
      uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
      secs[secIdx] = secs[secIdx].copyWith(units: uns);
      mods[modIdx] = mods[modIdx].copyWith(sections: secs);
      final newBook = base.copyWith(modules: mods);
      await _dbService.saveGeneratedBook(newBook);
      _bookUpdateController.add(newBook);
    } finally {
      activeCanvasRegens.remove(lesson.id);
      notifyListeners();
    }
  }

  Future<void> regenerateSlideCanvas({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
    required int slideIdx,
    String? errorContext,
  }) async {
    final slide = book
        .modules[modIdx]
        .sections[secIdx]
        .units[unitIdx]
        .lessons[lessonIdx]
        .slides[slideIdx];
    if ((slide.canvasPrompt?.trim().isEmpty ?? true) ||
        activeCanvasRegens.contains(slide.id)) {
      return;
    }
    activeCanvasRegens.add(slide.id);
    notifyListeners();
    try {
      final svg = await generateCanvasArtTask(
        slide.canvasPrompt!,
        contextText: slide.content,
        errorContext: errorContext,
      );
      if (svg == null) return;
      final base = (await _dbService.getBookFromCache(book.id)) ?? book;
      final mods = List<Module>.from(base.modules);
      final secs = List<Section>.from(mods[modIdx].sections);
      final uns = List<Unit>.from(secs[secIdx].units);
      final lessons = List<Lesson>.from(uns[unitIdx].lessons);
      final slides = List<Slide>.from(lessons[lessonIdx].slides);
      slides[slideIdx] = slides[slideIdx].copyWith(canvasSvg: svg);
      lessons[lessonIdx] = lessons[lessonIdx].copyWith(slides: slides);
      uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
      secs[secIdx] = secs[secIdx].copyWith(units: uns);
      mods[modIdx] = mods[modIdx].copyWith(sections: secs);
      final newBook = base.copyWith(modules: mods);
      await _dbService.saveGeneratedBook(newBook);
      _bookUpdateController.add(newBook);
    } finally {
      activeCanvasRegens.remove(slide.id);
      notifyListeners();
    }
  }

  Future<void> saveSlideEdit({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
    required int slideIdx,
    required Slide updated,
  }) async {
    final base = (await _dbService.getBookFromCache(book.id)) ?? book;
    final mods = List<Module>.from(base.modules);
    final secs = List<Section>.from(mods[modIdx].sections);
    final uns = List<Unit>.from(secs[secIdx].units);
    final lessons = List<Lesson>.from(uns[unitIdx].lessons);
    final slides = List<Slide>.from(lessons[lessonIdx].slides);
    slides[slideIdx] = updated;
    lessons[lessonIdx] = lessons[lessonIdx].copyWith(slides: slides);
    uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
    secs[secIdx] = secs[secIdx].copyWith(units: uns);
    mods[modIdx] = mods[modIdx].copyWith(sections: secs);
    final newBook = base.copyWith(modules: mods);
    await _dbService.saveGeneratedBook(newBook);
    _bookUpdateController.add(newBook);
    notifyListeners();
  }

  Future<void> deleteSlide({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
    required int slideIdx,
  }) async {
    final base = (await _dbService.getBookFromCache(book.id)) ?? book;
    final mods = List<Module>.from(base.modules);
    final secs = List<Section>.from(mods[modIdx].sections);
    final uns = List<Unit>.from(secs[secIdx].units);
    final lessons = List<Lesson>.from(uns[unitIdx].lessons);
    final slides = List<Slide>.from(lessons[lessonIdx].slides);

    slides.removeAt(slideIdx);

    lessons[lessonIdx] = lessons[lessonIdx].copyWith(slides: slides);
    uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
    secs[secIdx] = secs[secIdx].copyWith(units: uns);
    mods[modIdx] = mods[modIdx].copyWith(sections: secs);
    final newBook = base.copyWith(modules: mods);

    await _dbService.saveGeneratedBook(newBook);
    _bookUpdateController.add(newBook);
    notifyListeners();
  }

  Future<void> regenerateLesson({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
    bool generateGraphics = true,
    void Function(String message)? errorSink,
    bool isScheduled = false,
    String? customPrompt,
    String? newFormatId,
  }) async {
    final lesson =
        book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
    if (queue.any(
      (t) =>
          t.params['lessonId'] == lesson.id &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    _enqueue(
      title: 'Regen Lesson: ${lesson.title}',
      type: 'lesson_regen',
      bookId: book.id,
      moduleId: book.modules[modIdx].id,
      sectionId: book.modules[modIdx].sections[secIdx].id,
      unitId: book.modules[modIdx].sections[secIdx].units[unitIdx].id,
      generateGraphics: generateGraphics,
      isScheduled: isScheduled,
      params: {
        'modIdx': modIdx,
        'secIdx': secIdx,
        'unitIdx': unitIdx,
        'lessonIdx': lessonIdx,
        'lessonId': lesson.id,
        'customPrompt': ?customPrompt,
        'newFormatId': ?newFormatId,
      },
    );
  }

  Future<void> regenerateSlide({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
    required int slideIdx,
    String? note,
    String? targetType,
    String? screenSizeInfo,
  }) async {
    final base = (await _dbService.getBookFromCache(book.id)) ?? book;

    final lesson =
        book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
    final slide = lesson.slides[slideIdx];

    int targetModIdx = -1;
    int targetSecIdx = -1;
    int targetUnitIdx = -1;
    int targetLessonIdx = -1;

    for (int m = 0; m < base.modules.length; m++) {
      final mod = base.modules[m];
      for (int s = 0; s < mod.sections.length; s++) {
        final sec = mod.sections[s];
        for (int u = 0; u < sec.units.length; u++) {
          final un = sec.units[u];
          for (int l = 0; l < un.lessons.length; l++) {
            if (un.lessons[l].id == lesson.id) {
              targetModIdx = m;
              targetSecIdx = s;
              targetUnitIdx = u;
              targetLessonIdx = l;
              break;
            }
          }
        }
      }
    }

    if (targetModIdx == -1 ||
        targetSecIdx == -1 ||
        targetUnitIdx == -1 ||
        targetLessonIdx == -1) {
      targetModIdx = modIdx;
      targetSecIdx = secIdx;
      targetUnitIdx = unitIdx;
      targetLessonIdx = lessonIdx;
    }

    final freshLesson = base
        .modules[targetModIdx]
        .sections[targetSecIdx]
        .units[targetUnitIdx]
        .lessons[targetLessonIdx];

    if (activeSlideRegens.contains(slide.id)) return;
    activeSlideRegens.add(slide.id);
    notifyListeners();

    try {
      final String? chunkPath =
          base
              .modules[targetModIdx]
              .sections[targetSecIdx]
              .units[targetUnitIdx]
              .pdfPath ??
          base.modules[targetModIdx].sections[targetSecIdx].pdfPath;

      final fresh = await regenerateSlideTask(
        slide: slide,
        lesson: freshLesson,
        bookContext: base,
        chunkPath: chunkPath,
        note: note,
        targetType: targetType,
        screenSizeInfo: screenSizeInfo,
      );

      if (fresh == null) {
        throw Exception('Failed to regenerate slide: empty response from AI.');
      }

      final mods = List<Module>.from(base.modules);
      final secs = List<Section>.from(mods[targetModIdx].sections);
      final uns = List<Unit>.from(secs[targetSecIdx].units);
      final lessons = List<Lesson>.from(uns[targetUnitIdx].lessons);
      final slides = List<Slide>.from(lessons[targetLessonIdx].slides);

      int targetSlideIdx = slides.indexWhere((s) => s.id == slide.id);
      if (targetSlideIdx == -1) {
        targetSlideIdx = slideIdx;
      }

      slides[targetSlideIdx] = fresh;
      lessons[targetLessonIdx] = lessons[targetLessonIdx].copyWith(
        slides: slides,
      );
      uns[targetUnitIdx] = uns[targetUnitIdx].copyWith(lessons: lessons);
      secs[targetSecIdx] = secs[targetSecIdx].copyWith(units: uns);
      mods[targetModIdx] = mods[targetModIdx].copyWith(sections: secs);

      final newBook = base.copyWith(modules: mods);
      await _dbService.saveGeneratedBook(newBook);
      _bookUpdateController.add(newBook);
    } finally {
      activeSlideRegens.remove(slide.id);
      notifyListeners();
    }
  }

  void clearSectionManifestError(String sectionId) {
    activeSectionManifests.remove(sectionId);
    notifyListeners();
  }

  Future<void> startQpGeneration(
    String bookId,
    List<File> files,
    String qpTitle,
    Book currentBook, {
    String? customInstructions,
    bool isScheduled = false,
  }) async {
    if (queue.any(
      (t) =>
          t.bookId == bookId &&
          t.type == 'qp' &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    final filePaths = files.map((f) => f.path).toList();

    _enqueue(
      title: 'Exam: $qpTitle',
      type: 'qp',
      bookId: bookId,
      generateGraphics: true,
      isScheduled: isScheduled,
      params: {
        'title': qpTitle,
        'filePaths': filePaths,
        'instructions': customInstructions,
      },
    );
  }

  void clearUnitError(String unitId) {
    activeUnitGenerations.remove(unitId);
    notifyListeners();
  }

  void clearQpError(String bookId) {
    activeQpTasks.remove(bookId);
    notifyListeners();
  }

  void clearPyqError(String bookId) {
    activePyqTasks.remove(bookId);
    notifyListeners();
  }

  Future<void> startPyqAnalysis(
    String bookId,
    List<dynamic> files,
    Book currentBook, {
    String? customInstructions,
    bool isScheduled = false,
    int? moduleIndex,
  }) async {
    if (queue.any(
      (t) =>
          t.bookId == bookId &&
          t.type == 'pyq' &&
          (t.status == 'queued' || t.status == 'running'),
    )) {
      return;
    }

    final taskId = 'pyq_${DateTime.now().millisecondsSinceEpoch}_$bookId';

    final platformFiles = files.whereType<PlatformFile>().toList();
    if (platformFiles.isNotEmpty) {
      _inMemoryPyqFiles[taskId] = platformFiles;
    }

    final filePaths = files.whereType<File>().map((f) => f.path).toList();

    _enqueue(
      customTaskId: taskId,
      title: 'PYQ: ${currentBook.title}',
      type: 'pyq',
      bookId: bookId,
      generateGraphics: true,
      isScheduled: isScheduled,
      params: {
        'filePaths': filePaths,
        'instructions': customInstructions,
        'moduleIndex': ?moduleIndex,
      },
    );
  }

  bool isDuplicate(Slide newQ, List<Slide> existing) {
    final normNew = newQ.content.trim().toLowerCase();
    for (final q in existing) {
      if (q.id == newQ.id) return true;
      if (q.content.trim().toLowerCase() == normNew) return true;
    }
    return false;
  }

  void dismissTask(String id) {
    activeTasks.removeWhere((t) => t.id == id);
    NotificationService.cancel(id.hashCode);
    notifyListeners();
  }

  void _clearTaskNotification(AiTask task) {
    try {
      if (task.type == 'unit' && task.unitId != null) {
        NotificationService.cancel(task.unitId!.hashCode);
      } else if (task.type == 'manifest' && task.sectionId != null) {
        NotificationService.cancel(task.sectionId!.hashCode);
      } else if (task.type == 'qp') {
        NotificationService.cancel(task.bookId.hashCode + 1);
      } else if (task.type == 'pyq') {
        NotificationService.cancel(task.bookId.hashCode + 2);
      } else if (task.type == 'lesson_regen' &&
          task.params['lessonId'] != null) {
        NotificationService.cancel(
          ('regen_${task.params['lessonId']}').hashCode,
        );
      } else if (task.type == 'book_skeleton') {
        final timestampStr = task.id.replaceAll('skeleton_', '');
        final notifId =
            int.tryParse(timestampStr)?.hashCode ?? task.id.hashCode;
        NotificationService.cancel(notifId);
        NotificationService.cancel(task.id.hashCode);
        activeTasks.removeWhere((t) => t.id == timestampStr);
      } else {
        NotificationService.cancel(task.id.hashCode);
      }
    } catch (e) {
      print('[GenerationManager] Error cancelling notification: $e');
    }
  }

  void _pauseAllOtherTasks() {
    final otherTasks = queue
        .where(
          (t) =>
              t.type != 'slide_regen' &&
              (t.status == 'running' || t.status == 'queued'),
        )
        .toList();

    for (final t in otherTasks) {
      t.status = 'failed';
      t.errorMessage = 'Paused for priority slide regeneration.';
      t.statusMessage = 'Paused';
      if (!t.completer.isCompleted) {
        t.completer.completeError(Exception('Paused for priority task'));
      }
      _clearTaskNotification(t);
      _pausedTasks.add(t);
    }

    queue.removeWhere(
      (t) =>
          t.type != 'slide_regen' &&
          (t.status == 'running' || t.status == 'queued'),
    );

    _syncActiveMapsWithQueue();
    notifyListeners();
    _saveQueueToPrefs();
  }

  void _resumeAllPausedTasks() {
    if (_pausedTasks.isEmpty) return;
    for (final t in _pausedTasks) {
      final newTask = AiTask(
        id: t.id,
        title: t.title,
        bookId: t.bookId,
        moduleId: t.moduleId,
        sectionId: t.sectionId,
        unitId: t.unitId,
        type: t.type,
        generateGraphics: t.generateGraphics,
        isScheduled: t.isScheduled,
        status: 'queued',
        statusMessage: 'Queued',
        params: t.params,
      );
      _enqueueTaskObject(newTask);
    }
    _pausedTasks.clear();
  }

  void cancelQueuedTask(String id) {
    final taskIndex = queue.indexWhere((t) => t.id == id);
    if (taskIndex != -1) {
      final task = queue[taskIndex];
      _clearTaskNotification(task);
      queue.removeAt(taskIndex);
    }
    _syncActiveMapsWithQueue();
    notifyListeners();
    _saveQueueToPrefs();
    _processQueue();
  }

  void cancelAllTasks() {
    final cancellableTasks = queue
        .where((t) => t.status == 'running' || t.status == 'queued')
        .toList();
    for (final task in cancellableTasks) {
      _clearTaskNotification(task);
    }
    queue.removeWhere((t) => t.status == 'running' || t.status == 'queued');

    for (final task in activeTasks) {
      NotificationService.cancel(task.id.hashCode);
    }
    activeTasks.clear();

    _syncActiveMapsWithQueue();
    notifyListeners();
    _saveQueueToPrefs();
    _processQueue();
  }

  void clearCompletedTasks() {
    queue.removeWhere((t) => t.status == 'completed' || t.status == 'failed');
    _syncActiveMapsWithQueue();
    notifyListeners();
    _saveQueueToPrefs();
  }

  Future<int> _resolveConcurrency() async {
    try {
      final cores = kIsWeb ? 1 : Platform.numberOfProcessors;
      if (cores >= 8) return 4;
      if (cores >= 4) return 3;
      return 2;
    } catch (_) {
      return 2;
    }
  }

  Future<void> cancelCourseGeneration(String taskId) async {
    final taskIndex = activeTasks.indexWhere((t) => t.id == taskId);
    String? bookId;
    if (taskIndex != -1) {
      final task = activeTasks[taskIndex];
      bookId = task.skeletonBook?.id;
      activeTasks.removeAt(taskIndex);
    }

    try {
      await NotificationService.cancel(taskId.hashCode);
    } catch (_) {}

    final List<AiTask> toRemove = [];
    for (final t in queue) {
      final match =
          t.id == taskId ||
          t.bookId == taskId ||
          (bookId != null && t.bookId == bookId) ||
          (bookId == null && t.bookId == 'new_book') ||
          t.params['taskId'] == taskId;
      if (match) {
        toRemove.add(t);
      }
    }

    for (final t in toRemove) {
      if (t.status == 'running' || t.status == 'queued') {
        t.status = 'failed';
        t.errorMessage = 'Generation cancelled by user.';
        t.statusMessage = 'Cancelled';
        if (!t.completer.isCompleted) {
          t.completer.completeError(Exception('Cancelled'));
        }
      }
      queue.remove(t);
    }

    _syncActiveMapsWithQueue();
    notifyListeners();
    _saveQueueToPrefs();
    _processQueue();
  }

  Future<void> startBookGenerationFromBookmarks(
    List<File> sourceFiles,
    String filename,
    Book skeletonBook,
  ) async {
    sourceFiles = sourceFiles.toList();
    final taskId = DateTime.now().millisecondsSinceEpoch.toString();

    final task = GenerationTask(
      id: taskId,
      title: filename,
      sourceFiles: sourceFiles,
      startTime: DateTime.now(),
      estimatedDuration: const Duration(seconds: 15),
    );

    task.skeletonBook = skeletonBook;
    task.state = BookGenState.review;
    task.statusMessage = 'Action Required: Review Splits';

    activeTasks.add(task);
    _syncActiveMapsWithQueue();
    notifyListeners();
  }

  /// Runs the deterministic mapping verifier against [book]'s current page
  /// ranges. Used by the "Repair page alignment" tool in course settings.
  Future<MappingReport> checkPageAlignment(
    Book book,
    List<File> sourceFiles, {
    void Function(String status)? onStatus,
  }) {
    final verifier = MappingVerifier(
      pdfService: _pdfService,
      aiService: _aiService,
    );
    return verifier.verify(sourceFiles, book, onStatus: onStatus);
  }

  /// Shifts every mapped page range of [book] by [shift] pages, then
  /// re-splits the source PDFs (preserving generated lessons) and saves.
  Future<void> repairPageAlignment(
    Book book,
    List<File> sourceFiles,
    int shift,
  ) async {
    if (shift == 0) return;
    final shifted = MappingVerifier.applyGlobalShift(
      book,
      shift,
    ).copyWith(mappingVerified: true);
    await restoreBookFiles(shifted, sourceFiles);
  }

  Future<void> autoGenerateModule1Contents(Book book) async {
    if (book.modules.isEmpty || book.modules.first.sections.isEmpty) return;

    final firstSection = book.modules.first.sections.first;

    final task = AiTask(
      id: 'manifest_${DateTime.now().millisecondsSinceEpoch}_${firstSection.id}',
      title: 'Plan Manifest: ${firstSection.title}',
      bookId: book.id,
      moduleId: book.modules.first.id,
      sectionId: firstSection.id,
      type: 'manifest',
      generateGraphics: true,
      isScheduled: false,
      params: {
        'modIdx': 0,
        'secIdx': 0,
        'instructions': null,
        'saveGlobally': false,
      },
    );

    _enqueueTaskObject(task);

    try {
      await task.completer.future;

      final updatedBook = await _dbService.getBookFromCache(book.id);
      if (updatedBook != null &&
          updatedBook.modules.isNotEmpty &&
          updatedBook.modules.first.sections.isNotEmpty) {
        final updatedFirstSec = updatedBook.modules.first.sections.first;
        if (updatedFirstSec.units.isNotEmpty) {
          final firstUnit = updatedFirstSec.units.first;
          await startUnitGeneration(
            firstUnit,
            updatedBook,
            0,
            0,
            0,
            generateGraphics: true,
            isScheduled: false,
          );
        }
      }
    } catch (e) {
      print('Error auto-generating first unit manifest: $e');
    }
  }

  Future<void> _crossCheckUnit(
    Book book,
    int modIdx,
    int secIdx,
    int unitIdx,
    Unit generatedUnit,
    String? apiKey,
  ) async {
    try {
      print(
        '[GenerationManager] Starting AI-CROSS check for unit ${generatedUnit.title} (${generatedUnit.id})',
      );

      final faultyLessonIds = await _aiService.crossCheckUnitLessons(
        unit: generatedUnit,
        bookContext: book,
        forcedApiKey: apiKey,
      );

      if (faultyLessonIds.isEmpty) {
        print('[GenerationManager] AI-CROSS check complete: no faults found.');
        return;
      }

      print(
        '[GenerationManager] AI-CROSS check found faults in lessons: $faultyLessonIds',
      );

      for (final lessonId in faultyLessonIds) {
        final lessonIdx = generatedUnit.lessons.indexWhere(
          (l) => l.id == lessonId,
        );
        if (lessonIdx == -1) continue;

        final faultyLesson = generatedUnit.lessons[lessonIdx];

        print(
          '[GenerationManager] Regenerating faulty lesson: "${faultyLesson.title}" (${faultyLesson.id})',
        );

        try {
          final String? sectionPdfPath =
              book.modules[modIdx].sections[secIdx].pdfPath;
          final List<Unit> sectionUnits =
              book.modules[modIdx].sections[secIdx].units;
          final Unit? previousUnit = unitIdx > 0
              ? sectionUnits[unitIdx - 1]
              : null;
          final Unit? nextUnit = unitIdx < sectionUnits.length - 1
              ? sectionUnits[unitIdx + 1]
              : null;

          final fresh = await _aiService.regenerateLesson(
            lesson: faultyLesson,
            unit: generatedUnit,
            bookContext: book,
            sectionPdfPath: sectionPdfPath,
            previousUnit: previousUnit,
            nextUnit: nextUnit,
            generateGraphics: true,
            forcedApiKey: apiKey,
            customPrompt:
                "The previous version of this lesson had a fault. Please review the questions, slides, and objective choices carefully, and ensure all answers, option correct flags, and explanations are 100% correct.",
          );

          if (fresh != null) {
            final currentBook =
                (await _dbService.getBookFromCache(book.id)) ?? book;

            final mods = List<Module>.from(currentBook.modules);
            final secs = List<Section>.from(mods[modIdx].sections);
            final uns = List<Unit>.from(secs[secIdx].units);

            if (unitIdx < uns.length && uns[unitIdx].id == generatedUnit.id) {
              final lessons = List<Lesson>.from(uns[unitIdx].lessons);
              final lIdx = lessons.indexWhere((l) => l.id == lessonId);
              if (lIdx != -1) {
                lessons[lIdx] = fresh;
                uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
                secs[secIdx] = secs[secIdx].copyWith(units: uns);
                mods[modIdx] = mods[modIdx].copyWith(sections: secs);
                final updatedBook = currentBook.copyWith(modules: mods);

                await ProgressService.clearLessonProgress(lessonId, book.id);
                await _dbService.saveGeneratedBook(updatedBook);
                _bookUpdateController.add(updatedBook);
                print(
                  '[GenerationManager] Successfully replaced faulty lesson $lessonId with corrected version.',
                );
              }
            }
          } else {
            print(
              '[GenerationManager] Lesson regeneration returned null for $lessonId',
            );
          }
        } catch (e) {
          print(
            '[GenerationManager] Background regeneration failed for faulty lesson $lessonId: $e',
          );
        }
      }
    } catch (e) {
      print('[GenerationManager] AI-CROSS check failed: $e');
    }
  }
}