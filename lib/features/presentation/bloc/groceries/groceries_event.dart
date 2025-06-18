part of 'groceries_bloc.dart';

@immutable
sealed class GroceriesEvent {}

class LoadGroceriesEvent extends GroceriesEvent {
  final GroceryType groceryType;
  LoadGroceriesEvent(this.groceryType);
}

final class AddOutQtyEvent extends GroceriesEvent {
  final GroceriesModel grocery;
  AddOutQtyEvent(this.grocery);
}

final class SubtractOutQtyEvent extends GroceriesEvent {
  final GroceriesModel grocery;
  SubtractOutQtyEvent(this.grocery);
}

final class ChangeOutQtyEvent extends GroceriesEvent {
  final GroceriesModel grocery;
  final String value;
  ChangeOutQtyEvent(this.grocery, this.value);
}
