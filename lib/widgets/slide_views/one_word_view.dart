import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// One-Word Exact Recall View matching docs/new-theme/slide-p/one-word.html
class OneWordView extends StatefulWidget {
  final Slide slide;
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;
  final Widget? bottomBar;

  const OneWordView({
    super.key,
    required this.slide,
    required this.value,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
    this.bottomBar,
  });

  @override
  State<OneWordView> createState() => _OneWordViewState();
}

class _OneWordViewState extends State<OneWordView> {
  late TextEditingController _controller;
  bool _hintRevealed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant OneWordView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _revealFirstLetter() {
    final expected = widget.slide.blankAnswer?.trim() ?? '';
    if (expected.isEmpty) return;
    setState(() => _hintRevealed = true);
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final expected = widget.slide.blankAnswer?.trim() ?? '';
    final firstLetter = expected.isNotEmpty ? expected[0].toUpperCase() : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header Title & Category Breadcrumb
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'One-Word Exact Recall',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: colors.textMain,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Direct Memory Retrieval',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colors.textMuted,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.textSubtle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Single Term',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // 2. Main Question Card
                Container(
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(24),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // Badge Icon Circle
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.accentGreenLight,
                          border: Border.all(
                            color: colors.accentGreen.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            LucideIcons.target,
                            color: colors.accentGreen,
                            size: 20,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '→ QUESTION ←',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: colors.textSubtle,
                          letterSpacing: 1.5,
                        ),
                      ),

                      const SizedBox(height: 10),

                      MathMarkdown(
                        data: widget.slide.content,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: colors.textMain,
                          height: 1.4,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // 3. Your Answer Input Section
                Column(
                  children: [
                    Text(
                      '→ YOUR ANSWER ←',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: colors.textSubtle,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.cardBg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: widget.isAnswered
                              ? (widget.isCorrect
                                  ? colors.accentGreen
                                  : AppTheme.duoRed)
                              : colors.primaryBlue,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (widget.isAnswered
                                    ? (widget.isCorrect
                                        ? colors.accentGreen
                                        : AppTheme.duoRed)
                                    : colors.primaryBlue)
                                .withValues(alpha: 0.16),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.accentGreenLight,
                            ),
                            child: Center(
                              child: Icon(
                                LucideIcons.penTool,
                                size: 15,
                                color: colors.accentGreen,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              enabled: !widget.isAnswered,
                              onChanged: widget.onChanged,
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: widget.isAnswered
                                    ? (widget.isCorrect
                                        ? colors.accentGreen
                                        : AppTheme.duoRed)
                                    : colors.textMain,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type term here...',
                                hintStyle: TextStyle(
                                  color: colors.textSubtle,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                          if (widget.isAnswered)
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.isCorrect
                                    ? colors.accentGreenLight
                                    : AppTheme.duoRed.withValues(alpha: 0.12),
                              ),
                              child: Icon(
                                widget.isCorrect
                                    ? LucideIcons.check
                                    : LucideIcons.x,
                                size: 14,
                                color: widget.isCorrect
                                    ? colors.accentGreen
                                    : AppTheme.duoRed,
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // First letter hint pill
                    if (expected.isNotEmpty &&
                        !widget.isAnswered &&
                        !_hintRevealed)
                      GestureDetector(
                        onTap: _revealFirstLetter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: colors.badgeBg,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: colors.cardBorder),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.sparkles,
                                size: 13,
                                color: colors.primaryBlue,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Reveal First Letter',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: colors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (_hintRevealed && !widget.isAnswered)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primaryBlueLight,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: colors.primaryBlue.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.lightbulb,
                              size: 13,
                              color: colors.primaryBlue,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Starts with: $firstLetter...',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: colors.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
          if (widget.bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 16),
                  widget.bottomBar!,
                ],
              ),
            ),
        ],
      ),
    );
  }
}