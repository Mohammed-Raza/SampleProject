part of 'groceries_bloc.dart';

@immutable
sealed class GroceriesState {}

final class GroceriesInitial extends GroceriesState {}

class CategoriesMainState extends GroceriesState {}

class CategoriesLoading extends CategoriesMainState {}

class CategoriesSuccess extends CategoriesMainState {
  final List<GroceryCategoryModel> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesError extends CategoriesMainState {
  final PageErrorDetails errorDetails;
  CategoriesError(this.errorDetails);
}

class GroceryItemsLoading extends GroceriesState {}

class GroceryItemsSuccess extends GroceriesState {
  final List<GroceriesEntity> groceries;
  GroceryItemsSuccess(this.groceries);
}

class GroceryItemsError extends GroceriesState {
  final PageErrorDetails pageErrorDetails;
  GroceryItemsError(this.pageErrorDetails);
}
