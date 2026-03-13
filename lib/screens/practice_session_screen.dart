import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/global_state.dart';
import '../widgets/duo_button.dart';
import '../widgets/slide_views/quiz_view.dart';
import '../widgets/slide_views/fill_in_blank_view.dart';
import '../widgets/slide_views/numerical_view.dart';
import 'lesson_complete_screen.dart';

class PracticeSessionScreen extends StatefulWidget {
  final Book book;

  const PracticeSessionScreen({super.key, required this.book});

  @override
  State<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends State<PracticeSessionScreen> {
  List<Slide> _queue = [];
  int _totalQuestions = 0;
  int _completedQuestions = 0;
  
  bool _answered = false;
  bool _isCorrect = false;
  
  late DateTime _startTime;
  int _mistakesMade = 0;

  String? _selectedQuizOption;
  String _blankInput = '';
  String _numericInput = '';

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _extractInteractiveSlides();
  }

  void _extractInteractiveSlides() {
    List<Slide> pool = [];
    for (var module in widget.book.modules) {
      pool.addAll(module.practiceQuestions);
    }
    if (pool.isEmpty) {
      for (var module in widget.book.modules) {
        for (var section in module.sections) {
          for (var unit in section.units) {
            for (var lesson in unit.lessons) {
              for (var slide in lesson.slides) {
                if (['quiz', 'fill_in_blank', 'numerical'].contains(slide.type)) {
                  pool.add(slide);
                }
              }
            }
          }
        }
      }
    }
    
    pool.shuffle();
    // Take up to 5 questions for a session
    if (pool.length > 5) {
      _queue = pool.sublist(0, 5);
    } else {
      _queue = pool;
    }
    _totalQuestions = _queue.length;
  }

  Future<void> _finishPractice() async {
    int timeSpent = DateTime.now().difference(_startTime).inSeconds;
    int accuracy = _totalQuestions > 0 ? (((_totalQuestions) / (_totalQuestions + _mistakesMade)) * 100).round() : 100;
    int xpEarned = 10; 

    await GlobalState.addXp(xpEarned);

    if (mounted) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => LessonCompleteScreen(
          xpEarned: xpEarned,
          accuracy: accuracy,
          timeSpentSeconds: timeSpent,
          isPractice: true, 
        ))
      );
    }
  }

  void _processNext() {
    if (_isCorrect) {
      _completedQuestions++;
      _queue.removeAt(0); // Pop correct answer
    } else {
      _mistakesMade++;
      // Move to back of the queue to repeat later
      final slide = _queue.removeAt(0);
      _queue.add(slide);
    }

    if (_queue.isEmpty) {
      _finishPractice();
    } else {
      setState(() {
        _answered = false;
        _isCorrect = false;
        _selectedQuizOption = null;
        _blankInput = '';
        _numericInput = '';
      });
    }
  }

  void _checkAnswer() {
    final slide = _queue.first;
    bool correct = false;

    if (slide.type == 'quiz' && _selectedQuizOption != null) {
      correct = slide.options!.firstWhere((o) => o.id == _selectedQuizOption).isCorrect;
    } else if (slide.type == 'fill_in_blank') {
      correct = _blankInput.trim().toLowerCase() == slide.blankAnswer?.toLowerCase().replaceAll(r'\', '');
    } else if (slide.type == 'numerical') {
      final val = double.tryParse(_numericInput);
      if (val != null && slide.numericAnswer != null) {
        correct = (val - slide.numericAnswer!).abs() <= (slide.numericTolerance ?? 0.01);
      }
    }

    setState(() {
      _answered = true;
      _isCorrect = correct;
    });
  }

  bool _canCheck() {
    if (_queue.isEmpty) return false;
    final slide = _queue.first;
    if (slide.type == 'quiz') return _selectedQuizOption != null;
    if (slide.type == 'fill_in_blank') return _blankInput.trim().isNotEmpty;
    if (slide.type == 'numerical') return _numericInput.trim().isNotEmpty;
    return false;
  }

  Widget _buildContent(Slide slide) {
    if (slide.type == 'quiz') {
      return QuizView(
        slide: slide,
        selectedOptionId: _selectedQuizOption,
        isAnswered: _answered,
        onSelect: (id) => setState(() => _selectedQuizOption = id),
      );
    } else if (slide.type == 'fill_in_blank') {
      return FillInBlankView(
        slide: slide,
        value: _blankInput,
        isAnswered: _answered,
        isCorrect: _isCorrect,
        onChanged: (val) => setState(() => _blankInput = val),
      );
    } else if (slide.type == 'numerical') {
      return NumericalView(
        slide: slide,
        value: _numericInput,
        isAnswered: _answered,
        isCorrect: _isCorrect,
        onChanged: (val) => setState(() => _numericInput = val),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    if (_queue.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('No practice questions available.')),
      );
    }

    final slide = _queue.first;
    final progress = _totalQuestions == 0 ? 0.0 : (_completedQuestions / _totalQuestions);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: () => Navigator.pop(context),
        ),
        title: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white12,
          color: AppTheme.duoViolet,
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                slide.title.toUpperCase(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppTheme.duoViolet, letterSpacing: 1.5),
              ),
            ),
            
            Expanded(child: _buildContent(slide)),
            
            // Bottom Action Bar
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
                  if (_answered)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed, shape: BoxShape.circle),
                            child: Icon(_isCorrect ? LucideIcons.check : LucideIcons.x, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _isCorrect ? 'Excellent!' : 'Incorrect.',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  !_answered
                      ? DuoButton(
                          text: 'Check',
                          color: _canCheck() ? AppTheme.duoGreen : Colors.grey.shade700,
                          shadowColor: _canCheck() ? AppTheme.duoGreenDark : Colors.grey.shade800,
                          onPressed: () {
                            if (_canCheck()) _checkAnswer();
                          },
                        )
                      : DuoButton(
                          text: _answered && !_isCorrect ? 'Got It' : 'Continue',
                          color: _answered && !_isCorrect ? AppTheme.duoRed : AppTheme.duoBlue,
                          shadowColor: _answered && !_isCorrect ? AppTheme.duoRedDark : AppTheme.duoBlueDark,
                          onPressed: _processNext,
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