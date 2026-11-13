import 'package:flutter/material.dart';

abstract final class AppColors {
  static const orange = Color(0xFFFF6B35);
  static const cream = Color(0xFFF5EFE6);
  static const ink = Color(0xFF1C1A17);
  static const muted = Color(0xFF9B8B81);
  static const fieldBorder = Color(0xFFE8DDD5);
  static const fieldBg = Color(0xFFFAF7F4);
  static const green = Color(0xFF35B873);
  static const greenBg = Color(0xFFE7FFF1);
  static const errorRed = Color(0xFFD53A2F);
}

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.cream,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Inter'),
      displayMedium: TextStyle(fontFamily: 'Inter'),
      displaySmall: TextStyle(fontFamily: 'Inter'),
      headlineLarge: TextStyle(fontFamily: 'Inter'),
      headlineMedium: TextStyle(fontFamily: 'Inter'),
      headlineSmall: TextStyle(fontFamily: 'Inter'),
      titleLarge: TextStyle(fontFamily: 'Inter'),
      titleMedium: TextStyle(fontFamily: 'Inter'),
      titleSmall: TextStyle(fontFamily: 'Inter'),
      bodyLarge: TextStyle(fontFamily: 'Inter'),
      bodyMedium: TextStyle(fontFamily: 'Inter'),
      bodySmall: TextStyle(fontFamily: 'Inter'),
      labelLarge: TextStyle(fontFamily: 'Inter'),
      labelMedium: TextStyle(fontFamily: 'Inter'),
      labelSmall: TextStyle(fontFamily: 'Inter'),
    ),
  );
}

class AppText {
  static TextStyle inter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
