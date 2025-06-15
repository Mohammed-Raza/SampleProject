part of 'groceries_bloc.dart';

@immutable
sealed class GroceriesState {}

final class GroceriesInitial extends GroceriesState {}

class GroceryItemsLoading extends GroceriesState {}

class GroceryItemsSuccess extends GroceriesState {
  final List<GroceriesModel> groceries;
  GroceryItemsSuccess(this.groceries);
}

class GroceryItemsError extends GroceriesState {
  final PageErrorDetails pageErrorDetails;
  GroceryItemsError(this.pageErrorDetails);
}
