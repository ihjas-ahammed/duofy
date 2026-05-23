import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/global_state.dart';
import '../services/progress_service.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import '../widgets/slide_views/quiz_view.dart';
import '../widgets/slide_views/fill_in_blank_view.dart';
import '../widgets/slide_views/numerical_view.dart';
import '../widgets/slide_views/interactive_proof_view.dart';
import 'lesson_complete_screen.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentIndex = 0;
  bool _answered = false;
  bool _isCorrect = false;

  late DateTime _startTime;
  int _totalInteractive = 0;
  int _correctAttempts = 0;
  List<Slide> _slideQueue = [];

  String? _selectedQuizOption;
  String _blankInput = '';
  String _numericInput = '';

  bool _isEditingMode = false;
  final TextEditingController _editController = TextEditingController();

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _buildSlideQueue();
  }

  void _buildSlideQueue() {
    _slideQueue = List.of(widget.lesson.slides);

    for (var slide in _slideQueue) {
      if (['quiz', 'fill_in_blank', 'numerical', 'proof', 'step_by_step'].contains(slide.type)) {
        _totalInteractive++;
      }
    }
  }

  void _nextSlide() {
    if (_currentIndex < _slideQueue.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
        _isCorrect = false;
        _selectedQuizOption = null;
        _blankInput = '';
        _numericInput = '';
      });
    } else {
      _finishLesson();
    }
  }

  Future<void> _finishLesson() async {
    int timeSpent = DateTime.now().difference(_startTime).inSeconds;
    int accuracy = _totalInteractive > 0 ? ((_correctAttempts / _totalInteractive) * 100).round() : 100;
    
    bool isNewCompletion = !(await ProgressService.getCompletedLessons()).contains(widget.lesson.id);
    int xpEarned = isNewCompletion ? 20 : 5;

    await ProgressService.markLessonCompleted(widget.lesson.id);
    await GlobalState.addXp(xpEarned);
    
    if (mounted) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => LessonCompleteScreen(
          xpEarned: xpEarned,
          accuracy: accuracy,
          timeSpentSeconds: timeSpent,
        ))
      );
    }
  }

  void _checkAnswer(Slide slide) {
    bool correct = false;

    if (slide.type == 'quiz' && _selectedQuizOption != null) {
      final opt = slide.options!.firstWhere((o) => o.id == _selectedQuizOption);
      correct = opt.isCorrect;
      
      if (!correct) {
        final correctOpts = slide.options!.where((o) => o.isCorrect);
        if (correctOpts.any((c) => c.text.trim().toLowerCase() == opt.text.trim().toLowerCase())) {
          correct = true;
        }
      }
    } else if (slide.type == 'fill_in_blank') {
      correct = _blankInput.trim().toLowerCase() == slide.blankAnswer?.toLowerCase().replaceAll(r'\', '');
    } else if (slide.type == 'numerical') {
      final val = double.tryParse(_numericInput);
      if (val != null && slide.numericAnswer != null) {
        correct = (val - slide.numericAnswer!).abs() <= (slide.numericTolerance ?? 0.01);
      }
    }

    if (correct) {
      HapticFeedback.heavyImpact();
    } else {
      HapticFeedback.vibrate();
      _slideQueue.add(slide);
    }

    setState(() {
      _answered = true;
      _isCorrect = correct;
      if (correct) _correctAttempts++;
    });
  }

  bool _canCheck(Slide slide) {
    if (slide.type == 'quiz') return _selectedQuizOption != null;
    if (slide.type == 'fill_in_blank') return _blankInput.trim().isNotEmpty;
    if (slide.type == 'numerical') return _numericInput.trim().isNotEmpty;
    return true; 
  }

  bool _isCustomBottomBar(Slide slide) {
    return slide.type == 'proof' || slide.type == 'step_by_step';
  }

  String _getCorrectAnswerText(Slide slide) {
    if (slide.type == 'quiz') {
      final opt = slide.options?.firstWhere((o) => o.isCorrect, orElse: () => slide.options!.first);
      return opt?.text ?? '';
    }
    if (slide.type == 'fill_in_blank') return slide.blankAnswer ?? '';
    if (slide.type == 'numerical') return slide.numericAnswer?.toString() ?? '';
    return '';
  }

  Widget _buildSlideContent(Slide slide) {
    switch (slide.type) {
      case 'step_by_step':
      case 'proof':
        return InteractiveProofView(
          slide: slide,
          onComplete: () {
            HapticFeedback.heavyImpact();
            setState(() {
              _isCorrect = true;
              _answered = true;
              _correctAttempts++;
            });
            _nextSlide();
          },
        );
      case 'quiz':
        return QuizView(
          slide: slide,
          selectedOptionId: _selectedQuizOption,
          isAnswered: _answered,
          onSelect: (id) => setState(() => _selectedQuizOption = id),
        );
      case 'fill_in_blank':
        return FillInBlankView(
          slide: slide,
          value: _blankInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _blankInput = val),
        );
      case 'numerical':
        return NumericalView(
          slide: slide,
          value: _numericInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _numericInput = val),
        );
      case 'theory':
      case 'theory_group':
      default:
        // Wrap theory content matching LessonView.tsx default renderer (glass panel)
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SingleChildScrollView(
             physics: const BouncingScrollPhysics(),
             child: Column(
                children: [
                   if (slide.title.isNotEmpty)
                     Padding(
                        padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                        child: Text(
                          slide.title,
                          style: const TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        )
                     ),
                   Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(24),
                     decoration: AppTheme.glassDecoration.copyWith(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.black.withOpacity(0.4),
                     ),
                     child: Builder(
                       builder: (context) {
                         final lines = slide.content.split('\n');
                         return Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisSize: MainAxisSize.min,
                           children: lines.map((line) {
                             if (line.isEmpty) {
                               return const SizedBox(height: 8);
                             }
                             final hasMath = line.contains(r'$') ||
                                 line.contains(r'\[') ||
                                 line.contains(r'\]') ||
                                 line.contains(r'\(') ||
                                 line.contains(r'\)');
                             if (hasMath) {
                               return Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 4.0),
                                 child: SingleChildScrollView(
                                   scrollDirection: Axis.horizontal,
                                   physics: const BouncingScrollPhysics(),
                                   child: MathMarkdown(
                                     data: line,
                                     textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                                   ),
                                 ),
                               );
                             } else {
                               return Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 4.0),
                                 child: MathMarkdown(
                                   data: line,
                                   textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                                 ),
                               );
                             }
                           }).toList(),
                         );
                       }
                     ),
                   )
                ]
             )
          ),
        );
    }
  }



  @override
  Widget build(BuildContext context) {
    if (_slideQueue.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B0F19), // Match React lesson bg
        body: const Center(child: Text("Empty Lesson")),
      );
    }

    final slide = _slideQueue[_currentIndex];
    final progress = (_currentIndex) / _slideQueue.length;
    final isInteractive = ['quiz', 'fill_in_blank', 'numerical'].contains(slide.type);
    final hasCustomBar = _isCustomBottomBar(slide);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar exactly as LessonView.tsx
            ClipRRect( // To clip the BackdropFilter
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: const Border(bottom: BorderSide(color: Colors.white10)),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: const Icon(LucideIcons.x, color: Colors.white54, size: 28),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white10,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoGreen),
                            minHeight: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), // Match spacing symmetrically
                    ],
                  ),
                ),
              ),
            ),
            
            // Slide Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: _isEditingMode
                    ? TextField(
                        controller: _editController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 14),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF1E293B),
                          border: OutlineInputBorder(),
                          hintText: 'Markdown content...',
                          hintStyle: TextStyle(color: Colors.white24),
                        ),
                      )
                    : GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onDoubleTap: () {
                          setState(() {
                            _editController.text = slide.content;
                            _isEditingMode = true;
                          });
                        },
                        child: _buildSlideContent(slide),
                      ),
              )
            ),
            
            // Action Bottom Bar
            if (_isEditingMode)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(top: BorderSide(color: Colors.white10, width: 1)),
                ),
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
                child: DuoButton(
                  text: 'SAVE',
                  color: AppTheme.duoGreen,
                  shadowColor: AppTheme.duoGreenDark,
                  onPressed: () {
                    setState(() {
                      slide.content = _editController.text;
                      _isEditingMode = false;
                    });
                  },
                ),
              )
            else if (!hasCustomBar)
              Container(
                decoration: BoxDecoration(
                  color: _answered 
                    ? (_isCorrect ? AppTheme.duoGreen.withOpacity(0.1) : AppTheme.duoRed.withOpacity(0.1))
                    : Colors.transparent,
                  border: Border(
                    top: BorderSide(
                      color: _answered ? (_isCorrect ? AppTheme.duoGreen.withOpacity(0.3) : AppTheme.duoRed.withOpacity(0.3)) : Colors.white10, 
                      width: 1
                    )
                  ),
                ),
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_answered && !_isCorrect)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.duoRed.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.duoRed.withOpacity(0.4)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('CORRECT ANSWER:', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.2)),
                              const SizedBox(height: 8),
                              MathMarkdown(
                                data: _getCorrectAnswerText(slide), 
                                textStyle: const TextStyle(color: AppTheme.duoRed, fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    isInteractive && !_answered
                        ? DuoButton(
                            text: 'CHECK',
                            color: _canCheck(slide) ? AppTheme.duoGreen : const Color(0xFF334155),
                            shadowColor: _canCheck(slide) ? AppTheme.duoGreenDark : const Color(0xFF1E293B),
                            onPressed: () {
                              if (_canCheck(slide)) _checkAnswer(slide);
                            },
                          )
                        : DuoButton(
                            text: _answered && !_isCorrect ? 'GOT IT' : 'CONTINUE',
                            color: _answered && !_isCorrect ? AppTheme.duoRed : AppTheme.duoGreen, // React defaults to green for continue
                            shadowColor: _answered && !_isCorrect ? AppTheme.duoRedDark : AppTheme.duoGreenDark,
                            onPressed: _nextSlide,
                          ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}