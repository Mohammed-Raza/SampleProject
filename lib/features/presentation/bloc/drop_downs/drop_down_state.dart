part of 'drop_down_cubit.dart';

@immutable
sealed class DropDownState {}

final class DropDownInitial extends DropDownState {}

abstract class GroceryCategoryState extends DropDownState {}

abstract class GroceriesState extends DropDownState {}

/// States for handling grocery categories dropdown
class CategoryLoading extends GroceryCategoryState {}

class CategorySuccess extends GroceryCategoryState {}

class CategoryError extends GroceryCategoryState {
  final String errorText;
  CategoryError(this.errorText);
}

/// States for handling groceries dropdown
class GroceriesLoading extends GroceriesState {}

class GroceriesSuccess extends GroceriesState {}

class GroceriesError extends GroceriesState {
  final String errorText;
  GroceriesError(this.errorText);
}
