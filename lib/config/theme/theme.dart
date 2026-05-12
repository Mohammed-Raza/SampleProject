import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_project/core/environments/environment.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    final config = Environment().configuration;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: config.seedColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: config.seedColor,
      secondary: config.hoverColor,
      surface: const Color(0xFFFFFCF7),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF7F1E7),
      surfaceContainer: const Color(0xFFF0E9DD),
      outlineVariant: const Color(0xFFD8D0C4),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.dmSansTextTheme(
        ThemeData.light(useMaterial3: true).textTheme,
      ).copyWith(
        displaySmall: GoogleFonts.dmSerifDisplay(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF122117),
        ),
        headlineMedium: GoogleFonts.dmSerifDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF122117),
        ),
        titleLarge: GoogleFonts.dmSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF122117),
        ),
        titleMedium: GoogleFonts.dmSans(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF17261C),
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2E4133),
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF516053),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        CustomThemeExtensions(
          greyWithColor: Colors.black26,
          groceryButtonBorder: Color.fromRGBO(0, 0, 0, 0.05),
          groceryButtonShadow: Color.fromRGBO(0, 0, 0, 0.16),
          tableBorderColor: Colors.black38,
        )
      ],
      hoverColor: config.hoverColor,
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.94),
        shadowColor: config.shadowColor.withValues(alpha: 0.22),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.white,
      ),
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.18)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: config.hoverColor,
        selectedColor: colorScheme.primary.withValues(alpha: 0.12),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        labelStyle: GoogleFonts.dmSans(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF23402A),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFFF6F3EC),
      dropdownMenuTheme:
          DropdownMenuThemeData(inputDecorationTheme: lightInputThemeData),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: const Color(0xFF7B877B),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.dmSans(
          color: const Color(0xFF122117),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF122117)),
      ),
      dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
      inputDecorationTheme: lightInputThemeData,
    );
  }

  static ThemeData darkThemeData() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Environment().configuration.seedColor,
      brightness: Brightness.dark,
    ).copyWith(
      surface: const Color(0xFF111613),
      surfaceContainerLowest: const Color(0xFF151B17),
      surfaceContainerLow: const Color(0xFF1A211C),
      surfaceContainer: const Color(0xFF232B25),
      outlineVariant: const Color(0xFF3B463E),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.dmSansTextTheme(
        ThemeData.dark(useMaterial3: true).textTheme,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        CustomThemeExtensions(
          greyWithColor: Colors.white60,
          groceryButtonBorder: Colors.white54,
          groceryButtonShadow: Colors.white,
          tableBorderColor: Colors.white54,
        )
      ],
      elevatedButtonTheme: _elevatedButtonTheme,
      scaffoldBackgroundColor: const Color(0xFF101411),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      dropdownMenuTheme:
          DropdownMenuThemeData(inputDecorationTheme: darkInputThemeData),
      inputDecorationTheme: darkInputThemeData,
      cardTheme: CardThemeData(
        color: const Color(0xFF1A201C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        margin: EdgeInsets.zero,
        elevation: 6,
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Environment().configuration.seedColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
      ),
    );
  }

  static InputDecorationThemeData get lightInputThemeData =>
      InputDecorationThemeData(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.92),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: _border(const Color(0xFFD6DACE)),
        errorBorder: _border(Colors.red),
        focusedBorder: _border(Environment().configuration.seedColor),
        enabledBorder: _border(const Color(0xFFD6DACE)),
        focusedErrorBorder: _border(Colors.red),
      );

  static InputDecorationThemeData get darkInputThemeData =>
      InputDecorationThemeData(
        filled: true,
        fillColor: const Color(0xFF181E1A),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: _border(Colors.white),
        labelStyle: const TextStyle(color: Colors.white),
        errorBorder: _border(Colors.tealAccent),
        focusedBorder: _border(Colors.white),
        enabledBorder: _border(Colors.white),
        focusedErrorBorder: _border(Colors.tealAccent),
      );

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: color),
      );
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
