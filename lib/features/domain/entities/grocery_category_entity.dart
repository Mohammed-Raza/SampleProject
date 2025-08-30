import 'package:sample_project/features/data/models/groceries_model.dart';

class GroceryCategoryEntity {
  GroceryCategoryEntity(this.id, this.name, this.key);

  String id, name, key;

  GroceryCategoryEntity copyWith(String id, String name, String key) {
    return GroceryCategoryEntity(this.id, this.name, this.key);
  }

  GroceryCategoryModel toJson() {
    return GroceryCategoryModel(id, name, key);
  }
}
