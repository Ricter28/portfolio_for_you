import 'package:flutter_template/modules/domain/entity/item.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.model.g.dart';

@JsonSerializable()
class ItemModel  implements ItemEntity {
  ItemModel({
    this.id,
    this.cardId,
    this.des,
    this.name,
    this.index,
    this.image
  });
  
  @override
  int? cardId;
  
  @override
  String? des;
  
  @override
  int? id;
  
  @override
  String? image;
  
  @override
  @JsonKey(name: 'indexItem')
  int? index;
  
  @override
  String? name;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}