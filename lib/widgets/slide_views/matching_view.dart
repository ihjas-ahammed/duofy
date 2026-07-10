import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// `matching` slide: pair every left item with its right partner. Tap a left
/// chip, then a right chip, to bind them; tapping a right chip while a left is
/// selected reassigns it, tapping a bound right chip with nothing selected
/// unbinds it. State is keyed by pair INDEX (not display text) so pairs with
/// identical strings stay distinct. The host receives the current
/// leftIndex→rightIndex assignment map via [onChanged]; an assignment is
/// correct when key == value (the right item's original pair index matches).
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
  late Widget _titleWidget;
  late List<Widget> _leftChips; // by pair index
  late List<Widget> _rightChips; // by pair index

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
    _pairs = widget.slide.matchPairs ?? [];
    _rightOrder = List.generate(_pairs.length, (i) => i)
      ..shuffle(math.Random(widget.slide.id.hashCode));

    _titleWidget = MathMarkdown(
      key: ValueKey('title_${widget.slide.id}'),
      data: widget.slide.content.isNotEmpty
          ? widget.slide.content
          : 'Match each item with its pair.',
      textStyle: TextStyle(
          fontSize: 17, color: context.colors.textPrimary, fontWeight: FontWeight.bold),
    );

    _leftChips = [
      for (var i = 0; i < _pairs.length; i++)
        MathMarkdown(
          key: ValueKey('left_${widget.slide.id}_$i'),
          data: _pairs[i].left,
          textStyle: TextStyle(
              fontSize: 14, color: context.colors.textPrimary, fontWeight: FontWeight.bold),
        ),
    ];
    _rightChips = [
      for (var i = 0; i < _pairs.length; i++)
        MathMarkdown(
          key: ValueKey('right_${widget.slide.id}_$i'),
          data: _pairs[i].right,
          textStyle: TextStyle(
              fontSize: 14, color: context.colors.textPrimary, fontWeight: FontWeight.bold),
        ),
    ];
  }

  Color _pairColor(int leftIndex) =>
      _pairColors[leftIndex % _pairColors.length];

  bool _isPairCorrect(int leftIndex) => _assigned[leftIndex] == leftIndex;

  /// The left pair index currently bound to this right item, if any.
  int? _boundLeftFor(int rightIndex) => _assigned.entries
      .where((e) => e.value == rightIndex)
      .map((e) => e.key)
      .firstOrNull;

  void _tapLeft(int leftIndex) {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    setState(() {
      // Selecting never unbinds — a bound left can be selected and re-pointed
      // at a different right; tapping the selected left deselects it.
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

  Widget _chip({
    required Widget child,
    required bool bound,
    required Color color,
    required bool highlighted,
    Color? resultColor,
    required VoidCallback onTap,
  }) {
    final border = resultColor ??
        (bound ? color : (highlighted ? Colors.amber : context.colors.outline));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            constraints: const BoxConstraints(minHeight: 48),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: bound ? color.withOpacity(0.12) : context.colors.surfaceAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: border, width: 2),
            ),
            child: child,
          ),
        ),
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
                  decoration: AppTheme.glassOf(context),
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
                          for (var i = 0; i < _pairs.length; i++)
                            _chip(
                              child: _leftChips[i],
                              bound: _assigned.containsKey(i),
                              color: _pairColor(i),
                              highlighted: _selectedLeft == i,
                              resultColor: widget.isAnswered
                                  ? (_isPairCorrect(i)
                                      ? AppTheme.duoGreen
                                      : AppTheme.duoRed)
                                  : null,
                              onTap: () => _tapLeft(i),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final rightIndex in _rightOrder)
                            Builder(builder: (context) {
                              final boundLeft = _boundLeftFor(rightIndex);
                              return _chip(
                                child: _rightChips[rightIndex],
                                bound: boundLeft != null,
                                color: boundLeft != null
                                    ? _pairColor(boundLeft)
                                    : context.colors.outline,
                                highlighted: false,
                                resultColor: widget.isAnswered && boundLeft != null
                                    ? (_isPairCorrect(boundLeft)
                                        ? AppTheme.duoGreen
                                        : AppTheme.duoRed)
                                    : null,
                                onTap: () => _tapRight(rightIndex),
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
