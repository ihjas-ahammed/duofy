import 'dart:math' as math;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import '../models/app_models.dart';
import '../services/metacognition_service.dart';
import '../services/global_state.dart';
import '../theme/app_theme.dart';
import '../widgets/combo_badge.dart';
import '../widgets/math_markdown.dart';
import 'lesson_screen.dart';

/// Game-over / Lesson Mastered summary screen matching docs/new-theme/slide-p/game-over.html
class LessonCompleteScreen extends StatefulWidget {
  final int xpEarned;
  final int accuracy;
  final int timeSpentSeconds;
  final bool isPractice;

  /// When both are set, a one-tap reflection row is shown; the answer feeds
  /// the per-module difficulty signal used by future generation.
  final String? bookId;
  final String? moduleId;

  final Book? book;
  final int? modIdx;
  final int? secIdx;
  final int? unitIdx;
  final int? lessonIdx;
  final Lesson? lesson;
  final List<Slide>? difficultSlides;

  const LessonCompleteScreen({
    super.key,
    required this.xpEarned,
    required this.accuracy,
    required this.timeSpentSeconds,
    this.isPractice = false,
    this.bookId,
    this.moduleId,
    this.book,
    this.modIdx,
    this.secIdx,
    this.unitIdx,
    this.lessonIdx,
    this.lesson,
    this.difficultSlides,
  });

  @override
  State<LessonCompleteScreen> createState() => _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<LessonCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _gaugeAnimation;
  late Animation<double> _scaleAnim;
  late ConfettiController _confettiController;

