import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class TheoryView extends StatelessWidget {
  final Slide slide;

  const TheoryView({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.glassDecoration,
          child: MathMarkdown(
            data: slide.content, 
          ),
        ),
      ),
    );
  }
}