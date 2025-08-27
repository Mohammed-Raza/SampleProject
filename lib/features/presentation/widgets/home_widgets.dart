import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/config/routes/routes.dart';
import 'package:sample_project/core/utils/enums.dart';

class GroceryCard extends StatelessWidget {
  final String name, assetPath;
  final GroceryType groceryType;
  const GroceryCard(
      {super.key,
      required this.name,
      required this.assetPath,
      required this.groceryType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('${Routes.groceriesMainPath}/${groceryType.name}',
          extra: groceryType),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                  child: Image.asset(assetPath,
                      height: 130, width: 130, fit: BoxFit.cover)),
              const Gap(10),
              Text(name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }
}

class BuildActiveItemView extends StatelessWidget {
  final String label;
  final IconData icon;
  const BuildActiveItemView(
      {super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(label,
                style: const TextStyle(fontSize: 18, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
