import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

void showToast(BuildContext context, String message) {
  final overlayState = Overlay.maybeOf(context, rootOverlay: true) ?? Overlay.maybeOf(context);
  if (overlayState == null) {
    try {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (_) {}
    return;
  }
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 110.0,
      left: 32.0,
      right: 32.0,
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: 1.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: context.colors.outline, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.shadow,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);
  Timer(const Duration(milliseconds: 2200), () {
    overlayEntry.remove();
  });
}