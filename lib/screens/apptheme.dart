import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 137, 145, 255); 
  static const Color primaryVariant = Color.fromARGB(255, 86, 53, 163);
  static const Color secondary = Color(0xFF03DAC6); 
  static const Color background = Color(0xFFF5F5F5); 
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020); 
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
}

class AppTypography {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTypography.headline1,
      headlineMedium: AppTypography.headline2,
      bodyLarge: AppTypography.bodyText1,
      labelLarge: AppTypography.button,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      headlineLarge: AppTypography.headline1,
      headlineMedium: AppTypography.headline2,
      bodyLarge: AppTypography.bodyText1,
      labelLarge: AppTypography.button,
    ),
  );
}
