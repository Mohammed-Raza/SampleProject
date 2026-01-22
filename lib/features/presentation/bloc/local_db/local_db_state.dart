part of 'local_db_cubit.dart';

@immutable
sealed class LocalDbState {}

final class LocalDbInitial extends LocalDbState {}

final class LocalDataLoading extends LocalDbState {}

final class LocalDataSuccess extends LocalDbState {
  final Map<String, List<CategoryModel>>? itemsMapData;
  LocalDataSuccess(this.itemsMapData);
}

final class LocalDataError extends LocalDbState {
  final PageErrorDetails errorDetails;
  LocalDataError(this.errorDetails);
}
