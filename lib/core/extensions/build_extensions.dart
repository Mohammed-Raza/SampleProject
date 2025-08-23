import 'package:flutter/material.dart';
import 'package:sample_project/config/theme/theme.dart';

extension BuildExtension on BuildContext {
  /// Theme Extensions
  Color get languageBorderColor =>
      Theme.of(this).extension<CustomThemeExtensions>()?.greyWithColor ??
      Colors.black26;

  Color get groceryButtonBorderColor =>
      Theme.of(this).extension<CustomThemeExtensions>()?.groceryButtonBorder ??
      const Color.fromRGBO(0, 0, 0, 0.05);

  Color get groceryButtonShadowColor =>
      Theme.of(this).extension<CustomThemeExtensions>()?.groceryButtonShadow ??
      const Color.fromRGBO(0, 0, 0, 0.16);
}
