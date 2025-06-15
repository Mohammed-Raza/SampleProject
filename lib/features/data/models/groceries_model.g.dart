// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groceries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroceriesModel _$GroceriesModelFromJson(Map<String, dynamic> json) =>
    GroceriesModel(
      (json['id'] as num).toInt(),
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
