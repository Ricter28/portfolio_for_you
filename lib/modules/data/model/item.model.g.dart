// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as int?,
      cardId: json['cardId'] as int?,
      des: json['des'] as String?,
      name: json['name'] as String?,
      index: json['indexItem'] as int?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'des': instance.des,
      'id': instance.id,
      'image': instance.image,
      'indexItem': instance.index,
      'name': instance.name,
    };
