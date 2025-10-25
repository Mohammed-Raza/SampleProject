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
              groceryButtonShadow: Color.fromRGBO(0, 0, 0, 0.16),
              tableBorderColor: Colors.black38)
        ],
        hoverColor: config.hoverColor,
        cardTheme: CardThemeData(
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
        dropdownMenuTheme:
            DropdownMenuThemeData(inputDecorationTheme: lightInputThemeData),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 5, backgroundColor: Colors.amber.shade200),
        appBarTheme: AppBarTheme(
            backgroundColor: config.appBarColor,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25)),
        colorScheme: ColorScheme.fromSeed(seedColor: config.seedColor),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        inputDecorationTheme: lightInputThemeData);
  }

  static ThemeData darkThemeData() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        extensions: const <ThemeExtension<dynamic>>[
          CustomThemeExtensions(
              greyWithColor: Colors.white60,
              groceryButtonBorder: Colors.white54,
              groceryButtonShadow: Colors.white,
              tableBorderColor: Colors.white54)
        ],
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: _elevatedButtonTheme,
        scaffoldBackgroundColor: Colors.black45,
        appBarTheme: const AppBarTheme(elevation: 5),
        dropdownMenuTheme:
            DropdownMenuThemeData(inputDecorationTheme: darkInputThemeData),
        inputDecorationTheme: darkInputThemeData,
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

  static get lightInputThemeData => InputDecorationThemeData(
      border: _border(Colors.black45),
      errorBorder: _border(Colors.red),
      focusedBorder: _border(Colors.black45),
      enabledBorder: _border(Colors.black45),
      focusedErrorBorder: _border(Colors.red));

  static get darkInputThemeData => InputDecorationThemeData(
      border: _border(Colors.white),
      errorBorder: _border(Colors.tealAccent),
      focusedBorder: _border(Colors.white),
      enabledBorder: _border(Colors.white),
      focusedErrorBorder: _border(Colors.tealAccent));

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color));
}

@immutable
class CustomThemeExtensions extends ThemeExtension<CustomThemeExtensions> {
  const CustomThemeExtensions(
      {required this.greyWithColor,
      required this.groceryButtonShadow,
      required this.groceryButtonBorder,
      required this.tableBorderColor});

  final Color greyWithColor,
      groceryButtonBorder,
      groceryButtonShadow,
      tableBorderColor;

  @override
  ThemeExtension<CustomThemeExtensions> copyWith(
      {Color? greyWithColor,
      Color? groceryButtonBorder,
      Color? groceryButtonShadow,
      Color? tableBorder}) {
    return CustomThemeExtensions(
        greyWithColor: greyWithColor ?? this.greyWithColor,
        groceryButtonShadow: groceryButtonShadow ?? this.groceryButtonShadow,
        groceryButtonBorder: groceryButtonBorder ?? this.groceryButtonBorder,
        tableBorderColor: tableBorder ?? tableBorderColor);
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
        groceryButtonBorder: groceryButtonBorder,
        tableBorderColor: tableBorderColor);
  }
}
