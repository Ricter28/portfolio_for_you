// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      createdAt: json['createdAt'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      isSpotlight: json['isSpotlight'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      des: json['des'] as String?,
      headerColor: json['headerColor'] as String?,
      bgColor: json['bgColor'] as String?,
      headerTextColor: json['headerTextColor'] as String?,
      bodyTextColor: json['bodyTextColor'] as String?,
      QRData: json['QRData'] as String?,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) {
  final val = <String, dynamic>{
    'createdAt': instance.createdAt,
    'id': instance.id,
    'isSpotlight': instance.isSpotlight,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('items', CardModel.toNull(instance.items));
  val['name'] = instance.name;
  val['type'] = instance.type;
  val['des'] = instance.des;
  val['image'] = instance.image;
  val['bgColor'] = instance.bgColor;
  val['headerColor'] = instance.headerColor;
  val['bodyTextColor'] = instance.bodyTextColor;
  val['headerTextColor'] = instance.headerTextColor;
  val['QRData'] = instance.QRData;
  return val;
}
