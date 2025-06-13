

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GroceryCard extends StatelessWidget {
  final String name, assetPath;
  const GroceryCard({super.key, required this.name, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withValues(alpha: 0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 3), // changes position of shadow
            ),
          ]),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ClipOval(
              child: Image.asset(assetPath,
                  height: 130, width: 130, fit: BoxFit.cover)),
          const Gap(10),
          Text(name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}

class BuildActiveItemView extends StatelessWidget {
  final String label;
  final IconData icon;
  const BuildActiveItemView({super.key, required this.label, required this.icon});

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
            Text(label, style: const TextStyle(fontSize: 18, color: Colors.white))
          ],
        ),
      ),
    );
  }
}