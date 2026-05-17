import 'package:flutter/material.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
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

  static void showFullDescription(
      BuildContext context, String title, String description) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(context.l10n.fullDescription,
                      style: const TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(description,
                      style: const TextStyle(fontSize: 16, height: 1.5)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
