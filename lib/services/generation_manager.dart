import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import 'pdf_service.dart';
import 'database_service.dart';
import 'ai_service.dart';

enum BookGenState { extracting, review, chunking, saving, error }

class GenerationTask {
  final String id;
  final String title;
  final File pdfFile;
  BookGenState state;
  String statusMessage;
  Book? skeletonBook;
  String? errorMessage;
  Duration estimatedDuration;
  DateTime startTime;

  GenerationTask({
    required this.id, 
    required this.title, 
    required this.pdfFile,
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

class GenerationManager extends ChangeNotifier {
  static final GenerationManager instance = GenerationManager._internal();
  GenerationManager._internal();

  final List<GenerationTask> activeTasks = [];
  final Map<String, UnitGenTask> activeUnitGenerations = {}; // Unit ID -> Task Status
  
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
    if (history.length > 3) history.removeAt(0); // rolling average of last 3
    await prefs.setStringList(key, history);
  }

  Future<int> _getAverageRunTime(String key, int defaultMs) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(key) ?? [];
    if (history.isEmpty) return defaultMs;
    int sum = history.fold(0, (prev, element) => prev + int.parse(element));
    return sum ~/ history.length;
  }

  /// Background Stage 1: Async Book Skeleton Extraction
  Future<void> startBookGeneration(File pdfFile, String filename) async {
    final taskId = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Estimate Time
    final fileSize = await pdfFile.length();
    final uploadSecs = (fileSize / 500000).ceil(); // Assuming ~500 KB/s upload
    final avgAiMs = await _getAverageRunTime('meta_gen_history', 120000); // 2 mins default
    final estimatedDuration = Duration(seconds: uploadSecs, milliseconds: avgAiMs);

    final task = GenerationTask(
      id: taskId,
      title: filename,
      pdfFile: pdfFile,
      startTime: DateTime.now(),
      estimatedDuration: estimatedDuration,
    );
    
    activeTasks.add(task);
    notifyListeners();

    try {
      final stopwatch = Stopwatch()..start();
      final skeletonBook = await _aiService.generateBookSkeleton(pdfFile, filename);
      stopwatch.stop();

      await _recordRunTime('meta_gen_history', stopwatch.elapsedMilliseconds);

      if (skeletonBook != null) {
        task.skeletonBook = skeletonBook;
        task.state = BookGenState.review;
        task.statusMessage = 'Action Required: Review Splits';
        notifyListeners();
      }
    } catch (e) {
      task.state = BookGenState.error;
      task.errorMessage = e.toString();
      task.statusMessage = 'Failed to generate structure';
      notifyListeners();
    }
  }

  /// Background Stage 2: Physically splits the PDF and saves the chunked book to DB
  Future<void> startBackgroundSplitAndSave(String taskId, File originalPdf, Book offsetBook) async {
    final taskIndex = activeTasks.indexWhere((t) => t.id == taskId);
    if (taskIndex == -1) return;
    
    final task = activeTasks[taskIndex];
    task.state = BookGenState.chunking;
    task.statusMessage = 'Splitting PDF chunks...';
    // Re-estimate for chunking phase
    task.estimatedDuration = const Duration(seconds: 15);
    task.startTime = DateTime.now();
    notifyListeners();

    try {
      final completeBook = await _pdfService.splitBookPdf(originalPdf, offsetBook);

      task.state = BookGenState.saving;
      task.statusMessage = 'Saving to Database...';
      notifyListeners();
      
      await _dbService.saveGeneratedBook(completeBook);
      
      activeTasks.remove(task);
      notifyListeners();
      
      onBookGenerated?.call();
    } catch (e) {
      task.state = BookGenState.error;
      task.statusMessage = 'Error chunking file';
      task.errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Background Stage 3: Generates deep lesson content for a specific Unit asynchronously
  Future<void> startUnitGeneration(Unit unit, Book book, int modIdx, int secIdx, int unitIdx) async {
    if (activeUnitGenerations.containsKey(unit.id)) return;
    
    final avgUnitMs = await _getAverageRunTime('unit_gen_history', 90000); // 1.5 mins default

    activeUnitGenerations[unit.id] = UnitGenTask(
      status: 'Initializing AI...',
      estimatedDuration: Duration(milliseconds: avgUnitMs),
      startTime: DateTime.now()
    );
    notifyListeners();
    
    try {
      final stopwatch = Stopwatch()..start();
      final updatedUnit = await _aiService.generateUnitContent(unit, book, (status) {
        activeUnitGenerations[unit.id]?.status = status;
        notifyListeners();
      });
      stopwatch.stop();
      await _recordRunTime('unit_gen_history', stopwatch.elapsedMilliseconds);

      final List<Unit> updatedUnits = List.from(book.modules[modIdx].sections[secIdx].units);
      updatedUnits[unitIdx] = updatedUnit;
      
      final List<Section> updatedSections = List.from(book.modules[modIdx].sections);
      updatedSections[secIdx] = updatedSections[secIdx].copyWith(units: updatedUnits);

      final List<Module> updatedModules = List.from(book.modules);
      updatedModules[modIdx] = updatedModules[modIdx].copyWith(sections: updatedSections);

      final newBook = book.copyWith(modules: updatedModules);

      await _dbService.saveGeneratedBook(newBook);
      
      activeUnitGenerations.remove(unit.id);
      notifyListeners();

      _bookUpdateController.add(newBook);
    } catch (e) {
      activeUnitGenerations[unit.id]?.isError = true;
      activeUnitGenerations[unit.id]?.status = 'Error: $e';
      notifyListeners();
    }
  }

  void clearUnitError(String unitId) {
    if (activeUnitGenerations[unitId]?.isError == true) {
      activeUnitGenerations.remove(unitId);
      notifyListeners();
    }
  }

  void dismissTask(String id) {
    activeTasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}