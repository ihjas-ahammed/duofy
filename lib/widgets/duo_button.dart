import 'package:flutter/material.dart';

class DuoButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color shadowColor;
  final bool isOutline;

  const DuoButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.shadowColor,
    this.isOutline = false,
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Center(
          child: Text(
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