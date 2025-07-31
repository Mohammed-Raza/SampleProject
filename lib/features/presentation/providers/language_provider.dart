import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/utils/constants.dart';
import '../../../core/error/exception_handler.dart';
import '../../../core/utils/global_variables.dart';
import '../../../core/utils/local_storage_keys.dart';

class LanguageProvider with ChangeNotifier {
  Locale locale = const Locale(Constants.english);

  String selectedLanguageCode = Constants.english;

  void onApplyOfLanguage(BuildContext context) {
    try {
      if (Constants.languages.contains(selectedLanguageCode)) {
        locale = setLocale(selectedLanguageCode);
        context.pop();
      }
    } catch (e, s) {
      ExceptionHandler().handleExceptionWithToastNotifier(e, stackTrace: s);
    }
    notifyListeners();
  }

  /// Method is to set selected Locale
  Locale setLocale(String languageCode) {
    storage.write(key: LocalStorageKeys.languageCode, value: languageCode);
    return _locale(languageCode);
  }

  /// Method is to get selected Locale
  void getLocale() async {
    var languageCode = await storage.read(key: LocalStorageKeys.languageCode);
    locale = _locale(languageCode ?? Constants.english);
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

  void selectLanguage(String code) {
    selectedLanguageCode = code;
    notifyListeners();
  }
}
