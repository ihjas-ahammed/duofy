import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/file_selection_list.dart';

class GenerateBookScreen extends StatefulWidget {
  const GenerateBookScreen({super.key});

  @override
  State<GenerateBookScreen> createState() => _GenerateBookScreenState();
}

class _GenerateBookScreenState extends State<GenerateBookScreen> {
  final List<File> _selectedFiles = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        final newFiles = result.paths.where((p) => p != null).map((p) => File(p!)).toList();
        _selectedFiles.addAll(newFiles);
      });
    }
  }

  void _generate() {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select at least one file.')));
      return;
    }

    final filename = _selectedFiles.first.path.split('/').last;

    GenerationManager.instance.startBookGeneration(_selectedFiles, filename);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analyzing structure in Background! You can add another course.'))
    );

    setState(() {
      _selectedFiles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Course', style: TextStyle(fontWeight: FontWeight.w900))),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Upload PDFs or multiple images. We'll instantly analyze them to map out the course chapters. The process happens seamlessly in the background.",
                      style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    
                    FileSelectionList(
                      files: _selectedFiles,
                      onAddMore: _pickFiles,
                      onRemove: (idx) => setState(() => _selectedFiles.removeAt(idx)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DuoButton(
                text: 'Analyze Document',
                onPressed: _generate,
                color: _selectedFiles.isNotEmpty ? AppTheme.duoGreen : Colors.grey.shade700,
                shadowColor: _selectedFiles.isNotEmpty ? AppTheme.duoGreenDark : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}