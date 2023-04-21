// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:intl/intl.dart';

typedef ChooseBioIcon = Function(String asset);

class ShowLinksView extends StatelessWidget {
  final ChooseBioIcon chooseIcon;
  List<AssetGenImage> icons = const $AssetsBioLinkGen().values;
  ShowLinksView({super.key, required this.chooseIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSize.kSpacing20),
      child: ListView.builder(
          itemCount: icons.length,
          itemBuilder: (context, index) {
            AssetGenImage icon = icons[index];
            return Container(
              margin: const EdgeInsets.only(bottom: AppSize.kSpacing12),
              child: GestureDetector(
                onTap: () {
                  chooseIcon(icon.path);
                  context.router.pop(context);
                },
                child: Row(
                  children: [
                    ImageViewWidget(
                      icon.path,
                      width:42,
                      height:42,
                      borderRadius: BorderRadius.circular(42),
                    ),
                    const SizedBox(width: AppSize.kSpacing18),
                    Text(
                      toBeginningOfSentenceCase(icon.keyName.split('/').last.replaceAll('ic_', ' ').replaceAll('_', ' ').split('.').first)??'',
                      style: AppStyles.body1,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
