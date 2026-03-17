import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import '../models/app_models.dart';
import 'pdf_service.dart';
import 'database_service.dart';
import 'ai_service.dart';

class GenerationTask {
  final String id;
  final String title;
  String statusMessage;
  bool isError;

  GenerationTask({
    required this.id, 
    required this.title, 
    this.statusMessage = 'Starting...', 
    this.isError = false
  });
}

class GenerationManager extends ChangeNotifier {
  static final GenerationManager instance = GenerationManager._internal();
  GenerationManager._internal();

  final List<GenerationTask> activeTasks = [];
  final Map<String, String> activeUnitGenerations = {}; // Unit ID -> Status
  
  final PdfService _pdfService = PdfService();
  final DatabaseService _dbService = DatabaseService();
  final AiService _aiService = AiService();

  // Stream for broadcasting globally updated books (e.g., when a unit finishes generating in the background)
  final StreamController<Book> _bookUpdateController = StreamController<Book>.broadcast();
  Stream<Book> get bookUpdates => _bookUpdateController.stream;

  VoidCallback? onBookGenerated;

  /// Background Stage 2: Physically splits the PDF and saves the chunked book to DB
  Future<void> startBackgroundSplitAndSave(File originalPdf, Book offsetBook) async {
    print("\n[GenerationManager] === STARTING BACKGROUND SPLIT & SAVE ===");
    print("[GenerationManager] Book ID: ${offsetBook.id}");
    final task = GenerationTask(
      id: offsetBook.id, 
      title: offsetBook.title,
      statusMessage: 'Physically chunking PDF...'
    );
    activeTasks.add(task);
    notifyListeners();

    try {
      final completeBook = await _pdfService.splitBookPdf(originalPdf, offsetBook);

      task.statusMessage = 'Saving to Database...';
      notifyListeners();
      
      print("[GenerationManager] Split complete. Saving generated book to database.");
      await _dbService.saveGeneratedBook(completeBook);
      
      activeTasks.remove(task);
      notifyListeners();
      
      print("[GenerationManager] === SPLIT & SAVE SUCCESSFUL ===\n");
      onBookGenerated?.call();
    } catch (e) {
      print("[GenerationManager] ERROR during split & save: $e");
      task.isError = true;
      task.statusMessage = 'Error: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Background Stage 3: Generates deep lesson content for a specific Unit asynchronously
  Future<void> startUnitGeneration(Unit unit, Book book, int modIdx, int secIdx, int unitIdx) async {
    if (activeUnitGenerations.containsKey(unit.id)) {
      print("[GenerationManager] Unit ${unit.id} is already generating. Ignoring request.");
      return;
    }
    
    print("\n[GenerationManager] === STARTING UNIT GENERATION (BACKGROUND) ===");
    print("[GenerationManager] Target Unit: ${unit.title} (ID: ${unit.id})");
    
    activeUnitGenerations[unit.id] = 'Initializing AI...';
    notifyListeners();
    
    try {
      final updatedUnit = await _aiService.generateUnitContent(unit, book, (status) {
        activeUnitGenerations[unit.id] = status;
        notifyListeners();
      });
      
      print("[GenerationManager] Reconstructing book with generated unit...");
      final List<Unit> updatedUnits = List.from(book.modules[modIdx].sections[secIdx].units);
      updatedUnits[unitIdx] = updatedUnit;
      
      final List<Section> updatedSections = List.from(book.modules[modIdx].sections);
      updatedSections[secIdx] = updatedSections[secIdx].copyWith(units: updatedUnits);

      final List<Module> updatedModules = List.from(book.modules);
      updatedModules[modIdx] = updatedModules[modIdx].copyWith(sections: updatedSections);

      final newBook = book.copyWith(modules: updatedModules);

      print("[GenerationManager] Saving updated book to Database...");
      await _dbService.saveGeneratedBook(newBook);
      
      activeUnitGenerations.remove(unit.id);
      notifyListeners();

      print("[GenerationManager] Broadcasting Book Update to UI Listeners.");
      _bookUpdateController.add(newBook);
      print("[GenerationManager] === UNIT GENERATION SUCCESSFUL ===\n");

    } catch (e) {
      print("[GenerationManager] ERROR during unit generation: $e");
      activeUnitGenerations[unit.id] = 'Error: $e';
      notifyListeners();
    }
  }

  void clearUnitError(String unitId) {
    if (activeUnitGenerations[unitId]?.startsWith('Error') ?? false) {
      activeUnitGenerations.remove(unitId);
      notifyListeners();
    }
  }

  void dismissTask(String id) {
    activeTasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}