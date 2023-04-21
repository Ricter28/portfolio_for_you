import 'dart:math' as Math;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/utils/color_picker.util.dart';
import 'package:flutter_template/common/utils/toast.util.dart';
import 'package:flutter_template/common/widgets/app_rounded_button.widget.dart';
import 'package:flutter_template/common/widgets/app_text_form_field.widget.dart';
import 'package:flutter_template/common/widgets/bottom_sheet.widget.dart';
import 'package:flutter_template/common/widgets/dropdown_widet.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/item.model.dart';
import 'package:flutter_template/modules/data/model/list_item.model.dart';
import 'package:flutter_template/modules/presentation/components/show_links_view.dart';
import 'package:flutter_template/modules/presentation/edit_card/bloc/edit_card_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class EditCardView extends StatefulWidget {
  const EditCardView({super.key, required this.cardModel});
  final CardModel cardModel;

  @override
  State<EditCardView> createState() => _EditCardViewState();
}

class _EditCardViewState extends State<EditCardView> {
  late EditCardBloc editCardBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _qrController = TextEditingController();
  //
  BaseItem templateSelected = BaseItem(1, 'Template One');
  bool qrSwith = true;
  String type = '1';
  //
  final TextEditingController _nameItemController = TextEditingController();
  final TextEditingController _desItemController = TextEditingController();
  // create some values
  Color pickerHeaderBgColor = Colors.blueAccent;
  Color currentHeaderBgColor = Colors.blueAccent;
  Color pickerBodyBgColor = Colors.white;
  Color currentBodyBgColor = Colors.white;
  String imageCard = Assets.images.imgDefault.path;
  //
  Color pickerHeaderTextColor = Colors.white;
  Color currentHeaderTextColor = Colors.white;
  Color pickerBodyTextColor = Colors.blueAccent;
  Color currentBodyTextColor = Colors.blueAccent;
  //
  List<ItemModel> items = [];
  String itemImage = Assets.bioLink.info.path;
  //
  int cardId = Math.Random().nextInt(9999999);

  @override
  void initState() {
    editCardBloc = EditCardBloc();
    _nameController.text = widget.cardModel.name ?? '';
    _desController.text = widget.cardModel.des ?? '';
    imageCard = widget.cardModel.image ?? Assets.images.imgDefault.path;
    qrSwith = widget.cardModel.QRData!.isEmpty;
    _qrController.text = widget.cardModel.QRData ?? '';
    currentHeaderBgColor =
        Color(int.parse(widget.cardModel.headerColor ?? '0xFFFAFBFE'));
    currentHeaderTextColor =
        Color(int.parse(widget.cardModel.headerTextColor ?? '0xFFFAFBFE'));
    currentBodyBgColor =
        Color(int.parse(widget.cardModel.bgColor ?? '0xFFFAFBFE'));
    currentBodyTextColor =
        Color(int.parse(widget.cardModel.bodyTextColor ?? '0xFFFAFBFE'));
    //
    widget.cardModel.items!.forEach((element) {
      ItemModel tmp = element;
      tmp.cardId = cardId;
      items.add(tmp);
    });

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
    //
    editCardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => editCardBloc,
      child: BlocListener<EditCardBloc, EditCardState>(
        listener: (context, state) {
          if(state is UpdatedEditCardState){
            context.router.pop(context);
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
              BlocBuilder<EditCardBloc, EditCardState>(
                bloc: editCardBloc,
                builder: (context, state) {
                  if (state is LoadingEditCardState) {
                    return const CupertinoActivityIndicator(
                      color: AppColors.kPrimary,
                    );
                  }
                  return IconButton(
                    onPressed: () {
                      editCardBloc.add(
                        UpdateEditCardEvent(
                          widget.cardModel,
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
                    },
                    icon: const Icon(
                      Icons.save_as,
                      color: Colors.green,
                    ),
                  );
                },
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
                    currentItem: templateSelected,
                    itemCallBack: (value) {
                      type = (value!.key == 1) ? 'one': 'two';
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
                        itemImage = Assets.bioLink.info.path;
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
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {},
        child: ImageViewWidget(
          imageCard,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(8),
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
              data: _qrController.text.trim().isEmpty
                  ? 'Welcome'
                  : _qrController.text.trim(),
              size: SizeConfig.screenWidth * 0.38,
              gapless: false,
            ),
          )
        ],
      ),
    );
  }
}
