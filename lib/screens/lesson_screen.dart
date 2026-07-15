import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/database_service.dart';
import '../services/generation_manager.dart';
import '../services/global_state.dart';
import '../services/progress_service.dart';
import '../services/bookmark_service.dart';
import '../services/metacognition_service.dart';
import '../widgets/canvas_art_view.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import '../widgets/responsive_center.dart';
import '../widgets/slide_views/quiz_view.dart';
import '../widgets/slide_views/fill_in_blank_view.dart';
import '../widgets/slide_views/numerical_view.dart';
import '../widgets/slide_views/one_word_view.dart';
import '../widgets/slide_views/interactive_proof_view.dart';
import '../widgets/slide_views/theory_view.dart';
import '../widgets/slide_views/concept_pieces_view.dart';
import '../widgets/slide_views/descriptive_view.dart';
import '../widgets/slide_views/custom_html_view.dart';
import '../widgets/slide_views/matching_view.dart';
import '../widgets/slide_views/ordering_view.dart';
import '../widgets/slide_views/error_spotting_view.dart';
import '../widgets/slide_views/flashcard_view.dart';
import '../widgets/lesson_assistant_chat.dart';
import 'lesson_complete_screen.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;

  /// The following are optional because callers in older paths (e.g. quick
  /// preview from a non-dashboard surface) may not know them. When all four
  /// are non-null the in-lesson canvas regenerate button is wired up.
  final Book? book;
  final int? modIdx;
  final int? secIdx;
  final int? unitIdx;
  final int? lessonIdx;

  final String? initialSlideId;

  const LessonScreen({
    super.key,
    required this.lesson,
    this.book,
    this.modIdx,
    this.secIdx,
    this.unitIdx,
    this.lessonIdx,
    this.initialSlideId,
  });

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
  final Set<String> _failedCanvasIds = {};

  /// How many times each interactive slide has been answered wrong, keyed by
  /// slide id. Drives the "retry once, then skip" flow and ensures any failure
  /// permanently counts against final accuracy.
  final Map<String, int> _failCounts = {};
  List<Slide> _slideQueue = [];

  /// High-water mark for the header progress bar. Wrong answers requeue
  /// slides (growing the denominator), which used to visibly yank the bar
  /// backwards — clamp it so progress only ever moves forward.
  double _maxProgress = 0;

  /// Live copy of the lesson. Starts as the one we were constructed with and
  /// gets refreshed whenever [GenerationManager] notifies — this is how the
  /// background canvas-art pass and the user-triggered regenerate button
  /// reach this screen without it being popped/rebuilt.
  late Lesson _lesson;

  String? _selectedQuizOption;
  String _blankInput = '';
  String _numericInput = '';
  String _wordInput = '';
  // Left pair index -> right pair index; correct when key == value.
  Map<int, int> _matchingAssignments = {};
  List<String> _orderingCurrent = [];
  int? _errorSelection;

  /// Self-rated confidence (MetacognitionService constants) for the current
  /// slide, chosen before checking. Null = not rated (rating is optional).
  int? _confidence;

  /// Slides whose FIRST attempt was already logged to the metacognition
  /// service — wrong answers requeue slides, and only the first attempt may
  /// count for calibration and review scheduling.
  final Set<String> _attemptedSlideIds = {};

  bool _isEditingMode = false;
  bool _isBookmarked = false;
  final TextEditingController _editController = TextEditingController();

  /// Bookmarking needs the owning course so the lesson can be re-opened from
  /// the bookmarks window later.
  bool get _canBookmark => widget.book != null;

  bool get _canRegenerateCanvas =>
      widget.book != null &&
      widget.modIdx != null &&
      widget.secIdx != null &&
      widget.unitIdx != null &&
      widget.lessonIdx != null &&
      GlobalState.developerModeNotifier.value;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _lesson = widget.lesson;
    _buildSlideQueue();
    if (widget.initialSlideId != null) {
      final index = _slideQueue.indexWhere(
        (s) => s.id == widget.initialSlideId,
      );
      if (index != -1) {
        _currentIndex = index;
      }
    }
    GenerationManager.instance.addListener(_onGenerationManagerChange);
    // Pull the latest from cache once on open in case background art landed
    // between the dashboard build and this screen mounting.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _refreshFromCache();
        if (_canRegenerateCanvas) {
          _triggerBackgroundCanvasGeneration();
        }
        _checkAndPromptNextUnitGeneration();
      }
    });
    // Bookmark state + stamp last-opened time if this lesson is bookmarked.
    _loadBookmarkState();
    BookmarkService.markOpened(widget.lesson.id);
  }

  void _checkAndPromptNextUnitGeneration() {
    if (widget.book == null ||
        widget.modIdx == null ||
        widget.secIdx == null ||
        widget.unitIdx == null)
      return;

    final book = widget.book!;
    final modIdx = widget.modIdx!;
    final secIdx = widget.secIdx!;
    final unitIdx = widget.unitIdx!;

    Unit? nextUnit;
    int nextModIdx = modIdx;
    int nextSecIdx = secIdx;
    int nextUnitIdx = unitIdx + 1;

    // Check current section
    if (nextUnitIdx < book.modules[modIdx].sections[secIdx].units.length) {
      nextUnit = book.modules[modIdx].sections[secIdx].units[nextUnitIdx];
    } else {
      // Check next section in current module
      nextSecIdx = secIdx + 1;
      nextUnitIdx = 0;
      if (nextSecIdx < book.modules[modIdx].sections.length) {
        if (book.modules[modIdx].sections[nextSecIdx].units.isNotEmpty) {
          nextUnit =
              book.modules[modIdx].sections[nextSecIdx].units[nextUnitIdx];
        }
      } else {
        // Check next module
        nextModIdx = modIdx + 1;
        nextSecIdx = 0;
        nextUnitIdx = 0;
        if (nextModIdx < book.modules.length) {
          if (book.modules[nextModIdx].sections.isNotEmpty &&
              book.modules[nextModIdx].sections.first.units.isNotEmpty) {
            nextUnit = book.modules[nextModIdx].sections.first.units.first;
          }
        }
      }
    }

    if (nextUnit != null && !nextUnit.isGenerated) {
      final inQueue = GenerationManager.instance.queue.any(
        (t) =>
            t.unitId == nextUnit!.id &&
            (t.status == 'queued' || t.status == 'running'),
      );
      if (inQueue) return;

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: context.colors.surface,
          title: Text(
            'Generate Next Unit?',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'The next unit "${nextUnit!.title}" is not generated yet.\n\n'
            'Would you like to auto-generate it in the background now so it is ready when you get there?',
            style: TextStyle(color: context.colors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'Later',
                style: TextStyle(color: context.colors.textFaint),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                GenerationManager.instance.startUnitGeneration(
                  nextUnit!,
                  book,
                  nextModIdx,
                  nextSecIdx,
                  nextUnitIdx,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Generation for "${nextUnit.title}" started in the background.',
                    ),
                    backgroundColor: AppTheme.duoBlue,
                  ),
                );
              },
              child: const Text(
                'Generate',
                style: TextStyle(
                  color: AppTheme.duoBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _triggerBackgroundCanvasGeneration() {
    if (widget.book == null ||
        widget.modIdx == null ||
        widget.secIdx == null ||
        widget.unitIdx == null ||
        widget.lessonIdx == null)
      return;

    final book = widget.book!;
    final modIdx = widget.modIdx!;
    final secIdx = widget.secIdx!;
    final unitIdx = widget.unitIdx!;
    final lessonIdx = widget.lessonIdx!;
    final lesson = _lesson;

    // Trigger lesson canvas if prompt is present but SVG is empty
    if ((lesson.canvasPrompt?.trim().isNotEmpty ?? false) &&
        (lesson.canvasSvg?.trim().isEmpty ?? true)) {
      GenerationManager.instance.regenerateLessonCanvas(
        book: book,
        modIdx: modIdx,
        secIdx: secIdx,
        unitIdx: unitIdx,
        lessonIdx: lessonIdx,
      );
    }

    // Trigger slide canvas for any slide that has a prompt but no SVG
    for (int i = 0; i < lesson.slides.length; i++) {
      final s = lesson.slides[i];
      if ((s.canvasPrompt?.trim().isNotEmpty ?? false) &&
          (s.canvasSvg?.trim().isEmpty ?? true)) {
        GenerationManager.instance.regenerateSlideCanvas(
          book: book,
          modIdx: modIdx,
          secIdx: secIdx,
          unitIdx: unitIdx,
          lessonIdx: lessonIdx,
          slideIdx: i,
        );
      }
    }
  }

  Future<void> _loadBookmarkState() async {
    final marked = await BookmarkService.isBookmarked(widget.lesson.id);
    if (mounted) setState(() => _isBookmarked = marked);
  }

  Future<void> _toggleBookmark() async {
    if (!_canBookmark) return;
    final nowBookmarked = await BookmarkService.toggle(
      bookId: widget.book!.id,
      bookTitle: widget.book!.title,
      lessonId: widget.lesson.id,
      lessonTitle: widget.lesson.title,
    );
    if (!mounted) return;
    setState(() => _isBookmarked = nowBookmarked);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surface,
        duration: const Duration(seconds: 2),
        content: Text(
          nowBookmarked ? 'Lesson bookmarked' : 'Bookmark removed',
          style: TextStyle(color: context.colors.textPrimary),
        ),
      ),
    );
  }

  @override
  void dispose() {
    GenerationManager.instance.removeListener(_onGenerationManagerChange);
    _editController.dispose();
    super.dispose();
  }

  void _onGenerationManagerChange() {
    if (!mounted) return;
    setState(() {});
    _refreshFromCache();
  }

  Future<void> _refreshFromCache() async {
    if (!_canRegenerateCanvas) return;
    try {
      final fresh = await DatabaseService().getBookFromCache(widget.book!.id);
      if (fresh == null || !mounted) return;

      Lesson? lesson;
      final mIdx = widget.modIdx!;
      final sIdx = widget.secIdx!;
      final uIdx = widget.unitIdx!;
      final lIdx = widget.lessonIdx!;

      if (mIdx < fresh.modules.length) {
        final mod = fresh.modules[mIdx];
        if (sIdx < mod.sections.length) {
          final sec = mod.sections[sIdx];
          if (uIdx < sec.units.length) {
            final un = sec.units[uIdx];
            if (lIdx < un.lessons.length) {
              lesson = un.lessons[lIdx];
            }
          }
        }
      }

      if (lesson == null) {
        // Fallback search by ID
        for (final mod in fresh.modules) {
          for (final sec in mod.sections) {
            for (final un in sec.units) {
              for (final les in un.lessons) {
                if (les.id == _lesson.id) {
                  lesson = les;
                  break;
                }
              }
            }
          }
        }
      }

      if (lesson == null) return;

      setState(() {
        _lesson = lesson!;
        _failedCanvasIds.remove(lesson.id);

        // Update elements in _slideQueue in-place to reflect updated slide contents
        final freshSlidesMap = {for (var s in lesson.slides) s.id: s};
        for (int i = 0; i < _slideQueue.length; i++) {
          final currentSlide = _slideQueue[i];
          final freshSlide = freshSlidesMap[currentSlide.id];
          if (freshSlide != null) {
            _slideQueue[i] = freshSlide;
          }
        }
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _triggerBackgroundCanvasGeneration();
        }
      });
    } catch (e) {
      debugPrint('[LessonScreen] _refreshFromCache failed: $e');
    }
  }

  void _buildSlideQueue() {
    _slideQueue = List.of(_lesson.slides);
    _maxProgress = 0;

    for (var slide in _slideQueue) {
      if ([
        'quiz',
        'fill_in_blank',
        'one_word',
        'numerical',
        'proof',
        'step_by_step',
        'descriptive',
        'custom_html',
        'matching',
        'ordering',
        'error_spotting',
        'flashcard',
      ].contains(slide.type)) {
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
        _wordInput = '';
        _matchingAssignments = {};
        _orderingCurrent = [];
        _errorSelection = null;
        _confidence = null;
      });
    } else {
      _finishLesson();
    }
  }

  Future<void> _finishLesson() async {
    int timeSpent = DateTime.now().difference(_startTime).inSeconds;
    int accuracy = _totalInteractive > 0
        ? ((_correctAttempts / _totalInteractive) * 100).round()
        : 100;

    final courseId = widget.book?.id ?? 'unknown_course';
    bool isNewCompletion = !(await ProgressService.getCompletedLessons())
        .contains(widget.lesson.id);
    int xpEarned = isNewCompletion ? 20 : 5;

    await ProgressService.markLessonCompleted(widget.lesson.id, courseId);
    await GlobalState.addXp(xpEarned, courseId);

    await ProgressService.logActivity(
      courseId: courseId,
      lessonId: widget.lesson.id,
      activityType: 'lesson',
      xp: xpEarned,
      timeSpent: timeSpent,
      accuracy: accuracy,
    );

    if (widget.book != null) {
      final String currentLevel = widget.book!.bloomLevel;
      String newLevel = currentLevel;

      if (accuracy >= 80) {
        if (currentLevel == 'Remembering / Understanding') {
          newLevel = 'Applying / Analyzing';
        } else if (currentLevel == 'Applying / Analyzing') {
          newLevel = 'Evaluating / Creating';
        }
      } else if (accuracy < 50) {
        if (currentLevel == 'Evaluating / Creating') {
          newLevel = 'Applying / Analyzing';
        } else if (currentLevel == 'Applying / Analyzing') {
          newLevel = 'Remembering / Understanding';
        }
      }

      if (newLevel != currentLevel) {
        final updatedBook = widget.book!.copyWith(bloomLevel: newLevel);
        await DatabaseService().saveGeneratedBook(updatedBook);
        GenerationManager.instance.triggerBookUpdate(updatedBook);

        if (mounted) {
          final isPromotion = accuracy >= 80;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    isPromotion
                        ? LucideIcons.trendingUp
                        : LucideIcons.trendingDown,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isPromotion
                          ? "Metacognitive progression: Promoted to $newLevel!"
                          : "Scaffolding activated: Adapted to $newLevel.",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              backgroundColor: isPromotion
                  ? AppTheme.duoGreen
                  : AppTheme.duoOrange,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    }

    if (mounted) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LessonCompleteScreen(
            xpEarned: xpEarned,
            accuracy: accuracy,
            timeSpentSeconds: timeSpent,
            bookId: widget.book?.id,
            moduleId:
                (widget.book != null &&
                    widget.modIdx != null &&
                    widget.modIdx! >= 0 &&
                    widget.modIdx! < widget.book!.modules.length)
                ? widget.book!.modules[widget.modIdx!].id
                : null,
            book: widget.book,
            modIdx: widget.modIdx,
            secIdx: widget.secIdx,
            unitIdx: widget.unitIdx,
            lessonIdx: widget.lessonIdx,
          ),
        ),
      );
      if (mounted) {
        Navigator.pop(context, result);
      }
    }
  }

  void _checkAnswer(Slide slide) {
    bool correct = false;

    if (slide.type == 'quiz' && _selectedQuizOption != null) {
      final opt = slide.options!.firstWhere((o) => o.id == _selectedQuizOption);
      correct = opt.isCorrect;

      if (!correct) {
        final correctOpts = slide.options!.where((o) => o.isCorrect);
        if (correctOpts.any(
          (c) => c.text.trim().toLowerCase() == opt.text.trim().toLowerCase(),
        )) {
          correct = true;
        }
      }
    } else if (slide.type == 'fill_in_blank') {
      final userParts = _blankInput
          .split(',')
          .map((s) => s.trim().toLowerCase().replaceAll(r'\', ''))
          .toList();
      final correctParts = (slide.blankAnswer ?? '')
          .split(',')
          .map((s) => s.trim().toLowerCase().replaceAll(r'\', ''))
          .toList();
      if (userParts.length == correctParts.length) {
        correct = true;
        for (int i = 0; i < userParts.length; i++) {
          if (userParts[i] != correctParts[i]) {
            correct = false;
            break;
          }
        }
      } else {
        // Count mismatch (old cached slides generated before blank/answer
        // normalization): fall back to comparing the whole answer as one
        // string so the slide stays winnable.
        correct =
            userParts.join(' ').replaceAll(RegExp(r'\s+'), ' ') ==
            correctParts.join(' ').replaceAll(RegExp(r'\s+'), ' ');
      }
    } else if (slide.type == 'one_word') {
      correct =
          _wordInput.trim().toLowerCase() ==
          (slide.blankAnswer ?? '').trim().toLowerCase().replaceAll(r'\', '');
    } else if (slide.type == 'numerical') {
      final val = double.tryParse(_numericInput);
      if (val != null && slide.numericAnswer != null) {
        correct =
            (val - slide.numericAnswer!).abs() <=
            (slide.numericTolerance ?? 0.01);
      }
    } else if (slide.type == 'matching') {
      final pairs = slide.matchPairs ?? [];
      correct =
          pairs.isNotEmpty &&
          _matchingAssignments.length == pairs.length &&
          _matchingAssignments.entries.every((e) => e.key == e.value);
    } else if (slide.type == 'ordering') {
      final target = slide.orderItems ?? [];
      correct = target.isNotEmpty && _orderingCurrent.length == target.length;
      if (correct) {
        for (var i = 0; i < target.length; i++) {
          if (_orderingCurrent[i] != target[i]) {
            correct = false;
            break;
          }
        }
      }
    } else if (slide.type == 'error_spotting') {
      correct = _errorSelection != null && _errorSelection == slide.errorIndex;
    }

    setState(() {
      _answered = true;
      _isCorrect = correct;
      if (correct) _correctAttempts++;
    });

    if (!correct) {
      final fails = (_failCounts[slide.id] ?? 0) + 1;
      _failCounts[slide.id] = fails;
      // Every wrong answer adds one to the interactive total, so accuracy is
      // deducted even if the student later corrects it.
      _totalInteractive++;
      // First failure: requeue the slide so it reappears at the end. Second
      // failure: skip it entirely (don't requeue).
      if (fails < 2) {
        _slideQueue.add(slide);
      }
    }

    // Run haptics and telemetry logging in the next frame to prevent frame drops
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50), () {
        if (correct) {
          HapticFeedback.heavyImpact();
        } else {
          HapticFeedback.mediumImpact();
        }
      });
      _recordFirstAttempt(slide, correct);
    });
  }

  /// Logs the FIRST attempt at [slide] to the metacognition service (wrong
  /// answers requeue slides — repeats never count for calibration or review
  /// scheduling).
  void _recordFirstAttempt(Slide slide, bool correct) {
    if (_attemptedSlideIds.contains(slide.id)) return;
    _attemptedSlideIds.add(slide.id);
    MetacognitionService.recordAnswer(
      slide: slide,
      lessonId: widget.lesson.id,
      bookId: widget.book?.id ?? 'unknown_course',
      correct: correct,
      confidence: _confidence,
    );
  }

  bool _canCheck(Slide slide) {
    if (slide.type == 'quiz') return _selectedQuizOption != null;
    if (slide.type == 'fill_in_blank') return _blankInput.trim().isNotEmpty;
    if (slide.type == 'one_word') return _wordInput.trim().isNotEmpty;
    if (slide.type == 'numerical') return _numericInput.trim().isNotEmpty;
    if (slide.type == 'matching') {
      return _matchingAssignments.length == (slide.matchPairs?.length ?? 0) &&
          _matchingAssignments.isNotEmpty;
    }
    if (slide.type == 'ordering') return _orderingCurrent.isNotEmpty;
    if (slide.type == 'error_spotting') return _errorSelection != null;
    return true;
  }

  bool _isCustomBottomBar(Slide slide) {
    return slide.type == 'proof' ||
        slide.type == 'step_by_step' ||
        slide.type == 'descriptive' ||
        slide.type == 'custom_html' ||
        slide.type == 'flashcard';
  }

  String _getCorrectAnswerText(Slide slide) {
    if (slide.type == 'quiz') {
      final opt = slide.options?.firstWhere(
        (o) => o.isCorrect,
        orElse: () => slide.options!.first,
      );
      return opt?.text ?? '';
    }
    if (slide.type == 'fill_in_blank') return slide.blankAnswer ?? '';
    if (slide.type == 'one_word') return slide.blankAnswer ?? '';
    if (slide.type == 'numerical') return slide.numericAnswer?.toString() ?? '';
    if (slide.type == 'matching') {
      return (slide.matchPairs ?? [])
          .map((p) => '${p.left} → ${p.right}')
          .join('\n\n');
    }
    if (slide.type == 'ordering') {
      final items = slide.orderItems ?? [];
      return [
        for (var i = 0; i < items.length; i++) '${i + 1}. ${items[i]}',
      ].join('\n\n');
    }
    if (slide.type == 'error_spotting') {
      final steps = slide.proofSteps ?? [];
      final idx = slide.errorIndex ?? -1;
      return (idx >= 0 && idx < steps.length)
          ? 'Step ${idx + 1}: ${steps[idx]}'
          : '';
    }
    return '';
  }

  /// Lesson-level canvas widget. Returns SizedBox.shrink when the canvas
  /// has no prompt so callers can embed it unconditionally.
  Widget _buildLessonCanvas() {
    final hasFailed = _failedCanvasIds.contains(_lesson.id);
    return CanvasArtView(
      svg: _lesson.canvasSvg,
      hasPrompt: (_lesson.canvasPrompt?.trim().isNotEmpty ?? false),
      prompt: _lesson.canvasPrompt,
      isLoading: GenerationManager.instance.activeCanvasRegens.contains(
        _lesson.id,
      ),
      isStackedWithContent: !hasFailed,
      targetId: _lesson.id,
      onError: () {
        if (mounted) {
          setState(() {
            _failedCanvasIds.add(_lesson.id);
          });
        }
      },
      onRegenerate: _canRegenerateCanvas
          ? (err) => GenerationManager.instance.regenerateLessonCanvas(
              book: widget.book!,
              modIdx: widget.modIdx!,
              secIdx: widget.secIdx!,
              unitIdx: widget.unitIdx!,
              lessonIdx: widget.lessonIdx!,
              errorContext: err,
            )
          : null,
    );
  }

  /// Asks for an optional steering note, then regenerates [slide]'s content
  /// via the AI. The refreshed content lands through [_refreshFromCache] when
  /// the GenerationManager broadcasts the updated book.
  Future<void> _promptRegenerateSlide(Slide slide) async {
    final noteCtrl = TextEditingController();

    final slideTypes = {
      'theory': 'Theory Conceptual',
      'concept_pieces': 'Concept Pieces (Connected)',
      'quiz': 'Multiple Choice Quiz',
      'fill_in_blank': 'Fill In The Blank',
      'one_word': 'One Word Recall',
      'numerical': 'Numerical Calculation',
      'proof': 'Step-by-Step Proof',
      'descriptive': 'Descriptive Response',
      'custom_html': 'Custom HTML Page',
    };

    String selectedType = slide.type;
    if (!slideTypes.containsKey(selectedType)) {
      if (selectedType == 'theory_group') {
        selectedType = 'theory';
      } else if (selectedType == 'step_by_step') {
        selectedType = 'proof';
      } else {
        selectedType = 'theory';
      }
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: context.colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                'Regenerate this slide?',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'The AI will rewrite this slide using the source material. Optionally tell it what to change.',
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: noteCtrl,
                    maxLines: 2,
                    autofocus: true,
                    style: TextStyle(color: context.colors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Optional note — e.g. "make it simpler"',
                      hintStyle: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 12,
                      ),
                      filled: true,
                      fillColor: context.colors.surfaceAlt,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Slide Type:',
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    dropdownColor: context.colors.surface,
                    value: selectedType,
                    style: TextStyle(
                      color: context.colors.textPrimary,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: context.colors.surfaceAlt,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: slideTypes.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setStateDialog(() {
                          selectedType = val;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: context.colors.textFaint),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text(
                    'Regenerate',
                    style: TextStyle(
                      color: AppTheme.duoBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    final note = noteCtrl.text.trim();
    noteCtrl.dispose();
    if (confirmed != true || !_canRegenerateCanvas) return;

    final slideIdx = _lesson.slides.indexWhere((s) => s.id == slide.id);
    if (slideIdx < 0) return;

    // Show a loading dialog immediately
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppTheme.duoBlue),
            const SizedBox(height: 16),
            Text(
              'Regenerating slide...',
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );

    final size = MediaQuery.of(context).size;
    final screenSizeInfo =
        'Screen Width: ${size.width.toStringAsFixed(0)}px, Screen Height: ${size.height.toStringAsFixed(0)}px';

    try {
      await GenerationManager.instance.regenerateSlide(
        book: widget.book!,
        modIdx: widget.modIdx!,
        secIdx: widget.secIdx!,
        unitIdx: widget.unitIdx!,
        lessonIdx: widget.lessonIdx!,
        slideIdx: slideIdx,
        note: note.isEmpty ? null : note,
        targetType: selectedType,
        screenSizeInfo: screenSizeInfo,
      );

      if (mounted) {
        Navigator.of(context).pop(); // pop the loading dialog
      }
      await _refreshFromCache();
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // pop the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error regenerating slide: $e'),
            backgroundColor: AppTheme.duoRed,
          ),
        );
      }
    }
  }

  Future<void> _confirmExit() async {
    if (_currentIndex == 0 && _correctAttempts == 0) {
      Navigator.pop(context);
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Leave lesson?',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Your progress on this lesson won't be saved if you leave now.",
          style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Keep Learning',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Leave',
              style: TextStyle(
                color: AppTheme.duoRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) Navigator.pop(context);
  }

  Future<void> _promptDeleteSlide(Slide slide) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Delete this slide?',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to permanently delete this slide from this lesson? This cannot be undone.',
          style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: AppTheme.duoRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final slideIdx = _lesson.slides.indexWhere((s) => identical(s, slide));
    if (slideIdx < 0) return;

    final newSlides = List<Slide>.from(_lesson.slides)..removeAt(slideIdx);

    setState(() {
      _lesson = _lesson.copyWith(slides: newSlides);
      _slideQueue.removeWhere((s) => s.id == slide.id);

      if (_slideQueue.isEmpty) {
        Navigator.pop(context);
        return;
      }

      if (_currentIndex >= _slideQueue.length) {
        _currentIndex = _slideQueue.length - 1;
      }

      _answered = false;
      _isCorrect = false;
      _selectedQuizOption = null;
      _blankInput = '';
      _numericInput = '';
      _wordInput = '';
    });

    if (_canRegenerateCanvas) {
      await GenerationManager.instance.deleteSlide(
        book: widget.book!,
        modIdx: widget.modIdx!,
        secIdx: widget.secIdx!,
        unitIdx: widget.unitIdx!,
        lessonIdx: widget.lessonIdx!,
        slideIdx: slideIdx,
      );
    }
  }

  void _openAssistant() {
    String sectionNotes = "";
    if (widget.book != null && widget.modIdx != null && widget.secIdx != null) {
      try {
        final sec =
            widget.book!.modules[widget.modIdx!].sections[widget.secIdx!];
        final List<String> notesParts = [];
        for (var unit in sec.units) {
          for (var lesson in unit.lessons) {
            for (var slide in lesson.slides) {
              if (slide.type == 'theory' || slide.type == 'concept_pieces') {
                notesParts.add('**${slide.title}**\n${slide.content}');
              }
            }
          }
        }
        sectionNotes = notesParts.join('\n\n');
      } catch (e) {
        print("Error generating section notes: $e");
      }
    }

    if (sectionNotes.isEmpty) {
      sectionNotes = _lesson.slides
          .where((s) => s.type == 'theory' || s.type == 'concept_pieces')
          .map((s) => '**${s.title}**\n${s.content}')
          .join('\n\n');
    }

    final slide = _slideQueue[_currentIndex];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => LessonAssistantChat(
        book:
            widget.book ??
            Book(
              id: 'dummy',
              title: 'Lesson Course',
              description: '',
              icon: '',
              modules: [],
              lessonFormats: [],
              defaultFormatId: '',
            ),
        modIdx: widget.modIdx ?? 0,
        secIdx: widget.secIdx ?? 0,
        currentSlide: slide,
        sectionNotes: sectionNotes,
      ),
    );
  }

  /// Applies a slide edit coming from a child view (e.g. double-tap on an
  /// option or proof step). Updates the in-memory lesson and persists via
  /// GenerationManager so edits survive reloads.
  void _applySlideEdit(Slide updated) {
    final currentSlide = _slideQueue[_currentIndex];
    final lessonSlideIdx = _lesson.slides.indexWhere(
      (s) => identical(s, currentSlide),
    );
    if (lessonSlideIdx < 0) return;
    final newSlides = List<Slide>.from(_lesson.slides);
    newSlides[lessonSlideIdx] = updated;
    setState(() {
      _lesson = _lesson.copyWith(slides: newSlides);
      _slideQueue[_currentIndex] = updated;
    });
    if (_canRegenerateCanvas) {
      GenerationManager.instance.saveSlideEdit(
        book: widget.book!,
        modIdx: widget.modIdx!,
        secIdx: widget.secIdx!,
        unitIdx: widget.unitIdx!,
        lessonIdx: widget.lessonIdx!,
        slideIdx: lessonSlideIdx,
        updated: updated,
      );
    }
  }

  /// Compact optional confidence selector shown above CHECK. Rating is the
  /// heart of the metacognitive loop: it feeds calibration stats and decides
  /// whether a correct-but-guessed answer still enters the review queue.
  Widget _buildConfidenceRow() {
    Widget chip(int value, IconData icon, String label) {
      final selected = _confidence == value;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _confidence = selected ? null : value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: selected
                  ? AppTheme.duoBlue.withOpacity(0.18)
                  : context.colors.surfaceAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppTheme.duoBlue : context.colors.outline,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: selected ? AppTheme.duoBlue : context.colors.textFaint,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                    color: selected
                        ? AppTheme.duoBlue
                        : context.colors.textFaint,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          chip(
            MetacognitionService.confidenceGuessing,
            LucideIcons.dices,
            'GUESSING',
          ),
          chip(
            MetacognitionService.confidenceUnsure,
            LucideIcons.helpCircle,
            'UNSURE',
          ),
          chip(
            MetacognitionService.confidenceConfident,
            LucideIcons.checkCircle2,
            'SURE',
          ),
        ],
      ),
    );
  }

  /// For a wrongly answered quiz: why the picked option is wrong and/or why
  /// the correct one is right (the generator attaches an `explanation` to
  /// every option — it was never surfaced anywhere).
  String? _wrongQuizExplanation(Slide slide) {
    if (slide.type != 'quiz' || slide.options == null) return null;
    final selected = slide.options!
        .where((o) => o.id == _selectedQuizOption)
        .firstOrNull;
    final correct = slide.options!.where((o) => o.isCorrect).firstOrNull;
    final parts = [
      if (selected != null &&
          !selected.isCorrect &&
          selected.explanation.trim().isNotEmpty)
        selected.explanation.trim(),
      if (correct != null && correct.explanation.trim().isNotEmpty)
        correct.explanation.trim(),
    ];
    return parts.isEmpty ? null : parts.join('\n\n');
  }

  Widget _buildActionBottomBar(Slide slide) {
    final isInteractive = [
      'quiz',
      'fill_in_blank',
      'one_word',
      'numerical',
      'matching',
      'ordering',
      'error_spotting',
    ].contains(slide.type);
    final feedbackColor = _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed;
    final wrongExplanation = _wrongQuizExplanation(slide);
    return Container(
      decoration: BoxDecoration(
        color: _answered ? feedbackColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(_answered ? 20 : 0),
        border: Border.all(
          color: _answered
              ? feedbackColor.withOpacity(0.3)
              : Colors.transparent,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: (_answered && !_isCorrect)
                ? Padding(
                    key: const ValueKey('incorrect_feedback'),
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.duoRed.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.duoRed.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CORRECT ANSWER:',
                            style: TextStyle(
                              color: AppTheme.duoRed,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MathMarkdown(
                            data: _getCorrectAnswerText(slide),
                            textStyle: const TextStyle(
                              color: AppTheme.duoRed,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (wrongExplanation != null) ...[
                            const SizedBox(height: 10),
                            MathMarkdown(
                              data: wrongExplanation,
                              textStyle: TextStyle(
                                color: context.colors.textSecondary,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('empty_feedback')),
          ),
          if (isInteractive && !_answered) _buildConfidenceRow(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isInteractive && !_answered
                ? DuoButton(
                    key: const ValueKey('check_button'),
                    text: 'CHECK',
                    color: _canCheck(slide)
                        ? AppTheme.duoGreen
                        : const Color(0xFF334155),
                    shadowColor: _canCheck(slide)
                        ? AppTheme.duoGreenDark
                        : const Color(0xFF1E293B),
                    onPressed: () {
                      if (_canCheck(slide)) _checkAnswer(slide);
                    },
                  )
                : DuoButton(
                    key: const ValueKey('continue_button'),
                    text: _answered && !_isCorrect ? 'GOT IT' : 'CONTINUE',
                    color: _answered && !_isCorrect
                        ? AppTheme.duoRed
                        : AppTheme.duoGreen,
                    shadowColor: _answered && !_isCorrect
                        ? AppTheme.duoRedDark
                        : AppTheme.duoGreenDark,
                    onPressed: _nextSlide,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideContent(Slide slide, Widget? bottomBar) {
    switch (slide.type) {
      case 'descriptive':
        return DescriptiveView(
          slide: slide,
          lessonCanvas: _buildLessonCanvas(),
          onComplete: () {
            setState(() {
              _isCorrect = true;
              _answered = true;
              _correctAttempts++;
            });
            _nextSlide();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              HapticFeedback.heavyImpact();
              _recordFirstAttempt(slide, true);
            });
          },
        );
      case 'custom_html':
        return CustomHtmlView(
          slide: slide,
          onComplete: () {
            setState(() {
              _isCorrect = true;
              _answered = true;
              _correctAttempts++;
            });
            _nextSlide();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              HapticFeedback.heavyImpact();
              _recordFirstAttempt(slide, true);
            });
          },
        );
      case 'step_by_step':
      case 'proof':
        final slideIdx = _lesson.slides.indexWhere((s) => identical(s, slide));
        return InteractiveProofView(
          slide: slide,
          lessonCanvas: _buildLessonCanvas(),
          canvasIsLoading: GenerationManager.instance.activeCanvasRegens
              .contains(slide.id),
          onRegenerateCanvas: (_canRegenerateCanvas && slideIdx >= 0)
              ? (err) => GenerationManager.instance.regenerateSlideCanvas(
                  book: widget.book!,
                  modIdx: widget.modIdx!,
                  secIdx: widget.secIdx!,
                  unitIdx: widget.unitIdx!,
                  lessonIdx: widget.lessonIdx!,
                  slideIdx: slideIdx,
                  errorContext: err,
                )
              : null,
          onUpdateSlide: _applySlideEdit,
          onComplete: () {
            setState(() {
              _isCorrect = true;
              _answered = true;
              _correctAttempts++;
            });
            _nextSlide();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              HapticFeedback.heavyImpact();
            });
          },
        );
      case 'quiz':
        return QuizView(
          slide: slide,
          selectedOptionId: _selectedQuizOption,
          isAnswered: _answered,
          onSelect: (id) => setState(() => _selectedQuizOption = id),
          onUpdateSlide: _applySlideEdit,
          bottomBar: bottomBar,
        );
      case 'fill_in_blank':
        return FillInBlankView(
          slide: slide,
          value: _blankInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _blankInput = val),
          onSubmit: () {
            if (_canCheck(slide)) _checkAnswer(slide);
          },
          bottomBar: bottomBar,
        );
      case 'numerical':
        return NumericalView(
          slide: slide,
          value: _numericInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _numericInput = val),
          bottomBar: bottomBar,
        );
      case 'one_word':
        return OneWordView(
          slide: slide,
          value: _wordInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _wordInput = val),
          bottomBar: bottomBar,
        );
      case 'matching':
        return MatchingView(
          slide: slide,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (assignments) =>
              setState(() => _matchingAssignments = assignments),
          bottomBar: bottomBar,
        );
      case 'ordering':
        return OrderingView(
          slide: slide,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (order) => setState(() => _orderingCurrent = order),
          bottomBar: bottomBar,
        );
      case 'error_spotting':
        return ErrorSpottingView(
          slide: slide,
          selectedIndex: _errorSelection,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onSelect: (i) => setState(() => _errorSelection = i),
          bottomBar: bottomBar,
        );
      case 'flashcard':
        return FlashcardView(
          key: ValueKey(slide.id),
          slide: slide,
          onSelfGrade: (remembered) {
            setState(() {
              _isCorrect = remembered;
              _answered = true;
              if (remembered) {
                _correctAttempts++;
              }
            });
            if (!remembered) {
              final fails = (_failCounts[slide.id] ?? 0) + 1;
              _failCounts[slide.id] = fails;
              _totalInteractive++;
              if (fails < 2) {
                _slideQueue.add(slide);
              }
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(milliseconds: 50), () {
                if (remembered) {
                  HapticFeedback.heavyImpact();
                } else {
                  HapticFeedback.mediumImpact();
                }
              });
              _recordFirstAttempt(slide, remembered);
            });
            if (remembered) {
              _nextSlide();
            }
          },
        );
      case 'concept_pieces':
        final hasConceptCanvas =
            (_lesson.canvasPrompt?.trim().isNotEmpty ?? false) &&
            !_failedCanvasIds.contains(_lesson.id);
        return ConceptPiecesView(
          slide: slide,
          lessonCanvas: _buildLessonCanvas(),
          bottomBar: bottomBar,
          hasCanvas: hasConceptCanvas,
          lessonTitle: _lesson.title,
        );
      case 'theory':
      case 'theory_group':
      default:
        final hasTheoryCanvas =
            (_lesson.canvasPrompt?.trim().isNotEmpty ?? false) &&
            !_failedCanvasIds.contains(_lesson.id);
        return TheoryView(
          slide: slide,
          lessonCanvas: _buildLessonCanvas(),
          bottomBar: bottomBar,
          hasCanvas: hasTheoryCanvas,
          lessonTitle: _lesson.title,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_slideQueue.isEmpty) {
      return Scaffold(
        backgroundColor: context.colors.background, // Match React lesson bg
        body: Center(
          child: Text(
            "Empty Lesson",
            style: TextStyle(color: context.colors.textPrimary),
          ),
        ),
      );
    }

    // Defensive clamp: a background cache refresh can shrink _slideQueue
    // (wrong-answer repeats dropped) after _currentIndex has advanced, which
    // would otherwise index out of range here.
    if (_currentIndex >= _slideQueue.length) {
      _currentIndex = _slideQueue.length - 1;
    }
    if (_currentIndex < 0) _currentIndex = 0;

    final slide = _slideQueue[_currentIndex];
    var progress = (_currentIndex) / _slideQueue.length;
    if (progress > _maxProgress) {
      _maxProgress = progress;
    } else {
      progress = _maxProgress;
    }
    final remaining = _slideQueue.length - _currentIndex;
    final hasCustomBar = _isCustomBottomBar(slide);
    final bottomBar = (!hasCustomBar && !_isEditingMode)
        ? _buildActionBottomBar(slide)
        : null;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.mobile,
        breakpoint: ResponsiveMaxWidth.mobile,
        child: SafeArea(
          child: Column(
            children: [
              // Header Bar exactly as LessonView.tsx
              ClipRRect(
                // To clip the BackdropFilter
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceAlt,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                      border: Border(
                        bottom: BorderSide(color: context.colors.outline),
                      ),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _confirmExit,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.x,
                              color: context.colors.textFaint,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(end: progress),
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOut,
                              builder: (context, value, _) =>
                                  LinearProgressIndicator(
                                    value: value,
                                    backgroundColor: context.colors.outline,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          AppTheme.duoGreen,
                                        ),
                                    minHeight: 16,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$remaining left',
                          style: TextStyle(
                            color: context.colors.textFaint,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _openAssistant(),
                          child: SizedBox(
                            width: 40,
                            height: 48,
                            child: Icon(
                              LucideIcons.messageCircle,
                              color: AppTheme.duoBlue,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (_canBookmark)
                          GestureDetector(
                            onTap: _toggleBookmark,
                            child: SizedBox(
                              width: 40,
                              height: 48,
                              child: Icon(
                                _isBookmarked
                                    ? LucideIcons.bookmark
                                    : LucideIcons.bookmarkPlus,
                                color: _isBookmarked
                                    ? AppTheme.duoOrange
                                    : context.colors.textFaint,
                                size: 22,
                              ),
                            ),
                          ),
                        if (_canBookmark) const SizedBox(width: 8),
                        if (_canRegenerateCanvas)
                          AnimatedBuilder(
                            animation: GenerationManager.instance,
                            builder: (context, _) {
                              final busy = GenerationManager
                                  .instance
                                  .activeSlideRegens
                                  .contains(slide.id);
                              return GestureDetector(
                                onTap: busy
                                    ? null
                                    : () => _promptRegenerateSlide(slide),
                                child: SizedBox(
                                  width: 40,
                                  height: 48,
                                  child: Center(
                                    child: busy
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    AppTheme.duoBlue,
                                                  ),
                                            ),
                                          )
                                        : Icon(
                                            LucideIcons.refreshCcw,
                                            color: context.colors.textFaint,
                                            size: 22,
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                        if (_canRegenerateCanvas)
                          GestureDetector(
                            onTap: () => _promptDeleteSlide(slide),
                            child: const SizedBox(
                              width: 40,
                              height: 48,
                              child: Icon(
                                LucideIcons.trash2,
                                color: AppTheme.duoRed,
                                size: 22,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Slide Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: _isEditingMode
                      ? TextField(
                          controller: _editController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontFamily: 'monospace',
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: context.colors.surfaceAlt,
                            border: const OutlineInputBorder(),
                            hintText: 'Markdown content...',
                            hintStyle: TextStyle(
                              color: context.colors.textFaint,
                            ),
                          ),
                        )
                      : ([
                              'descriptive',
                              'one_word',
                              'numerical',
                              'fill_in_blank',
                              'custom_html',
                            ].contains(slide.type)
                            ? _buildSlideContent(slide, bottomBar)
                            : GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onDoubleTap:
                                    !GlobalState.developerModeNotifier.value
                                    ? null
                                    : () {
                                        setState(() {
                                          _editController.text = slide.content;
                                          _isEditingMode = true;
                                        });
                                      },
                                child: _buildSlideContent(slide, bottomBar),
                              )),
                ),
              ),

              // Action Bottom Bar (SAVE only in editing mode)
              if (_isEditingMode)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      top: BorderSide(color: context.colors.outline, width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 24,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DuoButton(
                          text: 'CANCEL',
                          color: context.colors.textFaint,
                          shadowColor: context.colors.outline,
                          isOutline: true,
                          onPressed: () =>
                              setState(() => _isEditingMode = false),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DuoButton(
                          text: 'SAVE',
                          color: AppTheme.duoGreen,
                          shadowColor: AppTheme.duoGreenDark,
                          onPressed: () {
                            final updatedSlide = slide.copyWith(
                              content: _editController.text,
                            );
                            setState(() {
                              _isEditingMode = false;
                            });
                            _applySlideEdit(updatedSlide);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
