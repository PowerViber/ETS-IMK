import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFFF9FAFB); // Light gray background
  static const Color surface = Color(0xFFFFFFFF);    // White cards
  static const Color accentGreen = Color(0xFF10B981); // Darker green for light text
  static const Color accentBlue = Color(0xFF3B82F6);  // Solid blue
  static const Color textPrimary = Color(0xFF111827); // Very dark text
  static const Color textSecondary = Color(0xFF6B7280); // Gray text
  
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
}
