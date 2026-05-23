import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import 'pdf_service.dart';
import 'database_service.dart';
import 'ai_service.dart';
import 'notification_service.dart';

enum BookGenState { extracting, review, chunking, saving, error }

class GenerationTask {
  final String id;
  final String title;
  final List<File> sourceFiles;
  BookGenState state;
  String statusMessage;
  Book? skeletonBook;
  String? errorMessage;
  Duration estimatedDuration;
  DateTime startTime;

  GenerationTask({
    required this.id, 
    required this.title, 
    required this.sourceFiles,
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

  UnitGenTask({
    required this.status, 
    required this.estimatedDuration, 
    required this.startTime, 
    this.isError = false
  });
}

class QpGenTask {
  String status;
  bool isError;
  QpGenTask({required this.status, this.isError = false});
}

class GenerationManager extends ChangeNotifier {
  static final GenerationManager instance = GenerationManager._internal();
  GenerationManager._internal();

  final List<GenerationTask> activeTasks = [];
  final Map<String, UnitGenTask> activeUnitGenerations = {}; 
  final Map<String, QpGenTask> activeQpTasks = {}; 
  
  final PdfService _pdfService = PdfService();
  final DatabaseService _dbService = DatabaseService();
  final AiService _aiService = AiService();

  final StreamController<Book> _bookUpdateController = StreamController<Book>.broadcast();
  Stream<Book> get bookUpdates => _bookUpdateController.stream;

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

  /// Starts the new TOC-only book generation flow.
  ///
  /// [sourceFiles] is the full original PDF/images (kept for the later
  /// chunking step). [indexFiles] is the trimmed index/TOC PDF the AI sees
  /// during skeleton generation. [chapter1AbsolutePage] is the absolute PDF
  /// page number where Chapter 1 starts in [sourceFiles], used for offset
  /// correction in the prompt.
  Future<void> startBookGeneration(
    List<File> sourceFiles,
    String filename, {
    required List<File> indexFiles,
    required int chapter1AbsolutePage,
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
      startTime: DateTime.now(),
      estimatedDuration: estimatedDuration,
    );

    activeTasks.add(task);
    notifyListeners();

    await NotificationService.showProgress(notifId, "Analyzing Source", "Extracting metadata...", indeterminate: true);

    try {
      final stopwatch = Stopwatch()..start();
      final skeletonBook = await _aiService.generateBookSkeleton(
        indexFiles,
        filename,
        chapter1AbsolutePage: chapter1AbsolutePage,
      );
      stopwatch.stop();

      await _recordRunTime('meta_gen_history', stopwatch.elapsedMilliseconds);

      if (skeletonBook != null) {
        task.skeletonBook = skeletonBook;
        task.state = BookGenState.review;
        task.statusMessage = 'Action Required: Review Splits';
        notifyListeners();
        
        await NotificationService.cancel(notifId);
        await NotificationService.showActionable(notifId, "Course Skeleton Ready", "Tap to review page splits.", "review_split|$taskId");
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
    task.estimatedDuration = const Duration(seconds: 15); // Native is much faster
    task.startTime = DateTime.now();
    notifyListeners();

    final notifId = taskId.hashCode;
    await NotificationService.showProgress(notifId, "Chunking Pages", "Processing natively...", indeterminate: true);

    try {
      final completeBook = await _pdfService.splitBookPdf(sourceFiles, offsetBook, (status) {
        task.statusMessage = status;
        notifyListeners();
        NotificationService.showProgress(notifId, "Chunking Document", status, indeterminate: true);
      });

      task.state = BookGenState.saving;
      task.statusMessage = 'Saving to Database...';
      notifyListeners();
      
      await _dbService.saveGeneratedBook(completeBook);
      
      activeTasks.remove(task);
      notifyListeners();
      
      _bookUpdateController.add(completeBook);
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
    if (activeTasks.any((t) => t.id == taskId)) return; // Prevent duplicate

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
      final completeBook = await _pdfService.splitBookPdf(sourceFiles, book, (status) {
        task.statusMessage = status;
        notifyListeners();
        NotificationService.showProgress(notifId, "Restoring Document", status, indeterminate: true);
      });

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

  Future<void> startUnitGeneration(Unit unit, Book book, int modIdx, int secIdx, int unitIdx) async {
    if (activeUnitGenerations.containsKey(unit.id)) return;

    final avgUnitMs = await _getAverageRunTime('unit_gen_history', 90000);
    final notifId = unit.id.hashCode;

    activeUnitGenerations[unit.id] = UnitGenTask(
      status: 'Initializing AI...',
      estimatedDuration: Duration(milliseconds: avgUnitMs),
      startTime: DateTime.now()
    );
    notifyListeners();

    await NotificationService.showProgress(notifId, "Generating Lesson", "AI is crafting content...", indeterminate: true);

    try {
      final stopwatch = Stopwatch()..start();
      // New-flow units share the section\'s PDF chunk. Pass it through so the
      // AI call can still hit a real on-disk file.
      final String? sectionPdfPath = book.modules[modIdx].sections[secIdx].pdfPath;
      final updatedUnit = await _aiService.generateUnitContent(
        unit,
        book,
        (status) {
          activeUnitGenerations[unit.id]?.status = status;
          notifyListeners();
        },
        sectionPdfPath: sectionPdfPath,
      );
      stopwatch.stop();
      await _recordRunTime('unit_gen_history', stopwatch.elapsedMilliseconds);

      // Persist the text-only unit first so the lesson is usable immediately
      // while the graphics pass runs in the background. Same merge pattern
      // is reused later for the SVG-enriched unit.
      Book applyUnit(Book base, Unit u) {
        final List<Unit> uns = List.from(base.modules[modIdx].sections[secIdx].units);
        uns[unitIdx] = u;
        final List<Section> secs = List.from(base.modules[modIdx].sections);
        secs[secIdx] = secs[secIdx].copyWith(units: uns);
        final List<Module> mods = List.from(base.modules);
        mods[modIdx] = mods[modIdx].copyWith(sections: secs);
        return base.copyWith(modules: mods);
      }

      Book baseBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final textOnlyBook = applyUnit(baseBook, updatedUnit);
      await _dbService.saveGeneratedBook(textOnlyBook);
      _bookUpdateController.add(textOnlyBook);

      // Stage 2: graphics pass. Failures here don\'t fail the whole lesson —
      // the user just sees the text-only version. Runs after the text save
      // so the lesson is immediately usable.
      try {
        activeUnitGenerations[unit.id]?.status = 'Rendering diagrams...';
        notifyListeners();
        await NotificationService.showProgress(notifId, "Generating Diagrams", "Drawing lesson art...", indeterminate: true);

        final unitWithArt = await _aiService.generateCanvasArtForUnit(
          updatedUnit,
          onProgress: (s) {
            activeUnitGenerations[unit.id]?.status = s;
            notifyListeners();
          },
        );

        final freshBase = (await _dbService.getBookFromCache(book.id)) ?? textOnlyBook;
        final artBook = applyUnit(freshBase, unitWithArt);
        await _dbService.saveGeneratedBook(artBook);
        _bookUpdateController.add(artBook);
      } catch (e) {
        // Best-effort: log and continue. Lesson is still usable without SVG.
        print('[GenerationManager] Canvas pass failed for ${unit.id}: $e');
      }

      activeUnitGenerations.remove(unit.id);
      notifyListeners();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Lesson Ready!", "Tap to start learning.", "open_home|");
    } catch (e) {
      activeUnitGenerations[unit.id]?.isError = true;
      activeUnitGenerations[unit.id]?.status = 'Error: $e';
      notifyListeners();

      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, "Generation Failed", "Failed to generate lesson.", "error");
    }
  }

  /// Tracks in-flight unit-manifest generations. Keyed by section id so the
  /// UI can show a loading state on the right section card.
  final Map<String, UnitGenTask> activeSectionManifests = {};

  /// Set of "art target" ids currently regenerating their canvas SVG. The
  /// id is the lesson id (for the lesson-top diagram) or the slide id (for
  /// the proof diagram). The UI checks this set to disable the regenerate
  /// button while a call is in flight.
  final Set<String> activeCanvasRegens = {};

  /// Lazily generates the unit list for a section in a new-flow book.
  /// Idempotent: if the section already has units or a manifest is already
  /// in flight, this is a no-op. Persists the populated section back to the
  /// DB and emits a book update on success.
  Future<void> startSectionUnitManifest(Book book, int modIdx, int secIdx) async {
    final section = book.modules[modIdx].sections[secIdx];
    if (!section.needsUnitManifest) return;
    if (activeSectionManifests.containsKey(section.id)) return;

    final notifId = section.id.hashCode;
    activeSectionManifests[section.id] = UnitGenTask(
      status: 'Planning units for "${section.title}"...',
      estimatedDuration: const Duration(seconds: 30),
      startTime: DateTime.now(),
    );
    notifyListeners();
    await NotificationService.showProgress(notifId, 'Planning section', 'Generating unit list...', indeterminate: true);

    try {
      final units = await _aiService.generateUnitManifest(section, book);

      // Re-read freshest book so concurrent edits don\'t clobber.
      final baseBook = (await _dbService.getBookFromCache(book.id)) ?? book;
      final modules = List<Module>.from(baseBook.modules);
      final sections = List<Section>.from(modules[modIdx].sections);
      sections[secIdx] = sections[secIdx].copyWith(units: units, unitsGenerated: true);
      modules[modIdx] = modules[modIdx].copyWith(sections: sections);
      final newBook = baseBook.copyWith(modules: modules);

      await _dbService.saveGeneratedBook(newBook);
      activeSectionManifests.remove(section.id);
      notifyListeners();
      _bookUpdateController.add(newBook);

      await NotificationService.cancel(notifId);
    } catch (e) {
      activeSectionManifests[section.id]?.isError = true;
      activeSectionManifests[section.id]?.status = 'Error: ${e.toString()}';
      notifyListeners();
      await NotificationService.cancel(notifId);
      await NotificationService.showActionable(notifId, 'Section Planning Failed', 'Could not generate units.', 'error');
    }
  }

  /// Regenerates the diagram for a single lesson (top-of-lesson art).
  /// No-op if the lesson has no `canvasPrompt` set. Persists the new SVG
  /// to the book and broadcasts the update.
  Future<void> regenerateLessonCanvas({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
  }) async {
    final lesson = book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx];
    if ((lesson.canvasPrompt?.trim().isEmpty ?? true) || activeCanvasRegens.contains(lesson.id)) return;
    activeCanvasRegens.add(lesson.id);
    notifyListeners();
    try {
      final svg = await _aiService.generateCanvasArt(
        lesson.canvasPrompt!,
        contextText: lesson.slides.isNotEmpty ? lesson.slides.first.content : '',
      );
      if (svg == null) return; // best-effort: keep old SVG if call failed
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

  /// Regenerates the diagram for a single proof / step_by_step slide. Same
  /// best-effort semantics as [regenerateLessonCanvas].
  Future<void> regenerateSlideCanvas({
    required Book book,
    required int modIdx,
    required int secIdx,
    required int unitIdx,
    required int lessonIdx,
    required int slideIdx,
  }) async {
    final slide = book.modules[modIdx].sections[secIdx].units[unitIdx].lessons[lessonIdx].slides[slideIdx];
    if ((slide.canvasPrompt?.trim().isEmpty ?? true) || activeCanvasRegens.contains(slide.id)) return;
    activeCanvasRegens.add(slide.id);
    notifyListeners();
    try {
      final svg = await _aiService.generateCanvasArt(slide.canvasPrompt!, contextText: slide.content);
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

  void clearSectionManifestError(String sectionId) {
    if (activeSectionManifests[sectionId]?.isError == true) {
      activeSectionManifests.remove(sectionId);
      notifyListeners();
    }
  }

  Future<void> startQpGeneration(String bookId, List<File> files, String qpTitle, Book currentBook) async {
    if (activeQpTasks.containsKey(bookId)) return;

    final notifId = bookId.hashCode + 1; // Unique ID avoiding collision
    activeQpTasks[bookId] = QpGenTask(status: 'Analyzing Exam Paper...');
    notifyListeners();
    
    await NotificationService.showProgress(notifId, "Analyzing Exam", "Extracting and solving questions natively...", indeterminate: true);

    try {
        final qp = await _aiService.generateQuestionPaper(files, qpTitle, currentBook.systemPrompt);

        // Re-read the freshest book so we don't clobber other concurrent edits.
        final baseBook = (await _dbService.getBookFromCache(currentBook.id)) ?? currentBook;
        final updatedBook = baseBook.copyWith(
            questionPapers: [...baseBook.questionPapers, qp]
        );

        await _dbService.saveGeneratedBook(updatedBook);
        _bookUpdateController.add(updatedBook);
        
        activeQpTasks.remove(bookId);
        notifyListeners();

        await NotificationService.cancel(notifId);
        await NotificationService.showActionable(notifId, "Exam Ready", "Past paper solved interactively!", "open_home|");
    } catch(e) {
        activeQpTasks[bookId]?.status = 'Error: $e';
        activeQpTasks[bookId]?.isError = true;
        notifyListeners();

        await NotificationService.cancel(notifId);
        await NotificationService.showActionable(notifId, "Analysis Failed", "Failed to solve past paper.", "error");
    }
  }

  void clearUnitError(String unitId) {
    if (activeUnitGenerations[unitId]?.isError == true) {
      activeUnitGenerations.remove(unitId);
      notifyListeners();
    }
  }

  void clearQpError(String bookId) {
    if (activeQpTasks[bookId]?.isError == true) {
      activeQpTasks.remove(bookId);
      notifyListeners();
    }
  }

  void dismissTask(String id) {
    activeTasks.removeWhere((t) => t.id == id);
    NotificationService.cancel(id.hashCode);
    notifyListeners();
  }
}