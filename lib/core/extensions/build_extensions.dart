import 'package:flutter/material.dart';
import 'package:sample_project/config/theme/theme.dart';

extension BuildExtension on BuildContext {
  /// Theme Extensions
  Color get languageBorderColor =>
      Theme.of(this).extension<CustomThemeExtensions>()?.greyWithColor ??
      Colors.black26;
}
