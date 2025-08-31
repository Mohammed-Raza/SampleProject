import 'package:sample_project/features/data/data_sources/remote/base_service.dart';
import 'package:sample_project/features/data/data_sources/remote/urls.dart';
import 'package:sample_project/features/data/models/groceries_model.dart';
import 'package:sample_project/features/domain/repository/groceries_repo.dart';

class GroceriesRepoImpl implements GroceriesRepository {
  GroceriesRepoImpl(this.baseService);

  final BaseService baseService;

  @override
  Future<List<GroceryCategoryModel>> fetchGroceryCategories() async {
    List<GroceryCategoryModel> categories = [];

    final response =
        await baseService.makeRequest(url: '${Urls.groceryCategory}.json');

    if (response is Map) {
      categories = (response.values.first as Map)
          .entries
          .map<GroceryCategoryModel>(
              (json) => GroceryCategoryModel.fromJson(json.value))
          .toList();
    }

    return categories;
  }

  @override
  Future<List<GroceriesModel>> fetchGroceryItems(String id) async {
    List<GroceriesModel> groceries = [];

    final response =
        await baseService.makeRequest(url: '${Urls.getGroceries}/$id.json');

    if (response is Map) {
      groceries = (response.values.first as Map)
          .entries
          .map<GroceriesModel>((json) => GroceriesModel.fromJson(json.value))
          .toList();
    }
    return groceries;
  }
}
