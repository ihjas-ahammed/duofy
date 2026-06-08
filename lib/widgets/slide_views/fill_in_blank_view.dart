import 'package:flutter/material.dart';
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

  const FillInBlankView({
    super.key,
    required this.slide,
    required this.value,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
  });

  @override
  State<FillInBlankView> createState() => _FillInBlankViewState();
}

class _FillInBlankViewState extends State<FillInBlankView> {
  late TextEditingController _controller;
  List<String> _suggestions = [];
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
    if (widget.slide.blankAnswer != null && widget.slide.blankAnswer!.isNotEmpty) {
      // Split by comma in case of multiple answers
      final answers = widget.slide.blankAnswer!.split(',').map((s) => s.trim());
      for (final ans in answers) {
        if (ans.isNotEmpty && !_suggestions.contains(ans)) {
          _suggestions.add(ans);
        }
      }
    }
    if (widget.slide.blankDistractors != null) {
      for (final dist in widget.slide.blankDistractors!) {
        final cleanDist = dist.trim();
        if (cleanDist.isNotEmpty && !_suggestions.contains(cleanDist)) {
          _suggestions.add(cleanDist);
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

  void _onSuggestionTapped(String word, [int numBlanks = 1, List<String>? userAnswers]) {
    if (widget.isAnswered) return;
    
    if (numBlanks <= 1 || userAnswers == null) {
      _controller.text = word;
      widget.onChanged(word);
      return;
    }

    setState(() {
      userAnswers[_activeBlankIndex] = word;
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
    if (_suggestions.isEmpty || widget.isAnswered) return const SizedBox.shrink();
    final effectiveUserAnswers = userAnswers ?? [widget.value];

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: _suggestions.map((word) {
          final isSelected = numBlanks <= 1
              ? widget.value == word
              : effectiveUserAnswers.contains(word);
          return GestureDetector(
            onTap: () => _onSuggestionTapped(word, numBlanks, effectiveUserAnswers),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.duoBlue.withOpacity(0.2) : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppTheme.duoBlue : Colors.white24,
                  width: 2,
                ),
              ),
              child: Text(
                word,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppTheme.duoBlue : Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
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
      String updatedContent = widget.slide.content.replaceAllMapped(RegExp(r'___+'), (match) {
        final i = blankCounter++;
        final displayWord = userAnswers[i].isEmpty ? r'\_\_\_\_\_' : userAnswers[i];
        final isActive = i == _activeBlankIndex;
        // Bold and point if active
        return isActive ? '**[ 👉 $displayWord ]**' : '*[ $displayWord ]*';
      });

      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.glassDecoration,
              child: MathMarkdown(
                data: updatedContent,
              ),
            ),
            if (numBlanks > 1 && !widget.isAnswered) ...[
              const SizedBox(height: 20),
              const Text(
                'SELECT BLANK TO FILL',
                style: TextStyle(
                  color: Colors.white54,
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
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: GestureDetector(
                        onTap: () => setState(() => _activeBlankIndex = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppTheme.duoBlue.withOpacity(0.15)
                                : Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isActive ? AppTheme.duoBlue : Colors.white24,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'Blank ${i + 1}: ${val.isEmpty ? '___' : val}',
                            style: TextStyle(
                              color: isActive ? AppTheme.duoBlue : Colors.white70,
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
            _buildSuggestionsBank(numBlanks, userAnswers),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassDecoration,
            child: MathMarkdown(data: widget.slide.content, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: widget.isAnswered ? (widget.isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.white12, width: 2),
            ),
            child: Column(
              children: [
                const Text('YOUR ANSWER', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.5)),
                const SizedBox(height: 12),
                TextField(
                  controller: _controller,
                  enabled: !widget.isAnswered,
                  onChanged: widget.onChanged,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: widget.isAnswered ? (widget.isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.amber,
                  ),
                  decoration: InputDecoration(
                    hintText: '___',
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.black45,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.amber, width: 2)),
                  ),
                ),
              ],
            ),
          ),
          _buildSuggestionsBank(),
        ],
      ),
    );
  }
}
