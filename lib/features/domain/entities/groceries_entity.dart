import 'package:flutter/cupertino.dart';

import '../../data/models/groceries_model.dart';

class GroceriesEntity {
  GroceriesEntity(this.id,
      {this.name = 'NA',
      this.content = 'NA',
      this.images = const [],
      this.prize = 0.0});

  final String id;

  final String? name, content;

  final List<String>? images;

  final double? prize;

  TextEditingController controller = TextEditingController();

  double totalAmount = 0.0;

  int outQty = 0;

  GroceriesEntity copyWith(String id, String? name, String? content,
      List<String>? images, double? prize) {
    return GroceriesEntity(id,
        name: name, prize: prize, images: images, content: content);
  }

  GroceriesModel toJson() {
    return GroceriesModel(id,
        content: content, images: images, name: name, prize: prize);
  }
}
