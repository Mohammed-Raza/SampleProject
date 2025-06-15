import 'package:sample_project/core/utils/query_params.dart';
import 'package:sample_project/features/data/models/groceries_model.dart';
import 'package:sample_project/features/domain/repository/groceries_repo.dart';

class GroceriesRepoImpl implements GroceriesRepository {
  @override
  Future<List<GroceriesModel>> fetchGroceryItems(Map localJson) async {
    List<GroceriesModel> groceries = [];

    final response = localJson;

    if (response != null && response[QueryParams.data] != null) {
      groceries = response[QueryParams.data]
          .map<GroceriesModel>((json) => GroceriesModel.fromJson(json))
          .toList();
    }
    return groceries;
  }
}
