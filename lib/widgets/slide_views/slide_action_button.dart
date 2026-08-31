import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/app_theme.dart';

/// Primary action button matching docs/new-theme/slide-p/theory.html .btn-action
class SlideActionButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Widget? leadingIcon;
  final bool showTrailingChevron;
  final bool isCenterAligned;

  const SlideActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.leadingIcon,
    this.showTrailingChevron = true,
    this.isCenterAligned = false,
  });

  @override
  State<SlideActionButton> createState() => _SlideActionButtonState();
}

class _SlideActionButtonState extends State<SlideActionButton> {
  bool _isPressed = false;

  static const Duration _pressAnim = Duration(milliseconds: 90);

  void _handleTapUp() {
    setState(() => _isPressed = false);
    Future.delayed(_pressAnim, () {
      if (mounted) widget.onPressed?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final primaryColor = widget.color ?? context.colors.primaryBlue;
    final effectiveColor = isEnabled
        ? primaryColor
        : (context.colors.isDark
            ? const Color(0xFF1E293B)
            : const Color(0xFFCBD5E1));

    final textColor = isEnabled
        ? Colors.white
        : (context.colors.isDark ? Colors.white38 : const Color(0xFF64748B));

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => _handleTapUp() : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      child: AnimatedContainer(
        duration: _pressAnim,
        curve: Curves.easeOutCubic,
        margin: EdgeInsets.only(
          top: _isPressed ? 3.0 : 0.0,
          bottom: _isPressed ? 0.0 : 3.0,
        ),
        width: double.infinity,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: (isEnabled && !_isPressed)
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: -4,
                  ),
                ]
              : [],
        ),
        child: widget.isCenterAligned
            ? Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.leadingIcon != null) ...[
                      widget.leadingIcon!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (widget.showTrailingChevron) ...[
                      const SizedBox(width: 6),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 16,
                        color: textColor,
                      ),
                    ],
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.leadingIcon != null)
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          child: Center(
                            child: widget.leadingIcon,
                          ),
                        ),
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  if (widget.showTrailingChevron)
                    Icon(
                      LucideIcons.chevronRight,
                      size: 16,
                      color: textColor,
                    ),
                ],
              ),
      ),
    );
  }
}
