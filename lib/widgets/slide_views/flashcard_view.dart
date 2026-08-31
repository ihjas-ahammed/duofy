import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Spaced Repetition 3D Flip Flashcard View matching docs/new-theme/slide-p/flashcards.html
class FlashcardView extends StatefulWidget {
  final Slide slide;
  final void Function(bool remembered) onSelfGrade;

  const FlashcardView({
    super.key,
    required this.slide,
    required this.onSelfGrade,
  });

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  bool _flipped = false;
  bool _graded = false;

  @override
  void didUpdateWidget(covariant FlashcardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _flipped = false;
      _graded = false;
    }
  }

  void _toggleFlip() {
    HapticFeedback.selectionClick();
    setState(() => _flipped = !_flipped);
  }

  void _handleGrade(bool remembered) {
    if (_graded) return;
    if (remembered) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.lightImpact();
    }
    setState(() => _graded = true);
    widget.onSelfGrade(remembered);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Spaced Repetition Stability Gauge Card
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: colors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: colors.isDark ? 0.25 : 0.03,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.brain,
                            size: 18,
                            color: colors.primaryBlue,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ACTIVE RETRIEVAL',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w800,
                                  color: colors.textSubtle,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                'Spaced Repetition Flashcard',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: colors.textMain,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colors.accentGreenLight,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.sparkles,
                              size: 11,
                              color: colors.accentGreen,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Review Deck',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                color: colors.accentGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // 2. 3D Flip Card Container
                GestureDetector(
                  onTap: _toggleFlip,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: _flipped ? 1 : 0),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutBack,
                    builder: (context, t, _) {
                      final showBack = t > 0.5;
                      final angle = t * math.pi;

                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0012)
                          ..rotateY(angle),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateY(showBack ? math.pi : 0),
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 280),
                            decoration: BoxDecoration(
                              color: colors.cardBg,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: showBack
                                    ? colors.accentGreen
                                    : colors.primaryBlue,
                                width: 1.8,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (showBack
                                          ? colors.accentGreen
                                          : colors.primaryBlue)
                                      .withValues(alpha: 0.18),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Card Top Bar
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: showBack
                                            ? colors.accentGreenLight
                                            : colors.primaryBlueLight,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        showBack
                                            ? 'ANSWER / KEY CONCEPT'
                                            : 'PROMPT / QUESTION',
                                        style: TextStyle(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w800,
                                          color: showBack
                                              ? colors.accentGreen
                                              : colors.primaryBlue,
                                          letterSpacing: 0.6,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      LucideIcons.rotateCcw,
                                      size: 14,
                                      color: colors.textSubtle,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Card Body Content
                                MathMarkdown(
                                  data: showBack
                                      ? (widget.slide.blankAnswer?.isNotEmpty ==
                                                true
                                            ? widget.slide.blankAnswer!
                                            : widget.slide.content)
                                      : widget.slide.content,
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: colors.textMain,
                                    height: 1.4,
                                    letterSpacing: -0.2,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Flip instruction footer
                                Text(
                                  showBack
                                      ? 'Tap to see prompt'
                                      : 'Tap card to flip and verify answer',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: colors.textSubtle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // 3. 4-Tier Spaced Repetition Grading Bar
                if (!_graded) ...[
                  Text(
                    'RATE YOUR RECALL FIDELITY:',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: colors.textSubtle,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      // Again (<10m)
                      Expanded(
                        child: _buildGradeButton(
                          title: 'Again',
                          interval: '<10m',
                          color: AppTheme.duoRed,
                          bgColor: AppTheme.duoRed.withValues(alpha: 0.12),
                          onTap: () => _handleGrade(false),
                        ),
                      ),
                      const SizedBox(width: 6),

                      // Hard (1d)
                      Expanded(
                        child: _buildGradeButton(
                          title: 'Hard',
                          interval: '1d',
                          color: AppTheme.duoOrange,
                          bgColor: AppTheme.duoOrange.withValues(alpha: 0.12),
                          onTap: () => _handleGrade(false),
                        ),
                      ),
                      const SizedBox(width: 6),

                      // Good (3d)
                      Expanded(
                        child: _buildGradeButton(
                          title: 'Good',
                          interval: '3d',
                          color: colors.primaryBlue,
                          bgColor: colors.primaryBlueLight,
                          onTap: () => _handleGrade(true),
                        ),
                      ),
                      const SizedBox(width: 6),

                      // Easy (7d)
                      Expanded(
                        child: _buildGradeButton(
                          title: 'Easy',
                          interval: '7d',
                          color: colors.accentGreen,
                          bgColor: colors.accentGreenLight,
                          onTap: () => _handleGrade(true),
                        ),
                      ),
                    ],
                  ),
                ] else
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.accentGreenLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colors.accentGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.checkCircle2,
                          size: 16,
                          color: colors.accentGreen,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Graded & Added to Spaced Queue',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: colors.accentGreen,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeButton({
    required String title,
    required String interval,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.35), width: 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              interval,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}