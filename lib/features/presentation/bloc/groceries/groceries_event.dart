part of 'groceries_bloc.dart';

@immutable
sealed class GroceriesEvent {}

class LoadGroceryCategoryEvent extends GroceriesEvent {
  LoadGroceryCategoryEvent();
}

class LoadGroceriesEvent extends GroceriesEvent {
  final String groceryKey;
  LoadGroceriesEvent(this.groceryKey);
}

final class AddOutQtyEvent extends GroceriesEvent {
  final GroceriesEntity grocery;
  AddOutQtyEvent(this.grocery);
}

final class SubtractOutQtyEvent extends GroceriesEvent {
  final GroceriesEntity grocery;
  SubtractOutQtyEvent(this.grocery);
}

final class ChangeOutQtyEvent extends GroceriesEvent {
  final GroceriesEntity grocery;
  final String value;
  ChangeOutQtyEvent(this.grocery, this.value);
}
