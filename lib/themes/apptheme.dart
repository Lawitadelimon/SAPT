import 'package:flutter/material.dart';

class AppColors {
  // Colores personalizados
  static const Color primary = Color.fromARGB(255, 137, 145, 255);
  static const Color primaryVariant = Color.fromARGB(255, 1, 140, 255);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Color.fromARGB(255, 202, 233, 247);
  static const Color surface = Colors.white;
  static const Color error = Color.fromARGB(255, 187, 0, 34);
  static const Color textPrimary = Color.fromARGB(255, 255, 255, 255);
  static const Color textSecondary = Colors.grey;
  static const Color button = Color.fromARGB(255, 137, 145, 255);
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

  static const TextStyle paragraph = TextStyle(
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

class AppTheme { //Tema global 
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
    iconTheme: const IconThemeData(
      color: AppColors.primary, // El color de los iconos
      size: 24,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTypography.headline1, // Para los titulos
      headlineMedium: AppTypography.headline2, // Para subtitulos
      bodyLarge: AppTypography.paragraph, // Texto en general jeje
      labelLarge: AppTypography.button, // Para el texto que este en algun boton
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTypography.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryVariant,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTypography.headline1,
      headlineMedium: AppTypography.headline2,
      bodyLarge: AppTypography.paragraph,
      labelLarge: AppTypography.button,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTypography.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
