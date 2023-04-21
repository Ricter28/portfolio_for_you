import 'package:flutter_template/modules/data/model/item.model.dart';
import 'package:flutter_template/modules/domain/entity/card.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.model.g.dart';

@JsonSerializable()
class CardModel implements CardEntity {
  CardModel({
    this.createdAt,
    this.id,
    this.name,
    this.type,
    this.isSpotlight,
    this.items,
    this.image,
    this.des,
    this.headerColor,
    this.bgColor,
    this.headerTextColor,
    this.bodyTextColor,
    this.QRData,
  });
  @override
  String? createdAt;

  @override
  int? id;

  @override
  String? isSpotlight;

  static toNull(_) => null; 
  @JsonKey(toJson: toNull, includeIfNull: false)
  @override
  List<ItemModel>? items;

  @override
  String? name;

  @override
  String? type;

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
  
  @override
  String? des;
  
  @override
  String? image;
  
  @override
  String? bgColor;
  
  @override
  String? headerColor;
  
  @override
  String? bodyTextColor;
  
  @override
  String? headerTextColor;
  
  @override
  String? QRData;
  
}