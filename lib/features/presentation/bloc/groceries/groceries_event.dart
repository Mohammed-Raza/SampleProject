part of 'groceries_bloc.dart';

@immutable
sealed class GroceriesEvent {}

class LoadGroceriesEvent extends GroceriesEvent {
  final GroceryType groceryType;
  LoadGroceriesEvent(this.groceryType);
}
