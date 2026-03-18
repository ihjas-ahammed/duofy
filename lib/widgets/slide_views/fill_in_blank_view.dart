import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class BlankSyntax extends md.InlineSyntax {
  BlankSyntax() : super(r'___+'); // Matches 3 or more underscores
  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.empty('blank'));
    return true;
  }
}

class BlankBuilder extends MarkdownElementBuilder {
  final TextEditingController controller;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;

  BlankBuilder({required this.controller, required this.isAnswered, required this.isCorrect, required this.onChanged});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return IntrinsicWidth(
      child: Container(
        height: 35,
        constraints: const BoxConstraints(minWidth: 80),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: TextField(
          controller: controller,
          enabled: !isAnswered,
          onChanged: onChanged,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isAnswered ? (isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.amber,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
            filled: true,
            fillColor: Colors.black45,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}

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
    required this.onChanged
  });

  @override
  State<FillInBlankView> createState() => _FillInBlankViewState();
}

class _FillInBlankViewState extends State<FillInBlankView> {
  late TextEditingController _controller;
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _buildSuggestions();
  }

  void _buildSuggestions() {
    _suggestions = [];
    if (widget.slide.blankAnswer != null && widget.slide.blankAnswer!.isNotEmpty) {
      _suggestions.add(widget.slide.blankAnswer!);
    }
    if (widget.slide.blankDistractors != null) {
      _suggestions.addAll(widget.slide.blankDistractors!);
    }
    _suggestions.shuffle();
  }

  @override
  void didUpdateWidget(FillInBlankView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _controller.text = widget.value;
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

  void _onSuggestionTapped(String word) {
    if (widget.isAnswered) return;
    _controller.text = word;
    widget.onChanged(word);
  }

  Widget _buildSuggestionsBank() {
    if (_suggestions.isEmpty || widget.isAnswered) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: _suggestions.map((word) {
          final isSelected = widget.value == word;
          return GestureDetector(
            onTap: () => _onSuggestionTapped(word),
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
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.glassDecoration,
              child: MathMarkdown(
                data: widget.slide.content,
                customSyntaxes: [BlankSyntax()],
                customBuilders: {
                  'blank': BlankBuilder(
                    controller: _controller,
                    isAnswered: widget.isAnswered,
                    isCorrect: widget.isCorrect,
                    onChanged: widget.onChanged,
                  )
                },
              ),
            ),
            _buildSuggestionsBank(),
          ],
        ),
      );
    }

    // Fallback: Standard block input logic if not written inline
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