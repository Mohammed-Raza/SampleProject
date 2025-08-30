import 'package:sample_project/core/utils/query_params.dart';
import 'package:sample_project/features/data/data_sources/remote/base_service.dart';
import 'package:sample_project/features/data/data_sources/remote/urls.dart';
import 'package:sample_project/features/data/models/groceries_model.dart';
import 'package:sample_project/features/domain/repository/groceries_repo.dart';
import '../../domain/entities/grocery_category_entity.dart';

class GroceriesRepoImpl implements GroceriesRepository {
  GroceriesRepoImpl(this.baseService);

  final BaseService baseService;

  @override
  Future<List<GroceryCategoryEntity>> fetchGroceryCategories() async {
    List<GroceryCategoryModel> categories = [];

    final response =
        await baseService.makeRequest(url: '${Urls.groceryCategory}.json');

    if (response is Map) {
      categories = response[QueryParams.groceryCategoryKey]
          .entries
          .map<GroceryCategoryModel>(
              (json) => GroceryCategoryModel.fromJson(json.value))
          .toList();
    }

    /// Converting DTO to entities
    List<GroceryCategoryEntity> entities =
        categories.map((category) => category.toCategoryEntity()).toList();

    return entities;
  }

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
