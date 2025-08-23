import 'package:flutter/material.dart';

class AppConfiguration {
  final String logoPath, orgName;

  final Color seedColor, hoverColor, shadowColor, appBarColor;

  AppConfiguration(
      {required this.logoPath,
      required this.orgName,
      required this.seedColor,
      required this.hoverColor,
      required this.shadowColor,
      required this.appBarColor});
}
