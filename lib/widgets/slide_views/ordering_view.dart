import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Chronological & Logic Ordering View matching docs/new-theme/slide-p/reorder.html
class OrderingView extends StatefulWidget {
  final Slide slide;
  final bool isAnswered;
  final bool isCorrect;
  final void Function(List<String> order) onChanged;
  final Widget? bottomBar;

  const OrderingView({
    super.key,
    required this.slide,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
    this.bottomBar,
  });

  @override
  State<OrderingView> createState() => _OrderingViewState();
}

class _OrderingViewState extends State<OrderingView> {
  late List<String> _current;

  @override
  void initState() {
    super.initState();
    final correct = widget.slide.orderItems ?? [];
    _current = List.of(correct);
    final rng = math.Random(widget.slide.id.hashCode);
    _current.shuffle(rng);
    if (_current.length > 1 && _listEquals(_current, correct)) {
      final first = _current.removeAt(0);
      _current.add(first);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onChanged(List.of(_current));
    });
  }

  static bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final correct = widget.slide.orderItems ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Header Prompt Card
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
                    color: colors.primaryBlueLight,
                  ),
                  child: Center(
                    child: Icon(
                      LucideIcons.listOrdered,
                      size: 16,
                      color: colors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MathMarkdown(
                    data: widget.slide.content.isNotEmpty
                        ? widget.slide.content
                        : 'Order the steps from first to last in proper sequence.',
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: colors.textMain,
                      height: 1.35,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 2. Reorderable Sequence List
          Expanded(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: !widget.isAnswered,
              physics: const BouncingScrollPhysics(),
              itemCount: _current.length,
              // ignore: deprecated_member_use
              onReorder: (oldIndex, newIndex) {
                if (widget.isAnswered) return;
                HapticFeedback.selectionClick();
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = _current.removeAt(oldIndex);
                  _current.insert(newIndex, item);
                });
                widget.onChanged(List.of(_current));
              },
              itemBuilder: (context, i) {
                final item = _current[i];
                final isLast = i == _current.length - 1;

                Color cardBg = colors.cardBg;
                Color cardBorder = colors.cardBorder;
                Color badgeBg = colors.primaryBlueLight;
                Color badgeTextColor = colors.primaryBlue;

                if (widget.isAnswered) {
                  final isItemCorrect =
                      i < correct.length && correct[i] == item;
                  if (isItemCorrect) {
                    cardBorder = colors.accentGreen;
                    cardBg = colors.accentGreenLight;
                    badgeBg = colors.accentGreen;
                    badgeTextColor = Colors.white;
                  } else {
                    cardBorder = AppTheme.duoRed;
                    cardBg = AppTheme.duoRed.withValues(alpha: 0.12);
                    badgeBg = AppTheme.duoRed;
                    badgeTextColor = Colors.white;
                  }
                }

                return Column(
                  key: ValueKey('order-$item-$i'),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: cardBorder, width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: colors.isDark ? 0.2 : 0.03,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          if (!widget.isAnswered)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                LucideIcons.gripVertical,
                                size: 16,
                                color: colors.textSubtle,
                              ),
                            ),
                          // Stage Number Badge
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: badgeBg,
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: badgeTextColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MathMarkdown(
                              data: item,
                              textStyle: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: colors.textMain,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Icon(
                          LucideIcons.arrowDown,
                          size: 13,
                          color: colors.textSubtle.withValues(alpha: 0.6),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),

          if (widget.bottomBar != null) widget.bottomBar!,
        ],
      ),
    );
  }
}