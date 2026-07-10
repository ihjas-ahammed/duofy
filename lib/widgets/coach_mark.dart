import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_theme.dart';

class CoachMark {
  final GlobalKey targetKey;
  final String title;
  final String body;
  const CoachMark({
    required this.targetKey,
    required this.title,
    required this.body,
  });
}

/// Sequential first-visit tooltips: dims the screen, cuts a hole around the
/// target widget, and shows one tip card at a time (tap anywhere to advance).
/// Runs once per [prefsKey]; capped at three tips so it welcomes rather than
/// nags. Plain OverlayEntry — no extra package.
class CoachMarkController {
  CoachMarkController._();

  static Future<void> maybeShow(
    BuildContext context, {
    required String prefsKey,
    required List<CoachMark> marks,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(prefsKey) ?? false) return;
    await prefs.setBool(prefsKey, true);
    if (!context.mounted) return;

    final overlay = Overlay.of(context, rootOverlay: true);
    final shown = marks.take(3).toList();
    for (var i = 0; i < shown.length; i++) {
      final mark = shown[i];
      final targetContext = mark.targetKey.currentContext;
      if (targetContext == null) continue;
      final box = targetContext.findRenderObject() as RenderBox?;
      if (box == null || !box.attached || !box.hasSize) continue;
      final rect = box.localToGlobal(Offset.zero) & box.size;
      await _showOne(overlay, rect, mark, i + 1, shown.length);
    }
  }

  static Future<void> _showOne(
    OverlayState overlay,
    Rect target,
    CoachMark mark,
    int index,
    int total,
  ) {
    final completer = Completer<void>();
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        final hole = target.inflate(8);
        final showBelow = hole.center.dy < size.height / 2;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            entry.remove();
            completer.complete();
          },
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _HolePainter(hole))),
              Positioned(
                left: 24,
                right: 24,
                top: showBelow ? hole.bottom + 16 : null,
                bottom: showBelow ? null : size.height - hole.top + 16,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppTheme.duoBlue.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.shadow,
                          blurRadius: 24,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.duoBlue.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$index / $total',
                                style: const TextStyle(
                                  color: AppTheme.duoBlue,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                mark.title,
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mark.body,
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Tap anywhere to continue',
                          style: TextStyle(
                            color: context.colors.textFaint,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    overlay.insert(entry);
    return completer.future;
  }
}

class _HolePainter extends CustomPainter {
  final Rect hole;
  _HolePainter(this.hole);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      Path()
        ..addRRect(RRect.fromRectAndRadius(hole, const Radius.circular(16))),
    );
    // Fixed dimming scrim for the spotlight cutout — deliberately
    // theme-invariant, not a themed surface.
    canvas.drawPath(path, Paint()..color = Colors.black.withOpacity(0.72));
  }

  @override
  bool shouldRepaint(_HolePainter oldDelegate) => oldDelegate.hole != hole;
}
