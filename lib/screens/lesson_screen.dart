import 'dart:ui';
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
import '../widgets/canvas_art_view.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import '../widgets/responsive_center.dart';
import '../widgets/slide_views/quiz_view.dart';
import '../widgets/slide_views/fill_in_blank_view.dart';
import '../widgets/slide_views/numerical_view.dart';
import '../widgets/slide_views/one_word_view.dart';
import '../widgets/slide_views/interactive_proof_view.dart';
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

  const LessonScreen({
    super.key,
    required this.lesson,
    this.book,
    this.modIdx,
    this.secIdx,
    this.unitIdx,
    this.lessonIdx,
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
  /// Live copy of the lesson. Starts as the one we were constructed with and
  /// gets refreshed whenever [GenerationManager] notifies — this is how the
  /// background canvas-art pass and the user-triggered regenerate button
  /// reach this screen without it being popped/rebuilt.
  late Lesson _lesson;

  String? _selectedQuizOption;
  String _blankInput = '';
  String _numericInput = '';
  String _wordInput = '';

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
      widget.lessonIdx != null;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _lesson = widget.lesson;
    _buildSlideQueue();
    GenerationManager.instance.addListener(_onGenerationManagerChange);
    // Pull the latest from cache once on open in case background art landed
    // between the dashboard build and this screen mounting.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _refreshFromCache();
        if (_canRegenerateCanvas) {
          _triggerBackgroundCanvasGeneration();
        }
      }
    });
    // Bookmark state + stamp last-opened time if this lesson is bookmarked.
    _loadBookmarkState();
    BookmarkService.markOpened(widget.lesson.id);
  }

  void _triggerBackgroundCanvasGeneration() {
    if (widget.book == null || widget.modIdx == null || widget.secIdx == null || widget.unitIdx == null || widget.lessonIdx == null) return;
    
    final book = widget.book!;
    final modIdx = widget.modIdx!;
    final secIdx = widget.secIdx!;
    final unitIdx = widget.unitIdx!;
    final lessonIdx = widget.lessonIdx!;
    final lesson = _lesson;

    // Trigger lesson canvas if prompt is present but SVG is empty
    if ((lesson.canvasPrompt?.trim().isNotEmpty ?? false) && (lesson.canvasSvg?.trim().isEmpty ?? true)) {
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
      if ((s.canvasPrompt?.trim().isNotEmpty ?? false) && (s.canvasSvg?.trim().isEmpty ?? true)) {
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
        backgroundColor: AppTheme.surface,
        duration: const Duration(seconds: 2),
        content: Text(
          nowBookmarked ? 'Lesson bookmarked' : 'Bookmark removed',
          style: const TextStyle(color: Colors.white),
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

  /// Reads the freshest book snapshot from the cache and updates [_lesson]
  /// with the latest copy at our indices. Cheap — `getBookFromCache` is an
  /// in-memory map lookup in DatabaseService.
  Future<void> _refreshFromCache() async {
    if (!_canRegenerateCanvas) return;
    try {
      final fresh = await DatabaseService().getBookFromCache(widget.book!.id);
      if (fresh == null || !mounted) return;
      final lesson = fresh
          .modules[widget.modIdx!]
          .sections[widget.secIdx!]
          .units[widget.unitIdx!]
          .lessons[widget.lessonIdx!];
      // Only setState if the slides identity or the canvas svg actually
      // changed, to avoid rebuilds on every notifier tick.
      if (lesson.canvasSvg != _lesson.canvasSvg ||
          identical(lesson.slides, _lesson.slides) == false) {
        setState(() {
          _lesson = lesson;
          _failedCanvasIds.remove(lesson.id);
          // Refresh the queue so each Slide object reflects the latest
          // canvasSvg / content. Length and order remain stable because
          // we're looking up the same lesson in the same book.
          _slideQueue = List.of(_lesson.slides);
          // The queue may have grown earlier (wrong-answer repeats are
          // appended) and _currentIndex advanced into that region. Rebuilding
          // from the base slides shrinks it, so clamp the cursor back into
          // range to avoid a RangeError on the next build.
          if (_currentIndex >= _slideQueue.length) {
            _currentIndex = _slideQueue.isEmpty ? 0 : _slideQueue.length - 1;
          }
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _triggerBackgroundCanvasGeneration();
          }
        });
      }
    } catch (_) {
      // Indices may be stale (book regenerated). Ignore — we keep showing
      // the snapshot we were constructed with.
    }
  }

  void _buildSlideQueue() {
    _slideQueue = List.of(_lesson.slides);

    for (var slide in _slideQueue) {
      if (['quiz', 'fill_in_blank', 'one_word', 'numerical', 'proof', 'step_by_step'].contains(slide.type)) {
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

    setState(() {
      _answered = true;
      _isCorrect = correct;
      if (correct) _correctAttempts++;
    });
  }

  bool _canCheck(Slide slide) {
    if (slide.type == 'quiz') return _selectedQuizOption != null;
    if (slide.type == 'fill_in_blank') return _blankInput.trim().isNotEmpty;
    if (slide.type == 'one_word') return _wordInput.trim().isNotEmpty;
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
    if (slide.type == 'one_word') return slide.blankAnswer ?? '';
    if (slide.type == 'numerical') return slide.numericAnswer?.toString() ?? '';
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
      isLoading: GenerationManager.instance.activeCanvasRegens.contains(_lesson.id),
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Regenerate this slide?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'The AI will rewrite this slide using the source material. Optionally tell it what to change.',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteCtrl,
              maxLines: 2,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Optional note — e.g. "make it simpler"',
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Regenerate', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    final note = noteCtrl.text.trim();
    noteCtrl.dispose();
    if (confirmed != true || !_canRegenerateCanvas) return;

    final slideIdx = _lesson.slides.indexWhere((s) => s.id == slide.id);
    if (slideIdx < 0) return;

    await GenerationManager.instance.regenerateSlide(
      book: widget.book!,
      modIdx: widget.modIdx!,
      secIdx: widget.secIdx!,
      unitIdx: widget.unitIdx!,
      lessonIdx: widget.lessonIdx!,
      slideIdx: slideIdx,
      note: note.isEmpty ? null : note,
    );
  }

  Future<void> _promptDeleteSlide(Slide slide) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Delete this slide?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Are you sure you want to permanently delete this slide from this lesson? This cannot be undone.',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
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
        final sec = widget.book!.modules[widget.modIdx!].sections[widget.secIdx!];
        final List<String> notesParts = [];
        for (var unit in sec.units) {
          for (var lesson in unit.lessons) {
            for (var slide in lesson.slides) {
              if (slide.type == 'theory') {
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
          .where((s) => s.type == 'theory')
          .map((s) => '**${s.title}**\n${s.content}')
          .join('\n\n');
    }

    final slide = _slideQueue[_currentIndex];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => LessonAssistantChat(
        book: widget.book ?? Book(id: 'dummy', title: 'Lesson Course', description: '', icon: '', modules: [], lessonFormats: [], defaultFormatId: ''),
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
    final lessonSlideIdx = _lesson.slides.indexWhere((s) => identical(s, currentSlide));
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

  Widget _buildActionBottomBar(Slide slide) {
    final isInteractive = ['quiz', 'fill_in_blank', 'one_word', 'numerical'].contains(slide.type);
    final feedbackColor = _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _answered 
          ? feedbackColor.withOpacity(0.1)
          : Colors.transparent,
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
                  )
                : const SizedBox.shrink(key: ValueKey('empty_feedback')),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isInteractive && !_answered
                ? DuoButton(
                    key: const ValueKey('check_button'),
                    text: 'CHECK',
                    color: _canCheck(slide) ? AppTheme.duoGreen : const Color(0xFF334155),
                    shadowColor: _canCheck(slide) ? AppTheme.duoGreenDark : const Color(0xFF1E293B),
                    onPressed: () {
                      if (_canCheck(slide)) _checkAnswer(slide);
                    },
                  )
                : DuoButton(
                    key: const ValueKey('continue_button'),
                    text: _answered && !_isCorrect ? 'GOT IT' : 'CONTINUE',
                    color: _answered && !_isCorrect ? AppTheme.duoRed : AppTheme.duoGreen,
                    shadowColor: _answered && !_isCorrect ? AppTheme.duoRedDark : AppTheme.duoGreenDark,
                    onPressed: _nextSlide,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideContent(Slide slide, Widget? bottomBar) {
    switch (slide.type) {
      case 'step_by_step':
      case 'proof':
        final slideIdx = _lesson.slides.indexWhere((s) => identical(s, slide));
        return InteractiveProofView(
          slide: slide,
          lessonCanvas: _buildLessonCanvas(),
          canvasIsLoading: GenerationManager.instance.activeCanvasRegens.contains(slide.id),
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
      case 'theory':
      case 'theory_group':
      default:
        final hasCanvas = (_lesson.canvasPrompt?.trim().isNotEmpty ?? false) && !_failedCanvasIds.contains(_lesson.id);
        // Wrap theory content matching LessonView.tsx default renderer (glass panel)
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CustomScrollView(
             physics: const BouncingScrollPhysics(),
             slivers: [
               SliverToBoxAdapter(
                 child: Column(
                    children: [
                       // Lesson-level canvas stacked above the theory text
                       _buildLessonCanvas(),
    
                       if (!hasCanvas)
                         Padding(
                           padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                           child: Text(
                             _lesson.title,
                             style: const TextStyle(
                               fontSize: 28,
                               fontWeight: FontWeight.w900,
                               color: Colors.white,
                               letterSpacing: -0.5,
                             ),
                             textAlign: TextAlign.center,
                           ),
                         ),
    
                       if (!hasCanvas && slide.title.isNotEmpty && slide.title.toLowerCase() != _lesson.title.toLowerCase())
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
                            borderRadius: hasCanvas
                                ? const BorderRadius.vertical(bottom: Radius.circular(24))
                                : BorderRadius.circular(24),
                            color: Colors.black.withOpacity(0.4),
                            border: hasCanvas
                                ? Border(
                                    left: BorderSide(color: Colors.white.withOpacity(0.1)),
                                    right: BorderSide(color: Colors.white.withOpacity(0.1)),
                                    bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                                  )
                                : null,
                         ),
                         child: Builder(
                           builder: (context) {
                             final lines = slide.content.split('\n');
                             return Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 if (hasCanvas && slide.title.isNotEmpty)
                                   Padding(
                                     padding: const EdgeInsets.only(bottom: 16.0),
                                     child: Center(
                                       child: Text(
                                         slide.title,
                                         style: const TextStyle(
                                           fontSize: 24,
                                           fontWeight: FontWeight.w900,
                                           color: Colors.white,
                                           letterSpacing: -0.5,
                                         ),
                                         textAlign: TextAlign.center,
                                       ),
                                     ),
                                   ),
                                 ...lines.map((line) {
                                   if (line.isEmpty) {
                                     return const SizedBox(height: 8);
                                   }
                                   return Padding(
                                     padding: const EdgeInsets.symmetric(vertical: 4.0),
                                     child: MathMarkdown(
                                       data: line,
                                       textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                                     ),
                                   );
                                 }),
                               ],
                             );
                           }
                         ),
                       ),
                    ]
                 ),
               ),
               if (bottomBar != null)
                 SliverFillRemaining(
                   hasScrollBody: false,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       const SizedBox(height: 24),
                       bottomBar,
                     ],
                   ),
                 ),
             ],
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

    // Defensive clamp: a background cache refresh can shrink _slideQueue
    // (wrong-answer repeats dropped) after _currentIndex has advanced, which
    // would otherwise index out of range here.
    if (_currentIndex >= _slideQueue.length) {
      _currentIndex = _slideQueue.length - 1;
    }
    if (_currentIndex < 0) _currentIndex = 0;

    final slide = _slideQueue[_currentIndex];
    final progress = (_currentIndex) / _slideQueue.length;
    final hasCustomBar = _isCustomBottomBar(slide);
    final bottomBar = (!hasCustomBar && !_isEditingMode) ? _buildActionBottomBar(slide) : null;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.mobile,
        breakpoint: ResponsiveMaxWidth.mobile,
        child: SafeArea(
        child: Column(
          children: [
            // Header Bar exactly as LessonView.tsx
            ClipRRect( // To clip the BackdropFilter
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
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
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _openAssistant(),
                        child: SizedBox(
                          width: 40,
                          height: 48,
                          child: Icon(LucideIcons.messageCircle, color: AppTheme.duoBlue, size: 22),
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
                              _isBookmarked ? LucideIcons.bookmark : LucideIcons.bookmarkPlus,
                              color: _isBookmarked ? AppTheme.duoOrange : Colors.white54,
                              size: 22,
                            ),
                          ),
                        ),
                      if (_canBookmark) const SizedBox(width: 8),
                      if (_canRegenerateCanvas)
                        AnimatedBuilder(
                          animation: GenerationManager.instance,
                          builder: (context, _) {
                            final busy = GenerationManager.instance.activeSlideRegens.contains(slide.id);
                            return GestureDetector(
                              onTap: busy ? null : () => _promptRegenerateSlide(slide),
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
                                            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                                          ),
                                        )
                                      : const Icon(LucideIcons.refreshCcw, color: Colors.white54, size: 22),
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
                            child: Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 22),
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
                        child: _buildSlideContent(slide, bottomBar),
                      ),
              )
            ),
            
            // Action Bottom Bar (SAVE only in editing mode)
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
                    final updatedSlide = slide.copyWith(content: _editController.text);
                    setState(() {
                      _isEditingMode = false;
                    });
                    _applySlideEdit(updatedSlide);
                  },
                ),
              )
          ],
        ),
        ),
      ),
    );
  }
}