  /// Which reflection chip was tapped (null until then).
  String? _reflection;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _gaugeAnimation = Tween<double>(
      begin: 0.0,
      end: widget.accuracy.clamp(0, 100) / 100.0,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.1, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    // Keep celebration animation same as original
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 1200),
    );

    _animController.forward();
    _confettiController.play();

    Future.delayed(const Duration(milliseconds: 100), () {
      HapticFeedback.heavyImpact();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  String get _topicTitle {
    if (widget.book != null &&
        widget.modIdx != null &&
        widget.secIdx != null &&
        widget.unitIdx != null &&
        widget.lessonIdx != null) {
      try {
        final b = widget.book!;
        final lesson = b
            .modules[widget.modIdx!]
            .sections[widget.secIdx!]
            .units[widget.unitIdx!]
            .lessons[widget.lessonIdx!];
        if (lesson.title.trim().isNotEmpty) return lesson.title;
      } catch (_) {}
    }
    if (widget.book != null && widget.book!.title.trim().isNotEmpty) {
      return widget.book!.title;
    }
    return 'Linear Transformations';
  }

  String get _heroMessage {
    if (widget.accuracy == 100) return 'Lesson Mastered';
    if (widget.accuracy >= 80) return 'Great Mastery';
    if (widget.accuracy >= 60) return 'Good Effort';
    return 'Lesson Completed';
  }

  String get _heroDescription {
    if (widget.accuracy >= 80) {
      return "Outstanding work! You've demonstrated deep understanding and can apply these concepts with confidence.";
    } else if (widget.accuracy >= 60) {
      return "Solid progress! Reviewing missed concepts will help solidify these schemas into permanent long-term memory.";
    }
    return "Great effort completing this session. Repetition and deliberate practice will boost your confidence!";
  }

  int get _focusVelocityMinutes {
    final m = (widget.timeSpentSeconds / 60).round();
    return m > 0 ? m : 1;
  }

  bool get _shouldAutoNext {
    if (widget.isPractice) return false;
    if (widget.book == null ||
        widget.modIdx == null ||
        widget.secIdx == null ||
        widget.unitIdx == null ||
        widget.lessonIdx == null) {
      return false;
    }
    final book = widget.book!;
    if (widget.modIdx! < 0 || widget.modIdx! >= book.modules.length) {
      return false;
    }
    final module = book.modules[widget.modIdx!];
    if (widget.secIdx! < 0 || widget.secIdx! >= module.sections.length) {
      return false;
    }
    final section = module.sections[widget.secIdx!];
    if (widget.unitIdx! < 0 || widget.unitIdx! >= section.units.length) {
      return false;
    }
    final unit = section.units[widget.unitIdx!];
    if (widget.lessonIdx! < 0 || widget.lessonIdx! >= unit.lessons.length) {
      return false;
    }

    // Do not auto next if it is the last lesson of the unit
    return widget.lessonIdx! < unit.lessons.length - 1;
  }

  void _shareProgress() {
    final title = _topicTitle;
    Share.share(
      'I just mastered "$title" with ${widget.accuracy}% accuracy in Duofy! 🚀 #learning #duofy',
      subject: 'Lesson Mastered on Duofy',
    );
  }

  void _openReviewModal() {
    final colors = context.colors;
    final difficult = widget.difficultSlides ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: difficult.isNotEmpty ? 0.7 : 0.45,
          minChildSize: 0.35,
          maxChildSize: 0.92,
          expand: false,
          builder: (sheetContext, scrollController) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                12,
                20,
                MediaQuery.of(sheetContext).padding.bottom + 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colors.textSubtle.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: difficult.isNotEmpty
                                  ? colors.primaryBlueLight
                                  : colors.accentGreenLight,
                            ),
                            child: Center(
                              child: Icon(
                                difficult.isNotEmpty
                                    ? LucideIcons.listOrdered
                                    : LucideIcons.checkCircle2,
                                color: difficult.isNotEmpty
                                    ? colors.primaryBlue
                                    : colors.accentGreen,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                difficult.isNotEmpty
                                    ? 'Difficult Step Analysis'
                                    : 'Flawless Retrieval!',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: colors.textMain,
                                ),
                              ),
                              Text(
                                difficult.isNotEmpty
                                    ? '${difficult.length} question${difficult.length > 1 ? "s" : ""} to reinforce'
                                    : '100% accuracy on all interactive steps',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: colors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(ctx),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.badgeBg,
                          ),
                          child: Icon(
                            LucideIcons.x,
                            size: 15,
                            color: colors.textSubtle,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Content List
                  Expanded(
                    child: difficult.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.accentGreenLight,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        LucideIcons.trophy,
                                        size: 32,
                                        color: colors.accentGreen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    'Zero Mistakes!',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: colors.textMain,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'You solved every step in this lesson correctly on your first attempt.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: colors.textMuted,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: difficult.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, idx) {
                              final slide = difficult[idx];
                              return _buildDifficultSlideCard(
                                context,
                                slide,
                                idx + 1,
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 14),

                  // Action Button
                  if (difficult.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _startTargetedPractice(difficult);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primaryBlue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.play, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Practice Missed Questions (${difficult.length})',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (widget.lesson != null)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _startTargetedPractice(widget.lesson!.slides);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primaryBlue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.rotateCcw, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Replay Full Lesson',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDifficultSlideCard(
    BuildContext context,
    Slide slide,
    int number,
  ) {
    final colors = context.colors;
    String? correctAnswerText;
    String? explanationText;

    if (slide.type == 'quiz' && slide.options != null) {
      final correctOpt = slide.options!.firstWhere(
        (o) => o.isCorrect,
        orElse: () => slide.options!.first,
      );
      correctAnswerText = correctOpt.text;
      explanationText = correctOpt.explanation;
    } else if (slide.type == 'fill_in_blank' ||
        slide.type == 'numerical' ||
        slide.type == 'one_word') {
      correctAnswerText = slide.blankAnswer;
    } else if (slide.type == 'matching' && slide.matchPairs != null) {
      correctAnswerText = slide.matchPairs!
          .map((p) => '${p.left} ➔ ${p.right}')
          .join('\n');
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.mathBoxBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryBlueLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'QUESTION $number • ${slide.type.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: colors.primaryBlue,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          MathMarkdown(
            data: slide.content,
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colors.textMain,
              height: 1.4,
            ),
          ),
          if (correctAnswerText != null && correctAnswerText.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: colors.accentGreenLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colors.accentGreen.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.checkCircle2,
                        size: 13,
                        color: colors.accentGreen,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Expected Answer:',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: colors.accentGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  MathMarkdown(
                    data: correctAnswerText,
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colors.textMain,
                    ),
                  ),
                  if (explanationText != null &&
                      explanationText.trim().isNotEmpty) ...[
                    const SizedBox(height: 4),
                    MathMarkdown(
                      data: explanationText,
                      textStyle: TextStyle(
                        fontSize: 11,
                        color: colors.textMuted,
                        height: 1.35,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _startTargetedPractice(List<Slide> slides) {
    if (slides.isEmpty) return;
    final practiceLesson = Lesson(
      id: '${widget.lesson?.id ?? "practice"}_difficult_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Review: ${widget.lesson?.title ?? "Difficult Questions"}',
      description: 'Reinforcement practice for difficult steps',
      icon: widget.lesson?.icon ?? 'brain',
      slides: slides,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          lesson: practiceLesson,
          book: widget.book,
          modIdx: widget.modIdx,
          secIdx: widget.secIdx,
          unitIdx: widget.unitIdx,
          lessonIdx: widget.lessonIdx,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Background subtle confetti accents matching HTML mockup
          Positioned(
            top: 25,
            left: 15,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3B82F6).withValues(alpha: 0.35),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 16,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 75,
            child: Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF10B981),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 140,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color(0xFF10B981),
              ),
            ),
          ),
          Positioned(
            top: 65,
            right: 80,
            child: Container(
              width: 11,
              height: 11,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFBBF24),
              ),
            ),
          ),

          SafeArea(
            child: isDesktop ? _buildDesktop(colors) : _buildMobile(colors),
          ),

          // Preserved Celebration Bursts
          Positioned(
            left: 20,
            bottom: 120,
            child: IgnorePointer(
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.01,
                numberOfParticles: 60,
                maxBlastForce: 135,
                minBlastForce: 75,
                gravity: 0.08,
                colors: const [
                  AppTheme.duoGreen,
                  AppTheme.duoBlue,
                  AppTheme.duoViolet,
                  AppTheme.duoOrange,
                  Colors.amber,
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 120,
            child: IgnorePointer(
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.01,
                numberOfParticles: 60,
                maxBlastForce: 135,
                minBlastForce: 75,
                gravity: 0.08,
                colors: const [
                  AppTheme.duoGreen,
                  AppTheme.duoBlue,
                  AppTheme.duoViolet,
                  AppTheme.duoOrange,
                  Colors.amber,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop(AppColors colors) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
            decoration: BoxDecoration(
              color: colors.cardBg,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: colors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: colors.isDark ? 0.35 : 0.05),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTopNavigation(colors),
                const SizedBox(height: 12),
                _buildHeroSection(colors),
                const SizedBox(height: 16),
                _buildMetricsGrid(colors),
                const SizedBox(height: 16),
                _buildForecastCard(colors),
                const SizedBox(height: 14),
                _buildReflectionRow(colors),
                const SizedBox(height: 20),
                _buildActionButtons(colors),
                const SizedBox(height: 12),
                _buildFooterTip(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobile(AppColors colors) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 6),
            _buildTopNavigation(colors),
            const SizedBox(height: 8),
            _buildHeroSection(colors),
            const SizedBox(height: 12),
            _buildMetricsGrid(colors),
            const SizedBox(height: 12),
            _buildForecastCard(colors),
            const SizedBox(height: 10),
            _buildReflectionRow(colors),
            const SizedBox(height: 16),
            _buildActionButtons(colors),
            const SizedBox(height: 14),
            _buildFooterTip(colors),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // 1. Navigation Header
  Widget _buildTopNavigation(AppColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context, _shouldAutoNext),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.cardBg,
              border: Border.all(color: colors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                LucideIcons.arrowLeft,
                size: 18,
                color: colors.textMain,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _shareProgress,
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.cardBg,
              border: Border.all(color: colors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                LucideIcons.share2,
                size: 18,
                color: colors.textMain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 2. Hero / Circular Mastery Section
  Widget _buildHeroSection(AppColors colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circular Gauge Meter
        ScaleTransition(
          scale: _scaleAnim,
          child: SizedBox(
            width: 136,
            height: 136,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _gaugeAnimation,
                  builder: (context, _) {
                    return CustomPaint(
                      size: const Size(136, 136),
                      painter: _CircularGaugePainter(
                        progress: _gaugeAnimation.value,
                        trackColor: colors.cardBorder,
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.accuracy}%',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: colors.textMain,
                        letterSpacing: -0.5,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Mastery',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.accentGreen,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Icon(
                      LucideIcons.shieldCheck,
                      size: 16,
                      color: colors.accentGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 14),

        // Hero Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Completed pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.accentGreenLight,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.check,
                      size: 12,
                      color: colors.accentGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lesson Completed!',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: colors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              Text(
                _heroMessage,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: colors.textMain,
                  letterSpacing: -0.4,
                ),
              ),

              const SizedBox(height: 2),

              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _topicTitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: colors.primaryBlue,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                _heroDescription,
                style: TextStyle(
                  fontSize: 10.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: colors.textMuted,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              ValueListenableBuilder<int>(
                valueListenable: GlobalState.comboNotifier,
                builder: (context, combo, _) {
                  if (combo < 2) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: ComboBadge(combo: combo, isCompact: true),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Three Metric Cards Row
  Widget _buildMetricsGrid(AppColors colors) {
    return Row(
      children: [
        // Metric 1: Focus Velocity
        Expanded(
          child: _buildMetricCard(
            colors: colors,
            icon: LucideIcons.activity,
            iconColor: colors.primaryBlue,
            iconBg: colors.primaryBlue.withValues(alpha: 0.1),
            title: 'Focus Velocity',
            value: '$_focusVelocityMinutes',
            unit: 'm',
            subtitle: 'in Flow',
            sparklineColor: colors.primaryBlue,
            points: const [0.4, 0.4, 0.65, 0.55, 0.8, 0.7, 0.95],
          ),
        ),
        const SizedBox(width: 8),

        // Metric 2: FirstTry Accuracy
        Expanded(
          child: _buildMetricCard(
            colors: colors,
            icon: LucideIcons.target,
            iconColor: colors.accentGreen,
            iconBg: colors.accentGreen.withValues(alpha: 0.12),
            title: 'FirstTry Accuracy',
            value: '${widget.accuracy}',
            unit: '%',
            subtitle: widget.accuracy >= 80 ? 'Excellent' : 'Solid',
            sparklineColor: colors.accentGreen,
            points: const [0.35, 0.4, 0.6, 0.5, 0.75, 0.65, 0.9],
          ),
        ),
        const SizedBox(width: 8),

        // Metric 3: Cognitive Momentum / XP
        Expanded(
          child: _buildMetricCard(
            colors: colors,
            icon: LucideIcons.trendingUp,
            iconColor: colors.violet,
            iconBg: colors.violet.withValues(alpha: 0.12),
            title: 'Cognitive Momentum',
            value: '+${widget.xpEarned}',
            unit: 'pts',
            subtitle: 'Keep Building!',
            sparklineColor: colors.violet,
            points: const [0.3, 0.45, 0.4, 0.65, 0.6, 0.85, 1.0],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required AppColors colors,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String value,
    required String unit,
    required String subtitle,
    required Color sparklineColor,
    required List<double> points,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: colors.isDark ? 0.3 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(6, 12, 6, 0),
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBg,
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 15,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: colors.textMain,
              height: 1.15,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: iconColor,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 1),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: CustomPaint(
              painter: _SparklinePainter(
                color: sparklineColor,
                points: points,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Spaced Repetition Forecast Card (Robust & Responsive Layout)
  Widget _buildForecastCard(AppColors colors) {
    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    DateTime addDays(int n) => now.add(Duration(days: n));
    String dayName(DateTime d) => days[(d.weekday - 1) % 7];
    String dateStr(DateTime d) => '${months[d.month - 1]} ${d.day.toString().padLeft(2, '0')}';

    final nextReviewDate = addDays(3);
    final nextReviewDayName = dayName(nextReviewDate);

    final intervals = [
      {'name': 'Today', 'date': dateStr(now), 'step': '✓', 'status': 'Completed', 'type': 'completed'},
      {'name': dayName(addDays(2)), 'date': dateStr(addDays(2)), 'step': '3', 'status': 'Good', 'type': 'green'},
      {'name': dayName(addDays(5)), 'date': dateStr(addDays(5)), 'step': '6', 'status': 'Review', 'type': 'blue'},
      {'name': dayName(addDays(10)), 'date': dateStr(addDays(10)), 'step': '11', 'status': 'Review', 'type': 'blue'},
      {'name': dayName(addDays(14)), 'date': dateStr(addDays(14)), 'step': '14', 'status': 'Review', 'type': 'purple'},
      {'name': dayName(addDays(18)), 'date': dateStr(addDays(18)), 'step': '18', 'status': 'Review', 'type': 'purple'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: colors.isDark ? 0.3 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Part with unconstrained overflow prevention
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: colors.primaryBlueLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          LucideIcons.calendar,
                          size: 15,
                          color: colors.primaryBlue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spaced Repetition Forecast',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: colors.textMain,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 1),
                          Text(
                            'Strengthen memory with timely reviews.',
                            style: TextStyle(
                              fontSize: 9,
                              color: colors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.accentGreenLight,
                  border: Border.all(color: colors.accentGreenBorder),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.calendarCheck,
                      size: 13,
                      color: colors.accentGreen,
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Next Review:',
                          style: TextStyle(
                            fontSize: 7.5,
                            fontWeight: FontWeight.w700,
                            color: colors.textMain,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          '$nextReviewDayName (3d)',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            color: colors.accentGreen,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Timeline Intervals Row
          Stack(
            alignment: Alignment.center,
            children: [
              // Connector dotted line positioned behind the circles
              Positioned(
                top: 31,
                left: 12,
                right: 12,
                child: CustomPaint(
                  size: const Size(double.infinity, 2),
                  painter: _DottedLinePainter(
                    color: colors.cardBorder,
                  ),
                ),
              ),

              Row(
                children: intervals.map((item) {
                  final isToday = item['name'] == 'Today';
                  Color nodeBorder;
                  Color nodeText;
                  Color statusColor;

                  if (item['type'] == 'completed') {
                    nodeBorder = colors.accentGreen;
                    nodeText = Colors.white;
                    statusColor = colors.accentGreen;
                  } else if (item['type'] == 'green') {
                    nodeBorder = colors.accentGreen;
                    nodeText = colors.accentGreen;
                    statusColor = colors.accentGreen;
                  } else if (item['type'] == 'purple') {
                    nodeBorder = colors.violet;
                    nodeText = colors.violet;
                    statusColor = colors.violet;
                  } else {
                    nodeBorder = colors.primaryBlue;
                    nodeText = colors.primaryBlue;
                    statusColor = colors.primaryBlue;
                  }

                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 1),
                      decoration: BoxDecoration(
                        color: isToday
                            ? (colors.isDark
                                ? const Color(0x1F10B981)
                                : const Color(0xFFEDFBF4))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item['name']!,
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: isToday ? colors.accentGreen : colors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 1),
                          Text(
                            item['date']!,
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: colors.textSubtle,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: item['type'] == 'completed'
                                  ? colors.accentGreen
                                  : colors.cardBg,
                              border: Border.all(
                                color: nodeBorder,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Center(
                              child: item['type'] == 'completed'
                                  ? const Icon(
                                      LucideIcons.check,
                                      color: Colors.white,
                                      size: 11,
                                    )
                                  : Text(
                                      item['step']!,
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                        color: nodeText,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['status']!,
                            style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 5. Adaptive Difficulty Reflection Row
  Widget _buildReflectionRow(AppColors colors) {
    if (widget.bookId == null || widget.moduleId == null) {
      return const SizedBox.shrink();
    }

    Widget chip(String value, IconData icon, String label, Color color) {
      final selected = _reflection == value;
      return Expanded(
        child: GestureDetector(
          onTap: _reflection != null
              ? null
              : () {
                  setState(() => _reflection = value);
                  MetacognitionService.recordReflection(
                    widget.bookId!,
                    widget.moduleId!,
                    value,
                  );
                  HapticFeedback.selectionClick();
                },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _reflection == null || selected ? 1 : 0.35,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: selected
                    ? color.withValues(alpha: 0.18)
                    : colors.cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? color : colors.cardBorder,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: selected ? color : colors.textFaint,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w900,
                      color: selected ? color : colors.textFaint,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Text(
          _reflection == null
              ? 'HOW DID THAT FEEL?'
              : 'THANKS — FUTURE LESSONS WILL ADAPT',
          style: TextStyle(
            color: colors.textSubtle,
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            chip('easy', LucideIcons.feather, 'TOO EASY', colors.primaryBlue),
            chip('right', LucideIcons.smile, 'JUST RIGHT', colors.accentGreen),
            chip(
              'confusing',
              LucideIcons.cloudFog,
              'CONFUSING',
              AppTheme.duoOrange,
            ),
          ],
        ),
      ],
    );
  }

  // 6. Action Buttons (Primary + Secondary)
  Widget _buildActionButtons(AppColors colors) {
    return Column(
      children: [
        // Primary Blue Action Button
        GestureDetector(
          onTap: () => Navigator.pop(context, _shouldAutoNext),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: colors.primaryBlue,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: colors.primaryBlue.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.22),
                      ),
                      child: const Center(
                        child: Icon(
                          LucideIcons.rocket,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Continue Learning Journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  LucideIcons.chevronRight,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Secondary Outlined Action Button
        GestureDetector(
          onTap: _openReviewModal,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: colors.cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: colors.primaryBlue,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.primaryBlueLight,
                      ),
                      child: Center(
                        child: Icon(
                          LucideIcons.listFilter,
                          color: colors.primaryBlue,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.difficultSlides != null && widget.difficultSlides!.isNotEmpty
                          ? 'Review Difficult Steps (${widget.difficultSlides!.length})'
                          : 'Review Difficult Steps',
                      style: TextStyle(
                        color: colors.primaryBlue,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                Icon(
                  LucideIcons.chevronRight,
                  color: colors.primaryBlue,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 7. Footer Metacognition Tip
  Widget _buildFooterTip(AppColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: colors.isDark ? const Color(0xFF1E293B) : const Color(0xFFEEF2F6),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🧠', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 6),
          Flexible(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 10,
                  color: colors.textMuted,
                  fontFamily: 'Nunito',
                ),
                children: [
                  TextSpan(
                    text: 'Metacognition Tip: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: colors.textMain,
                    ),
                  ),
                  const TextSpan(
                    text: 'Teaching others is one of the best ways to retain knowledge.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the Circular Gauge Arc
class _CircularGaugePainter extends CustomPainter {
  final double progress;
  final Color trackColor;

  _CircularGaugePainter({
    required this.progress,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;

    // 1. Background Track Arc
    final bgPaint = Paint()
      ..color = trackColor
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // 2. Glowing Gradient Progress Arc
    if (progress > 0.0) {
      final sweepAngle = 2 * math.pi * progress;

      final gradient = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: const [
          Color(0xFF10B981),
          Color(0xFF06B6D4),
          Color(0xFF0056FD),
        ],
        stops: const [0.0, 0.5, 1.0],
        transform: const GradientRotation(-math.pi / 2),
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius))
        ..strokeWidth = 9
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularGaugePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.trackColor != trackColor;
}

/// Custom painter for Smooth Sparkline Graphs with Gradient Area
class _SparklinePainter extends CustomPainter {
  final Color color;
  final List<double> points;

  _SparklinePainter({required this.color, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final w = size.width;
    final h = size.height;
    final step = w / (points.length - 1);

    final path = Path();
    final fillPath = Path();

    path.moveTo(0, h - (points[0] * h * 0.8));
    fillPath.moveTo(0, h);
    fillPath.lineTo(0, h - (points[0] * h * 0.8));

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = Offset(i * step, h - (points[i] * h * 0.8));
      final p1 = Offset((i + 1) * step, h - (points[i + 1] * h * 0.8));

      final midX = (p0.dx + p1.dx) / 2;
      path.cubicTo(midX, p0.dy, midX, p1.dy, p1.dx, p1.dy);
      fillPath.cubicTo(midX, p0.dy, midX, p1.dy, p1.dx, p1.dy);
    }

    fillPath.lineTo(w, h);
    fillPath.close();

    // Area Gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.25),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Line Stroke
    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, strokePaint);

    // End point dot
    final lastPoint = Offset(w, h - (points.last * h * 0.8));
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(lastPoint, 2.5, dotPaint);
  }

  @override
  bool shouldRepaint(_SparklinePainter oldDelegate) => false;
}

/// Custom painter for timeline dashed connector line
class _DottedLinePainter extends CustomPainter {
  final Color color;

  _DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(math.min(startX + dashWidth, size.width), size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) => false;
}