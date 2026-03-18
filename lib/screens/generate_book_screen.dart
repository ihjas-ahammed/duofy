import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

class GenerateBookScreen extends StatefulWidget {
  const GenerateBookScreen({super.key});

  @override
  State<GenerateBookScreen> createState() => _GenerateBookScreenState();
}

class _GenerateBookScreenState extends State<GenerateBookScreen> {
  File? _selectedFile;

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

  void _generate() {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a PDF file first.')));
      return;
    }

    final filename = _selectedFile!.path.split('/').last;
    
    // Kick off async metadata extraction immediately and return to home
    GenerationManager.instance.startBookGeneration(_selectedFile!, filename);
    Navigator.pop(context);
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
              "We'll instantly analyze the PDF to map out the course chapters. You can review the structure before we chunk the file in the background.",
              style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 32),
            DuoButton(
              text: _selectedFile != null ? 'PDF Selected' : 'Upload PDF',
              onPressed: _pickFile,
              color: AppTheme.duoBlue,
              shadowColor: AppTheme.duoBlueDark,
              isOutline: _selectedFile != null,
            ),
            if (_selectedFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('File: ${_selectedFile!.path.split('/').last}', style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ),
            const Spacer(),
            
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