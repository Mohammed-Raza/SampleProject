import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/features/domain/entities/drop_down_entity.dart';
import 'package:sample_project/features/domain/usecases/grocery_usecases.dart';

part 'drop_down_state.dart';

class DropDownCubit extends Cubit<DropDownState> {
  DropDownCubit(this._groceryUserCases) : super(DropDownInitial());

  final ExceptionHandler _exceptionHandler = ExceptionHandler();

  final GroceryUserCases _groceryUserCases;

  List<DropDownEntity> categories = [], groceries = [];

  String? selectedCategoryId, selectedGroceryId;

  /// On change categories dropdown
  void onChangeOfCategory(id) {
    selectedCategoryId = id;
  }

  /// On change groceries dropdown
  void onChangeOfGrocery(id) {
    selectedGroceryId = id;
  }

  /// Load grocery category dropdown
  Future<void> loadCategories() async {
    try {
      emit(CategoryLoading());

      var response = await _groceryUserCases.loadCategories();

      if (response.isNotEmpty) {
        categories.clear();
        for (var e in response) {
          categories.add(DropDownEntity(e.key, e.name, id: int.parse(e.id)));
        }
      }
      emit(CategorySuccess());
    } catch (e, s) {
      emit(CategoryError(
          _exceptionHandler.getErrorTextBasedOnType(e, stackTrace: s)));
    }
  }

  /// Load groceries dropdown
  Future<void> loadGroceries() async {
    try {
      emit(GroceriesLoading());

      var response =
          await _groceryUserCases.loadGroceryItems(selectedCategoryId ?? '##');

      if (response.isNotEmpty) {
        groceries.clear();
        for (var e in response) {
          groceries.add(DropDownEntity(e.id, e.name ?? '--'));
        }
      }
      emit(GroceriesSuccess());
    } catch (e, s) {
      emit(GroceriesError(
          _exceptionHandler.getErrorTextBasedOnType(e, stackTrace: s)));
    }
  }
}
