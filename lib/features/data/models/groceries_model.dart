import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'groceries_model.g.dart';

@JsonSerializable()
class GroceriesModel {
  final int id;

  final String? name, content;

  final List<String>? images;

  final double? prize;

  @JsonKey(includeFromJson: false, includeToJson: false)
  TextEditingController controller = TextEditingController();

  @JsonKey(includeFromJson: false, includeToJson: false)
  double totalAmount = 0.0;

  @JsonKey(includeFromJson: false)
  int outQty = 0;

  GroceriesModel(this.id,
      {this.name = 'NA',
      this.content = 'NA',
      this.images = const [],
      this.prize = 0.0});

  factory GroceriesModel.fromJson(Map<String, dynamic> json) =>
      _$GroceriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceriesModelToJson(this);
}
