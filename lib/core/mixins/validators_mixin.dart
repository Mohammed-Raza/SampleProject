import 'package:flutter/cupertino.dart';

mixin ValidatorsMixin {
  String? valueEmptyValidator(
      String value, BuildContext context, String label) {
    if (value.trim().isEmpty) {
      return label;
    }
    return null;
  }

  String? dropdownEmptyValidator(id, String label) {
    if (id == null) {
      return 'select $label';
    }
    return null;
  }

  String? quantityValidator(String value, BuildContext context, String label) {
    int val =
        value.trim().isNotEmpty ? int.parse(value.trim()) : int.parse('0');
    if (value.trim().isEmpty) {
      return label;
    } else if (val == 0) {
      return 'enter value';
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
      return label;
    } else if (val == 0.0) {
      return 'enter value';
    } else if (value.trim() == '.') {
      return 'dot not allowed';
    }
    return null;
  }

  String? spacesValidator(String value, String text) {
    bool isValid = RegExp(whiteSpaceValidation).hasMatch(value);
    if (value.trim().isEmpty) {
      return 'enter $text';
    }
    if (isValid) {
      return 'spaces are not allowed';
    }
    return null;
  }

  static const String whiteSpaceValidation = r"\s";
}
