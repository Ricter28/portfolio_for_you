import 'package:flutter_template/modules/data/model/item.model.dart';

abstract class CardEntity {
  int? id;
  String? name;
  String? image;
  String? des;
  String? type;
  String? createdAt;
  String? isSpotlight;
  String? headerColor;
  String? bgColor;
  String? headerTextColor;
  String? bodyTextColor;
  String? QRData;
  List<ItemModel>? items;
}