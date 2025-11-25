import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF6200EE);
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Colors.white;
  static const Color errorLight = Color(0xFFB00020);
  static const Color onPrimaryLight = Colors.white;
  static const Color onSecondaryLight = Colors.black;
  static const Color onBackgroundLight = Colors.black;
  static const Color onSurfaceLight = Colors.black;

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color onPrimaryDark = Colors.black;
  static const Color onSecondaryDark = Colors.black;
  static const Color onBackgroundDark = Colors.white;
  static const Color onSurfaceDark = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        secondary: secondaryLight,
        surface: surfaceLight,
        error: errorLight,
        onPrimary: onPrimaryLight,
        onSecondary: onSecondaryLight,
        onSurface: onSurfaceLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryLight,
        foregroundColor: onPrimaryLight,
        elevation: 0,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto', // Or any other premium font if added
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        secondary: secondaryDark,
        surface: surfaceDark,
        error: errorDark,
        onPrimary: onPrimaryDark,
        onSecondary: onSecondaryDark,
        onSurface: onSurfaceDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDark, // Dark app bar for dark mode
        foregroundColor: onSurfaceDark,
        elevation: 0,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto',
    );
  }
}
