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
        iconTheme: IconThemeData(color: AppColors.lightIconColor),
      ),
      iconTheme: const IconThemeData(color: AppColors.lightIconColor),
      primaryIconTheme: const IconThemeData(color: AppColors.primary),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
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
        iconTheme: IconThemeData(color: AppColors.darkIconColor),
      ),
      iconTheme: const IconThemeData(color: AppColors.darkIconColor),
      primaryIconTheme: const IconThemeData(color: AppColors.primary),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      // Add other dark theme configurations
    );
  }
}
