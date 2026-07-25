import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
        backgroundColor: context.colors.surface,
        title: Text(
          'Edit option',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: ctrl,
          maxLines: null,
          autofocus: true,
          style: TextStyle(color: context.colors.textPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colors.surfaceAlt,
            hintText: 'Option text (Markdown / LaTeX supported)',
            hintStyle: TextStyle(color: context.colors.textFaint),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text(
              'Save',
              style: TextStyle(
                color: AppTheme.duoBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
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
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Fallback to hide empty dark container if AI fails to populate content
                if (slide.content.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.isDark
                          ? AppTheme.glassOf(context).color
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
                          child: MathMarkdown(
                            data: slide.content,
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (slide.content.isNotEmpty) const SizedBox(height: 24),

                if (slide.options != null)
                  ...slide.options!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final opt = entry.value;
                    final isSelected = selectedOptionId == opt.id;
                    final optionLetter = String.fromCharCode(65 + index);
                    final badgeColors = [
                      AppTheme.duoBlue,
                      AppTheme.duoViolet,
                      AppTheme.duoOrange,
                      context.colors.secondary,
                      AppTheme.duoGreen,
                    ];
                    final optionAccent = badgeColors[index % badgeColors.length];

                    Color borderColor = context.colors.isDark
                        ? optionAccent.withValues(alpha: 0.3)
                        : optionAccent.withValues(alpha: 0.4);
                    Color bgColor = context.colors.isDark
                        ? optionAccent.withValues(alpha: 0.08)
                        : optionAccent.withValues(alpha: 0.06);

                    if (isAnswered) {
                      if (opt.isCorrect) {
                        borderColor = AppTheme.duoGreen;
                        bgColor = AppTheme.duoGreen.withValues(alpha: 0.2);
                      } else if (isSelected && !opt.isCorrect) {
                        borderColor = AppTheme.duoRed;
                        bgColor = AppTheme.duoRed.withValues(alpha: 0.2);
                      } else {
                        bgColor = Colors.transparent;
                      }
                    } else if (isSelected) {
                      borderColor = optionAccent;
                      bgColor = optionAccent.withValues(alpha: 0.22);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: isAnswered
                                ? null
                                : () {
                                    HapticFeedback.selectionClick();
                                    onSelect(opt.id);
                                  },
                            onDoubleTap: onUpdateSlide == null
                                ? null
                                : () => _editOption(context, opt),
                            borderRadius: BorderRadius.circular(16),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.fromLTRB(
                                14,
                                14,
                                onUpdateSlide == null ? 14 : 34,
                                14,
                              ),
                              constraints: const BoxConstraints(minHeight: 52),
                              decoration: BoxDecoration(
                                color: bgColor,
                                border: Border.all(
                                  color: borderColor,
                                  width: isSelected ? 2.5 : 1.5,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? optionAccent
                                          : optionAccent.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: optionAccent.withValues(alpha: 0.4),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      optionLetter,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : (context.colors.isDark
                                                ? optionAccent
                                                : optionAccent),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: MathMarkdown(
                                      data: opt.text,
                                      selectable: false,
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: context.colors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (onUpdateSlide != null)
                            Positioned(
                              top: 8,
                              right: 10,
                              child: IgnorePointer(
                                child: Tooltip(
                                  message: 'Double-tap to edit',
                                  child: Icon(
                                    LucideIcons.edit2,
                                    size: 14,
                                    color: context.colors.textFaint,
                                  ),
                                ),
                              ),
                            ),
                        ],
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
                children: [const SizedBox(height: 24), bottomBar!],
              ),
            ),
        ],
      ),
    );
  }
}