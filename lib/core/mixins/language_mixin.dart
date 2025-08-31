import 'package:flutter/cupertino.dart';
import '../../l10n/app_localizations.dart';
import '../utils/constants.dart';

mixin LanguageMixin {
  String getSelectedLanguage(String languageCode) {
    switch (languageCode) {
      case Constants.english:
        return 'English';
      case Constants.hindi:
        return 'हिंदी';
      case Constants.telugu:
        return 'తెలుగు';
      case Constants.urdu:
        return 'اردو';
      default:
        return 'English';
    }
  }

  static AppLocalizations translate(BuildContext context) =>
      AppLocalizations.of(context)!;
}
