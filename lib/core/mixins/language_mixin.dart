import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:sample_project/core/utils/global_variables.dart';
import '../../l10n/app_localizations.dart';
import '../utils/constants.dart';
import '../utils/local_storage_keys.dart';

mixin LanguageMixin {
  Locale setLocale(String languageCode) {
    storage.write(key: LocalStorageKeys.languageCode, value: languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
    var languageCode = await storage.read(key: LocalStorageKeys.languageCode);
    return _locale(languageCode ?? Constants.english);
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case Constants.english:
        return const Locale(Constants.english, 'US');
      case Constants.hindi:
        return const Locale(Constants.hindi, 'IN');
      case Constants.telugu:
        return const Locale(Constants.telugu, 'IN');
      case Constants.urdu:
        return const Locale(Constants.urdu, 'PK');
      default:
        return const Locale(Constants.english, 'US');
    }
  }

  String getSelectedLanguage(String languageCode) {
    switch (languageCode) {
      case Constants.english:
        return 'English';
      case Constants.hindi:
        return 'Hindi';
      case Constants.telugu:
        return 'Telugu';
      case Constants.urdu:
        return 'Urdu';
      default:
        return 'English';
    }
  }

  AppLocalizations translate(BuildContext context) =>
      AppLocalizations.of(context)!;
}
