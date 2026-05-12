import 'package:flutter/material.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/l10n/app_localizations.dart';

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

  String getSelectedTheme(AppLocalizations l10n) {
    switch (selectedThemeMode) {
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
      case ThemeMode.system:
        return l10n.automatic;
    }
  }
}
