import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class TheoryView extends StatelessWidget {
  final Slide slide;

  const TheoryView({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    // If adjacent theory slides were grouped by LessonScreen using '---', we split them here
    final parts = slide.content.split(RegExp(r'\n+---\n+'));

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: parts.map((p) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
             color: AppTheme.surface,
             borderRadius: BorderRadius.circular(16),
             border: Border.all(color: Colors.white12)
          ),
          child: MathMarkdown(
            data: p.trim(), 
            textStyle: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
          ),
        )).toList(),
      ),
    );
  }
}