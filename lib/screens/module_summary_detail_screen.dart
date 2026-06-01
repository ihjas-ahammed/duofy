import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/math_markdown.dart';

class ModuleSummaryDetailScreen extends StatelessWidget {
  final Module module;

  const ModuleSummaryDetailScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    // Gather all theory slides for this module
    List<Slide> moduleTheorySlides = [];
    for (var section in module.sections) {
      for (var unit in section.units) {
        for (var lesson in unit.lessons) {
          for (var slide in lesson.slides) {
            if (slide.type == 'theory') {
              moduleTheorySlides.add(slide);
            }
          }
        }
      }
    }

    // We build a flat list using ListView.builder to allow lazy loading (on scroll)
    final int outlineCount = module.sections.length;
    final int headerCount = 1;
    final int outlineHeaderCount = outlineCount > 0 ? 1 : 0;
    final int theoryHeaderCount = 1;
    
    final int totalCount = headerCount + 
        outlineHeaderCount + 
        outlineCount + 
        theoryHeaderCount + 
        moduleTheorySlides.length;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background.withOpacity(0.9),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        title: Text(
          module.title,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
          itemCount: totalCount,
          itemBuilder: (context, index) {
            // 1. Header with description
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppTheme.glassDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(LucideIcons.info, color: AppTheme.duoBlue, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'MODULE OVERVIEW',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              color: AppTheme.duoBlue,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        module.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            int currentIndex = 1;

            // 2. Outline Header
            if (outlineHeaderCount > 0) {
              if (index == currentIndex) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12, top: 8),
                  child: Text(
                    'COURSE OUTLINE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      letterSpacing: 0.8,
                      color: AppTheme.duoBlue,
                    ),
                  ),
                );
              }
              currentIndex++;
            }

            // 3. Outline items
            if (outlineCount > 0) {
              if (index >= currentIndex && index < currentIndex + outlineCount) {
                final secIdx = index - currentIndex;
                final sec = module.sections[secIdx];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: AppTheme.glassDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(LucideIcons.arrowRight, size: 14, color: AppTheme.duoBlue),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sec.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            if (sec.description.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  sec.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              currentIndex += outlineCount;
            }

            // 4. Theory Header
            if (index == currentIndex) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: Text(
                  'CORE CONCEPTS SUMMARY',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 0.8,
                    color: AppTheme.duoViolet,
                  ),
                ),
              );
            }
            currentIndex++;

            // 5. Theory slides (lazy loaded on scroll)
            final slideIdx = index - currentIndex;
            if (slideIdx >= 0 && slideIdx < moduleTheorySlides.length) {
              final slide = moduleTheorySlides[slideIdx];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.glassDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.sparkles, color: AppTheme.duoViolet, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            slide.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppTheme.duoViolet,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    MathMarkdown(
                      data: slide.content,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
