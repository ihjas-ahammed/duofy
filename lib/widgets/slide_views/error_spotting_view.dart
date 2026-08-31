import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Error Spotting & Logic Bug Hunt View matching docs/new-theme/slide-p/find-error.html
class ErrorSpottingView extends StatefulWidget {
  final Slide slide;
  final int? selectedIndex;
  final bool isAnswered;
  final bool isCorrect;
  final ValueChanged<int> onSelect;
  final Widget? bottomBar;

  const ErrorSpottingView({
    super.key,
    required this.slide,
    this.selectedIndex,
    required this.isAnswered,
    required this.isCorrect,
    required this.onSelect,
    this.bottomBar,
  });

  @override
  State<ErrorSpottingView> createState() => _ErrorSpottingViewState();
}

class _ErrorSpottingViewState extends State<ErrorSpottingView> {
  int? _selectedStep;

  @override
  void initState() {
    super.initState();
    _selectedStep = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant ErrorSpottingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _selectedStep = widget.selectedIndex;
    } else if (widget.selectedIndex != _selectedStep) {
      _selectedStep = widget.selectedIndex;
    }
  }

  void _onStepTap(int index) {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    setState(() {
      _selectedStep = index;
    });
    widget.onSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final List<String> steps = (widget.slide.proofSteps != null &&
            widget.slide.proofSteps!.isNotEmpty)
        ? widget.slide.proofSteps!
        : (widget.slide.options?.map((o) => o.text).toList() ?? <String>[]);

    final int targetErrorIndex = widget.slide.errorIndex ??
        (widget.slide.options != null
            ? widget.slide.options!.indexWhere((o) => o.isCorrect)
            : 0);

    final int correctIndex = targetErrorIndex >= 0 ? targetErrorIndex : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header Information
                Container(
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: colors.isDark ? 0.35 : 0.04,
                        ),
                        blurRadius: 18,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.duoOrange.withValues(alpha: 0.12),
                          border: Border.all(
                            color: AppTheme.duoOrange.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            LucideIcons.search,
                            size: 16,
                            color: AppTheme.duoOrange,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'BUG HUNT / ERROR SPOTTING',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.duoOrange,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.duoOrange.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'SPOT THE FLAW',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.duoOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            MathMarkdown(
                              data: widget.slide.content.isNotEmpty
                                  ? widget.slide.content
                                  : 'Identify which line or step contains a logical error or invalid deduction.',
                              textStyle: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: colors.textMain,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 2. Inspection Step List
                Column(
                  children: List.generate(steps.length, (idx) {
                    final isSelected = _selectedStep == idx;
                    final isCorrectChoice = idx == correctIndex;

                    Color itemBg = colors.cardBg;
                    Color itemBorder = colors.cardBorder;
                    Color badgeBg = colors.badgeBg;
                    Color badgeColor = colors.textSubtle;

                    if (widget.isAnswered) {
                      if (isSelected) {
                        itemBorder = widget.isCorrect
                            ? colors.accentGreen
                            : AppTheme.duoRed;
                        itemBg = widget.isCorrect
                            ? colors.accentGreenLight
                            : AppTheme.duoRed.withValues(alpha: 0.12);
                        badgeBg = widget.isCorrect
                            ? colors.accentGreen
                            : AppTheme.duoRed;
                        badgeColor = Colors.white;
                      } else if (isCorrectChoice) {
                        itemBorder = colors.accentGreen;
                        itemBg = colors.accentGreenLight;
                        badgeBg = colors.accentGreen;
                        badgeColor = Colors.white;
                      }
                    } else if (isSelected) {
                      itemBorder = AppTheme.duoOrange;
                      itemBg = AppTheme.duoOrange.withValues(alpha: 0.1);
                      badgeBg = AppTheme.duoOrange;
                      badgeColor = Colors.white;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GestureDetector(
                        onTap: () => _onStepTap(idx),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: itemBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: itemBorder,
                              width: isSelected ? 1.8 : 1.0,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppTheme.duoOrange.withValues(
                                        alpha: 0.25,
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
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: badgeBg,
                                ),
                                child: Center(
                                  child: Text(
                                    '${idx + 1}',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w800,
                                      color: badgeColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MathMarkdown(
                                  data: steps[idx],
                                  selectable: false,
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: colors.textMain,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  LucideIcons.alertTriangle,
                                  size: 16,
                                  color: AppTheme.duoOrange,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
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