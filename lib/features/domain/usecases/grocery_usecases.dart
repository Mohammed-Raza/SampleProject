import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/data/data_sources/local/local_jsons.dart';
import 'package:sample_project/features/data/models/groceries_model.dart';
import 'package:sample_project/features/domain/repository/groceries_repo.dart';
import '../entities/grocery_category_entity.dart';

class GroceryUserCases {
  GroceryUserCases(this._repository);

  final GroceriesRepository _repository;

  Future<List<GroceriesModel>> loadGroceryItems(GroceryType groceryType) async {
    final response = await _repository
        .fetchGroceryItems(getLocalJsonBasedOnType(groceryType));
    return response;
  }

  Future<List<GroceryCategoryEntity>> loadCategories() async {
    final response = await _repository.fetchGroceryCategories();
    return response;
  }

  Map getLocalJsonBasedOnType(GroceryType groceryType) {
    var localJson = LocalJsons();
    switch (groceryType) {
      case GroceryType.fruits:
        return localJson.fruitsJson;
      case GroceryType.veggies:
        return localJson.vegetablesJson;
      case GroceryType.milkProducts:
        return localJson.dairyProductsJson;
      case GroceryType.cookies:
        return localJson.grainsJson;
    }
  }
}
