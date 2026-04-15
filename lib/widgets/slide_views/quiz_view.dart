import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class QuizView extends StatelessWidget {
  final Slide slide;
  final String? selectedOptionId;
  final bool isAnswered;
  final Function(String) onSelect;

  const QuizView({
    super.key, 
    required this.slide, 
    required this.selectedOptionId, 
    required this.isAnswered, 
    required this.onSelect
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}