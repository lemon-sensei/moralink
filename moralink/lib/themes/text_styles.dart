// ---------- Common
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moralink/themes/colors.dart';

class AppTextStyles {
  static TextTheme get lightTextTheme {
    return TextTheme(
      displayLarge: GoogleFonts.prompt(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.prompt(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.prompt(
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: GoogleFonts.prompt(
        fontSize: 40,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headlineMedium: GoogleFonts.prompt(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headlineSmall: GoogleFonts.prompt(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.prompt(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleMedium: GoogleFonts.prompt(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.prompt(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.prompt(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.prompt(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.prompt(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.prompt(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      labelMedium: GoogleFonts.prompt(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelSmall: GoogleFonts.prompt(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      displayLarge: GoogleFonts.prompt(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: AppColors.accent,
      ),
      displayMedium: GoogleFonts.prompt(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: AppColors.accent,
      ),
      displaySmall: GoogleFonts.prompt(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: AppColors.accent,
      ),
      headlineLarge: GoogleFonts.prompt(
        fontSize: 40,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.accent,
      ),
      headlineMedium: GoogleFonts.prompt(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.accent,
      ),
      headlineSmall: GoogleFonts.prompt(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.accent,
      ),
      titleLarge: GoogleFonts.prompt(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.prompt(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.prompt(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.prompt(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.prompt(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.prompt(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: Colors.white,
      ),
      labelLarge: GoogleFonts.prompt(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: Colors.white,
      ),
      labelMedium: GoogleFonts.prompt(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: Colors.white,
      ),
      labelSmall: GoogleFonts.prompt(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: Colors.white,
      ),
    );
  }
}