import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/file_selection_list.dart';
import 'index_picker_screen.dart';

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

    // The TOC-only flow needs a single PDF so the user can scroll to the
    // index pages and to Chapter 1. Image-only inputs aren\'t supported for
    // skeleton generation right now — surface that explicitly rather than
    // silently falling back to old behaviour.
    final isSinglePdf = _selectedFiles.length == 1 &&
        _selectedFiles.first.path.toLowerCase().endsWith('.pdf');
    if (!isSinglePdf) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('New course generation needs a single PDF (so you can pick its index pages).'),
      ));
      return;
    }

    final pdf = _selectedFiles.first;
    final filename = pdf.path.split(RegExp(r'[\\/]')).last;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => IndexPickerScreen(sourcePdf: pdf, filename: filename),
    ));

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