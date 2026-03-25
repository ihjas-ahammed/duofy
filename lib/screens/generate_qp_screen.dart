import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/app_models.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/file_selection_list.dart';

class GenerateQpScreen extends StatefulWidget {
  final Book book;

  const GenerateQpScreen({super.key, required this.book});

  @override
  State<GenerateQpScreen> createState() => _GenerateQpScreenState();
}

class _GenerateQpScreenState extends State<GenerateQpScreen> {
  final List<File> _selectedFiles = [];
  final TextEditingController _titleCtrl = TextEditingController();
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
    
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a name for this past paper.')));
      return;
    }

    final prompt = _promptCtrl.text.trim().isEmpty ? null : _promptCtrl.text.trim();
    
    GenerationManager.instance.startQpGeneration(widget.book.id, _selectedFiles, title, widget.book, prompt);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Exam in Background! You can queue another.'))
    );
    
    setState(() {
      _selectedFiles.clear();
      _titleCtrl.clear();
      _promptCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Past Paper', style: TextStyle(fontWeight: FontWeight.w900))),
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
                      "Upload PDFs or photos of past exams. The AI will extract the questions and solve them interactively. You can safely minimize the app during processing.",
                      style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 24),

                    const Text('Exam Name', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: AppTheme.glassDecoration,
                      child: TextField(
                        controller: _titleCtrl,
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: "e.g. Midterm 2023",
                          hintStyle: const TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.normal),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
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
                          hintText: "E.g., Provide extremely detailed step-by-step proofs for any calculus questions.",
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
                text: 'Solve & Add Paper',
                onPressed: _generate,
                color: _selectedFiles.isNotEmpty ? AppTheme.duoBlue : Colors.grey.shade700,
                shadowColor: _selectedFiles.isNotEmpty ? AppTheme.duoBlueDark : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}