import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/math_markdown.dart';

class NotesScreen extends StatelessWidget {
  final Book book;

  const NotesScreen({super.key, required this.book});

  List<Slide> _getTheorySlides() {
    List<Slide> notes = [];
    for (var module in book.modules) {
      for (var section in module.sections) {
        for (var unit in section.units) {
          for (var lesson in unit.lessons) {
            for (var slide in lesson.slides) {
              if (slide.type == 'theory') {
                notes.add(slide);
              }
            }
          }
        }
      }
    }
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    final notes = _getTheorySlides();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Module Notes', style: TextStyle(fontWeight: FontWeight.w900)),
        automaticallyImplyLeading: false,
      ),
      body: notes.isEmpty 
        ? const Center(child: Text('No notes available.', style: TextStyle(color: Colors.white54)))
        : ListView.builder(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final slide = notes[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: AppTheme.glassDecoration.copyWith(
                  border: const Border(left: BorderSide(color: AppTheme.duoViolet, width: 4)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.bookOpen, color: AppTheme.duoViolet, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            slide.title.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: AppTheme.duoViolet),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MathMarkdown(data: slide.content, textStyle: const TextStyle(fontSize: 16, color: Colors.white, height: 1.6)),
                  ],
                ),
              );
            },
          ),
    );
  }
}