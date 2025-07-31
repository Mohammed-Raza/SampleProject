import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
        brightness: Brightness.light,
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: _elevatedButtonTheme,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.teal.shade200),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        cardTheme: CardThemeData(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.zero,
            elevation: 5,
            shadowColor: Colors.teal.withValues(alpha: 0.4)),
        useMaterial3: true);
  }

  static ThemeData darkThemeData() {
    return ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: _elevatedButtonTheme,
        appBarTheme: const AppBarTheme(elevation: 5),
        cardTheme: CardThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.zero,
            elevation: 5),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true);
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, foregroundColor: Colors.white));
  }
}
