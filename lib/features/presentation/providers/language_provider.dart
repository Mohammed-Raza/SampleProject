import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/mixins/language_mixin.dart';
import 'package:sample_project/core/utils/constants.dart';

import '../../../core/error/exception_handler.dart';

class LanguageProvider with ChangeNotifier, LanguageMixin {
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

  void selectLanguage(String code) {
    selectedLanguageCode = code;
    notifyListeners();
  }
}
