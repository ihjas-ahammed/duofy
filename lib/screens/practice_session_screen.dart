import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/global_state.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import '../widgets/responsive_center.dart';
import '../widgets/slide_views/quiz_view.dart';
import '../widgets/slide_views/fill_in_blank_view.dart';
import '../widgets/slide_views/numerical_view.dart';
import '../widgets/slide_views/one_word_view.dart';
import '../widgets/slide_views/interactive_proof_view.dart';
import '../widgets/slide_views/pyq_one_word_view.dart';
import '../widgets/slide_views/descriptive_view.dart';
import '../services/ai_service.dart';
import '../services/progress_service.dart';
import 'pyq_complete_screen.dart';
import 'lesson_complete_screen.dart';

class PracticeSessionScreen extends StatefulWidget {
  final Book book;
  final String practiceType;
  /// When non-null and non-empty, the practice pool is drawn only from
  /// lessons belonging to these unit ids (set on the Practice screen via the
  /// unit-range selector). Null/empty keeps the original whole-book behaviour.
  final List<String>? unitIds;
  final int? pyqOneWordCount;
  final int? pyqProofCount;

  const PracticeSessionScreen({
    super.key,
    required this.book,
    required this.practiceType,
    this.unitIds,
    this.pyqOneWordCount,
    this.pyqProofCount,
  });

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
  String _wordInput = '';
  
