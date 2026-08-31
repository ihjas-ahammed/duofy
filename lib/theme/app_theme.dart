import 'dart:ui';
import 'package:flutter/material.dart';

/// Semantic color tokens for the Sirius celestial theme.
///
/// Obtain via `context.colors` (preferred — registers a Theme dependency so
/// the widget rebuilds when the theme mode flips) or, where no context is
/// available, via [AppTheme.darkColors]/[AppTheme.lightColors].
class AppColors {
  final Brightness brightness;

  // Accents
  final Color primary; // star blue
  final Color primaryDark; // pressed/3D-shadow variant
  final Color secondary; // cyan
  final Color success;
  final Color successDark;
  final Color danger;
  final Color dangerDark;
  final Color gold; // XP / streaks
  final Color goldDark;
  final Color violet;
  final Color violetDark;

  // Surfaces
  final Color background;
  final Color surface;
  final Color surfaceAlt; // subtle fill on top of surface

  // Content
  final Color textPrimary;
  final Color textSecondary;
  final Color textFaint;
  final Color outline;

  // Glass / depth
  final Color glassFill;
  final Color glassStrong;
  final Color shadow;

  const AppColors({
    required this.brightness,
    required this.primary,
    required this.primaryDark,
    required this.secondary,
    required this.success,
    required this.successDark,
    required this.danger,
    required this.dangerDark,
    required this.gold,
    required this.goldDark,
    required this.violet,
    required this.violetDark,
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.textFaint,
    required this.outline,
    required this.glassFill,
    required this.glassStrong,
    required this.shadow,
  });

  bool get isDark => brightness == Brightness.dark;

  // New slide theme tokens
  Color get cardBg => isDark ? const Color(0xFF131B2E) : const Color(0xFFFFFFFF);
  Color get cardBorder => isDark ? const Color(0x14FFFFFF) : const Color(0xE6E2E8F0);
  Color get mathBoxBg => isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9);
  Color get mathBoxBorder => isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
  Color get primaryBlue => isDark ? const Color(0xFF2563EB) : const Color(0xFF005CF6);
  Color get primaryBlueHover => isDark ? const Color(0xFF1D4ED8) : const Color(0xFF0046C7);
  Color get primaryBlueLight => isDark ? const Color(0x262563EB) : const Color(0xFFEFF6FF);
  Color get accentGreen => isDark ? const Color(0xFF10B981) : const Color(0xFF059669);
  Color get accentGreenLight => isDark ? const Color(0x1F10B981) : const Color(0xFFECFDF5);
  Color get accentGreenBorder => isDark ? const Color(0x4D10B981) : const Color(0xFFA7F3D0);
  Color get sheetBg => isDark ? const Color(0xFF091E17) : const Color(0xFFF7FDFA);
  Color get sheetBorder => isDark ? const Color(0xFF059669) : const Color(0xFF10B981);
  Color get textMain => isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);
  Color get textMuted => isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
  Color get textSubtle => isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);
  Color get badgeBg => isDark ? const Color(0x0DFFFFFF) : const Color(0x0A000000);
}

/// Preferred access point for theme tokens: `context.colors.surface`.
extension ThemeColorsX on BuildContext {
  AppColors get colors => AppTheme.of(this);
}

class AppTheme {
  // ---------------------------------------------------------------------
  // Brand accents (celestial palette). The duo* names are legacy aliases
  // kept so the ~80 not-yet-migrated files re-skin without edits; new code
  // should use context.colors.* instead.
  // ---------------------------------------------------------------------
  static const Color duoGreen = Color(0xFF34D399);
  static const Color duoGreenDark = Color(0xFF059669);
  static const Color duoBlue = Color(0xFF5B8CFF);
  static const Color duoBlueDark = Color(0xFF3B6DE8);
  static const Color duoRed = Color(0xFFF87171);
  static const Color duoRedDark = Color(0xFFDC2626);
  static const Color duoViolet = Color(0xFFA78BFA);
  static const Color duoVioletDark = Color(0xFF7C3AED);
  static const Color duoOrange = Color(0xFFFFC94D);
  static const Color duoOrangeDark = Color(0xFFD97706);
  static const Color duoYellow = Color(0xFFFBBF24);
  static const Color duoYellowDark = Color(0xFFD97706);

  static const AppColors darkColors = AppColors(
    brightness: Brightness.dark,
    primary: Color(0xFF5B8CFF),
    primaryDark: Color(0xFF3B6DE8),
    secondary: Color(0xFF22D3EE),
    success: Color(0xFF34D399),
    successDark: Color(0xFF059669),
    danger: Color(0xFFF87171),
    dangerDark: Color(0xFFDC2626),
    gold: Color(0xFFFFC94D),
    goldDark: Color(0xFFD97706),
    violet: Color(0xFFA78BFA),
    violetDark: Color(0xFF7C3AED),
    background: Color(0xFF070B14),
    surface: Color(0xFF10172A),
    surfaceAlt: Color(0x0AFFFFFF), // white 4%
    textPrimary: Colors.white,
    textSecondary: Colors.white70,
    textFaint: Colors.white38,
    outline: Color(0x1AFFFFFF), // white 10%
    glassFill: Color(0x0DFFFFFF), // white 5%
    glassStrong: Color(0x66000000), // black 40%
    shadow: Color(0x4D000000), // black 30%
  );

