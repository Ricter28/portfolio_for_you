import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/modules/data/model/catalog.model.dart';

@RoutePage()
class CatalogView extends StatelessWidget {
  CatalogView({super.key});
  final List<Image> images = [
    Assets.images.catalogOne
        .image(height: 175, width: SizeConfig.screenWidth, fit: BoxFit.cover),
    Assets.images.catalogTwo
        .image(height: 175, width: SizeConfig.screenWidth, fit: BoxFit.cover),
    Assets.images.catalogThree
        .image(height: 175, width: SizeConfig.screenWidth, fit: BoxFit.cover),
  ];

  final List<CatalogModel> catalogs = [
    CatalogModel(
        title: 'Standard visit card',
        subTitle:
            'A standard visit card is the most common type of visit card. It typically includes your name, title, company name, phone number, and email address.'),
    CatalogModel(
        title: 'Creative visit card',
        subTitle:
            'A creative visit card is designed to be more eye-catching and memorable than a standard visit card. It may include unique shapes, colors, or materials.'),
    CatalogModel(
        title: 'Double-sided visit card',
        subTitle:
            'A double-sided visit card includes information on both sides of the card. This is useful if you have a lot of information to include.'),
    CatalogModel(
        title: 'Folded visit card',
        subTitle:
            "A folded visit card includes a fold in the middle, allowing for more information to be included. It's a good option if you need to include more information than can fit on a standard visit card."),
    CatalogModel(
        title: 'Magnetic visit card',
        subTitle:
            'A magnetic visit card has a magnetic strip on the back, allowing it to be easily attached to metal surfaces.'),
    CatalogModel(
        title: 'Business card with a purpose',
        subTitle:
            'Some visit cards are designed with a specific purpose in mind, such as a loyalty card or appointment reminder card.'),
    CatalogModel(
        title: 'Personal visit card',
        subTitle:
            "A personal visit card includes personal contact information, such as your phone number and email address. It's useful for networking or social situations."),
    CatalogModel(
        title: 'Professional visit card',
        subTitle:
            'A professional visit card is designed for use in a professional setting, such as at a business meeting or conference.'),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == 0) {
            return _buildSlider();
          }
          if(index == 1){
            return Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text('Catalogs', style: AppStyles.heading4.copyWith(fontSize: 18),),
          );
          }
          return _buildListTitle(index);
        },
        childCount: 10,
      ),
    );
  }

  Container _buildListTitle(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.kBlack1, borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        title: Text(
          catalogs[index - 2].title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          catalogs[index - 2].subTitle,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      height: 245,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text('Tips', style: AppStyles.heading4.copyWith(fontSize: 18),),
          ),
          Container(
            margin: const EdgeInsets.only(top: 18),
            height: 180,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
              ),
              items: [0, 1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: images[i],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
