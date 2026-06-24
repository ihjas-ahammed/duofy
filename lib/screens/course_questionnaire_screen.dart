import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/pdf_service.dart';
import '../services/generation_manager.dart';
import '../services/ai_service.dart';
import '../widgets/responsive_center.dart';
import '../widgets/duo_button.dart';
import 'generate_book_screen.dart' show IndexMode;
import 'package:lucide_icons/lucide_icons.dart';

class CourseQuestionnaireScreen extends StatefulWidget {
  final List<File> sourcePdfs;
  final String filename;
  final List<File> syllabusFiles;
  final bool isCourse;
  final List<List<int>>? allIndexPages;
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
  List<Map<String, dynamic>> _questions = [];
  final Map<int, int> _userAnswers = {};
  int _currentQuestionIndex = 0;
  bool _isLoadingAiQuestions = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _generateDiagnosticQuestions();
  }

  Future<void> _generateDiagnosticQuestions() async {
    try {
      final syllabusFile = widget.syllabusFiles.isNotEmpty ? widget.syllabusFiles.first : null;
      final sourcePdf = widget.sourcePdfs.isNotEmpty ? widget.sourcePdfs.first : null;
      final indexPages = widget.allIndexPages != null && widget.allIndexPages!.isNotEmpty
          ? widget.allIndexPages!.first
          : null;

      final result = await AiService().generateCognitiveDiagnosticQuestions(
        syllabusPdf: syllabusFile,
        sourcePdf: sourcePdf,
        indexPages: indexPages,
      );

      if (result != null && result['questions'] is List) {
        if (mounted) {
          setState(() {
            _questions = List<Map<String, dynamic>>.from(
              (result['questions'] as List).map((e) => Map<String, dynamic>.from(e as Map)),
            );
            _isLoadingAiQuestions = false;
          });
        }
      } else {
        throw Exception("Invalid response structure or no questions generated.");
      }
    } catch (e) {
      print('Diagnostic pre-assessment questions error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = "Unable to generate assessment: $e. You can proceed directly to generate the course.";
          _isLoadingAiQuestions = false;
        });
      }
    }
  }

  Future<void> _submit() async {
    final String? customInstructions = (widget.customIndexingPrompt != null && widget.customIndexingPrompt!.trim().isNotEmpty)
        ? 'Indexing guidance:\n${widget.customIndexingPrompt!.trim()}'
        : null;

    final List<File> indexPdfs = [];
    try {
      if (widget.allIndexPages != null) {
        for (int i = 0; i < widget.sourcePdfs.length; i++) {
          final pdf = widget.sourcePdfs[i];
          final pages = widget.allIndexPages![i];
          final name = pdf.path.split(RegExp(r'[\\/]')).last;
          final indexPdf = await PdfService().extractPages(
            pdf,
            pages,
            outputName: 'index_$name',
          );
          indexPdfs.add(indexPdf);
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error extracting index: $e')));
      return;
    }

    if (!mounted) return;

    // Score user answers to determine entry Bloom's taxonomy level
    int correctCount = 0;
    bool isSkipped = _userAnswers.isEmpty;
    for (int i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] == _questions[i]['correctIndex']) {
        correctCount++;
      }
    }

    String bloomLevel;
    if (_questions.isEmpty) {
      bloomLevel = 'Remembering / Understanding';
    } else {
      final pct = correctCount / _questions.length;
      if (pct <= 0.33) {
        bloomLevel = 'Remembering / Understanding';
      } else if (pct <= 0.67) {
        bloomLevel = 'Applying / Analyzing';
      } else {
        bloomLevel = 'Evaluating / Creating';
      }
    }

    GenerationManager.instance.startBookGeneration(
      widget.sourcePdfs,
      widget.filename,
      indexFiles: indexPdfs,
      chapter1AbsolutePages: widget.allChapter1StartPages,
      customInstructions: customInstructions,
      syllabusFiles: widget.syllabusFiles,
      isHandout: widget.isHandout,
      chapterStarts: widget.indexMode == IndexMode.chapters ? widget.allIndexPages : null,
      bloomLevel: bloomLevel,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(isSkipped
          ? 'Starting course with baseline level: $bloomLevel. Generating course...'
          : 'Diagnostic score: $correctCount/${_questions.length}. Entry level: $bloomLevel. Generating course...'),
      duration: const Duration(seconds: 4),
    ));
    
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_isLoadingAiQuestions) {
      bodyContent = Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppTheme.duoBlue),
              const SizedBox(height: 24),
              const Text(
                'Generating Diagnostic Assessment...',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.syllabusFiles.isNotEmpty
                    ? 'Extracting syllabus topics to test readiness...'
                    : 'Parsing textbook table of contents to test readiness...',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else if (_errorMessage != null) {
      bodyContent = Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(LucideIcons.alertCircle, color: AppTheme.duoOrange, size: 48),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            DuoButton(
              text: 'Retry Generating Assessment',
              onPressed: () {
                setState(() {
                  _isLoadingAiQuestions = true;
                  _errorMessage = null;
                });
                _generateDiagnosticQuestions();
              },
              color: AppTheme.duoBlue,
              shadowColor: AppTheme.duoBlueDark,
            ),
            const SizedBox(height: 12),
            DuoButton(
              text: 'Start Default Generation',
              onPressed: _submit,
              color: AppTheme.duoGreen,
              shadowColor: AppTheme.duoGreenDark,
            ),
          ],
        ),
      );
    } else {
      final currentQuestion = _questions[_currentQuestionIndex];
      final options = List<String>.from(currentQuestion['options']);
      final selectedOption = _userAnswers[_currentQuestionIndex];

      bodyContent = SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress tracker
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / _questions.length,
                    backgroundColor: Colors.white10,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${_currentQuestionIndex + 1}/${_questions.length}',
                  style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Question Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.glassDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.duoBlue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      currentQuestion['bloomLevel']?.toString().toUpperCase() ?? 'ASSESSMENT',
                      style: const TextStyle(
                        color: AppTheme.duoBlue,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentQuestion['question'] ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Options list
            ...options.asMap().entries.map((entry) {
              final idx = entry.key;
              final text = entry.value;
              final isSelected = selectedOption == idx;

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
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _userAnswers[_currentQuestionIndex] = idx;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: isSelected ? AppTheme.duoBlue : Colors.white12,
                          child: Text(
                            String.fromCharCode(65 + idx), // A, B, C, D
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            text,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 32),

            Row(
              children: [
                if (_currentQuestionIndex > 0) ...[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                      child: const Text('Back', style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedOption != null ? AppTheme.duoGreen : Colors.white12,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      if (_currentQuestionIndex < _questions.length - 1) {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      } else {
                        _submit();
                      }
                    },
                    child: Text(
                      selectedOption != null
                          ? (_currentQuestionIndex == _questions.length - 1 ? 'Start Generation' : 'Next')
                          : (_currentQuestionIndex == _questions.length - 1 ? 'Skip & Start' : 'Skip Question'),
                      style: TextStyle(
                        color: selectedOption != null ? Colors.white : Colors.white60,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _userAnswers.clear();
                _submit();
              },
              child: const Text(
                'Skip Assessment (Start with baseline level)',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Cognitive Diagnostic Assessment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: bodyContent,
      ),
    );
  }
}
