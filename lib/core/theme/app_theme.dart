import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFFF0F1F1);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color accentGreen = Color(0xFF166D56);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color textPrimary = Color(0xFF173F35);
  static const Color textSecondary = Color(0xFF6B8079);
  static const Color border = Color(0xFFE0E9E5);
  static const Color softSurface = Color(0xFFE6F3EE);

  static const Color darkBackground = Color(0xFF0F1715);
  static const Color darkSurface = Color(0xFF17211E);
  static const Color darkSoftSurface = Color(0xFF20302B);
  static const Color darkBorder = Color(0xFF29423B);
  static const Color darkTextPrimary = Color(0xFFF1F6F3);
  static const Color darkTextSecondary = Color(0xFFA8BBB4);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      primaryColor: accentGreen,
      colorScheme: const ColorScheme.light(
        primary: accentGreen,
        secondary: accentBlue,
        surface: surface,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: accentGreen,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: accentGreen,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF72D4B4),
        secondary: Color(0xFF8AB4FF),
        surface: darkSurface,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: Color(0xFF72D4B4),
        unselectedItemColor: darkTextSecondary,
      ),
    );
  }
}

extension AppThemeContext on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get appBackground =>
      isDarkMode ? AppTheme.darkBackground : AppTheme.background;

  Color get appSurface =>
      isDarkMode ? AppTheme.darkSurface : AppTheme.surface;

  Color get appSoftSurface =>
      isDarkMode ? AppTheme.darkSoftSurface : AppTheme.softSurface;

  Color get appBorder => isDarkMode ? AppTheme.darkBorder : AppTheme.border;

  Color get appTextPrimary =>
      isDarkMode ? AppTheme.darkTextPrimary : AppTheme.textPrimary;

  Color get appTextSecondary =>
      isDarkMode ? AppTheme.darkTextSecondary : AppTheme.textSecondary;

  Color get appDockSurface =>
      isDarkMode ? const Color(0xD91B2623) : const Color(0xC9FFFFFF);

  Color get appDockSurfaceFocused =>
      isDarkMode ? const Color(0xF022312C) : const Color(0xF7FFFFFF);

  Color get appDockBorder =>
      isDarkMode ? const Color(0x663D5B51) : const Color(0x26FFFFFF);

  Color get appDockBorderFocused =>
      isDarkMode ? const Color(0x9972D4B4) : const Color(0x66FFFFFF);

  Color get appNavIcon =>
      isDarkMode ? const Color(0xFFB8D2C8) : const Color(0xFF315B50);
}
