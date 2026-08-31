import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Theory slide view matching docs/new-theme/slide-p/theory.html
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

  /// Extract an appropriate math/topic symbol for the badge (default π)
  String _extractBadgeSymbol(String title) {
    final t = title.toLowerCase();
    if (t.contains('euler') || t.contains('pi') || t.contains('circle') || t.contains('trig')) {
      return 'π';
    }
    if (t.contains('integral') || t.contains('calculus')) {
      return '∫';
    }
    if (t.contains('sum') || t.contains('series')) {
      return '∑';
    }
    if (t.contains('matrix') || t.contains('vector') || t.contains('linear')) {
      return 'λ';
    }
    if (t.contains('limit') || t.contains('infinity')) {
      return '∞';
    }
    if (t.contains('quantum') || t.contains('physics')) {
      return 'Ψ';
    }
    if (t.contains('delta') || t.contains('change')) {
      return 'Δ';
    }
    if (t.contains('logic') || t.contains('set')) {
      return '∈';
    }
    return 'π';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final displayTitle = slide.title.trim().isNotEmpty ? slide.title : lessonTitle;
    final badgeSymbol = _extractBadgeSymbol(displayTitle);

    // If adjacent theory slides were grouped using '---', we split them into distinct sections
    final parts = slide.content.split(RegExp(r'\n+---\n+'));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Category Tag
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 8.0, top: 2.0),
                  child: Text(
                    'THEORY & CONCEPT INTRODUCTION',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      color: colors.textSubtle,
                    ),
                  ),
                ),

                // 2. Main Lesson Card
                _buildMainLessonCard(
                  context: context,
                  title: displayTitle,
                  badgeSymbol: badgeSymbol,
                  primaryContent: parts.isNotEmpty ? parts.first : '',
                ),

                const SizedBox(height: 12),

                // 3. Theory Explainer / Concept Cards for remaining sections or paragraphs
                if (parts.length > 1)
                  ...parts.sublist(1).map(
                        (chunk) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildTheoryExplainerBox(context, chunk),
                        ),
                      )
                else
                  _buildDefaultTheoryExplainer(context, parts.first),
              ],
            ),
          ),

          if (bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  bottomBar!,
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainLessonCard({
    required BuildContext context,
    required String title,
    required String badgeSymbol,
    required String primaryContent,
  }) {
    final colors = context.colors;

    // Check if the primary content has a standalone display formula ($$...$$)
    final formulaMatch = RegExp(r'\$\$([\s\S]*?)\$\$').firstMatch(primaryContent);
    final String? formulaText = formulaMatch?.group(1)?.trim();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: colors.isDark ? 0.35 : 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Pi Badge + Lesson Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primaryBlueLight,
                ),
                child: Center(
                  child: Text(
                    badgeSymbol,
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: colors.primaryBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: colors.textMain,
                    letterSpacing: -0.3,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),

          // Optional Inline Visual / Diagram / Lesson Canvas
          if (lessonCanvas != null) ...[
            const SizedBox(height: 14),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: lessonCanvas!,
              ),
            ),
          ],

          // Math Formula Callout Box
          if (formulaText != null && formulaText.isNotEmpty) ...[
            const SizedBox(height: 14),
            _buildMathFormulaBox(context, formulaText),
          ],
        ],
      ),
    );
  }

  Widget _buildMathFormulaBox(BuildContext context, String formulaText) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colors.mathBoxBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colors.mathBoxBorder,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Primary Equation
          MathMarkdown(
            data: '\$\$$formulaText\$\$',
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colors.primaryBlue,
            ),
          ),
          const SizedBox(height: 6),
          // Formula Divider
          Container(
            width: 120,
            height: 1,
            color: colors.outline.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 6),
          // Subtle Formula Meta Hint
          Text(
            'Core Definition & Invariant Relation',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: colors.textSubtle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTheoryExplainerBox(BuildContext context, String content) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: colors.isDark ? 0.25 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left vertical blue accent bar
          Positioned(
            left: 10,
            top: 14,
            bottom: 14,
            child: Container(
              width: 2.5,
              decoration: BoxDecoration(
                color: colors.primaryBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Sparkle Icon at top-left
          Positioned(
            top: 8,
            left: 6,
            child: Container(
              color: colors.cardBg,
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '✦',
                style: TextStyle(
                  color: colors.primaryBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Content body
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MathMarkdown(
                  data: content,
                  textStyle: TextStyle(
                    fontSize: 13.5,
                    height: 1.55,
                    color: colors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultTheoryExplainer(BuildContext context, String rawContent) {
    // If the primary card displayed the formula, we extract remaining paragraphs for the explainer
    final cleaned = rawContent.replaceAll(RegExp(r'\$\$[\s\S]*?\$\$'), '').trim();
    if (cleaned.isEmpty) return const SizedBox.shrink();

    return _buildTheoryExplainerBox(context, cleaned);
  }
}