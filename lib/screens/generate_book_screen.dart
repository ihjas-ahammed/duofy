import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/ai_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import 'pdf_split_preview_screen.dart';

class GenerateBookScreen extends StatefulWidget {
  const GenerateBookScreen({super.key});

  @override
  State<GenerateBookScreen> createState() => _GenerateBookScreenState();
}

class _GenerateBookScreenState extends State<GenerateBookScreen> {
  final AiService _aiService = AiService();
  final _titleController = TextEditingController();
  
  File? _selectedFile;
  bool _isGenerating = false;

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

    setState(() => _isGenerating = true);

    try {
      // Stage 1: Generate Skeleton
      final skeletonBook = await _aiService.generateBookSkeleton(_selectedFile!, _titleController.text.trim());
      
      if (skeletonBook != null && mounted) {
        // Pause generation and push to Preview Screen for confirmation
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (_) => PdfSplitPreviewScreen(
              originalPdf: _selectedFile!,
              skeletonBook: skeletonBook,
            )
          )
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
        setState(() => _isGenerating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Course', style: TextStyle(fontWeight: FontWeight.w900))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "We'll analyze the PDF to create a course skeleton first. Then you can review the assigned page ranges before we chunk the file.",
              style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Course Title',
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
                child: Text('File: ${_selectedFile!.path.split('/').last}', style: const TextStyle(color: Colors.white54), textAlign: TextAlign.center),
              ),
            const Spacer(),
            
            if (_isGenerating)
              const Column(
                children: [
                  CircularProgressIndicator(color: AppTheme.duoGreen),
                  SizedBox(height: 16),
                  Text('Analyzing Book Structure...', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                ],
              )
            else
              DuoButton(
                text: 'Analyze PDF',
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