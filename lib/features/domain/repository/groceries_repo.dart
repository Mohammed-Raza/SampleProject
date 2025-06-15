import 'package:sample_project/features/data/models/groceries_model.dart';

abstract class GroceriesRepository {
  Future<List<GroceriesModel>> fetchGroceryItems(Map localJson);
}
