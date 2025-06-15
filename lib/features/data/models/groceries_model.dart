import 'package:json_annotation/json_annotation.dart';

part 'groceries_model.g.dart';

@JsonSerializable()
class GroceriesModel {
  final int id;

  final String? name, content;

  final List<String>? images;

  final double? prize;

  const GroceriesModel(this.id,
      {this.name = 'NA',
      this.content = 'NA',
      this.images = const [],
      this.prize = 0.0});

  factory GroceriesModel.fromJson(Map<String, dynamic> json) =>
      _$GroceriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceriesModelToJson(this);
}
