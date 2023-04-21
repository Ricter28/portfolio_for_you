import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as Math;

import 'package:flutter_template/common/constants/app_mockup.dart';
import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/utils/color_picker.util.dart';
import 'package:flutter_template/common/utils/common_dialog.util.dart';
import 'package:flutter_template/common/utils/dialog.util.dart';
import 'package:flutter_template/common/utils/toast.util.dart';
import 'package:flutter_template/common/widgets/app_rounded_button.widget.dart';
import 'package:flutter_template/common/widgets/app_text_form_field.widget.dart';
import 'package:flutter_template/common/widgets/bottom_sheet.widget.dart';
import 'package:flutter_template/common/widgets/dropdown_widet.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/item.model.dart';
import 'package:flutter_template/modules/data/model/list_item.model.dart';
import 'package:flutter_template/modules/presentation/components/show_links_view.dart';
import 'package:flutter_template/modules/presentation/create_card/bloc/create_card_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class CreateCardView extends StatefulWidget {
  const CreateCardView({super.key});

  @override
  State<CreateCardView> createState() => _CreateCardViewState();
}

class _CreateCardViewState extends State<CreateCardView> {
  late CreateCardBloc cardBloc;
  int cardId = Math.Random().nextInt(9999999);
  bool qrSwith = true;
  //
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _qrController = TextEditingController();
  //
  final TextEditingController _nameItemController = TextEditingController();
  final TextEditingController _desItemController = TextEditingController();
  String imageCard = Assets.images.imgDefault.path;
  // create some values
  Color pickerHeaderBgColor = Colors.blueAccent;
  Color currentHeaderBgColor = Colors.blueAccent;
  Color pickerBodyBgColor = Colors.white;
  Color currentBodyBgColor = Colors.white;
  //
  String type = '1';
  //
  Color pickerHeaderTextColor = Colors.white;
  Color currentHeaderTextColor = Colors.white;
  Color pickerBodyTextColor = Colors.blueAccent;
  Color currentBodyTextColor = Colors.blueAccent;
  //
  List<ItemModel> items = [];
  String itemImage = Assets.bioLink.info.path;
  //
  @override
  void initState() {
    cardBloc = CreateCardBloc();
    cardBloc.add(const InitCreateCardEvent());
    items.add(
      ItemModel(
        cardId: cardId,
        name: 'Menlo Park, California, United States',
        des: 'Technology company',
        image: Assets.bioLink.map.path,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _desController.dispose();
    _qrController.dispose();
    //
    _nameItemController.dispose();
    _desItemController.dispose();
    cardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cardBloc,
      child: BlocListener<CreateCardBloc, CreateCardState>(
        listener: (context, state) {
          if(state is CreateCardSuccessState){
            context.router.pop(); 
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.kBgColor,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: AppColors.kBlack5,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  DialogUtil.showCustomDialog(
                    context,
                    title: 'Confirm data befor submit',
                    confirmAction: () {
                      cardBloc.add(
                        CreateCreateCardEvent(
                          CardModel(
                            id: cardId,
                            name: _nameController.text.trim(),
                            type: type,
                            isSpotlight: '0',
                            items: items,
                            image: imageCard,
                            des: _desController.text.trim(),
                            headerColor: currentHeaderBgColor.value.toString(),
                            bgColor: currentBodyBgColor.value.toString(),
                            headerTextColor:
                                currentHeaderTextColor.value.toString(),
                            bodyTextColor:
                                currentBodyTextColor.value.toString(),
                            QRData: _qrController.text.trim(),
                            createdAt: DateTime.now().toString(),
                          ),
                        ),
                      );
                      context.router.pop(context);
                    },
                  );
                },
                icon: const Icon(
                  Icons.done_all_outlined,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMainImage(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.kSpacing20,
                  ),
                  child: TextFieldWidget(
                    label: 'Your Title',
                    keyboardType: TextInputType.text,
                    hintText: 'Lucas Eden',
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    suffixIcon: _nameController.text.isNotEmpty
                        ? const Icon(Icons.clear)
                        : null,
                    onTapSuffixIcon: () {
                      _nameController.clear();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.kSpacing20,
                  ),
                  child: TextFieldWidget(
                    label: 'Description',
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    hintText:
                        'Business cards are cards bearing business information about a company or individual',
                    controller: _desController,
                    textInputAction: TextInputAction.next,
                    suffixIcon: _desController.text.isNotEmpty
                        ? const Icon(Icons.clear)
                        : null,
                    onTapSuffixIcon: () {
                      _desController.clear();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.kSpacing20,
                  ),
                  child: DropDownWidget(
                    title: 'Template',
                    items: [
                      BaseItem(1, 'Template One'),
                      BaseItem(2, 'Templase Two')
                    ],
                    itemCallBack: (value) => {
                      type = (value!.key == 1) ? 'one': 'two'
                    },
                    hintText: 'Choose your type',
                  ),
                ),
                _buidHeaderOptionColor(context),
                _buidTextOptionColor(context),
                _buildQR(),
                const Divider(),
                _buildItems()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildQR() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.kSpacing20),
      child: Column(
        children: [
          SizedBox(
            height: 58,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Use QR code',
                  style: AppStyles.body2.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 16 / 12,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                CupertinoSwitch(
                  value: qrSwith,
                  onChanged: (value) {
                    setState(() {
                      qrSwith = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: qrSwith,
            child: TextFieldWidget(
              keyboardType: TextInputType.text,
              hintText: 'Your QR data',
              controller: _qrController,
              textInputAction: TextInputAction.next,
              suffixIcon: _qrController.text.isNotEmpty
                  ? const Icon(Icons.clear)
                  : null,
              onTapSuffixIcon: () {
                _qrController.clear();
              },
              onChanged: (value) {},
            ),
          ),
          Visibility(
            visible: qrSwith,
            child: QrImage(
              data: _qrController.text.trim().isEmpty ? 'Welcome' : _qrController.text.trim(),
              size: SizeConfig.screenWidth * 0.38,
              gapless: false,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItems() {
    if (items.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(AppSize.kSpacing20),
        child: AppRoundedButton(
          onPressed: () {
            showCommonBottomSheet(context, child: _buildItemForm());
          },
          child: Text(
            'Add new item',
            style: AppStyles.body1.copyWith(color: Colors.white),
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return Container(
            margin: const EdgeInsets.all(AppSize.kSpacing20),
            child: AppRoundedButton(
              onPressed: () {
                showCommonBottomSheet(context, child: _buildItemForm());
              },
              child: Text(
                'Add new item',
                style: AppStyles.body1.copyWith(color: Colors.white),
              ),
            ),
          );
        } else {
          return _buildItem(items[index], index);
        }
      },
    );
  }

  Container _buildItem(ItemModel item, int index) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: AppSize.kSpacing20),
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
              ),
              subtitle: Text(
                item.des ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  Widget _buildItemForm() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setStateModel) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSize.kSpacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                child: Text(
                  'New Item',
                  style: AppStyles.heading4,
                ),
              ),
              const SizedBox(height: AppSize.kSpacing20),
              _buildItemImage(setStateModel),
              TextFieldWidget(
                label: 'Item name',
                keyboardType: TextInputType.text,
                hintText: 'Your item name',
                controller: _nameItemController,
                textInputAction: TextInputAction.next,
                suffixIcon: _nameItemController.text.isNotEmpty
                    ? const Icon(Icons.clear)
                    : null,
                onTapSuffixIcon: () {
                  _nameItemController.clear();
                },
              ),
              TextFieldWidget(
                label: 'Item description',
                keyboardType: TextInputType.text,
                hintText: 'Your item description',
                controller: _desItemController,
                textInputAction: TextInputAction.next,
                suffixIcon: _desItemController.text.isNotEmpty
                    ? const Icon(Icons.clear)
                    : null,
                onTapSuffixIcon: () {
                  _desItemController.clear();
                },
              ),
              const SizedBox(height: AppSize.kSpacing20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.kSpacing20,
                ),
                child: AppRoundedButton(
                  onPressed: () {
                    if (_nameItemController.text.isEmpty) {
                      ToastUtil.showError(context,
                          text: 'Please enter item name!');
                    } else {
                      setState(() {
                        items.add(
                          ItemModel(
                            cardId: cardId,
                            index: items.length,
                            name: _nameItemController.text.trim(),
                            des: _desItemController.text.trim(),
                            image: itemImage,
                          ),
                        );
                        _nameItemController.clear();
                        _desItemController.clear();
                        itemImage = const $AssetsBioLinkGen().info.path;
                      });
                      context.router.pop(context);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: AppStyles.body1.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemImage(StateSetter setStateModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon',
          style: AppStyles.body2.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            height: 16 / 12,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        Align(
          child: GestureDetector(
            onTap: () {
              showCommonBottomSheet(
                context,
                child: ShowLinksView(
                  chooseIcon: (value) {
                    setStateModel(() {
                      itemImage = value;
                    });
                  },
                ),
              );
            },
            child: ImageViewWidget(
              itemImage,
              width: 58,
              height: 58,
              borderRadius: BorderRadius.circular(58),
            ),
          ),
        ),
      ],
    );
  }

  Row _buidHeaderOptionColor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: ListTile(
            title: Text(
              'Header background color',
              style: AppStyles.body2.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 16 / 12,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                ColorPickerUtil.onColorPicker(
                  context,
                  pickerColor: pickerHeaderBgColor,
                  currentColor: currentHeaderBgColor,
                  changeColor: (value) {
                    setState(() {
                      currentHeaderBgColor = value;
                    });
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                width: SizeConfig.screenWidth * 0.45,
                height: 38,
                decoration: BoxDecoration(
                  color: currentHeaderBgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColors.kPrimary, width: 0.8),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Body background color',
              style: AppStyles.body2.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 16 / 12,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                ColorPickerUtil.onColorPicker(
                  context,
                  pickerColor: pickerBodyBgColor,
                  currentColor: currentBodyBgColor,
                  changeColor: (value) {
                    setState(() {
                      currentBodyBgColor = value;
                    });
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                width: SizeConfig.screenWidth * 0.45,
                height: 38,
                decoration: BoxDecoration(
                  color: currentBodyBgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColors.kPrimary, width: 0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buidTextOptionColor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: ListTile(
            title: Text(
              'Header text color',
              style: AppStyles.body2.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 16 / 12,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                ColorPickerUtil.onColorPicker(
                  context,
                  pickerColor: pickerHeaderTextColor,
                  currentColor: currentHeaderTextColor,
                  changeColor: (value) {
                    setState(() {
                      currentHeaderTextColor = value;
                    });
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                width: SizeConfig.screenWidth * 0.45,
                height: 38,
                decoration: BoxDecoration(
                  color: currentHeaderTextColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColors.kPrimary, width: 0.8),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Body text color',
              style: AppStyles.body2.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 16 / 12,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                ColorPickerUtil.onColorPicker(
                  context,
                  pickerColor: pickerBodyTextColor,
                  currentColor: currentBodyTextColor,
                  changeColor: (value) {
                    setState(() {
                      currentBodyTextColor = value;
                    });
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                width: SizeConfig.screenWidth * 0.45,
                height: 38,
                decoration: BoxDecoration(
                  color: currentBodyTextColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColors.kPrimary, width: 0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainImage() {
    return BlocBuilder<CreateCardBloc, CreateCardState>(
      bloc: cardBloc,
      builder: (context, state) {
        if (state is LoadedCreateCardState) {
          if (state.cardModel.image != null) {
            imageCard = state.cardModel.image ?? Assets.images.imgDefault.path;
          }
        }
        return Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              cardBloc.add(ChooseImageEvent(context));
            },
            child: ImageViewWidget(
              imageCard,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
