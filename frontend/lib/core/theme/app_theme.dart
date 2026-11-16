import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static TextTheme _buildTextTheme(Color textColor) {
    // Start with the default text theme to avoid type conflicts
    final baseTheme = ThemeData.light().textTheme;

    // Apply fonts manually using copyWith to avoid the material_ui conflict
    return baseTheme.copyWith(
      displayLarge: GoogleFonts.spaceGrotesk(
          fontSize: 52, fontWeight: FontWeight.w700, height: 1.1, letterSpacing: -1.0, color: textColor),
      displayMedium: GoogleFonts.spaceGrotesk(
          fontSize: 48, fontWeight: FontWeight.w700, color: textColor),
      displaySmall: GoogleFonts.spaceGrotesk(
          fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5, color: textColor),
      headlineLarge: GoogleFonts.spaceGrotesk(
          fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5, color: textColor),
      headlineMedium: GoogleFonts.spaceGrotesk(
          fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: textColor),
      titleLarge: GoogleFonts.spaceGrotesk(
          fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
      bodyLarge: GoogleFonts.dmSans(color: textColor),
      bodyMedium: GoogleFonts.dmSans(color: textColor),
      labelLarge: GoogleFonts.dmSans(color: textColor),
    );
  }

  static ThemeData get lightTheme {
    final textTheme = _buildTextTheme(AppColors.lightTextDark);

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primaryNavy,
      textTheme: textTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryNavy,
        secondary: AppColors.accentDarkGreen,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryNavy,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}