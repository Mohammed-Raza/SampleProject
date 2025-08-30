import 'package:sample_project/features/data/models/groceries_model.dart';
import '../entities/grocery_category_entity.dart';

abstract class GroceriesRepository {
  Future<List<GroceryCategoryEntity>> fetchGroceryCategories();
  Future<List<GroceriesModel>> fetchGroceryItems(Map localJson);
}
