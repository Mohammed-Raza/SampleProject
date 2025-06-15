import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/data/models/groceries_model.dart';
import 'package:sample_project/features/domain/usecases/grocery_usecases.dart';

import '../../../../core/utils/records_typedefs.dart';

part 'groceries_event.dart';
part 'groceries_state.dart';

class GroceriesBloc extends Bloc<GroceriesEvent, GroceriesState> {
  GroceriesBloc(this._groceryUserCases) : super(GroceriesInitial()) {
    on<GroceriesEvent>((event, emit) {});
    on<LoadGroceriesEvent>(_loadGroceries);
  }

  final GroceryUserCases _groceryUserCases;

  ExceptionHandler exceptionHandler = ExceptionHandler();

  void _loadGroceries(
      LoadGroceriesEvent event, Emitter<GroceriesState> emit) async {
    try {
      emit(GroceryItemsLoading());

      await Future.delayed(const Duration(seconds: 2));

      final result =
          await _groceryUserCases.loadGroceryItems(event.groceryType);

      emit(GroceryItemsSuccess(result));
    } catch (e) {
      emit(GroceryItemsError(exceptionHandler.getPageErrorDetails(e)));
    }
  }
}
