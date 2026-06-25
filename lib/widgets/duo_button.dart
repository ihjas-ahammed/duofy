import 'package:flutter/material.dart';

class DuoButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color shadowColor;
  final bool isOutline;
  final Widget? child;

  const DuoButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.shadowColor,
    this.isOutline = false,
    this.child,
  });

  @override
  State<DuoButton> createState() => _DuoButtonState();
}

class _DuoButtonState extends State<DuoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.only(top: _isPressed ? 4 : 0, bottom: _isPressed ? 0 : 4),
        decoration: BoxDecoration(
          color: widget.isOutline ? Colors.transparent : widget.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.isOutline ? widget.color : widget.shadowColor,
            width: 2,
          ),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: widget.child ?? Text(
            widget.text.toUpperCase(),
            style: TextStyle(
              color: widget.isOutline ? widget.color : Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class DuoIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color color;
  final Color shadowColor;
  final Widget icon;
  final double size;

  const DuoIconButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.shadowColor,
    required this.icon,
    this.size = 56.0,
  });

  @override
  State<DuoIconButton> createState() => _DuoIconButtonState();
}

class _DuoIconButtonState extends State<DuoIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.only(
          top: _isPressed ? 4.0 : 0.0,
          bottom: _isPressed ? 0.0 : 4.0,
        ),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        child: Center(
          child: widget.icon,
        ),
      ),
    );
  }
}