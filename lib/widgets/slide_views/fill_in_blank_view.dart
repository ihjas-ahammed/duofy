import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';
// BlankSyntax and BlankBuilder are now internal to MathMarkdown.

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

class _BlankOption {
  final String id;
  final String text;

  const _BlankOption({required this.id, required this.text});
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
          _suggestions.add(_BlankOption(id: 'dist_${idx++}_$cleanDist', text: cleanDist));
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
    if (_suggestions.isEmpty || widget.isAnswered) {
      return const SizedBox.shrink();
    }
    final effectiveUserAnswers = userAnswers ?? [widget.value];

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: _suggestions.map((option) {
          final isSelected = _assignedChipIds.containsValue(option.id) ||
              (numBlanks <= 1
                  ? widget.value == option.text
                  : effectiveUserAnswers.contains(option.text));
          return GestureDetector(
            onTap: () =>
                _onSuggestionTapped(option, numBlanks, effectiveUserAnswers),
            child: Container(
              constraints: BoxConstraints(minHeight: 48),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.duoBlue.withValues(alpha: 0.2)
                    : context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.duoBlue
                      : context.colors.textFaint,
                  width: 2,
                ),
              ),
              child: Text(
                option.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? AppTheme.duoBlue
                      : context.colors.textPrimary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Fallback for when the AI returned no blankAnswer/blankDistractors to
  // build a suggestion bank from — without this, CHECK stays permanently
  // disabled with no way to answer the inline blank(s).
  Widget _buildInlineFallbackField(int numBlanks, List<String> userAnswers) {
    if (widget.isAnswered) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: TextFormField(
        key: ValueKey('blank_fallback_$_activeBlankIndex'),
        initialValue: userAnswers[_activeBlankIndex],
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => widget.onSubmit?.call(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Colors.amber,
        ),
        decoration: InputDecoration(
          hintText: numBlanks > 1
              ? 'Type answer for blank ${_activeBlankIndex + 1}'
              : 'Type your answer',
          hintStyle: TextStyle(color: context.colors.textFaint, fontSize: 14),
          filled: true,
          fillColor: context.colors.surfaceAlt,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
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
    bool hasInlineBlank = widget.slide.content.contains('___');

    if (hasInlineBlank) {
      final matches = RegExp(r'___+').allMatches(widget.slide.content);
      final numBlanks = matches.length;

      // Parse userAnswers from widget.value
      final List<String> userAnswers = List.generate(numBlanks, (index) => '');
      if (widget.value.isNotEmpty) {
        final splitValues = widget.value.split(',');
        for (int i = 0; i < splitValues.length && i < numBlanks; i++) {
          userAnswers[i] = splitValues[i].trim();
        }
      }

      // Rebuild updatedContent replacing each ___ sequentially with the user answer
      int blankCounter = 0;
      String updatedContent = widget.slide.content.replaceAllMapped(
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
        padding: const EdgeInsets.all(24),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.isDark
                          ? context.colors.surface
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.duoBlue.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.duoBlue.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 4,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.duoBlue, AppTheme.duoViolet, AppTheme.duoGreen],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: MathMarkdown(data: updatedContent),
                        ),
                      ],
                    ),
                  ),
                  if (numBlanks > 1 && !widget.isAnswered) ...[
                    const SizedBox(height: 20),
                    Text(
                      'SELECT BLANK TO FILL',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(numBlanks, (i) {
                          final isActive = i == _activeBlankIndex;
                          final val = userAnswers[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _activeBlankIndex = i),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                constraints: const BoxConstraints(
                                  minHeight: 48,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppTheme.duoBlue.withValues(alpha: 0.15)
                                      : context.colors.surfaceAlt,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isActive
                                        ? AppTheme.duoBlue
                                        : context.colors.textFaint,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  'Blank ${i + 1}: ${val.isEmpty ? '___' : val}',
                                  style: TextStyle(
                                    color: isActive
                                        ? AppTheme.duoBlue
                                        : context.colors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                  _suggestions.isEmpty
                      ? _buildInlineFallbackField(numBlanks, userAnswers)
                      : _buildSuggestionsBank(numBlanks, userAnswers),
                ],
              ),
            ),
            if (widget.bottomBar != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [const SizedBox(height: 24), widget.bottomBar!],
                ),
              ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppTheme.glassOf(context),
                  child: MathMarkdown(
                    data: widget.slide.content,
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceAlt,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.isAnswered
                          ? (widget.isCorrect
                                ? AppTheme.duoGreen
                                : AppTheme.duoRed)
                          : context.colors.outline,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'YOUR ANSWER',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _controller,
                        enabled: !widget.isAnswered,
                        onChanged: widget.onChanged,
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.done,
                        onSubmitted: widget.isAnswered
                            ? null
                            : (_) => widget.onSubmit?.call(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: widget.isAnswered
                              ? (widget.isCorrect
                                    ? AppTheme.duoGreen
                                    : AppTheme.duoRed)
                              : Colors.amber,
                        ),
                        decoration: InputDecoration(
                          hintText: '___',
                          hintStyle: TextStyle(color: context.colors.textFaint),
                          filled: true,
                          fillColor: context.colors.surfaceAlt,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSuggestionsBank(),
              ],
            ),
          ),
          if (widget.bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const SizedBox(height: 24), widget.bottomBar!],
              ),
            ),
        ],
      ),
    );
  }
}