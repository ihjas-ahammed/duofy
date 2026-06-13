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
  final List<String> _choices = [
    "Include core conceptual theory and definitions",
    "Include step-by-step worked examples",
  ];
  final Set<String> _selectedChoices = {};
  bool _isLoadingAiQuestions = true;

  @override
  void initState() {
    super.initState();
    _selectedChoices.addAll(_choices);
    _generateAiQuestions();
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
            if (!_choices.contains(q)) {
              _choices.add(q);
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
    final String? customInstructions = (widget.customIndexingPrompt != null && widget.customIndexingPrompt!.trim().isNotEmpty)
        ? 'Indexing guidance:\n${widget.customIndexingPrompt!.trim()}'
        : null;

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

    GenerationManager.instance.startBookGeneration(
      widget.sourcePdfs,
      widget.filename,
      indexFiles: indexPdfs,
      chapter1AbsolutePages: widget.allChapter1StartPages,
      customInstructions: customInstructions,
      syllabusFiles: widget.syllabusFiles,
      isHandout: widget.isHandout,
      chapterStarts: widget.indexMode == IndexMode.chapters ? widget.allIndexPages : null,
      plannerQuestions: _choices,
      selectedQuestions: _selectedChoices.toList(),
    );
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating course in background...')));
    Navigator.of(context).popUntil((route) => route.isFirst);
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
              const Text('Select options to tailor the generated units to your learning style.', style: TextStyle(color: Colors.white54, fontSize: 13)),
              const SizedBox(height: 24),
              
              ..._choices.map((choice) {
                final isSelected = _selectedChoices.contains(choice);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppTheme.duoBlue : Colors.white12,
                      width: 1.5,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    activeColor: AppTheme.duoBlue,
                    checkColor: Colors.white,
                    title: Text(
                      choice,
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          _selectedChoices.add(choice);
                        } else {
                          _selectedChoices.remove(choice);
                        }
                      });
                    },
                  ),
                );
              }),
              
              if (_isLoadingAiQuestions)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(color: AppTheme.duoBlue),
                  ),
                ),
                
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
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
