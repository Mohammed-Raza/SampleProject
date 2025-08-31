import 'package:flutter/cupertino.dart';
import 'package:sample_project/core/utils/enums.dart';

import '../../generated/assets.dart';
import 'language_mixin.dart';

mixin CommonMixin {
  static String getNumberWithCommas(String amount) {
    if (amount.isEmpty) return '';
    return amount.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  static String getGroceryAssetPath(GroceryType type) {
    switch (type) {
      case GroceryType.fruits:
        return Assets.imagesFruits;
      case GroceryType.veggies:
        return Assets.imagesVeggies;
      case GroceryType.milkProducts:
        return Assets.imagesMilk;
      case GroceryType.cookies:
        return Assets.imagesCakes;
    }
  }

  static String getGroceryName(BuildContext context, GroceryType type) {
    switch (type) {
      case GroceryType.fruits:
        return LanguageMixin.translate(context).fruits;
      case GroceryType.veggies:
        return LanguageMixin.translate(context).vegetables;
      case GroceryType.milkProducts:
        return LanguageMixin.translate(context).milkProducts;
      case GroceryType.cookies:
        return LanguageMixin.translate(context).cookies;
    }
  }
}
