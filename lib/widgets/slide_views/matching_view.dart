import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Conceptual Matching Pairs View matching docs/new-theme/slide-p/math-pairs.html
class MatchingView extends StatefulWidget {
  final Slide slide;
  final bool isAnswered;
  final bool isCorrect;
  final void Function(Map<int, int> assignments) onChanged;
  final Widget? bottomBar;

  const MatchingView({
    super.key,
    required this.slide,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
    this.bottomBar,
  });

  @override
  State<MatchingView> createState() => _MatchingViewState();
}

class _MatchingViewState extends State<MatchingView> {
  late List<MatchPair> _pairs;
  late List<int> _rightOrder; // pair indices, shuffled for the right column
  final Map<int, int> _assigned = {}; // left pair index -> right pair index
  int? _selectedLeft;

  static const List<Color> _pairColors = [
    AppTheme.duoBlue,
    AppTheme.duoViolet,
    AppTheme.duoOrange,
    AppTheme.duoGreen,
    Color(0xFFF472B6),
    Color(0xFF22D3EE),
  ];

  @override
  void initState() {
    super.initState();
    _initSlide();
  }

  @override
  void didUpdateWidget(covariant MatchingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _initSlide();
    }
  }

  void _initSlide() {
    _assigned.clear();
    _selectedLeft = null;
    _pairs = widget.slide.matchPairs ?? [];
    _rightOrder = List.generate(_pairs.length, (i) => i)
      ..shuffle(math.Random(widget.slide.id.hashCode));
  }

  Color _pairColor(int leftIndex) =>
      _pairColors[leftIndex % _pairColors.length];

  bool _isPairCorrect(int leftIndex) {
    final assignedRightIdx = _assigned[leftIndex];
    if (assignedRightIdx == null) return false;
    if (leftIndex < 0 || leftIndex >= _pairs.length) return false;
    if (assignedRightIdx < 0 || assignedRightIdx >= _pairs.length) return false;
    return _pairs[leftIndex].right.trim().toLowerCase() ==
        _pairs[assignedRightIdx].right.trim().toLowerCase();
  }

  /// The left pair index currently bound to this right item, if any.
  int? _boundLeftFor(int rightIndex) => _assigned.entries
      .where((e) => e.value == rightIndex)
      .map((e) => e.key)
      .firstOrNull;

  void _tapLeft(int leftIndex) {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    setState(() {
      _selectedLeft = _selectedLeft == leftIndex ? null : leftIndex;
    });
    widget.onChanged(Map.of(_assigned));
  }

  void _tapRight(int rightIndex) {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    setState(() {
      if (_selectedLeft != null) {
        // Selection wins: (re)assign, stealing this right from any other left.
        _assigned.removeWhere((_, v) => v == rightIndex);
        _assigned[_selectedLeft!] = rightIndex;
        _selectedLeft = null;
      } else {
        final boundLeft = _boundLeftFor(rightIndex);
        if (boundLeft != null) {
          // Nothing selected: unbind and pick the freed left back up.
          _assigned.remove(boundLeft);
          _selectedLeft = boundLeft;
        }
      }
    });
    widget.onChanged(Map.of(_assigned));
  }

  void _resetMatches() {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    setState(() {
      _assigned.clear();
      _selectedLeft = null;
    });
    widget.onChanged({});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final totalPairs = _pairs.length;
    final matchedCount = _assigned.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header Title & Objective Banner
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Matching Pairs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: colors.textMain,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.slide.content.isNotEmpty
                          ? widget.slide.content
                          : 'Match each concept on the left with its corresponding partner.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // 2. Column Headers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.boxes,
                              size: 13,
                              color: colors.primaryBlue,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'CONCEPT / TERM',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: colors.primaryBlue,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.link2,
                              size: 13,
                              color: Color(0xFF8B5CF6),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'DEFINITION / MATCH',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF8B5CF6),
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // 3. Matching Pairs Grid (2 Columns)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column
                    Expanded(
                      child: Column(
                        children: List.generate(_pairs.length, (leftIdx) {
                          final isSelected = _selectedLeft == leftIdx;
                          final isBound = _assigned.containsKey(leftIdx);
                          final boundColor = _pairColor(leftIdx);

                          Color cardBg = colors.cardBg;
                          Color cardBorder = colors.cardBorder;
                          Color textColor = colors.textMain;

                          if (widget.isAnswered && isBound) {
                            final correct = _isPairCorrect(leftIdx);
                            cardBorder = correct
                                ? colors.accentGreen
                                : AppTheme.duoRed;
                            cardBg = correct
                                ? colors.accentGreenLight
                                : AppTheme.duoRed.withValues(alpha: 0.12);
                            textColor = correct
                                ? colors.accentGreen
                                : AppTheme.duoRed;
                          } else if (isSelected) {
                            cardBorder = colors.primaryBlue;
                            cardBg = colors.primaryBlueLight;
                            textColor = colors.primaryBlue;
                          } else if (isBound) {
                            cardBorder = boundColor;
                            cardBg = boundColor.withValues(alpha: 0.12);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () => _tapLeft(leftIdx),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                constraints: const BoxConstraints(
                                  minHeight: 64,
                                ),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: cardBorder,
                                    width: isSelected || isBound ? 1.8 : 1.0,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: colors.primaryBlue
                                                .withValues(alpha: 0.18),
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isBound
                                              ? boundColor
                                              : (isSelected
                                                  ? colors.primaryBlue
                                                  : colors.cardBorder),
                                          width: 1.5,
                                        ),
                                        color: isBound
                                            ? boundColor
                                            : (isSelected
                                                ? colors.primaryBlue
                                                : Colors.transparent),
                                      ),
                                      child: isBound
                                          ? const Icon(
                                              LucideIcons.check,
                                              size: 11,
                                              color: Colors.white,
                                            )
                                          : (isSelected
                                              ? const Center(
                                                  child: Icon(
                                                    LucideIcons.dot,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : null),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: MathMarkdown(
                                        data: _pairs[leftIdx].left,
                                        selectable: false,
                                        textStyle: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Right Column
                    Expanded(
                      child: Column(
                        children: _rightOrder.map((rightIdx) {
                          final boundLeft = _boundLeftFor(rightIdx);
                          final isBound = boundLeft != null;
                          final boundColor = isBound
                              ? _pairColor(boundLeft)
                              : colors.cardBorder;

                          Color cardBg = colors.cardBg;
                          Color cardBorder = colors.cardBorder;
                          Color textColor = colors.textMain;

                          if (widget.isAnswered && isBound) {
                            final correct = _isPairCorrect(boundLeft);
                            cardBorder = correct
                                ? colors.accentGreen
                                : AppTheme.duoRed;
                            cardBg = correct
                                ? colors.accentGreenLight
                                : AppTheme.duoRed.withValues(alpha: 0.12);
                            textColor = correct
                                ? colors.accentGreen
                                : AppTheme.duoRed;
                          } else if (isBound) {
                            cardBorder = boundColor;
                            cardBg = boundColor.withValues(alpha: 0.12);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () => _tapRight(rightIdx),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                constraints: const BoxConstraints(
                                  minHeight: 64,
                                ),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: cardBorder,
                                    width: isBound ? 1.8 : 1.0,
                                  ),
                                  boxShadow: isBound
                                      ? [
                                          BoxShadow(
                                            color: boundColor.withValues(
                                              alpha: 0.14,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isBound
                                              ? boundColor
                                              : colors.cardBorder,
                                          width: 1.5,
                                        ),
                                        color: isBound
                                            ? boundColor
                                            : Colors.transparent,
                                      ),
                                      child: isBound
                                          ? const Icon(
                                              LucideIcons.check,
                                              size: 11,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: MathMarkdown(
                                        data: _pairs[rightIdx].right,
                                        selectable: false,
                                        textStyle: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 4. Bottom Utility Bar (Instruction & Reset Action)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colors.cardBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.helpCircle,
                            size: 14,
                            color: colors.primaryBlue,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Matched: $matchedCount of $totalPairs pairs',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      if (!widget.isAnswered && matchedCount > 0)
                        GestureDetector(
                          onTap: _resetMatches,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colors.badgeBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colors.cardBorder),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.rotateCcw,
                                  size: 11,
                                  color: colors.textMuted,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Reset',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
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