  // PYQ practice tracking
  final List<Map<String, dynamic>> _pyqSessionAnswers = [];
  Map<int, String> _pyqOneWordInputs = {};

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _extractInteractiveSlides();
  }

  void _extractInteractiveSlides() {
    final unitFilter = widget.unitIds;
    
    if (widget.practiceType == 'pyq') {
      List<Slide> pyqs = [];
      final wanted = unitFilter?.toSet();
      for (var module in widget.book.modules) {
        for (var section in module.sections) {
          final isSelected = wanted == null || section.units.any((u) => wanted.contains(u.id));
          if (isSelected) {
            pyqs.addAll(section.pyqQuestions);
          }
        }
      }

      // Filter duplicates by content
      final List<Slide> uniquePyqs = [];
      final Set<String> seen = {};
      for (final q in pyqs) {
        if (seen.add(q.content.trim().toLowerCase())) {
          uniquePyqs.add(q);
        }
      }

      final oneWordPool = uniquePyqs.where((q) => q.type == 'one_word').toList()..shuffle();
      final proofPool = uniquePyqs.where((q) => q.type == 'proof').toList()..shuffle();

      final int oneWordCount = widget.pyqOneWordCount ?? 5;
      final int proofCount = widget.pyqProofCount ?? 2;

      final selectedOneWord = oneWordPool.sublist(0, oneWordCount.clamp(0, oneWordPool.length));
      final selectedProof = proofPool.sublist(0, proofCount.clamp(0, proofPool.length));

      _queue = [...selectedOneWord, ...selectedProof]..shuffle();
      _totalQuestions = _queue.length;
      return;
    }

    List<Slide> pool = [];
    final bool hasFilter = unitFilter != null && unitFilter.isNotEmpty;

    if (hasFilter) {
      // Range-scoped practice: pull only from lessons in the selected units.
      final wanted = unitFilter.toSet();
      for (var module in widget.book.modules) {
        for (var section in module.sections) {
          for (var unit in section.units) {
            if (!wanted.contains(unit.id)) continue;
            for (var lesson in unit.lessons) {
              for (var slide in lesson.slides) {
                if (_isTargetType(slide.type)) pool.add(slide);
              }
            }
          }
        }
      }
    } else {
      // Scan curated practice questions in modules first.
      for (var module in widget.book.modules) {
        for (var slide in module.practiceQuestions) {
          if (_isTargetType(slide.type)) pool.add(slide);
        }
      }

      // If still empty, scan all lessons.
      if (pool.isEmpty) {
        for (var module in widget.book.modules) {
          for (var section in module.sections) {
            for (var unit in section.units) {
              for (var lesson in unit.lessons) {
                for (var slide in lesson.slides) {
                  if (_isTargetType(slide.type)) pool.add(slide);
                }
              }
            }
          }
        }
      }
    }

    pool.shuffle();
    if (pool.length > 5) {
      _queue = pool.sublist(0, 5);
    } else {
      _queue = pool;
    }
    _totalQuestions = _queue.length;
  }

  bool _isTargetType(String slideType) {
    if (widget.practiceType == 'quiz' && slideType == 'quiz') return true;
    if (widget.practiceType == 'proof' && slideType == 'proof') return true;
    if (widget.practiceType == 'step_by_step' && (slideType == 'step_by_step' || slideType == 'proof')) return true;
    if (widget.practiceType == 'fill_in_blank' && slideType == 'fill_in_blank') return true;
    if (widget.practiceType == 'one_word' && slideType == 'one_word') return true;
    if (widget.practiceType == 'numerical' && slideType == 'numerical') return true;
    return false;
  }

  Future<void> _finishPractice() async {
    int timeSpent = DateTime.now().difference(_startTime).inSeconds;
    int xpEarned = 10; 

    if (widget.practiceType == 'pyq') {
      // Show loading spinner
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const Center(
          child: CircularProgressIndicator(color: AppTheme.duoBlue),
        ),
      );

      final List<Map<String, dynamic>> answersToGrade = [];
      int idx = 0;
      for (final record in _pyqSessionAnswers) {
        final slide = record['slide'] as Slide;
        final answersMap = record['userAnswers'] as Map<int, String>;
        final steps = slide.interactiveSteps ?? [];
        
        if (steps.isEmpty) {
          answersToGrade.add({
            'index': idx++,
            'question': slide.content,
            'correctAnswer': slide.blankAnswer ?? '',
            'userAnswer': answersMap[0] ?? '',
          });
        } else {
          for (int i = 0; i < steps.length; i++) {
            answersToGrade.add({
              'index': idx++,
              'question': steps[i].prompt ?? slide.content,
              'correctAnswer': steps[i].stepText ?? '',
              'userAnswer': answersMap[i] ?? '',
            });
          }
        }
      }

      List<Map<String, dynamic>> gradedResults = [];
      try {
        if (answersToGrade.isNotEmpty) {
          final results = await AiService().gradePyqAnswers(answersToGrade: answersToGrade);
          for (final r in results) {
            final int index = r['index'] is int ? r['index'] : int.parse(r['index'].toString());
            final matchingInput = answersToGrade.firstWhere((element) => element['index'] == index);
            gradedResults.add({
              'question': matchingInput['question'],
              'correctAnswer': matchingInput['correctAnswer'],
              'userAnswer': matchingInput['userAnswer'],
              'isCorrect': r['isCorrect'],
              'explanation': r['explanation'],
            });
          }
        }
      } catch (e) {
        print("Error grading answers: $e");
        // Fallback exact match
        for (final input in answersToGrade) {
          final userAns = input['userAnswer'].toString().trim().toLowerCase();
          final correctAns = input['correctAnswer'].toString().trim().toLowerCase();
          final isCorrect = userAns == correctAns;
          gradedResults.add({
            'question': input['question'],
            'correctAnswer': input['correctAnswer'],
            'userAnswer': input['userAnswer'],
            'isCorrect': isCorrect,
            'explanation': isCorrect ? 'Exact match' : 'Incorrect answer.',
          });
        }
      }

      // Hide loading spinner
      if (mounted) {
        Navigator.pop(context);
      }

      await GlobalState.addXp(xpEarned, widget.book.id);

      int correctCount = gradedResults.where((r) => r['isCorrect'] == true).length;
      int pyqAccuracy = gradedResults.isNotEmpty ? ((correctCount / gradedResults.length) * 100).round() : 100;
      await ProgressService.logActivity(
        courseId: widget.book.id,
        lessonId: 'practice_pyq',
        activityType: 'practice',
        xp: xpEarned,
        timeSpent: timeSpent,
        accuracy: pyqAccuracy,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (_) => PyqCompleteScreen(
            gradedResults: gradedResults,
            timeSpentSeconds: timeSpent,
            xpEarned: xpEarned,
          ))
        );
      }
      return;
    }

    int accuracy = _totalQuestions > 0 ? (((_totalQuestions) / (_totalQuestions + _mistakesMade)) * 100).round() : 100;
    await GlobalState.addXp(xpEarned, widget.book.id);

    await ProgressService.logActivity(
      courseId: widget.book.id,
      lessonId: 'practice_${widget.practiceType}',
      activityType: 'practice',
      xp: xpEarned,
      timeSpent: timeSpent,
      accuracy: accuracy,
    );

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

  void _processNextPyqOneWord() {
    final slide = _queue.first;
    _pyqSessionAnswers.add({
      'slide': slide,
      'userAnswers': Map<int, String>.from(_pyqOneWordInputs),
    });

    _completedQuestions++;
    _queue.removeAt(0);

    if (_queue.isEmpty) {
      _finishPractice();
    } else {
      setState(() {
        _answered = false;
        _isCorrect = false;
        _selectedQuizOption = null;
        _blankInput = '';
        _numericInput = '';
        _wordInput = '';
        _pyqOneWordInputs = {};
      });
    }
  }

  void _processNext() {
    if (_isCorrect) {
      _completedQuestions++;
      _queue.removeAt(0); 
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
        _wordInput = '';
      });
    }
  }

  void _checkAnswer() {
    final slide = _queue.first;
    bool correct = false;

    if (slide.type == 'quiz' && _selectedQuizOption != null) {
      final selectedOpt = slide.options!.firstWhere((o) => o.id == _selectedQuizOption);
      correct = selectedOpt.isCorrect;
      
      // Fallback robust check
      if (!correct) {
        final correctOpts = slide.options!.where((o) => o.isCorrect);
        if (correctOpts.any((c) => c.text.trim().toLowerCase() == selectedOpt.text.trim().toLowerCase())) {
          correct = true;
        }
      }
    } else if (slide.type == 'fill_in_blank') {
      final userParts = _blankInput.split(',').map((s) => s.trim().toLowerCase().replaceAll(r'\', '')).toList();
      final correctParts = (slide.blankAnswer ?? '').split(',').map((s) => s.trim().toLowerCase().replaceAll(r'\', '')).toList();
      if (userParts.length == correctParts.length) {
        correct = true;
        for (int i = 0; i < userParts.length; i++) {
          if (userParts[i] != correctParts[i]) {
            correct = false;
            break;
          }
        }
      } else {
        correct = false;
      }
    } else if (slide.type == 'one_word') {
      correct = _wordInput.trim().toLowerCase() == (slide.blankAnswer ?? '').trim().toLowerCase().replaceAll(r'\', '');
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
    if (slide.type == 'one_word') return _wordInput.trim().isNotEmpty;
    if (slide.type == 'numerical') return _numericInput.trim().isNotEmpty;
    return false;
  }

  bool get _isCustomBottomBar {
    if (_queue.isEmpty) return false;
    final slide = _queue.first;
    final type = slide.type;
    if (widget.practiceType == 'pyq' && type == 'one_word') {
      return true; // Render a custom bottom bar for PYQ one-word slides
    }
    return type == 'proof' || type == 'step_by_step' || type == 'descriptive';
  }

  String _getCorrectAnswerText(Slide slide) {
    if (slide.type == 'quiz') {
      final opt = slide.options?.firstWhere((o) => o.isCorrect, orElse: () => slide.options!.first);
      return opt?.text ?? '';
    }
    if (slide.type == 'fill_in_blank') return slide.blankAnswer ?? '';
    if (slide.type == 'one_word') return slide.blankAnswer ?? '';
    if (slide.type == 'numerical') return slide.numericAnswer?.toString() ?? '';
    return '';
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
    } else if (slide.type == 'one_word') {
      if (widget.practiceType == 'pyq') {
        return PyqOneWordView(
          slide: slide,
          values: _pyqOneWordInputs,
          onChanged: (idx, val) => setState(() => _pyqOneWordInputs[idx] = val),
        );
      }
      return OneWordView(
        slide: slide,
        value: _wordInput,
        isAnswered: _answered,
        isCorrect: _isCorrect,
        onChanged: (val) => setState(() => _wordInput = val),
      );
    } else if (slide.type == 'descriptive') {
      return DescriptiveView(
        slide: slide,
        onComplete: () {
          HapticFeedback.heavyImpact();
          setState(() {
            _isCorrect = true;
            _answered = true;
          });
          _processNext();
        },
      );
    } else if (slide.type == 'proof' || slide.type == 'step_by_step') {
      return InteractiveProofView(
        slide: slide,
        onComplete: () {
          HapticFeedback.heavyImpact();
          setState(() {
            _isCorrect = true;
            _answered = true;
          });
          _processNext();
        },
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    if (_queue.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('No practice questions available for this type.', style: TextStyle(color: Colors.white54))),
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
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.reading,
        child: SafeArea(
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
            
            // Native Bottom Action Bar (hide if child implements its own)
            if (!_isCustomBottomBar)
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
              ),

            // PYQ One Word Action Bar
            if (widget.practiceType == 'pyq' && slide.type == 'one_word')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: DuoButton(
                  text: 'Continue',
                  color: AppTheme.duoBlue,
                  shadowColor: AppTheme.duoBlueDark,
                  onPressed: _processNextPyqOneWord,
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
}