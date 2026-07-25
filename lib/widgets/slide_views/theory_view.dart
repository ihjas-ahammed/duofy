import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class TheoryView extends StatelessWidget {
  final Slide slide;
  final Widget? lessonCanvas;
  final Widget? bottomBar;
  final bool hasCanvas;
  final String lessonTitle;

  const TheoryView({
    super.key,
    required this.slide,
    this.lessonCanvas,
    this.bottomBar,
    required this.hasCanvas,
    required this.lessonTitle,
  });

  @override
  Widget build(BuildContext context) {
    // If adjacent theory slides were grouped by LessonScreen using '---', we split them here
    final parts = slide.content.split(RegExp(r'\n+---\n+'));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                ?lessonCanvas,
                if (!hasCanvas)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                    child: Text(
                      lessonTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: context.colors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (!hasCanvas &&
                    slide.title.isNotEmpty &&
                    slide.title.toLowerCase() != lessonTitle.toLowerCase())
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                    child: Text(
                      slide.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: context.colors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ...parts
                    .asMap().entries
                    .map(
                      (entry) {
                        final idx = entry.key;
                        final p = entry.value;
                        final accents = [AppTheme.duoBlue, AppTheme.duoViolet, AppTheme.duoGreen, AppTheme.duoOrange];
                        final cardAccent = accents[idx % accents.length];

                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: context.colors.isDark
                                ? context.colors.surface
                                : Colors.white,
                            borderRadius: hasCanvas
                                ? const BorderRadius.vertical(
                                    bottom: Radius.circular(24),
                                  )
                                : BorderRadius.circular(24),
                            border: Border.all(
                              color: cardAccent.withValues(alpha: 0.35),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: cardAccent.withValues(alpha: 0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 4,
                                color: cardAccent,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                            if (hasCanvas && slide.title.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Center(
                                  child: Text(
                                    slide.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: context.colors.textPrimary,
                                      letterSpacing: -0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ...p.split('\n').map((line) {
                              if (line.isEmpty) {
                                return const SizedBox(height: 8);
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: MathMarkdown(
                                  data: line,
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: context.colors.textPrimary,
                                    height: 1.55,
                                  ),
                                ),
                              );
                            }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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