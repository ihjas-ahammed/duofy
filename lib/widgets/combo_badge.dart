import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ComboBadge extends StatefulWidget {
  final int combo;
  final bool isCompact;

  const ComboBadge({
    super.key,
    required this.combo,
    this.isCompact = false,
  });

  @override
  State<ComboBadge> createState() => _ComboBadgeState();
}

class _ComboBadgeState extends State<ComboBadge>
    with TickerProviderStateMixin {
  late AnimationController _popController;
  late Animation<double> _popScaleAnimation;
  late Animation<double> _popRotateAnimation;

  late AnimationController _pulseController;
  late Animation<double> _pulseScaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Scale pop on combo increase
    _popController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _popScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.38)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.38, end: 0.95)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_popController);

    _popRotateAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -0.08),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.08, end: 0.08),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.08, end: 0.0),
        weight: 30,
      ),
    ]).animate(_popController);

    // Looping glow / pulse animation for momentum effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseScaleAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.35, end: 0.85).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Initial entrance pop
    _popController.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(ComboBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.combo != oldWidget.combo) {
      _popController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _popController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // Visual Theme configuration based on Combo Tier & Color Psychology
  _ComboStyle _getStyle(int combo) {
    if (combo >= 5) {
      // Tier 4: Apex Celestial Flow (Violet -> Purple -> Electric Cyan) - Focus & Mastery
      return _ComboStyle(
        gradient: const LinearGradient(
          colors: [Color(0xFFA78BFA), Color(0xFF7C3AED), Color(0xFF22D3EE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        glowColor: const Color(0xFFA78BFA),
        textColor: Colors.white,
        iconColor: const Color(0xFF22D3EE),
        borderColors: [const Color(0xFFC4B5FD), Colors.white],
        labelPrefix: 'COMBO ',
      );
    } else if (combo == 4) {
      // Tier 3: Burning Fire Crimson (Red -> Crimson) - High Performance & Passion
      return _ComboStyle(
        gradient: const LinearGradient(
          colors: [Color(0xFFF87171), Color(0xFFDC2626), Color(0xFF991B1B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        glowColor: const Color(0xFFF87171),
        textColor: Colors.white,
        iconColor: const Color(0xFFFFC94D),
        borderColors: [const Color(0xFFFCA5A5), Colors.white],
        labelPrefix: 'x',
      );
    } else if (combo == 3) {
      // Tier 2: Warm Amber & Duo Orange (Gold -> Orange) - Heat & Energy
      return _ComboStyle(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFC94D), Color(0xFFF59E0B), Color(0xFFD97706)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        glowColor: const Color(0xFFFFC94D),
        textColor: const Color(0xFF0F172A),
        iconColor: Colors.white,
        borderColors: [const Color(0xFFFDE68A), Colors.white],
        labelPrefix: 'x',
      );
    } else {
      // Tier 1: Duo Emerald Green (Green -> Dark Emerald) - Growth & Momentum
      return _ComboStyle(
        gradient: const LinearGradient(
          colors: [Color(0xFF34D399), Color(0xFF059669), Color(0xFF047857)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        glowColor: const Color(0xFF34D399),
        textColor: Colors.white,
        iconColor: const Color(0xFFFFC94D),
        borderColors: [const Color(0xFFA7F3D0), Colors.white],
        labelPrefix: 'x',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStyle(widget.combo);

    return AnimatedBuilder(
      animation: Listenable.merge([_popController, _pulseController]),
      builder: (context, _) {
        final scale = _popScaleAnimation.value * _pulseScaleAnimation.value;
        final rotation = _popRotateAnimation.value;
        final glowOpacity = _glowAnimation.value;

        final fontSize = widget.isCompact ? 11.0 : 12.0;
        final iconSize = widget.isCompact ? 13.0 : 15.0;
        final padH = widget.isCompact ? 8.0 : 10.0;
        final padV = widget.isCompact ? 3.0 : 5.0;

        return Transform.scale(
          scale: scale,
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
              decoration: BoxDecoration(
                gradient: style.gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: style.glowColor.withValues(alpha: 0.55 * glowOpacity),
                    blurRadius: 10,
                    spreadRadius: 1.5,
                  ),
                ],
                border: Border.all(
                  color: style.borderColors.first.withValues(alpha: 0.8),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Lightning Bolt Icon
                  Transform.rotate(
                    angle: math.sin(_pulseController.value * math.pi * 2) * 0.1,
                    child: Icon(
                      LucideIcons.zap,
                      size: iconSize,
                      color: style.iconColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Combo Count Label (e.g. x2, x3, x4, COMBO x5)
                  Text(
                    '${style.labelPrefix}${widget.combo}',
                    style: TextStyle(
                      color: style.textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.6,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ComboStyle {
  final LinearGradient gradient;
  final Color glowColor;
  final Color textColor;
  final Color iconColor;
  final List<Color> borderColors;
  final String labelPrefix;

  _ComboStyle({
    required this.gradient,
    required this.glowColor,
    required this.textColor,
    required this.iconColor,
    required this.borderColors,
    required this.labelPrefix,
  });
}