  static const AppColors lightColors = AppColors(
    brightness: Brightness.light,
    primary: Color(0xFF4F46E5),
    primaryDark: Color(0xFF4338CA),
    secondary: Color(0xFF0284C7),
    success: Color(0xFF059669),
    successDark: Color(0xFF047857),
    danger: Color(0xFFDC2626),
    dangerDark: Color(0xFFB91C1C),
    gold: Color(0xFFD97706),
    goldDark: Color(0xFFB45309),
    violet: Color(0xFF7C3AED),
    violetDark: Color(0xFF6D28D9),
    background: Color(0xFFEEF2FF), // Celestial soft light blue-gray canvas
    surface: Color(0xFFF8FAFC), // Crisp soft slate surface for cards
    surfaceAlt: Color(0xFFE2E8F0), // Soft slate fill for containers
    textPrimary: Color(0xFF0F172A), // Deep charcoal navy (always dark in light mode)
    textSecondary: Color(0xFF334155), // Dark slate body text
    textFaint: Color(0xFF64748B), // Slate gray captions
    outline: Color(0xFFCBD5E1), // Crisp slate borders
    glassFill: Color(0x33FFFFFF), // Translucent sheer glass fill (maximum transparency)
    glassStrong: Color(0x66FFFFFF), // Frosted sheer glass container (maximum transparency)
    shadow: Color(0x140F172A),
  );

  /// Resolves tokens through the ambient [Theme], registering a rebuild
  /// dependency — the correct way inside widgets.
  static AppColors of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkColors : lightColors;

  /// Effective brightness for code without a BuildContext (legacy static
  /// [background]/[surface]/[glassDecoration] readers). Kept in sync by the
  /// themeMode listener in main.dart, resolving ThemeMode.system against the
  /// platform brightness. Such readers repaint on their next rebuild after a
  /// toggle rather than instantly — acceptable during migration.
  static Brightness currentBrightness = Brightness.dark;

  static AppColors get _current =>
      currentBrightness == Brightness.dark ? darkColors : lightColors;

  // Legacy static surface tokens; prefer context.colors.background/surface.
  static Color get background => _current.background;
  static Color get surface => _current.surface;

  static ThemeData get darkTheme => _theme(darkColors);
  static ThemeData get lightTheme => _theme(lightColors);

  static ThemeData _theme(AppColors c) {
    final base = c.isDark ? ColorScheme.dark : ColorScheme.light;
    return ThemeData(
      brightness: c.brightness,
      scaffoldBackgroundColor: c.background,
      primaryColor: c.primary,
      fontFamily: 'Nunito',
      colorScheme: base(
        primary: c.primary,
        secondary: c.secondary,
        error: c.danger,
        surface: c.surface,
        onSurface: c.textPrimary,
        onPrimary: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: c.textPrimary),
        bodyMedium: TextStyle(color: c.textPrimary),
        bodySmall: TextStyle(color: c.textSecondary),
        titleLarge: TextStyle(color: c.textPrimary, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: c.textPrimary, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(color: c.textSecondary, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        elevation: 0,
        centerTitle: true,
        foregroundColor: c.textPrimary,
        iconTheme: IconThemeData(color: c.textPrimary),
        titleTextStyle: TextStyle(
          color: c.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          fontFamily: 'Nunito',
        ),
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 2,
        shadowColor: c.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: c.outline, width: 1),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: c.outline, width: 1),
        ),
        titleTextStyle: TextStyle(
          color: c.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
        contentTextStyle: TextStyle(
          color: c.textSecondary,
          fontSize: 14,
          fontFamily: 'Nunito',
        ),
      ),
      iconTheme: IconThemeData(color: c.textPrimary),
    );
  }

  /// Context-aware glass card decoration; use instead of [glassDecoration].
  static BoxDecoration glassOf(BuildContext context, {double borderRadius = 20}) =>
      _glass(of(context), borderRadius);

  /// Legacy getter (no context): follows [currentBrightness].
  static BoxDecoration get glassDecoration => _glass(_current, 20);

  static BoxDecoration _glass(AppColors c, double borderRadius) {
    return BoxDecoration(
      color: c.glassFill,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: c.outline, width: 1),
      boxShadow: [
        BoxShadow(
          color: c.shadow,
          blurRadius: 30,
          offset: const Offset(0, 4),
        )
      ],
    );
  }

  // Used for wrapping elements with a true glass blur. Follows
  // [currentBrightness] when no explicit color is given.
  static Widget applyGlassBlur(
      {required Widget child, double borderRadius = 20, Color? color}) {
    final c = _current;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? c.glassStrong,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: c.outline, width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}