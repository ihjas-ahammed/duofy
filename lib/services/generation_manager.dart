import 'dart:io';
import 'package:flutter/material.dart';
import '../models/app_models.dart';
import 'pdf_service.dart';
import 'database_service.dart';

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
  final PdfService _pdfService = PdfService();
  final DatabaseService _dbService = DatabaseService();

  VoidCallback? onBookGenerated;

  /// Background Stage 2: Physically splits the PDF and saves the chunked book to DB
  Future<void> startBackgroundSplitAndSave(File originalPdf, Book offsetBook) async {
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
      
      await _dbService.saveGeneratedBook(completeBook);
      
      activeTasks.remove(task);
      notifyListeners();
      
      onBookGenerated?.call();
    } catch (e) {
      task.isError = true;
      task.statusMessage = 'Error: ${e.toString()}';
      notifyListeners();
    }
  }

  void dismissTask(String id) {
    activeTasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}