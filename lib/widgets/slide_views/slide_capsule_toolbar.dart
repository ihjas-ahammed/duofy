import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Glassmorphism Capsule Header Bar matching docs/new-theme/slide-p/theory.html
class SlideCapsuleToolbar extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final int streakCount;
  final VoidCallback onClose;
  final VoidCallback onAssistantTap;
  final VoidCallback? onBookmarkTap;
  final bool isBookmarked;
  final VoidCallback? onRegenerateTap;
  final bool isRegenerating;
  final VoidCallback? onDeleteTap;
  final bool isDeveloperMode;

  const SlideCapsuleToolbar({
    super.key,
    required this.progress,
    this.streakCount = 1,
    required this.onClose,
    required this.onAssistantTap,
    this.onBookmarkTap,
    this.isBookmarked = false,
    this.onRegenerateTap,
    this.isRegenerating = false,
    this.onDeleteTap,
    this.isDeveloperMode = false,
  });

  @override
  State<SlideCapsuleToolbar> createState() => _SlideCapsuleToolbarState();
}

class _SlideCapsuleToolbarState extends State<SlideCapsuleToolbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clampedProgress = widget.progress.clamp(0.0, 1.0);
    final percentText = '${(clampedProgress * 100).toInt()}%';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9999),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xBF0F172A), // rgba(15, 23, 42, 0.75)
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Row(
              children: [
                // 1. Glass Close Button
                _buildGlassCloseButton(),

                const SizedBox(width: 8),

                // 2. Glowing Liquid Progress Track
                Expanded(
                  child: _buildProgressTrack(clampedProgress, percentText),
                ),

                const SizedBox(width: 8),

                // 3. Streak Flame Badge
                _buildStreakBadge(),

                const SizedBox(width: 6),

                // 4. Glass Divider
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.white.withValues(alpha: 0.15),
                ),

                const SizedBox(width: 6),

                // 5. Bot Avatar Button
                _buildBotAvatarButton(),

                // 6. Optional Developer/Bookmark Extra Actions
                if (widget.onBookmarkTap != null ||
                    (widget.isDeveloperMode && widget.onRegenerateTap != null)) ...[
                  const SizedBox(width: 4),
                  _buildSecondaryMenu(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCloseButton() {
    return GestureDetector(
      onTap: widget.onClose,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.10),
              Colors.white.withValues(alpha: 0.03),
            ],
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.18),
            width: 1,
          ),
        ),
        child: const Center(
          child: Icon(
            LucideIcons.x,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressTrack(double progress, String percentText) {
    return Container(
      height: 32,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0x73000000), // rgba(0, 0, 0, 0.45)
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 1,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Liquid Gradient Fill
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                builder: (context, fillVal, _) {
                  final fillWidth = totalWidth * fillVal;

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: Container(
                      width: fillWidth,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF0052D4),
                            Color(0xFF4364F7),
                            Color(0xFF6FB1FC),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xCC4364F7),
                            blurRadius: 14,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: AnimatedBuilder(
                        animation: _waveController,
                        builder: (context, _) {
                          // Liquid wave shimmer
                          return CustomPaint(
                            size: Size(fillWidth, double.infinity),
                            painter: _LiquidWavePainter(
                              progress: _waveController.value,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              // Progress Percentage Text
              Positioned(
                right: 10,
                child: Text(
                  percentText,
                  style: const TextStyle(
                    color: Color(0xFF7DD3FC),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStreakBadge() {
    final count = widget.streakCount > 0 ? widget.streakCount : 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Flame with subtle drop shadow
          Text(
            '🔥',
            style: TextStyle(
              fontSize: 15,
              shadows: [
                Shadow(
                  color: const Color(0xFFF97316).withValues(alpha: 0.8),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 3),
          Text(
            'x$count',
            style: const TextStyle(
              color: Color(0xFFFBBF24),
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotAvatarButton() {
    return GestureDetector(
      onTap: widget.onAssistantTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            center: Alignment(-0.4, -0.4),
            radius: 0.8,
            colors: [
              Color(0xFF381F75),
              Color(0xFF110E2E),
            ],
          ),
          border: Border.all(
            color: const Color(0xFFA855F7),
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x99A855F7),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: CustomPaint(
            size: const Size(22, 22),
            painter: _BotAvatarPainter(),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryMenu() {
    return PopupMenuButton<String>(
      icon: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.08),
        ),
        child: const Icon(
          LucideIcons.moreVertical,
          color: Colors.white70,
          size: 15,
        ),
      ),
      color: const Color(0xFF131B2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      onSelected: (val) {
        if (val == 'bookmark') {
          widget.onBookmarkTap?.call();
        } else if (val == 'regenerate') {
          widget.onRegenerateTap?.call();
        } else if (val == 'delete') {
          widget.onDeleteTap?.call();
        }
      },
      itemBuilder: (ctx) => [
        if (widget.onBookmarkTap != null)
          PopupMenuItem(
            value: 'bookmark',
            child: Row(
              children: [
                Icon(
                  widget.isBookmarked
                      ? LucideIcons.bookmark
                      : LucideIcons.bookmarkPlus,
                  color: widget.isBookmarked
                      ? const Color(0xFFFFC94D)
                      : Colors.white70,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.isBookmarked ? 'Bookmarked' : 'Bookmark',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        if (widget.isDeveloperMode && widget.onRegenerateTap != null)
          PopupMenuItem(
            value: 'regenerate',
            child: Row(
              children: [
                if (widget.isRegenerating)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF5B8CFF),
                    ),
                  )
                else
                  const Icon(
                    LucideIcons.refreshCcw,
                    color: Color(0xFF5B8CFF),
                    size: 16,
                  ),
                const SizedBox(width: 8),
                const Text(
                  'Regenerate Slide',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        if (widget.isDeveloperMode && widget.onDeleteTap != null)
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  LucideIcons.trash2,
                  color: Color(0xFFF87171),
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  'Delete Slide',
                  style: TextStyle(color: Color(0xFFF87171), fontSize: 13),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Custom painter for the liquid wave reflection inside the progress bar
class _LiquidWavePainter extends CustomPainter {
  final double progress;

  _LiquidWavePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0) return;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.transparent,
          Colors.white.withValues(alpha: 0.35),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(
        Rect.fromLTWH(
          (size.width * 2) * progress - size.width,
          0,
          size.width,
          size.height,
        ),
      );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(_LiquidWavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Custom painter for AI Bot Tutor avatar with orbit ring
class _BotAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFFE0E7FF)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = const Color(0xFFE0E7FF)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Orbit ring (tilted ellipse behind/around robot)
    canvas.save();
    canvas.translate(w * 0.5, h * 0.58);
    canvas.rotate(-15 * math.pi / 180);

    final orbitPaint = Paint()
      ..color = const Color(0xFFC084FC)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final orbitPath = Path()
      ..addOval(Rect.fromCenter(
        center: Offset.zero,
        width: w * 0.95,
        height: h * 0.40,
      ));

    canvas.drawPath(orbitPath, orbitPaint);
    canvas.restore();

    // Antenna
    canvas.drawLine(
      Offset(w * 0.5, h * 0.16),
      Offset(w * 0.5, h * 0.33),
      strokePaint,
    );
    canvas.drawCircle(Offset(w * 0.5, h * 0.14), 1.5, fillPaint);

    // Left & Right Ear nodes
    canvas.drawLine(
      Offset(w * 0.08, h * 0.56),
      Offset(w * 0.18, h * 0.56),
      strokePaint,
    );
    canvas.drawLine(
      Offset(w * 0.82, h * 0.56),
      Offset(w * 0.92, h * 0.56),
      strokePaint,
    );

    // Head container
    final headRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.18, h * 0.33, w * 0.64, h * 0.52),
      const Radius.circular(5.0),
    );
    canvas.drawRRect(headRect, strokePaint);

    // Two glowing round eyes
    canvas.drawCircle(Offset(w * 0.38, h * 0.56), 1.6, fillPaint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.56), 1.6, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
