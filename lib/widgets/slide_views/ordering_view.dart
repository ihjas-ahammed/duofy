import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// `ordering` slide: drag the shuffled items into their correct sequence.
/// The host receives the current order via [onChanged] and validates it
/// against [Slide.orderItems].
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
    // Deterministic shuffle (stable across rebuilds); reshuffle once if the
    // shuffle landed on the already-correct order.
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
    final correct = widget.slide.orderItems ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassOf(context),
            child: MathMarkdown(
              data: widget.slide.content.isNotEmpty
                  ? widget.slide.content
                  : 'Drag the steps into the correct order.',
              textStyle: TextStyle(
                fontSize: 17,
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: !widget.isAnswered,
              physics: const BouncingScrollPhysics(),
              itemCount: _current.length,
              onReorder: (oldIndex, newIndex) {
                if (widget.isAnswered) return;
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = _current.removeAt(oldIndex);
                  _current.insert(newIndex, item);
                });
                widget.onChanged(List.of(_current));
              },
              itemBuilder: (context, i) {
                final item = _current[i];
                final resultColor = widget.isAnswered
                    ? (i < correct.length && correct[i] == item
                          ? AppTheme.duoGreen
                          : AppTheme.duoRed)
                    : null;
                return Container(
                  key: ValueKey('order-$item'),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceAlt,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: resultColor ?? context.colors.outline,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (resultColor ?? AppTheme.duoBlue).withValues(
                            alpha: 0.15,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: resultColor ?? AppTheme.duoBlue,
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MathMarkdown(
                          data: item,
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: context.colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!widget.isAnswered)
                        Icon(
                          LucideIcons.gripVertical,
                          color: context.colors.textFaint,
                          size: 18,
                        ),
                    ],
                  ),
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
