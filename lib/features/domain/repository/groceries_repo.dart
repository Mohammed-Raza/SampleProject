import 'package:sample_project/features/data/models/groceries_model.dart';

abstract class GroceriesRepository {
  Future<List<GroceryCategoryModel>> fetchGroceryCategories();
  Future<List<GroceriesModel>> fetchGroceryItems(String id);
}
