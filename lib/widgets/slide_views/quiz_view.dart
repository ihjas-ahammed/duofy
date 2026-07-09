import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class QuizView extends StatefulWidget {
  final Slide slide;
  final String? selectedOptionId;
  final bool isAnswered;
  final Function(String) onSelect;
  final void Function(Slide updated)? onUpdateSlide;
  final Widget? bottomBar;

  const QuizView({
    super.key,
    required this.slide,
    required this.selectedOptionId,
    required this.isAnswered,
    required this.onSelect,
    this.onUpdateSlide,
    this.bottomBar,
  });

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  bool _showOptions = false;

  Future<void> _editOption(BuildContext context, QuizOption opt) async {
    if (widget.onUpdateSlide == null) return;
    final ctrl = TextEditingController(text: opt.text);
    final newText = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Edit option', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: ctrl,
          maxLines: null,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black26,
            hintText: 'Option text (Markdown / LaTeX supported)',
            hintStyle: const TextStyle(color: Colors.white38),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('Save', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (newText == null || newText.isEmpty || newText == opt.text) return;
    final updatedOpts = widget.slide.options!
        .map((o) => o.id == opt.id ? o.copyWith(text: newText) : o)
        .toList();
    widget.onUpdateSlide!(widget.slide.copyWith(options: updatedOpts));
  }

  @override
  void didUpdateWidget(QuizView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _showOptions = false;
    }
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
                if (widget.slide.content.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      if (!_showOptions) {
                        setState(() {
                          _showOptions = true;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppTheme.glassDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MathMarkdown(data: widget.slide.content, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                          if (!_showOptions)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Center(
                                child: Text(
                                  "Tap to show options",
                                  style: TextStyle(color: Colors.white54, fontSize: 14, fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
    
                if (widget.slide.content.isNotEmpty && _showOptions)
                  const SizedBox(height: 24),
    
                if (widget.slide.options != null && _showOptions)
                  ...widget.slide.options!.map((opt) {
                    final isSelected = widget.selectedOptionId == opt.id;
    
                    Color borderColor = Colors.white12;
                    Color bgColor = Colors.white.withOpacity(0.05);
    
                    if (widget.isAnswered) {
                      if (opt.isCorrect) {
                        borderColor = AppTheme.duoGreen;
                        bgColor = AppTheme.duoGreen.withOpacity(0.2);
                      } else if (isSelected && !opt.isCorrect) {
                        borderColor = AppTheme.duoRed;
                        bgColor = AppTheme.duoRed.withOpacity(0.2);
                      } else {
                        bgColor = Colors.transparent;
                      }
                    } else if (isSelected) {
                      borderColor = AppTheme.duoBlue;
                      bgColor = AppTheme.duoBlue.withOpacity(0.2);
                    }
    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: widget.isAnswered ? null : () => widget.onSelect(opt.id),
                        onDoubleTap: widget.onUpdateSlide == null ? null : () => _editOption(context, opt),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: MathMarkdown(
                            data: opt.text,
                            selectable: false,
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
              ],
            ),
          ),
          if (widget.bottomBar != null && _showOptions)
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
