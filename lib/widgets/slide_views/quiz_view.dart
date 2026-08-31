import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Active Retrieval Quiz View matching docs/new-theme/slide-p/omr.html
class QuizView extends StatelessWidget {
  final Slide slide;
  final String? selectedOptionId;
  final bool isAnswered;
  final Function(String) onSelect;
  final void Function(Slide updated)? onUpdateSlide;
  final Widget? bottomBar;

  const QuizView({
    super.key,
    required this.slide,
    required this.selectedOptionId,
    required this.isAnswered,
    required this.onSelect,
    this.onUpdateSlide,
    this.bottomBar,
  });

  Future<void> _editOption(BuildContext context, QuizOption opt) async {
    if (onUpdateSlide == null) return;
    final ctrl = TextEditingController(text: opt.text);
    final newText = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.cardBg,
        title: Text(
          'Edit option',
          style: TextStyle(
            color: context.colors.textMain,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: ctrl,
          maxLines: null,
          autofocus: true,
          style: TextStyle(color: context.colors.textMain),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colors.mathBoxBg,
            hintText: 'Option text (Markdown / LaTeX supported)',
            hintStyle: TextStyle(color: context.colors.textSubtle),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textMuted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (newText == null || newText.isEmpty || newText == opt.text) return;
    final updatedOpts = slide.options!
        .map((o) => o.id == opt.id ? o.copyWith(text: newText) : o)
        .toList();
    onUpdateSlide!(slide.copyWith(options: updatedOpts));
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
                // 1. Question Card matching omr.html
                Container(
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: colors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: colors.isDark ? 0.35 : 0.04,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag header row
                      Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primaryBlueLight,
                            ),
                            child: Center(
                              child: Text(
                                'Q',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: colors.primaryBlue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ACTIVE RETRIEVAL',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              color: colors.textSubtle,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Question prompt
                      MathMarkdown(
                        data: slide.content,
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: colors.textMain,
                          height: 1.35,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // 2. Options List
                if (slide.options != null)
                  ...slide.options!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final opt = entry.value;
                    final isSelected = selectedOptionId == opt.id;
                    final optionLetter = String.fromCharCode(65 + index);

                    Color optBg = colors.cardBg;
                    Color optBorder = colors.cardBorder;
                    Color optTextColor = colors.textMain;
                    Color circleBg = colors.badgeBg;
                    Color circleTextColor = colors.textMuted;
                    double borderWidth = 1.0;

                    if (isAnswered) {
                      if (opt.isCorrect) {
                        optBorder = colors.accentGreen;
                        optBg = colors.accentGreenLight;
                        optTextColor = colors.accentGreen;
                        circleBg = colors.accentGreen;
                        circleTextColor = Colors.white;
                        borderWidth = 1.8;
                      } else if (isSelected && !opt.isCorrect) {
                        optBorder = AppTheme.duoRed;
                        optBg = AppTheme.duoRed.withValues(alpha: 0.12);
                        optTextColor = AppTheme.duoRed;
                        circleBg = AppTheme.duoRed;
                        circleTextColor = Colors.white;
                        borderWidth = 1.8;
                      }
                    } else if (isSelected) {
                      optBorder = colors.primaryBlue;
                      optBg = colors.isDark
                          ? const Color(0xFF0F1B33)
                          : const Color(0xFFEFF6FF);
                      optTextColor = colors.primaryBlue;
                      circleBg = colors.primaryBlue;
                      circleTextColor = Colors.white;
                      borderWidth = 1.8;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: GestureDetector(
                        onTap: isAnswered
                            ? null
                            : () {
                                HapticFeedback.selectionClick();
                                onSelect(opt.id);
                              },
                        onDoubleTap: onUpdateSlide == null
                            ? null
                            : () => _editOption(context, opt),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: optBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: optBorder,
                              width: borderWidth,
                            ),
                            boxShadow: isSelected && !isAnswered
                                ? [
                                    BoxShadow(
                                      color: colors.primaryBlue.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 14,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              // Circular Letter Badge
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: circleBg,
                                ),
                                child: Center(
                                  child: Text(
                                    optionLetter,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: circleTextColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Option Markdown Content
                              Expanded(
                                child: MathMarkdown(
                                  data: opt.text,
                                  selectable: false,
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: optTextColor,
                                    height: 1.35,
                                  ),
                                ),
                              ),

                              if (onUpdateSlide != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Icon(
                                    LucideIcons.edit2,
                                    size: 13,
                                    color: colors.textSubtle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                const SizedBox(height: 16),
              ],
            ),
          ),
          if (bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 16),
                  bottomBar!,
                ],
              ),
            ),
        ],
      ),
    );
  }
}