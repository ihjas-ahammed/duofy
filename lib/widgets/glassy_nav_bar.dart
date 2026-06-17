import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassyNavBar extends StatelessWidget {
  final int currentIndex;
  final List<IconData> icons;
  final List<String> tooltips;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final double blur;

  const GlassyNavBar({
    super.key,
    required this.currentIndex,
    required this.icons,
    required this.tooltips,
    required this.onTap,
    this.activeColor = AppTheme.duoBlue,
    this.blur = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = icons.length;
    // Align index from -1.0 (leftmost) to 1.0 (rightmost)
    final double alignmentX = itemCount > 1
        ? -1.0 + (currentIndex * 2.0 / (itemCount - 1))
        : 0.0;

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 26),
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  // Animated background bubble - like a glass plate above another
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: Alignment(alignmentX, 0.0),
                    child: FractionallySizedBox(
                      widthFactor: 1.0 / itemCount,
                      child: Container(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Icons Row
                  Row(
                    children: List.generate(itemCount, (index) {
                      final icon = icons[index];
                      final isActive = index == currentIndex;
                      return Expanded(
                        child: Tooltip(
                          message: tooltips[index],
                          preferBelow: false,
                          verticalOffset: 28,
                          child: GestureDetector(
                            onTap: () => onTap(index),
                            behavior: HitTestBehavior.opaque,
                            child: Center(
                              child: AnimatedScale(
                                scale: isActive ? 1.2 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: Icon(
                                  icon,
                                  color: isActive ? activeColor : Colors.white60,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
