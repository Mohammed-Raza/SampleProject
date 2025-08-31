import 'package:sample_project/features/domain/entities/groceries_entity.dart';
import 'package:sample_project/features/domain/repository/groceries_repo.dart';
import '../../data/models/groceries_model.dart';

class GroceryUserCases {
  GroceryUserCases(this._repository);

  final GroceriesRepository _repository;

  Future<List<GroceryCategoryModel>> loadCategories() async {
    final response = await _repository.fetchGroceryCategories();
    return response;
  }

  Future<List<GroceriesEntity>> loadGroceryItems(String id) async {
    final response = await _repository.fetchGroceryItems(id);

    /// Converting DTO to Entity
    List<GroceriesEntity> groceries =
        response.map((e) => e.toGroceryEntity()).toList();

    return groceries;
  }
}
