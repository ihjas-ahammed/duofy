import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class _BlankOption {
  final String id;
  final String text;

  const _BlankOption({required this.id, required this.text});
}

/// Fill in the Blank & Synthesis View matching docs/new-theme/slide-p/fill-program.html
class FillInBlankView extends StatefulWidget {
  final Slide slide;
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;
  final VoidCallback? onSubmit;
  final Widget? bottomBar;

  const FillInBlankView({
    super.key,
    required this.slide,
    required this.value,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
    this.onSubmit,
    this.bottomBar,
  });

  @override
  State<FillInBlankView> createState() => _FillInBlankViewState();
}

class _FillInBlankViewState extends State<FillInBlankView> {
  late TextEditingController _controller;
  List<_BlankOption> _suggestions = [];
  final Map<int, String> _assignedChipIds = {}; // blankIndex -> option.id
  int _activeBlankIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _activeBlankIndex = 0;
    _buildSuggestions();
  }

  void _buildSuggestions() {
    _suggestions = [];
    _assignedChipIds.clear();
    int idx = 0;
    if (widget.slide.blankAnswer != null &&
        widget.slide.blankAnswer!.isNotEmpty) {
      final answers = widget.slide.blankAnswer!.split(',').map((s) => s.trim());
      for (final ans in answers) {
        if (ans.isNotEmpty) {
          _suggestions.add(_BlankOption(id: 'ans_${idx++}_$ans', text: ans));
        }
      }
    }
    if (widget.slide.blankDistractors != null) {
      for (final dist in widget.slide.blankDistractors!) {
        final cleanDist = dist.trim();
        if (cleanDist.isNotEmpty) {
          _suggestions.add(
            _BlankOption(id: 'dist_${idx++}_$cleanDist', text: cleanDist),
          );
        }
      }
    }
    _suggestions.shuffle();
  }

  @override
  void didUpdateWidget(FillInBlankView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _controller.text = widget.value;
      _activeBlankIndex = 0;
      _buildSuggestions();
    } else if (_controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSuggestionTapped(
    _BlankOption option, [
    int numBlanks = 1,
    List<String>? userAnswers,
  ]) {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();

    if (numBlanks <= 1 || userAnswers == null) {
      _controller.text = option.text;
      _assignedChipIds[0] = option.id;
      widget.onChanged(option.text);
      return;
    }

    setState(() {
      userAnswers[_activeBlankIndex] = option.text;
      _assignedChipIds[_activeBlankIndex] = option.id;
      widget.onChanged(userAnswers.join(', '));

      // Auto-advance to the next empty blank
      int nextEmpty = -1;
      for (int i = 0; i < numBlanks; i++) {
        final idx = (i + _activeBlankIndex + 1) % numBlanks;
        if (userAnswers[idx].isEmpty) {
          nextEmpty = idx;
          break;
        }
      }
      if (nextEmpty != -1) {
        _activeBlankIndex = nextEmpty;
      } else {
        _activeBlankIndex = (_activeBlankIndex + 1) % numBlanks;
      }
    });
  }

  Widget _buildSuggestionsBank([int numBlanks = 1, List<String>? userAnswers]) {
    final colors = context.colors;
    if (_suggestions.isEmpty || widget.isAnswered) {
      return const SizedBox.shrink();
    }
    final effectiveUserAnswers = userAnswers ?? [widget.value];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0, bottom: 8.0),
          child: Text(
            'SELECT A TOKEN / EXPRESSION:',
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: colors.textSubtle,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _suggestions.map((option) {
            final isSelected = _assignedChipIds.containsValue(option.id) ||
                (numBlanks <= 1
                    ? widget.value == option.text
                    : effectiveUserAnswers.contains(option.text));
            return GestureDetector(
              onTap: () =>
                  _onSuggestionTapped(option, numBlanks, effectiveUserAnswers),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                constraints: const BoxConstraints(minHeight: 44),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primaryBlueLight
                      : colors.cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? colors.primaryBlue
                        : colors.cardBorder,
                    width: isSelected ? 1.8 : 1.0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colors.primaryBlue.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  option.text,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? colors.primaryBlue
                        : colors.textMain,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInlineFallbackField(int numBlanks, List<String> userAnswers) {
    final colors = context.colors;
    if (widget.isAnswered) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.cardBorder),
      ),
      child: TextFormField(
        key: ValueKey('blank_fallback_$_activeBlankIndex'),
        initialValue: userAnswers[_activeBlankIndex],
        textAlign: TextAlign.left,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => widget.onSubmit?.call(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: colors.textMain,
        ),
        decoration: InputDecoration(
          hintText: numBlanks > 1
              ? 'Type answer for blank ${_activeBlankIndex + 1}...'
              : 'Type missing token here...',
          hintStyle: TextStyle(color: colors.textSubtle, fontSize: 13),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
        onChanged: (text) {
          userAnswers[_activeBlankIndex] = text;
          widget.onChanged(userAnswers.join(', '));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bool hasInlineBlank = widget.slide.content.contains('___');

    if (hasInlineBlank) {
      final matches = RegExp(r'___+').allMatches(widget.slide.content);
      final numBlanks = matches.length;

      final List<String> userAnswers = List.generate(numBlanks, (index) => '');
      if (widget.value.isNotEmpty) {
        final splitValues = widget.value.split(',');
        for (int i = 0; i < splitValues.length && i < numBlanks; i++) {
          userAnswers[i] = splitValues[i].trim();
        }
      }

      int blankCounter = 0;
      final String updatedContent = widget.slide.content.replaceAllMapped(
        RegExp(r'___+'),
        (match) {
          final i = blankCounter++;
          final displayWord = userAnswers[i].isEmpty
              ? r'\_\_\_\_\_'
              : userAnswers[i];
          return '**$displayWord**';
        },
      );

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Instruction Header
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
                              LucideIcons.edit3,
                              size: 16,
                              color: colors.primaryBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SYNTHESIZE THE MISSING CONCEPT',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: colors.primaryBlue,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 6),
                              MathMarkdown(
                                data: updatedContent,
                                textStyle: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: colors.textMain,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (numBlanks > 1 && !widget.isAnswered) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(numBlanks, (i) {
                          final isActive = i == _activeBlankIndex;
                          final val = userAnswers[i];
                          return Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _activeBlankIndex = i),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? colors.primaryBlueLight
                                      : colors.cardBg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isActive
                                        ? colors.primaryBlue
                                        : colors.cardBorder,
                                    width: isActive ? 1.5 : 1.0,
                                  ),
                                ),
                                child: Text(
                                  'Blank ${i + 1}: ${val.isEmpty ? "___" : val}',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: isActive
                                        ? colors.primaryBlue
                                        : colors.textMuted,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // 2. Suggestions or Manual Input
                  _suggestions.isEmpty
                      ? _buildInlineFallbackField(numBlanks, userAnswers)
                      : _buildSuggestionsBank(numBlanks, userAnswers),

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

    // Default Fill-In Blank View
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                            LucideIcons.helpCircle,
                            size: 16,
                            color: colors.primaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FILL IN THE BLANK',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: colors.primaryBlue,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 6),
                            MathMarkdown(
                              data: widget.slide.content,
                              textStyle: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: colors.textMain,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Answer Field
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.isAnswered
                          ? (widget.isCorrect
                              ? colors.accentGreen
                              : AppTheme.duoRed)
                          : colors.cardBorder,
                      width: widget.isAnswered ? 1.8 : 1.0,
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    enabled: !widget.isAnswered,
                    onChanged: widget.onChanged,
                    textAlign: TextAlign.left,
                    textInputAction: TextInputAction.done,
                    onSubmitted: widget.isAnswered
                        ? null
                        : (_) => widget.onSubmit?.call(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: widget.isAnswered
                          ? (widget.isCorrect
                              ? colors.accentGreen
                              : AppTheme.duoRed)
                          : colors.textMain,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type your answer here...',
                      hintStyle: TextStyle(
                        color: colors.textSubtle,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                _buildSuggestionsBank(),

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