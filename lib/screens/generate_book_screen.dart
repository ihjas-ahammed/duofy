import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/ai_service.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

class GenerateBookScreen extends StatefulWidget {
  const GenerateBookScreen({super.key});

  @override
  State<GenerateBookScreen> createState() => _GenerateBookScreenState();
}

class _GenerateBookScreenState extends State<GenerateBookScreen> {
  final AiService _aiService = AiService();
  final DatabaseService _dbService = DatabaseService();
  final _titleController = TextEditingController();
  
  File? _selectedFile;
  bool _isGenerating = false;
  String _statusMessage = '';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _generate() async {
    if (_selectedFile == null || _titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a PDF and enter a title.')));
      return;
    }

    setState(() {
      _isGenerating = true;
      _statusMessage = 'Analyzing PDF with Gemini... This may take a minute.';
    });

    try {
      final book = await _aiService.generateBookFromPdf(_selectedFile!, _titleController.text.trim());
      if (book != null) {
        setState(() => _statusMessage = 'Saving to Database...');
        await _dbService.saveGeneratedBook(book);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book Generated Successfully!')));
          Navigator.pop(context);
        }
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: \${e.toString()}';
      });
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate Lesson')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Book Title',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black26,
              ),
            ),
            const SizedBox(height: 24),
            DuoButton(
              text: _selectedFile != null ? 'PDF Selected' : 'Upload PDF',
              onPressed: _pickFile,
              color: AppTheme.duoBlue,
              shadowColor: AppTheme.duoBlueDark,
              isOutline: _selectedFile != null,
            ),
            if (_selectedFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('File: \${_selectedFile!.path.split('/').last}', style: const TextStyle(color: Colors.white54), textAlign: TextAlign.center),
              ),
            const Spacer(),
            if (_isGenerating)
              Column(
                children: [
                  const CircularProgressIndicator(color: AppTheme.duoGreen),
                  const SizedBox(height: 16),
                  Text(_statusMessage, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                ],
              )
            else
              DuoButton(
                text: 'Generate Book',
                onPressed: _generate,
                color: AppTheme.duoGreen,
                shadowColor: AppTheme.duoGreenDark,
              ),
          ],
        ),
      ),
    );
  }
}