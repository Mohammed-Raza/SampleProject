import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import '../../../../core/database/db_helper.dart';
import '../../../../core/utils/records_typedefs.dart';
import '../../../data/models/category_model.dart';

part 'local_db_state.dart';

class LocalDbCubit extends Cubit<LocalDbState> {
  LocalDbCubit() : super(LocalDbInitial());

  final ExceptionHandler _exceptionHandler = ExceptionHandler();

  /// Load locally stored DB data
  void fetchLocallyStoredDbData() async {
    try {
      Map<String, List<CategoryModel>>? itemsMapData;
      final dbHelper = DBHelper();

      emit(LocalDataLoading());

      // Fetch from SqfLite
      final List<CategoryModel> result = await dbHelper.getAllGroceries();

      if (result.isNotEmpty) {
        itemsMapData = null;
        for (var e in result) {
          itemsMapData ??= {};
          if (itemsMapData.keys.toList().contains(e.categoryType)) {
            itemsMapData[e.categoryType]?.add(e);
          } else {
            itemsMapData[e.categoryType] = <CategoryModel>[];
            itemsMapData[e.categoryType]?.add(e);
          }
        }
      }

      emit(LocalDataSuccess(itemsMapData));
    } catch (e) {
      emit(LocalDataError(_exceptionHandler.getPageErrorDetails(e)));
    }
  }
}
