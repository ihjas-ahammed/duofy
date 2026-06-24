import 'dart:async';
import 'package:flutter/material.dart';

void showToast(BuildContext context, String message) {
  final overlayState = Overlay.of(context);
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
                color: const Color(0xFF1E293B).withOpacity(0.95), // Premium slate dark color
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
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
