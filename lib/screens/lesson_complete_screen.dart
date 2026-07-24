
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../services/metacognition_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

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
  });

  @override
  State<LessonCompleteScreen> createState() => _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<LessonCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late ConfettiController _confettiController;

  /// Which reflection chip was tapped (null until then).
  String? _reflection;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );

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

  String get _formattedTime {
    int m = widget.timeSpentSeconds ~/ 60;
    int s = widget.timeSpentSeconds % 60;
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  String get _message {
    if (widget.accuracy == 100) return "Perfect!";
    if (widget.accuracy >= 80) return "Great Job!";
    if (widget.accuracy >= 60) return "Good Effort!";
    return "Complete!";
  }

  /// Wraps [child] in the staggered elastic pop-in used across the stat tiles.
  Widget _staggered(double start, Widget child) => ScaleTransition(
    scale: CurvedAnimation(
      parent: _animController,
      curve: Interval(start, 1.0, curve: Curves.elasticOut),
    ),
    child: child,
  );

  /// A single stat tile (XP / accuracy / time). [accentColor] tints the icon
  /// and the bottom rule.
  Widget _statTile({
    required IconData icon,
    required Color accentColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: AppTheme.glassOf(context).copyWith(
        border: Border(bottom: BorderSide(color: accentColor, width: 4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: accentColor, size: 28),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: context.colors.textFaint,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  /// XP tile whose number counts up from 0 as the screen lands.
  Widget _xpStatTile() => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: widget.xpEarned.toDouble()),
    duration: const Duration(milliseconds: 900),
    curve: Curves.easeOutCubic,
    builder: (context, v, _) => _statTile(
      icon: LucideIcons.zap,
      accentColor: Colors.amber,
      label: 'XP EARNED',
      value: '+${v.round()}',
    ),
  );

  Widget get _hero => ScaleTransition(
    scale: _scaleAnim,
    child: Column(
      children: [
        const Icon(LucideIcons.trophy, size: 96, color: Colors.amber),
        const SizedBox(height: 28),
        Text(
          _message,
          style: const TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: Colors.amber,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

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

  Widget get _continueButton => _staggered(
    0.6,
    DuoButton(
      text: 'Continue',
      color: AppTheme.duoGreen,
      shadowColor: AppTheme.duoGreenDark,
      // Because pushReplacement is used in both LessonScreen and
      // PracticeSessionScreen, popping exactly once properly returns back
      // to the lesson path or practice menu.
      onPressed: () => Navigator.pop(context, _shouldAutoNext),
    ),
  );

  /// One-tap "How did that feel?" row. Entirely optional — Continue works
  /// without it — but each tap tunes the module's future difficulty.
  Widget get _reflectionRow {
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
            duration: Duration(milliseconds: 200),
            opacity: _reflection == null || selected ? 1 : 0.35,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: selected
                    ? color.withValues(alpha: 0.18)
                    : context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? color : context.colors.outline,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: selected ? color : context.colors.textFaint,
                  ),
                  SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: selected ? color : context.colors.textFaint,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return _staggered(
      0.55,
      Column(
        children: [
          Text(
            _reflection == null
                ? 'HOW DID THAT FEEL?'
                : 'THANKS — FUTURE LESSONS WILL ADAPT',
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              chip('easy', LucideIcons.feather, 'TOO EASY', AppTheme.duoBlue),
              chip('right', LucideIcons.smile, 'JUST RIGHT', AppTheme.duoGreen),
              chip(
                'confusing',
                LucideIcons.cloudFog,
                'CONFUSING',
                AppTheme.duoOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: isDesktop ? _buildDesktop() : _buildMobile(),
          ),
          // Celebration burst shooting from left corner
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
          // Celebration burst shooting from right corner
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

  /// Desktop: a single centered glass card holding the hero, all three stats
  /// in one row, and the continue button.
  Widget _buildDesktop() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 620),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 56),
            decoration: AppTheme.glassOf(context).copyWith(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: context.colors.outline),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _hero,
                const SizedBox(height: 48),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _staggered(0.2, _xpStatTile())),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _staggered(
                          0.35,
                          _statTile(
                            icon: LucideIcons.target,
                            accentColor: AppTheme.duoBlue,
                            label: 'ACCURACY',
                            value: '${widget.accuracy}%',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _staggered(
                          0.5,
                          _statTile(
                            icon: LucideIcons.clock,
                            accentColor: AppTheme.duoGreen,
                            label: 'TIME SPENT',
                            value: _formattedTime,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _reflectionRow,
                const SizedBox(height: 32),
                SizedBox(width: 280, child: _continueButton),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Mobile: original full-height stacked layout.
  Widget _buildMobile() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _hero,
            const SizedBox(height: 32),
            _staggered(
              0.2,
              Row(
                children: [
                  Expanded(child: _xpStatTile()),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _statTile(
                      icon: LucideIcons.target,
                      accentColor: AppTheme.duoBlue,
                      label: 'ACCURACY',
                      value: '${widget.accuracy}%',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _staggered(
              0.4,
              SizedBox(
                width: double.infinity,
                child: _statTile(
                  icon: LucideIcons.clock,
                  accentColor: AppTheme.duoGreen,
                  label: 'TIME SPENT',
                  value: _formattedTime,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _reflectionRow,
            const SizedBox(height: 24),
            _continueButton,
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}