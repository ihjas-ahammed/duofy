import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class ConceptPiecesView extends StatelessWidget {
  final Slide slide;
  final Widget? lessonCanvas;
  final Widget? bottomBar;
  final bool hasCanvas;
  final String lessonTitle;

  const ConceptPiecesView({
    super.key,
    required this.slide,
    this.lessonCanvas,
    this.bottomBar,
    required this.hasCanvas,
    required this.lessonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final sentences = slide.content
        .split(RegExp(r'\n|\. (?=[A-Z])'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (lessonCanvas != null) lessonCanvas!,
                if (!hasCanvas)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                    child: Text(
                      lessonTitle,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (!hasCanvas && slide.title.isNotEmpty && slide.title.toLowerCase() != lessonTitle.toLowerCase())
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                    child: Text(
                      slide.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 12),
                Column(
                  children: List.generate(sentences.length, (idx) {
                    final s = sentences[idx];
                    final isLast = idx == sentences.length - 1;

                    final stepRatio = idx / (sentences.length > 1 ? sentences.length - 1 : 1);
                    final currentAccent = Color.lerp(AppTheme.duoBlue, AppTheme.duoViolet, stepRatio) ?? AppTheme.duoBlue;
                    final currentAccentSecondary = Color.lerp(AppTheme.duoBlueDark, AppTheme.duoVioletDark, stepRatio) ?? AppTheme.duoBlueDark;

                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 400 + (idx * 150)),
                      curve: Curves.easeOutCubic,
                      builder: (context, animValue, child) {
                        return Opacity(
                          opacity: animValue,
                          child: Transform.translate(
                            offset: Offset(0, (1 - animValue) * 20),
                            child: child,
                          ),
                        );
                      },
                      child: CustomPaint(
                        painter: _TimelineLinePainter(
                          isLast: isLast,
                          bubbleSize: 32.0,
                          index: idx,
                          totalCount: sentences.length,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [currentAccent, currentAccentSecondary],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: currentAccent.withOpacity(0.4),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${idx + 1}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppTheme.applyGlassBlur(
                                  borderRadius: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: currentAccent.withOpacity(0.8),
                                          width: 4,
                                        ),
                                      ),
                                    ),
                                    child: MathMarkdown(
                                      data: s.endsWith('.') ? s : '$s.',
                                      textStyle: const TextStyle(
                                        fontSize: 14.5,
                                        color: Colors.white,
                                        height: 1.45,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
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

class _TimelineLinePainter extends CustomPainter {
  final bool isLast;
  final double bubbleSize;
  final int index;
  final int totalCount;

  _TimelineLinePainter({
    required this.isLast,
    required this.bubbleSize,
    required this.index,
    required this.totalCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final startX = bubbleSize / 2;
    final centerY = (size.height - 20.0) / 2;

    if (index > 0) {
      final startRatio = (index - 0.5) / (totalCount > 1 ? totalCount - 1 : 1);
      final endRatio = index / (totalCount > 1 ? totalCount - 1 : 1);
      final startColor = Color.lerp(AppTheme.duoBlue, AppTheme.duoViolet, startRatio) ?? AppTheme.duoBlue;
      final endColor = Color.lerp(AppTheme.duoBlue, AppTheme.duoViolet, endRatio) ?? AppTheme.duoBlue;

      final paintTop = Paint()
        ..shader = ui.Gradient.linear(
          Offset(startX, 0),
          Offset(startX, centerY - bubbleSize / 2),
          [
            startColor.withOpacity(0.8),
            endColor.withOpacity(0.8),
          ],
        )
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(startX, 0), Offset(startX, centerY - bubbleSize / 2), paintTop);
    }

    if (!isLast) {
      final startRatio = index / (totalCount > 1 ? totalCount - 1 : 1);
      final endRatio = (index + 0.5) / (totalCount > 1 ? totalCount - 1 : 1);
      final startColor = Color.lerp(AppTheme.duoBlue, AppTheme.duoViolet, startRatio) ?? AppTheme.duoBlue;
      final endColor = Color.lerp(AppTheme.duoBlue, AppTheme.duoViolet, endRatio) ?? AppTheme.duoViolet;

      final paintBottom = Paint()
        ..shader = ui.Gradient.linear(
          Offset(startX, centerY + bubbleSize / 2),
          Offset(startX, size.height),
          [
            startColor.withOpacity(0.8),
            endColor.withOpacity(0.8),
          ],
        )
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(startX, centerY + bubbleSize / 2), Offset(startX, size.height), paintBottom);
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineLinePainter oldDelegate) {
    return oldDelegate.isLast != isLast ||
        oldDelegate.bubbleSize != bubbleSize ||
        oldDelegate.index != index ||
        oldDelegate.totalCount != totalCount;
  }
}
