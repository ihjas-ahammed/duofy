import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/global_state.dart';
import '../services/progress_service.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import '../widgets/slide_views/theory_view.dart';
import '../widgets/slide_views/quiz_view.dart';
import '../widgets/slide_views/fill_in_blank_view.dart';
import '../widgets/slide_views/numerical_view.dart';
import '../widgets/slide_views/interactive_webview.dart';
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

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _buildSlideQueue();
  }

  void _buildSlideQueue() {
    _slideQueue = [];
    Slide? prevTheory;
    
    // Group adjacent theory slides into a single "theory_group" slide separated by ---
    for (var slide in widget.lesson.slides) {
      if (slide.type == 'theory') {
        if (prevTheory != null) {
          _slideQueue.add(prevTheory.copyWith(
            id: '${prevTheory.id}_${slide.id}',
            content: '${prevTheory.content}\n\n---\n\n${slide.content}',
          ));
          prevTheory = null; // Grouped, reset
        } else {
          prevTheory = slide;
        }
      } else {
        if (prevTheory != null) {
          _slideQueue.add(prevTheory);
          prevTheory = null;
        }
        _slideQueue.add(slide);
      }
    }
    
    if (prevTheory != null) {
      _slideQueue.add(prevTheory);
    }

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
    int xpEarned = 15;

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
      case 'interactive_canvas':
        return InteractiveWebview(slide: slide);
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
        return TheoryView(slide: slide);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_slideQueue.isEmpty) {
      return Scaffold(appBar: AppBar(), body: const Center(child: Text("Empty Lesson")));
    }

    final slide = _slideQueue[_currentIndex];
    final progress = (_currentIndex) / _slideQueue.length;
    final isInteractive = ['quiz', 'fill_in_blank', 'numerical'].contains(slide.type);
    final hasCustomBar = _isCustomBottomBar(slide);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: () => Navigator.pop(context),
        ),
        title: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white12,
          color: AppTheme.duoGreen,
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (slide.title.isNotEmpty && !hasCustomBar)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Text(
                  slide.title, 
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            
            Expanded(child: _buildSlideContent(slide)),
            
            if (!hasCustomBar)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: _answered 
                    ? (_isCorrect ? AppTheme.duoGreen.withOpacity(0.15) : AppTheme.duoRed.withOpacity(0.15))
                    : Colors.transparent,
                  border: Border(top: BorderSide(
                    color: _answered ? (_isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.white10, 
                    width: 2)
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_answered && !_isCorrect)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.duoRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.duoRed.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('CORRECT ANSWER:', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.2)),
                              const SizedBox(height: 4),
                              MathMarkdown(
                                data: _getCorrectAnswerText(slide), 
                                textStyle: const TextStyle(color: AppTheme.duoRed, fontSize: 16, fontWeight: FontWeight.bold)
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    isInteractive && !_answered
                        ? DuoButton(
                            text: 'Check',
                            color: _canCheck(slide) ? AppTheme.duoGreen : Colors.grey.shade700,
                            shadowColor: _canCheck(slide) ? AppTheme.duoGreenDark : Colors.grey.shade800,
                            onPressed: () {
                              if (_canCheck(slide)) _checkAnswer(slide);
                            },
                          )
                        : DuoButton(
                            text: _answered && !_isCorrect ? 'Got It' : 'Continue',
                            color: _answered && !_isCorrect ? AppTheme.duoRed : AppTheme.duoBlue,
                            shadowColor: _answered && !_isCorrect ? AppTheme.duoRedDark : AppTheme.duoBlueDark,
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