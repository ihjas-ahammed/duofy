import 'package:flutter/material.dart';

class MiniProgressBar extends StatelessWidget {
  final int percentage;
  final double height;
  final bool showText;

  const MiniProgressBar({
    super.key,
    required this.percentage,
    this.height = 8,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final safe = percentage.clamp(0, 100);
    final isCompleted = safe == 100;

    final fillGradient = isCompleted
        ? const LinearGradient(colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)])
        : const LinearGradient(colors: [Color(0xFF58CC02), Color(0xFF22C55E)]);

    final shadowColor = isCompleted
        ? const Color(0xFFFBBF24).withOpacity(0.4)
        : const Color(0xFF58CC02).withOpacity(0.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showText)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'PROGRESS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF94A3B8),
                    letterSpacing: 1.6,
                  ),
                ),
                Text(
                  '$safe%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: isCompleted ? const Color(0xFFFBBF24) : const Color(0xFFE2E8F0),
                  ),
                ),
              ],
            ),
          ),
        LayoutBuilder(
          builder: (context, constraints) {
            final fillWidth = constraints.maxWidth * (safe / 100.0);
            return Stack(
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  width: fillWidth,
                  height: height,
                  decoration: BoxDecoration(
                    gradient: fillGradient,
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(color: shadowColor, blurRadius: 10),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
