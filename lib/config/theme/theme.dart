import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_project/core/environments/environment.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    var config = Environment().configuration;
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        extensions: const <ThemeExtension<dynamic>>[
          CustomThemeExtensions(
              greyWithColor: Colors.black26,
              groceryButtonBorder: Color.fromRGBO(0, 0, 0, 0.05),
              groceryButtonShadow: Color.fromRGBO(0, 0, 0, 0.16))
        ],
        hoverColor: config.hoverColor,
        cardTheme: CardTheme(
            color: Colors.white,
            shadowColor: config.shadowColor,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.zero,
            surfaceTintColor: Colors.white),
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: _elevatedButtonTheme,
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 5, backgroundColor: Colors.amber.shade200),
        appBarTheme: AppBarTheme(
            backgroundColor: config.appBarColor,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25)),
        colorScheme: ColorScheme.fromSeed(seedColor: config.seedColor),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white));
  }

  static ThemeData darkThemeData() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        extensions: const <ThemeExtension<dynamic>>[
          CustomThemeExtensions(
              greyWithColor: Colors.white60,
              groceryButtonBorder: Colors.white54,
              groceryButtonShadow: Colors.white)
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
            backgroundColor: Environment().configuration.seedColor,
            foregroundColor: Colors.white));
  }
}

@immutable
class CustomThemeExtensions extends ThemeExtension<CustomThemeExtensions> {
  const CustomThemeExtensions(
      {required this.greyWithColor,
      required this.groceryButtonShadow,
      required this.groceryButtonBorder});

  final Color greyWithColor, groceryButtonBorder, groceryButtonShadow;

  @override
  ThemeExtension<CustomThemeExtensions> copyWith(
      {Color? greyWithColor,
      Color? groceryButtonBorder,
      Color? groceryButtonShadow}) {
    return CustomThemeExtensions(
        greyWithColor: greyWithColor ?? this.greyWithColor,
        groceryButtonShadow: groceryButtonShadow ?? this.groceryButtonShadow,
        groceryButtonBorder: groceryButtonBorder ?? this.groceryButtonBorder);
  }

  @override
  CustomThemeExtensions lerp(
      ThemeExtension<CustomThemeExtensions>? other, double t) {
    if (other is! CustomThemeExtensions) {
      return this;
    }
    return CustomThemeExtensions(
        greyWithColor: greyWithColor,
        groceryButtonShadow: groceryButtonShadow,
        groceryButtonBorder: groceryButtonBorder);
  }
}
