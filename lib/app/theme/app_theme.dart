import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared brand design tokens for HR Leave Management.
///
/// Direction: light-first, minimal/clean, inspired by a reviewed Figma
/// Community HRMS reference (card-grid dashboard, segmented toggles,
/// outlined form fields, brick-red accent, subtle 8-ish px corners).
///
/// These values are mirrored in the Jetpack Compose theme of the sibling
/// Android app so both clients present one consistent product, even though
/// they're built on completely different frameworks. Keep the two in sync
/// if a token changes here.
abstract class AppColors {
  static const Color primary = Color(0xFFCA282C); // Brick red
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightBackground = Color(0xFFF7F7F8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE1E1E4);
  static const Color danger = Color(0xFFCA282C);
  static const Color warning = Color(0xFFFB8C00);
  static const Color success = Color(0xFF2E7D32);
}

abstract class AppShapes {
  static const double buttonRadius = 12;
  static const double cardRadius = 14;
  static const double fieldRadius = 12;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? Colors.white : Colors.black87;
    final border = isDark ? Colors.white24 : AppColors.lightBorder;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primary,
      onSecondary: Colors.white,
      error: AppColors.danger,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
    );

    final textTheme = GoogleFonts.poppinsTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.cardRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.fieldRadius),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.fieldRadius),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.fieldRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.buttonRadius),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.buttonRadius),
          side: BorderSide(color: border),
        ),
      ),
      useMaterial3: true,
    );
  }
}
