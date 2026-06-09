import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../models/app_models.dart';
import '../models/ai_task.dart';
import 'pdf_service.dart';
import 'database_service.dart';
import 'ai_service.dart';
import 'notification_service.dart';
import 'progress_service.dart';

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

  GenerationTask({
    required this.id, 
    required this.title, 
    required this.sourceFiles,
    this.syllabusFiles = const [],
    this.state = BookGenState.extracting,
    this.statusMessage = 'Extracting Metadata & Planning...', 
    required this.estimatedDuration,
    required this.startTime,
  });
}

class UnitGenTask {
  String status;
  Duration estimatedDuration;
  DateTime startTime;
  bool isError;
  double? progress;

  UnitGenTask({
    required this.status,
    required this.estimatedDuration,
    required this.startTime,
    this.isError = false,
    this.progress,
  });
}

class QpGenTask {
  String status;
  bool isError;
  QpGenTask({required this.status, this.isError = false});
}

class GenerationManager extends ChangeNotifier {
  static final GenerationManager instance = GenerationManager._internal();
  static final Map<String, List<PlatformFile>> _inMemoryPyqFiles = {};
  
  GenerationManager._internal() {
    _loadQueueFromPrefs();
    _startQueueTimer();
  }

  final List<GenerationTask> activeTasks = [];
  final Map<String, UnitGenTask> activeUnitGenerations = {}; 
  final Map<String, QpGenTask> activeQpTasks = {}; 
  final Map<String, QpGenTask> activePyqTasks = {}; 

  // New queue system variables
  final List<AiTask> queue = [];
  Timer? _queueTimer;
  bool _isProcessing = false;
  bool _isPaused = false;
  bool _hasInterruptedTasks = false;

  bool get isPaused => _isPaused;
  bool get hasInterruptedTasks => _hasInterruptedTasks;

  void clearInterruptedTasksFlag() {
    _hasInterruptedTasks = false;
    notifyListeners();
  }

  Future<void> setPaused(bool paused) async {
    if (_isPaused == paused) return;
    _isPaused = paused;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('generation_paused', paused);
    notifyListeners();
    if (!paused) {
      _processQueue();
    }
  }
  
  final PdfService _pdfService = PdfService();
  final DatabaseService _dbService = DatabaseService();
  final AiService _aiService = AiService();

