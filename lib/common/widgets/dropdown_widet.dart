import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/modules/data/model/list_item.model.dart';

class DropDownWidget extends StatefulWidget {
  final String title;
  final List<ListItem> items;
  final ValueChanged<ListItem?> itemCallBack;
  final ListItem? currentItem;
  final String hintText;
  final String? errorText;
  final Widget icon;
  const DropDownWidget({
    super.key,
    required this.title,
    required this.items,
    required this.itemCallBack,
    this.currentItem,
    required this.hintText,
    this.errorText,
    this.icon = const Icon(Icons.keyboard_arrow_down_rounded),
  });

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  ListItem? currentItem;
  List<DropdownMenuItem<ListItem>> dropDownItems = [];

  @override
  void initState() {
    for (ListItem item in widget.items) {
      dropDownItems.add(
        DropdownMenuItem(
          value: item,
          child: Text(
            item.value,
            style: AppStyles.body2.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 20 / 14,
              color: AppColors.kBlack10,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  void didUpdateWidget(DropDownWidget oldWidget) {
    if (currentItem != widget.currentItem) {
      setState(() {
        currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppStyles.body2.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            height: 16 / 12,
            color: AppColors.kBlack10,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSize.kSpacing10),
          child: DropdownButtonFormField<ListItem>(
            value: widget.currentItem,
            isExpanded: true,
            items: dropDownItems,
            onChanged: (selectedItem) => setState(() {
              currentItem = selectedItem;
              widget.itemCallBack(currentItem);
            }),
            hint: Text(
              widget.hintText,
              style: AppStyles.body2.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 20 / 14,
                color: AppColors.kBlack5,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            style: AppStyles.body2.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 20 / 14,
              color: AppColors.kBlack10,
              leadingDistribution: TextLeadingDistribution.even,
            ),
            decoration: _textFieldInputdecoration(context),
            icon: widget.icon,
          ),
        ),
        Text(
          widget.errorText ?? '',
          style: AppStyles.body2.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 16 / 12,
            color: AppColors.kRed5,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ],
    );
  }

  InputDecoration _textFieldInputdecoration(BuildContext context) {
    return InputDecoration(
      prefixIconConstraints: const BoxConstraints(),
      suffixIconConstraints: const BoxConstraints(),
      constraints: const BoxConstraints(),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSize.kHorizontalSpace),
      hintStyle: AppStyles.body1.copyWith(
        color: AppColors.kBlack5,
      ),
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildFocusedBorder(),
      errorBorder: _buildErrorBorder(),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kPrimary,
      ),
      borderRadius: BorderRadius.circular(
        AppSize.kRadius8,
      ),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kRed5,
      ),
      borderRadius: BorderRadius.circular(
        AppSize.kRadius8,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kBlack3,
      ),
      borderRadius: BorderRadius.circular(
        AppSize.kRadius8,
      ),
    );
  }
}
