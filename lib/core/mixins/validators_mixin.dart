import 'package:flutter/cupertino.dart';
import 'package:sample_project/core/extensions/context_extension.dart';

mixin ValidatorsMixin {
  String? valueEmptyValidator(
      String value, BuildContext context, String label) {
    if (value.trim().isEmpty) {
      return context.l10n.enterField(label);
    }
    return null;
  }

  String? dropdownEmptyValidator(BuildContext context, id, String label) {
    if (id == null) {
      return context.l10n.selectField(label);
    }
    return null;
  }

  String? quantityValidator(String value, BuildContext context, String label) {
    int val =
        value.trim().isNotEmpty ? int.parse(value.trim()) : int.parse('0');
    if (value.trim().isEmpty) {
      return context.l10n.enterField(label);
    } else if (val == 0) {
      return context.l10n.enterValue;
    }
    return null;
  }

  String? amountValidator(String value, BuildContext context, String label) {
    double val = 0.0;
    if (value.trim() != '.') {
      val = value.trim().isNotEmpty
          ? double.parse(value.trim())
          : double.parse('0.0');
    }
    if (value.trim().isEmpty) {
      return context.l10n.enterField(label);
    } else if (val == 0.0) {
      return context.l10n.enterValue;
    } else if (value.trim() == '.') {
      return context.l10n.dotNotAllowed;
    }
    return null;
  }

  String? spacesValidator(BuildContext context, String value, String text) {
    bool isValid = RegExp(whiteSpaceValidation).hasMatch(value);
    if (value.trim().isEmpty) {
      return context.l10n.enterField(text);
    }
    if (isValid) {
      return context.l10n.spacesAreNotAllowed;
    }
    return null;
  }

  static const String whiteSpaceValidation = r"\s";
}
