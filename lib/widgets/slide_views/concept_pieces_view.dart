import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

/// Interactive Concept Pieces View matching docs/new-theme/slide-p/concept-pieces.html
class ConceptPiecesView extends StatefulWidget {
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
  State<ConceptPiecesView> createState() => _ConceptPiecesViewState();
}

class _ConceptPiecesViewState extends State<ConceptPiecesView>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _pulseController;

  static const List<Color> _accentColors = [
    Color(0xFF10B981), // Mint / Emerald (Q)
    Color(0xFF0077FF), // Sky Blue (K)
    Color(0xFFF59E0B), // Amber (V)
    Color(0xFFA855F7), // Purple / Violet (S)
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEC4899), // Pink
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  List<_ParsedConceptPiece> _parsePieces() {
    final rawPieces = widget.slide.content
        .split(RegExp(r'\n+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (rawPieces.isEmpty) {
      return [
        _ParsedConceptPiece(
          title: widget.slide.title.isNotEmpty ? widget.slide.title : 'Concept',
          subtitle: '',
          description: widget.slide.content,
          badgeSymbol: '1',
          colorIndex: 0,
        ),
      ];
    }

    return List.generate(rawPieces.length, (i) {
      final text = rawPieces[i];
      // Check for formats like "Queries (Q): Represent what we seek." or "1. Title: Description"
      final colonIdx = text.indexOf(':');
      final dashIdx = text.indexOf(' - ');

      String title;
      String desc;
      String formula = '';
      String badgeSymbol = '${i + 1}';

      if (colonIdx > 0 && colonIdx < 40) {
        title = text.substring(0, colonIdx).replaceAll(RegExp(r'^\d+[\.\)]\s*'), '').trim();
        desc = text.substring(colonIdx + 1).trim();
      } else if (dashIdx > 0 && dashIdx < 40) {
        title = text.substring(0, dashIdx).replaceAll(RegExp(r'^\d+[\.\)]\s*'), '').trim();
        desc = text.substring(dashIdx + 3).trim();
      } else {
        title = text.replaceAll(RegExp(r'^\d+[\.\)]\s*'), '').trim();
        desc = '';
      }

      // Extract symbol like (Q) or (K) if present in title
      final parenMatch = RegExp(r'\((.+?)\)').firstMatch(title);
      if (parenMatch != null) {
        final inside = parenMatch.group(1)!.trim();
        if (inside.length <= 3) {
          badgeSymbol = inside;
        }
      }

      // Check if formula exists in description or title
      final formulaMatch = RegExp(r'\$(.+?)\$').firstMatch(desc);
      if (formulaMatch != null) {
        formula = '\$${formulaMatch.group(1)}\$';
      }

      return _ParsedConceptPiece(
        title: title,
        subtitle: formula,
        description: desc.isNotEmpty ? desc : title,
        badgeSymbol: badgeSymbol,
        colorIndex: i % _accentColors.length,
      );
    });
  }

  void _openAssembleSheet(List<_ParsedConceptPiece> pieces, AppColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.sheetBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        final displayTitle = widget.slide.title.isNotEmpty
            ? widget.slide.title
            : widget.lessonTitle;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            MediaQuery.of(ctx).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.textSubtle.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Sheet Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.primaryBlueLight,
                        ),
                        child: Center(
                          child: Icon(
                            LucideIcons.sparkles,
                            color: colors.primaryBlue,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Schema Assembled',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: colors.textMain,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.badgeBg,
                        border: Border.all(color: colors.cardBorder),
                      ),
                      child: Center(
                        child: Icon(
                          LucideIcons.x,
                          size: 14,
                          color: colors.textMain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Unified synthesis preview container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: colors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayTitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: colors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 6),
                    MathMarkdown(
                      data: widget.slide.content,
                      textStyle: TextStyle(
                        fontSize: 13.5,
                        height: 1.45,
                        color: colors.textMain,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'All atomic concept pieces have converged into a unified schema in working memory.',
                style: TextStyle(
                  fontSize: 11,
                  color: colors.textMuted,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue Exploring',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(LucideIcons.chevronRight, size: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final pieces = _parsePieces();
    final clampedIdx = _selectedIndex.clamp(0, pieces.length - 1);
    final activePiece = pieces[clampedIdx];
    final displayTitle = widget.slide.title.isNotEmpty
        ? widget.slide.title
        : widget.lessonTitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Architecture Diagram / Canvas Card
                Container(
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: colors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: colors.isDark ? 0.35 : 0.04,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Title & Subtitle
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayTitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: colors.textMain,
                                    letterSpacing: -0.3,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Break it down. Understand. Reassemble.',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500,
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.badgeBg,
                            ),
                            child: Icon(
                              LucideIcons.info,
                              size: 15,
                              color: colors.textSubtle,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Canvas or Interactive Schematic Painter
                      if (widget.hasCanvas && widget.lessonCanvas != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: widget.lessonCanvas!,
                        )
                      else
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: colors.mathBoxBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: colors.cardBorder.withValues(alpha: 0.6),
                            ),
                          ),
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, _) {
                              return CustomPaint(
                                painter: _ConceptSchematicPainter(
                                  piecesCount: pieces.length,
                                  activeIndex: clampedIdx,
                                  activeColor: _accentColors[activePiece.colorIndex],
                                  pulseValue: _pulseController.value,
                                  isDark: colors.isDark,
                                  pieceBadges: pieces.map((p) => p.badgeSymbol).toList(),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // 2. Section Helper Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.layoutGrid,
                          size: 14,
                          color: colors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Select a concept piece to explore',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _accentColors[activePiece.colorIndex].withValues(
                          alpha: 0.12,
                        ),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: _accentColors[activePiece.colorIndex].withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                      child: Text(
                        'Piece ${clampedIdx + 1} of ${pieces.length}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: _accentColors[activePiece.colorIndex],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 3. Modular Concept Cards List
                Column(
                  children: List.generate(pieces.length, (idx) {
                    final piece = pieces[idx];
                    final isSelected = idx == clampedIdx;
                    final accent = _accentColors[piece.colorIndex];

                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedIndex = idx);
                        HapticFeedback.selectionClick();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (colors.isDark
                                  ? const Color(0xFF111B30)
                                  : const Color(0xFFF1F5F9))
                              : colors.cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? colors.primaryBlue
                                : colors.cardBorder,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: colors.primaryBlue.withValues(
                                      alpha: 0.18,
                                    ),
                                    blurRadius: 14,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          children: [
                            // Left glowing indicator pill
                            Container(
                              width: 4,
                              height: 32,
                              decoration: BoxDecoration(
                                color: accent,
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: accent.withValues(alpha: 0.6),
                                          blurRadius: 6,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Badge icon with letter or number
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: accent.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: accent,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  piece.badgeSymbol,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: accent,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Title & Description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    piece.title,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: colors.textMain,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (piece.description.isNotEmpty &&
                                      piece.description != piece.title)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                        piece.description,
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w500,
                                          color: colors.textMuted,
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Trailing chevron
                            Icon(
                              LucideIcons.chevronRight,
                              size: 15,
                              color: isSelected
                                  ? colors.textMain
                                  : colors.textSubtle,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 10),

                // 4. Assemble Schema Action Button
                GestureDetector(
                  onTap: () => _openAssembleSheet(pieces, colors),
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: colors.primaryBlue,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: colors.primaryBlue.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              LucideIcons.network,
                              color: Colors.white,
                              size: 17,
                            ),
                            const SizedBox(width: 9),
                            const Text(
                              'Assemble Schema',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          LucideIcons.chevronRight,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
          if (widget.bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 16),
                  widget.bottomBar!,
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ParsedConceptPiece {
  final String title;
  final String subtitle;
  final String description;
  final String badgeSymbol;
  final int colorIndex;

  _ParsedConceptPiece({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.badgeSymbol,
    required this.colorIndex,
  });
}

/// Custom painter that draws an interactive node-network schematic
class _ConceptSchematicPainter extends CustomPainter {
  final int piecesCount;
  final int activeIndex;
  final Color activeColor;
  final double pulseValue;
  final bool isDark;
  final List<String> pieceBadges;

  _ConceptSchematicPainter({
    required this.piecesCount,
    required this.activeIndex,
    required this.activeColor,
    required this.pulseValue,
    required this.isDark,
    required this.pieceBadges,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final count = math.max(piecesCount, 1);
    final w = size.width;
    final h = size.height;
    final centerY = h / 2;

    // 1. Input Node on Left
    final inputCenter = Offset(w * 0.12, centerY);
    final inputPaint = Paint()
      ..color = const Color(0xFF6366F1).withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    final inputBorder = Paint()
      ..color = const Color(0xFF6366F1)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: inputCenter, width: 26, height: 64),
        const Radius.circular(8),
      ),
      inputPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: inputCenter, width: 26, height: 64),
        const Radius.circular(8),
      ),
      inputBorder,
    );

    // 2. Output Node on Right
    final outputCenter = Offset(w * 0.88, centerY);
    final outputPaint = Paint()
      ..color = const Color(0xFFA855F7).withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    final outputBorder = Paint()
      ..color = const Color(0xFFA855F7)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: outputCenter, width: 26, height: 64),
        const Radius.circular(8),
      ),
      outputPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: outputCenter, width: 26, height: 64),
        const Radius.circular(8),
      ),
      outputBorder,
    );

    // 3. Middle Concept Nodes
    final nodeSpacing = (h - 36) / (count > 1 ? count - 1 : 1);
    final midX = w * 0.5;

    for (int i = 0; i < count; i++) {
      final nodeY = count > 1 ? (18 + i * nodeSpacing) : centerY;
      final nodeCenter = Offset(midX, nodeY);
      final isActive = i == activeIndex;

      // Connecting curves from Input to Middle
      final pathLeft = Path()
        ..moveTo(inputCenter.dx + 13, inputCenter.dy)
        ..cubicTo(
          (inputCenter.dx + midX) / 2,
          inputCenter.dy,
          (inputCenter.dx + midX) / 2,
          nodeY,
          nodeCenter.dx - 18,
          nodeY,
        );

      final linePaint = Paint()
        ..color = isActive
            ? activeColor.withValues(alpha: 0.8)
            : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1))
        ..strokeWidth = isActive ? 1.8 : 1.0
        ..style = PaintingStyle.stroke;

      canvas.drawPath(pathLeft, linePaint);

      // Connecting curves from Middle to Output
      final pathRight = Path()
        ..moveTo(nodeCenter.dx + 18, nodeY)
        ..cubicTo(
          (midX + outputCenter.dx) / 2,
          nodeY,
          (midX + outputCenter.dx) / 2,
          outputCenter.dy,
          outputCenter.dx - 13,
          outputCenter.dy,
        );

      canvas.drawPath(pathRight, linePaint);

      // Draw Middle Node Box
      final boxPaint = Paint()
        ..color = isActive
            ? activeColor.withValues(alpha: 0.18 + pulseValue * 0.08)
            : (isDark ? const Color(0xFF0F172A) : Colors.white)
        ..style = PaintingStyle.fill;

      final boxBorder = Paint()
        ..color = isActive
            ? activeColor
            : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0))
        ..strokeWidth = isActive ? 1.8 : 1.0
        ..style = PaintingStyle.stroke;

      final nodeRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: nodeCenter,
          width: isActive ? 38 + (pulseValue * 2) : 34,
          height: isActive ? 26 + (pulseValue * 2) : 22,
        ),
        const Radius.circular(6),
      );

      canvas.drawRRect(nodeRect, boxPaint);
      canvas.drawRRect(nodeRect, boxBorder);

      // Text label inside node
      final label = i < pieceBadges.length ? pieceBadges[i] : '${i + 1}';
      final textSpan = TextSpan(
        text: label,
        style: TextStyle(
          color: isActive
              ? activeColor
              : (isDark ? Colors.white70 : const Color(0xFF475569)),
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(nodeCenter.dx - textPainter.width / 2, nodeCenter.dy - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(_ConceptSchematicPainter oldDelegate) =>
      oldDelegate.activeIndex != activeIndex ||
      oldDelegate.pulseValue != pulseValue ||
      oldDelegate.isDark != isDark ||
      oldDelegate.piecesCount != piecesCount;
}