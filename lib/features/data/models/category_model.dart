import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int? id;
  final int categoryId;
  final String name, categoryType, description;

  CategoryModel(
      {this.id,
      required this.categoryId,
      required this.categoryType,
      required this.name,
      this.description = ''});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
