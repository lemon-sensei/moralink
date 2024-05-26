// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/themes/colors.dart';
import 'package:moralink/themes/text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      hintColor: AppColors.accent,
      scaffoldBackgroundColor: AppColors.lightScaffoldBackground,
      textTheme: AppTextStyles.lightTextTheme,
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
      ),
      // Add other light theme configurations
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      hintColor: AppColors.accent,
      scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
      textTheme: AppTextStyles.darkTextTheme,
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
      ),
      // Add other dark theme configurations
    );
  }
}