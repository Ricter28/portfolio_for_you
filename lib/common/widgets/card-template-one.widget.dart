import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/helpers/size_config.dart';
//
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/utils/dialog.util.dart';
import 'package:flutter_template/common/utils/widget_to_image.helper.dart';
import 'package:flutter_template/common/widgets/app_rounded_button.widget.dart';
import 'package:flutter_template/common/widgets/bottom_sheet.widget.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/item.model.dart';
import 'package:flutter_template/modules/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_template/router/app_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardTemplateOneWidget extends StatelessWidget {
  const CardTemplateOneWidget({
    super.key,
    required this.cardModel,
    required this.repaintKey,
  });
  final GlobalKey repaintKey;
  final CardModel cardModel;

  Future<void> takeScreenshot() async {
    final image = await Helper.takeScreenshot(
      key: repaintKey,
      fileName: "business-card",
    );
    if (image == null) {
      return;
    }
    await Helper.shareFiles(
        files: [image], fileName: cardModel.name ?? 'business-card');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCommonBottomSheet(
        context,
        maxHeight: SizeConfig.screenHeight / 2,
        child: BlocProvider.value(
          value: getIt<HomeBloc>(),
          child: Container(
            margin: const EdgeInsets.all(AppSize.kSpacing20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    child: Text(
                      cardModel.name ?? '',
                      style: AppStyles.heading6,
                    ),
                  ),
                  const SizedBox(height: AppSize.kSpacing20),
                  AppRoundedButton(
                    height: 48,
                    onPressed: () async {
                      await takeScreenshot();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.share,
                          color: AppColors.kWhite,
                        ),
                        const SizedBox(width: AppSize.kSpacing12),
                        Text(
                          'Share',
                          style: AppStyles.body2.copyWith(
                            color: AppColors.kWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.kSpacing20),
                  AppRoundedButton(
                    backgroundColor: AppColors.kWhite,
                    height: 48,
                    onPressed: () {
                      context.pushRoute(EditCardRoute(cardModel: cardModel));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit_document,
                          color: Colors.green,
                        ),
                        const SizedBox(width: AppSize.kSpacing12),
                        Text(
                          'Edit',
                          style: AppStyles.body2.copyWith(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.kSpacing20),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return AppRoundedButton(
                        backgroundColor: AppColors.kWhite,
                        height: 48,
                        onPressed: () async {
                          cardModel.isSpotlight == '0'?
                          getIt<HomeBloc>().add(AddToSpotlightEvent(cardModel: cardModel)):
                          getIt<HomeBloc>().add(RemoveFromSpotlightEvent(cardModel: cardModel));
                          context.router.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: cardModel.isSpotlight == '0'?Colors.amber:Colors.amber[900],
                            ),
                            const SizedBox(width: AppSize.kSpacing12),
                            Text(
                              cardModel.isSpotlight == '0'? 'Add to spotlight' : 'Remove from spotlight',
                              style: AppStyles.body2.copyWith(
                                color: cardModel.isSpotlight == '0'?Colors.amber:Colors.amber[900],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.kSpacing20),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return AppRoundedButton(
                        backgroundColor: AppColors.kWhite,
                        height: 48,
                        onPressed: () {
                          DialogUtil.showCustomDialog(
                            context,
                            title: 'Are you sure want to delete 01?',
                            confirmAction: () {
                              getIt<HomeBloc>().add(
                                DeleteCardEvent(cardModel: cardModel),
                              );
                              context.router.pop();
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            const SizedBox(width: AppSize.kSpacing12),
                            Text(
                              'Delete',
                              style: AppStyles.body2.copyWith(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.kSpacing20),
                ],
              ),
            ),
          ),
        ),
      ),
      child: RepaintBoundary(
        key: repaintKey,
        child: Container(
          decoration: BoxDecoration(
            color: Color(int.parse(cardModel.headerColor ?? '0xFFFAFBFE')),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: AppSize.kSpacing20,
            vertical: AppSize.kSpacing12,
          ),
          // color: AppColors.kBlack1,
          child: Column(
            children: [_buildHeaderCard(), _buildBody()],
          ),
        ),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.kSpacing16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cardModel.items?.length ?? 0,
            itemBuilder: (context, index) {
              ItemModel item = cardModel.items![index];
              return _buildItem(item);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  SizedBox _buildItem(ItemModel item) {
    return SizedBox(
      height: 58,
      child: Row(
        children: <Widget>[
          ImageViewWidget(
            item.image!,
            borderRadius: BorderRadius.circular(38),
            height: 38,
            width: 38,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: ListTile(
              title: Text(
                item.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(int.parse(cardModel.bodyTextColor!)),
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                item.des ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(int.parse(cardModel.bodyTextColor!))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.kSpacing16,
        vertical: AppSize.kSpacing8,
      ),
      child: Row(
        children: <Widget>[
          ImageViewWidget(
            cardModel.image!,
            borderRadius: BorderRadius.circular(8),
            height: 48,
            width: 48,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: ListTile(
              title: Text(
                cardModel.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(int.parse(cardModel.headerTextColor!)),
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              subtitle: Text(
                cardModel.des ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(int.parse(cardModel.headerTextColor!))),
              ),
            ),
          ),
          QrImage(
            data: cardModel.QRData ?? '',
            size: 58,
            foregroundColor: Color(int.parse(cardModel.headerTextColor!)),
            gapless: false,
          ),
        ],
      ),
    );
  }
}
