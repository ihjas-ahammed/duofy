import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/slide_views/interactive_webview.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentIndex = 0;
  bool _answeredCorrectly = false;
  String? _selectedOption;

  void _nextSlide() {
    if (_currentIndex < widget.lesson.slides.length - 1) {
      setState(() {
        _currentIndex++;
        _answeredCorrectly = false;
        _selectedOption = null;
      });
    } else {
      // Lesson Complete
      Navigator.pop(context);
    }
  }

  Widget _buildSlideContent(Slide slide) {
    if (slide.type == 'interactive_canvas' && slide.interactiveCanvasUrl != null) {
      return Expanded(
        child: Column(
          children: [
            if (slide.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MarkdownBody(data: slide.content, styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 18, color: Colors.white))),
              ),
            Expanded(child: InteractiveWebview(url: slide.interactiveCanvasUrl!)),
          ],
        ),
      );
    }

    if (slide.type == 'quiz') {
      return Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.glassDecoration,
                child: MarkdownBody(data: slide.content, styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 20, color: Colors.white))),
              ),
              const SizedBox(height: 32),
              if (slide.options != null)
                ...slide.options!.map((opt) {
                  final isSelected = _selectedOption == opt.id;
                  final color = _answeredCorrectly && isSelected 
                      ? AppTheme.duoGreen 
                      : (isSelected ? AppTheme.duoBlue : Colors.white10);
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: _answeredCorrectly ? null : () => setState(() => _selectedOption = opt.id),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          border: Border.all(color: color, width: 2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: MarkdownBody(data: opt.text, styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 18))),
                      ),
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      );
    }

    // Default Theory View
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.glassDecoration,
          child: MarkdownBody(data: slide.content, styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 18, color: Colors.white, height: 1.5))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lesson.slides.isEmpty) {
      return Scaffold(appBar: AppBar(), body: const Center(child: Text("Empty Lesson")));
    }

    final slide = widget.lesson.slides[_currentIndex];
    final progress = (_currentIndex) / widget.lesson.slides.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: () => Navigator.pop(context),
        ),
        title: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white12,
          color: AppTheme.duoGreen,
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (slide.title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(slide.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              ),
            
            _buildSlideContent(slide),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10, width: 1)),
              ),
              child: slide.type == 'quiz' && !_answeredCorrectly
                  ? DuoButton(
                      text: 'Check',
                      color: _selectedOption != null ? AppTheme.duoGreen : Colors.grey.shade700,
                      shadowColor: _selectedOption != null ? AppTheme.duoGreenDark : Colors.grey.shade800,
                      onPressed: () {
                        if (_selectedOption != null) {
                          final opt = slide.options!.firstWhere((o) => o.id == _selectedOption);
                          if (opt.isCorrect) {
                            setState(() => _answeredCorrectly = true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(opt.explanation)));
                          }
                        }
                      },
                    )
                  : DuoButton(
                      text: 'Continue',
                      color: AppTheme.duoBlue,
                      shadowColor: AppTheme.duoBlueDark,
                      onPressed: _nextSlide,
                    ),
            )
          ],
        ),
      ),
    );
  }
}