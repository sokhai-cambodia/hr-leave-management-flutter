import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared brand design tokens for HR Leave Management.
///
/// Direction (redesign batch 3, see `feature/ui-redesign`): clean white
/// canvas + a single confident red/coral brand accent, rounded cards and
/// pill buttons, bottom-tab-bar shell — inspired by a reference ERP mobile
/// app mockup (`ui.webp` at repo root: splash/login/home screens). Adapted,
/// not cloned — this app keeps its own name/branding, only the visual
/// language (color, shape, layout rhythm) is borrowed.
/// Flutter-app-only for now — NOT currently mirrored in the sibling
/// Jetpack Compose Android app's theme; revisit syncing them if this
/// direction is validated.
abstract class AppColors {
  static const Color primary = Color(0xFFE23744); // Confident red/coral
  static const Color primaryDark = Color(0xFFC01F2B); // Pressed/gradient end
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightFieldFill = Color(0xFFF7F7F9);
  static const Color lightBorder = Color(0xFFEAEAEE);
  static const Color danger = Color(0xFFEF4444); // True red - errors/rejected
  static const Color warning = Color(0xFFF5A623); // Amber
  static const Color success = Color(0xFF22A659); // Green
  static const Color info = Color(0xFF4C8DFF); // Soft blue - stat-card accent

  /// Light tint + matching saturated foreground for a stat-card/badge
  /// background, derived from one base color instead of hand-picking a
  /// bg/fg pair per card (avoids one-off constants per stat tile).
  static ({Color background, Color foreground}) pastel(Color base) {
    return (
      background: Color.alphaBlend(base.withValues(alpha: 0.14), Colors.white),
      foreground: base,
    );
  }
}

abstract class AppShapes {
  static const double buttonRadius = 14;
  static const double cardRadius = 18;
  static const double fieldRadius = 12;
  static const double pillRadius = 999;
}

/// Spacing scale - use instead of hardcoding `SizedBox`/`EdgeInsets` values.
abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
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
        fillColor: isDark ? surface : AppColors.lightFieldFill,
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
        hintStyle: TextStyle(color: onSurface.withValues(alpha: 0.35)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
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
      tabBarTheme: TabBarThemeData(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppShapes.pillRadius),
        ),
        indicatorColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: onSurface.withValues(alpha: 0.6),
        labelStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: textTheme.labelLarge,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: onSurface.withValues(alpha: 0.45),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
      ),
      useMaterial3: true,
    );
  }
}
