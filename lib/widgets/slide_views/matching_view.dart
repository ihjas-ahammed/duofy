import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// `matching` slide: pair every left item with its right partner. Tap a left
/// chip, then a right chip, to bind them (tap a bound chip to unbind). The
/// host receives the current left→right assignment map via [onChanged] and
/// validates it against [Slide.matchPairs].
class MatchingView extends StatefulWidget {
  final Slide slide;
  final bool isAnswered;
  final bool isCorrect;
  final void Function(Map<String, String> assignments) onChanged;
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
  late List<String> _lefts;
  late List<String> _rights; // shuffled
  final Map<String, String> _assigned = {}; // left -> right
  String? _selectedLeft;
  late Widget _titleWidget;
  late Map<String, Widget> _chipWidgets;

  static const List<Color> _pairColors = [
    AppTheme.duoBlue,
    AppTheme.duoViolet,
    AppTheme.duoOrange,
    AppTheme.duoGreen,
    Color(0xFFf472b6),
    Color(0xFF22d3ee),
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
    final pairs = widget.slide.matchPairs ?? [];
    _lefts = [for (final p in pairs) p.left];
    _rights = [for (final p in pairs) p.right]
      ..shuffle(math.Random(widget.slide.id.hashCode));

    _titleWidget = MathMarkdown(
      key: ValueKey('title_${widget.slide.id}'),
      data: widget.slide.content.isNotEmpty
          ? widget.slide.content
          : 'Match each item with its pair.',
      textStyle: const TextStyle(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    );

    _chipWidgets = {};
    for (final p in pairs) {
      _chipWidgets[p.left] = MathMarkdown(
        key: ValueKey('left_${widget.slide.id}_${p.left}'),
        data: p.left,
        textStyle: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
      );
      _chipWidgets[p.right] = MathMarkdown(
        key: ValueKey('right_${widget.slide.id}_${p.right}'),
        data: p.right,
        textStyle: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
      );
    }
  }

  Color _pairColor(String left) =>
      _pairColors[_lefts.indexOf(left) % _pairColors.length];

  bool _isPairCorrect(String left) {
    final pairs = widget.slide.matchPairs ?? [];
    final expected = pairs.firstWhere((p) => p.left == left,
        orElse: () => MatchPair(left: '', right: ''));
    return _assigned[left] == expected.right;
  }

  void _tapLeft(String left) {
    if (widget.isAnswered) return;
    setState(() {
      if (_assigned.containsKey(left)) {
        _assigned.remove(left);
        _selectedLeft = left;
      } else {
        _selectedLeft = _selectedLeft == left ? null : left;
      }
    });
    widget.onChanged(Map.of(_assigned));
  }

  void _tapRight(String right) {
    if (widget.isAnswered) return;
    setState(() {
      final boundLeft = _assigned.entries
          .where((e) => e.value == right)
          .map((e) => e.key)
          .firstOrNull;
      if (boundLeft != null) {
        _assigned.remove(boundLeft);
        _selectedLeft = boundLeft;
      } else if (_selectedLeft != null) {
        _assigned[_selectedLeft!] = right;
        _selectedLeft = null;
      }
    });
    widget.onChanged(Map.of(_assigned));
  }

  Widget _chip({
    required String text,
    required bool bound,
    required Color color,
    required bool highlighted,
    Color? resultColor,
    required VoidCallback onTap,
  }) {
    final border = resultColor ??
        (bound ? color : (highlighted ? Colors.amber : Colors.white12));
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bound ? color.withOpacity(0.12) : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 2),
        ),
        child: _chipWidgets[text] ?? const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppTheme.glassDecoration,
                  child: _titleWidget,
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final left in _lefts)
                            _chip(
                              text: left,
                              bound: _assigned.containsKey(left),
                              color: _pairColor(left),
                              highlighted: _selectedLeft == left,
                              resultColor: widget.isAnswered
                                  ? (_isPairCorrect(left)
                                      ? AppTheme.duoGreen
                                      : AppTheme.duoRed)
                                  : null,
                              onTap: () => _tapLeft(left),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final right in _rights)
                            Builder(builder: (context) {
                              final boundLeft = _assigned.entries
                                  .where((e) => e.value == right)
                                  .map((e) => e.key)
                                  .firstOrNull;
                              return _chip(
                                text: right,
                                bound: boundLeft != null,
                                color: boundLeft != null
                                    ? _pairColor(boundLeft)
                                    : Colors.white12,
                                highlighted: false,
                                resultColor: widget.isAnswered && boundLeft != null
                                    ? (_isPairCorrect(boundLeft)
                                        ? AppTheme.duoGreen
                                        : AppTheme.duoRed)
                                    : null,
                                onTap: () => _tapRight(right),
                              );
                            }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 24),
                  widget.bottomBar!,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