  final StreamController<Book> _bookUpdateController = StreamController<Book>.broadcast();
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
    try {
      final prefs = await SharedPreferences.getInstance();
      _isPaused = prefs.getBool('generation_paused') ?? false;
      final jsonStr = prefs.getString('ai_generation_queue');
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final List decoded = jsonDecode(jsonStr);
        queue.clear();
        queue.addAll(decoded.map((e) => AiTask.fromJson(Map<String, dynamic>.from(e))));
        
        // Convert running to queued if interrupted
        bool hadInterruptedTasks = false;
        for (final t in queue) {
          if (t.status == 'running') {
            t.status = 'queued';
            t.statusMessage = 'Queued (interrupted)';
            hadInterruptedTasks = true;
          }
        }
        
        _hasInterruptedTasks = hadInterruptedTasks;
        if (hadInterruptedTasks) {
          _isPaused = true;
          await prefs.setBool('generation_paused', true);
        }
        
        _syncActiveMapsWithQueue();
        notifyListeners();
        
        if (!_isPaused) {
          _processQueue();
        }
      }
    } catch (e) {
      print('[GenerationManager] Error loading queue: $e');
    }
  }

  void _syncActiveMapsWithQueue() {
    activeUnitGenerations.clear();
    activeSectionManifests.clear();
    activeQpTasks.clear();
    activePyqTasks.clear();
    
    for (final task in queue) {
      if (task.status == 'queued' || task.status == 'running') {
        final isError = task.status == 'failed';
        final statusMsg = task.status == 'running' ? task.statusMessage : 'Queued';
        
        if (task.type == 'unit') {
          if (task.unitId != null) {
            activeUnitGenerations[task.unitId!] = UnitGenTask(
              status: statusMsg,
              estimatedDuration: const Duration(seconds: 90),
              startTime: task.startTime ?? DateTime.now(),
              isError: isError,
              progress: task.progress,
            );
          }
        } else if (task.type == 'manifest') {
          if (task.sectionId != null) {
            activeSectionManifests[task.sectionId!] = UnitGenTask(
              status: statusMsg,
              estimatedDuration: const Duration(seconds: 30),
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
          );
        } else if (task.type == 'pyq') {
          activePyqTasks[task.bookId] = QpGenTask(
            status: statusMsg,
            isError: isError,
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
    
    // Check if generation is paused
    final prefs = await SharedPreferences.getInstance();
    final paused = prefs.getBool('generation_paused') ?? false;
    if (paused) {
      return;
    }
    
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
      List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
      if (keys.isEmpty) {
        final keysString = prefs.getString('gemini_api_keys') ?? '';
        keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      
      // Execute all 'canvas_regen' tasks immediately
      final canvasRegens = queuedTasks.where((t) => t.type == 'canvas_regen').toList();
      if (canvasRegens.isNotEmpty) {
        if (keys.isEmpty) {
          for (final t in canvasRegens) {
            t.status = 'failed';
            t.statusMessage = 'Failed';
            t.errorMessage = 'No API Keys configured. Please add keys in Settings.';
            t.endTime = DateTime.now();
            t.completer.completeError(Exception('No API Keys configured.'));
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
      
      final remainingQueued = queuedTasks.where((t) => t.type != 'canvas_regen').toList();
      if (remainingQueued.isEmpty) {
        _isProcessing = false;
        return;
      }
      
      int availableSlots = limit - runningTasks.where((t) => t.type != 'canvas_regen').length;
      if (availableSlots <= 0) {
        _isProcessing = false;
        return;
      }
      
      // Select next tasks to run
      final nextTasks = _getNextTasksToRun(remainingQueued, isWithinHours, availableSlots);
      
      if (keys.isEmpty) {
        for (final t in nextTasks) {
          t.status = 'failed';
          t.statusMessage = 'Failed';
          t.errorMessage = 'No API Keys configured. Please add keys in Settings.';
          t.endTime = DateTime.now();
          t.completer.completeError(Exception('No API Keys configured.'));
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

  List<AiTask> _getNextTasksToRun(List<AiTask> queuedTasks, bool isWithinHours, int availableSlots) {
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

  String _selectApiKeyForTask(AiTask task, List<String> allKeys, List<AiTask> runningTasks) {
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
        case 'index_scan':
          await _runIndexScanForTask(task, apiKey);
          break;
        case 'unit':
          final bookId = task.bookId;
          final modIdx = task.params['modIdx'] as int;
          final secIdx = task.params['secIdx'] as int;
          final unitIdx = task.params['unitIdx'] as int;
          final book = await _dbService.getBookFromCache(bookId);
          if (book == null) throw Exception("Course not found");
          final unit = book.modules[modIdx].sections[secIdx].units[unitIdx];
          await _runUnitGenerationForTask(task, unit, book, modIdx, secIdx, unitIdx, apiKey);
          break;
        case 'manifest':
          final bookId = task.bookId;
          final modIdx = task.params['modIdx'] as int;
          final secIdx = task.params['secIdx'] as int;
          final instructions = task.params['instructions'] as String?;
          final saveGlobally = task.params['saveGlobally'] as bool? ?? false;
          final book = await _dbService.getBookFromCache(bookId);
          if (book == null) throw Exception("Course not found");
          await _runManifestGenerationForTask(task, book, modIdx, secIdx, instructions, saveGlobally, apiKey);
          break;
        case 'section':
          await _runSectionGenerationForTask(task, task.bookId, task.params['modIdx'] as int, task.params['secIdx'] as int, apiKey);
          break;
        case 'module':
          await _runModuleGenerationForTask(task, task.bookId, task.params['modIdx'] as int, apiKey);
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
          await _runQpGenerationForTask(task, files, title, book, instructions, apiKey);
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
          await _runPyqGenerationForTask(task, files, book, instructions, apiKey, moduleIndex: moduleIndex);
          break;
        case 'lesson_regen':
          final modIdx = task.params['modIdx'] as int;
          final secIdx = task.params['secIdx'] as int;
          final unitIdx = task.params['unitIdx'] as int;
          final lessonIdx = task.params['lessonIdx'] as int;
          final book = await _dbService.getBookFromCache(task.bookId);
          if (book == null) throw Exception("Course not found");
          final lesson = book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
          await _runLessonRegenForTask(task, book, modIdx, secIdx, unitIdx, lessonIdx, lesson, apiKey);
          break;
        case 'slide_regen':
          await _runSlideRegenForTask(task, apiKey);
          break;
        case 'canvas_regen':
          await _runCanvasRegenForTask(task, apiKey);
          break;
        default:
          throw Exception("Unknown task type: ${task.type}");
      }
      
      task.status = 'completed';
      task.progress = 1.0;
      task.statusMessage = 'Completed';
      task.endTime = DateTime.now();
    } catch (e) {
      task.status = 'failed';
      task.statusMessage = 'Failed';
      task.errorMessage = e.toString();
      task.endTime = DateTime.now();
      task.completer.completeError(e);
    } finally {
      if (isCanvasRegen) {
        AiService.activeCanvasRegensCount = (AiService.activeCanvasRegensCount - 1).clamp(0, 9999);
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
  void _enqueueTaskObject(AiTask task) {
    queue.add(task);
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
  }) {
    final taskId = customTaskId ?? '${type}_${DateTime.now().millisecondsSinceEpoch}_${unitId ?? sectionId ?? moduleId ?? bookId}';
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
    _enqueueTaskObject(task);
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
        if (chapterStarts != null) 'chapterStarts': chapterStarts,
        'sourceFilesPaths': sourceFiles.map((f) => f.path).toList(),
      },
    );
    _enqueueTaskObject(task);
    final result = await task.completer.future;
    return result as Book?;
  }

  Future<Map<String, dynamic>?> startIndexScanTask(File chunkPdf, int startPage, int endPage) async {
    final task = AiTask(
      id: 'index_scan_${DateTime.now().millisecondsSinceEpoch}_$startPage',
      title: 'Scan Index pages $startPage-$endPage',
      bookId: 'new_book',
      type: 'index_scan',
      generateGraphics: false,
      isScheduled: false,
      params: {
        'pdfPath': chunkPdf.path,
        'startPage': startPage,
        'endPage': endPage,
      },
    );
    _enqueueTaskObject(task);
    final result = await task.completer.future;
    return result as Map<String, dynamic>?;
  }

  Future<String?> generateCanvasArtTask(String canvasPrompt, {String contextText = '', String? errorContext}) async {
    final task = AiTask(
      id: 'canvas_${DateTime.now().millisecondsSinceEpoch}_${canvasPrompt.hashCode}',
      title: 'Generate Graphic: ${canvasPrompt.length > 20 ? canvasPrompt.substring(0, 20) + "..." : canvasPrompt}',
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
  }) async {
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
      },
    );
    _enqueueTaskObject(task);
    final result = await task.completer.future;
    return result as Slide?;
  }

  // ---------------------------------------------------------------------------
  // Runners for queued tasks
  // ---------------------------------------------------------------------------
  Future<void> _runBookSkeletonForTask(AiTask task, String apiKey) async {
    final indexFilesPaths = List<String>.from(task.params['indexFilesPaths']);
    final syllabusFilesPaths = List<String>.from(task.params['syllabusFilesPaths'] ?? []);
    final sourceFilesPaths = List<String>.from(task.params['sourceFilesPaths'] ?? []);
    final filename = task.params['filename'] as String;
    final chapter1AbsolutePages = List<int>.from(task.params['chapter1AbsolutePages'] ?? []);
    final customInstructions = task.params['customInstructions'] as String?;
    final isHandout = task.params['isHandout'] as bool? ?? false;
    
    final chapterStartsRaw = task.params['chapterStarts'] as List?;
    final List<List<int>>? chapterStarts = chapterStartsRaw != null
        ? chapterStartsRaw.map((list) => List<int>.from(list as List)).toList()
        : null;

    final indexFiles = indexFilesPaths.map((p) => File(p)).toList();
    final syllabusFiles = syllabusFilesPaths.map((p) => File(p)).toList();
    final sourceFiles = sourceFilesPaths.map((p) => File(p)).toList();
    
    final result = await _aiService.generateBookSkeleton(
      indexFiles,
      filename,
      chapter1AbsolutePages: chapter1AbsolutePages,
      customInstructions: customInstructions,
      syllabusFiles: syllabusFiles,
      isHandout: isHandout,
      chapterStarts: chapterStarts,
      sourceFiles: sourceFiles,
      onProgress: (status, progress) {
        task.statusMessage = status;
        task.progress = progress;
        notifyListeners();
      },
      forcedApiKey: apiKey,
    );
    task.completer.complete(result);
  }

  Future<void> _runIndexScanForTask(AiTask task, String apiKey) async {
    final pdfPath = task.params['pdfPath'] as String;
    final startPage = task.params['startPage'] as int;
    final endPage = task.params['endPage'] as int;
    
    final result = await _aiService.scanIndexChunk(File(pdfPath), startPage, endPage, forcedApiKey: apiKey);
    task.completer.complete(result);
  }

  Future<void> _runCanvasRegenForTask(AiTask task, String apiKey) async {
    final canvasPrompt = task.params['canvasPrompt'] as String;
    final contextText = task.params['contextText'] as String? ?? '';
    final errorContext = task.params['errorContext'] as String?;
    
    final result = await _aiService.generateCanvasArt(canvasPrompt, contextText: contextText, errorContext: errorContext, forcedApiKey: apiKey, isHighPriority: true);
    task.completer.complete(result);
  }

  Future<void> _runSlideRegenForTask(AiTask task, String apiKey) async {
    final slideJson = task.params['slide'] as Map<String, dynamic>;
    final lessonJson = task.params['lesson'] as Map<String, dynamic>;
    final bookContextJson = task.params['bookContext'] as Map<String, dynamic>;
    final chunkPath = task.params['chunkPath'] as String?;
    final note = task.params['note'] as String?;
    
    final result = await _aiService.regenerateSlide(
      slide: Slide.fromJson(slideJson),
      lesson: Lesson.fromJson(lessonJson),
      bookContext: Book.fromJson(bookContextJson),
      chunkPath: chunkPath,
      note: note,
      forcedApiKey: apiKey,
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
    
    await NotificationService.showProgress(notifId, "Generating Lesson", "AI is crafting content...", indeterminate: true);
    
    Book applyUnit(Book base, Unit u) {
      final List<Unit> uns = List.from(base.modules[modIdx].sections[secIdx].units);
      uns[unitIdx] = u;
      final List<Section> secs = List.from(base.modules[modIdx].sections);
      secs[secIdx] = secs[secIdx].copyWith(units: uns);
      final List<Module> mods = List.from(base.modules);
      mods[modIdx] = mods[modIdx].copyWith(sections: secs);
      return base.copyWith(modules: mods);
    }
    
    try {
      final stopwatch = Stopwatch()..start();
      final String? sectionPdfPath = book.modules[modIdx].sections[secIdx].pdfPath;
      
      final Book ctxBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final List<Unit> sectionUnits = ctxBook.modules[modIdx].sections[secIdx].units;
      final Unit? previousUnit = unitIdx > 0 ? sectionUnits[unitIdx - 1] : null;
      final Unit? nextUnit = unitIdx < sectionUnits.length - 1 ? sectionUnits[unitIdx + 1] : null;
      
      final List<Unit> previousGeneratedUnits = [];
      for (int i = unitIdx - 1; i >= 0 && previousGeneratedUnits.length < 2; i--) {
        final u = sectionUnits[i];
        if (u.isGenerated && u.lessons.isNotEmpty) previousGeneratedUnits.insert(0, u);
      }
      
      Future<void> saveChain = Future.value();
      void onLessonGenerated(List<Lesson> lessonsSoFar) {
        final snapshot = List<Lesson>.from(lessonsSoFar);
        if (snapshot.isEmpty) return;
        saveChain = saveChain.then((_) async {
          final base = (await _dbService.getBookFromCache(book.id)) ?? book;
          final partial = applyUnit(base, unit.copyWith(isGenerated: false, lessons: snapshot));
          await _dbService.saveGeneratedBook(partial);
          _bookUpdateController.add(partial);
        }).catchError((e) {
          print('[GenerationManager] Streaming save failed for ${unit.id}: $e');
        });
      }
      
      final updatedUnit = await _aiService.generateUnitContent(
        unit,
        ctxBook,
        (status, [progress]) {
          task.statusMessage = status;
          task.progress = progress;
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
      await NotificationService.showActionable(notifId, "Lesson Ready!", "Tap to start learning.", "open_home|");
      task.completer.complete(updatedUnit);
    } catch (e) {
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Generation Failed", "Failed to generate lesson.", "error");
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
    String apiKey,
  ) async {
    final section = book.modules[modIdx].sections[secIdx];
    final String? effectiveInstructions =
        (instructions?.trim().isNotEmpty ?? false)
            ? instructions!.trim()
            : (section.customInstructions ?? book.customInstructions);

    final notifId = section.id.hashCode;
    await NotificationService.showProgress(notifId, 'Planning section', 'Generating unit list...', indeterminate: true);

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
      sections[secIdx] = sections[secIdx].copyWith(
        units: units,
        unitsGenerated: true,
        customInstructions: effectiveInstructions,
      );
      modules[modIdx] = modules[modIdx].copyWith(sections: sections);

      final List<LessonFormat> updatedFormats = List.from(baseBook.lessonFormats);
      for (final nf in newFormats) {
        final alreadyExists = updatedFormats.any((lf) =>
            lf.id == nf.id || lf.name.toLowerCase() == nf.name.toLowerCase());
        if (!alreadyExists) {
          updatedFormats.add(nf);
        }
      }

      final newBook = baseBook.copyWith(
        modules: modules,
        lessonFormats: updatedFormats,
        customInstructions: saveGlobally ? effectiveInstructions : baseBook.customInstructions,
      );

      await _dbService.saveGeneratedBook(newBook);
      _bookUpdateController.add(newBook);
      await NotificationService.cancel(notifId);
      task.completer.complete(manifestResult);
    } catch (e) {
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, 'Section Planning Failed', 'Could not generate units.', 'error');
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
      notifyListeners();
      
      await _runManifestGenerationForTask(task, book, modIdx, secIdx, null, false, apiKey);
      
      book = await _dbService.getBookFromCache(bookId);
      if (book == null) throw Exception("Course not found after planning");
      section = book.modules[modIdx].sections[secIdx];
      
      if (!section.unitFormatsConfirmed && section.units.isNotEmpty) {
        final modules = List<Module>.from(book.modules);
        final secs = List<Section>.from(modules[modIdx].sections);
        secs[secIdx] = secs[secIdx].copyWith(
          unitFormatsConfirmed: true,
        );
        modules[modIdx] = modules[modIdx].copyWith(sections: secs);
        book = book.copyWith(modules: modules);
        await _dbService.saveGeneratedBook(book);
        _bookUpdateController.add(book);
      }
    }
    
    final unitsToGen = section.units.asMap().entries.where((entry) => !entry.value.isGenerated).toList();
    if (unitsToGen.isEmpty) {
      task.statusMessage = 'All units already generated';
      task.progress = 1.0;
      notifyListeners();
      return;
    }
    
    for (int i = 0; i < unitsToGen.length; i++) {
      final entry = unitsToGen[i];
      final unitIdx = entry.key;
      final unit = entry.value;
      
      await startUnitGeneration(
        unit,
        book!,
        modIdx,
        secIdx,
        unitIdx,
        generateGraphics: task.generateGraphics,
        isScheduled: task.isScheduled,
      );
    }
    task.statusMessage = 'Enqueued ${unitsToGen.length} units';
    task.progress = 1.0;
    notifyListeners();
  }

  Future<void> _runModuleGenerationForTask(AiTask task, String bookId, int modIdx, String apiKey) async {
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
    notifyListeners();
  }

  Future<void> _runBookContentGenerationForTask(AiTask task, String bookId, String apiKey) async {
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
    await NotificationService.showProgress(notifId, "Analyzing Exam", "Extracting and solving questions natively...", indeterminate: true);
    
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
      await NotificationService.showActionable(notifId, "Exam Ready", "Past paper solved interactively!", "open_home|");
      task.completer.complete(qp);
    } catch (e) {
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Analysis Failed", "Failed to solve past paper.", "error");
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
    await NotificationService.showProgress(notifId, "Analyzing PYQ", "Extracting and splitting questions...", indeterminate: true);

    try {
      Book freshestBook = (await _dbService.getBookFromCache(book.id)) ?? book;

      // Scope extraction to a single module when one is given (the module the
      // user has open on the Path tab). Questions stay within that module — the
      // cross-section spread below is also limited to its sections.
      final List<Module> scopedModules =
          (moduleIndex != null && moduleIndex >= 0 && moduleIndex < freshestBook.modules.length)
              ? [freshestBook.modules[moduleIndex]]
              : freshestBook.modules;

      List<Section> activeSections = [];
      for (final m in scopedModules) {
        for (final s in m.sections) {
          final hasLessons = s.units.any((u) => u.isGenerated && u.lessons.isNotEmpty);
          if (hasLessons) {
            activeSections.add(s);
          }
        }
      }
      if (activeSections.isEmpty) {
        throw Exception("This module has no sections with generated lessons yet. Please generate lessons first.");
      }

      final Map<String, List<Slide>> newSlidesForSections = {};
      for (final s in activeSections) {
        newSlidesForSections[s.id] = [];
      }

      // Only offer the in-scope sections as cross-assignment targets so a
      // question never leaks into another module.
      final List<Map<String, String>> otherSectionsMeta = scopedModules
          .expand((m) => m.sections)
          .map((s) => {'id': s.id, 'title': s.title})
          .toList();
          
      for (int i = 0; i < activeSections.length; i++) {
        final sec = activeSections[i];
        task.statusMessage = 'Extracting questions for: ${sec.title} (${i+1}/${activeSections.length})...';
        task.progress = i / activeSections.length;
        notifyListeners();
        
        final existingInSec = List<Slide>.from(sec.pyqQuestions);
        final newlyExtractedInSec = newSlidesForSections[sec.id] ?? [];
        final totalExisting = [...existingInSec, ...newlyExtractedInSec];
        
        final extracted = await _aiService.extractPyqQuestionsForSection(
          files: files,
          section: sec,
          existingQuestions: totalExisting,
          otherSections: otherSectionsMeta.where((s) => s['id'] != sec.id).toList(),
          customInstructions: customInstructions,
          forcedApiKey: apiKey,
        );
        
        for (final q in extracted) {
          if (!isDuplicate(q, totalExisting)) {
            newSlidesForSections[sec.id]!.add(q);
          }
          final otherIds = q.toJson()['otherSupportedSectionIds'] as List?;
          if (otherIds != null) {
            for (final otherIdRaw in otherIds) {
              final otherId = otherIdRaw.toString();
              final hasSection = freshestBook.modules.expand((m) => m.sections).any((s) => s.id == otherId);
              if (hasSection) {
                final otherSec = freshestBook.modules.expand((m) => m.sections).firstWhere((s) => s.id == otherId);
                final otherHasLessons = otherSec.units.any((u) => u.isGenerated && u.lessons.isNotEmpty);
                if (otherHasLessons) {
                  newSlidesForSections.putIfAbsent(otherId, () => []);
                  final existingInOther = List<Slide>.from(otherSec.pyqQuestions);
                  final newlyExtractedInOther = newSlidesForSections[otherId]!;
                  final totalExistingOther = [...existingInOther, ...newlyExtractedInOther];
                  if (!isDuplicate(q, totalExistingOther)) {
                    newSlidesForSections[otherId]!.add(q);
                  }
                }
              }
            }
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
      task.completer.complete(null);
    } catch (e) {
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "PYQ Analysis Failed", "Failed to extract exam questions.", "error");
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
    await NotificationService.showProgress(notifId, 'Regenerating lesson', lesson.title, indeterminate: true);
    
    try {
      final ctxBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final sectionUnits = ctxBook.modules[modIdx].sections[secIdx].units;
      final unit = sectionUnits[unitIdx];
      final Unit? previousUnit = unitIdx > 0 ? sectionUnits[unitIdx - 1] : null;
      final Unit? nextUnit = unitIdx < sectionUnits.length - 1 ? sectionUnits[unitIdx + 1] : null;
      final String? sectionPdfPath = ctxBook.modules[modIdx].sections[secIdx].pdfPath;
      
      final fresh = await _aiService.regenerateLesson(
        lesson: lesson,
        unit: unit,
        bookContext: ctxBook,
        sectionPdfPath: sectionPdfPath,
        previousUnit: previousUnit,
        nextUnit: nextUnit,
        generateGraphics: task.generateGraphics,
        forcedApiKey: apiKey,
      );
      if (fresh == null) {
        throw Exception('Lesson regeneration failed. The previous lesson is kept.');
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
      
      await ProgressService.clearLessonProgress(lesson.id);
      await _dbService.saveGeneratedBook(newBook);
      _bookUpdateController.add(newBook);
      await NotificationService.cancel(notifId);
      task.completer.complete(fresh);
    } catch (e) {
      await NotificationService.cancel(notifId);
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // Interface Methods called by Screens / Callers
  // ---------------------------------------------------------------------------
  Future<void> startBookGeneration(
    List<File> sourceFiles,
    String filename, {
    required List<File> indexFiles,
    required List<int> chapter1AbsolutePages,
    String? customInstructions,
    List<File> syllabusFiles = const [],
    bool isHandout = false,
    List<List<int>>? chapterStarts,
  }) async {
    sourceFiles = sourceFiles.toList();
    final taskId = DateTime.now().millisecondsSinceEpoch.toString();
    final notifId = taskId.hashCode;

    double totalSize = 0;
    for (var f in sourceFiles) { totalSize += await f.length(); }

    final uploadSecs = (totalSize / 500000).ceil();
    final avgAiMs = await _getAverageRunTime('meta_gen_history', 120000);
    final estimatedDuration = Duration(seconds: uploadSecs, milliseconds: avgAiMs);

    final task = GenerationTask(
      id: taskId,
      title: filename,
      sourceFiles: sourceFiles,
      syllabusFiles: syllabusFiles,
      startTime: DateTime.now(),
      estimatedDuration: estimatedDuration,
    );

    activeTasks.add(task);
    notifyListeners();

    await NotificationService.showProgress(notifId, "Analyzing Source", "Extracting metadata...", indeterminate: true);

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
      );
      
      stopwatch.stop();
      await _recordRunTime('meta_gen_history', stopwatch.elapsedMilliseconds);

      if (skeletonBook != null) {
        if (isHandout) {
          await startBackgroundSplitAndSave(taskId, sourceFiles, skeletonBook);
        } else {
          task.skeletonBook = skeletonBook;
          task.state = BookGenState.review;
          task.statusMessage = 'Action Required: Review Splits';
          notifyListeners();

          await NotificationService.cancel(notifId);
          await NotificationService.showActionable(notifId, "Course Skeleton Ready", "Tap to review page splits.", "review_split|$taskId");
        }
      }
    } catch (e) {
      task.state = BookGenState.error;
      task.errorMessage = e.toString();
      task.statusMessage = 'Failed to generate structure';
      notifyListeners();
      
      final shortError = e.toString().length > 200 ? "${e.toString().substring(0, 200)}..." : e.toString();
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Generation Failed", shortError, "error");
    }
  }

  Future<void> startBackgroundSplitAndSave(String taskId, List<File> sourceFiles, Book offsetBook) async {
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
    await NotificationService.showProgress(notifId, "Chunking Pages", "Processing natively...", indeterminate: true);

    try {
      final completeBook = await _pdfService.splitBookPdf(sourceFiles, offsetBook, (status, progress) {
        task.statusMessage = status;
        task.progress = progress;
        notifyListeners();
        NotificationService.showProgress(notifId, "Chunking Document", status, indeterminate: true);
      });

      task.state = BookGenState.saving;
      task.statusMessage = 'Saving to Database...';
      notifyListeners();
      
      Book finalBook = completeBook;
      if (task.syllabusFiles.isNotEmpty) {
        try {
          final dir = await getApplicationDocumentsDirectory();
          final bookDirPath = '${dir.path}/books/${completeBook.id}';
          final bookDir = Directory(bookDirPath);
          if (!await bookDir.exists()) {
            await bookDir.create(recursive: true);
          }
          File finalSyllabusFile;
          if (task.syllabusFiles.length == 1) {
            finalSyllabusFile = task.syllabusFiles.first;
          } else {
            finalSyllabusFile = await _pdfService.mergeFiles(task.syllabusFiles);
          }
          if (await finalSyllabusFile.exists()) {
            final ext = finalSyllabusFile.path.split('.').last;
            final targetPath = '$bookDirPath/syllabus.$ext';
            await finalSyllabusFile.copy(targetPath);
            finalBook = completeBook.copyWith(syllabusPath: targetPath);
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

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Course Created!", "Your book is ready.", "open_home|");
    } catch (e) {
      task.state = BookGenState.error;
      task.statusMessage = 'Error chunking file';
      task.errorMessage = e.toString();
      notifyListeners();
      
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Error", "Failed to split file.", "error");
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

    await NotificationService.showProgress(notifId, "Restoring Files", "Re-splitting source natively...", indeterminate: true);

    try {
      List<File> finalSourceFiles = sourceFiles;
      final bool isMultiBookCourse = book.modules.any((m) => m.sections.any((s) => (s.bookIndex ?? 0) > 0));
      if (!isMultiBookCourse) {
        if (sourceFiles.length > 1 || (sourceFiles.isNotEmpty && !sourceFiles.first.path.toLowerCase().endsWith('.pdf'))) {
          finalSourceFiles = [await _pdfService.mergeFiles(sourceFiles)];
        }
      }

      final completeBook = await _pdfService.splitBookPdf(finalSourceFiles, book, (status, progress) {
        task.statusMessage = status;
        task.progress = progress;
        notifyListeners();
        NotificationService.showProgress(notifId, "Restoring Document", status, indeterminate: true);
      }, preserveLessons: true);

      task.state = BookGenState.saving;
      task.statusMessage = 'Saving to Database...';
      notifyListeners();

      await _dbService.saveGeneratedBook(completeBook);

      activeTasks.remove(task);
      notifyListeners();

      _bookUpdateController.add(completeBook);

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Files Restored!", "Your course is ready for generation.", "open_home|");
    } catch (e) {
      task.state = BookGenState.error;
      task.statusMessage = 'Error restoring files';
      task.errorMessage = e.toString();
      notifyListeners();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Error", "Failed to restore files.", "error");
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
    if (queue.any((t) => t.unitId == unit.id && (t.status == 'queued' || t.status == 'running'))) {
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
      params: {
        'modIdx': modIdx,
        'secIdx': secIdx,
        'unitIdx': unitIdx,
      },
    );
  }

  final Map<String, UnitGenTask> activeSectionManifests = {};
  final Map<String, UnitGenTask> activeSectionGenerations = {};
  final Set<String> activeCanvasRegens = {};
  final Set<String> activeSlideRegens = {};
  final Set<String> activeLessonRegens = {};

  Future<void> startSectionUnitManifest(
    Book book,
    int modIdx,
    int secIdx, {
    String? instructions,
    bool saveGlobally = false,
    bool isScheduled = false,
  }) async {
    final section = book.modules[modIdx].sections[secIdx];
    if (queue.any((t) => t.sectionId == section.id && t.type == 'manifest' && (t.status == 'queued' || t.status == 'running'))) {
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
    if (queue.any((t) => t.sectionId == section.id && t.type == 'section' && (t.status == 'queued' || t.status == 'running'))) {
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
      params: {
        'modIdx': modIdx,
        'secIdx': secIdx,
      },
    );
  }

  Future<void> startModuleGeneration(
    Book book,
    int modIdx, {
    bool generateGraphics = true,
    bool isScheduled = false,
  }) async {
    final module = book.modules[modIdx];
    if (queue.any((t) => t.moduleId == module.id && t.type == 'module' && (t.status == 'queued' || t.status == 'running'))) {
      return;
    }
    
    _enqueue(
      title: 'Module Contents: ${module.title}',
      type: 'module',
      bookId: book.id,
      moduleId: module.id,
      generateGraphics: generateGraphics,
      isScheduled: isScheduled,
      params: {
        'modIdx': modIdx,
      },
    );
  }

  Future<void> startBookContentGeneration(
    Book book, {
    bool generateGraphics = true,
    bool isScheduled = false,
  }) async {
    if (queue.any((t) => t.bookId == book.id && t.type == 'book_content' && (t.status == 'queued' || t.status == 'running'))) {
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
    final lesson = book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
    if ((lesson.canvasPrompt?.trim().isEmpty ?? true) || activeCanvasRegens.contains(lesson.id)) return;
    activeCanvasRegens.add(lesson.id);
    notifyListeners();
    try {
      final svg = await generateCanvasArtTask(
        lesson.canvasPrompt!,
        contextText: lesson.slides.isNotEmpty ? lesson.slides.first.content : '',
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
    final slide = book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx].slides[slideIdx];
    if ((slide.canvasPrompt?.trim().isEmpty ?? true) || activeCanvasRegens.contains(slide.id)) return;
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
  }) async {
    final lesson = book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
    if (queue.any((t) => t.params['lessonId'] == lesson.id && (t.status == 'queued' || t.status == 'running'))) {
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
  }) async {
    final lesson = book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
    final slide = lesson.slides[slideIdx];
    if (activeSlideRegens.contains(slide.id)) return;
    activeSlideRegens.add(slide.id);
    notifyListeners();
    try {
      final String? chunkPath = book.modules[modIdx].sections[secIdx].units[unitIdx].pdfPath ??
          book.modules[modIdx].sections[secIdx].pdfPath;
      final fresh = await regenerateSlideTask(
        slide: slide,
        lesson: lesson,
        bookContext: book,
        chunkPath: chunkPath,
        note: note,
      );
      if (fresh == null) return;
      final base = (await _dbService.getBookFromCache(book.id)) ?? book;
      final mods = List<Module>.from(base.modules);
      final secs = List<Section>.from(mods[modIdx].sections);
      final uns = List<Unit>.from(secs[secIdx].units);
      final lessons = List<Lesson>.from(uns[unitIdx].lessons);
      final slides = List<Slide>.from(lessons[lessonIdx].slides);
      slides[slideIdx] = fresh;
      lessons[lessonIdx] = lessons[lessonIdx].copyWith(slides: slides);
      uns[unitIdx] = uns[unitIdx].copyWith(lessons: lessons);
      secs[secIdx] = secs[secIdx].copyWith(units: uns);
      mods[modIdx] = mods[modIdx].copyWith(sections: secs);
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
    if (queue.any((t) => t.bookId == bookId && t.type == 'qp' && (t.status == 'queued' || t.status == 'running'))) {
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
    if (queue.any((t) => t.bookId == bookId && t.type == 'pyq' && (t.status == 'queued' || t.status == 'running'))) {
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
        if (moduleIndex != null) 'moduleIndex': moduleIndex,
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
      } else if (task.type == 'lesson_regen' && task.params['lessonId'] != null) {
        NotificationService.cancel(('regen_${task.params['lessonId']}').hashCode);
      } else if (task.type == 'book_skeleton') {
        final timestampStr = task.id.replaceAll('skeleton_', '');
        final notifId = int.tryParse(timestampStr)?.hashCode ?? task.id.hashCode;
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
    final cancellableTasks = queue.where((t) => t.status == 'running' || t.status == 'queued').toList();
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
      final match = t.id == taskId || 
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
}