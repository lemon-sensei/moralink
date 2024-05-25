import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moralink/themes/colors.dart';

class AppTextStyles {
  static TextTheme get lightTextTheme {
    return TextTheme(
      headlineLarge: GoogleFonts.prompt(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.prompt(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      // Add other light text styles as needed
    );
  }

  static TextTheme get darkTextTheme {
    return const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.accent,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      // Add other dark text styles as needed
    );
  }
}
