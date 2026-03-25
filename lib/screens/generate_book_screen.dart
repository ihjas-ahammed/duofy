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
  final TextEditingController _promptCtrl = TextEditingController();

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
    final prompt = _promptCtrl.text.trim().isEmpty ? null : _promptCtrl.text.trim();
    
    GenerationManager.instance.startBookGeneration(_selectedFiles, filename, prompt);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analyzing structure in Background! You can add another course.'))
    );
    
    setState(() {
      _selectedFiles.clear();
      _promptCtrl.clear();
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
                    
                    const SizedBox(height: 32),
                    const Text('Custom Instructions (Optional)', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: AppTheme.glassDecoration,
                      child: TextField(
                        controller: _promptCtrl,
                        maxLines: 4,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "E.g., Focus deeply on mathematical proofs, or make it suitable for a 10 year old.",
                          hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
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