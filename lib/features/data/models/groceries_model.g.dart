// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groceries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroceryCategoryModel _$GroceryCategoryModelFromJson(
        Map<String, dynamic> json) =>
    GroceryCategoryModel(
      json['id'] as String,
      json['name'] as String,
      json['key'] as String,
    );

Map<String, dynamic> _$GroceryCategoryModelToJson(
        GroceryCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'key': instance.key,
    };

GroceriesModel _$GroceriesModelFromJson(Map<String, dynamic> json) =>
    GroceriesModel(
      json['id'] as String,
      name: json['name'] as String? ?? 'NA',
      content: json['content'] as String? ?? 'NA',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      prize: (json['prize'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$GroceriesModelToJson(GroceriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'images': instance.images,
      'prize': instance.prize,
    };
