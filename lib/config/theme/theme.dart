import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        extensions: const <ThemeExtension<dynamic>>[
          CustomThemeExtensions(greyWithColor: Colors.black26)
        ],
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: _elevatedButtonTheme,
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 5, backgroundColor: Colors.amber.shade200),
        appBarTheme: AppBarTheme(backgroundColor: Colors.teal.shade200),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        cardTheme: CardThemeData(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.zero,
            elevation: 5,
            shadowColor: Colors.teal.withValues(alpha: 0.4)));
  }

  static ThemeData darkThemeData() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        extensions: const <ThemeExtension<dynamic>>[
          CustomThemeExtensions(greyWithColor: Colors.white60)
        ],
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: _elevatedButtonTheme,
        scaffoldBackgroundColor: Colors.black45,
        appBarTheme: const AppBarTheme(elevation: 5),
        cardTheme: CardThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.zero,
            elevation: 5));
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, foregroundColor: Colors.white));
  }
}

@immutable
class CustomThemeExtensions extends ThemeExtension<CustomThemeExtensions> {
  const CustomThemeExtensions({this.greyWithColor});

  final Color? greyWithColor;

  @override
  ThemeExtension<CustomThemeExtensions> copyWith({Color? headerColor}) {
    return const CustomThemeExtensions();
  }

  @override
  CustomThemeExtensions lerp(
      ThemeExtension<CustomThemeExtensions>? other, double t) {
    if (other is! CustomThemeExtensions) {
      return this;
    }
    return const CustomThemeExtensions();
  }
}
