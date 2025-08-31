import 'package:json_annotation/json_annotation.dart';
import 'package:sample_project/features/domain/entities/groceries_entity.dart';

part 'groceries_model.g.dart';

@JsonSerializable()
class GroceryCategoryModel {
  final String id, name, key;

  GroceryCategoryModel(this.id, this.name, this.key);

  factory GroceryCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$GroceryCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryCategoryModelToJson(this);
}

@JsonSerializable()
class GroceriesModel {
  final String id;

  final String? name, content;

  final List<String>? images;

  final double? prize;

  GroceriesModel(this.id,
      {this.name = 'NA',
      this.content = 'NA',
      this.images = const [],
      this.prize = 0.0});

  factory GroceriesModel.fromJson(Map<String, dynamic> json) =>
      _$GroceriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceriesModelToJson(this);

  GroceriesEntity toGroceryEntity() {
    return GroceriesEntity(id,
        content: content, images: images, prize: prize, name: name);
  }
}
