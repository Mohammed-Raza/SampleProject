import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/features/domain/entities/groceries_entity.dart';
import 'package:sample_project/features/domain/usecases/grocery_usecases.dart';
import '../../../../core/utils/records_typedefs.dart';
import '../../../data/models/groceries_model.dart';

part 'groceries_event.dart';
part 'groceries_state.dart';

class GroceriesBloc extends Bloc<GroceriesEvent, GroceriesState> {
  GroceriesBloc(this._groceryUserCases) : super(GroceriesInitial()) {
    on<GroceriesEvent>((event, emit) {});
    on<LoadGroceryCategoryEvent>(_loadGroceryCategories);
    on<LoadGroceriesEvent>(_loadGroceries);
    on<AddOutQtyEvent>(_onClickOfAddOutQty);
    on<SubtractOutQtyEvent>(_onClickOfSubtractOutQty);
    on<ChangeOutQtyEvent>(_onChangeOfTextField);
  }

  final GroceryUserCases _groceryUserCases;

  List<GroceriesEntity> groceries = [];

  ExceptionHandler exceptionHandler = ExceptionHandler();

  /// Load grocery categories
  void _loadGroceryCategories(
      LoadGroceryCategoryEvent event, Emitter<GroceriesState> emit) async {
    try {
      emit(CategoriesLoading());

      final result = await _groceryUserCases.loadCategories();

      emit(CategoriesSuccess(result));
    } catch (e) {
      emit(CategoriesError(exceptionHandler.getPageErrorDetails(e)));
    }
  }

  /// Load groceries
  void _loadGroceries(
      LoadGroceriesEvent event, Emitter<GroceriesState> emit) async {
    try {
      emit(GroceryItemsLoading());

      final result = await _groceryUserCases.loadGroceryItems(event.groceryKey);

      groceries = result;

      emit(GroceryItemsSuccess(result));
    } catch (e) {
      emit(GroceryItemsError(exceptionHandler.getPageErrorDetails(e)));
    }
  }

  /// On perform of out qty addition
  void _onClickOfAddOutQty(AddOutQtyEvent event, Emitter<GroceriesState> emit) {
    ++event.grocery.outQty;
    _setOutQtyValue(event.grocery, emit);
  }

  /// On perform of out qty subtraction
  void _onClickOfSubtractOutQty(
      SubtractOutQtyEvent event, Emitter<GroceriesState> emit) {
    if (event.grocery.outQty <= 0) return;
    --event.grocery.outQty;
    _setOutQtyValue(event.grocery, emit);
  }

  /// On change of out qty value
  void _onChangeOfTextField(
      ChangeOutQtyEvent event, Emitter<GroceriesState> emit) {
    event.grocery.outQty =
        int.parse(event.value.trim().isEmpty ? '0' : event.value);
    _setOutQtyValue(event.grocery, emit);
  }

  /// Method is to set out qty value
  void _setOutQtyValue(GroceriesEntity grocery, Emitter<GroceriesState> emit) {
    grocery.totalAmount = grocery.prize! * grocery.outQty;
    grocery.controller.text =
        (grocery.outQty == 0) ? '' : grocery.outQty.toString();
    grocery.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: grocery.controller.text.length));
    emit(GroceryItemsSuccess(groceries));
  }
}
