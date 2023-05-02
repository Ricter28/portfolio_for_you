import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/modules/data/model/tip_detail.model.dart';

@RoutePage()
class TipDetailView extends StatelessWidget {
  const TipDetailView({super.key, required this.tipDetails});
  final List<TipDetailModel> tipDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.kBlack5,
        ),
        backgroundColor: AppColors.kBgColor,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(AppSize.kSpacing20),
        child: ListView.builder(
          itemCount: tipDetails.length,
          itemBuilder: (context, index) {
            TipDetailModel tipDetail = tipDetails[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(tipDetail.image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: ImageViewWidget(
                      tipDetail.image!,
                      height: 180,
                      fit: BoxFit.cover,
                      width: SizeConfig.screenWidth,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                if(tipDetail.title != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      tipDetail.title??'',
                      style: AppStyles.heading4.copyWith(
                        fontSize: 18,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                if(tipDetail.des != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      tipDetail.des??'',
                      style: AppStyles.body1.copyWith(
                        fontSize: 16,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
