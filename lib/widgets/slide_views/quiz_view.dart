import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class QuizView extends StatelessWidget {
  final Slide slide;
  final String? selectedOptionId;
  final bool isAnswered;
  final Function(String) onSelect;
  /// Fires when the user double-taps an option to edit its text. The view
  /// passes back the new [Slide] (with the option's text replaced) and the
  /// lesson screen owns persistence + re-rendering. Null disables editing.
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

  Future<void> _editOption(BuildContext context, QuizOption opt) async {
    if (onUpdateSlide == null) return;
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
    final updatedOpts = slide.options!
        .map((o) => o.id == opt.id ? o.copyWith(text: newText) : o)
        .toList();
    onUpdateSlide!(slide.copyWith(options: updatedOpts));
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
                // Fallback to hide empty dark container if AI fails to populate content
                if (slide.content.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppTheme.glassDecoration,
                    child: MathMarkdown(data: slide.content, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
    
                if (slide.content.isNotEmpty)
                  const SizedBox(height: 24),
    
                if (slide.options != null)
                  ...slide.options!.map((opt) {
                    final isSelected = selectedOptionId == opt.id;
    
                    Color borderColor = Colors.white12;
                    Color bgColor = Colors.white.withOpacity(0.05);
    
                    if (isAnswered) {
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
                        onTap: isAnswered ? null : () => onSelect(opt.id),
                        onDoubleTap: onUpdateSlide == null ? null : () => _editOption(context, opt),
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
          if (bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 24),
                  bottomBar!,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
