import 'package:flutter/material.dart';
import 'package:flutter_template/common/widgets/card-template-one.widget.dart';
import 'package:flutter_template/common/widgets/card-template-two.widget.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';

class CardItemWidget extends StatelessWidget {
  CardItemWidget({super.key, required this.cardModel});
  final CardModel cardModel;
  final GlobalKey repaintKeyOne = GlobalKey();
  final GlobalKey repaintKeyTwo = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if(cardModel.type == 'one'){
      return CardTemplateOneWidget(cardModel: cardModel, repaintKey: repaintKeyOne);
    }
    return CardTemplateTwoWidget(cardModel: cardModel, repaintKey: repaintKeyTwo,);
  }
}
