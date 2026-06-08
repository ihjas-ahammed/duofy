import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/pdf_service.dart';
import '../services/generation_manager.dart';
import '../services/ai_service.dart';
import '../widgets/responsive_center.dart';
import 'generate_book_screen.dart' show IndexMode;

class CourseQuestionnaireScreen extends StatefulWidget {
  final List<File> sourcePdfs;
  final String filename;
  final List<File> syllabusFiles;
  final bool isCourse;
  final List<List<int>> allIndexPages;
  final List<int> allChapter1StartPages;
  final bool isHandout;
  final IndexMode indexMode;
  final String? customIndexingPrompt;

  const CourseQuestionnaireScreen({
    super.key,
    required this.sourcePdfs,
    required this.filename,
    this.syllabusFiles = const [],
    this.isCourse = false,
    required this.allIndexPages,
    required this.allChapter1StartPages,
    this.isHandout = false,
    this.indexMode = IndexMode.manual,
    this.customIndexingPrompt,
  });

  @override
  State<CourseQuestionnaireScreen> createState() => _CourseQuestionnaireScreenState();
}

class _CourseQuestionnaireScreenState extends State<CourseQuestionnaireScreen> {
  final Map<String, TextEditingController> _answers = {};
  List<String> _questions = [
    "What is your primary goal for this material? (e.g. Exam prep, casual learning)",
    "Do you prefer more theory or more practical worked examples?",
  ];
  bool _isLoadingAiQuestions = true;

  @override
  void initState() {
    super.initState();
    for (var q in _questions) {
      _answers[q] = TextEditingController();
    }
    _generateAiQuestions();
  }

  @override
  void dispose() {
    for (var ctrl in _answers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Future<void> _generateAiQuestions() async {
    try {
      if (widget.sourcePdfs.isEmpty || widget.allChapter1StartPages.isEmpty) return;
      final qs = await AiService().generateCourseQuestions(
        sourcePdf: widget.sourcePdfs.first,
        chapter1StartPage: widget.allChapter1StartPages.first,
      );
      
      if (qs != null && mounted) {
        setState(() {
          for (var q in qs) {
            if (!_questions.contains(q)) {
              _questions.add(q);
              _answers[q] = TextEditingController();
            }
          }
        });
      }
    } catch (e) {
      print('AI questions error: $e');
    } finally {
      if (mounted) setState(() => _isLoadingAiQuestions = false);
    }
  }

  Future<void> _submit() async {
    final buffer = StringBuffer();
    if (widget.customIndexingPrompt != null && widget.customIndexingPrompt!.trim().isNotEmpty) {
      buffer.writeln('Indexing guidance:\n${widget.customIndexingPrompt!.trim()}');
      buffer.writeln('');
    }
    for (var q in _questions) {
      final ans = _answers[q]?.text.trim() ?? '';
      if (ans.isNotEmpty) {
        buffer.writeln('Q: $q');
        buffer.writeln('A: $ans');
        buffer.writeln('');
      }
    }
    
    final customInstructions = buffer.toString().trim();

    final List<File> indexPdfs = [];
    try {
      for (int i = 0; i < widget.sourcePdfs.length; i++) {
        final pdf = widget.sourcePdfs[i];
        final pages = widget.allIndexPages[i];
        final name = pdf.path.split(RegExp(r'[\\/]')).last;
        final indexPdf = await PdfService().extractPages(
          pdf,
          pages,
          outputName: 'index_$name',
        );
        indexPdfs.add(indexPdf);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error extracting index: $e')));
      return;
    }

    if (!mounted) return;

    if (widget.isCourse && widget.syllabusFiles.isNotEmpty) {
      GenerationManager.instance.startBookGeneration(
        widget.sourcePdfs,
        widget.filename,
        indexFiles: indexPdfs,
        chapter1AbsolutePages: widget.allChapter1StartPages,
        customInstructions: customInstructions.isNotEmpty ? customInstructions : null,
        syllabusFiles: widget.syllabusFiles,
        isHandout: widget.isHandout,
        chapterStarts: widget.indexMode == IndexMode.chapters ? widget.allIndexPages : null,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating course in background...')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      // Normal book generation but with auto-index and custom instructions
      GenerationManager.instance.startBookGeneration(
        widget.sourcePdfs,
        widget.filename,
        indexFiles: indexPdfs,
        chapter1AbsolutePages: widget.allChapter1StartPages,
        customInstructions: customInstructions.isNotEmpty ? customInstructions : null,
        isHandout: widget.isHandout,
        chapterStarts: widget.indexMode == IndexMode.chapters ? widget.allIndexPages : null,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating course in background...')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('Course Setup', style: TextStyle(fontWeight: FontWeight.bold))),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Personalize Your Course', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Answer a few questions to tailor the generated units to your learning style.', style: TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 24),
            
            ..._questions.map((q) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(q, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _answers[q],
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Your answer (optional)',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: AppTheme.surface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ),
            )),
            
            if (_isLoadingAiQuestions)
              const Center(child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(color: AppTheme.duoBlue),
              )),
              
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.duoGreen, padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: _submit,
              child: const Text('Start Generation', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
