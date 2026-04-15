import 'dart:ui';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color duoGreen = Color(0xFF58cc02);
  static const Color duoGreenDark = Color(0xFF46a302);
  static const Color duoBlue = Color(0xFF1cb0f6);
  static const Color duoBlueDark = Color(0xFF1899d6);
  static const Color duoRed = Color(0xFFff4b4b);
  static const Color duoRedDark = Color(0xFFea2b2b);
  static const Color duoViolet = Color(0xFFce82ff);
  static const Color duoVioletDark = Color(0xFFa559ce);
  static const Color duoOrange = Color(0xFFff9600);
  static const Color duoOrangeDark = Color(0xFFcc7800);
  
  static const Color background = Color(0xFF0b0f19);
  static const Color surface = Color(0xFF1f1f28);
  
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: duoBlue,
      fontFamily: 'Nunito',
      colorScheme: const ColorScheme.dark(
        primary: duoBlue,
        secondary: duoGreen,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static BoxDecoration get glassDecoration {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 30,
          offset: const Offset(0, 4),
        )
      ],
    );
  }

  // Used for wrapping elements with a true glass blur
  static Widget applyGlassBlur({required Widget child, double borderRadius = 20, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}