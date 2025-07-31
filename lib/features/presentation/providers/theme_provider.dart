import 'package:flutter/material.dart';
import 'package:sample_project/core/utils/enums.dart';

class ThemeProvider with ChangeNotifier {
  ThemeType themeType = ThemeType.light;

  ThemeMode selectedThemeMode = ThemeMode.light;

  /// On change of theme radio button
  void onChangeOfRadioButton(ThemeType? type) {
    themeType = type ?? ThemeType.light;
    notifyListeners();
  }

  void onSelectionOfAppearance() {
    switch (themeType) {
      case ThemeType.light:
        selectedThemeMode = ThemeMode.light;
        break;
      case ThemeType.dark:
        selectedThemeMode = ThemeMode.dark;
        break;
      case ThemeType.system:
        selectedThemeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }

  void setThemeTypeBasedOnSelectedThemeMode() {
    switch (selectedThemeMode) {
      case ThemeMode.light:
        themeType = ThemeType.light;
      case ThemeMode.dark:
        themeType = ThemeType.dark;
      case ThemeMode.system:
        themeType = ThemeType.system;
    }
  }

  String getSelectedTheme() {
    switch (selectedThemeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'Automatic';
    }
  }
}
