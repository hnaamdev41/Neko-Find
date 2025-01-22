// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - more muted
  static const primary = Color(0xFF6B4E71);     // Muted purple
  static const secondary = Color(0xFFB6947C);   // Muted brown/peach
  
  // Supporting colors - softer tones
  static const background = Color(0xFFF5F5F5);  // Very light gray background
  static const surface = Colors.white;
  static const error = Color(0xFFCF6679);       // Softer red
  
  // Text colors - easier on eyes
  static const textPrimary = Color(0xFF2C2C2C);    // Soft black
  static const textSecondary = Color(0xFF666666);   // Medium gray
  
  // Cat-themed accent colors - muted palette
  static const catGray = Color(0xFFAFAFAF);        // Soft gray
  static const catBrown = Color(0xFF8D7B74);       // Muted brown
  static const catBeige = Color(0xFFD8C3A5);       // Soft beige
  static const catCharcoal = Color(0xFF4A4A4A);    // Soft black
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    
    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    
    // Card theme
    cardTheme: CardTheme(
      elevation: 1, // Reduced elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
    ),
    
    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 1, // Reduced elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
    
    // FloatingActionButton theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF8F8F8), // Very light gray
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
    ),

    // Text theme
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: const Color(0xFF1A1A1A),    // Darker background
      surface: const Color(0xFF242424),       // Slightly lighter than background
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    
    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF242424),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.grey[200]),
    ),
    
    // Card theme
    cardTheme: CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF2C2C2C), // Slightly lighter than surface
    ),
    
    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
    
    // FloatingActionButton theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF404040)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF404040)),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.grey[200],
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: Colors.grey[200],
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: Colors.grey[300],
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey[400],
        fontSize: 14,
      ),
    ),
  );
}